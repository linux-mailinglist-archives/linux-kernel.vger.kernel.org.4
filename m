Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A986486A7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiLIQkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLIQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:40:48 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A34D86F7C;
        Fri,  9 Dec 2022 08:40:42 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 28E58200D78;
        Fri,  9 Dec 2022 16:40:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 8775D200D15;
        Fri,  9 Dec 2022 16:40:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670604040; a=rsa-sha256;
        cv=none;
        b=5KbLf/EBq3w52y12Z7XVtBqNs8YsEde4weVTtlmE4M88XGX0cl44saGZB5AJINNv/BDFRn
        9dV/oJlKifz1NQI4tcJYoe4aJvBIwKccfrX0peFcD5SmzXp7EuvQIIXY5blXgmscIvr2x6
        fdJWmyFXmu5UMv0LxUrNclKkTTeqgu0hOvltqDutj/MRnSU5OIyMVJvbw9X/WvJFtgDses
        iIRuPP5ehYFNrZ6yuDFi4iiY1F97nPSKLs8jNhasVJsYCW6gMGlfFWjjOEpgnmvIQ9HHMQ
        t2IdcmykoX08QyzE0MbKkjHTyrchywz0N5lhaUL7JRpkgvxlV6h8Bzf9CK2Q3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670604040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ZZY0SRPYTTcbUs02/UOaW9OEZ8kvhOaDT4X+CAXzZA0=;
        b=TP75hlQlNySjtFFZdAf4HwRCG4xUVr0RW8RtgdkqszwdZIf8cYlQqIyc7Wq6YXi8oNZu3I
        j7kJStHriBxmwNQZENw3b0avmk3igKwxjyq5yKBEMuC5XzkG3UaxEITHiuahGpjfsCm868
        4YVcwXgndXlDYHtS+ExCO+WuZgGsiupA2a14xWPktosPiTSnS9S3s+ZheXGmt3pjLYlzRj
        jRPVgLgG2OOloM/18DQ8RM+O6VVvxrZOS4WeWh5t2PVtXmVps0IdrLseZbYIdLJkUCgxXF
        g3e7Yvi2vR6lienXO4SVD/hxBG5/Te7l63Y/0ytA2wmjJAumEY3STUtgmWcH3A==
ARC-Authentication-Results: i=1;
        rspamd-85f95c7974-8lndr;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Reaction: 4a0b451e3e36a2d4_1670604040879_713008605
X-MC-Loop-Signature: 1670604040879:17422609
X-MC-Ingress-Time: 1670604040878
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.229.8 (trex/6.7.1);
        Fri, 09 Dec 2022 16:40:40 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4NTGwl4ZqTz3b;
        Fri,  9 Dec 2022 08:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670604040;
        bh=ZZY0SRPYTTcbUs02/UOaW9OEZ8kvhOaDT4X+CAXzZA0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=hhYfFyjzcgQRkIUFZgsDjYoig5qhaqMKDnOxOdOF/PwzcSkH9Zf+NHsYhKTfAqbJo
         oK8Zqxt3OGcrhvJ8xVgRJl2Lh03X+ltQELkX1Po+nuwEa7GL/Wos9hAg+RCxek3mJU
         LyD5r3W1yQm73H/+b5yND771KJBE139F20P9RTvAFxu/mmVLSyu6s/KL6KVIK5S9SU
         ASA6u/Qpfm9+KpIEO58wWPaJTqnjOyzD6tcI2//9BshkjZpgZ2m8F357JTW4VzeCqg
         azjDLqTcxTJfCTEmqG58bmFUJrqqDIsCfnmDiFySIq2XBnrnfOi3OeV1inlSCLvJ+L
         xkQXkUi1YjxlQ==
Date:   Fri, 9 Dec 2022 08:16:28 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: fix null dereference on probe for missing
 ACPI_COMPANION()
Message-ID: <20221209161628.ln4cqj3rgtvwcnqe@offworld>
References: <20221209062919.1096779-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221209062919.1096779-1-mcgrof@kernel.org>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Dec 2022, Luis Chamberlain wrote:

