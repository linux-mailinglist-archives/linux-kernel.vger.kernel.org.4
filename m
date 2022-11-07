Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2316261F5B4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiKGOT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiKGOSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:18:24 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FFE1DF0C;
        Mon,  7 Nov 2022 06:17:04 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id c2so11158638plz.11;
        Mon, 07 Nov 2022 06:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YIGCG3JSicaeGibjjXaK+2paVpoxNZKxWBa9NcdXR60=;
        b=IpTvulmM03bh7V7v6A1s0fgGEjc0qe/ZluJ72Ql31yPTIGsRX94CeaYUTeQnF9jUp0
         aacc1OITFyuRx75c7wTUqIzcKSdrm/ue+mpxVqdjwPrssj5zWA9lXFtALQEMWt7dZyAd
         966iMNjvuqfyKxvZD+ey5JFS7pdUrDp2KGhtAs31Jc7AtKxw9NdkWGWtgtfuTIF/LiOV
         3OoOlNp0PsiKyNabgxIsc269EDWO+Goqecup3MgZMuEO7NNaL9tsmGsVduOaosz0EBAR
         5gIr12gyTks0wVugLx4eDe16T1EmI18OBES8eg8dMb9U8wZCFVnZw9/4J00Zdk2TFFoU
         Xbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIGCG3JSicaeGibjjXaK+2paVpoxNZKxWBa9NcdXR60=;
        b=02pRA/24Aq0mQaDdF5CjAe/b2CbQqMjSSKGBbmujTo1lWrS+HtpL8w20HEijBzvuqW
         dau3qcwE1/DPKLgVODKOLPtSQsFROETZGv22twdUs6RV9vb8UMtQbwgDh6OvtKK+0M51
         M3Q+U8tBsDyLHUbSNcj3PalNm9cGIt+SpU7ocMbO7skWwfEsqI2mA5PtyQJAkBdV0fsg
         Y3v8e3/5sGx0h7St+zZX5G+GZD4nCmdzx8Yk1ryiEvvQ770y+QYaAPZukPylWJDLd8m2
         6M2dzgurtx13SCSB19glw8Yc7OAlLUTsEsAtYB6xKgUiEBFiQN0FqP3/QYCRR+MZuv8O
         Niuw==
X-Gm-Message-State: ACrzQf0yRUcRCuFn2ev6oQ+u6BjzSfkGgzuk1y/2+Q8yJSr1jTkxu9DF
        FLBHhXzx7wCIY82s29XPFAc=
X-Google-Smtp-Source: AMsMyM7GRrlvbpu8FqCWhlxkmoMyv/nS+cndGIMuBYNsIKDEbOORRCIe4haCFaamNj64BoJ+4sGczw==
X-Received: by 2002:a17:902:720a:b0:181:150c:fcc4 with SMTP id ba10-20020a170902720a00b00181150cfcc4mr51685547plb.109.1667830624200;
        Mon, 07 Nov 2022 06:17:04 -0800 (PST)
Received: from localhost.localdomain ([103.98.14.159])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b00176ba091cd3sm5063726plh.196.2022.11.07.06.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 06:17:03 -0800 (PST)
From:   Jiang Li <jiang.li1388@gmail.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiang@ugreen.com, Jiang Li <jiang.li@ugreen.com>
Subject: [PATCH V3 1/1] md/raid1: stop mdx_raid1 thread when raid1 array run failed
Date:   Mon,  7 Nov 2022 22:16:59 +0800
Message-Id: <20221107141659.2680-1-jiang.li1388@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiang Li <jiang.li@ugreen.com>

fail run raid1 array when we assemble array with the inactive disk only,
but the mdx_raid1 thread were not stop, Even if the associated resources
have been released. it will caused a NULL dereference when we do poweroff.

