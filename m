Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D893631774
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 01:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiKUAAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 19:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKUAAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 19:00:51 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B90525298;
        Sun, 20 Nov 2022 16:00:49 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NFnbH0RvXz4x1D;
        Mon, 21 Nov 2022 11:00:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668988843;
        bh=PQ/mZoZy1OtDgUCx+23gEqJrYuLlwBeJIlyTABANKZQ=;
        h=Date:From:To:Cc:Subject:From;
        b=XsZDt2AwZFtzEeALOulNeE7FT+EnsebC5lpY3R8kLnPecJ9qR1pQYg1C7qxnmKTA3
         2TFYJMjBADBeJVgjQc9cKwpCcGfNwfJiAprkVTWPeBQkgx4SAELZJ+YBrOpoImJZa8
         6/KxH+LH2vjEePTfpRNIDsTWgbRWxizTOs1i+mk28NbXSFmQ/SW17LwxAziHFcQxl+
         C1RtcbYy9UVWpqEgbaxz4vc/N3BE5B2wrWqzdIH2rcUd/L8MGVqYQSpYBM383e7dyy
         +UsZX74wUcddyDnitt2ojHsrDKKLxlWjV8S19FjDHkauAxA1SCgnxeinEGvX8/yrJo
         60z0GADH6gTuQ==
Date:   Mon, 21 Nov 2022 11:00:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the printk tree
Message-ID: <20221121110041.1d2c635b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B3yQZdqv6nwEEef/MGmVwSi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B3yQZdqv6nwEEef/MGmVwSi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the printk tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "lockdep_assert_console_list_lock_held" [drivers/video/fbde=
v/xen-fbfront.ko] undefined!
ERROR: modpost: "lockdep_assert_console_list_lock_held" [drivers/tty/serial=
/8250/8250.ko] undefined!
ERROR: modpost: "lockdep_assert_console_list_lock_held" [drivers/tty/serial=
/samsung_tty.ko] undefined!
ERROR: modpost: "lockdep_assert_console_list_lock_held" [drivers/tty/serial=
/kgdboc.ko] undefined!
ERROR: modpost: "lockdep_assert_console_list_lock_held" [drivers/net/netcon=
sole.ko] undefined!

Presumably caused by commits

  c26c1533e3bd ("printk: introduce console_list_lock")
  a71ba89dc3ed ("console: introduce wrappers to read/write console flags")
  d3ca62bf29bb ("console: introduce console_is_registered()")

I have used the printk tree from next-20221118 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/B3yQZdqv6nwEEef/MGmVwSi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN6v6kACgkQAVBC80lX
0GyDgwf9HAyNLl37VMCGeardwi3g7gbCoJaM5RQdYCjUAHY8gIL6pMlDmE9qXEh9
R9KzWya0HPsRjmZDNSMpLlKX4tJ40XUVWhGGzr6CSM11CUnRAgPHl1HZC6P7T5V6
Tx+nSW9AQnmU8LYeEtltP4ZKuLZgFey2lHUPpILPRwmXTD2gDi4Z2GtRan6PwP/8
9u7WdjDGZx6bW/oV9pixf19prBzHNzNn+mJCjbIQbt+Y4FFLAEoaAxuqSjRQwwbo
W21GZ0VFjqbHoHvTGtsnZdAyZpnaSpuI8S7McrKCNSOTuOXDDxaUBE2CFxcZIwps
ycJFhw4ZSkwntLQlPm01Ad3tIspBlA==
=1RME
-----END PGP SIGNATURE-----

--Sig_/B3yQZdqv6nwEEef/MGmVwSi--
