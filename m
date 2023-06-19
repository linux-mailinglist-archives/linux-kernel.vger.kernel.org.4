Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D4F7356CB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjFSM1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjFSM05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:26:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE8D10DE;
        Mon, 19 Jun 2023 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687177592; x=1718713592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2dMPAEYH75en74GBwY9FUzB00jeJTw7JbQjAFqm65cI=;
  b=y5y2lcYw7LO9x7vcm8uSKTnK/RW7xR10KNObobUChLSmjeiS+fHjdqq1
   1/76DmX0EwuNCWz85MyL4FegG87soWXSgr34dUmaDn91a3xlWNtvGxCIx
   37A5Ry8NDq6QrXXC8QvGVk9vRswWINqGShjbp2ewe2cr1LQTb0ixuS8Ft
   b9+O9IUgetlWihkMDHMz4E+hLWVjcqgG+asrFEre6b6pQQhmwfuR9SqWU
   qWumVdo41Cj1cQxXH31oSCP+KZY57QCxW7+YwK96GLdpAatn+hWuo2k4U
   BCt+hTnup8kRTqgejCGoqVCDCJLIMKl/8Do0S47wexGcqLKGR5cXJG7Ei
   g==;
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="asc'?scan'208";a="218611642"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jun 2023 05:26:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 19 Jun 2023 05:26:13 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 19 Jun 2023 05:26:11 -0700
Date:   Mon, 19 Jun 2023 13:25:45 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
Message-ID: <20230619-kerchief-unmixed-cfdbeb1cf242@wendy>
References: <20230619094705.51337-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JACaknZClFQ0c+Zo"
Content-Disposition: inline
In-Reply-To: <20230619094705.51337-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--JACaknZClFQ0c+Zo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alex,

Thanks for working on this :) I've got a mix of suggestions and
questions below. Hopefully it is not too disjoint, since I didn't write
them in order.

On Mon, Jun 19, 2023 at 11:47:04AM +0200, Alexandre Ghiti wrote:
> This document describes the constraints and requirements of the early
> boot process in a RISC-V kernel.
>=20
> Szigned-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  Documentation/riscv/boot-image-header.rst |   3 -
>  Documentation/riscv/boot.rst              | 181 ++++++++++++++++++++++
>  Documentation/riscv/index.rst             |   1 +
>  3 files changed, 182 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/riscv/boot.rst
>=20
> diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/ri=
scv/boot-image-header.rst
> index d7752533865f..a4a45310c4c4 100644
> --- a/Documentation/riscv/boot-image-header.rst
> +++ b/Documentation/riscv/boot-image-header.rst
> @@ -7,9 +7,6 @@ Boot image header in RISC-V Linux
> =20
>  This document only describes the boot image header details for RISC-V Li=
nux.
> =20
> -TODO:
> -  Write a complete booting guide.
> -
>  The following 64-byte header is present in decompressed Linux kernel ima=
ge::
> =20
>  	u32 code0;		  /* Executable code */
> diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot.rst
> new file mode 100644
> index 000000000000..b02230818b79
> --- /dev/null
> +++ b/Documentation/riscv/boot.rst
> @@ -0,0 +1,181 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Early boot requirements/constraints on RISC-V
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Please use "title case", here and elsewhere in the doc.
I'd also be inclined to drop the "Early" from here, as it permits more
natural section headings. Perhaps "RISC-V Kernel Boot Requirements and
Constraints"?

> +
> +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> +:Date: 23 May 2023
> +
> +This document describes what the RISC-V kernel expects from the previous=
 stages

"the previous stages" is a bit vague IMO. You mean bootloader stages I
assume, but I think it should be explicit. Perhaps:
"...what a RISC-V kernel expects from bootloaders and firmware, and the
constraints..."

> +and the firmware, but also the constraints that any developer must have =
in mind
> +when touching the early boot process, e.g. before the final virtual mapp=
ing is
> +setup.

s/setup./set up./

Do you mean to have "For example" here? Or is "before the final virtual
mapping is set up" the definition or "early boot"? If the latter, I
would reword this as something like:
"...when modifying the early boot process. For the purposes of this
document, the 'early boot process' refers to any code that runs before
the final virtual mapping is set up."

> +Pre-kernel boot (Expectations from firmware)

Firmware or bootloaders? TBH, I would just drop the section in () and
do something like:
	Pre-kernel Requirements and Constraints
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=09
	The RISC-V kernel expects the following of bootloaders and platform
	firmware:

> +
> +Registers state

s/Registers state/Register State/

