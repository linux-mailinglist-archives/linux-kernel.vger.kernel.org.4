Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8675B6278E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiKNJVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbiKNJVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:21:18 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA1EE0F2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1668417616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1ESBhBNDD5fApVjeRdESCYkNiIVfilpMQwEp5vVBlw8=;
        b=DFRx6oco1gw1zIpPLSMvUh1khe1ps33RhOls+eDgXoGwBNahI7/gJnT0kWC59g42J87AYr
        JgedfZW5HGiEwyl8Y46cGh0oKbYG9RyWSMa7yM9V3RE6exdm4qobEn0yHWNt3dEtoxNEG4
        jBFHtICAcA0gtU9CqTAWuXQqYw3VYyA9UJt3i3ZUfnyVGwpsY6oU3CFjbFm6Q7wv4LJiFF
        ucrQCUMxryn5i5fYD0inV+USieIJUiDpZVwCnC8gDsWlmp7PPvL3JLcFHN1rhf+cHSj/Kc
        gVCbzmxxYXklCOb9R35+9Wvh0gtybOSRWUasY868bZpU0vEJcjLWgtHXOE5uLA==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-98-Wj5cdgjdOHCIAqnlGi2ZIw-1; Mon, 14 Nov 2022 04:20:14 -0500
X-MC-Unique: Wj5cdgjdOHCIAqnlGi2ZIw-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Mon, 14 Nov 2022 01:20:09 -0800
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <bigeasy@linutronix.de>, <robh@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>
CC:     <andriy.shevchenko@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>
Subject: [PATCH RESEND 0/1] x86/of: Fix a bug in x86 arch OF support
Date:   Mon, 14 Nov 2022 17:20:05 +0800
Message-ID: <cover.1668403214.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian Andrzej Siewior, Rob, Thomas, Ingo, Boris, Andy, Dave=20
& all x86@kernel.org maintainers,=20

I sent this patch 3 times but for some reasons, never got any response or
attention from anybody so far. Hence, resending with a cover letter to
explain the rationale behind it in detail & to justify the need to add
this fix. Also, hoping to get some feedback in-case i am mistaken in my
understanding which might be the reason why i never got any response.

Background (baseline understanding - pls correct if mistaken anywhere):

References [1], [2] & [6]

For SMP systems, Intel defines three (logically four) interrupt modes
during boot/init time while BIOS/bootloader boots & switches to linux
kernel.

  1. PIC mode - Legacy 8259 PIC interrupt controller.
  2. Virtual wire mode via Local APIC - uses local APIC as virtual wire
  3. Virtual wire mode via I/O APIC - uses I/O APIC as virtual wire
  4. Symmetric I/O mode - final one used by linux for SMP systems.=20

BIOS/bootloaders are supposed to boot in either #1 or #2 or #3 and then
switch to #4 in linux for SMP systems.

For our platform, we use #2.

Detection of which interrupt mode the system is booting in is made by using
below global variable in apic.c

int pic_mode __ro_after_init;=20

Here pic_mode =3D 1 means #1 (PIC mode) above.
And pic_mode =3D 0 means #2 or #3 (basically virtual wire mode via apic).

And apic.c while doing setup_local_APIC() uses below code [3]:

        value =3D apic_read(APIC_LVT0) & APIC_LVT_MASKED;
        if (!cpu && (pic_mode || !value || skip_ioapic_setup)) {
                value =3D APIC_DM_EXTINT;
                apic_printk(APIC_VERBOSE, "enabled ExtINT on CPU#%d\n", cpu=
);
        } else {
                value =3D APIC_DM_EXTINT | APIC_LVT_MASKED;
                apic_printk(APIC_VERBOSE, "masked ExtINT on CPU#%d\n", cpu)=
;
        }
        apic_write(APIC_LVT0, value);

What i understand from above is that if at this point of time, as long as
it is cpu0 & pic_mode=3D1, it will set delivery mode to ExtINT (causes the
processor to respond to the interrupt as if the interrupt originated in an
externally connected (8259A-compatible) interrupt controller) and enables/
unmask the interrupts.

pic_mode is presently set/populated/initialized at only two places:
 1. In  mpparse.c [4]
 2. In devicetree.c [7]

For #1 MPPARSE Kconfig definition is as below:

=09config X86_MPPARSE
        =09bool "Enable MPS table" if ACPI
        =09default y
        =09depends on X86_LOCAL_APIC
        =09help
          =09For old smp systems that do not have proper acpi support. Newe=
r systems
          =09(esp with 64bit cpus) with acpi support, MADT and DSDT will ov=
erride it

As seen above, if ACPI is not enabled, then mpparse by default is always
enabled. Presently, there is no way to disable MPPARSE (if ACPI is not
enabled). This to me appears to be another bug which needs fixing. As per
theory, MPPARSE was to support MPS spec [1] as a temporary solution to
support SMP systems until a final ACPI standard was added. But now if ACPI
is not enabled, it will rely on MPPARSE driver to read MP floating pointer
structure's IMCRP Bit 7 of MP feature info byte 2 [5] to figure out if it
supports PIC mode or virtual wire mode and initialize pic_mode variable
accordingly. If ACPI is enabled, the ACPI code overrides it by using the
MADT table spec'ed in ACPI spec [2].=20

For #2 devicetree.c presently hardcodes pic_mode =3D 1 (PIC Mode). There is
no support to configure virtual wire mode via devicetree path for OF based
systems.

Now we have a platform which is OF based & does not use legacy 8259 PIC
interrupt controller. Non ACPI compliant as well as non MPPARSE compliant.

For such platforms, it appears to me that hardcoding pic_mode =3D 1 (PIC Mo=
de)
and giving no other choice to choose virtual wire mode is a bug for OF
based x86 platforms.=20

Just like mpparse relies on IMCRP bit 7 of MP feature info byte2 [5] to
select pic_mode to PIC mode or virtual wire mode. arch/x86/kernel/devicetre=
e.c
should also provide some similar configurability to choose interrupt
delivery mode & not hardcode it to PIC mode.

This patch is to fix above explained bug in x86/of support for interrupt
delivery mode configuration. Please let me know if you find any mistake
in above understanding or if you have a alternative better suggestion to
solve it or if you find anything odd here in our platform/system. TIA.

The patch is baselined on below git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core

[1] https://pdos.csail.mit.edu/6.828/2008/readings/ia32/MPspec.pdf
[2] https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
[3] https://elixir.bootlin.com/linux/v6.1-rc5/source/arch/x86/kernel/apic/a=
pic.c#L1691
[4] https://elixir.bootlin.com/linux/v6.1-rc5/source/arch/x86/kernel/mppars=
e.c#L517
[5] https://www.manualslib.com/manual/77733/Intel-Multiprocessor.html?page=
=3D40#manual
[6] https://www.intel.com/content/www/us/en/developer/articles/technical/in=
tel-sdm.html
[7] https://elixir.bootlin.com/linux/v6.1-rc5/source/arch/x86/kernel/device=
tree.c#L170

Rahul Tanwar (1):
  x86/of: Add support for boot time interrupt mode config

 arch/x86/kernel/devicetree.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--=20
2.17.1

