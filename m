Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D806E81BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjDSTPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDSTP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:15:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478BD5BA1;
        Wed, 19 Apr 2023 12:15:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLccC/QRy/W9cWbJNDzH+ERbbyFXjzssKdpcsmcnQbZQWCTDCXlaVJ7h6jZH4oxPEgq+XiIlr4OXRocUmunok8SQgU6tFiWTOuHqTtgd2u0PC3zi/9QrqWnhvLaWc5G1CMb6FhGyuRpwqi0Ek3T4kPltBKn6pAnSR9S3tu1myNkzGtavsqY6PMCr64tG+g6agJGu9tkjW7OtA6UriM7kQjmWv2nb1t6RoQBoa/eBQi+G5UnsIPdfz/MvuFT+2WUBhMbledtbWS2j8R5IJUIONAHQFnQYBlBSpeAb/KugKpnHIzfNunrRLRQthFqCXKXrqnhu6hqNcwrihhmO6AH1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZEqIsa4sqU6g9powWv6/gQ0+9RhX7HcgUK6LzrHpCY=;
 b=fDCtr01UlH+rpRfCkaCYyNkZERxNwiXklWRdpNLgyq4tTgLMRz8X7M47F4aYB0FbyWEN8Pc5pV8eMDb/MwmW+SH/riRwX6uAQcs3h63p6aS1LyjFgqBW6ms8C3GqfvvKXJzHQ+DD9MdpNS9OnM3NeinQFsVmVURg9AFowYKB+36OdCOXt16gLB5fistv7yapsAV65F5e01o5hFMMuPmIS4YS9dsY/KJOPUkvhinErdiK8DMVyS+lnNDWfgOg7quEoi+gLE/6KgvFj1mJTDcwi0xMFgSlvnwPT/cAOpypZ+aQAgMBa45xrawqq+gb3DJ4bpzShmdz3/SRVDlm6YPzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZEqIsa4sqU6g9powWv6/gQ0+9RhX7HcgUK6LzrHpCY=;
 b=oUxyctjyjQvl5oKAHfdqkgOanNBrBiIRAHI1GfZnbg2FUMkGnUPwS6Ox8ZV1Phgsul3IpnaBLiK2mjMZsZbK6H7HTsVkdMknwxbGcPYlU7SbJWFqqLJx3BYdHGIrOxQNQde9VypsIJJcuJ30saqyc89hVtypfw557kkOPFn0FzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SJ0PR08MB7783.namprd08.prod.outlook.com
 (2603:10b6:a03:3de::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 19:15:21 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%6]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 19:15:20 +0000
Date:   Wed, 19 Apr 2023 14:15:17 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] dt-bindings: input: touchscreen: goodix: clarify
 irq-gpios misleading text
