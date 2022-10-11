Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8FC5FAC90
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJKGVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJKGUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:20:54 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852BD65D5;
        Mon, 10 Oct 2022 23:20:51 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=dq2BmnmaCKp4/wV07IVLq8YONy0Q1ZGvFxModPbYsQsyLVsV+YYnRK0S11p5v3E4WgQcb+AAe3zbyTYjHNMiaB9QI5L3eaIBr9GodAHRCbHO6Yvnguj1wUoxs/5l2XLBceB5CascMilrhKYONIziu1Mn6YoQdoDvi4UWQgKhkIwGahHGq7pYDioT2i3AMnoPmfzEBR4T0u9D50FMKBPeO1ygogl6tbqL8FBBfMlBAbVptpU1JlZzjGTccmwvMqhZxz51OXtcqom4I3FJ334g7IdHGxIsFMPmi/X4ELsmOAu8283TMqK4bHVl6bONsMFcHobI8yKhPCHCuajP1NiVOA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hun5aseDF5csra66Q6d+Ua4ZUi755X/jHo1VBtzQukw=;
 b=aRxAwmXXdiGI3r/n3cJrMg7fIH1gTCkY+D7/+QRoosGrMsFEjNzEobDNrI9aiYEQ93ai6Na1OtdEbaMQkA/sUBTtNmkoSv09O3CIN9W34lBLIA9Ys7LHVFGOcNx8uupGSd/iqq7swSKZc3+3h7/X0amuzWT4u4HjuSuuKb1f6wWyTjKYlrgdy3wGcHXl6dMlRTzwduh+oq8Ws+urjt2/Vs0dr5hPHWdq/EnWQ7aZeFGnDUmVw+U7md14eHj/UO/Z17ZYO99bgIE1DfuG5xB+InaEdC/fFtXaqLrjsex83kwhK0gW7OQtqlxnd1dKDDsPWJNnkkveBmDv73EXX5W8SQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=topicproducts.com; dmarc=none action=none header.from=topic.nl;
 dkim=none (message not signed); arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hun5aseDF5csra66Q6d+Ua4ZUi755X/jHo1VBtzQukw=;
 b=x34CM0R2oZ1oZy//uK+obhfhOlTtTpFiosfsV4kuVWEWEL5U5KwUuuSjrg8VS3Icfi8Us+pFkGdbWIRvHzNKKZre/GYwrr8/DYDTfqNN6jyMyPVACU8hKRS0Y1HSS1a3nui07bDnHegD9rs/Rzdtgefmqio/lgvgWqoR5d6eljUbYg0m787FTAWEKh2sbwRoD7Zt70669Tx0kEdyqvRNB4qB6q1ydp4Ig+z80atpl0lO57rKmLWM975TkIa7GTA8ITFQ1hQ2+JnrVO3vBMG53VELKEFEAgduswdmWEQfDcmwYbyLQhfGvcofK0svnU5iHiSJ/jV8JTdJsFJO1+YjKw==
Received: from OL1P279CA0040.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::9) by
 DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:373::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Tue, 11 Oct 2022 06:20:45 +0000
