Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E317693661
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 08:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBLHjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 02:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBLHjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 02:39:51 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C2DE076;
        Sat, 11 Feb 2023 23:39:50 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-16a7f5b6882so11839259fac.10;
        Sat, 11 Feb 2023 23:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AbdTGX2HfdPDPJ5urJzs6BFMyz88+QI/M5bZN4yo268=;
        b=HHShUb01K1C3wH8rCZMLSk25JDHUY8dv19q69YXCCy00eXVA/RigwMEv2KtuU6kXG5
         4bjbbUre0OIAnFJR/bs206vITa7MeCyXv+RSb3F3hG3M8DQ6S+MvQtQcsfUpdFzBCmfr
         CZz+AGNTQjYQBeOcibmXPt4ksTOraFpv+neRdFMmJOeLHZ8uTHMkNDIrbekyfEkXO0LY
         i/8kMMWNWNiTn4Utg0GFZVljCinERYs/8DqYdjrXaO0+eyXzdI3pww03RH4VAdiOgShV
         d9sO2hF7qLNWV2cvcehV8c7OccotsHKkLrvxrxoUR2Uy0EG+ul0jEqHhJFHNjTEME2ws
         veHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbdTGX2HfdPDPJ5urJzs6BFMyz88+QI/M5bZN4yo268=;
        b=hzmdP6cV5AsTaN0zFtyEVKZ0Z83u5ZyqyHrTv5UNyF8jKIP2YQpjfrO6eVlegbkvle
         /uWG285QPxrX5/ozknkDBAb09+rv9Ur7LuVd86jLRDVQljnm9vL9gt4/6pB2UIhICqjT
         NIrCdSx5JTN6igMNBMg1wxcrUHBSOyg2RS/t7jeTCCmw9uCn9lS1WyOe2xM9Vb6nhHTi
         peCqUT1C0mOVSmw6xRtGG7bH+Mblqsgfyzo4pn4HJrfS6W/9gbxL144jJc/aO6afC3R0
         ULK65lqbH5rBpJ6tHBzLz6W7gi3aBiDnVyCnfiS88TxXDEh5ahRmHjsji0WK3uFryGAH
         T7bw==
X-Gm-Message-State: AO0yUKWFCQSr4hBROsoTN4daawEyjnQcd4riCFiI2qsvBCKF2ZuewD7F
        3Ls0qftmWBbOJCXpf6A5rcqmAREE+C1eYJwt2NaSq5zNeRV2gQ==
X-Google-Smtp-Source: AK7set8PiDRfaDZAwoFjZTFJCI3Zvd35wJ+a3wFejFKgpf+BOtKsENQ+wHjtZC8KITh+WZ0XE98H/Z1LaVMO3NKyxQM=
X-Received: by 2002:a05:6870:d288:b0:163:83b6:d9e2 with SMTP id
 d8-20020a056870d28800b0016383b6d9e2mr3070927oae.90.1676187588418; Sat, 11 Feb
 2023 23:39:48 -0800 (PST)
MIME-Version: 1.0
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Sat, 11 Feb 2023 23:39:37 -0800
Message-ID: <CANX2M5YjZfJs5Z1L1O0bXEhMn=ZDp7uy4y=D14BHnhFFLjLrUg@mail.gmail.com>
Subject: KMSAN: uninit-value in sr_check_events
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Marius Fleischer <fleischermarius@googlemail.com>,
        Priyanka Bose <its.priyanka.bose@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c90e6005f47bd5b6"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c90e6005f47bd5b6
Content-Type: text/plain; charset="UTF-8"

Hi,

We would like to report the following bug which has been found by our
modified version of syzkaller.

