Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33367399C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjFVIbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjFVIbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:31:03 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCD81FEC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:30:40 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687422637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2C9OAWtennWoPZrbFNAF7xrc7sanFnVYruKnET/n8o=;
        b=UuruDO1dWX/jbVqs7EYehuAANp/CTONsONPudYXvjfzRjcxVbdG+/ZPWaUzO4oOmlmGIEI
        GeWhqKUDLEskr0m1jxN8I9BiqMgme7xrh1DVr9rk1ImiYNICtLWRaUYfJA8LHWTIyPnF+U
        DFcFqx7FYx7gYOPGsRJfsaVN+pk8D41jTavaC9NQ6B9JE6YZ93Gpzpm8OIhA39nVPoqHjy
        n2Yien8ZoSkgaS5OOKeRbNp2r6IJkbfsiIerSGpTmsgGkNUdPEXkE1Q3xgYJCrRIpDJauJ
        hIMJ+F+DC//mtdY0VBRBEkGyDXKy4M3RpuU18U7qCZpEofKgnxrXz2NT58gbeA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A93871BF20D;
        Thu, 22 Jun 2023 08:30:33 +0000 (UTC)
Date:   Thu, 22 Jun 2023 10:30:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/2] mtd: prepare for dynamically removed devices
Message-ID: <20230622103032.0febdb25@xps-13>
In-Reply-To: <20230620131905.648089-1-alexander.usyskin@intel.com>
References: <20230620131905.648089-1-alexander.usyskin@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

alexander.usyskin@intel.com wrote on Tue, 20 Jun 2023 16:19:03 +0300:

> Prepare mtd subsystem for devices that can be dynamically removed,
> like memory on PCIE card.
> Use refcount to prevent crashes when underlying device
> removed unexpectedly and reshuffle __get and __put functions
> to allow underlying device to clean it memory according to refcount.
>=20
> Alexander Usyskin (1):
>   mtd: call external _get and _put in right order
>=20
> Tomas Winkler (1):
>   mtd: use refcount to prevent corruption
>=20
>  drivers/mtd/mtdcore.c   | 86 ++++++++++++++++++++++-------------------
>  drivers/mtd/mtdcore.h   |  1 +
>  drivers/mtd/mtdpart.c   | 14 ++++---
>  include/linux/mtd/mtd.h |  2 +-
>  4 files changed, 56 insertions(+), 47 deletions(-)
>=20

The idea is of course great, the implementation looks fine, but the
risk is too high at -rc7 so I'll take this at -rc1 for the next
release.

Thanks, Miqu=C3=A8l
