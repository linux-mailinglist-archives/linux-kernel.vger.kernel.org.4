Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ACE6DF1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjDLKHS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Apr 2023 06:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDLKHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:07:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7925D9000
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:06:45 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-11-OIVFlk1zNIulZSxCxWqPCg-1; Wed, 12 Apr 2023 11:06:42 +0100
X-MC-Unique: OIVFlk1zNIulZSxCxWqPCg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 12 Apr
 2023 11:06:39 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 12 Apr 2023 11:06:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arseniy Krasnov' <AVKrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Richard Weinberger" <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
        "kernel@sberdevices.ru" <kernel@sberdevices.ru>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/5] mtd: rawnand: meson: replace GENMASK() macro with
 define
Thread-Topic: [PATCH v1 2/5] mtd: rawnand: meson: replace GENMASK() macro with
 define
Thread-Index: AQHZbQcFy/8yOpNpAUyIp49WWIi1Cq8ncmZA
Date:   Wed, 12 Apr 2023 10:06:39 +0000
Message-ID: <2f89000bdbbb4e2bb7f1dd96c1b498f9@AcuMS.aculab.com>
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <20230412061700.1492474-3-AVKrasnov@sberdevices.ru>
In-Reply-To: <20230412061700.1492474-3-AVKrasnov@sberdevices.ru>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arseniy Krasnov
> Sent: 12 April 2023 07:17
> Subject: [PATCH v1 2/5] mtd: rawnand: meson: replace GENMASK() macro with define
> 
...
>  		len = mtd->writesize + mtd->oobsize;
> -		cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
> +		cmd = (len & NFC_CMD_RAW_LEN) | scrambler | DMA_DIR(dir);
>  		writel(cmd, nfc->reg_base + NFC_REG_CMD);

What is the point of the mask?
If the length is too big it just generates a different
'hard to debug' error.
If the length can't be too bit there is no point masking it.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

