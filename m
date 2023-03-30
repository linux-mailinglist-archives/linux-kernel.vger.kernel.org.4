Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738806D127C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjC3Wq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjC3Wqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:46:44 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F413A18497;
        Thu, 30 Mar 2023 15:46:11 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id h15so17684883vsh.0;
        Thu, 30 Mar 2023 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680216370;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4EQSMQs5GAUSHzo+hKN5Bk3dJVN6YWS21XRsOUj0x+w=;
        b=nh28FL2qHIqiboX9rLnHjQQQAlv484JpH9ACfhTVosb05+8yjV5LJDAJpA+of5gqrg
         SJ8fFOW2ZuaNuB0+qNIARmjSEWkmTrRDu9YxSLopwyJnIlW3gTj/ZZdQve+xEDqwyf5m
         gJkhvrXnE+UatJXGty4j+b/zEC01+ADh+bjvTgmwu/RlbdDM0XTOY6bvan31LT8uGjOE
         hbc4CV7jsXdYcMB3Gue8jNklOY2AEjntRg9we2cxW7yhopD3jd/VBfPHum7n/RP7HtAd
         iwppxh3rRiv1131olF2milFcXQq5ptnA6ca/zGjAWnepoLZlYQETm/PY3DG6gpVijBvD
         hzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680216370;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4EQSMQs5GAUSHzo+hKN5Bk3dJVN6YWS21XRsOUj0x+w=;
        b=A7qCdZNYwZcRc3ENTXZ+VnyFMI3Ygl9LDx/TQykg8VfdpTm2CozUCwCF38BhzMcPDL
         cz8DSZd6jAyLWXigwKi+j9zymXL38KCaCJygORBBtqoKfd2vYyxxArUtIo1bphKQZLdV
         VEe2CHXs6e7efsV3k/S5iDcLVJ47RF9NXpNcPrT8Z88JifoO1lwaMDGaKbxgmWuKmgur
         DurlYEfW7YriLLVYO1E7Iz1xyXE8NBje/B7IpcRnqVWdisRNiCcHR43XoJhOQ0XYWHhq
         aRc9a/0633ZSzAR/8HM2BvBpX0Op7dNubgGBWyXYxtKvqpGcmIBVk4/FxpXY/vI9VcJF
         +Wgw==
X-Gm-Message-State: AAQBX9df0X1IhPXTQmLtIaCvaS3+w8hcartQ4nZV2PpzP9IgfMac/SP1
        RLA0NewiXgh25yVcpI0hedSLCB2lVXv52XX2xBg=
X-Google-Smtp-Source: AKy350ZNvBnnpcdcvbix66uxlX53AEvGhtPQavOgxlBpbqhGRnxmOdwEvIkB8JOy1dCLh5rYMA/esqvpHXVPn9Xtv2A=
X-Received: by 2002:a67:d88e:0:b0:426:3a3d:180b with SMTP id
 f14-20020a67d88e000000b004263a3d180bmr13165011vsj.5.1680216369880; Thu, 30
 Mar 2023 15:46:09 -0700 (PDT)
MIME-Version: 1.0
From:   jim.cromie@gmail.com
Date:   Thu, 30 Mar 2023 16:45:43 -0600
Message-ID: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
Subject: kmemleaks on ac3b43283923 ("module: replace module_layout with module_memory")
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, song@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Luis, etal

kmemleak is reporting 19 leaks during boot

because the hexdumps appeared to have module-names,
and Ive been hacking nearby, and see the same names
every time I boot my test-vm, I needed a clearer picture
Jason corroborated and bisected.

the 19 leaks split into 2 groups,
9 with names of builtin modules in the hexdump,
all with the same backtrace
9 without module-names (with a shared backtrace)
+1 wo name-ish and a separate backtrace


bash-5.2# ./grok_kmemleak -n
this prints not-module-name set 1st, then the "module"-ish

