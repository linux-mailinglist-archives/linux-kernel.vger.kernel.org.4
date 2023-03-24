Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8618A6C8756
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCXVOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjCXVOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:14:17 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Mar 2023 14:14:15 PDT
Received: from cascadia.aikidev.net (cascadia.aikidev.net [173.255.214.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE564CDD8;
        Fri, 24 Mar 2023 14:14:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2600:3c01:e000:21:7:77:0:50])
        (Authenticated sender: vagrant@cascadia.debian.net)
        by cascadia.aikidev.net (Postfix) with ESMTPSA id 322AC1AC76;
        Fri, 24 Mar 2023 13:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=debian.org;
        s=1.vagrant.user; t=1679691519;
        bh=5AJu9nz78j4ts/g2nvscHT3J1GeFCzBFCBBnWVD7S+w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GNBpaM4xqS7E0PVQN4/bhbql9woBy3Nt1T4CHJJfFcll02GoRTmAlAg9MZgZTzBdK
         Y0j7A6s1sLqPcH/bS3HNPOFeVrBPO03q3iQCTLkmnnE5iBrlNUS+lP3IeC9w6Pes1j
         +O7mOHgRQaKfVXqD1brwD2/daiUFW26Xnz9L+c8B1h2lVn7CtmHTApLz8gJZXsI1p7
         lOiCNfyfSvBE6TBk5qSOTiGNWbhbewQ3TNQUoqMsQwK2lp0GVPrreGGUF9IgZ0uj0e
         7SeI+mySr8/x1Yf8e6IBf6nd06k6lcCK8mhywmlgoIZEOD/3SteYiiRPn8jycR2KAP
         DDUQGbAHrHvnA==
From:   Vagrant Cascadian <vagrant@debian.org>
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Aurelien Jarno <aurel32@debian.org>, 1033301@bugs.debian.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Tom Saeger <tom.saeger@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kibi@debian.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: Re: Bug#1033301: linux: arm64 kernel size increased from 31 to 39
 MB, causing u-boot-rpi to fail
In-Reply-To: <ZBqeh6aN4lFsFPb3@eldamar.lan>
References: <167943667390.3323902.2304413357807812348.reportbug@ohm.local>
 <ZBqeh6aN4lFsFPb3@eldamar.lan>
Date:   Fri, 24 Mar 2023 13:58:35 -0700
Message-ID: <87h6u9vpc4.fsf@wireframe>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Adding u-boot maintainers for rpi (Matthias Brugger, Peter Robinson)
platforms and u-boot list to CC.

On 2023-03-22, Salvatore Bonaccorso wrote:
> Thanks for tracking this down. I would like to loop in Masahiro and
> upstream to see if something can/should be done on upstream side.
>
> Masahiro, in short, upstream change 994b7ac1697b ("arm64: remove
> special treatment for the link order of head.o") (which got backported
> as well to 6.1.14) caused the vmlinuz size to icrease significantly,
> causing boot failures on Raspberry Pi 3 Model B Plus with u-boot
> parameters previously working. Full quoting the Debian report below

In general it would be nice to not have the kernel grow nearly 25% in
size from a single commit; was that an expected outcome from the above
upstream change? Was the "special treament" originally done to keep the
kernel size down?

As for u-boot, It seems u-boot might need to update the various load
addresses for the kernel, device tree and ramdisk at some point
regardless of weather this particular issue gets fixed in the kernel, as
the kernel will likely continue to grow a bit over time...

Aurelien Jarno included a patch referenced below which bumps the
tolerances in u-boot from 36MB to 42MB.


