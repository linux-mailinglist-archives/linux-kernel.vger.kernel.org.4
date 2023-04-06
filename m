Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9526D9643
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbjDFLt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbjDFLtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:49:12 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C00CCC36;
        Thu,  6 Apr 2023 04:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QuJNP0bX8iKUqBrcGwjzdXmqAfisYkTfJpaelOiAAJo=; b=PiMkCT5j8UA76wAHvO2aEt7rCD
        HJA6oPSVS6raZPmRpthSvMo6W3oHEVAgAN9QuLJZ35B+6gJlNhh/m4PCKvLblwCdA/tHQ/I4ajzT/
        f4vhgomvF2g/5pLLVJDA2JqRDhvIZPfDI5I/JxoyJ8cy2iYDYD6JLbfw5qXi2FVWtVd8lKrcXCC53
        xV+H6bdsx9DxKipvuNUFV/HgwThBCD1sJH7t0uISb32D9EnKRiUk+3q8ERhKJ863YXlBmme2K2q0O
        lDkiaLYOH6VJnEtARWi5+VTLh3d8y+Ztc/rvDVyILSt2b4dlXflHL8l0wuKP6EBxndIpgvJuHYTR9
        +BQfSbqQ==;
Received: from p200300ccff190e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff19:e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pkO1L-0002CA-Kl; Thu, 06 Apr 2023 13:43:15 +0200
Date:   Thu, 6 Apr 2023 13:43:14 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hns@goldelico.com
Subject: Re: [PATCH 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel i2c
 LED driver
Message-ID: <20230406134314.25f8d3a0@aktux>
In-Reply-To: <7d8c558f-0d21-91ed-ecd0-cac079d366ee@gmail.com>
References: <20230406060825.103187-1-andreas@kemnade.info>
        <20230406060825.103187-3-andreas@kemnade.info>
        <7d8c558f-0d21-91ed-ecd0-cac079d366ee@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

thanks for the review:

On Thu, 6 Apr 2023 11:57:15 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> > +	priv->regmap = devm_regmap_init_i2c(client, &bd2606mvv_regmap);
> > +	if (IS_ERR(priv->regmap)) {
> > +		err = PTR_ERR(priv->regmap);
> > +		dev_err(dev, "Failed to allocate register map: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	i2c_set_clientdata(client, priv);
> > +  
> 
> The IC seems to have an enable pin. I think you might add the 
> enable-gpio in dt-bindings and try to (optionally) get and enable it here.

It has an enable pin. I would prefer to just have the binding as complete as
possible and have it added later in the driver by someone needing it
since I cannot test that.

Regards,
Andreas
