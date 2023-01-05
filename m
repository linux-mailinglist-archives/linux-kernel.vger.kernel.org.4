Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14B765F637
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbjAEVvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbjAEVuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:50:55 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC70F6F962
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:49:28 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso2371381wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 13:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7V/s38fVYJBT93IRpkuecNxxo/ffnzMudvj0xxvClFw=;
        b=Aim8BLlmbnVSiOiHg6D3z6i7vLS8FBRv24LoOFmVfTZVvLG3NbNoaQ/EFcz5TkycL3
         v6ugiBLZPhiDJ8CfKTHAgDW6eOsEMH8XoNuyp2QldxCHfwQSAWepUeVBYAB/PZgtGLjo
         WS0qxDapgGfeAOiA09YcM6DvPCut3uAsf38snEy6QAb/x+3VXCD0L+Q9kM/u5n4H9oW5
         A8BveIU2KXIZm8LniNQp/X221ukd04YMLSNFb3v/+IgZ502zVUT/A0MG2zy9zi52QtTb
         kUF1XxJWmJMvf0zSXOkalucBkcZSl39rRMaNqSF1MMEJgWSUHBRzKuW/1bIOESdlbZM4
         J9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7V/s38fVYJBT93IRpkuecNxxo/ffnzMudvj0xxvClFw=;
        b=Vap3a/4jvUkcdNfXTMGrvczU/VZnxD52xYKCBPy+KsxR+pK4N0dd5CBu/LrNmEzXIa
         3z8npXM0F7znsrBs4fIuinoz3jtQ+comMv/b4NltBcWbamxqUYmfaX15nAIVKV4Sh5JC
         Kmo7JsEW4t1W5BsEL3adK/e0W27Ozh6xIdUIjq9GSzmYeniKgBRnCPvNvO0bSXPrffRa
         CcAyp8trESF9x7EgUK18wXfkYmDHT0fZM6kr8D9X/CTPqxYxEQNpz31tAVEQ3tTNYKxT
         oW8VkOlUTyBiGmKxut9ZTdD6zj2/gOV8coZSVWLhqih02rZLJwe/INh05rVtrAbUCc+W
         WCKg==
X-Gm-Message-State: AFqh2ko1L8YudXfORhgAhqfI7sC3QwFYeP22V0wRfvJWmzYtPBUmeumk
        L2luSD3h9igBXzkpXt6fWoo=
X-Google-Smtp-Source: AMrXdXsoC4NuznOp1MUmwGI5cb/3uFFaxgQW8Ycp7b96iZHeMgdvENE/T6puVobP2soDbBfZsSI8WQ==
X-Received: by 2002:a05:600c:3d8a:b0:3d3:4406:8a37 with SMTP id bi10-20020a05600c3d8a00b003d344068a37mr37798473wmb.41.1672955367264;
        Thu, 05 Jan 2023 13:49:27 -0800 (PST)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id bg41-20020a05600c3ca900b003d1e34bcbb2sm4407251wmb.13.2023.01.05.13.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 13:49:26 -0800 (PST)
From:   Joan Bruguera <joanbrugueram@gmail.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
Subject: Re: [PATCH v3 55/59] x86/bpf: Emit call depth accounting if required
Date:   Thu,  5 Jan 2023 21:49:22 +0000
Message-Id: <20230105214922.250473-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20220915111148.615413406@infradead.org>
References: <20220915111148.615413406@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joan Bruguera Micó <joanbrugueram@gmail.com>

I'm observing a kernel panic on boot on both Arch Linux and Fedora Rawhide,
reproduced on a real Intel i5-7200U (with `retbleed=stuff`), and also AMD 5700G
(with `retbleed=stuff,force`) on both real hw. and QEMU+KVM with `-cpu=host`.

The panic seems to be triggered by systemd attempting to load a BPF program
(see "bpf-lsm: LSM BPF program attached" in the trace below).
Disabling BPF using `lsm=...` fixes the panic and the system boots.

