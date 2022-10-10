Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682DD5FA072
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJJOs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJJOsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:48:16 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C873910;
        Mon, 10 Oct 2022 07:48:06 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id h15so2453806qtu.2;
        Mon, 10 Oct 2022 07:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpl+HJx24mQV8eDUHSlRaOdy3oKyBT3ownyekipI6Vs=;
        b=zXnnmtyshe4ExxvhTMMUWrjECfa4bRwHvpcvp/1PFvtJ4qzfNlKaSYobA0yQjehBU0
         pkh8tl3mHJzhed83kRR7wOBN4SEY1u6dvcaBvCfvL+3bcM72JhfaXWaDpe8Lv8t3R0Mp
         RfjbqpzzNob5XMAwnKNUrAvBQjHcdqtaeCmDOEZnGwaSOyP0RvjS4VItIvvdLdZ4eJdR
         QYPNYq/+q75cUtuc7uXIU3Uz5Xt6Jc54Y1BFviNmG9c7UniOXXGqkkOdDQsbAy22i9nm
         BG8rDTHpBHRc35tUcRwnBvTTDRlOy+YIRqA2gkcIAp+3h/iYhquYBIgkXQmhunl+R20c
         W3qQ==
X-Gm-Message-State: ACrzQf02ZZ/Zmd2hotFonSl6ijvAFhPF46LvwO2Ys+3I+NUiequS5Ven
        PQReBst3M+BqkFkxN+k/zYGZU4sDLFNMmvu4bZmpoJUx
X-Google-Smtp-Source: AMsMyM4ZtvYFvkgScpyA70y2xt4xu7wifJ2vFmW1ZEkt/oe1u8zQ26DZnPalvGbmWy1jo7qEA65Krfrb1dHxefqHzCs=
X-Received: by 2002:a05:622a:11c8:b0:35c:e912:a8ea with SMTP id
 n8-20020a05622a11c800b0035ce912a8eamr15305962qtk.17.1665413285505; Mon, 10
 Oct 2022 07:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221010141630.zfzi7mk7zvnmclzy@techsingularity.net>
In-Reply-To: <20221010141630.zfzi7mk7zvnmclzy@techsingularity.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Oct 2022 16:47:50 +0200
Message-ID: <CAJZ5v0j9JyDZupNnQUsTUVv0WapGjK7b5S-4ewZ8-b=HOret2Q@mail.gmail.com>
Subject: Re: Intermittent boot failure after 6492fed7d8c9 (v6.0-rc1)
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-rtc@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000049adbd05eaaf3f1a"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000049adbd05eaaf3f1a
Content-Type: text/plain; charset="UTF-8"

Hi Mel,

Thanks for the report!

