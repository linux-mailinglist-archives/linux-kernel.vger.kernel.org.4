Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE801707781
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjERBmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjERBmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:42:17 -0400
Received: from out-29.mta1.migadu.com (out-29.mta1.migadu.com [95.215.58.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D4F123
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:42:15 -0700 (PDT)
Message-ID: <a453c3d4-5615-f445-17a8-92a1dc4282e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684374130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3gOJF+MXOBVq1iRu2W9W0FS9rlAZbKgdHYpF5mdLYw=;
        b=RwU0TiOxw2327F+kMmXihTAd02Cf701OOjP6FIfyfSwLCMe+5ycqEHxO7MkapmNHhUgOod
        AcQ0y+gwx7ckF42fBknrcDX8s3rp+wiyro0mZdGDtyrqe2EtxncGed5ryW6E2oxtBs5VDX
        j2+9myDtAVqH1UktlLEJFbwifSlgY7E=
Date:   Wed, 17 May 2023 18:42:06 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: btf: restore resolve_mode when popping the
 resolve stack
Content-Language: en-US
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20230515121521.30569-1-lmb@isovalent.com>
 <a29c604e-5a68-eed2-b581-0ad4687fda10@linux.dev>
 <CAN+4W8hixyHYOwYRh-3WedS-a0KTQk8VQ4JxqM8y-DQY-yjsNA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAN+4W8hixyHYOwYRh-3WedS-a0KTQk8VQ4JxqM8y-DQY-yjsNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 2:01 AM, Lorenz Bauer wrote:
> On Wed, May 17, 2023 at 7:26 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 5/15/23 5:15 AM, Lorenz Bauer wrote:
>>> In commit 9b459804ff99 ("btf: fix resolving BTF_KIND_VAR after ARRAY, STRUCT, UNION, PTR")
>>> I fixed a bug that occurred during resolving of a DATASEC by strategically resetting
>>> resolve_mode. This fixes the immediate bug but leaves us open to future bugs where
>>> nested types have to be resolved.
>>
>> hmm... future bugs like when adding new BTF_KIND in the future?
> 
> It could just be refactoring of the codebase? What is the downside of
> restoring the mode when popping the item? It also makes push and pop
> symmetrical.

I can see your point to refactor it to make it work for all different BTF_KIND.

Other than BTF_KIND_DATASEC, env->resolve_mode stays the same for all other 
kinds once it is decided. It is why resolve_mode is in the "env" instead of "v". 
My concern is this will hide some bugs (existing or future) that accidentally 
changed the resolve_mode in the middle. If there is another legit case that 
could be found other than BTF_KIND_DATASEC, that will be a better time to do 
this refactoring with a proper test case considering most bpf progs need btf to 
load nowadays and probably need to veristat test also. If it came to that, might 
as well consider moving resolve_mode from "env" to "v".

btf_datasec_resolve() is acting as a very top level resolver like btf_resolve(), 
so it reset env->resolve_mode before resolving its var member like how 
btf_resolve() does. imo, together with env->resolve_mode stays the same for 
others, it is more straight forward to reason. I understand that it is personal 
preference and could argue either way.