It can be reproduced with Fedora-Cloud-Base-Rawhide-20230105.n.0.x86_64.qcow2
(from https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/Cloud)
launching QEMU with:
    qemu-system-x86_64 -enable-kvm -cpu host -m 1024 -serial stdio -hda \
        Fedora-Cloud-Base-Rawhide-20230105.n.0.x86_64.qcow2
and appending `retbleed=stuff,force` on the GRUB command line.

I'm experimenting with a patch that adjusts `ip` (in `emit_rsb_call`) after
calling `x86_call_depth_emit_accounting` but it needs a bit more testing.

PS: Sorry if this has already been discussed elsewhere, I can't find it
(but it's been a while since this patch was posted and merged)

Sample kernel panic log:

    ...
    :: running hook [keymap]
    :: Loading keymap...kbd_mode: KDSKBMODE: Inappropriate ioctl for device
    done.
    :: performing fsck on '/dev/sda2'
    /dev/sda2: clean, 54442/643376 files, 659509/2568704 blocks
    :: mounting '/dev/sda2' on real root
    [    0.856081] EXT4-fs (sda2): mounted filesystem b11fd1e6-2bc2-43b4-ab2c-09a60647bd0b with ordered data mode. Quota mode: none.
    :: running cleanup hook [udev]
    [    0.937171] systemd[1]: systemd 252.4-2-arch running in system mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 ...
    -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
    [    0.939588] systemd[1]: Detected virtualization kvm.
    [    0.939925] systemd[1]: Detected architecture x86-64.
    
    Welcome to Arch Linux!
    
    [    1.325709] systemd[1]: bpf-lsm: LSM BPF program attached
    [    1.326283] BUG: kernel NULL pointer dereference, address: 000000000000007a
    [    1.326762] #PF: supervisor write access in kernel mode
    [    1.327101] #PF: error_code(0x0002) - not-present page
    [    1.327463] PGD 0 P4D 0 
    [    1.327634] Oops: 0002 [#1] PREEMPT SMP NOPTI
    [    1.327926] CPU: 0 PID: 1 Comm: systemd Not tainted 6.2.0-rc2-1-mainline #1 fe8e69619c49cfdd8b05f798d0c88b25f1808a3f
    [    1.328603] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.1-1-1 04/01/2014
    [    1.329002] RIP: 0010:__bpf_tramp_enter+0xc/0x40
    [    1.329002] Code: ff e9 08 22 ad 00 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 53 48 89 fb e8 59 04 ee <ff> 48 8b 83 60 02 00 00 a8 03 75 0a 65 48 ...
    ff 00 5b e9 4e 4d ee ff
    [    1.329002] RSP: 0018:ffff9cbe00013b88 EFLAGS: 00010282
    [    1.329002] RAX: 00000000000000ef RBX: ffffffffa9cdad88 RCX: 0000000500000000
    [    1.329002] RDX: 0000000000000000 RSI: 0000000000000064 RDI: ffff8ba14121b800
    [    1.329002] RBP: ffff9cbe00013bc0 R08: ffff8ba1439a6ca0 R09: ffff8ba140429a40
    [    1.329002] R10: 0000000000000000 R11: 0000000000000002 R12: ffff9cbe00013cc0
    [    1.329002] R13: 0000000000000000 R14: ffff8ba142157f10 R15: ffff8ba142157f00
    [    1.329002] FS:  00007f39b636da40(0000) GS:ffff8ba277a00000(0000) knlGS:0000000000000000
    [    1.329002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [    1.329002] CR2: 000000000000007a CR3: 0000000104d20000 CR4: 0000000000750ef0
    [    1.329002] PKRU: 55555554
    [    1.329002] Call Trace:
    [    1.329002]  <TASK>
    [    1.329002]  ? bpf_trampoline_6442538647_0+0x3d/0x1000
    [    1.329002]  ? bpf_lsm_file_open+0x9/0x10
    [    1.329002]  ? security_file_open+0x30/0x50
    [    1.329002]  ? do_dentry_open+0xf8/0x460
    [    1.329002]  ? path_openat+0xd8f/0x1260
    [    1.329002]  ? inode_permission+0x3d/0x1e0
    [    1.329002]  ? __pfx_bpf_lsm_inode_permission+0x10/0x10
    [    1.329002]  ? security_inode_permission+0x3e/0x60
    [    1.329002]  ? do_filp_open+0xb3/0x160
    [    1.329002]  ? do_sys_openat2+0xaf/0x170
    [    1.329002]  ? __x64_sys_openat+0x6e/0xa0
    [    1.329002]  ? do_syscall_64+0x5f/0x90
    [    1.329002]  ? kmem_cache_free+0x19/0x360
    [    1.329002]  ? do_mkdirat+0xed/0x180
    [    1.329002]  ? __x86_return_skl+0x71/0x88
    [    1.329002]  ? __x86_return_skl+0x6b/0x88
    [    1.329002]  ? __x86_return_skl+0x65/0x88
    [    1.329002]  ? __x86_return_skl+0x5f/0x88
    [    1.329002]  ? __x86_return_skl+0x59/0x88
    [    1.329002]  ? __x86_return_skl+0x53/0x88
    [    1.329002]  ? __x86_return_skl+0x4d/0x88
    [    1.329002]  ? __x86_return_skl+0x47/0x88
    [    1.329002]  ? __x86_return_skl+0x41/0x88
    [    1.329002]  ? __x86_return_skl+0x3b/0x88
    [    1.329002]  ? __x86_return_skl+0x35/0x88
    [    1.329002]  ? __x86_return_skl+0x2f/0x88
    [    1.329002]  ? __x86_return_skl+0x29/0x88
    [    1.329002]  ? __x86_return_skl+0x23/0x88
    [    1.329002]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
    [    1.329002]  </TASK>
    [    1.329002] Modules linked in: bpf_preload qemu_fw_cfg ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 virtio_net virtio_gpu ata_generic serio_raw net_failover virtio_dma_buf ...
    virtio_rng failover pata_acpi atkbd libps2 vivaldi_fmap virtio_pci i8042 virtio_pci_legacy_dev crc32c_intel floppy serio ata_piix virtio_pci_modern_dev
    [    1.329002] CR2: 000000000000007a
    [    1.329002] ---[ end trace 0000000000000000 ]---
    [    1.329002] RIP: 0010:__bpf_tramp_enter+0xc/0x40
    [    1.329002] Code: ff e9 08 22 ad 00 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 53 48 89 fb e8 59 04 ee <ff> 48 8b 83 60 02 00 00 a8 03 75 0a 65 48...
    ff 00 5b e9 4e 4d ee ff
    [    1.329002] RSP: 0018:ffff9cbe00013b88 EFLAGS: 00010282
    [    1.329002] RAX: 00000000000000ef RBX: ffffffffa9cdad88 RCX: 0000000500000000
    [    1.329002] RDX: 0000000000000000 RSI: 0000000000000064 RDI: ffff8ba14121b800
    [    1.329002] RBP: ffff9cbe00013bc0 R08: ffff8ba1439a6ca0 R09: ffff8ba140429a40
    [    1.329002] R10: 0000000000000000 R11: 0000000000000002 R12: ffff9cbe00013cc0
    [    1.329002] R13: 0000000000000000 R14: ffff8ba142157f10 R15: ffff8ba142157f00
    [    1.329002] FS:  00007f39b636da40(0000) GS:ffff8ba277a00000(0000) knlGS:0000000000000000
    [    1.329002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [    1.329002] CR2: 000000000000007a CR3: 0000000104d20000 CR4: 0000000000750ef0
    [    1.329002] PKRU: 55555554
    [    1.352911] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
    [    1.353529] Kernel Offset: 0x27600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
    [    1.354255] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---
