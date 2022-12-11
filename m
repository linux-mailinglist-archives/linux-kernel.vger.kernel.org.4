Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D2B6491DD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiLKCXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiLKCXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:23:38 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63C8F037;
        Sat, 10 Dec 2022 18:23:36 -0800 (PST)
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EB61120031;
        Sun, 11 Dec 2022 10:23:26 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1670725410;
        bh=oRQJsqzCGBMTG33n3iS7RD7axpI2c5pPwbl5xTMRjY8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=PKnsPaLcmvWPEpEKRE06YNL5zsNYumvw8FOLKfhWkrt6HEU8N4znk4v3Pv2UKUb9Z
         mnr+o+f7GU0FIhNCuBqrjVreZI9b0vJDl0o54g0uaZr2iUvW/elUpV3es0Ma8lLm/x
         JLmm0QGVWqayeAfI3BvjOQDwSeYvAG3gkTtZvItntINSrqou+NekqCPU47ex8k1rTz
         Kt8Fy5tqi+0pZHR0VL6Wr76qJqefLWDAVupRYqUwuDGSZHcOVT3Y56dSRKm54vpaBf
         4w/YZxMFk3o0z7kXqwdfaoqgF+gAbTPMecLgFq4yPILWv1/nv7Ix5f1YnRf/4Ht6ZT
         1xdWWbxpqwVTg==
Message-ID: <be3f9f0f68ce371b1a3837d21146daa25ebe77a0.camel@codeconstruct.com.au>
Subject: Re: [RFC PATCH v2 2/3] regmap: mmio: allow reset control in a MMIO
 regmap
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Date:   Sun, 11 Dec 2022 10:23:26 +0800
In-Reply-To: <Y5MvOp7kLoEJfwkk@sirena.org.uk>
References: <20221209013309.407879-1-jk@codeconstruct.com.au>
         <20221209013309.407879-3-jk@codeconstruct.com.au>
         <Y5MvOp7kLoEJfwkk@sirena.org.uk>
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

Hi Mark,

> > A syscon device may need to be taken out of reset before functioning
> > - this change adds a facility to attach a reset control to a mmio
> > regmap, and performs the necessary deassert/assert operations on the
> > reset controller on attach/detach.
>=20
> Managment of reset feels like something that should be done at a
> higher level - typically reset also implies losing all the register
> contents which means it should be somewhere above the cache layer.

Yep, that makes sense. I'll rework to do the reset controller handling
in the syscon layer instead - unless there are any objections to that?

Cheers,


Jeremy
