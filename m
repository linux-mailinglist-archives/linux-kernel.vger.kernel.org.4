Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A8C645672
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiLGJ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLGJ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:28:46 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3D211A35;
        Wed,  7 Dec 2022 01:28:43 -0800 (PST)
Received: from [192.168.182.212] (pa49-196-243-253.pa.vic.optusnet.com.au [49.196.243.253])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B9E26200E6;
        Wed,  7 Dec 2022 17:28:39 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1670405321;
        bh=6l4r7simpKUMuXx6ig8BZefzYMf1MV2GW2hjFSVYB3I=;
        h=Subject:From:To:Date:In-Reply-To:References;
        b=iih8kZY/n9JA/10HAslqwyMusOnuWGjLwPpGhYdw2IMqfTOcW+o4KNQP0AmGIb4ZT
         akNoXR1EHZTvgDeWvIhq3ubcu9h+zRxXNY0v+kRBJTQAfb4Iw0sJ4DilekDMANSSLv
         RfsT5ETPLVqf2t3Nt5vUoYa5JgKQIk6iT3NGFXf/E8PkTCD8otLPH/RDtd/GyTZeDV
         6jM5A58z+nP9pyrE/qFmawfvuXoPxHCCsHrgErmI8I+niZktNz2bgzKXx+ZZazyWA7
         aF7LrFy9u6HLWNb6ojOAT5vU33mfu0eb+bzEu3utDglg3PDiR60atnP8DJbMIXYzyP
         pPD9Y1tQy0jyQ==
Message-ID: <0a8f144c920c63598a7283ad95975c3d5a7d7018.camel@codeconstruct.com.au>
Subject: Re: [RFC PATCH 2/2] mfd: syscon: allow reset control for syscon
 devices
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Date:   Wed, 07 Dec 2022 17:28:39 +0800
In-Reply-To: <5a57e163-c705-4308-93ac-11e0cea2804b@app.fastmail.com>
References: <20221206073916.1606125-1-jk@codeconstruct.com.au>
         <20221206073916.1606125-3-jk@codeconstruct.com.au>
         <e46a680f-e891-489c-9747-98ae3df42ade@app.fastmail.com>
         <a83f62d604e70a8e58309dc7a5e2e3515227e1c4.camel@pengutronix.de>
         <b29dceb0-a07f-4e12-9e7b-6fead4db826d@app.fastmail.com>
         <ff70222596646757cbd6e2f24aadf3247183061d.camel@codeconstruct.com.au>
         <5a57e163-c705-4308-93ac-11e0cea2804b@app.fastmail.com>
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


> Hmm, it's clearly not doing what I was remembering it to do ;-)
>=20
> Before 2014 commit bdb0066df96e ("mfd: syscon: Decouple syscon
> interface
> from platform devices"), it was supposed to be the same regmap in
> both cases, with the linked list being maintained to ensure we
> never get more than one instance for device_node.

Yep, that makes sense with your earlier suggestions.

> After this commit, I see that the platform_driver no longer matches
> syscon nodes from devicetree, but only those nodes that have
> platform_device.dev.name=3D"syscon" and are created from board
> files. The only user of manually created syscon devices at the
> time was mach-clps711x, but that has been converted to DT
> a long time ago, so I don't even see anything using the
> platform_device at all.
>=20
> This would in turn indicate that we can completely remove the
> platform_driver code, but I don't see how your RFC patch then
> had any effect because it wouldn't actually perform the
> reset for any devices in mainline kernels.

I've been changing a few things at once, it's entirely possible that my
testing is incorrect!

So, I'll add the reset controller linkage in just the DT-based code,
and leave the platform device as-is. And then make sure that I'm
getting the correct regmap <--> reset interactions :D

Cheers,


Jeremy