======================================================
description: KMSAN: uninit-value in sr_check_events
affected file: drivers/scsi/sr.c
kernel version: 6.2.0-rc5
kernel commit: 41c66f47061608dc1fd493eebce198f0e74cc2d7
git tree: kmsan
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=a9a22da1efde3af6
crash reproducer: attached
======================================================
Crash log:
======================================================
BUG: KMSAN: uninit-value in sr_check_events+0x12d2/0x13c0 drivers/scsi/sr.c:269
 sr_check_events+0x12d2/0x13c0 drivers/scsi/sr.c:269
 cdrom_update_events drivers/cdrom/cdrom.c:1485 [inline]
 cdrom_check_events+0x61/0x170 drivers/cdrom/cdrom.c:1495
 sr_block_check_events+0xf5/0x130 drivers/scsi/sr.c:559
 disk_check_events+0xf1/0x950 block/disk-events.c:193
 disk_clear_events block/disk-events.c:248 [inline]
 bdev_check_media_change+0x26a/0x7f0 block/disk-events.c:279
 sr_block_open+0x159/0x340 drivers/scsi/sr.c:494
 blkdev_get_whole+0xb4/0x700 block/bdev.c:672
 blkdev_get_by_dev+0x4c9/0x1280 block/bdev.c:822
 blkdev_open+0x216/0x440 block/fops.c:478
 do_dentry_open+0xf85/0x1970 fs/open.c:882
 vfs_open+0x75/0xa0 fs/open.c:1013
 do_open fs/namei.c:3557 [inline]
 path_openat+0x4c4b/0x5a00 fs/namei.c:3714
 do_filp_open+0x252/0x660 fs/namei.c:3741
 do_sys_openat2+0x200/0x920 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x285/0x310 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was stored to memory at:
 sr_check_events+0xb04/0x13c0 drivers/scsi/sr.c:216
 cdrom_update_events drivers/cdrom/cdrom.c:1485 [inline]
 cdrom_check_events+0x61/0x170 drivers/cdrom/cdrom.c:1495
 sr_block_check_events+0xf5/0x130 drivers/scsi/sr.c:559
 disk_check_events+0xf1/0x950 block/disk-events.c:193
 disk_clear_events block/disk-events.c:248 [inline]
 bdev_check_media_change+0x26a/0x7f0 block/disk-events.c:279
 sr_block_open+0x159/0x340 drivers/scsi/sr.c:494
 blkdev_get_whole+0xb4/0x700 block/bdev.c:672
 blkdev_get_by_dev+0x4c9/0x1280 block/bdev.c:822
 blkdev_open+0x216/0x440 block/fops.c:478
 do_dentry_open+0xf85/0x1970 fs/open.c:882
 vfs_open+0x75/0xa0 fs/open.c:1013
 do_open fs/namei.c:3557 [inline]
 path_openat+0x4c4b/0x5a00 fs/namei.c:3714
 do_filp_open+0x252/0x660 fs/namei.c:3741
 do_sys_openat2+0x200/0x920 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x285/0x310 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Local variable sshdr.i created at:
 sr_get_events drivers/scsi/sr.c:172 [inline]
 sr_check_events+0x11f/0x13c0 drivers/scsi/sr.c:215
 cdrom_update_events drivers/cdrom/cdrom.c:1485 [inline]
 cdrom_check_events+0x61/0x170 drivers/cdrom/cdrom.c:1495

CPU: 0 PID: 22994 Comm: syz-executor.1 Not tainted
6.2.0-rc5-00010-g41c66f470616 #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014

-- 
Thanks and Regards,

Dipanjan

--000000000000c90e6005f47bd5b6
Content-Type: application/octet-stream; name="repro.syz"
Content-Disposition: attachment; filename="repro.syz"
Content-Transfer-Encoding: base64
Content-ID: <f_le12o6xx2>
X-Attachment-Id: f_le12o6xx2

