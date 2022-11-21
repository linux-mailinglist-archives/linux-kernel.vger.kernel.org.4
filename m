Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B4D632EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiKUVgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiKUVfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:35:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A341C8464
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 13:35:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A863AB81668
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB4DC433D6;
        Mon, 21 Nov 2022 21:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669066537;
        bh=ME3JoFynEewzrOSy9c/B1ctbwfUDRGobuFBsXDrfdw8=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=qoxS8FrV44z8YCfl3O/WSwGWeEfMrhZaleDfeKlLyy/FburDP3i2I/LH7Wf7Gzyv5
         f94asK7C6zzNQVssQefVHv274RkO1LR0qMFPlxvep6gbuBy5YUlQLOdHWermXvcmsa
         oLRDGu7JRKVZ3rglw6KkylEpLbjHNCuLEn1Jnvju95PohaVMggaw/qTcfH3RDk83aF
         oZppzQSx8/NUdzmWh/2CyQLePYR8D2eM6IeUrTlwaknOgX+n6v229zr8X+6K42MDjV
         JCVPOpIKDtS42aqMl+9o0ncZ3tV9zE++7CJEyYgB2zGvmYJn0pdeJcPWnvEgpYVlPw
         gborMbJ9tZYnw==
Date:   Mon, 21 Nov 2022 13:35:30 -0800
From:   Kees Cook <kees@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
CC:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_01/12=5D_mm=2C_slab=3A_ignore_har?= =?US-ASCII?Q?dened_usercopy_parameters_when_disabled?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221121171202.22080-2-vbabka@suse.cz>
References: <20221121171202.22080-1-vbabka@suse.cz> <20221121171202.22080-2-vbabka@suse.cz>
Message-ID: <206E0154-63A6-45CF-8E19-BD01B35AEF0B@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 21, 2022 9:11:51 AM PST, Vlastimil Babka <vbabka@suse=2Ecz> wro=
te:
>With CONFIG_HARDENED_USERCOPY not enabled, there are no
>__check_heap_object() checks happening that would use the kmem_cache
>useroffset and usersize fields=2E Yet the fields are still initialized,
>preventing merging of otherwise compatible caches=2E Thus ignore the
>values passed to cache creation and leave them zero when
>CONFIG_HARDENED_USERCOPY is disabled=2E
>
>In a quick virtme boot test, this has reduced the number of caches in
>/proc/slabinfo from 131 to 111=2E
>
>Cc: Kees Cook <keescook@chromium=2Eorg>
>Signed-off-by: Vlastimil Babka <vbabka@suse=2Ecz>
>---
> mm/slab_common=2Ec | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/mm/slab_common=2Ec b/mm/slab_common=2Ec
>index 0042fb2730d1=2E=2Ea8cb5de255fc 100644
>--- a/mm/slab_common=2Ec
>+++ b/mm/slab_common=2Ec
>@@ -317,7 +317,8 @@ kmem_cache_create_usercopy(const char *name,
> 	flags &=3D CACHE_CREATE_MASK;
>=20
> 	/* Fail closed on bad usersize of useroffset values=2E */
>-	if (WARN_ON(!usersize && useroffset) ||
>+	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
>+	    WARN_ON(!usersize && useroffset) ||
> 	    WARN_ON(size < usersize || size - usersize < useroffset))
> 		usersize =3D useroffset =3D 0;
>=20
>@@ -640,6 +641,9 @@ void __init create_boot_cache(struct kmem_cache *s, c=
onst char *name,
> 		align =3D max(align, size);
> 	s->align =3D calculate_alignment(flags, align, size);
>=20
>+	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY))
>+		useroffset =3D usersize =3D 0;
>+
> 	s->useroffset =3D useroffset;
> 	s->usersize =3D usersize;
>=20

"Always non-mergeable" is intentional here, but I do see the argument for =
not doing it under hardened-usercopy=2E

That said, if you keep this part, maybe go the full step and ifdef away us=
eroffset/usersize's struct member definition and other logic, especially fo=
r SLUB_TINY benefits, so 2 ulongs are dropped from the cache struct?

-Kees


--=20
Kees Cook
