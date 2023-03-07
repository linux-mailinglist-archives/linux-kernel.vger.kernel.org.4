Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971486AD4ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCGCnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCGCnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:43:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489C037B43;
        Mon,  6 Mar 2023 18:43:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PW09t3ly4z4x1d;
        Tue,  7 Mar 2023 13:43:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678156994;
        bh=bhFzI3X2fZmZeWMzLyhlyB7PT7fCT/MfaDJHUf4SIsM=;
        h=Date:From:To:Cc:Subject:From;
        b=O2xbhVC987ib7KfaHYT6syLUzvQvOZtpZSpaJ/tD89yBPyaO361GTwdPBVPAr4abU
         +MgQwKCeCnYOWTiXvHQjgjwWkUZgIa/Vsi5kDyUPhtqoUF0wp+w1BUOrLpbW1L3vhV
         XqQpt49I/dFEmukeZ0ZTOsH6zXUHocZWA80ufJQ7pD16rmYiTn+9Pj08cUJx5rSODb
         c8sIS4YN+trOOy6UBDfJCW4/t40qOIJaTRe8t9ihkZ7yf0PqBizpweLsO5gX8gV9cT
         WAIvuVvsUlNkxolHmNBROmAvsnY/Lgmx/CxkXiZ9dktvnz0RlzI5Qc6EFYp5VsHbTS
         fk+LIiKRZEDCw==
Date:   Tue, 7 Mar 2023 13:43:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: runtime warning after merge of the driver-core tree
Message-ID: <20230307134313.1b2aa555@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0u4lt3Y93/NlVgFI7oKg.p2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0u4lt3Y93/NlVgFI7oKg.p2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next qemu boot
(powerpc pseries_le_defconfig) produced this boot time warning:

HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
sysfs: cannot create duplicate filename '//block'
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc1-01530-ge44d8b957584 #2
Hardware name: IBM pSeries (emulated by qemu) POWER9 (raw) 0x4e1202 0xf0000=
05 of:SLOF,HEAD hv:linux,kvm pSeries
Call Trace:
[c000000003503990] [c000000000e1c9bc] dump_stack_lvl+0x70/0xa0 (unreliable)
[c0000000035039c0] [c0000000005a1728] sysfs_warn_dup+0x88/0xc0
[c000000003503a40] [c0000000005a194c] sysfs_create_dir_ns+0x12c/0x170
[c000000003503a90] [c000000000e26b54] kobject_add_internal+0x124/0x3c0
[c000000003503b10] [c000000000e26e60] kobject_add+0x70/0xf0
[c000000003503b90] [c000000000e26f88] kobject_create_and_add+0xa8/0x120
[c000000003503c10] [c00000000204aa58] genhd_device_init+0x84/0xa8
[c000000003503c40] [c0000000000132a0] do_one_initcall+0x80/0x320
[c000000003503d20] [c000000002004a68] kernel_init_freeable+0x304/0x3a4
[c000000003503df0] [c0000000000138a0] kernel_init+0x30/0x1a0
[c000000003503e50] [c00000000000df94] ret_from_kernel_thread+0x5c/0x64
--- interrupt: 0 at 0x0
NIP:  0000000000000000 LR: 0000000000000000 CTR: 0000000000000000
REGS: c000000003503e80 TRAP: 0000   Not tainted  (6.3.0-rc1-01530-ge44d8b95=
7584)
MSR:  0000000000000000 <>  CR: 00000000  XER: 00000000
CFAR: 0000000000000000 IRQMASK: 0=20
GPR00: 0000000000000000 c000000003504000 0000000000000000 0000000000000000=
=20
GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR12: 0000000000000000 0000000000000000 c000000000013878 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
NIP [0000000000000000] 0x0
LR [0000000000000000] 0x0
--- interrupt: 0
kobject_add_internal failed for block with -EEXIST, don't try to register t=
hings with the same name in the same directory.
kobject_create_and_add: kobject_add error: -17
iommu: Default domain type: Translated=20

Introduced by commit

  721da5cee9d4 ("driver core: remove CONFIG_SYSFS_DEPRECATED and CONFIG_SYS=
FS_DEPRECATED_V2")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/0u4lt3Y93/NlVgFI7oKg.p2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQGpMEACgkQAVBC80lX
0GwmHQf/br4X3K0FGz+lI4rEX97u2/n9jBedigh0SUVLwfKDs4y6Cn/dPftqw2vu
dD5buuNzxNdYcdUf+WTSpoKrlDwHutXX/M+rzpeburG7grMzJiVwGoelSzEJ1+aJ
lHDLxqlv+9zzrw6+obXZ+OeSfYQkdREyHU1mj6v3cbdDDeTApWZ2gXCTiWgxj4xp
/caFmM5LXdO7fUt+BVhP5UQNSpj7M7mehH93LaWskmRRXVNOKS84cUtP79dRbhvV
amM3t1KVT+aqCx0Bg5W2mRI+HGTytV8PO/BSaiiDg+kGWsfT30wMNIF+dbXrwrCk
Z2VaPsnGUY6kKOsZnKxDvj8nvPT5/A==
=+UJy
-----END PGP SIGNATURE-----

--Sig_/0u4lt3Y93/NlVgFI7oKg.p2--