> +---------------
> +
> +The RISC-V kernel expects:
> +
> +  * `$a0` to contain the hartid of the current core.
> +  * `$a1` to contain the address of the device tree in memory.
> +
> +CSR state
> +---------
> +
> +The RISC-V kernel expects:
> +
> +  * `$satp =3D 0`: the MMU must be disabled.

"the MMU, if present, must be disabled." ;)

> +
> +Reserved memory for resident firmware
> +-------------------------------------
> +
> +The RISC-V kernel expects the firmware to mark any resident memory with =
the

Should this be
"...resident memory, or memory it has protected with PMPs, with..."
?

> +`no-map` flag, thus the kernel won't map those regions in the direct map=
ping

"no-map" is a DT specific term, should this section be moved down under
DT, as a sub-section of that?

> +(avoiding issues with hibernation, speculative accesses and probably oth=
er
> +subsystems).

I'm not sure that this () section is beneficial. To be honest, recent
issues aside, this section here seems like a statement of the obvious...

> +
> +Kernel location
> +---------------
> +
> +The RISC-V kernel expects to be placed at a PMD boundary (2MB for rv64 a=
nd 4MB

Would that be better worded as "(2 MB aligned for rv64 and 4 MB aligned
for rv32)"? It might be overly explicit, but I figure there's no harm...

> +for rv32). Note though that the EFI stub will physically relocate the ke=
rnel if

s/though//

> +that's not the case.
> +
> +Device-tree

s/Device-tree/Devicetree/ and...

> +-----------
> +
> +The RISC-V kernel always expects a device tree, it is:

=2E..s/device tree/devicetree/ to match elsewhere in the kernel docs.
Same applies to the other instances of "device tree" in this patch,
please.

> +
> +- either passed directly to the kernel from the previous stage using the=
 `$a1`
> +  register,
> +- or when booting with UEFI, the device tree will be retrieved by the EF=
I stub
> +  using the EFI configuration table or it will be created.

Can I suggest changing this around a little, pulling the "either" &
dropping some boilerplate so that it reads (to me!) a little more
naturally:
	The RISC-V kernel always expects a devicetree, it is either:
=09
	- passed directly to the kernel from the previous stage using the `$a1`
	  register,
	- retrieved by the EFI stub when booting with UEFI, using the EFI
	  configuration table or it will be created by ____.

Also, please elaborate on what it will be created by.

> +
> +Bootflow

"Boot Flow", no?
I am not sure that this is the "correct" heading for the content it
describes, but I have nothing better to offer :/

> +--------
> +
> +There exist 2 methods to enter the kernel:
> +
> +- `RISCV_BOOT_SPINWAIT`: the firmware releases all harts in the kernel, =
one hart
> +  wins a lottery and executes the early boot code while the other harts =
are
> +  parked waiting for the initialization to finish. This method is now

nit: s/now//

What do you mean by deprecated? There's no requirement to implement the
HSM extension, right?

> +  **deprecated**.
> +- Ordered booting: the firmware releases only one hart that will execute=
 the
> +  initialization phase and then will start all other harts using the SBI=
 HSM
> +  extension.
> +
> +UEFI
> +----
> +
> +UEFI memory map
> +~~~~~~~~~~~~~~~
> +
> +When booting with UEFI, the RISC-V kernel will use only the EFI memory m=
ap to
> +populate the system memory.
> +
> +The UEFI firmware must parse the subnodes of the `/reserved-memory` devi=
ce tree
> +node and abide by the device tree specification to convert the attribute=
s of
> +those subnodes (`no-map` and `reusable`) into their correct EFI equivale=
nt
> +(refer to section "3.5.4 /reserved-memory and UEFI" of the device tree
> +specification).
> +
> +RISCV_EFI_BOOT_PROTOCOL
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When booting with UEFI, the EFI stub requires the boot hartid in order t=
o pass
> +it to the RISC-V kernel in `$a1`. The EFI stub retrieves the boot hartid=
 using
> +one of the following methods:
> +
> +- `RISCV_EFI_BOOT_PROTOCOL` (**preferred**).
> +- `boot-hartid` device tree subnode (**deprecated**).
> +
> +Any new firmware must implement `RISCV_EFI_BOOT_PROTOCOL` as the device =
tree
> +based approach is deprecated now.
> +
> +During kernel boot: (Kernel internals)

With the other section titles changed, this could be:
	Early Boot Requirements and Constraints
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=09
	The RISC-V kernel's early boot process operates under the
	following constraints:

Thoughts?

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +EFI stub and device tree

Same comments about "device tree" here etc.

> +------------------------
> +
> +When booting with UEFI, the device tree is supplemented by the EFI stub =
with the
> +following parameters (largely shared with arm64 in Documentation/arm/uef=
i.rst):
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Name                        Size     Description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +linux,uefi-system-table     64-bit   Physical address of the UEFI System=
 Table.

