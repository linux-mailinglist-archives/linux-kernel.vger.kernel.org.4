Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE196B3B37
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCJJqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCJJqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:46:36 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF2C1514C;
        Fri, 10 Mar 2023 01:46:19 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4DA3F1C000E;
        Fri, 10 Mar 2023 09:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678441577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0R9Fl/afFUae2+l0/vC5lPFGhFJJAoVkohC/AkbfR0=;
        b=LPXdW8lr63zWnNPHnFokXGR3FBBXMztuWKCUmgJ+PteaoxqtlVrWv5Yc3nvr5t/m4E1KNF
        TMFwxC4erX3lxXOVcRa5jZWvHcN6zZJ/ZT5KOdFajSsHnwhZowha9kp2HQ0oHKINPhBSUt
        9b0qeaZuZ5mSW7aM4kNsqWZoyBWNpKnGf+o1iVZ5pT+4SCxcUT4hlA6oEIvVFZqTBG3FBD
        +kZ3+TSgl+F4z6758Awu6AEkfi/+nNPWlQqoiWEAoYSk434UUvml82AgfvBjlhxG6pDDzo
        0m/ocnEwS7exGQzFxRvvitiFa4NfaSXDnWybObQx6SSlKta4yKL3JvPq4AIsRg==
Date:   Fri, 10 Mar 2023 10:46:15 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFm?= =?UTF-8?B?YcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3] dt-bindings: nvmem: convert base example to use
 "nvmem-layout" node
Message-ID: <20230310104615.3cf5de31@xps-13>
In-Reply-To: <9d8ef6df-c0b4-f578-26c3-b186d43c9660@linaro.org>
References: <20230310075145.3996-1-zajec5@gmail.com>
        <20230310075145.3996-2-zajec5@gmail.com>
        <9d8ef6df-c0b4-f578-26c3-b186d43c9660@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Fri, 10 Mar 2023 09:29:18 +0000:

> On 10/03/2023 07:51, Rafa=C5=82 Mi=C5=82ecki wrote:
> > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >=20
> > With support for "fixed-layout" binding we can use now "nvmem-layout"
> > even for fixed NVMEM cells. Use that in the base example as it should be
> > preferred over placing cells directly in the device node.
> >  =20
> Fixed layouts are the core part of nvmem, am not sure why you want to dep=
recate this. Either we derive the cell information dt or via layouts or som=
e post processing they should still endup as fixed layouts.
> this way the core part is always same irrespective of where the cell info=
 comes from.

Actually I was suspicious as first but we had a very similar case in
mtd:
- People need partitioning so we add partitions in the mtd node
- People need more advanced partitioning and partitioning becomes a
  mess so we containerize everything in a "partitions" subnode.
  It definitely improves the readability and makes the code more
  resilient: outside of the container, it's not a partition, period.

I believe that's what Rafa=C5=82 is trying to anticipate. Just moving the
fixed cells declaration into a container (and we have one already:
nvmem-layout).

Thanks,
Miqu=C3=A8l
