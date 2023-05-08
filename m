Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FC06FA010
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjEHGoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjEHGoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:44:06 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BEB6EB9;
        Sun,  7 May 2023 23:44:05 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 3D10DD25;
        Mon,  8 May 2023 08:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1683528244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oNsckQr9pOwjisGyDfnqn2Dt5LCUUag4cKDrtkUUgbo=;
        b=yZbmEUowMPK1RDPRDXzVEfIhgO+Gp2ZY5SAjbKwAGRGp2XLNCpNp/ge9jxqN9Z1fdABbUb
        JMp6HxemOz5Zpn2DanP22eZYqXPIzti5DiMGeGdzQ2+GHQ1gzbBU2CXK24yv3BU6No6VP4
        wA25uVISha7Mh8iV1p+unyjY4z2q8jqxtWPeO3hTMS6NdOkIFqxTfOdqQ2TSgjEqTJKf5x
        /yTVnxDWsbzY11TeJUaSNa95HGffURThgNHs3cLil6AuBDiKN0XryUqAWMp7wToHPIas/O
        lcuR39mWDjYypNdwtXIEihjn5gfN+1yvzyM8o7BaqYfLhHDGhhleIkoRqZpgJw==
MIME-Version: 1.0
Date:   Mon, 08 May 2023 08:44:04 +0200
From:   Michael Walle <michael@walle.cc>
To:     "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        kumaravel.thiagarajan@microchip.com,
        tharunkumar.pasumarthi@microchip.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v11 char-misc-next 2/2] misc: microchip: pci1xxxx: Add
 support to read and write into PCI1XXXX EEPROM via NVMEM sysfs
In-Reply-To: <20230429120209.2232-3-vaibhaavram.tl@microchip.com>
References: <20230429120209.2232-1-vaibhaavram.tl@microchip.com>
 <20230429120209.2232-3-vaibhaavram.tl@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <78faf23f4f746f332dc53f7f981ac0fe@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> @@ -219,6 +348,22 @@ static int pci1xxxx_otp_eeprom_probe(struct
> auxiliary_device *aux_dev,
>  		return -ENOMEM;
> 
>  	priv->pdev = aux_dev;
> +	priv->nvmem_config_eeprom.type = NVMEM_TYPE_EEPROM;
> +	priv->nvmem_config_eeprom.name = EEPROM_NAME;
> +	priv->nvmem_config_eeprom.dev = &aux_dev->dev;
> +	priv->nvmem_config_eeprom.owner = THIS_MODULE;
> +	priv->nvmem_config_eeprom.reg_read = pci1xxxx_eeprom_read;
> +	priv->nvmem_config_eeprom.reg_write = pci1xxxx_eeprom_write;
> +	priv->nvmem_config_eeprom.priv = priv;
> +	priv->nvmem_config_eeprom.stride = 1;
> +	priv->nvmem_config_eeprom.word_size = 1;
> +	priv->nvmem_config_eeprom.size = EEPROM_SIZE_BYTES;
> +
> +	priv->nvmem_eeprom = devm_nvmem_register(&aux_dev->dev,
> +						 &priv->nvmem_config_eeprom);
> +	if (!priv->nvmem_eeprom)
> +		return -ENOMEM;
> +
>  	priv->nvmem_config_otp.type = NVMEM_TYPE_OTP;
>  	priv->nvmem_config_otp.name = OTP_NAME;
>  	priv->nvmem_config_otp.dev = &aux_dev->dev;
> @@ -258,6 +403,9 @@ static int pci1xxxx_otp_eeprom_probe(struct
> auxiliary_device *aux_dev,
> 
>  	dev_set_drvdata(&aux_dev->dev, priv);
> 
> +	if (is_eeprom_responsive(priv))
> +		priv->is_eeprom_present = true;

What's this? The eeprom isn't there (or in whatever state), then you
still register the nvmem device, but read and write doesn't do anything
useful. You shouldn't register the device in the first place if it
is not functional.

-michael