This causes the following Oops:
    [  287.587787] BUG: kernel NULL pointer dereference, address: 0000000000000070
    [  287.594762] #PF: supervisor read access in kernel mode
    [  287.599912] #PF: error_code(0x0000) - not-present page
    [  287.605061] PGD 0 P4D 0
    [  287.607612] Oops: 0000 [#1] SMP NOPTI
    [  287.611287] CPU: 3 PID: 5265 Comm: md0_raid1 Tainted: G     U            5.10.146 #0
    [  287.619029] Hardware name: xxxxxxx/To be filled by O.E.M, BIOS 5.19 06/16/2022
    [  287.626775] RIP: 0010:md_check_recovery+0x57/0x500 [md_mod]
    [  287.632357] Code: fe 01 00 00 48 83 bb 10 03 00 00 00 74 08 48 89 ......
    [  287.651118] RSP: 0018:ffffc90000433d78 EFLAGS: 00010202
    [  287.656347] RAX: 0000000000000000 RBX: ffff888105986800 RCX: 0000000000000000
    [  287.663491] RDX: ffffc90000433bb0 RSI: 00000000ffffefff RDI: ffff888105986800
    [  287.670634] RBP: ffffc90000433da0 R08: 0000000000000000 R09: c0000000ffffefff
    [  287.677771] R10: 0000000000000001 R11: ffffc90000433ba8 R12: ffff888105986800
    [  287.684907] R13: 0000000000000000 R14: fffffffffffffe00 R15: ffff888100b6b500
    [  287.692052] FS:  0000000000000000(0000) GS:ffff888277f80000(0000) knlGS:0000000000000000
    [  287.700149] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  287.705897] CR2: 0000000000000070 CR3: 000000000320a000 CR4: 0000000000350ee0
    [  287.713033] Call Trace:
    [  287.715498]  raid1d+0x6c/0xbbb [raid1]
    [  287.719256]  ? __schedule+0x1ff/0x760
    [  287.722930]  ? schedule+0x3b/0xb0
    [  287.726260]  ? schedule_timeout+0x1ed/0x290
    [  287.730456]  ? __switch_to+0x11f/0x400
    [  287.734219]  md_thread+0xe9/0x140 [md_mod]
    [  287.738328]  ? md_thread+0xe9/0x140 [md_mod]
    [  287.742601]  ? wait_woken+0x80/0x80
    [  287.746097]  ? md_register_thread+0xe0/0xe0 [md_mod]
    [  287.751064]  kthread+0x11a/0x140
    [  287.754300]  ? kthread_park+0x90/0x90
    [  287.757974]  ret_from_fork+0x1f/0x30

In fact, when raid1 array run fail, we need to do
md_unregister_thread() before raid1_free().

Signed-off-by: Jiang Li <jiang.li@ugreen.com>
---
Hi,
my full name is Jiang Li. Thanks!

The following steps can be used to reproduce the problem:
mdadm --create /dev/md0 --level=1  --raid-devices=2 /dev/sd[a-b]
mdadm -A /dev/md0 /dev/sd[a-b]
mkfs.ext4  /dev/md0
mount /dev/md0   /mnt/md0

mdadm -S /dev/md0

mdadm -A /dev/md0 /dev/sda   --run  
mount /dev/md0   /mnt/md0
#Store a certain amount of data, so that the rebuilding will not be completed in a short time
dd if=/dev/urandom of=/mnt/md0/test.db bs=1M count=40960

mdadm --add /dev/md0 /dev/sdb
sleep 1
#when the array were rebuilding, we stop the array.
umount /dev/md0  
mdadm -S  /dev/md0

#assemble array with the sdb only in --run insist mode:
mdadm -A /dev/md0 /dev/sdb  --run  

#md run fail with kernel message as follow:
[  850.593441] md: md0 stopped.
[  850.672071] md: pers->run() failed ...
[  850.686913] md: md0 stopped.

#we can see the md0_raid1 thread were not stop:
$ps -ef | grep raid1
root      5672     2  0 Oct31 ?        00:00:04 [md0_raid1]

#now, do poweroff can reproduce the problem.

 drivers/md/raid1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 05d8438cfec8..58f705f42948 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3159,6 +3159,7 @@ static int raid1_run(struct mddev *mddev)
 	 * RAID1 needs at least one disk in active
 	 */
 	if (conf->raid_disks - mddev->degraded < 1) {
+		md_unregister_thread(&conf->thread);
 		ret = -EINVAL;
 		goto abort;
 	}
-- 
2.25.1

