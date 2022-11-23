Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4ED6359C8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbiKWKZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbiKWKYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:24:09 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08137252B2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669198141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0BlMP3vE6NPYkowJ5CYY9pKK4uobIqguXEfH7GISyWM=;
        b=hNwJu+7aHf2/tACy7j/lzZlRrPCnHatghGbvEiGM02gXLpYq9Gp401xeyw+YRo8KeMIRFs
        lIMv51qhGUiA5olsfI55o3JRZ0IYhPQ7YDPVcfEUnvLEqbNbiXUTlQjApimqJgcD3dN4w8
        mf+Bcdg/s36lOprj43lqqtwTY9hbeFw5Us8CyT+Z8e/T7UHmM7Pv7tZ40w2t9nM0A+PeTq
        5hP1Ekn4MAShxBG4XKM/PoL91Z2EwI95FftWIt4YolcfUxFgfXn4PHNpNq+UBHrBlMgucH
        AzYZM7vz4fuAOgs7czwWBlTV4ANBu8Yjib03s5EXjLWKbKJu76VU9vzxhKtHuQ==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-634-GlAu2hBEM3-xoo23vO7U3g-1; Wed, 23 Nov 2022 05:09:00 -0500
X-MC-Unique: GlAu2hBEM3-xoo23vO7U3g-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 23 Nov 2022 02:08:51 -0800
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-lgm-soc@maxlinear.com>,
        <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 0/4] x86/of: Add support for interrupt mode config for x86 OF systems
Date:   Wed, 23 Nov 2022 18:08:46 +0800
Message-ID: <20221123100850.22969-1-rtanwar@maxlinear.com>
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

[RESEND due a missing Cc in previous send]

Hi All,

This patch series mainly adds a boot time interrupt delivery mode
configuration option for OF based x86 platforms. Presently,
boot time interrupt delivery mode is hardcoded to legacy PIC mode
with no option to configure it to virtual wire mode. This patch
series aims to extend it by introducing a new optional boolean
property for lapic devicetree node which can be used to configure
it to virtual wire mode where applicable. Please find below detailed
rationale behind it.

Rationale:

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
unmask the interrupts. This causes kernel boot crash for platforms which
does not support 8259 compatible external PIC.

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
enabled). This to me appears to be a bug which needs fixing. As per
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
and giving no other choice to choose virtual wire mode is a lacking feature=
.

Just like mpparse relies on IMCRP bit 7 of MP feature info byte2 [5] to
select pic_mode to PIC mode or virtual wire mode. arch/x86/kernel/devicetre=
e.c
should also provide some similar configurability to choose interrupt
delivery mode & not hardcode it to PIC mode.

This patch is to add above mentioned interrupt mode configurability in x86/=
of
controlled via a new optional bool property.

Please let me know if you find any mistake in above understanding or if you
have a alternative better suggestion to solve it or if you find anything od=
d
here in our platform/system. TIA.

The patch is baselined on below git tree (linux-v6.1.0-rc6):
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

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

v4:
- Address review concerns from Andy Shevchenko
  * Update maintainers in binding files.
  * Place URL in YAML schema properly as reference.
  * Remove some unnecessary comments from YAML description.
  * Remove fixes tag & not treat it as a bug. Treat it as new feature addit=
ion instead.
  * Use proper prefixes for bindings file (dt-bindings: x86: ioapic:)
  * Add Reviewed-by tag from Andy for patch 3/4.

v3:
- Address review concerns from Andy Shevchenko
  * Reshuffle patch series changes to make it more logical.
  * Patch 1 just converts existing intel,ce4100-ioapic.txt into
    YAML schema and separates out ioapic & lapic.
  * Patch 2 adds new optional property for lapic.
  * Patch 3 replaces older printk(KERN_LVL) to newer pr_lvl()
  * Patch 4 adds code changes in devicetree.c to support newly
    added property.
- Fix 'make DT_CHECKER_FLAGS=3D-m dt_binding_check' errors reported
  by Rob Herring's bot.

v2:
- Address review concern from Andy - rename property name to make
  it a bit more positive & self explanatory.
- Found that the bindings document for these HW's (APIC) are a bit
  off/obsolete and still in text format. Created new YAML schemas
  one for each - lapic & ioapic. Updated these schemas with latest
  info and add in new optional property details in the updated
  schema for lapic. Delete/let go of the text binding doc.
- CC devicetree@vger.kernel.org as these changes appear to be
  mainly targeted for devicetree maintainers review & approval.
- Increase CCed list to include all possible people who touched
  and were involved this part of code/feature addition.

v1:
- Initial draft


Rahul Tanwar (4):
  dt-bindings: x86: apic: Convert Intel's APIC bindings to YAML schema
  dt-bindings: x86: apic: Introduce new optional bool property for lapic
  x86/of: Replace printk(KERN_LVL) with pr_lvl()
  x86/of: Add support for boot time interrupt delivery mode
    configuration

 .../intel,ce4100-ioapic.txt                   | 26 --------
 .../intel,ce4100-ioapic.yaml                  | 62 ++++++++++++++++++
 .../intel,ce4100-lapic.yaml                   | 63 +++++++++++++++++++
 arch/x86/kernel/devicetree.c                  | 13 +++-
 4 files changed, 135 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/=
intel,ce4100-ioapic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/=
intel,ce4100-ioapic.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/=
intel,ce4100-lapic.yaml

--=20
2.17.1

