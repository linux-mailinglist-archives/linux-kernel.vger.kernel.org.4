Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE99C74903A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjGEVuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbjGEVt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:49:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891081BD0;
        Wed,  5 Jul 2023 14:49:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b852785a65so151485ad.0;
        Wed, 05 Jul 2023 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688593765; x=1691185765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JlA7Omc66rXMNTH6X1ydcJJyDlSBvcJI/ger0lg7xWk=;
        b=l/5lrwFm5S27bh4okIpLe8W9g6TnfrmD1hDoFUP4abPVME+Ose3bNs1mtZu//oMoGx
         Us1VUD1Oa4+QAEDOl/FzgagEbhT4xkFJw/WOg/tmKtVUYovVKA9LtaVgLJVzXIsjID/X
         iI8+jQ35Sm+dLdbO2EtVjfuOpwJS9RHZesZJdXb2CgQ0/JDJjV0KYCXxHGw4+CttLq8A
         fOqoD+c0bT1fwV75DK6LuTwwXgFhHol8ONfy7Ai+SaxID89n58Sd118zXK7UjVXarm83
         vrzARZoooAdW2+SopGdlqtAfDX/VCdOManSfphUqpxakZi2Mi+o67/VpDvwGxOKLAUQI
         PLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688593765; x=1691185765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlA7Omc66rXMNTH6X1ydcJJyDlSBvcJI/ger0lg7xWk=;
        b=gB7uV8kGnnLNbO3IkergJRPCTsZWKuftcUmA12UfvzGt6Mmr/gaCbQBffN37tXgDGK
         OPAqwh0EDWRDtaGS7WbsJu5glRX5FRBQWXHGs2IG5ZvHGEdxKAvgjiZ+JlxXUmUhgMPu
         45WgH9E9qM5jGzEB44fAUNaK+6ja1K9UXXQydSDmqDy7SxkNs3eh0mySG7jH2fqMxyBK
         dh5CtgWqnfBT3N3U/4UXYZf09xtzIa3tj0iRKeWbnnyWCwZ1OqNjSGDDBZ796e/Y7dUQ
         kaEXmEmSocxItiIqYKXckDHuUj9iePJgkvFgAN6hs886HQvnTa/+aJaTHfnYEnwgytmF
         QCxw==
X-Gm-Message-State: ABy/qLZOAOApkFuhvgQF12UBxEVetRzwPUVDqSnl6tF4krwU49pG+5A2
        j4n99UJtgfTifdNZLxArTRQ=
X-Google-Smtp-Source: APBJJlEPLpeBpRKLD+37mMaaabZCQQ3DaaVqaA+uW4TAiRKZXbYJOk1GzZrrd/fAet6CUy09hUwL8A==
X-Received: by 2002:a17:902:e78a:b0:1b8:7613:594d with SMTP id cp10-20020a170902e78a00b001b87613594dmr4383059plb.24.1688593764637;
        Wed, 05 Jul 2023 14:49:24 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9fac:a99f:7f0a:397])
        by smtp.gmail.com with ESMTPSA id bh1-20020a170902a98100b001b3f039f8a8sm13129482plb.61.2023.07.05.14.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 14:49:24 -0700 (PDT)
Date:   Wed, 5 Jul 2023 14:49:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: exc3000 - Support power supply regulators
Message-ID: <ZKXlYbsk+6MPfeWy@google.com>
References: <20230703084536.8429-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.12499438-d166-465a-8847-b25e1baa3dad@emailsignatures365.codetwo.com>
 <20230703084536.8429-2-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703084536.8429-2-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Mon, Jul 03, 2023 at 10:45:36AM +0200, Mike Looijmans wrote:
> Add power supply regulator support to the exc3000 devices.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
>  drivers/input/touchscreen/exc3000.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
> index 4af4c1e5d0da..3e50af8a4a2d 100644
> --- a/drivers/input/touchscreen/exc3000.c
> +++ b/drivers/input/touchscreen/exc3000.c
> @@ -18,6 +18,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/sizes.h>
>  #include <linux/timer.h>
>  #include <asm/unaligned.h>
> @@ -360,6 +361,12 @@ static int exc3000_probe(struct i2c_client *client)
>  	if (IS_ERR(data->reset))
>  		return PTR_ERR(data->reset);
>  
> +	/* For proper reset sequence, enable power while reset asserted */
> +	error = devm_regulator_get_enable_optional(&client->dev, "vdd");
> +	if (error && error != -ENODEV)
> +		dev_err_probe(&client->dev, error,
> +			      "failed to request vdd regulator\n");


If there is a regulator described in the firmware we should not continue
with initializing the device if we fail to grab/enable it. Think about
what happens if you get -EPROBE_DEFER here. You should return here.

Also, why are you using the _optional() variant? VDD is not an optional
for the controller. regulator_get_optional() is needed when you need to
alter the behavior of the device/driver depending on the presence of an
optional supply, whereas here it should work fine with a sub supply that
will be created if you simply call devm_regulator_get_enable() and there
is not regulator mentioned in DT/ACPI for the board.

Thanks.

-- 
Dmitry