b3BlbmF0JHNyKDB4ZmZmZmZmZmZmZmZmZmY5YywgJigweDdmMDAwMDAwMDA0MCksIDB4NDg4MDAs
IDB4MCkgKGZhaWxfbnRoOiA3KQo=
--000000000000c90e6005f47bd5b6
Content-Type: text/x-csrc; charset="US-ASCII"; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_le12o6xp1>
X-Attachment-Id: f_le12o6xp1

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRSAKCiNpbmNsdWRlIDxkaXJlbnQuaD4KI2lu
Y2x1ZGUgPGVuZGlhbi5oPgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNp
bmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN0ZGFyZy5oPgojaW5jbHVkZSA8c3RkYm9vbC5o
PgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGli
Lmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN5cy9wcmN0bC5oPgojaW5jbHVkZSA8
c3lzL3N0YXQuaD4KI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMu
aD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNpbmNsdWRlIDx0aW1lLmg+CiNpbmNsdWRlIDx1bmlz
dGQuaD4KCnN0YXRpYyB2b2lkIHNsZWVwX21zKHVpbnQ2NF90IG1zKQp7Cgl1c2xlZXAobXMgKiAx
MDAwKTsKfQoKc3RhdGljIHVpbnQ2NF90IGN1cnJlbnRfdGltZV9tcyh2b2lkKQp7CglzdHJ1Y3Qg
dGltZXNwZWMgdHM7CglpZiAoY2xvY2tfZ2V0dGltZShDTE9DS19NT05PVE9OSUMsICZ0cykpCgll
eGl0KDEpOwoJcmV0dXJuICh1aW50NjRfdCl0cy50dl9zZWMgKiAxMDAwICsgKHVpbnQ2NF90KXRz
LnR2X25zZWMgLyAxMDAwMDAwOwp9CgpzdGF0aWMgYm9vbCB3cml0ZV9maWxlKGNvbnN0IGNoYXIq
IGZpbGUsIGNvbnN0IGNoYXIqIHdoYXQsIC4uLikKewoJY2hhciBidWZbMTAyNF07Cgl2YV9saXN0
IGFyZ3M7Cgl2YV9zdGFydChhcmdzLCB3aGF0KTsKCXZzbnByaW50ZihidWYsIHNpemVvZihidWYp
LCB3aGF0LCBhcmdzKTsKCXZhX2VuZChhcmdzKTsKCWJ1ZltzaXplb2YoYnVmKSAtIDFdID0gMDsK
CWludCBsZW4gPSBzdHJsZW4oYnVmKTsKCWludCBmZCA9IG9wZW4oZmlsZSwgT19XUk9OTFkgfCBP
X0NMT0VYRUMpOwoJaWYgKGZkID09IC0xKQoJCXJldHVybiBmYWxzZTsKCWlmICh3cml0ZShmZCwg
YnVmLCBsZW4pICE9IGxlbikgewoJCWludCBlcnIgPSBlcnJubzsKCQljbG9zZShmZCk7CgkJZXJy
bm8gPSBlcnI7CgkJcmV0dXJuIGZhbHNlOwoJfQoJY2xvc2UoZmQpOwoJcmV0dXJuIHRydWU7Cn0K
CnN0YXRpYyBpbnQgaW5qZWN0X2ZhdWx0KGludCBudGgpCnsKCWludCBmZDsKCWZkID0gb3Blbigi
L3Byb2MvdGhyZWFkLXNlbGYvZmFpbC1udGgiLCBPX1JEV1IpOwoJaWYgKGZkID09IC0xKQoJZXhp
dCgxKTsKCWNoYXIgYnVmWzE2XTsKCXNwcmludGYoYnVmLCAiJWQiLCBudGgpOwoJaWYgKHdyaXRl
KGZkLCBidWYsIHN0cmxlbihidWYpKSAhPSAoc3NpemVfdClzdHJsZW4oYnVmKSkKCWV4aXQoMSk7
CglyZXR1cm4gZmQ7Cn0KCnN0YXRpYyB2b2lkIGtpbGxfYW5kX3dhaXQoaW50IHBpZCwgaW50KiBz
dGF0dXMpCnsKCWtpbGwoLXBpZCwgU0lHS0lMTCk7CglraWxsKHBpZCwgU0lHS0lMTCk7Cglmb3Ig
KGludCBpID0gMDsgaSA8IDEwMDsgaSsrKSB7CgkJaWYgKHdhaXRwaWQoLTEsIHN0YXR1cywgV05P
SEFORyB8IF9fV0FMTCkgPT0gcGlkKQoJCQlyZXR1cm47CgkJdXNsZWVwKDEwMDApOwoJfQoJRElS
KiBkaXIgPSBvcGVuZGlyKCIvc3lzL2ZzL2Z1c2UvY29ubmVjdGlvbnMiKTsKCWlmIChkaXIpIHsK
CQlmb3IgKDs7KSB7CgkJCXN0cnVjdCBkaXJlbnQqIGVudCA9IHJlYWRkaXIoZGlyKTsKCQkJaWYg
KCFlbnQpCgkJCQlicmVhazsKCQkJaWYgKHN0cmNtcChlbnQtPmRfbmFtZSwgIi4iKSA9PSAwIHx8
IHN0cmNtcChlbnQtPmRfbmFtZSwgIi4uIikgPT0gMCkKCQkJCWNvbnRpbnVlOwoJCQljaGFyIGFi
b3J0WzMwMF07CgkJCXNucHJpbnRmKGFib3J0LCBzaXplb2YoYWJvcnQpLCAiL3N5cy9mcy9mdXNl
L2Nvbm5lY3Rpb25zLyVzL2Fib3J0IiwgZW50LT5kX25hbWUpOwoJCQlpbnQgZmQgPSBvcGVuKGFi
b3J0LCBPX1dST05MWSk7CgkJCWlmIChmZCA9PSAtMSkgewoJCQkJY29udGludWU7CgkJCX0KCQkJ
aWYgKHdyaXRlKGZkLCBhYm9ydCwgMSkgPCAwKSB7CgkJCX0KCQkJY2xvc2UoZmQpOwoJCX0KCQlj
bG9zZWRpcihkaXIpOwoJfSBlbHNlIHsKCX0KCXdoaWxlICh3YWl0cGlkKC0xLCBzdGF0dXMsIF9f
V0FMTCkgIT0gcGlkKSB7Cgl9Cn0KCnN0YXRpYyB2b2lkIHNldHVwX3Rlc3QoKQp7CglwcmN0bChQ
Ul9TRVRfUERFQVRIU0lHLCBTSUdLSUxMLCAwLCAwLCAwKTsKCXNldHBncnAoKTsKCXdyaXRlX2Zp
bGUoIi9wcm9jL3NlbGYvb29tX3Njb3JlX2FkaiIsICIxMDAwIik7Cn0KCnN0YXRpYyB2b2lkIHNl
dHVwX2ZhdWx0KCkKewoJc3RhdGljIHN0cnVjdCB7CgkJY29uc3QgY2hhciogZmlsZTsKCQljb25z
dCBjaGFyKiB2YWw7CgkJYm9vbCBmYXRhbDsKCX0gZmlsZXNbXSA9IHsKCSAgICB7Ii9zeXMva2Vy
bmVsL2RlYnVnL2ZhaWxzbGFiL2lnbm9yZS1nZnAtd2FpdCIsICJOIiwgdHJ1ZX0sCgkgICAgeyIv
c3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX2Z1dGV4L2lnbm9yZS1wcml2YXRlIiwgIk4iLCBmYWxzZX0s
CgkgICAgeyIvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX3BhZ2VfYWxsb2MvaWdub3JlLWdmcC1oaWdo
bWVtIiwgIk4iLCBmYWxzZX0sCgkgICAgeyIvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX3BhZ2VfYWxs
b2MvaWdub3JlLWdmcC13YWl0IiwgIk4iLCBmYWxzZX0sCgkgICAgeyIvc3lzL2tlcm5lbC9kZWJ1
Zy9mYWlsX3BhZ2VfYWxsb2MvbWluLW9yZGVyIiwgIjAiLCBmYWxzZX0sCgl9OwoJdW5zaWduZWQg
aTsKCWZvciAoaSA9IDA7IGkgPCBzaXplb2YoZmlsZXMpIC8gc2l6ZW9mKGZpbGVzWzBdKTsgaSsr
KSB7CgkJaWYgKCF3cml0ZV9maWxlKGZpbGVzW2ldLmZpbGUsIGZpbGVzW2ldLnZhbCkpIHsKCQkJ
aWYgKGZpbGVzW2ldLmZhdGFsKQoJZXhpdCgxKTsKCQl9Cgl9Cn0KCnN0YXRpYyB2b2lkIGV4ZWN1
dGVfb25lKHZvaWQpOwoKI2RlZmluZSBXQUlUX0ZMQUdTIF9fV0FMTAoKc3RhdGljIHZvaWQgbG9v
cCh2b2lkKQp7CglpbnQgaXRlciA9IDA7Cglmb3IgKDs7IGl0ZXIrKykgewoJCWludCBwaWQgPSBm
b3JrKCk7CgkJaWYgKHBpZCA8IDApCglleGl0KDEpOwoJCWlmIChwaWQgPT0gMCkgewoJCQlzZXR1
cF90ZXN0KCk7CgkJCWV4ZWN1dGVfb25lKCk7CgkJCWV4aXQoMCk7CgkJfQoJCWludCBzdGF0dXMg
PSAwOwoJCXVpbnQ2NF90IHN0YXJ0ID0gY3VycmVudF90aW1lX21zKCk7CgkJZm9yICg7OykgewoJ
CQlpZiAod2FpdHBpZCgtMSwgJnN0YXR1cywgV05PSEFORyB8IFdBSVRfRkxBR1MpID09IHBpZCkK
CQkJCWJyZWFrOwoJCQlzbGVlcF9tcygxKTsKCQkJaWYgKGN1cnJlbnRfdGltZV9tcygpIC0gc3Rh
cnQgPCA1MDAwKQoJCQkJY29udGludWU7CgkJCWtpbGxfYW5kX3dhaXQocGlkLCAmc3RhdHVzKTsK
CQkJYnJlYWs7CgkJfQoJfQp9Cgp2b2lkIGV4ZWN1dGVfb25lKHZvaWQpCnsKbWVtY3B5KCh2b2lk
KikweDIwMDAwMDQwLCAiL2Rldi9zcjBcMDAwIiwgOSk7CglpbmplY3RfZmF1bHQoNyk7CglzeXNj
YWxsKF9fTlJfb3BlbmF0LCAweGZmZmZmZmZmZmZmZmZmOWN1bCwgMHgyMDAwMDA0MHVsLCAweDQ4
ODAwdWwsIDB1bCk7Cgp9CmludCBtYWluKHZvaWQpCnsKCQlzeXNjYWxsKF9fTlJfbW1hcCwgMHgx
ZmZmZjAwMHVsLCAweDEwMDB1bCwgMHVsLCAweDMydWwsIC0xLCAwdWwpOwoJc3lzY2FsbChfX05S
X21tYXAsIDB4MjAwMDAwMDB1bCwgMHgxMDAwMDAwdWwsIDd1bCwgMHgzMnVsLCAtMSwgMHVsKTsK
CXN5c2NhbGwoX19OUl9tbWFwLCAweDIxMDAwMDAwdWwsIDB4MTAwMHVsLCAwdWwsIDB4MzJ1bCwg
LTEsIDB1bCk7CglzZXR1cF9mYXVsdCgpOwoJCQlsb29wKCk7CglyZXR1cm4gMDsKfQo=
--000000000000c90e6005f47bd5b6--
