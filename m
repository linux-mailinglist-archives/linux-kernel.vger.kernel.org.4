Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2257E703DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbjEOT1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245209AbjEOT0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:26:54 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D491111B6C;
        Mon, 15 May 2023 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=lXoK52Fe6kW0CWMrJKqKJEGH9DkEiqD01FgLyUl7s7g=; b=dtqWCor9ITYNxXRSr7OHKTFRJc
        o3DgfYVjDYAhIvGriT7EefUAx2OTizr8BlYhDHBnw2PUlwSYXbk2fmq4bz8uaVDXx3fsFjy6PmT7q
        C3vOa2JH6TuYCNO1AcWdjh+UFE7+uU414FgoaLFZJmV9vRZn8Nf159f1BnsGYrTcR+ht/ZyL4A/zx
        EKlBHim0Ph41InK492svugSiULU+3EgU+kDNfykOV+9uLZ3k2Ko9R06+3laYTxTszouUmSKYxkrYl
        kdZdAIXLpUrwJO39+EuCIy8Y/ACFaq+b0pIwC9N50I9LFRy1gv/OXvPQIfyB1kTTxCaAKszdXZMeL
        /2AM38Kg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pydqE-000E0c-TB; Mon, 15 May 2023 21:26:42 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pydqE-0007iu-8s; Mon, 15 May 2023 21:26:42 +0200
Subject: Re: [PATCH bpf-next] bpf: btf: restore resolve_mode when popping the
 resolve stack
To:     Lorenz Bauer <lmb@isovalent.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230515121521.30569-1-lmb@isovalent.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6b585a75-ae1a-1ad5-2756-bcce78fbd2fd@iogearbox.net>
Date:   Mon, 15 May 2023 21:26:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230515121521.30569-1-lmb@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26907/Mon May 15 09:25:12 2023)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 2:15 PM, Lorenz Bauer wrote:
> In commit 9b459804ff99 ("btf: fix resolving BTF_KIND_VAR after ARRAY, STRUCT, UNION, PTR")
> I fixed a bug that occurred during resolving of a DATASEC by strategically resetting
> resolve_mode. This fixes the immediate bug but leaves us open to future bugs where
> nested types have to be resolved.

Lgtm, is there a way we could also craft a test case for this corner case?

Thanks,
Daniel