>Simply loading cxl_test ends up triggering a null pointer dereference
>on next-20221207, and it happens because the fetched ACPI_COMPANION() can
>end up not correct / missing. As with other code which uses ACPI_COMPANION()
>(drivers/acpi/device_pm.c comes to mind) be defensive over the assumption
>the companion is always present and bail right away.
>
>This can be easily reproduced with kdevops [0] with linux next-20221207 [1]
>and cxl enabled workflows:
>
>make menuconfig      # enable cxl and linux-next
>make                 # sets up variables, builds qemu from source
>make linux           # builds and install next-20221207
>make cxl             # installs cxl tool
>make cxl-test-probe  # loads cxl_test
>
>The oops:
>
> # modprobe cxl_test
>No TPM handle discovered.
>failed to open file /etc/ndctl/keys/nvdimm-master.blob: No such file or directory
>
>[0] https://github.com/linux-kdevops/kdevops
>[1] https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/bootlinux/templates/config-next-20221207
>
>cxl_mock: loading out-of-tree module taints kernel.
>cxl_mock: loading test module taints kernel.
>cxl_mem mem0: at cxl_root_port.0 no parent for dport: platform
>cxl_mem mem1: at cxl_root_port.1 no parent for dport: platform
>cxl_mem mem2: at cxl_root_port.2 no parent for dport: platform
>cxl_mem mem3: at cxl_root_port.3 no parent for dport: platform
>cxl_mem mem4: at cxl_root_port.0 no parent for dport: platform
>cxl_mem mem5: at cxl_root_port.1 no parent for dport: platform
>cxl_mem mem6: at cxl_root_port.2 no parent for dport: platform
>cxl_mem mem7: at cxl_root_port.3 no parent for dport: platform
>cxl_mem mem8: at cxl_root_port.4 no parent for dport: platform
>cxl_mem mem9: at cxl_root_port.4 no parent for dport: platform
>cxl_mem mem10: CXL port topology not found
>BUG: kernel NULL pointer dereference, address: 00000000000002c0
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
>PGD 0 P4D 0
>Oops: 0000 [#1] PREEMPT SMP PTI
>CPU: 4 PID: 1644 Comm: systemd-udevd Kdump: loaded Tainted: G           O     N 6.1.0-rc8-next-20221207 #5
>Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
>RIP: 0010:cxl_acpi_probe+0xeb/0x2f0 [cxl_acpi]
>Code: ff ff ff 48 c7 40 08 ff ff ff ff 48 c7 40 18 00 02 00 00 e8 57 29 fd ff 49 89 c7 41 89 c4 48 3d 00 f0 ff ff 0f 87 73 ff ff ff <49> 8b bd c0 02 00 00 48 c7 c1 c0 64 e4 c0 48 89 c2 31 f6 e8 bd f1
>RSP: 0018:ffffbe6d008b7c30 EFLAGS: 00010287
>RAX: ffff97a7c6e01000 RBX: ffff97a7c51fd810 RCX: 0000000000000000
>RDX: 0000000000000001 RSI: 0000000000000282 RDI: 00000000ffffffff
>RBP: 0000000000000000 R08: ffff97a7c51fdaa8 R09: 0000000000000010
>R10: 0000000000000002 R11: 00000000000013c7 R12: 00000000c6e01000
>R13: 0000000000000000 R14: ffff97a7d9c653a8 R15: ffff97a7c6e01000
>FS:  00007f34b038ed00(0000) GS:ffff97a83bd00000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 00000000000002c0 CR3: 0000000102f7e005 CR4: 0000000000770ee0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>PKRU: 55555554
>Call Trace:
> <TASK>
> ? kernfs_create_link+0x5d/0xa0
> platform_probe+0x41/0x90
> really_probe+0xdb/0x380
> ? pm_runtime_barrier+0x50/0x90
> __driver_probe_device+0x78/0x170
> driver_probe_device+0x1f/0x90
> __driver_attach+0xce/0x1c0
> ? __pfx___driver_attach+0x10/0x10
> bus_for_each_dev+0x73/0xc0
> bus_add_driver+0x1ae/0x200
> driver_register+0x89/0xe0
> ? __pfx_init_module+0x10/0x10 [cxl_acpi]
> do_one_initcall+0x43/0x220
> ? kmalloc_trace+0x26/0x90
> do_init_module+0x4a/0x1f0
> __do_sys_init_module+0x17f/0x1b0
> do_syscall_64+0x37/0x90
> entry_SYSCALL_64_after_hwframe+0x72/0xdc
>RIP: 0033:0x7f34b061baaa
>Code: 48 8b 0d 59 83 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 26 83 0c 00 f7 d8 64 89 01 48
>RSP: 002b:00007fff6a198408 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
>RAX: ffffffffffffffda RBX: 00005635afc7e5e0 RCX: 00007f34b061baaa
>RDX: 00007f34b07a5efd RSI: 0000000000060a29 RDI: 00005635afdd6510
>RBP: 00007f34b07a5efd R08: 000000000001f5b3 R09: 0000000000000000
>R10: 000000000000eb81 R11: 0000000000000246 R12: 00005635afdd6510
>R13: 0000000000000000 R14: 00005635afca6f40 R15: 00005635af874e50
> </TASK>
>Modules linked in: cxl_acpi(+) cxl_pmem cxl_mem cxl_port cxl_mock_mem(ON) cxl_test(ON) cxl_mock(ON) cxl_core libnvdimm cbc encrypted_keys kvm_intel kvm 9p netfs irqbypass crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 sha512_generic aesni_intel crypto_simd cryptd cirrus drm_shmem_helper 9pnet_virtio virtio_balloon i6300esb drm_kms_helper joydev evdev button serio_raw drm configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 md_mod virtio_net net_failover virtio_blk failover psmouse virtio_pci virtio_pci_legacy_dev nvme virtio_pci_modern_dev crc32_pclmul nvme_core virtio crc32c_intel t10_pi virtio_ring crc64_rocksoft crc64
>
>And gdb:
>
>(gdb) l *(cxl_acpi_probe+0xeb)
>0xa8b is in cxl_acpi_probe (tools/testing/cxl/../../../drivers/cxl/acpi.c:648).
>643
>644             root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
>645             if (IS_ERR(root_port))
>646                     return PTR_ERR(root_port);
>647
>648             rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
>649                                   add_host_bridge_dport);
>650             if (rc < 0)
>651                     return rc;
>652
>
>Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
