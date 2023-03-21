Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91B46C2878
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 04:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCUDE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 23:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUDE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 23:04:26 -0400
Received: from out-4.mta0.migadu.com (out-4.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68846193EC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 20:04:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679367859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2CzmygZ3+9dcEEzX9d9IRsXgfDbVX0/dCnDP3lROHyI=;
        b=XRudqie4wY/koaYw9RjFAc1kxFGp3McOvtX0jtPKxU9wE3Z56T8ivT/dyQlovSiQok2a/t
        ffkEdEdqj2iGLxgIdoh9GoaDkOGbnJyVVfB0OctS8xcS+ae5KP8QY5GSwgODj8y4RumCSl
        lY9os2eKS3biWyHMuZKSfPRtUcFrL1Q=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: kfence: fix PG_slab and memcg_data clearing
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230320142954.fd314c5e46c1d18887ccf8cc@linux-foundation.org>
Date:   Tue, 21 Mar 2023 11:03:41 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>, glider@google.com,
        elver@google.com, dvyukov@google.com, sjpark@amazon.de,
        jannh@google.com, Roman Gushchin <roman.gushchin@linux.dev>,
        kasan-dev@googlegroups.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <962CB717-DF8B-490A-86A0-2ACE90209012@linux.dev>
References: <20230320030059.20189-1-songmuchun@bytedance.com>
 <20230320142954.fd314c5e46c1d18887ccf8cc@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 21, 2023, at 05:29, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Mon, 20 Mar 2023 11:00:59 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>=20
>> It does not reset PG_slab and memcg_data when KFENCE fails to =
initialize
>> kfence pool at runtime. It is reporting a "Bad page state" message =
when
>> kfence pool is freed to buddy. The checking of whether it is a =
compound
>> head page seems unnecessary sicne we already guarantee this when =
allocating
>> kfence pool, removing the check to simplify the code.
>>=20
>> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
>> Fixes: 8f0b36497303 ("mm: kfence: fix objcgs vector allocation")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> I'm not sure how the -stable maintainers are to handle two Fixes: =
tags.
> Can we narrow it down to one please?  I assume 8f0b36497303 triggered
> the bad_page() warning?
>=20

Actually, 0ce20dd84089 triggered the PG_slab warning and 8f0b36497303
triggered the "page still charged to cgroup" warning. This patch fixes
both warnings. Moreover, 8f0b36497303 fixes 0ce20dd84089 as well. So I =
think
we can narrow it down to 0ce20dd84089.

Thanks.

