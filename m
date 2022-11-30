Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BBD63D8A1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiK3O6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiK3O6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:58:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83E917054
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669820237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N6u+3XG/IMxarSx5aTpA9vTKE6ky1leeXmNmLaEP+NA=;
        b=FMkFdlOPHXkk7RnOxSn6cSYK0SdLMakwS2DaifBEg+sTCWyPO+JzvAGWUxcYtAQxDD2dO0
        KynItKnmodqMqZ880I/lToA08LJDWGRSmiauLRY2R8Ac1bUzlkY0GrkhNlGw45u7zVwPeM
        130/BBV1G4XLnevKZZCm7hZ86yxXW7E=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-CnNKd7jpOxWOSd_uRvV6jg-1; Wed, 30 Nov 2022 09:57:15 -0500
X-MC-Unique: CnNKd7jpOxWOSd_uRvV6jg-1
Received: by mail-pf1-f200.google.com with SMTP id b13-20020a056a000a8d00b0057348c50123so14460015pfl.18
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6u+3XG/IMxarSx5aTpA9vTKE6ky1leeXmNmLaEP+NA=;
        b=DU6SVDQ4ZkssvO9YdZApYC45I/238zCcupzQcLRwMazppsN4buSpDuUe1eSyzZ5XTa
         gqjwerSoIRck8zR23orcL+rphPEmHd/qhkXNdMbX3ysDODsH4WgjfNpSg3K4tStWJ14h
         zot6LD60TpTnAKp+gpyOFXIyquS3bEjaWwXCji9MLgw3/n0gZOgrmA6oBch41HkIJNnA
         TeSOS+RFl54O084buuFnODnhPfgJTCfVV7Bm9SkFu60CRMEpZVSyH7Sk5BUh6mOQRWE9
         KVhOJekMTORyseKev0jWUDptEau3hOXka3/PzSOwcxxKlA4GSBEa1+G8Bdz4kiFOqCk1
         ZDZA==
X-Gm-Message-State: ANoB5pncha7vkHDvhXR95RgT3GQRlH6Tf7dujmbYSTB1VS511QZxKfm1
        EqYpMcShSWpHbz/QVbUZBGcjKJY5Xk04Iyezop/XaYVn5Ggi+J/UWPAV15Dg79zSkk2M68v03yI
        zW7U0cD/hhxYVgWEa3ES81jMp
X-Received: by 2002:a63:165d:0:b0:473:f7cd:6603 with SMTP id 29-20020a63165d000000b00473f7cd6603mr37042533pgw.336.1669820234232;
        Wed, 30 Nov 2022 06:57:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7V5/uVZ6WdKV+gGJoNyoymh+C7/c+wVew1dN51CbEENsyVhB08Hf+fc9wbP23e81z/ykc0ng==
X-Received: by 2002:a63:165d:0:b0:473:f7cd:6603 with SMTP id 29-20020a63165d000000b00473f7cd6603mr37042464pgw.336.1669820233305;
        Wed, 30 Nov 2022 06:57:13 -0800 (PST)
Received: from ryzen.. ([240d:1a:c0d:9f00:fc9c:8ee9:e32c:2d9])
        by smtp.gmail.com with ESMTPSA id v124-20020a626182000000b00574e4fe6118sm1488600pfb.162.2022.11.30.06.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 06:57:12 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] fs/ntfs3: Fix slab-out-of-bounds in ntfs_trim_fs()
Date:   Wed, 30 Nov 2022 23:57:05 +0900
Message-Id: <20221130145705.488351-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ntfs_trim_fs() should loop with wnd->nwnd, not wnd->nbits.  KASAN
detects this as an out-of-bounds access like below:

==================================================================
BUG: KASAN: slab-out-of-bounds in ntfs_trim_fs (fs/ntfs3/bitmap.c:1434)
Read of size 2 at addr ffff8881745b4f02 by task repro/19678

Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-2.fc37 04/01/2014
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
print_report (mm/kasan/report.c:285 mm/kasan/report.c:395)
? __virt_addr_valid (arch/x86/mm/physaddr.c:66)
? __phys_addr (arch/x86/mm/physaddr.c:32 (discriminator 4))
? ntfs_trim_fs (fs/ntfs3/bitmap.c:1434)
? ntfs_trim_fs (fs/ntfs3/bitmap.c:1434)
kasan_report (mm/kasan/report.c:162 mm/kasan/report.c:497)
? ntfs_trim_fs (fs/ntfs3/bitmap.c:1434)
ntfs_trim_fs (fs/ntfs3/bitmap.c:1434)
ntfs_ioctl (fs/ntfs3/file.c:41 fs/ntfs3/file.c:57)
? ntfs_fiemap (fs/ntfs3/file.c:51)
? bpf_lsm_file_ioctl (./include/linux/lsm_hook_defs.h:165)
? ntfs_fiemap (fs/ntfs3/file.c:51)
__x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 fs/ioctl.c:856 fs/ioctl.c:856)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 fs/ntfs3/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index e92bbd754365..1930640be31a 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -1424,7 +1424,7 @@ int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range)
 
 	down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
 
-	for (; iw < wnd->nbits; iw++, wbit = 0) {
+	for (; iw < wnd->nwnd; iw++, wbit = 0) {
 		CLST lcn_wnd = iw * wbits;
 		struct buffer_head *bh;
 
-- 
2.38.1

