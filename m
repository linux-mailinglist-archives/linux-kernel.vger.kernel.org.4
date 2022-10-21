Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34562607839
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiJUNUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJUNUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:20:18 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4040E09E6;
        Fri, 21 Oct 2022 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666358407; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9PZQHCJizz9XI1SIZdia67urvalf6FhSv/SC9QESuyw=;
        b=oX1x4cqrkUx772EwB7qp03fVmeM3lIl7k50o0rYidmAdO7gSEGY0H5dmurzzMLxmDSVE83
        lJqELmyEW+bLeFjCwmMk1OECYnYvYKh8gQuticEdHGUCRizDay/32nCgeGIWjuSmUiCDL0
        CuLGvOBkNR4WstoIXY7BRCVcsoMmIfo=
Date:   Fri, 21 Oct 2022 14:19:58 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2] leds: max8997: Don't error if there is no pdata
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Message-Id: <ADU3KR.HZPTLZCKPHT63@crapouillou.net>
In-Reply-To: <20221021131145.GB16264@duo.ucw.cz>
References: <20221020114442.22215-1-paul@crapouillou.net>
        <20221021131145.GB16264@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le ven. 21 oct. 2022 =E0 15:11:45 +0200, Pavel Machek <pavel@ucw.cz> a=20
=E9crit :
> On Thu 2022-10-20 12:44:42, Paul Cercueil wrote:
>>  The driver works just fine if no platform data is supplied.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20
> Does it? Bad Paul, bad Andy.

Yes, it does.

>>  +++ b/drivers/leds/leds-max8997.c
>>  @@ -238,11 +238,6 @@ static int max8997_led_probe(struct=20
>> platform_device *pdev)
>>   	char name[20];
>>   	int ret =3D 0;
>>=20
>>  -	if (pdata =3D=3D NULL) {
>>  -		dev_err(&pdev->dev, "no platform data\n");
>>  -		return -ENODEV;
>>  -	}
>>  -
>>   	led =3D devm_kzalloc(&pdev->dev, sizeof(*led), GFP_KERNEL);
>>   	if (led =3D=3D NULL)
>>   		return -ENOMEM;
>>  @@ -258,7 +253,7 @@ static int max8997_led_probe(struct=20
>> platform_device *pdev)
>>   	led->iodev =3D iodev;
>>=20
>>   	/* initialize mode and brightness according to platform_data */
>>  -	if (pdata->led_pdata) {
>>  +	if (pdata && pdata->led_pdata) {
>>   		u8 mode =3D 0, brightness =3D 0;
>>=20
>>   		mode =3D pdata->led_pdata->mode[led->id];
>=20
> I see pdata being dereferenced here.

Oh really. Look again.

-Paul


