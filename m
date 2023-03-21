Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7066C347D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjCUOkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCUOkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF86298ED
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679409552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=te2wjPxLotIIBWis0C4qhukl42NU3760NpTaXDtKkAA=;
        b=EbVzPZrKdkvnCdwIpfWLMotNblRPD0f+5pk2lPjGnYXFmo28DdBkRZ0ThavnCju19SjOnN
        /N/MfLMQZMDPzjxdCXwREojR7cRqL09CUJvbAdPv/MN/DEgu1RQLEyWbV52yBWohoOOBz2
        ZYq8jFMoEpEGEUvmsO4fvAbt3SP8sTA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-MOaFrRVgOha05xutUUB10w-1; Tue, 21 Mar 2023 10:39:08 -0400
X-MC-Unique: MOaFrRVgOha05xutUUB10w-1
Received: by mail-wm1-f69.google.com with SMTP id j16-20020a05600c1c1000b003edfa11fa91so2498980wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409547;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=te2wjPxLotIIBWis0C4qhukl42NU3760NpTaXDtKkAA=;
        b=exwfvmdZKeJnp50rrTP3yHUI9xlil4rCbZsR3KRm2mxbC1X+3S8SRLmAkxNtMW7vfk
         /iSxCdIbcwcrgTP0lkmT6+ULKP5DIOeKMys3AvBfZxnYoV5g/P/tMPSrpDasIObowtZ0
         9VDtdpHW46W8vgQ6wZpNoN6csqACQsdKG8IiQFEnL9K4Bi0uAccHu67QUJvN4J3SXZpt
         BS8wmq+z+xHv/Cf8oG2iAiEfDZdx/Oz/XxyqM8ByH9VfrwwcOeQSGX6eWA4P+EFQ9/ax
         hPyK+6WP+2jxlyUsP5SqfmTqvABmjzjN/4JXpmgJlfvgkBaUlIbOg1XvuV6RUM/NklUm
         yvSQ==
X-Gm-Message-State: AO0yUKWsGIq9BviytkEyX311iTfORP+4nTSxDgH6/Rqvxi61IF/uHZXo
        ClN5doOlPtFSn+ypwMjWw2CDcjlBkmVRNDLRXURoEVT/0XjLKWOvjYvbcGvNeaR1vp1//hO67M+
        D0psMMJNr1WdcKyWiexQSRNAB
X-Received: by 2002:a05:600c:4744:b0:3ed:ebcb:e2c6 with SMTP id w4-20020a05600c474400b003edebcbe2c6mr2966522wmo.3.1679409547707;
        Tue, 21 Mar 2023 07:39:07 -0700 (PDT)
X-Google-Smtp-Source: AK7set8Jpe5k8eJaSDWziJnwP3NQWvprpto6X93PPJIuPivb6Bx6XPYOeMSt783Ld3ERpqKIUsu/Vg==
X-Received: by 2002:a05:600c:4744:b0:3ed:ebcb:e2c6 with SMTP id w4-20020a05600c474400b003edebcbe2c6mr2966505wmo.3.1679409547445;
        Tue, 21 Mar 2023 07:39:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-244-19.dyn.eolo.it. [146.241.244.19])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c1c8f00b003ed793d9de0sm2618439wms.1.2023.03.21.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:39:07 -0700 (PDT)
Message-ID: <7589589f340f1ecb49bc8ed852e1e2dddb384700.camel@redhat.com>
Subject: Re: [PATCH net v2 2/2] smsc911x: avoid PHY being resumed when
 interface is not up
From:   Paolo Abeni <pabeni@redhat.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        netdev@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 Mar 2023 15:39:05 +0100
In-Reply-To: <20230320092041.1656-3-wsa+renesas@sang-engineering.com>
References: <20230320092041.1656-1-wsa+renesas@sang-engineering.com>
         <20230320092041.1656-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-20 at 10:20 +0100, Wolfram Sang wrote:
> SMSC911x doesn't need mdiobus suspend/resume, that's why it sets
> 'mac_managed_pm'. However, setting it needs to be moved from init to
> probe, so mdiobus PM functions will really never be called (e.g. when
> the interface is not up yet during suspend/resume). The errno is changed
> because ENODEV has a special meaning when returned in probe().
>=20
> Fixes: 3ce9f2bef755 ("net: smsc911x: Stop and start PHY during suspend an=
d resume")
> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Changes since v1:
> * no change
>=20
> In smsc911x_mii_probe(), I remove the sanity check for 'phydev' because
> it was already done in smsc911x_mii_init(). Let me know if this is
> acceptable or if a more defensive approach is favoured.

Since this is a fix, I would keep the old check, too.

> @@ -1108,6 +1102,15 @@ static int smsc911x_mii_init(struct platform_devic=
e *pdev,
>  		goto err_out_free_bus_2;
>  	}
> =20
> +	phydev =3D phy_find_first(pdata->mii_bus);
> +	if (!phydev) {
> +		netdev_err(dev, "no PHY found\n");
> +		err =3D -ENOENT;
> +		goto err_out_free_bus_2;

Why don't you call mdiobus_unregister() in this error path?

mdiobus_register() completed successfully a few lines above.

Cheers,

Paolo

