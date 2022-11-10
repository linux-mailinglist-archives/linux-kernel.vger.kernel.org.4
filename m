Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A56A62485F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiKJR3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiKJR26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:28:58 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37125FD1;
        Thu, 10 Nov 2022 09:28:52 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7597960004;
        Thu, 10 Nov 2022 17:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668101331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14K4vkigpc+r6ifepskjAS5nboNCAI5rkQqWrxZ4Kk4=;
        b=Nch2Lks2ASc+gcIGppOjqGRMldcSbvpuknlEY5fSStadYxm83tItBCL7GZd5OhSmPthfBI
        9kOsD73/MAttirUbNSLg1CnPnINrWyF350weJQrjSRuHBGhy5a99LKRoMJF3ia2bLbI8L5
        qcPShugX1vcYVz5l5LkTilgkNvZSnYGTjJJ8rOB0Kij/6dtlM/LGURVi2Y6hPvIlqbSsAJ
        euFWoMT4ywWmPO2VY+yGzUNO59I/OpHp3ehrcm7JjxJwSbCl76uPspXNkcrYmCZzvGq9rV
        C/zbmU349Z+6vcXWt0/9FetXgSHRG/ukAafFTKFNSNbbjha3XKBjuunQyn/Xqg==
Date:   Thu, 10 Nov 2022 18:28:48 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/17] dt-bindings: mtd: nvmem-cells: Fix example
Message-ID: <20221110182848.492e4a6f@xps-13>
In-Reply-To: <20221110165906.GA241353-robh@kernel.org>
References: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
        <20221104164718.1290859-14-miquel.raynal@bootlin.com>
        <20221110165906.GA241353-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Thu, 10 Nov 2022 10:59:06 -0600:

> On Fri, Nov 04, 2022 at 05:47:14PM +0100, Miquel Raynal wrote:
> > There is no such thing as a "ranges" property within an nvmem-cells
> > node. There is no use of it, it is anyway not pictured anywhere that
> > this is valid, so drop it from the example. =20
>=20
> For a memory mapped device such as parallel NOR flash. It would be=20
> perfectly fine to translate a nvmem cell 'reg' address to a CPU address.=
=20
> If the partitions are not memory mapped, then it's a gray area. Whether=20
> it makes sense to translate just to just the absolute offset of the=20
> flash device, maybe or maybe not. At a minimum, 'ranges' just means=20
> can translate to the parent address space. The Linux DT translate code=20
> only supports the full translation to CPU addresses, but then it mainly=20
> just supports creating resources.

Ah ok, I missed this possibility indeed, thanks for the explanation.

So I agree the commit log is wrong, but I guess the change itself
is fine because the property should be declared/authorized in the
schema. So here we have two options:
1- Document the property
2- Drop the property from the example

As we currently have no user upstream of this property I would argue we
can keep dropping 'ranges' from the example, knowing of course that
someone might come up some day and document it properly if it is
needed. In this case I would update the commit message to:

	dt-bindings: mtd: nvmem-cells: Drop range property from example

	Memory mapped devices such as parallel NOR flash could make use
	of the 'ranges' property to translate a nvmem 'reg' cell
	address to a CPU address but in practice there is no upstream
	user nor any declaration of this property being valid in this
	case.

	In order to avoid warnings when constraining a bit more the
	schema, let's drop the property from the example, knowing that
	someone might actually properly define it some day.

Would you agree with this change?

Thanks,
Miqu=C3=A8l
