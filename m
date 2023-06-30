Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296DD743B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjF3L6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjF3L6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:58:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA76171E;
        Fri, 30 Jun 2023 04:58:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 291E56173B;
        Fri, 30 Jun 2023 11:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CF5C433C0;
        Fri, 30 Jun 2023 11:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688126294;
        bh=og/alEAgFmUrna29k3gmbnQ2qlv9qDvV6lg1WZdZS3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XG4Ryok+6n2Ff+5jP1ZgE0I38G9bhUJJIvahc3FNxUc8luaLi0OpjlRlR7XC7uHlO
         DsBOorTzcHghPWzPJUJuBORYQlEaV4yDWKZpFAdzQlmPN7oPNsY0Ca+r+nBnS6Jxge
         VwpwCY9LRnYc2kTrIHlJ/KcFG0S1QpkxHWgbGkOqdOChnuWrcgS67QvK50wugItFJG
         /acH2V6uA1yKmNBxK61IZ9Dk3n042V6cgJkXULvfh08PTuVaVwhC9mUxhPoWcEHSDp
         NO0a7qwNiIown7xwZov6l+EYthAjy++agd04DGX/9bmAVn5ccUb9cKfiRHhM4SVZdK
         C97ZAfhc26UkA==
Date:   Fri, 30 Jun 2023 12:58:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "Sahin, Okan" <Okan.Sahin@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <4283e3aa-14b5-4b2e-9a8a-aeee1e493c27@sirena.org.uk>
References: <472a4d86-3bfb-4c2b-a099-f1254dd01e24@sirena.org.uk>
 <20230629072500.GA2110266@google.com>
 <d070eecd-cb3b-4968-803e-1817a1a4359a@sirena.org.uk>
 <20230629155134.GB2110266@google.com>
 <7987cbbe-55bc-49a9-b63a-7f1906bf5f74@sirena.org.uk>
 <CAL_Jsq+AQrv7EGMtEkB-2cBCvA4mLHuMbyQ=f39yQkYPkvfVww@mail.gmail.com>
 <998ef8d8-594e-45e3-9aa3-ec9061cf7f11@sirena.org.uk>
 <CAL_JsqK1X-oZHerE9qhcPZ=mFsm7rJa3KxWGBqV3znHHfr6vaQ@mail.gmail.com>
 <920531c8-b5c1-409a-9cda-3ec77ba944e7@sirena.org.uk>
 <20230630071751.GC2110266@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q6ikaDz92rEr7KkW"
Content-Disposition: inline
In-Reply-To: <20230630071751.GC2110266@google.com>
X-Cookie: Old mail has arrived.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q6ikaDz92rEr7KkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 30, 2023 at 08:17:51AM +0100, Lee Jones wrote:
> On Thu, 29 Jun 2023, Mark Brown wrote:

> > My suggestion is that once the core is ready to apply that and also
> > start applying everything else to Lee's tree as it's ready.  A branch
> > also works and might come in handy anyway in the case where there's some
> > subsystem wide updates in some other subsystem (since it avoids having
> > to pull the whole MFD tree in or anything like that) but it's not
> > essential to the idea.

> The issue we currently have is that the core usually comes with a header
> file which is included by some or all of the leaf drivers.  If leaf
> drivers are pulled in without that header, the drivers will fail to
> build which will make people grumpy.

Which is why I'm not suggesting doing that.

> The suggestion of a separate branch that's added to over time as leaf
> drivers become ready is even more work that a one-hit strategy.  It will
> also mean littering the working branch which a bunch more merges and/or
> more frequent rebases than I'm happy with.

As I said you don't *need* to do the separate branch, it's more of a
nice to have in case cross tree issues come up, and it'll probably work
fine most of the time to just put the incremental commits directly on
your main branch even if there was a separate branch for the initial
batch.  This all becomes especially true as we get close to the merge
window and the likelyhood of new cross tree issues decreases.

--q6ikaDz92rEr7KkW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSew00ACgkQJNaLcl1U
h9AvZgf9EKqEitJbUm3ywtBy7eGuYkv7xgaky391q0cvAAhIIh36P3G47f7uIEF3
sGvPJxuu/5oSmkxW3Ir0kJB2tBbQviAFG2uaFVxf3F0BZOnsIc+VJIY357uPuB9E
mt8BOcMip1jI2xeX5R8C4S8axp5Ce+n/cmMseOCPRAMHP7xVf1TdFSGA2mFqwSNJ
bOlq1bqUGvs8ZwLfej//laEnWQKEspPrQ5rYZASRVx+85HtLgkUM665FVa6Jg/QF
hkCIezMosvl/qzfBMK72Z42Bk3HAM3xYFCpy0eiha+NJDBHsWIX1GruVclkn9n4R
8jlIG43meWFkYsrt1KiQ+E8+9wJk6Q==
=HBKs
-----END PGP SIGNATURE-----

--q6ikaDz92rEr7KkW--