On Mon, Oct 10, 2022 at 4:25 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> Hi Rafael,
>
> I'm seeing intermittent boot failures after 6492fed7d8c9 ("rtc: rtc-cmos:
> Do not check ACPI_FADT_LOW_POWER_S0") due to a NULL pointer exception
> early in boot. It fails to boot 5 times after 10 boot attempts and I've
> only observed it on one machine so far. Either a revert or the patch below
> fixes it but it's unlikely it is the correct fix.
>
> --- drivers/rtc/rtc-cmos.c.orig 2022-10-10 15:11:50.335756567 +0200
> +++ drivers/rtc/rtc-cmos.c      2022-10-10 15:11:53.211756691 +0200
> @@ -1209,7 +1209,7 @@
>          * Or else, ACPI SCI is enabled during suspend/resume only,
>          * update rtc irq in that case.
>          */
> -       if (cmos_use_acpi_alarm())
> +       if (cmos_use_acpi_alarm() && cmos)
>                 cmos_interrupt(0, (void *)cmos->rtc);
>         else {
>                 /* Fix me: can we use cmos_interrupt() here as well? */

It looks like I've exposed a race condition there.

Generally speaking, it is misguided to install an event handler that
is not ready to handle the event at that time before making sure that
the event is disabled.

Does the attached patch help?

>
> Boot failure looks like the below, it's not a vanilla kernel but the
> applied patch is not relevant and it's known to fail on a vanilla kernel.
> The machine has a E5-2698 v4 CPU plugged into a SGI C2112-4GP3 platform
> with a X10DRT-P-Series motherboard.
>
> [   10.924167][    C1] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   10.928016][    C1] #PF: supervisor read access in kernel mode
> [   10.928016][    C1] #PF: error_code(0x0000) - not-present page
> [   10.928016][    C1] PGD 0 P4D 0
> [   10.928016][    C1] Oops: 0000 [#1] PREEMPT SMP PTI
> [   10.928016][    C1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-mm-pcpnoirq-v1r2 #1 6debc4647ebcbe3e91270f1109aebc1e85510e3e
> [   10.928016][    C1] Hardware name: SGI.COM C2112-4GP3/X10DRT-P-Series, BIOS 2.0a 05/09/2016
> [   10.928016][    C1] RIP: 0010:rtc_handler+0x73/0xd0
> [   10.928016][    C1] Code: df e8 41 62 f9 ff bf 04 00 00 00 e8 a3 bf e7 ff 31 f6 bf 04 00 00 00 e8 08 c2 e7 ff b8 01 00 00 00 5b 5d 41 5c c3 cc cc cc cc <48> 8b 75 00 31 ff e8 72 fe ff ff eb c0 bf 0b 00 00 00 e8 56 81 77
> [   10.928016][    C1] RSP: 0000:ffffaf7f8003eec0 EFLAGS: 00010002
> [   10.928016][    C1] RAX: ffffffffad6d0c00 RBX: ffff94049801a000 RCX: 0000000000000000
> [   10.928016][    C1] RDX: 0000000000000040 RSI: ffffffffadf00460 RDI: ffff94049801a000
> [   10.928016][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000004d0
> [   10.928016][    C1] R10: 0000000000000000 R11: ffffaf7f8003eff8 R12: 0000000000000000
> [   10.928016][    C1] R13: ffffffffae228d82 R14: 0000000000000004 R15: 0000000000000000
> [   10.928016][    C1] FS:  0000000000000000(0000) GS:ffff94037ea80000(0000) knlGS:0000000000000000
> [   10.928016][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   10.928016][    C1] CR2: 0000000000000000 CR3: 00000002c7e26001 CR4: 00000000003706e0
> [   10.928016][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   10.928016][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   10.928016][    C1] Call Trace:
> [   10.928016][    C1]  <IRQ>
> [   10.928016][    C1]  acpi_ev_fixed_event_detect+0x14a/0x18c
> [   10.928016][    C1]  acpi_ev_sci_xrupt_handler+0x2c/0x6e
> [   10.928016][    C1]  acpi_irq+0x18/0x40
> [   10.928016][    C1]  __handle_irq_event_percpu+0x3e/0x2d0
> [   10.928016][    C1]  handle_irq_event_percpu+0xf/0x40
> [   10.928016][    C1]  handle_irq_event+0x34/0x60
> [   10.928016][    C1]  handle_fasteoi_irq+0x7b/0x140
> [   10.928016][    C1]  __common_interrupt+0x4b/0x100
> [   10.928016][    C1]  common_interrupt+0x58/0xa0
> [   10.928016][    C1]  </IRQ>
> [   10.928016][    C1]  <TASK>
> [   10.928016][    C1]  asm_common_interrupt+0x22/0x40
> [   10.928016][    C1] RIP: 0010:cmos_wake_setup.part.9+0x2f/0x120
> [   10.928016][    C1] Code: 80 3d 65 16 4a 01 00 53 48 89 fb 0f 84 a5 00 00 00 48 89 da 48 c7 c6 00 0c 6d ad bf 04 00 00 00 e8 53 b8 e7 ff bf 04 00 00 00 <e8> 98 c6 e7 ff 31 f6 bf 04 00 00 00 e8 fd c8 e7 ff 0f b6 0d 34 ce
> [   10.928016][    C1] RSP: 0000:ffffaf7f800d7ca8 EFLAGS: 00000246
> [   10.928016][    C1] RAX: 0000000000000000 RBX: ffff94049801a000 RCX: 0000000000000004
> [   10.928016][    C1] RDX: ffffffffadefef10 RSI: ffffffffadefee20 RDI: 0000000000000004
> [   10.928016][    C1] RBP: ffffffffaeaf98a0 R08: 0000000000000000 R09: 0000000000000000
> [   10.928016][    C1] R10: 0000000000000000 R11: 000000000000000a R12: ffffffffad6d1750
> [   10.928016][    C1] R13: 0000000000000000 R14: ffff93c5111191a0 R15: ffffffffaefe47f8
> [   10.928016][    C1]  ? rdinit_setup+0x2f/0x2f
> [   10.928016][    C1]  ? cmos_do_probe+0x570/0x570
> [   10.928016][    C1]  ? cmos_wake_setup.part.9+0x2a/0x120
> [   10.928016][    C1]  cmos_pnp_probe+0x6c/0xa0
> [   10.928016][    C1]  pnp_device_probe+0x5b/0xb0
> [   10.928016][    C1]  ? driver_sysfs_add+0x75/0xe0
> [   10.928016][    C1]  really_probe+0x109/0x3e0
> [   10.928016][    C1]  ? pm_runtime_barrier+0x4f/0xa0
> [   10.928016][    C1]  __driver_probe_device+0x79/0x170
> [   10.928016][    C1]  driver_probe_device+0x1f/0xa0
> [   10.928016][    C1]  __driver_attach+0x11e/0x180
> [   10.928016][    C1]  ? __device_attach_driver+0x110/0x110
> [   10.928016][    C1]  bus_for_each_dev+0x79/0xc0
> [   10.928016][    C1]  bus_add_driver+0x1ba/0x250
> [   10.928016][    C1]  ? rtc_dev_init+0x34/0x34
> [   10.928016][    C1]  driver_register+0x5f/0x100
> [   10.928016][    C1]  ? rtc_dev_init+0x34/0x34
> [   10.928016][    C1]  cmos_init+0x12/0x70
> [   10.928016][    C1]  do_one_initcall+0x5b/0x310
> [   10.928016][    C1]  ? rcu_read_lock_held_common+0xe/0x50
> [   10.928016][    C1]  ? rcu_read_lock_sched_held+0x23/0x80
> [   10.928016][    C1]  kernel_init_freeable+0x2b7/0x319
> [   10.928016][    C1]  ? rest_init+0x1b0/0x1b0
> [   10.928016][    C1]  kernel_init+0x16/0x140
> [   10.928016][    C1]  ret_from_fork+0x22/0x30
> [   10.928016][    C1]  </TASK>
> [   10.928016][    C1] Modules linked in:
> [   10.928016][    C1] CR2: 0000000000000000
> [   10.928016][    C1] ---[ end trace 0000000000000000 ]---
> [   10.928016][    C1] RIP: 0010:rtc_handler+0x73/0xd0
> [   10.928016][    C1] Code: df e8 41 62 f9 ff bf 04 00 00 00 e8 a3 bf e7 ff 31 f6 bf 04 00 00 00 e8 08 c2 e7 ff b8 01 00 00 00 5b 5d 41 5c c3 cc cc cc cc <48> 8b 75 00 31 ff e8 72 fe ff ff eb c0 bf 0b 00 00 00 e8 56 81 77
> [   10.928016][    C1] RSP: 0000:ffffaf7f8003eec0 EFLAGS: 00010002
> [   10.928016][    C1] RAX: ffffffffad6d0c00 RBX: ffff94049801a000 RCX: 0000000000000000
> [   10.928016][    C1] RDX: 0000000000000040 RSI: ffffffffadf00460 RDI: ffff94049801a000
> [   10.928016][    C1] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000004d0
> [   10.928016][    C1] R10: 0000000000000000 R11: ffffaf7f8003eff8 R12: 0000000000000000
> [   10.928016][    C1] R13: ffffffffae228d82 R14: 0000000000000004 R15: 0000000000000000
> [   10.928016][    C1] FS:  0000000000000000(0000) GS:ffff94037ea80000(0000) knlGS:0000000000000000
> [   10.928016][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   10.928016][    C1] CR2: 0000000000000000 CR3: 00000002c7e26001 CR4: 00000000003706e0
> [   10.928016][    C1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   10.928016][    C1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   10.928016][    C1] Kernel panic - not syncing: Fatal exception in interrupt
> [   10.928016][    C1] Kernel Offset: 0x2be00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [   10.928016][    C1] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>
> --
> Mel Gorman
> SUSE Labs

--00000000000049adbd05eaaf3f1a
Content-Type: text/x-patch; charset="US-ASCII"; name="rtc-handler-wake-setup-debug.patch"
Content-Disposition: attachment; 
	filename="rtc-handler-wake-setup-debug.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l92w0wne0>
X-Attachment-Id: f_l92w0wne0

LS0tCiBkcml2ZXJzL3J0Yy9ydGMtY21vcy5jIHwgICAgNyArKystLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4LXBtL2RyaXZl
cnMvcnRjL3J0Yy1jbW9zLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0ub3JpZy9kcml2ZXJzL3J0
Yy9ydGMtY21vcy5jCisrKyBsaW51eC1wbS9kcml2ZXJzL3J0Yy9ydGMtY21vcy5jCkBAIC0xMjMz
LDEzICsxMjMzLDEyIEBAIHN0YXRpYyB1MzIgcnRjX2hhbmRsZXIodm9pZCAqY29udGV4dCkKIAog
c3RhdGljIGlubGluZSB2b2lkIHJ0Y193YWtlX3NldHVwKHN0cnVjdCBkZXZpY2UgKmRldikKIHsK
LQlhY3BpX2luc3RhbGxfZml4ZWRfZXZlbnRfaGFuZGxlcihBQ1BJX0VWRU5UX1JUQywgcnRjX2hh
bmRsZXIsIGRldik7CiAJLyoKLQkgKiBBZnRlciB0aGUgUlRDIGhhbmRsZXIgaXMgaW5zdGFsbGVk
LCB0aGUgRml4ZWRfUlRDIGV2ZW50IHNob3VsZAotCSAqIGJlIGRpc2FibGVkLiBPbmx5IHdoZW4g
dGhlIFJUQyBhbGFybSBpcyBzZXQgd2lsbCBpdCBiZSBlbmFibGVkLgorCSAqIERpc2FibGUgdGhl
IEZpeGVkX1JUQyBldmVudCBiZWZvcmUgaW5zdGFsbGluZyB0aGUgUlRDIGhhbmRsZXIuICBJdAor
CSAqIGNhbiBiZSBlbmFibGVkIG9ubHkgd2hlbiB0aGUgUlRDIGFsYXJtIGlzIHNldC4KIAkgKi8K
LQlhY3BpX2NsZWFyX2V2ZW50KEFDUElfRVZFTlRfUlRDKTsKIAlhY3BpX2Rpc2FibGVfZXZlbnQo
QUNQSV9FVkVOVF9SVEMsIDApOworCWFjcGlfaW5zdGFsbF9maXhlZF9ldmVudF9oYW5kbGVyKEFD
UElfRVZFTlRfUlRDLCBydGNfaGFuZGxlciwgZGV2KTsKIH0KIAogc3RhdGljIHZvaWQgcnRjX3dh
a2Vfb24oc3RydWN0IGRldmljZSAqZGV2KQo=
--00000000000049adbd05eaaf3f1a--
