Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8355FC85B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJLPZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJLPZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:25:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5523CBE4;
        Wed, 12 Oct 2022 08:25:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b15so15575645pje.1;
        Wed, 12 Oct 2022 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6sAsGYX3J2Ywp9AFoeC19lv0Q2JC+XewfioV1XazBfU=;
        b=jgi1xr+4QST0cSoTuy8B71zEhLRujUBFMmA2BVNnhFBYOrwMJYkfeGc+6ZKyPK+TNP
         nrUdJF6SJsfr5h6R7MiA4nbWoy0HzA9PCrTVyvV9y+QArbRRkVxsINbjyDLNKtN9JJB0
         ewlXtu5d0yyASUjtnHtEOgR/zp17y8ysYLSwtChvEvoTi9+l1S1VAxlKIXQH1zA3yGGq
         8+6gTLZEpp6stncaM5fPBF7g0yEogepFARSQPunLTD0jEH7U81tP69d6lGXWS2vnK69m
         fNVz3iUv9qxziIiHeCIZpId3kwaWXT9HoUuqLQqejdX9/ribfs9Zjro6fFOgAE7oOkIh
         /Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sAsGYX3J2Ywp9AFoeC19lv0Q2JC+XewfioV1XazBfU=;
        b=InZC9m1KGm48uIGVnVgHimTwPtCp6UaZoCkcPvl4SCpkl1NxXOrj4JHLzzt8Sk5vIy
         qe0Qug7Ce2nEADgyiHRRo94cHvCU/QypiPZV/6/sa3nvpGzjRn4Pf7ZcHAAjo5W/fnfW
         KLma6+IQyluOHAn8ivQ0seDSfZKPGREgCLkTexKbob4lhxJmLxvkVdynrHLCLDbFE5aa
         EpnwpINXv/qjixo/HR7ux3SdKtH36dl/SDu3Hcu0+2rjEs9hG93mhGnvugnwGc853yhS
         XLoFTNsqOE5YUXVnq37EroSbx5+F6NmYGJG4Flq8ZYZLCnd8hNqOkpF2LyxStAq07v7j
         AsKQ==
X-Gm-Message-State: ACrzQf1vAiK4Xj+AdBec2vfN1gaZcmVnKBm6Ib/KXc0dzRW2XR/sv/6U
        vYLb+9RcVVAY3y5rbZ54tcw=
X-Google-Smtp-Source: AMsMyM5q5hLAeKBSRDeDIPS3wFojXBXzDAqLX57Ia7Z5Bbj+fAAsK05mNKIES79/ba29CBEIihr7/A==
X-Received: by 2002:a17:902:d589:b0:181:d0e4:3306 with SMTP id k9-20020a170902d58900b00181d0e43306mr19405557plh.28.1665588310827;
        Wed, 12 Oct 2022 08:25:10 -0700 (PDT)
Received: from ?IPv6:::1? ([2607:fb90:370a:3fc:ad3:2951:4f00:9866])
        by smtp.gmail.com with ESMTPSA id u186-20020a6260c3000000b00561c6a4c1b0sm11536115pfb.176.2022.10.12.08.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 08:25:09 -0700 (PDT)
Date:   Wed, 12 Oct 2022 08:25:06 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_7/7=5D_gpiolib=3A_of=3A_add_quirk_for?= =?US-ASCII?Q?_phy_reset_polarity_for_Freescale_Ethernet?=
User-Agent: K-9 Mail for Android
In-Reply-To: <12081856.O9o76ZdvQC@steina-w>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com> <20221011-gpiolib-quirks-v1-7-e01d9d3e7b29@gmail.com> <12081856.O9o76ZdvQC@steina-w>
Message-ID: <9266C00F-0F8F-4DE2-B4DD-08B2D7B1EE4E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 11, 2022 11:14:46 PM PDT, Alexander Stein <alexander=2Estein@ew=
=2Etq-group=2Ecom> wrote:
>Am Mittwoch, 12=2E Oktober 2022, 00:19:35 CEST schrieb Dmitry Torokhov:
>> Bindings for Freescale Fast Ethernet Controller use a separate
>> property "phy-reset-active-high" to specify polarity of its phy
>> gpio line=2E To allow converting the driver to gpiod API we need
>> to add this quirk to gpiolib=2E
>>=20
>> Signed-off-by: Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom>
>> ---
>>  drivers/gpio/gpiolib-of=2Ec | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>=20
>> diff --git a/drivers/gpio/gpiolib-of=2Ec b/drivers/gpio/gpiolib-of=2Ec
>> index 3200d705fbe3=2E=2Ec3d3fe4d927c 100644
>> --- a/drivers/gpio/gpiolib-of=2Ec
>> +++ b/drivers/gpio/gpiolib-of=2Ec
>> @@ -231,6 +231,33 @@ static void of_gpio_flags_quirks(const struct
>> device_node *np, !strcmp(propname, "snps,reset-gpio") &&
>>  	    of_property_read_bool(np, "snps,reset-active-low"))
>>  		*flags |=3D OF_GPIO_ACTIVE_LOW;
>> +
>> +	/*
>> +	 * Freescale Fast Ethernet Controller uses a separate property to
>> +	 * describe polarity of the phy reset line=2E
>> +	 */
>> +	if (IS_ENABLED(CONFIG_FEC)) {
>> +		static const char * const fec_devices[] =3D {
>> +			"fsl,imx25-fec",
>> +			"fsl,imx27-fec",
>> +			"fsl,imx28-fec",
>> +			"fsl,imx6q-fec",
>> +			"fsl,mvf600-fec",
>> +			"fsl,imx6sx-fec",
>> +			"fsl,imx6ul-fec",
>
>> +			"fsl,imx6mq-fec",
>> +			"fsl,imx6qm-fec",
>
>These two should be 'fsl,imx8mq-fec' & 'fsl,imx8qm-fec' (imx8 instead of=
=20
>imx6)=2E

Thank you for noticing this=2E I'll fix it up in the next version=2E

Thanks=2E

--=20
Dmitry