Received: from HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::6f) by OL1P279CA0040.outlook.office365.com
 (2603:10a6:e10:14::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Tue, 11 Oct 2022 06:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 HE1EUR01FT031.mail.protection.outlook.com (10.152.0.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 06:20:45 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (104.47.14.55) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 11 Oct 2022 06:20:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1bwtk6IUf5+GwVCj+pHvFF97s+1z1YSUNxqlcdbKUM5JNQV9LMPLsF0DzwmAQtJ2IB/mkXJh2uXNgU97ReXtS+4k5FHlqCYU+eCf3i6WnfEbIn9SJZ8A67/uYizMXYHn0KBGmRWZxPaJSme1MuFzeEcvIQRdxdKyaWbopW0v/NSnW0QTbmba96n7Q15fftgvnyx5D6iGTQ+GS/lhZmS8WR4jY5acTsPtcYgg4Vl9gYdGFaJIlWbmI1vVMEoJILNcccXk1QzCFQqqQCLrNrtawqCDP8tdMiUdDkj0IpS37wcVHYp6qkeE72gIfjrGCUHiSgWwDiujp3qnHYTBYQL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udDMpcrrg+QQjfaXwI6l28dwqw38zCjxyu9uhwY1+kA=;
 b=SVmv9y5LK+fpTQ6OZQmWS1M9/+6n2qI7qUrVMs59S+lzCHWEYPBudTWHJ8t/IY1CaStiSIHWqfXAVyuIC7YS2sQ0QqVHrUbtkPLUSK36EMzCniUw4UUQVTvFocKvJKqG54LJIu1ebYiYuNmpGUbwi+Uqpw+hFDY+dvjpTXgTivLKgLSz2Q1ioAGPck1naVa7afBC8NjqXdXu9MIdrWTvOyThL9F20t2yUClYAj8nvKNZ7gnbjE7LSDjOJJxx3ACVEO57n9SR5BmFKCQGwjDOdT9bIXgWTeildG4nig5Eq0kTMR+LfLXQmpM7wOum1+yEYllrNfpPQYL8rpoQX3OMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AM0PR04MB6516.eurprd04.prod.outlook.com (2603:10a6:208:174::27)
 by DU2PR04MB8533.eurprd04.prod.outlook.com (2603:10a6:10:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 06:20:39 +0000
Received: from AM0PR04MB6516.eurprd04.prod.outlook.com
 ([fe80::b16d:dd46:e253:7db3]) by AM0PR04MB6516.eurprd04.prod.outlook.com
 ([fe80::b16d:dd46:e253:7db3%3]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 06:20:39 +0000
Message-ID: <f78f1d8a-096b-60ad-e0de-266b63de8ffd@topic.nl>
Date:   Tue, 11 Oct 2022 08:20:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] leds: pca963x: Add support for PCA962x chips
Content-Language: en-US
To:     linux-leds@vger.kernel.org
CC:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        p.meerwald@bct-electronic.com
References: <20220822061838.8212-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.eea759f5-b343-44ae-b225-1c6c559cf756.15e0f4b6-2201-4a5d-b92c-9ec71e7ae8fa@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.67ffd036-675b-48f2-93d0-58c455654605@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
In-Reply-To: <20220822061838.8212-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P190CA0042.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::19) To AM0PR04MB6516.eurprd04.prod.outlook.com
 (2603:10a6:208:174::27)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR04MB6516:EE_|DU2PR04MB8533:EE_|HE1EUR01FT031:EE_|DB9PR04MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f965b4-166d-4b6f-c100-08daab50bb39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9BLNjUUWeBkUgsJPXREVh73igmCiF2oXXBH0DKVQdEeZSADgQfOLFl8w7IQHK5poQVZtTn4RIt9xjy4ZbVRfnM8xEtL7V4/5mZ2pDhe4AgTjFM7h6VrIPQat90mSDC+GKg8rbstb7ZYwO8voTa9ZdQccTgtJL9m/p+3kNAYF5/8/1crDMZklYMjLGEMYBR92bwW5yJ+7uxaRn3S2CiQz95U1/gA/MGycd1kblQq7sUj2L14zy5If77jdvOFnrZYcEtJ3lKdEJZcgkyerFXRNh7JcZNHkYC0/WPnudaxZQNmc9nDRjWkHk2tRf8+uuWHMXDF2nBpbLQlr8k4NrrbtD/AGw5h4sQR95wE3oTDRCzFZ6VesJISBW2GbDzbsS+UAf76U/ML707uCZhdACKzv50wuGlgP4IPgmY8188f4FTuVWGNIDcdg3cYHqwH2B+XX3OYCaTAvteXMbyvdG9ZNTMXSLiuqC6XG4U42dKM/RPJdred5nSIOqffqFo2DkNDkBU0TYwLUjonNx1FmqzrGkMZ2r5QprfaN2c2WI+2qXeCtDRVREeQNS53qwVqstK2OFv2w5+xl6zIZvJPSl8sL3tq2YtCPdr+lD3URB5zn4COYbhRo1SU1c7/uurPKCLg6UbiYnNyECmtdDP2sIo4bVg9EKrvOS3uE36sqPY8pMfe9r/uEZO1WQApDdybJZcL0jGwfYVjpVglVQJUCkZSWQMxkTQcDUk4sl/8TK0jR/eFHuEbpzOV9Bj/S5xBjGPssSFidX2fCNfiK3mRzBzKKKHLWgJTFabyF2C1YuLiRwmvuZOYh27Pq6K+He0JZUqhB
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6516.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39840400004)(366004)(136003)(451199015)(5660300002)(38350700002)(83170400001)(31686004)(38100700002)(6486002)(478600001)(2906002)(31696002)(6506007)(6916009)(316002)(41300700001)(44832011)(2616005)(36756003)(4326008)(42882007)(83380400001)(66946007)(66476007)(6512007)(186003)(8936002)(36916002)(52116002)(8676002)(26005)(53546011)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8533
X-CodeTwo-MessageID: 0563cfbb-d5df-4714-8e54-1d268b6c188a.20221011062042@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: da4e5d15-54a6-4b83-5f1e-08daab50b75d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Gp93CAhc9Emw18zB/bFmQMWOIv9RZ3BEt+4Frmo3thJQKshRFPP+MPZajMSYhgy3fiALDTzF/lCV3KXu2DNymVzR0dZsFUG9xx/219d0PspC0nZOZQZvqv0vsCUeGi6TLcRdxnb8cDxC9cIzQMe+JFJ2WyUa4HPHu5maiG2nfrZKBjCNnKbv1D4YP8RfxFzC8cccZrKtPNaGWTmvencIvUPUsiRpGt8r7CGtzO8jLf1Um8sTrhzJm+9TDHl9N8PZBju0ZFk2HNZKoGGWLT9goLlUbrzRS0Iy2zWCTx5/H9TooYB5IgkP0WpnPVAotefdhdVNPTsst0pvvLqQu8GrcejD5c99gvoz+1y6/Z4n6niVQFQ6YUgTjjH1TyNcEGLGoXN43Lz7U0i21n9jYAXrUusjU1XaJAHvZf5fjosQjuxwjfgynxPvlHUF0RqTOoM0pHP6cLaWAWoF/8mXL89rhhBCAMmN0BnLr+ovzh3seC9p3h0+43/HaLcVYo2Kavks+xMYxYbyRfCM3NUPqm2I9RL/kAqOic0d+1II3BwTTa0HZXftI04zMNwLUf6+ufs0xsM1RddSggZvt9OoLl5LDAs1eJWXOz7UubxLkAtielkBKwEXhmHTHROt+L8vgL3Oc8G4/sni0++g3SVEPtaditszGfBBkmQCwRmrC37rskjTizksG1tZaUdtnrn/2FiZFpf0cscMJYMHpkfKA4xsatz/Gg7h6mRvY7uz3OoUakBw25UUHc7KxqMlZPhjKntWhvPc23WdKR4uVFjKkzTURciEtTgFmSRkF+PbdWmLuc=
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39840400004)(396003)(451199015)(36840700001)(46966006)(26005)(36860700001)(36916002)(6506007)(6512007)(40480700001)(83380400001)(336012)(47076005)(186003)(2616005)(2906002)(5660300002)(42882007)(44832011)(8936002)(82310400005)(6916009)(6486002)(41300700001)(478600001)(4326008)(70206006)(70586007)(8676002)(53546011)(316002)(83170400001)(356005)(31686004)(36756003)(7636003)(7596003)(15974865002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 06:20:45.1798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f965b4-166d-4b6f-c100-08daab50bb39
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a gentle "ping", haven't seen any feedback for quite some time. Any=20
issues, comments?


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 22-08-2022 08:18, Mike Looijmans wrote:
> The PCA962x family shares the same I2C register layout and functionality.
> This adds support for the following chips:
> PCA9623 4-channel
> PCA9624 8-channel
> PCA9622 16-channel
> PCA9626 24-channel
>
> Tested only the PCA9624. Other devices based on datasheet information.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>
>   drivers/leds/Kconfig        |  8 ++++----
>   drivers/leds/leds-pca963x.c | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 499d0f215a8b..9a99190c13af 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -497,13 +497,13 @@ config LEDS_PCA955X_GPIO
>  =20
>  =20
>   config LEDS_PCA963X
> -	tristate "LED support for PCA963x I2C chip"
> +	tristate "LED support for PCA962x and PCA963x I2C chips"
>   	depends on LEDS_CLASS
>   	depends on I2C
>   	help
> -	  This option enables support for LEDs connected to the PCA963x
> -	  LED driver chip accessed via the I2C bus. Supported
> -	  devices include PCA9633 and PCA9634
> +	  This option enables support for LEDs connected to the PCA96xx
> +	  LED driver chip accessed via the I2C bus. Supported devices:
> +	  PCA9622, PCA9623, PCA9624, PCA9626, PCA9633, PCA9634, PCA9635.
>  =20
>   config LEDS_WM831X_STATUS
>   	tristate "LED support for status LEDs on WM831x PMICs"
> diff --git a/drivers/leds/leds-pca963x.c b/drivers/leds/leds-pca963x.c
> index 00aecd67e348..4d589624d192 100644
> --- a/drivers/leds/leds-pca963x.c
> +++ b/drivers/leds/leds-pca963x.c
> @@ -48,6 +48,10 @@
>   #define PCA963X_PWM_BASE	0x02
>  =20
>   enum pca963x_type {
> +	pca9622,
> +	pca9623,
> +	pca9624,
> +	pca9626,
>   	pca9633,
>   	pca9634,
>   	pca9635,
> @@ -62,6 +66,30 @@ struct pca963x_chipdef {
>   };
>  =20
>   static struct pca963x_chipdef pca963x_chipdefs[] =3D {
> +	[pca9622] =3D {
> +		.grppwm		=3D 0x12,
> +		.grpfreq	=3D 0x13,
> +		.ledout_base	=3D 0x14,
> +		.n_leds		=3D 16,
> +	},
> +	[pca9623] =3D {
> +		.grppwm		=3D 0x6,
> +		.grpfreq	=3D 0x7,
> +		.ledout_base	=3D 0x8,
> +		.n_leds		=3D 4,
> +	},
> +	[pca9624] =3D {
> +		.grppwm		=3D 0xa,
> +		.grpfreq	=3D 0xb,
> +		.ledout_base	=3D 0xc,
> +		.n_leds		=3D 8,
> +	},
> +	[pca9626] =3D {
> +		.grppwm		=3D 0x1a,
> +		.grpfreq	=3D 0x1b,
> +		.ledout_base	=3D 0x1d,
> +		.n_leds		=3D 24,
> +	},
>   	[pca9633] =3D {
>   		.grppwm		=3D 0x6,
>   		.grpfreq	=3D 0x7,
> @@ -87,6 +115,10 @@ static struct pca963x_chipdef pca963x_chipdefs[] =3D =
{
>   #define PCA963X_BLINK_PERIOD_MAX	10667
>  =20
>   static const struct i2c_device_id pca963x_id[] =3D {
> +	{ "pca9622", pca9622 },
> +	{ "pca9623", pca9623 },
> +	{ "pca9624", pca9624 },
> +	{ "pca9626", pca9626 },
>   	{ "pca9632", pca9633 },
>   	{ "pca9633", pca9633 },
>   	{ "pca9634", pca9634 },
> @@ -363,6 +395,10 @@ static int pca963x_register_leds(struct i2c_client *=
client,
>   }
>  =20
>   static const struct of_device_id of_pca963x_match[] =3D {
> +	{ .compatible =3D "nxp,pca9622", },
> +	{ .compatible =3D "nxp,pca9623", },
> +	{ .compatible =3D "nxp,pca9624", },
> +	{ .compatible =3D "nxp,pca9626", },
>   	{ .compatible =3D "nxp,pca9632", },
>   	{ .compatible =3D "nxp,pca9633", },
>   	{ .compatible =3D "nxp,pca9634", },


--=20
Mike Looijmans

