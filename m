Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D575B8A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiINO06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiINO0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:26:38 -0400
Received: from mail.sf-mail.de (mail.sf-mail.de [IPv6:2a01:4f8:1c17:6fae:616d:6c69:616d:6c69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C92DEE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:26:07 -0700 (PDT)
Received: (qmail 29980 invoked from network); 14 Sep 2022 14:26:24 -0000
Received: from p200300cf07104d0076d435fffeb7be92.dip0.t-ipconnect.de ([2003:cf:710:4d00:76d4:35ff:feb7:be92]:50372 HELO eto.sf-tec.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.38dev) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPSA
        for <zeming@nfschina.com>; Wed, 14 Sep 2022 16:26:24 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     Li zeming <zeming@nfschina.com>,
        James.Bottomley@hansenpartnership.com, Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: Increase the usage check of kmalloc allocated object a
Date:   Wed, 14 Sep 2022 16:25:59 +0200
Message-ID: <7266457.TOmriZnqnj@eto.sf-tec.de>
In-Reply-To: <3a72852c-2f28-2916-f02c-b52cb06efd7d@gmx.de>
References: <20220914060428.4039-1-zeming@nfschina.com> <1668528.WaZXzWfjLs@eto.sf-tec.de> <3a72852c-2f28-2916-f02c-b52cb06efd7d@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3490446.bMliCE8gdQ"; micalg="pgp-sha1"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3490446.bMliCE8gdQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Sep 2022 16:25:59 +0200
Message-ID: <7266457.TOmriZnqnj@eto.sf-tec.de>
In-Reply-To: <3a72852c-2f28-2916-f02c-b52cb06efd7d@gmx.de>
MIME-Version: 1.0

Am Mittwoch, 14. September 2022, 11:04:33 CEST schrieb Helge Deller:
> On 9/14/22 08:43, Rolf Eike Beer wrote:
> > Am Mittwoch, 14. September 2022, 08:18:19 CEST schrieb Helge Deller:
> >> On 9/14/22 08:04, Li zeming wrote:

> Yes, your proposal is good.
> Anyone want to send a patch (with a small comment that kcalloc() will return
> at least the required 8-byte alignment)?

Done.

> > And these functions end up propagating an allocation error in this file
> > and it will never reach kernel/setup.c, which seems bad.
> 
> That part I don't understand.
> The return value of iosapic_alloc_irt() is checked afterwards, but you
> probably meant something else?
> 
> > But I guess the only point where this really can go wrong if the PDC
> > returns an absurdly large number of entries.

What I meant was that if iosapic_alloc_irt() fails, then iosapic_load_irt() 
will return 0, which can either be "nothing to do" or "error". iosapic_init() 
is void, so even if it could detect the failure, it can't report it upwards to 
parisc_init(). Which is the same for basically all other *_init() calls in 
there.

Eike
--nextPart3490446.bMliCE8gdQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSaYVDeqwKa3fTXNeNcpIk+abn8TgUCYyHkdwAKCRBcpIk+abn8
TiFmAKCiYz0oM2+UTnWjzFdCTegZHOedFACfSwfqyw+ldoHibEfySzEWC9sw16g=
=rIPh
-----END PGP SIGNATURE-----

--nextPart3490446.bMliCE8gdQ--



