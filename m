Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5096B2179
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCIKca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCIKc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:32:27 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40F14E5D0;
        Thu,  9 Mar 2023 02:32:21 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9F267240008;
        Thu,  9 Mar 2023 10:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678357939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+cXRuoz2crxClbePA4aHujvCEPsQDErwoIVjnqXYZ3c=;
        b=CfZUI4CsJcfRJwl5byLRWsTuib2qcfQ1YrORvwF0Al2CQtmagw8kLvsZ1CwINuX7VNHw7w
        sMqyDm9af0+OxDHfAhqcT5dMG6oso2lcDhkERrGB+4m5ieN9P7NfeybwFcf05BAw74CnFo
        HAWR/OPoDc+gCrJ95khSdDX1EjmQCbBA+THvW7PLJVpIRN2sEHVpKFGeU22fEXrPGMSmz2
        htvAuphDa7vCHEhGS8pUJ8zmncPt7dBOB1vzVUdTJVxnh/b5bGzzxHrNBR3fZZuvDetyXN
        wdaHadDHDiZUXEvckldMV3L8mhl3RXIs0BGP3HOEYjXVr37CNAjKfqc5jc44ZA==
Date:   Thu, 9 Mar 2023 11:32:11 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Walle <michael@walle.cc>, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/4] nvmem: core: allow nvmem_cell_post_process_t
 callbacks to adjust buffer
Message-ID: <20230309113211.6321ce3d@xps-13>
In-Reply-To: <37f821b8-f681-08e4-d4f1-d37be191ff7f@linaro.org>
References: <20230222172245.6313-1-zajec5@gmail.com>
        <20230222172245.6313-3-zajec5@gmail.com>
        <37f821b8-f681-08e4-d4f1-d37be191ff7f@linaro.org>
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

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Thu, 9 Mar 2023 10:12:24 +0000:

> On 22/02/2023 17:22, Rafa=C5=82 Mi=C5=82ecki wrote:
> > @@ -1791,11 +1792,15 @@ ssize_t nvmem_device_cell_read(struct nvmem_dev=
ice *nvmem,
> >   	if (!nvmem)
> >   		return -EINVAL; =20
> >   > +	/* Cells with read_post_process hook may realloc buffer we can't =
allow here */ =20
> > +	if (info->read_post_process)
> > +		return -EINVAL; =20
> This should probably go in 1/4 patch. Other than that series looks good t=
o me.

FYI patch 1/4 is also carried by the nvmem-layouts series, so it's
probably best to keep these 2 patches separated to simplify the merging.

Thanks,
Miqu=C3=A8l
