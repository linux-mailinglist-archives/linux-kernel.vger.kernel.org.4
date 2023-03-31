Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D946D2A62
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjCaVxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjCaVxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:53:23 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B33DE390;
        Fri, 31 Mar 2023 14:52:49 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 1D1064E20;
        Fri, 31 Mar 2023 23:52:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1680299529;
        bh=mIgvKEKbsdZdXYnK/e8dLN1n1nIAYWBRaa+ZNUH6xrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DrRFKoQVTwergRVKrlX2xaQEw0ars3VTGJcr48H7Lyj7osqsJvg0pjG3kXE3zD2Zg
         hHpG99/ZJ2sTn8TYyBDEXfiLwv7zRpHkTyCxxHLYkbrwHZSrC+JR/ENpVEsmzBRuMN
         TJ0D8QBPp9+ok7QNCLl8qCNSqIGYlaIN9pBlg3Wsuah8xs9zEBxLgMcWOowc8Asij6
         H1T1Jg8Weip9F4WktmMae2YH33YE/jHZ7m3lSFHZmafwje9YJtG4OPtyP9Iv7Ebp3e
         pJSKvNzcA462iWC0atau7Vunue4dNQt+D0vFjdBANExk8aGlpvxqihAJZhkt96DxM0
         aiVSRD1Sktm4g==
Date:   Fri, 31 Mar 2023 23:52:07 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>,
        "open list:MODULE SUPPORT" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: Make use of platform keyring for module signature
 verification
Message-ID: <oyf37idsgn3qgonracgtoj6k5lshzt37j5bulnqgigy4t3iy4q@nxy53nmnzuud>
References: <qvgp2il2co4iyxkzxvcs4p2bpyilqsbfgcprtpfrsajwae2etc@3z2s2o52i3xg>
 <ZCc8J6wS1EpXrLQW@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ctfue7uj2awdz525"
Content-Disposition: inline
In-Reply-To: <ZCc8J6wS1EpXrLQW@bombadil.infradead.org>
User-Agent: NeoMutt/20230322
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ctfue7uj2awdz525
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2023 at 01:01:43PM -0700, Luis Chamberlain wrote:
> On Fri, Mar 31, 2023 at 04:30:21PM +0200, Ahelenia Ziemia=C5=84ska wrote:
> > This allows a cert in DB to be used to sign modules,
> > in addition to certs in the MoK and built-in keyrings.
> >=20
> > This key policy matches what's used for kexec.
> Before I nose dive, the commit log should explain why this patch never
> was sent upstream, if it was, why it was rejected.=20
How would I know that?

Searching around on the list, I found an equivalent 2022-02-15 patch:
  https://lore.kernel.org/linux-kernel/840433bc93a58d6dfc4d96c34c0c3b158a0e=
669d.1644953683.git.msuchanek@suse.de/t/#u
and there's even a reply from you in there.

The discussion appears to boil down to
".platform is restricted to kexec",
"there are common setups in which it'd make much more sense to allow
 this, and also it's prety equivalent security-policy-wise",
(this repeats).

MoK/shim is also mentioned, for some reason, even though that solves a
different problem.

> What makes it good now?
Debian and Fedora are using it, and it's what users expect to work.

> Who is using it?
Debian (since 5.3.9-1, #935945) and Fedora (since the time of that bug
 at the very least, as Debian imported from there, so 2019-11-09).

> What are other distributions doing about it?
What does that mean, and also how would I know that?

Best,

--ctfue7uj2awdz525
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQnVgQACgkQvP0LAY0m
WPHbrw//SBTenWvEm3w9KT+/Tf5ZMHvPzqWyHK7Gk4S2x2ivRamjAQY0Y/fRpFU3
PknBjiApowWa8Y8DKi1Q3SOZe55QGssZL4SXRhFsRPH5Mh+Kp7PfBtuRrtSqxd6s
ZS9cRR5HbzdNtieqkOV1G3k+FgTiL9Aj+g49h7wkdpg5wfmsGElVM3dadzG6xUc4
laUhdmds98iWOIGb8gdaUtb0c9ybJpH/h5IyxvkMPui54C2hOoGc8/0XAvjLiItk
PyH7Mw8j4dMA59zMOU+4qel7FhQF0mY24hBa1raEgxmD5x1SBPekplsKnpRxd2Zk
xK4RowUcErTCOGwnwanDJH2EYERKvHeXm87tPENI9FUXGpZFvX773Cr52QadN0iu
k/zDzresRxhdnKrcAzO3gkTYVVIZuA3mx3Sg+9ZYJ5yXVGdaIYhVKrV24VCmuAER
U2i/H4HApPaX368SPNSCVXulXrYYuApSPKRfuWo6Oarx4BLOUeUk3OcYWKH38RCi
A4kjw8eT38fkcbKYN5/PqlYIoRFnDG8NfHUjvnprGw2wVrfGjFUCUNXvDKEqw2X8
Y7IS0oTF/QoatchfqLumkmAS/tozduFAeIhAvIS9tJ6t6Ss3Twt7SzZ2gROtl5JG
a+zVNTcHajZQSFYeb2BJ/wv/djOxpGJKDJ2IYQQwHXEQ8tv7WLM=
=et90
-----END PGP SIGNATURE-----

--ctfue7uj2awdz525--
