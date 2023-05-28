Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECAB713BF1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 20:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjE1S4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 14:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjE1S4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 14:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24409BE;
        Sun, 28 May 2023 11:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B547C61328;
        Sun, 28 May 2023 18:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E89C433D2;
        Sun, 28 May 2023 18:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685300202;
        bh=JDYChD/vhzIWiUOnUxUBVKV4YxXceKDOuf90kByVAbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CwxRSZPI7c3dF4UAgivHhpR9UekVEr825YEoDm+Bs0009aLIX+M4+Qcg84u8NfE3g
         xZIRiCmHSrWigmW2XGjuaSeGUchxtZqWtIG0/4t2ddIvhrVJFT/MmEC8DaNFInr20X
         sgatrvSK7LZGeDaWFoe/o9re4lqSoMJqrXg+7ikKbja8bQ3NxT0f6MLCUIEIm6s6Yd
         1iGPlN/LOz1snMFMZ7kAOP8+AKnBS43oatYXQHli2hqBj1gx+ZD6t00qdFitxwCLp3
         Hd9YQjFYOSajlZa6vDDDEfSmYly3BFFuXYIfNqHianfW6jiSu588bC79RAW+X5EcQR
         VRFaiy0MOR8RA==
Date:   Sun, 28 May 2023 20:13:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: addac: ad74413: don't set DIN_SINK for functions
 other than digital input
Message-ID: <20230528201301.68b31bca@jic23-huawei>
In-Reply-To: <822d2741-32ff-fc73-28a5-25575ab3cc52@rasmusvillemoes.dk>
References: <20230503105042.453755-1-linux@rasmusvillemoes.dk>
        <27fe41e402ea0d6ef42aa0ac80aa3d1488862cd8.camel@gmail.com>
        <6fcf4997-9d88-7e86-70f7-52f9d296bc6e@rasmusvillemoes.dk>
        <20230506191636.3cff4b24@jic23-huawei>
        <822d2741-32ff-fc73-28a5-25575ab3cc52@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 10:44:11 +0200
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> On 06/05/2023 20.16, Jonathan Cameron wrote:
> > On Thu, 4 May 2023 12:08:53 +0200
> > Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> >  =20
> >> On 04/05/2023 09.28, Nuno S=C3=A1 wrote: =20
>=20
> >>> Can anyone have a working device by specifying that dt parameter
> >>> on a non digital channel (or expect something from having that parame=
ter set)?
> >>> Or the only effect is to actually have some functions misbehaving?   =
=20
> >>
> >> The data sheet doesn't say that the DIN_SINK should have any effect for
> >> other functions, so I'm pretty sure it's only the latter: some functio=
ns
> >> misbehave.
> >> =20
> >>> On the driver side, if it's never right to have
> >>> these settings together, then the patch is valid since if someone has=
 this, his
> >>> configuration is broken anyways (maybe that's also a valid point for =
the
> >>> bindings)...   =20
> >>
> >> Yes, I do believe that it's a broken description (whether or not the
> >> bindings specify that), and drivers don't need to go out of their way =
to
> >> validate or fixup such brokenness. But in this particular case, there's
> >> really no extra burden on the driver to not put garbage in DIN_SINK wh=
en
> >> a not-digital-input function has been chosen (the patch is a two-liner
> >> with 'git show -w'). =20
> >=20
> > If we can tighten the DT binding to rule out something that should not =
be
> > set than that would be good.  Tightening bindings is fine - we don't mi=
nd
> > validation of bindings failing on peoples DTs as long as we didn't 'bre=
ak'
> > them actually working. =20
>=20
> Well, I'm afraid I don't have any idea how to spell that constraint in
> the yaml-language (help appreciated).

Lots of examples in tree of this sort of thing.   Look for a=20
: false with something other than additionalProperties or unevaluatedProper=
ties
Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
for example.

In short you have an allOf block containing a list of rules, one of which
is a match on particular conditions to set particular properties to 'false'
which means that any attempt to have them set when that condition is met
results in an error from the dts checking scripts.

>=20
> And I assume a dt binding update would be a separate patch anyway, so
> could you please consider applying this patch?
Fair enough. Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

>=20
> Thanks,
> Rasmus
>=20