Message-ID: <ZEA9xZH5+nEjDWcS@nixie71>
References: <20230419171849.946986-1-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419171849.946986-1-luca.ceresoli@bootlin.com>
X-ClientProxiedBy: DM6PR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:5:174::29) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SJ0PR08MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe298bb-976c-4f78-f994-08db410a6ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5IzAw936m3H2NlooZ7zK29RFz6sxtl7GCp2Lpe7rcxHSp45hKXkz8/8jGPASWRXKwFg9c5FgfAo0jitPha5tSpNJMRAhbRNf5EFcSq2vBtL38FnWWh8cy0i04Nb/VrquKrxbsHr2/UVca0GnVJ0QzkHum+2PfL2zVbwAd4lp2vXwRBMXQw4tWuHBtv4ua83GB9W97PDhmJb6rpwW42MJcsaAljAownMe3V70QuGOd9ONIGh+NVfQA34rtlc3xLd1umj6oAFLHtXFNuLHQ7M4LStoRyZutPliu7R8Cv7d1u5fOJFixzdFGSFdjavVXmCYEsqDMTXLLa6n1x1k40rvD9icSRFDv1V+37zv/a4gp/ppCqG+mtsvYG/WjEQTWwbSoW2J8i8AcrboWPAL+0IsTiOJfzACXQh68awlVfk3/49xKHIZDWv4ZAFVhc25w3vImhThS99p8G13y4bY4pIQ3CW3s2b9T5YlefCiKYsKzUDaw7IXfPX1650EKtKagakzr7f5JDR6n8xfwHFJ2Btbqcg/uF+wO9NiMyAZ0oWf7uRVKy7szLonRFtre6ODWwO4rB0f2mf/VAXfj4N3VlJzRhlIu5LeGzQYSekE54GxIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(346002)(39830400003)(396003)(366004)(451199021)(186003)(6916009)(4326008)(54906003)(316002)(66556008)(66946007)(66476007)(6486002)(478600001)(6666004)(8936002)(33716001)(8676002)(5660300002)(41300700001)(7416002)(2906002)(86362001)(38100700002)(26005)(6512007)(6506007)(83380400001)(9686003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OXFkxqnhGF9eunw2XReGSHykh3T2KDMSj/yKnDkBTJlBeKnTLD2Ep9hVe/vs?=
 =?us-ascii?Q?KvJfkbhGHsBoBSw3RpM8ZzvPXvMj+W1OVko8uyH8C7E2B2pggdIhqEIB0j3E?=
 =?us-ascii?Q?MGexfLUsoKg5+lwXroKBuiliBjy2UlNRE1dbRpq1fwt83jYkJNEPrXeGgcmA?=
 =?us-ascii?Q?Qkyk71xIRi7baS+2JLGa/ynQ5kevbJcRyLlVlVEzJFFTZOBbWBfIuZ3/FB3N?=
 =?us-ascii?Q?7QxOV10FOraOzBaaxwL9OgGdTqCYd6Dp4RyMuSHlUdwpDKAeCTMiZEEbLVgg?=
 =?us-ascii?Q?n5OZQLfF2j6YUxDIAz3XB1TneeWjwVDFDB/9oUJOjIZaF8a0grSiHcYuAHXI?=
 =?us-ascii?Q?Oj685HB9fQbBb7gCNlth/snBN8dHEixqMUNgYRroRFadtNdiHLrhmnwsz75x?=
 =?us-ascii?Q?D30unXUvYHd9SqHeXjMz+62XKnywsKJQ+YM6TOmt2KT4RG+UdaT5umUyadSD?=
 =?us-ascii?Q?5tj+HAKYhFpWpW1Hg7qB9qlrGpylUXo0z3ZYobCmqEpPhtxK0jyZGZRaWDy4?=
 =?us-ascii?Q?dGy0v3yaLH9luVEXjH0RAQLBQGdJnJf0wJP8Sx5sV7cfZ906TITIloBHK8NI?=
 =?us-ascii?Q?sNHEwqb9dTjmxZIeyABhwmu0034spT9P5K1xDKze7J6QMxxsDEKi2D7Aaa+R?=
 =?us-ascii?Q?Z/qwCQZjY14OoWB3qFufw8LO11SDfKg2/Qf+s0pK2QEtnsf8zdQIyLQ4scI2?=
 =?us-ascii?Q?LCmiAXEyatTe1xYUqRPsiWum1THwKZV36oIIdIEqv9gQD7nwHzwN5PT4FT0V?=
 =?us-ascii?Q?1WL7YtO2UUVHWPBxKVCALtRyLQ2tn3xEeBaqGABtbSK50ntev0nUyA2gYISq?=
 =?us-ascii?Q?Nia4BK+H0O5ro9ZzetPWnz0ppWQRyNP4eGEbrIY8sblD5rUruJTJBhFRD9V5?=
 =?us-ascii?Q?OJ/OtboR4cJVHonw0o1inZm1uCOUnblF77NrQfeB8Hi91I85oezJL6vrIgAN?=
 =?us-ascii?Q?Be0Cs9oG6P54Ya7UX3Wyd8daA1LXxUgw4l2j1TrAABJAIkX/5Rzppqh6Q3sO?=
 =?us-ascii?Q?jar2tLwwdW7OFqgOuQb4uUQcaIrckLpELcJ3TJgsWzSqDB6BXpr3I4BEz5w7?=
 =?us-ascii?Q?nPsE2oY0EcX5Db5tVRXBij8pEj+4Hmv16dOyJRfnWNbN8pPc3LQOZ/maLArz?=
 =?us-ascii?Q?lyT0rJfxyiM71onfn3cowaSxyDLtcGu38hv3mkR4xGc4I9aVxwQE+1qMDxon?=
 =?us-ascii?Q?cyrnCQHD/QiAAsDkrYMo9/qYe8rGflsbUc3oyV3Q3Afke7PWwhiRdDNZG0fu?=
 =?us-ascii?Q?JFZEow67wDKQ4tLW9Q9rE5K4mVyK0fpYL+MKnEAcjWSs4yIW1/re2rGz2Nws?=
 =?us-ascii?Q?4ffUKPMCCcw6fxBp90UVV/b1muzyC61rADdUAhgFf47EbU2M5D3FzGU7k54z?=
 =?us-ascii?Q?VWzDplG1M5pAZZeCxbarl+l/+gi4tY5A3AXLCiX2uVRcZPClwth0WPQhxolv?=
 =?us-ascii?Q?Vn2cH57XeGkIIokZFdIM2C4u72F+t2u2gbf0K7Ih8JHGsYDkgwyMEisWJIyn?=
 =?us-ascii?Q?p4tFsVs3K6R2y83gknAh9asEFU2GsE8GAu4RHLxHkTU/QDiWNyPGJYy3T46D?=
 =?us-ascii?Q?f0cb7z77ARbF8vmJBJQUSwLIIOxMe/TjAXIYoC1B?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe298bb-976c-4f78-f994-08db410a6ac5
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 19:15:20.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3TAf269wtMQSjytCjcZytp94LNdr9iWCNXcnjMJC0FFCrWgs+NbYVHvMEPyuCM2OoHvEFp2Sq2DENUvXwx3pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB7783
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Wed, Apr 19, 2023 at 07:18:49PM +0200, Luca Ceresoli wrote:
> The irq-gpios description misleading, apparently saying that driving the
> IRQ GPIO resets the device, which is even more puzzling as there is a reset
> GPIO as well.
> 
> In reality the IRQ pin can be driven during the reset sequence to configure
> the client address, as it becomes clear after checking both the datasheet
> and the driver code. Improve the text to clarify that.
> 
> Also rephrase to remove reference to the driver, which is not appropriate
> in the bindings.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  .../devicetree/bindings/input/touchscreen/goodix.yaml         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> index 3d016b87c8df..26ad104052ba 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> @@ -37,8 +37,8 @@ properties:
>      maxItems: 1
>  
>    irq-gpios:
> -    description: GPIO pin used for IRQ. The driver uses the interrupt gpio pin
> -      as output to reset the device.
> +    description: GPIO pin used for IRQ. The IRQ line can be driven during the
> +      reset sequence to configure the client address.

This is a step in the right direction, but in my humble opinion it is now
ambiguous who drives the bidirectional IRQ pin (device or driver). Perhaps
combining both versions conveys the appropriate message:

"...The driver uses the interrupt GPIO pin as an output to configure the client
address during the reset sequence."

>      maxItems: 1
>  
>    reset-gpios:
> -- 
> 2.34.1
> 

Kind regards,
Jeff LaBundy
