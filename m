Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60628745398
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 03:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjGCBeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 21:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGCBeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 21:34:09 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5220E134;
        Sun,  2 Jul 2023 18:34:08 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7659cb9c42aso334976285a.3;
        Sun, 02 Jul 2023 18:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688348047; x=1690940047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j+DQp1aToFjJn6ibYm/4PN8jG7y+qtLc+dd9jn1u2OI=;
        b=E247jHIts6Coz6hmPu1O7nST/fEOvOmX8+WSIt8dvPOLEXWrHnbxR8/wZMD7eWOQfA
         VWuEOxQiDxZX2TGM1v1cJTzENETOZ1RTwXjXhPbfHKBlDZERMQ0MzLWQBG2sf45cWvf5
         TKh5cRMAl5Q29jZMz0JhPRozzhHoZodIsIBQ91yhE+QLdGmpjzDzt89AC7M/S72qzn2a
         AVlnBgqkZNvWnvJSs9VW+FNOJHBQusF4u/9r8z7R5++3JVQb0cb5EZNZXAolt3W62II7
         yhCabHg/iIHSZWmXZ+U6AnsKqOzUSbouWdcIm+VutWFROc2Cc1OuWBmxckNnX9zLZA1S
         rJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688348047; x=1690940047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+DQp1aToFjJn6ibYm/4PN8jG7y+qtLc+dd9jn1u2OI=;
        b=geLdkrHdwTIN7W8hXXmwtxRkGhCtXn7O/4Am0Up1USE2b/v4QWtNr5OVj35eTRC4yP
         jCAvSJbaMG4ARUPPsMs4SwHwQyiKu5pgf9LMW1cP0S0rc7Gc5lkAVcMv/oobE5/UoAHr
         Eg0DuAcG5KwNoph7Y1mp88RaoTO8H+a3LjkCtku8zGAYZzn8anYJGysBwxIFfNtN8Pdd
         wj36dmHQYFe/JPGWm7VOJx4RcsqmbmBRwIrBPx2bBXM1EhyoQsqIM77mNwhStoUrUssq
         +2fsZ7mRVwG3oheu/NyS5NBlDvc0cyrn5bZdgvyNo/9YuOvYbr+dSqiTv6iqy/UMFvN3
         gq3Q==
X-Gm-Message-State: ABy/qLbk62z94zjKN/ATUGAeZrU/FzR81GBxdSc9+l0j3BVk3M4nJUUc
        YaUW469rHABg3hupwPfRuAg=
X-Google-Smtp-Source: APBJJlH92Kk5anUzz/btdHsFS1h2wIq4UMijxUHmrjYT7HeyyIRo0qQnTuby7k7tSS0XXQYnB3Oa/Q==
X-Received: by 2002:a05:620a:2547:b0:763:9f31:1588 with SMTP id s7-20020a05620a254700b007639f311588mr10579466qko.70.1688348047293;
        Sun, 02 Jul 2023 18:34:07 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c184-20020a621cc1000000b0066875f17266sm3492941pfc.135.2023.07.02.18.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 18:34:06 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 73EA181BD580; Mon,  3 Jul 2023 08:34:02 +0700 (WIB)
Date:   Mon, 3 Jul 2023 08:34:01 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        David R <david@unsolicited.net>,
        Boris Ostrovsky <boris.ovstrosky@oracle.com>,
        Miguel Luis <miguel.luis@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux RCU <rcu@vger.kernel.org>,
        Wireguard Mailing List <wireguard@lists.zx2c4.com>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Manuel 'satmd' Leiner <manuel.leiner@gmx.de>
Subject: Re: Fwd: RCU stalls with wireguard over bonding over igb on Linux
 6.3.0+
Message-ID: <ZKIlibX5wCgWlonq@debian.me>
References: <e5b76a4f-81ae-5b09-535f-114149be5069@gmail.com>
 <79196679-fb65-e5ad-e836-2c43447cfacd@gmail.com>
 <10f2a5ee-91e2-1241-9e3b-932c493e61b6@leemhuis.info>
 <CAHmME9onMWdJVUerf86V0kpmNKByt+VC=SUfys+GFryGq1ziHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iSZj5c+AXivxuOj4"
Content-Disposition: inline
In-Reply-To: <CAHmME9onMWdJVUerf86V0kpmNKByt+VC=SUfys+GFryGq1ziHQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iSZj5c+AXivxuOj4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 02, 2023 at 03:46:38PM +0200, Jason A. Donenfeld wrote:
> I've got an overdue patch that I still need to submit to netdev, which
> I suspect might actually fix this.
>=20
> Can you let me know if
> https://git.zx2c4.com/wireguard-linux/patch/?id=3D54d5e4329efe0d1dba8b4a5=
8720d29493926bed0
> solves the problem?

The reporter on Bugzilla [1] said it fixed the regression, so telling
regzbot:

#regzbot fix: 54d5e4329efe0d

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217620#c6

--=20
An old man doll... just what I always wanted! - Clara

--iSZj5c+AXivxuOj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZKIlfgAKCRD2uYlJVVFO
o4VvAQC1HOL3pBDT4GLVcFv6vo9unyPwADyfbTt7FItp8GNDGwD/S1k8ndaOLk2I
CQNHucPSMLNR09jmYdkOaFrGjSpluAQ=
=tRvy
-----END PGP SIGNATURE-----

--iSZj5c+AXivxuOj4--
