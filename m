Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAA160BBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiJXVMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJXVLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:11:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44E75F9BF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:18:01 -0700 (PDT)
Received: from weisslap.fritz.box ([31.19.218.61]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M7JrG-1ojlfn3uQ8-007kSm; Mon, 24 Oct 2022 21:16:00 +0200
From:   =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [PATCH 1/1] squashfs: enable idmapped mounts
Date:   Mon, 24 Oct 2022 21:15:52 +0200
Message-Id: <20221024191552.55951-1-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GS8PANgE7Dfklhd8gVLd+uEzsWvaG0dtuKC/+aY6eN5NekbFeTJ
 KX6ESI4Kifr40Y5GMDg2hiBjnYPjMy3hj3VVt0S7TLwYyB9lLdvmm3usHbJNg1URQ1FQKKw
 arSZc/Phg+qpGiMoPpp0wWkz1RWNwUkIyzNGURusy5u7KH9zE/6JVs4WOLbumt3yo2g4qgg
 SPSStrV4pKpCHX56yFTkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pK+tZBCwFdo=:OTmz4XuzG3Syg00L5YHUzK
 kTPY2BZnwjHcXdv0Jhe5YzvtYeEjdRSXNwvBH3V7j8tHD1NEqcIqeQuhqmA6Eg2PzaY2Tu66u
 uPe3x7Uf7C6j3omK9qzuBrI1R19qwvOEapBIQH/biaiQFKLlWS7TGwg4+G6Yl3DXI2VjPJt8e
 rHibxcpbHR2eu0wn9apzc985zRJn8Qt6HYr7o4bRYLsiS0h801uSl5E2qwfgTU4HLe5y8fEuZ
 pr4+6KH+I84bPGD/l3sq7VXplNr1qBPBXB8VzrGmCx68PfhQR7DE4VqtNqJxS8HmS1qJlT1Fu
 y4xhf7q+C/Hgr8+2/YteBqOceN8OvqAe3gohI9VhJxtJGjCsXS7+lPIinpL92Snh4ggZeDaSC
 jkL+FCbwXUHxv/UPX/zkJQZVojzSGjelcUdQA2OTOgmQylqVuU0mgY7cdDs+Z2hSPYt2fPkqL
 COXaMvn5nwb0+UR174Ub5l2ohGm1SxjTOBsSxzZPLGYmi1epVnKgMm0ONIqIzfLNikqBKcaD8
 GyIzzmHLqD6BjiiIFYdSNncALOb8AN6hJL+k3q7g97NuW8ixr/MedMhLq7UDqIWIoRlvDv7du
 tO08dt0xen+0O5OlTK3Ig3FNIRuHRFWMBExDREW79Um/hXtTB6zKmRUNna2wBwCd3FuDLA/Dc
 TaDLwa39dJJ4mEKXo+QHOaLosom0IjtAwFzsaF/FwW8juy/LIA9Ku/Mif8mOICOI8EpFNPUo5
 KJSTFNKeDbckippD2cezPyGtiqkbXmqftyDl/jrioTSNmj8hKrvvRbVnqFFljCWSzBVZd7KKZ
 uJxAgSQqnsLMjDEZosULhgKJ84dQw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For squashfs all needed functionality for idmapped mounts is already
implemented by the generic handlers in the VFS. Thus, it is sufficient
to just enable the corresponding FS_ALLOW_IDMAP flag to support
idmapped mounts.

We use this for unprivileged (user namespaced) containers based on
squashfs images as rootfs in GyroidOS.

A simple test using the mount-idmapped tool executed as user with
uid=1000 looks as follows:

$ mkdir test
$ echo "test" > test/test_file
$ mksquashfs test/ fs.img
$ sudo mkdir /mnt/test
$ sudo mkdir /mnt/mapped
$ sudo mount fs.img -o loop /mnt/test/
$ sudo ./mount-idmapped --map-mount b:1000:2000:1 /mnt/test/ /mnt/mapped/

$ mount | tail -n2
fs.img on /mnt/test type squashfs (ro,relatime,errors=continue)
fs.img on /mnt/mapped type squashfs (ro,relatime,idmapped,errors=continue)

$ ls -lan /mnt/test/
total 5
drwxr-xr-x 2 1000 1000   32 Okt 24 13:36 .
drwxr-xr-x 6    0    0 4096 Okt 24 13:38 ..
-rw-r--r-- 1 1000 1000    5 Okt 24 13:36 test_file

$ ls -lan /mnt/mapped/
total 5
drwxr-xr-x 2 2000 2000   32 Okt 24 13:36 .
drwxr-xr-x 6    0    0 4096 Okt 24 13:38 ..
-rw-r--r-- 1 2000 2000    5 Okt 24 13:36 test_file

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 fs/squashfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 32565dafa7f3..2636cb354435 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -568,7 +568,7 @@ static struct file_system_type squashfs_fs_type = {
 	.init_fs_context = squashfs_init_fs_context,
 	.parameters = squashfs_fs_parameters,
 	.kill_sb = kill_block_super,
-	.fs_flags = FS_REQUIRES_DEV
+	.fs_flags = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("squashfs");
 
-- 
2.30.2

