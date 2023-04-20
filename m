Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642146E98D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjDTPz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDTPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:55:58 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A276110;
        Thu, 20 Apr 2023 08:55:55 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B9ECF24000D;
        Thu, 20 Apr 2023 15:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682006154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xQDee/z2XFFx22IZQpnFIHOpdjrphmkJhT/9/bX1Hfw=;
        b=MZIrzR5vcXk+QIdU0DBYFiZ8VpLh3+pN+/9gahku9fhSPxd4xeQxLbNko7Ng5fOKSLx6DZ
        m7Ha6qpLN9luRExbHmVyqzfl/5j2ef5lDZP7zQyAjfo6YD/nZtDdwxmgJIWJsPrIRyVb1o
        OjZ2/fcekT5xGQzTWlJH/QSVNyUlsJHUGnC4qbSNNzUaGOJsmyJ39BgAGra6UjLPJHIV60
        1sKP93jU6l2efIowgo+cWhvpdSSWGfyV0l9i7mHPcP8IGcoN+/qQvCJkhP9uyEsCB9tHX5
        wtn0MakQvi/8cmFlF9RLk2anCQDf10I+2/dQLplWmVkO2vWMpO0qMVrSyZbouQ==
Date:   Thu, 20 Apr 2023 17:55:52 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/3] iio: potentiometer: Add support for the Renesas
 X9250 potentiometers
Message-ID: <20230420175552.58b15819@bootlin.com>
In-Reply-To: <85e214c8-b639-5197-70a1-7279f9418f66@metafoo.de>
References: <20230420121320.252884-1-herve.codina@bootlin.com>
        <20230420121320.252884-3-herve.codina@bootlin.com>
        <85e214c8-b639-5197-70a1-7279f9418f66@metafoo.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 06:47:32 -0700
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 4/20/23 05:13, Herve Codina wrote:
> > The Renesas X9250 integrates four digitally controlled potentiometers.
> > On each potentiometer, the X9250T has a 100 kOhms total resistance and
> > the X9250U has a 50 kOhms total resistance.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> 
> Hi,
> 
> Looks perfect! Just one small comment.
> 
> > +static int x9250_write8(struct x9250 *x9250, u8 cmd, u8 val)
> > +{
> > +	struct spi_transfer xfer = {
> > +		.tx_buf = &x9250->spi_tx_buf,
> > +		.len = 3,
> > +	};
> > +	int ret;
> > +
> > +	BUILD_BUG_ON(sizeof(x9250->spi_tx_buf) < 3);
> > +
> > +	mutex_lock(&x9250->lock);
> > +
> > +	x9250->spi_tx_buf[0] = 0x50;  
> The 0x50 shows up as a magic constant in multiple places, a define for 
> it would be nice.

Sure, a define will be present in next iteration.

> > +	x9250->spi_tx_buf[1] = cmd;
> > +	x9250->spi_tx_buf[2] = val;
> > +
> > +	ret = spi_sync_transfer(x9250->spi, &xfer, 1);
> > +
> > +	mutex_unlock(&x9250->lock);
> > +
> > +	return ret;
> > +}  

Thanks for the review,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