> On Tue, Mar 21, 2023 at 11:11:13PM +0100, Aurelien Jarno wrote:
>> Following the upgrade of the kernel from 6.1.12-1 to 6.1.15-1 on a
>> Raspberry Pi 3 Model B Plus, u-boot (from the u-boot-rpi package) failed
>> to boot with:
>>=20
>> | 40175552 bytes read in 1695 ms (23 MiB/s)
>> | 43794863 bytes read in 1817 ms (23 MiB/s)
>> | Moving Image from 0x80000 to 0x200000, end=3D2990000
>> | ERROR: RD image overlaps OS image (OS=3D0x200000..0x2990000)
>>=20
>> I tracked the issue to a significant increase of the kernel size between
>> version 6.1.12-1 and 6.15-1:
>>=20
>> | 31492   /boot/vmlinuz-6.1.0-5-arm64
>> | 39236   /boot/vmlinuz-6.1.0-6-arm64
>>=20
>> This is more than the 36MB that is allowed by u-boot with the default
>> load addresses. A workaround is to shift the load addresses at the
>> u-boot level as in the attached patch.
>>=20
>> I have tracked issue on the upstream kernel side to the following commit
>> on the stable tree:
>>=20
>> | commit 3e3e4d234d46e48480a7c7c35399fa811182e8ef
>> | Author: Masahiro Yamada <masahiroy@kernel.org>
>> | Date:   Thu Oct 13 08:35:00 2022 +0900
>> |=20
>> |     arm64: remove special treatment for the link order of head.o
>> |=20=20=20=20=20
>> |     commit 994b7ac1697b4581b7726d2ac64321e3c840229b upstream.
>> |=20=20=20=20=20
>> |     In the previous discussion (see the Link tag), Ard pointed out that
>> |     arm/arm64/kernel/head.o does not need any special treatment - the =
only
>> |     piece that must appear right at the start of the binary image is t=
he
>> |     image header which is emitted into .head.text.
>> |=20=20=20=20=20
>> |     The linker script does the right thing to do. The build system does
>> |     not need to manipulate the link order of head.o.
>> |=20=20=20=20=20
>> |     Link: https://lore.kernel.org/lkml/CAMj1kXH77Ja8bSsq2Qj8Ck9iSZKw=
=3D1F8Uy-uAWGVDm4-CG=3DEuA@mail.gmail.com/
>> |     Suggested-by: Ard Biesheuvel <ardb@kernel.org>
>> |     Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> |     Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>> |     Link: https://lore.kernel.org/r/20221012233500.156764-1-masahiroy@=
kernel.org
>> |     Signed-off-by: Will Deacon <will@kernel.org>
>> |     Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
>> |     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>=20
>> The problem is still reproducible on Linus' master.
>>=20
>> I am reporting the bug to the linux package as I believed there is no
>> real reason for such an increase in the kernel size. In case I missed
>> something and this is actually wanted, the bug can be reassigned to the
>> u-boot package.
>>=20
>> Regards
>> Aurelien
>
>> --- u-boot-2023.01+dfsg.orig/include/configs/rpi.h
>> +++ u-boot-2023.01+dfsg/include/configs/rpi.h
>> @@ -95,32 +95,32 @@
>>   *   text_offset bytes (specified in the header of the Image) into a 2MB
>>   *   boundary. The 'booti' command relocates the image if necessary. Li=
nux uses
>>   *   a default text_offset of 0x80000.  In summary, loading at 0x80000
>> - *   satisfies all these constraints and reserving memory up to 0x02400=
000
>> - *   permits fairly large (roughly 36M) kernels.
>> + *   satisfies all these constraints and reserving memory up to 0x02a00=
000
>> + *   permits fairly large (roughly 42M) kernels.
>>   *
>>   * scriptaddr and pxefile_addr_r can be pretty much anywhere that doesn=
't
>>   * conflict with something else. Reserving 1M for each of them at
>> - * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
>> + * 0x02a00000-0x02b00000 and 0x02c00000-0x02d00000 should be plenty.
>>   *
>>   * On ARM, both the DTB and any possible initrd must be loaded such tha=
t they
>>   * fit inside the lowmem mapping in Linux. In practice, this usually me=
ans not
>>   * more than ~700M away from the start of the kernel image but this num=
ber can
>>   * be larger OR smaller depending on e.g. the 'vmalloc=3DxxxM' command =
line
>>   * parameter given to the kernel. So reserving memory from low to high
>> - * satisfies this constraint again. Reserving 1M at 0x02600000-0x027000=
00 for
>> - * the DTB leaves rest of the free RAM to the initrd starting at 0x0270=
0000.
>> + * satisfies this constraint again. Reserving 1M at 0x02c00000-0x02d000=
00 for
>> + * the DTB leaves rest of the free RAM to the initrd starting at 0x02d0=
0000.
>>   * Even with the smallest possible CPU-GPU memory split of the CPU gett=
ing
>> - * only 64M, the remaining 25M starting at 0x02700000 should allow quite
>> + * only 64M, the remaining 19M starting at 0x02d00000 should allow quite
>>   * large initrds before they start colliding with U-Boot.
>>   */
>>  #define ENV_MEM_LAYOUT_SETTINGS \
>>  	"fdt_high=3D" FDT_HIGH "\0" \
>>  	"initrd_high=3D" INITRD_HIGH "\0" \
>>  	"kernel_addr_r=3D0x00080000\0" \
>> -	"scriptaddr=3D0x02400000\0" \
>> -	"pxefile_addr_r=3D0x02500000\0" \
>> -	"fdt_addr_r=3D0x02600000\0" \
>> -	"ramdisk_addr_r=3D0x02700000\0"
>> +	"scriptaddr=3D0x02a00000\0" \
>> +	"pxefile_addr_r=3D0x02b00000\0" \
>> +	"fdt_addr_r=3D0x02c00000\0" \
>> +	"ramdisk_addr_r=3D0x02d00000\0"
>>=20=20
>>  #if CONFIG_IS_ENABLED(CMD_MMC)
>>  	#define BOOT_TARGET_MMC(func) \

Bumping from 36MB to 42MB seems address the issue at hand, although
would it make sense to bump even higher... or is that starting to hit
other limitations?


Thanks everyone!


live well,
  vagrant

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRlgHNhO/zFx+LkXUXcUY/If5cWqgUCZB4O/AAKCRDcUY/If5cW
qlDlAP9+k2e0vW2sgZYql2f1dRAPHvj0iMvHG2LJa4KGkurkQgEAvwxDC4PdKQds
LnyXvjIQTA/NIzpPZV46ZNDZfepH2wk=
=1vKQ
-----END PGP SIGNATURE-----
--=-=-=--