not: bless( {
  'backtraces' => {
    '[<0000000003a4e200>] __kmalloc_node_track_caller+0x44/0xb0
    [<0000000072a38f0a>] memdup_user+0x26/0x90
    [<000000005669249f>] strndup_user+0x47/0x70
    [<00000000a8de6ea1>] load_module+0x9d5/0x10b0
    [<000000000132739b>] __do_sys_finit_module+0xe4/0x160
    [<000000005ac0591a>] do_syscall_64+0x34/0x80
    [<0000000078e9b61a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0' => 9,
    '[<00000000f9318e0d>] kmalloc_trace+0x26/0x60
    [<0000000056fc149d>] ref_module+0xd6/0x200
    [<0000000059adcd74>] resolve_symbol+0x2ae/0x320
    [<000000006a75da8e>] simplify_symbols+0x1ae/0x5a0
    [<0000000061d9061a>] load_module+0x529/0x10b0
    [<000000000132739b>] __do_sys_finit_module+0xe4/0x160
    [<000000005ac0591a>] do_syscall_64+0x34/0x80
    [<0000000078e9b61a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0' => 1
  },
  'hexdumps' => {
    '00 19 b2 fc 00 c8 52 8a                          ......R.' => 1,
    '00 42 7d fc 00 07 09 a2                          .B}.....' => 1,
    '00 42 ba fc 00 c0 0f 6a                          .B.....j' => 1,
    '00 43 48 fc 00 32 0c 8a                          .CH..2..' => 1,
    '00 44 48 fc 00 32 05 92                          .DH..2..' => 1,
    '00 4f 7d fc 00 07 0c 42                          .O}....B' => 1,
    '00 61 a7 fc 00 dd 2d 52                          .a....-R' => 1,
    '00 62 a7 fc 00 dd 29 f2                          .b....).' => 1,
    '00 69 a7 fc 00 dd 2a 62                          .i....*b' => 1,
    '38 86 25 c0 ff ff ff ff 38 86 25 c0 ff ff ff ff  8.%.....8.%.....' => 1
  },
  'users' => {
    'comm "(udev-worker)", pid 218,' => 1,
    'comm "(udev-worker)", pid 219,' => 2,
    'comm "(udev-worker)", pid 225,' => 1,
    'comm "(udev-worker)", pid 226,' => 1,
    'comm "(udev-worker)", pid 229,' => 5
  }
}, 'LeakSet' )
mods: bless( {
  'backtraces' => {
    '[<0000000003a4e200>] __kmalloc_node_track_caller+0x44/0xb0
    [<00000000a39d2d44>] kstrdup+0x30/0x60
    [<000000003584675a>] kobject_set_name_vargs+0x2d/0xb0
    [<00000000fd79ba60>] kobject_init_and_add+0x9d/0x100
    [<00000000b107c417>] mod_sysfs_setup+0xf8/0x3c0
    [<0000000082c80748>] load_module+0xf16/0x10b0
    [<000000000132739b>] __do_sys_finit_module+0xe4/0x160
    [<000000005ac0591a>] do_syscall_64+0x34/0x80
    [<0000000078e9b61a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0' => 9
  },
  'hexdumps' => {
    '63 72 63 33 32 5f 70 63 6c 6d 75 6c 00 ca 32 3f  crc32_pclmul..2?' => 1,
    '63 72 63 33 32 63 5f 69 6e 74 65 6c 00 dd 01 bf  crc32c_intel....' => 1,
    '63 72 63 74 31 30 64 69 66 5f 70 63 6c 6d 75 6c  crct10dif_pclmul' => 1,
    '67 68 61 73 68 5f 63 6c 6d 75 6c 6e 69 5f 69 6e  ghash_clmulni_in' => 1,
    '69 32 63 5f 70 69 69 78 34 00 77 85 96 39 f4 3f  i2c_piix4.w..9.?' => 1,
    '69 6e 74 65 6c 5f 72 61 70 6c 5f 63 6f 6d 6d 6f  intel_rapl_commo' => 1,
    '69 6e 74 65 6c 5f 72 61 70 6c 5f 6d 73 72 00 9f  intel_rapl_msr..' => 1,
    '70 63 73 70 6b 72 00 72                          pcspkr.r' => 1,
    '73 65 72 69 6f 5f 72 61 77 00 c9 84 97 87 cb 3f  serio_raw......?' => 1
  },
  'users' => {
    'comm "(udev-worker)", pid 218,' => 1,
    'comm "(udev-worker)", pid 219,' => 1,
    'comm "(udev-worker)", pid 225,' => 1,
    'comm "(udev-worker)", pid 226,' => 1,
    'comm "(udev-worker)", pid 229,' => 5
  }
}, 'LeakSet' )


After a batch of modprobe, rmmod cycles on drm,
I got more leaks.
They have same backtrace as the original set
only the user has changed, to "modprobe"

:#> [98442.905272] kmemleak: 14 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
./grok_kmemleak -n
not: bless( {
  'backtraces' => {
    '[<0000000003a4e200>] __kmalloc_node_track_caller+0x44/0xb0
    [<0000000072a38f0a>] memdup_user+0x26/0x90
    [<000000005669249f>] strndup_user+0x47/0x70
    [<00000000a8de6ea1>] load_module+0x9d5/0x10b0
    [<000000000132739b>] __do_sys_finit_module+0xe4/0x160
    [<000000005ac0591a>] do_syscall_64+0x34/0x80
    [<0000000078e9b61a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0' => 15,
    '[<00000000f9318e0d>] kmalloc_trace+0x26/0x60
    [<0000000056fc149d>] ref_module+0xd6/0x200
    [<0000000059adcd74>] resolve_symbol+0x2ae/0x320
    [<000000006a75da8e>] simplify_symbols+0x1ae/0x5a0
    [<0000000061d9061a>] load_module+0x529/0x10b0
    [<000000000132739b>] __do_sys_finit_module+0xe4/0x160
    [<000000005ac0591a>] do_syscall_64+0x34/0x80
    [<0000000078e9b61a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0' => 2
  },
  'hexdumps' => {
    '00 19 b2 fc 00 c8 52 8a                          ......R.' => 1,
    '00 2d 0d f8 04 77 62 a2                          .-...wb.' => 1,
    '00 3f 4e fd 01 34 7a aa                          .?N..4z.' => 1,
    '00 41 48 fc 00 32 03 9a                          .AH..2..' => 1,
    '00 42 7d fc 00 07 09 a2                          .B}.....' => 1,
    '00 42 ba fc 00 c0 0f 6a                          .B.....j' => 1,
    '00 43 48 fc 00 32 0c 8a                          .CH..2..' => 1,
    '00 44 48 fc 00 32 05 92                          .DH..2..' => 1,
    '00 4e ba fc 00 c0 06 b2                          .N......' => 1,
    '00 4f 7d fc 00 07 0c 42                          .O}....B' => 1,
    '00 61 a7 fc 00 dd 2d 52                          .a....-R' => 1,
    '00 62 a7 fc 00 dd 29 f2                          .b....).' => 1,
    '00 69 a7 fc 00 dd 2a 62                          .i....*b' => 1,
    '00 e8 f4 fc 00 8e aa 4a                          .......J' => 1,
    '00 ee f4 fc 00 8e aa 62                          .......b' => 1,
    '38 86 25 c0 ff ff ff ff 38 86 25 c0 ff ff ff ff  8.%.....8.%.....' => 1,
    '80 70 0c 08 80 88 ff ff 38 7a 42 c0 ff ff ff ff  .p......8zB.....' => 1
  },
  'users' => {
    'comm "(udev-worker)", pid 218,' => 1,
    'comm "(udev-worker)", pid 219,' => 2,
    'comm "(udev-worker)", pid 225,' => 1,
    'comm "(udev-worker)", pid 226,' => 1,
    'comm "(udev-worker)", pid 229,' => 5,
    'comm "modprobe", pid 673,' => 1,
    'comm "modprobe", pid 683,' => 3,
    'comm "modprobe", pid 690,' => 1,
    'comm "modprobe", pid 693,' => 2
  }
}, 'LeakSet' )
mods: bless( {
  'backtraces' => {
    '[<0000000003a4e200>] __kmalloc_node_track_caller+0x44/0xb0
    [<00000000a39d2d44>] kstrdup+0x30/0x60
    [<000000003584675a>] kobject_set_name_vargs+0x2d/0xb0
    [<00000000fd79ba60>] kobject_init_and_add+0x9d/0x100
    [<00000000b107c417>] mod_sysfs_setup+0xf8/0x3c0
    [<0000000082c80748>] load_module+0xf16/0x10b0
    [<000000000132739b>] __do_sys_finit_module+0xe4/0x160
    [<000000005ac0591a>] do_syscall_64+0x34/0x80
    [<0000000078e9b61a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0' => 15,
    '[<00000000f9318e0d>] kmalloc_trace+0x26/0x60
    [<0000000056fc149d>] ref_module+0xd6/0x200
    [<0000000059adcd74>] resolve_symbol+0x2ae/0x320
    [<000000006a75da8e>] simplify_symbols+0x1ae/0x5a0
    [<0000000061d9061a>] load_module+0x529/0x10b0
    [<000000000132739b>] __do_sys_finit_module+0xe4/0x160
    [<000000005ac0591a>] do_syscall_64+0x34/0x80
    [<0000000078e9b61a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0' => 1
  },
  'hexdumps' => {
    '38 7a 42 c0 ff ff ff ff 80 97 bf 09 80 88 ff ff  8zB.............' => 1,
    '63 65 63 00 04 77 6a c2                          cec..wj.' => 1,
    '63 72 63 33 32 5f 70 63 6c 6d 75 6c 00 ca 32 3f  crc32_pclmul..2?' => 1,
    '63 72 63 33 32 63 5f 69 6e 74 65 6c 00 dd 01 bf  crc32c_intel....' => 1,
    '63 72 63 74 31 30 64 69 66 5f 70 63 6c 6d 75 6c  crct10dif_pclmul' => 1,
    '67 68 61 73 68 5f 63 6c 6d 75 6c 6e 69 5f 69 6e  ghash_clmulni_in' => 1,
    '69 32 63 5f 61 6c 67 6f 5f 62 69 74 00 f2 db 3f  i2c_algo_bit...?' => 1,
    '69 32 63 5f 70 69 69 78 34 00 77 85 96 39 f4 3f  i2c_piix4.w..9.?' => 1,
    '69 6e 74 65 6c 5f 72 61 70 6c 5f 63 6f 6d 6d 6f  intel_rapl_commo' => 1,
    '69 6e 74 65 6c 5f 72 61 70 6c 5f 6d 73 72 00 9f  intel_rapl_msr..' => 1,
    '69 6f 6d 6d 75 5f 76 32 00 ae da 84 97 94 b1 5f  iommu_v2......._' => 1,
    '6d 78 6d 5f 77 6d 69 00                          mxm_wmi.' => 1,
    '70 63 73 70 6b 72 00 72                          pcspkr.r' => 1,
    '73 65 72 69 6f 5f 72 61 77 00 c9 84 97 87 cb 3f  serio_raw......?' => 1,
    '76 69 64 65 6f 00 ae 82                          video...' => 1,
    '77 6d 69 00 00 c0 06 52                          wmi....R' => 1
  },
  'users' => {
    'comm "(udev-worker)", pid 218,' => 1,
    'comm "(udev-worker)", pid 219,' => 1,
    'comm "(udev-worker)", pid 225,' => 1,
    'comm "(udev-worker)", pid 226,' => 1,
    'comm "(udev-worker)", pid 229,' => 5,
    'comm "modprobe", pid 673,' => 1,
    'comm "modprobe", pid 683,' => 4,
    'comm "modprobe", pid 690,' => 1,
    'comm "modprobe", pid 693,' => 1
  }
}, 'LeakSet' )
:#>

I hope all this helps to sort out what the kmemleak is,
let me know how I can help further

Jim