nit: Hmm, I think for all of these sizes s/-bit/ bits/.

> +
> +linux,uefi-mmap-start       64-bit   Physical address of the UEFI memory=
 map,
> +                                     populated by the UEFI GetMemoryMap(=
) call.
> +
> +linux,uefi-mmap-size        32-bit   Size in bytes of the UEFI memory map
> +                                     pointed to in previous entry.
> +
> +linux,uefi-mmap-desc-size   32-bit   Size in bytes of each entry in the =
UEFI
> +                                     memory map.
> +
> +linux,uefi-mmap-desc-ver    32-bit   Version of the mmap descriptor form=
at.
> +
> +kaslr-seed                  64-bit   Entropy used to randomize the kerne=
l image
> +                                     base address location.
> +
> +bootargs                             Kernel command line
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D  =3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Virtual mapping setup

nit: s/setup/Installation/

> +---------------------
> +
> +The installation of the virtual mapping is done in 2 steps in the RISC-V=
 kernel:
> +
> +1. :c:func:`setup_vm` installs a temporary kernel mapping in
> +   :c:var:`early_pg_dir` which allows to discover the system memory: onl=
y the

s/to discover/discovery of/
s/: only/. Only/

> +   kernel text/data are mapped at this point. When establishing this map=
ping,
> +   no allocation can be done (since the system memory is not known yet),=
 so
> +   :c:var:`early_pg_dir` page table is statically allocated (using only =
one
> +   table for each level).
> +
> +2. :c:func:`setup_vm_final` creates the final kernel mapping in
> +   :c:var:`swapper_pg_dir` and takes advantage of the discovered system =
memory
> +   to create the linear mapping. When establishing this mapping, the ker=
nel
> +   can allocate memory but cannot access it directly (since the direct m=
apping
> +   is not present yet), so it uses temporary mappings in the fixmap regi=
on to
> +   be able to access the newly allocated page table levels.
> +
> +For :c:func:`virt_to_phys` and :c:func:`phys_to_virt` to be able to corr=
ectly
> +convert direct mapping addresses to physical addresses, it needs to know=
 the

nit: s/it/they/

> +start of the DRAM: this happens after 1, right before 2 installs the dir=
ect

s/:/./
Also how about s/1/step 1/ & s/2/step 2/?

> +mapping (see :c:func:`setup_bootmem` function in arch/riscv/mm/init.c). =
So

s/So//

> +any usage of those macros before the final virtual mapping is installed =
must be
> +carefully examined.
> +
> +Device-tree mapping via fixmap
> +------------------------------
> +
> +The RISC-V kernel uses the fixmap region to map the device tree because =
the
> +device tree virtual mapping must remain the same between :c:func:`setup_=
vm` and
> +:c:func:`setup_vm_final` calls since :c:var:`reserved_mem` array is init=
ialized

Missing a "the" before reserved_mem.

> +with virtual addresses established by :c:func:`setup_vm` and used with t=
he
> +mapping established by :c:func:`setup_vm_final`.
> +
> +Pre-MMU execution
> +-----------------
> +
> +Any code that executes before even the first virtual mapping is establis=
hed
> +must be very carefully compiled as:

Could you point out what the non-obvious examples of this code are?

> +- `-fno-pie`: This is needed for relocatable kernels which use `-fPIE`, =
since

Is there a reason why the capitalisation is different for the two
compiler flags?

> +  otherwise, any access to a global symbol would go through the GOT whic=
h is
> +  only relocated virtually.
> +- `-mcmodel=3Dmedany`: Any access to a global symbol must be PC-relative=
 to avoid
> +  any relocations to happen before the MMU is setup.
> +- Also note that *all* instrumentation must also be disabled (that inclu=
des

nit: s/Also note that//

> +  KASAN, ftrace and others).
> +
> +As using a symbol from a different compilation unit requires this unit t=
o be
> +compiled with those flags, we advise, as much as possible, not to use ex=
ternal
> +symbols.

If the use of early alternatives grows, are we going to have to split
the vendors early alternatives into a different compilation unit from
their regular alternatives?

Cheers,
Conor.

--JACaknZClFQ0c+Zo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJBJSQAKCRB4tDGHoIJi
0oYDAQDGw2eP2kvR360enKpa4T0n4O3yeOMhIwpzOvH1jiZSkQD/T7rN9x2isuCG
HO1sBS2rDZtQ0sf35qDBBUWb3h0fNQo=
=pfM6
-----END PGP SIGNATURE-----

--JACaknZClFQ0c+Zo--
