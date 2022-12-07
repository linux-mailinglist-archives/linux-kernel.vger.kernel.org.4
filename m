Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDBF6454FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLGH46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLGH4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:56:51 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF3C30554;
        Tue,  6 Dec 2022 23:56:50 -0800 (PST)
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D92B2200E6;
        Wed,  7 Dec 2022 15:56:43 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1670399804;
        bh=uhJAeKSiEwcETVAy29NnoEcD5gNca+lhmYO7Gqq/BtY=;
        h=Subject:From:To:Date:In-Reply-To:References;
        b=dlKVQEOzmnyuL9qOvd5MCYxwIzAeVELA/XEmPXM+Z7IBbog/shMY/oITCseV4FXPM
         SSscjovRTYmUu8d89AQv6x4UxHKWbq7lZQYFJmEuTo3yTv8X31qzo+zE/cCpZ5tahq
         /zZSvIP0dXqdignAqDcjwcHkmEw63IaGz7+jLKetrIPy43UTsUo/MRKBd/7RKBA5Sn
         FdVV7AqKnj1F1t7+xe9QABb6L/SkpCWRyVIViNMPiOLTup5e42l99Edplx3+BjF8tH
         Bv0/DL/DmYA5VPZ93Aiu8viPqSXd2OfZTt7q74hoULFaFSPTJ/h4M1lAmZ3oD/twfV
         3b2+VsndQCi+w==
Message-ID: <ff70222596646757cbd6e2f24aadf3247183061d.camel@codeconstruct.com.au>
Subject: Re: [RFC PATCH 2/2] mfd: syscon: allow reset control for syscon
 devices
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Date:   Wed, 07 Dec 2022 15:56:42 +0800
In-Reply-To: <b29dceb0-a07f-4e12-9e7b-6fead4db826d@app.fastmail.com>
References: <20221206073916.1606125-1-jk@codeconstruct.com.au>
         <20221206073916.1606125-3-jk@codeconstruct.com.au>
         <e46a680f-e891-489c-9747-98ae3df42ade@app.fastmail.com>
         <a83f62d604e70a8e58309dc7a5e2e3515227e1c4.camel@pengutronix.de>
         <b29dceb0-a07f-4e12-9e7b-6fead4db826d@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for taking a look a this. Just a question about the early
approach; I'm not too familiar with the internals of the syscon/regmap
infrastructure:

> > reset_controller_register() only initializes a few fields in the
> > passed rcdev structure and adds it to a static list under a static
> > mutex, so there's not much of a limit.
>=20
> Ok, in that case I think we should at least leave the option of
> doing the reset from an early syscon as well.

OK, sounds good - I'll add a direct of_reset_control_get_<variant>() in
the early of_syscon_register path, which should work in a similar way to
the clocks properties.

However: this may conflict with the later platform_device syscon; if the
late syscon tries to of_reset_control_get_exclusive() the same reset
controller (because it's the same syscon node), that will (of course)
fail.

Hence a question about the syscon infrastructure: how are the late- and
early- syscon registrations supposed to interact? Should I allow for
there to be two syscons registered (one through of_syscon_register(),
the other through the platform device probe), or do we expect that to
never happen?

In case of the former, I can just grab a shared handle to the reset
controller instead, but I want to make sure that's the correct thing to do.

Cheers,


Jeremy
