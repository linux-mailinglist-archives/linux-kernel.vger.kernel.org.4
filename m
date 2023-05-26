Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5919711B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 02:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjEZAm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 20:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEZAmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 20:42:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE6512E;
        Thu, 25 May 2023 17:42:53 -0700 (PDT)
Received: from [192.168.2.2] (109-252-147-95.dynamic.spd-mgts.ru [109.252.147.95])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E80A466056D7;
        Fri, 26 May 2023 01:42:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685061772;
        bh=b7KTbM4WhfYXB/uJQOVCQcF+/n4UsmItxYts7ak+544=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X9p955qco/4LsnrR3Fs9iBBQ6k5LF4ildGWZENBsZXu7Beb5V7+FxMT/CrwVYPME9
         oPadLycKEEy3ZrbSqSqYEhnaYEnJT61A49IhMckbd0qrO6NCc0r1CB/rdvBbFcNRj1
         Qw26UXPNiRkzkKaoKikk76Y8Zhy0GoHC9x/cX5ju6UZ4YCq/+nuoF+rldkSK/PQEvA
         SCwzyj/kA3M+N3OgjLSZ2o60bi6dyk7PPG8NPwBPkl3+8h1su6sL90EhEuOGbKcK1j
         rDOj7viXyrovhz1l+tmnsD4MkxXOas9L7mrz6t+TMyEj/6LS3YCE8JZNKGF7ARTKxN
         H3Now5JbFoTKw==
Message-ID: <a7e0d4f0-a497-8697-e108-5247e11abc41@collabora.com>
Date:   Fri, 26 May 2023 03:42:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/8] iio: adc: rockchip_saradc: Make use of
 devm_clk_get_enabled
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
References: <20230525212712.255406-1-shreeya.patel@collabora.com>
 <20230525212712.255406-4-shreeya.patel@collabora.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230525212712.255406-4-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 00:27, Shreeya Patel wrote:
> @@ -600,8 +560,6 @@ static int rockchip_saradc_suspend(struct device *dev)
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct rockchip_saradc *info = iio_priv(indio_dev);
>  
> -	clk_disable_unprepare(info->clk);
> -	clk_disable_unprepare(info->pclk);
>  	regulator_disable(info->vref);

Why clocks need to be enabled during suspend?

-- 
Best regards,
Dmitry

