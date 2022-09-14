Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB01F5B8E42
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiINRlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiINRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:41:10 -0400
Received: from mail-oa1-x62.google.com (mail-oa1-x62.google.com [IPv6:2001:4860:4864:20::62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4269785A89
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 10:41:07 -0700 (PDT)
Received: by mail-oa1-x62.google.com with SMTP id 586e51a60fabf-11eab59db71so42937123fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 10:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date;
        bh=OC+An9rGy64Oo11LE9atBcfSR4Lnge42KOirmnmC0cI=;
        b=nKoce94PSgppuJeSushHDiBrhEa+7mU3QWF7/5pw9OQpQGbbhI2pOq990Qut2FgrK9
         7owhXiG4cONGPUuvMnRQ4eQNn+ry/vEdqIBkyfHLHZkmlTXA5ULRtgdmM1opG9bZwTFU
         5oeXXkxo8noHL0+doNZGf1k1CZcJxgRkTDndy2uuN5eNjLQuTt8M+vnJ2eJ2e9uE7Buk
         FCyk3El3BopuBcmtIgF2H9zJhJWPBq5/fxnYpxq5KtfYlByersMvoWocNvdrsjiFF3lU
         uNyCoVb7KHJH78BCmF/EnOZAojBNfNA0EzhSnmA+TyQgAvRNSBBmjasYFNjNW7vBkJHU
         FSTQ==
X-Gm-Message-State: ACgBeo0wAuel3Uei0W/QyRHcf44xffeu5Ddh4ted4AZ7CUGQJzr4YYKx
        ihQz9nLaBlbo/31AIOC2VZEtq2CJ/A1ZvYtxog7uNDosfKLz
X-Google-Smtp-Source: AA6agR5bgI5MLvOj22J+/AeudGv75xiYxiZzZukCj+rDPoEoyuIFx/fYgw/OmBTKI/WXT18pBVICXOVpnXzP
X-Received: by 2002:a05:6808:1142:b0:343:86a0:dedc with SMTP id u2-20020a056808114200b0034386a0dedcmr2453375oiu.44.1663177266220;
        Wed, 14 Sep 2022 10:41:06 -0700 (PDT)
Received: from smtp.aristanetworks.com (mx.aristanetworks.com. [162.210.129.12])
        by smtp-relay.gmail.com with ESMTPS id pv11-20020a0568709d8b00b0012c35fc7611sm92940oab.9.2022.09.14.10.41.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Sep 2022 10:41:06 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from us267.sjc.aristanetworks.com (us267.sjc.aristanetworks.com [10.244.144.10])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 7FD34419011;
        Wed, 14 Sep 2022 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-B; t=1663177265;
        bh=OC+An9rGy64Oo11LE9atBcfSR4Lnge42KOirmnmC0cI=;
        h=From:To:Cc:Subject:Date:From;
        b=rt/XXv1dqIt0vD53QAmr8b3aO2LYrOVyvyCEIE/q+JfZq1WQHXXR2tffqAd/wQ5PR
         BWb2CGpDsD4Zz/YuGPGdGlW3ZC9ddcbhxoRlvac5V+qQPkPJ2vM+NyWJDjnhHqNy6L
         udG05JjdyOKIsg0pshqLQH8bx7lKCd2jIBpblA+I=
Received: by us267.sjc.aristanetworks.com (Postfix, from userid 17566)
        id 69E12B70033A; Wed, 14 Sep 2022 10:41:05 -0700 (PDT)
From:   Gianfranco <gianfranco.dutka@arista.com>
To:     hirofumi@mail.parknet.co.jp
Cc:     gianfranco.dutka@arista.com, linux-kernel@vger.kernel.org
Subject: [PATCH]     fat: device-level-flush-after-sync
Date:   Wed, 14 Sep 2022 10:40:14 -0700
Message-Id: <20220914174015.7158-1-gianfranco.dutka@arista.com>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    This patch forces a device-level flush after the generic Linux
    code for sync has run.

    The kernel depends upon filesystem-specific code to flush when
    the filesystem itself thinks it is necessary, and otherwise
    does nothing.  Someone expecting sync to behave as expected
    might be in for a rude surprise.

    The usual caveats apply:  Devices that do not implement flush
    or whose implementation is buggy will not behave well.  IO
    that occurs after the sync will not be flushed.

Signed-off-by: Ken Kofman <gianfranco.dutka@arista.com>

---
 fs/fat/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index a38238d75c08..ddaed94ee48f 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -823,6 +823,14 @@ static int fat_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 }
 
+static int fat_sync_fs(struct super_block *sb, int wait)
+{
+	if (wait)
+		return blkdev_issue_flush(sb->s_bdev, GFP_KERNEL, NULL);
+	else
+		return 0;
+}
+
 static int fat_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
@@ -937,6 +945,7 @@ static const struct super_operations fat_sops = {
 	.put_super	= fat_put_super,
 	.statfs		= fat_statfs,
 	.remount_fs	= fat_remount,
+	.sync_fs        = fat_sync_fs,
 
 	.show_options	= fat_show_options,
 };
-- 
2.37.0

