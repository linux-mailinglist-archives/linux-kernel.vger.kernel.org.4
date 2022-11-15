Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDA66298FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiKOMhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKOMhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:37:38 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773EBA18E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:37:36 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id D3766C021; Tue, 15 Nov 2022 13:37:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1668515859; bh=dRLmRGjelLn4ISwDWuO82EQ3Hk28Cz8KmKcEPDOeBrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXOB+kRUbMSDj4e863Cpr7UoXEs8nn0cm9BC5p/k5kpFqX47UPdOSWQGLTZ0ptnfL
         JFZFguJmIVimXgunUzKYjIFn+Owb//uKHqL8vJw/S4day7442/qztmd3t8eBrY0oz6
         d0w+mjQdunUBDMcQGDvOqrinzu1B5yNw7AKjSb5KSqGdP19QWNzwrpRs8B3pcgIBpb
         sWXIBSjI6d1qx2u+YegXuUTqwzm2fDjE6XoDiyns/UboZBSKGYEivR93osRdPXHS2c
         JwAEjC52z3rK/mAWwAPqO2TF2Jdpgvewc+e19j3SvU+usQSYGBvAweNz16TGrWl57x
         kNsncS7S7VodQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 19CBDC009;
        Tue, 15 Nov 2022 13:37:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1668515858; bh=dRLmRGjelLn4ISwDWuO82EQ3Hk28Cz8KmKcEPDOeBrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwu5HcHhSenN1e1nzWezhza/vy9zmZTqAVGh0Ms7xh/2tHyeUxbRA81PBKHwISush
         g4V4T3eSfsNcvZsdk667gWIGgwsMT8t5kfAS8yBoYLgF62dgn57vemKVLNzJUfDAxL
         O7QWfMS3FP7gzqFOP/cX0PUGBMrjeuPq9aS5nvW29wDg/1tJo9CDi6sgrHvdR34ldu
         32TbGsma406f+F+a8obtNjQcGTBz+X/DnGsUe3ZbkQlv1/YetIZ22MHXrdvUVkU6wP
         Sb8NugbowQdnN/PcVk5b8jJhlfRWu7He3Ra09koDqXE8r5pnPUi2c0F1uOHUOVXoVJ
         /riwf5+UWjoTA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id c61401fc;
        Tue, 15 Nov 2022 12:37:27 +0000 (UTC)
Date:   Tue, 15 Nov 2022 21:37:12 +0900
From:   asmadeus@codewreck.org
To:     Peng Zhang <zhangpeng362@huawei.com>, dhowells@redhat.com
Cc:     ericvh@gmail.com, lucho@ionkov.net, linux_oss@crudebyte.com,
        jlayton@kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+a76f6a6e524cf2080aa3@syzkaller.appspotmail.com
Subject: Re: [PATCH] fscache: fix OOB Read in __fscache_acquire_volume
Message-ID: <Y3OH+Dmi0QIOK18n@codewreck.org>
References: <20221115122701.2117502-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221115122701.2117502-1-zhangpeng362@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peng Zhang wrote on Tue, Nov 15, 2022 at 12:27:01PM +0000:
> The type of a->key[0] is char. If the length of cache volume key is
> greater than 127, the value of a->key[0] is less than 0. In this case,
> klen becomes much larger than 255 after type conversion, because the
> type of klen is size_t. As a result, memcmp() is read out of bounds. Fix
> this by adding a check on the length of the key in
> v9fs_cache_session_get_cookie().

Thanks for the analysis. (it took me a while to understand what a->key
was about, this is referring to the code in fscache_volume_same...)

It feels like that's another problem that could be avoided by using
unsigned... but I don't know enough about fscache to comment seriously
about whether that'd be viable or not, and it'd just punt the limit from
127 to 255 anyway.

Rather than this patch, I've had a quick look at afs/cifs/ceph and it
doesen't look like any of these check the name length before calling
fscache_acquire_volume either -- I'd say it's worth moving that check
there.
Perhaps in fscahce_alloc_volume() they already compute
klen = strlen(volume_key) to store it in key[0] -- making sure it fits
a signed char before writing key[0] sounds like a good idea that'd
benefit everyone?

Please test this (feel free to resend that):
---
diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
index a058e0136bfe..cc206d5e4cc7 100644
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -230,6 +230,8 @@ static struct fscache_volume *fscache_alloc_volume(const char *volume_key,
 	 * hashing easier.
 	 */
 	klen = strlen(volume_key);
+	if (klen > 127)
+		goto err_cache;
 	hlen = round_up(1 + klen + 1, sizeof(__le32));
 	key = kzalloc(hlen, GFP_KERNEL);
 	if (!key)
---


David, comments welcome :)

--
Dominique
