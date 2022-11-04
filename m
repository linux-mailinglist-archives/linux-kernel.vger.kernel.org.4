Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB52618DCA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 02:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiKDBsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 21:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiKDBsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 21:48:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F66324083;
        Thu,  3 Nov 2022 18:48:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N3Nnn6lwFz4xGQ;
        Fri,  4 Nov 2022 12:48:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667526526;
        bh=Sw8ahRMEJhKbsmXfbRquLX9VUEUzLmgtYJuC3Xv2+IE=;
        h=Date:From:To:Cc:Subject:From;
        b=dsYfepOk79XuQf+UoGXkBoA87aUNf1Keu0OKqyDdNwEfuSo5aa2kgSxHtFubtQwgM
         goqImN/x+icdDCHc06GkOXiIt0xiCOJiBA5FPRsZVAVZpxzjCgo0CihJFz3nmjhVve
         6kRz9it/t1mKAYS5JuTZ7YE2PSjeeXgKAssZe8zD4rBOaLZy4VnvR53UqLSOS1eZwv
         G9O71r9pNUOET3mki9LzGbLxIJ9lzdecAsAhRqPOJY7211vXo3mYZJ4THnhMnw/BFZ
         8R9tSW0ruCO2I758d2h8j2aAYNf5ZGFMkN7d17oDfKBTYUTHJrorgMqtU3kKvWkg04
         FI6ox3dWUypvg==
Date:   Fri, 4 Nov 2022 12:48:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Corey Minyard <cminyard@mvista.com>
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the ipmi tree
Message-ID: <20221104124840.51ab5b5c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ca7G/cqBi.HxMd8M3bO8V7c";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ca7G/cqBi.HxMd8M3bO8V7c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ipmi tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/char/ipmi/ipmi_ssif.c: In function 'shutdown_ssif':
drivers/char/ipmi/ipmi_ssif.c:1276:9: error: implicit declaration of functi=
on 'del_timer_shutdown'; did you mean 'device_shutdown'? [-Werror=3Dimplici=
t-function-declaration]
 1276 |         del_timer_shutdown(&ssif_info->watch_timer);
      |         ^~~~~~~~~~~~~~~~~~
      |         device_shutdown
cc1: all warnings being treated as errors
drivers/char/ipmi/ipmi_msghandler.c: In function 'cleanup_ipmi':
drivers/char/ipmi/ipmi_msghandler.c:5547:17: error: implicit declaration of=
 function 'del_timer_shutdown'; did you mean 'device_shutdown'? [-Werror=3D=
implicit-function-declaration]
 5547 |                 del_timer_shutdown(&ipmi_timer);
      |                 ^~~~~~~~~~~~~~~~~~
      |                 device_shutdown
cc1: all warnings being treated as errors

Caused by commit

  306ab2918b4c ("timers: ipmi: Use del_timer_shutdown() before freeing time=
r")

I have used the ipmi tree from next-20221103 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ca7G/cqBi.HxMd8M3bO8V7c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNkb3gACgkQAVBC80lX
0Gz69gf9FtzKZYfPo3f059cujYxPvcVZNh4xMK00Q8BeHMa/H89WaUBAwFJpqx/h
rI6v59BT2nr6ofMbq3x8qNn587/1a/qBnY7zxy+/stiQU89fiwC0PsYwamgBXCGe
rtgulLUVEOm+n3fIxDv/Y3+KGYJZ7PIZW7ZIXYieqtV9wlnMX0cly8QPGFcmgTn6
1V0EMJnnzVJT8ZWTedOri6y4qtx8vFu9ReoWHtPqFCKUnWwvHoF7vdBzNQwtayM7
KZd+lfiFAvToJaR92LWuWqQk41BApMzjg+YXL16RR8WyHjD7QSDISkf37hzvd8lv
fz0b1ZB52qMIJvqD15mQA4E6NUmeTQ==
=ujV8
-----END PGP SIGNATURE-----

--Sig_/ca7G/cqBi.HxMd8M3bO8V7c--
