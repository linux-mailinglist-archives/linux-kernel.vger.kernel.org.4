Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7767368CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjFTKGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjFTKFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:05:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCE91AC;
        Tue, 20 Jun 2023 03:05:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C106661193;
        Tue, 20 Jun 2023 10:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA59C433C9;
        Tue, 20 Jun 2023 10:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687255531;
        bh=vc5WlVlGI94okyigrFf0d+GSybFc03mLe2FWiiXr8N0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sddhdzg2AhtXOX2BNswSTh047C+vw9hNecLzglmn1TpZi9ZIiK9ocqIu4pRfUM3Xj
         bVwHX9pEykboXk/Oqllb3Mmr9AwMLuFWpbC1QL4ohgeWHuIgXPstMLe6vOp8q4J1mH
         f+4/Dxq9YAqg8GdgHonl8n3IDPWtFo9Dn36eTA3eai/DOvUCg8U1EW4SjgDg0NigCG
         Fkpm/Vsly5A7K+wHG/wMBAefevtdl0a/1xqkOGH8GAa/kXPpLMqrhj4KvCbvYlHIL5
         XZ3IXxDX9Fen5aA5uGl6Y706YeZw/kj9cr6uBj+bmn2mxKH3EEZlLRw0TBfizniERA
         ac7vKTEAnEWnA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBYEt-00080a-8T; Tue, 20 Jun 2023 12:05:31 +0200
Date:   Tue, 20 Jun 2023 12:05:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] gnss: ubx: add support for the reset gpio
Message-ID: <ZJF56yaeyIGiK9qu@hovoldconsulting.com>
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-5-wsa+renesas@sang-engineering.com>
 <ZJFSjrf41PHe400c@hovoldconsulting.com>
 <ZJFsGWepuvkSjL9a@shikoro>
 <ZJFtdWK5I13YUUcu@hovoldconsulting.com>
 <ZJF0U/mIniEksVwZ@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q/yN9VCYAD/fgz9L"
Content-Disposition: inline
In-Reply-To: <ZJF0U/mIniEksVwZ@ninjato>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q/yN9VCYAD/fgz9L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 11:41:39AM +0200, Wolfram Sang wrote:
>=20
> > But can you elaborate on the "disappearing" bit? How exactly does it
> > "disappear" when the gnss0 device is *not* opened?
>=20
> When you send an I2C message with the address of the device, it usually
> ACKs it to say "Hi, I am here". When the ublox device is in reset state,
> it does not ACK its address. So, tools like "i2cdetect" will not report
> the device as "someone is listening there".

Ah, ok, so you used it to verify that reset is working as intended.

Rereading the commit message now it makes more sense, I guess I was
thrown off by the reference to I2C. Perhaps adding a sentence or two
about the alternate interface and using it as a means of verification
would make things a bit more clear.

Johan

--Q/yN9VCYAD/fgz9L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZJF55wAKCRALxc3C7H1l
CDIpAP4kmGFSuyp69uWui9laihxxH35pNGIkCvnQs1MAIZYvAgD+MVPI7cZ+4WKi
ctaineUcuYKMsPqBCC8411pUQElQiQE=
=oN5T
-----END PGP SIGNATURE-----

--Q/yN9VCYAD/fgz9L--
