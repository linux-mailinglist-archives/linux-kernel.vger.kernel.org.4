Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6DD6FEFE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbjEKK1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbjEKK11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C9C8A4E
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683800798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RhczK8dDlliuVGSzk9PMw10+gj4mVel9O/McDJEwOJU=;
        b=EF2rTFtKHpYPtx5zEDGOUUfkZRkyekOqvYV/on4dlZWQ7l42Leku1X0q56iZ/YTlllhHjx
        b97rxe7DGAwwDq+ZmzHKynkMT/Bhg6Xdaizuy/vjKaUvTsFD6I4yX+uDex+VlfKnz9gmUD
        ctGFlHpOaVKzvSsi9CNsPm6oyBwd1+Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-vRMWItqsO-WAHDFj8WG4Ug-1; Thu, 11 May 2023 06:26:37 -0400
X-MC-Unique: vRMWItqsO-WAHDFj8WG4Ug-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-307ae58624dso159402f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683800796; x=1686392796;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhczK8dDlliuVGSzk9PMw10+gj4mVel9O/McDJEwOJU=;
        b=WBEZsSH4lXRemfIxjybf6yKca+bc05NcUtdk20pDAPaCmrbLdOllWqTV/Omw4Q3TpU
         3k2lt+oK96vS82k8KA79wQSWQ4Qi4dazn+XSNWBwNGALDYfod58PrM6gxXCIMaasUSwq
         gjN7lSTdkJfiHATxX4L10sflT8q+ad2y0MDS0pgvTWhAB2TnJvqbYbjbDmhpgeawwy6j
         qQG0qIC756ZUkVrEX7rLYSFOeDCFwNM2DZUsB/6whM9ojmHpIgaoyT/E6iyCiORyZRKq
         LzpXvq9MzEXc33U7DaG1ulMe/8lV6pikfmPhY+lxMySC6uymDUuv2dvLcCNz7w+sqVcU
         T3aw==
X-Gm-Message-State: AC+VfDycrB6YfLc0UsanFmdixA0/wTV+uuWlnnI/iRz9gGe5T4Jqr/8g
        IixRmyJlGJAZ0BRMOe+xSRMTQUnXMCuWD6zYGQtQG/ThUrNmkoA/KP7S95UsdQIgOmp4PBC4Knf
        ig10bWxMArLRVzfBUlUjckHLR
X-Received: by 2002:a05:600c:350a:b0:3f1:78bd:c38b with SMTP id h10-20020a05600c350a00b003f178bdc38bmr14676290wmq.4.1683800796461;
        Thu, 11 May 2023 03:26:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63NU4Oof1bATaeQhgP8Iy50937zSMDTB6Qrx0C92vLioRIcxbSK8LmdgeNCuXGMWSrGWa1Qw==
X-Received: by 2002:a05:600c:350a:b0:3f1:78bd:c38b with SMTP id h10-20020a05600c350a00b003f178bdc38bmr14676270wmq.4.1683800796103;
        Thu, 11 May 2023 03:26:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-149.dyn.eolo.it. [146.241.243.149])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4c42000000b003063db8f45bsm19893247wrt.23.2023.05.11.03.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 03:26:35 -0700 (PDT)
Message-ID: <8aebd38cf057cf659d5133527f55e1ced0e6f70c.camel@redhat.com>
Subject: Re: [PATCH net-next v2 2/3] net: phy: broadcom: Add support for
 Wake-on-LAN
From:   Paolo Abeni <pabeni@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc:     Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marek =?ISO-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 11 May 2023 12:26:34 +0200
In-Reply-To: <20230509223403.1852603-3-f.fainelli@gmail.com>
References: <20230509223403.1852603-1-f.fainelli@gmail.com>
         <20230509223403.1852603-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2023-05-09 at 15:34 -0700, Florian Fainelli wrote:
> @@ -821,7 +917,28 @@ static int bcm54xx_phy_probe(struct phy_device *phyd=
ev)
>  	if (IS_ERR(priv->ptp))
>  		return PTR_ERR(priv->ptp);
> =20
> -	return 0;
> +	/* We cannot utilize the _optional variant here since we want to know
> +	 * whether the GPIO descriptor exists or not to advertise Wake-on-LAN
> +	 * support or not.
> +	 */
> +	wakeup_gpio =3D devm_gpiod_get(&phydev->mdio.dev, "wakeup", GPIOD_IN);
> +	if (PTR_ERR(wakeup_gpio) =3D=3D -EPROBE_DEFER)
> +		return PTR_ERR(wakeup_gpio);
> +
> +	if (!IS_ERR(wakeup_gpio)) {
> +		priv->wake_irq =3D gpiod_to_irq(wakeup_gpio);
> +		ret =3D irq_set_irq_type(priv->wake_irq, IRQ_TYPE_LEVEL_LOW);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* If we do not have a main interrupt or a side-band wake-up interrupt,
> +	 * then the device cannot be marked as wake-up capable.
> +	 */
> +	if (!bcm54xx_phy_can_wakeup(phydev))
> +		return ret;

AFAICS, as this point 'ret' is 0, so the above is confusing. Do you
intend the probe to complete successfully? If so, would not be
better/more clear:

		return 0;

?

Thanks,

Paolo

