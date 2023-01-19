Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C20E6743E7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjASVFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjASVEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:04:24 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A13A4AA6B;
        Thu, 19 Jan 2023 12:58:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NyZjP5gN5z4xHV;
        Fri, 20 Jan 2023 07:58:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674161914;
        bh=vPxcCPs+eRbBI6ym9iEXerGJI4yHG5vqgXv2CB8zFGc=;
        h=Date:From:To:Cc:Subject:From;
        b=mB+Csdslz++Y9xyF7qxk1/sg2k15CQdCDYQGcWmza/8W3PDVbrZroXs8wm+slkBcW
         OOtAQctSEriCY7oarxoVuzJIcxuLRneaM0QZkWfM2A6AH0Go5z1bqxfhNdHjlnqOjB
         76S2/DXXzegLjzD8ZEPs9uzVGnp3yTuRUbhaSqQzbsyOSB63OvI7yZoluWJaceJjKR
         hX7V+YrBwMhI9rJTNoxs+Y2+nagxJU9gOlv3el5QaQ174wow0QOMpXauKltmhiuZ2Y
         hJyi6IS98RSJO+D417/dvIW/v/ixa/rJ9bp3T2d5qpWwFgBrP6Aqr4iLqqD/190lEy
         J71JCR6V0S6MA==
Date:   Fri, 20 Jan 2023 07:58:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marex@denx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the tty.current tree
Message-ID: <20230120075832.02bc1124@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5/AB2U4D7xjTBJeslbDffu2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5/AB2U4D7xjTBJeslbDffu2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tty.current tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/tty/serial/stm32-usart.c: In function 'stm32_usart_interrupt':
drivers/tty/serial/stm32-usart.c:804:62: error: 'flags' undeclared (first u=
se in this function)
  804 |                 uart_unlock_and_check_sysrq_irqrestore(port, flags);
      |                                                              ^~~~~
drivers/tty/serial/stm32-usart.c:804:62: note: each undeclared identifier i=
s reported only once for each function it appears in

Caused by commit

  f24771b62a83 ("serial: stm32: Merge hard IRQ and threaded IRQ handling in=
to single IRQ handler")

I have used the tty.current tree from next-20230119 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/5/AB2U4D7xjTBJeslbDffu2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPJrvgACgkQAVBC80lX
0GyhmQf+JbrqXjpyQu8xpasu681oFJjQ0cAiMCes2a773vFayUcymgW7Fjq0UDHk
ZIZT+3mmQOeNFA3D5AQ6rJSl5eyYxslv3h1vDxUvxvo5KQlvrecDsZld539XhMQy
bDqvEsY2CZDx82LVkgM1PqOfO9V4blSxvnyBcwSYcGvcwmoY6WrSZaG+IIrxPBec
HFxkHa2kaMC8tb5iVSq1ElK9t85gtq7UmyKVlSxX/h02nxxc/BNfyja1TrOeuHOq
/+ILEjtEOEGMER4oig/9QAhnfMoo1lgxUndlSQzMHzF1QOa4lbqpl//xSoRurJGX
Kcv4De38zZ9PzdGlhA+bE+07Z8SNmw==
=hofW
-----END PGP SIGNATURE-----

--Sig_/5/AB2U4D7xjTBJeslbDffu2--
