Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDC06A599C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjB1NAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjB1NAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:00:11 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807841CAC7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:00:09 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 73F3061CC40F9;
        Tue, 28 Feb 2023 14:00:06 +0100 (CET)
Message-ID: <af9723a2-a077-5fde-97d0-3c6ce216287a@molgen.mpg.de>
Date:   Tue, 28 Feb 2023 14:00:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Hirofumi Ogawa <hirofumi@mail.parknet.co.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Long mount time of ESP FAT partition
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


On a Dell Precision 3540 with Debian sid/unstable, Linux 6.1.12 takes 
1.5 seconds to mount the 128 MB FAT partition `/dev/nvme0n1p1` to 
`/boot/efi`.

```
$ lsblk --fs
NAME                FSTYPE      FSVER LABEL UUID 
         FSAVAIL FSUSE% MOUNTPOINTS
nvme0n1 

├─nvme0n1p1         vfat        FAT32 ESP   381C-FF6C 
           49.2M    61% /boot/efi
├─nvme0n1p2         crypto_LUKS 2 
b88be798-13e3-4884-9748-bf7a23f0ae87
│ └─nvme0n1p2_crypt ext4        1.0 
c9342a55-b747-4442-b2f4-bc03eb7a51cf    733G    17% /
└─nvme0n1p3         ext4        1.0   boot 
16743b63-5a4f-404e-a46e-2db5add63980  303.6M    10% /boot
$ more /etc/fstab
[…]
/dev/disk/by-uuid/c9342a55-b747-4442-b2f4-bc03eb7a51cf /  auto 
defaults,errors=remount-ro 0   1
/dev/disk/by-uuid/16743b63-5a4f-404e-a46e-2db5add63980 /boot  auto 
defaults,errors=remount-ro      0       1
UUID=381C-FF6C  /boot/efi       vfat    umask=0022      0       1
$ journalctl -b -u boot.mount -o short-precise
Feb 28 11:19:14.006616 morley systemd[1]: Mounting boot.mount - /boot...
Feb 28 11:19:14.013246 morley systemd[1]: Mounted boot.mount - /boot.
$ journalctl -b -u boot-efi.mount -o short-precise
Feb 28 11:19:14.014469 morley systemd[1]: Mounting boot-efi.mount - 
/boot/efi...
Feb 28 11:19:15.550770 morley systemd[1]: Mounted boot-efi.mount - 
/boot/efi.
```

On a Dell Latitude E7250 mounting a 128 MB FAT partition `/dev/sda1` 
(SAMSUNG SSD PM851 mSATA 256GB) only takes 90 ms.

```
$ journalctl -u boot-efi.mount -o short-monotonic -b
[   10.693263] ersatz systemd[1]: Mounting boot-efi.mount - /boot/efi...
[   10.783176] ersatz systemd[1]: Mounted boot-efi.mount - /boot/efi.
```


Kind regards,

Paul
