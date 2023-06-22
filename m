Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7558A73A8C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjFVTFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjFVTFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:05:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBC3186;
        Thu, 22 Jun 2023 12:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2VdUyuI/FHox/a1bn2QYz4DiVDWgOlkKPAPob4NoqeKF1jwgR2Yml7EM9/V3INVyxXrwFYcK5wJaciMqEpFq/gOWYEL1X6btI+nLJqyimfmKPQ6jT53eDP7q25J6lditXOKWSewGyg4f2pjfhnCv6+FHr/aBk3Af2ggFTD1bbBsP0XDoSUToVOqmRqdZundHGSK7A9Oz69YT8/FB3xqEsFw6b0XJqhW8llWA1EWiJqUgl6h6WDRQLmljPLtw7B7rwRQTbbFTxtIoU3KxGO2i5FhMkdqiZGWPwvz5c7p7RicTLDLuAmEbTUFwrQWBiggSOCS3T+fxlx6zvAhFrc7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjbvXcntIuzTM48zd6A16XziVXqOTN0goSYqwglb0bc=;
 b=lnlNJMPtuSGRQ0WB7fXY9FBf8uL4YbQ+Hpk9nidbLSeEyo2gQFznCBm1CWfCGHroZNXrwqI3FPKpER99IO1ws/4Ej7PS/KzbdPpCtpIecdgS7bYWy4nGk8X03lOo6i5xiFwmWqRzfU/Q0vcGfdYmhW9fz6lyuDN7pOiSuGc9YJtoghrtOMQP+f35GRTY85THtWzNJEdbIuurrUyuazn9cjy9RGtDP06O2Ns2DLUz8JI55jXDfnfdn9neN3fLqTA2PrSof5Q1qmzPNeKrQAFAy0WXdOf2ocSOcu9pevUOklRY4Ad0wtvgmyQY7MeB9j+21n6YxEzFABlFdItQHxYI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjbvXcntIuzTM48zd6A16XziVXqOTN0goSYqwglb0bc=;
 b=WsMTqIZk2oLueskQQbvipbFGat6I5nKEnAsni9zyxVfAXP5zr0nh3rGEFwJp6H0vpWIzCjIf3/a108rgZYMDMI8lM8zh7NXzux94iVHlqZF+2pEkZVfWk5ezFLT2OKB6KFVvw0BiSQ4LlEUmEBvbWtPvv7oYLuIt1tv7vYD3GCM=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by MW3PR12MB4556.namprd12.prod.outlook.com (2603:10b6:303:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 19:05:07 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::8368:23:db50:8f88]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::8368:23:db50:8f88%5]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 19:05:07 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Maxim Kochetkov <fido_max@inbox.ru>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Robert Hancock <robert.hancock@calian.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        Andre Przywara <andre.przywara@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] net: axienet: Move reset before DMA detection
Thread-Topic: [PATCH v3 1/1] net: axienet: Move reset before DMA detection
Thread-Index: AQHZpTqU8MLStBZMoECUyq/cRIOBYq+XLi8g
Date:   Thu, 22 Jun 2023 19:05:07 +0000
Message-ID: <MN0PR12MB59530BA3E40F29E082FD09ABB722A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20230622185131.113717-1-fido_max@inbox.ru>
In-Reply-To: <20230622185131.113717-1-fido_max@inbox.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|MW3PR12MB4556:EE_
x-ms-office365-filtering-correlation-id: f0fc33ba-6fe5-4144-109d-08db7353982d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y5Tb4juarC32iQspg83x7iw/cbxSiPiv9kDjMzY0MuosCAMPGlQBESkP1YTPQ6NNId9LwnJJZCf1ZHPLVU40jlDQ385gbflnox9W89O1ozTMFZfRqbgQXIvGZlTVaYF0Mz2jDJ4ETJKi8EvXG92v3NIamROBbZ+WX7Azy9xrgHIgqfiX7p7375mqDtMvWwO4HUfkrtSPPkHn5kwwhi0VIdC7/lahZ6nf9gopB25xIrDFTb7lJ9BRDit8sJWn17O0D0Q1Ov1KehsnGOQ7sADB0e5lRvkPGnsBp5uXUdoNakY/JvYjYhUloexcFKlTl4xtfrOMGOJP8GL2SR+iDPOdOddOTvL+CMgaGiqfcdhgN5hdyiRvcYNkL45wc6POhIOzlfOID0Ci1ry1fUVcnrd5YdpBj4TcSj5PfScJOTNj3YehnOsZOFYwjzFwijTH45ebfefvtJFCsF2Sas6pwMEue2obMfjV4IDuY4sm3Bm97ohmoWQWPlb2HPr5Kn1y7uqpaFkkoj2BQNNcn6lOKocdFBzDkVzakA7WC1tdDMUU+ChDJYrKJBxhE835Rhp+ZUoV0I3wr48Nx8FQh2MVLIozvnhVvsO32jvMPdsvWXvRGpeTCLtUmuCAB+ReFkc/AmOd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199021)(4326008)(66556008)(66476007)(66446008)(316002)(54906003)(64756008)(122000001)(66946007)(76116006)(5660300002)(71200400001)(83380400001)(6506007)(52536014)(53546011)(86362001)(7416002)(2906002)(7696005)(8676002)(8936002)(9686003)(186003)(41300700001)(478600001)(33656002)(55016003)(110136005)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pWDz8aEr3YMnwyBx4LomUBzTUoE7lVhG730c014y/1Abxr5tlH2SDb4hFHZn?=
 =?us-ascii?Q?FZpQ3cggF+XCH9hvK7mlcrWNJIq/CjOsAZodltBAvBJ41JXg6oIeHihzDFyt?=
 =?us-ascii?Q?TTRFFezZkPnCQ3Rd9gAxVE/1p/PHZhhieQSk6Y+zV9FcE2XS2N06qXNN+PDa?=
 =?us-ascii?Q?qdrJS92MBZtE0vGVVPHXwX+gSDl8Hgb0ZUBq7u4xHao4pJjSfPPXAhKXRlwr?=
 =?us-ascii?Q?CNhB5gYdnSqae71hPy3YCczWyw0+w0xLOfhYN2mwelKSC/px1fnpTlN4MBoF?=
 =?us-ascii?Q?yTTWIm8K16fGwr5BGVCfuO4J548eSruH3RTJjJnaPMPfiJHVHbdmTL4Q92rM?=
 =?us-ascii?Q?JSl2XhpArOZHhdF1tAWNOaK/uCvHHxHn2PxaNV1yuVfgT9x7oCTep6gcViNt?=
 =?us-ascii?Q?tg2W0RDbM8pyeA01cqMTqwWVh3WQ8pIVASb25abusblfFyHZSSwbaYTD+TT0?=
 =?us-ascii?Q?S2sL5+5CQNajeutIQWO7vlFUYAxoILIO78/tIBZGgRwWo67I8p7D/66+Xte9?=
 =?us-ascii?Q?6l1TcmQsb8/YmAp/F1x4zqvFg8Dsjn7Ku4MYqztwo9fL0Ay76sDjQUk2kwXY?=
 =?us-ascii?Q?hbYiYYCtAyT0ShlkInEkXC3woC2p6G14CQ9BOa+WPSzvSsEe7vmY1c6CRAtm?=
 =?us-ascii?Q?59V7vSvRJA50YCoCcM3cJ3DeSDnr6X07PjV6X2DUTdsBbtY6c0rUkN4LYZLg?=
 =?us-ascii?Q?0ImndfWjtfo07D2jMBv/vG+plLf0qY37rR+UHKT25/CejoaZKifWAwCZ1Z2H?=
 =?us-ascii?Q?i7fmY3D7J3lUJqXBFJD0NkXODbXzFGlV4dj2rhXkl4nNCd88VBJEeo3Hj9dl?=
 =?us-ascii?Q?4XVGI6z2MNCsJgI+sROYQAvEXQM5h6aiI880IXIE80xYBs1h0utMhrjtWFtb?=
 =?us-ascii?Q?eVU75n819A0hKNw/bJJC+AMChlpeLWvLMspXgd18cFUoJrgjF2q/OAWnmGUj?=
 =?us-ascii?Q?8uFb7oeygwzXlKLRgDj7HwGUxF8HVBYsd88TNpinAQ+0Uy9bOJtVG4LeV1Do?=
 =?us-ascii?Q?oW1WYJZ3smi/Ed5mfNSbR/XsXr+9FOU9qEOIQY6e2d0UQRlAwkmR2zf7jLLQ?=
 =?us-ascii?Q?Y9QjBOhpdsT5jfNolelp7nrJn1auFRggIpnVBhXGd767uqvQyy4OefndUm9O?=
 =?us-ascii?Q?EzqZQex+AQClhubooi4dRBKDq42JR+Wd9cHy8SBj0TTddpb0o8OdrerqABiZ?=
 =?us-ascii?Q?uPXZLo6K+kS/EbFaehoFo4QC+PBQ5KKrcSW9IUGi4v+FPvx2q7l50kp52oI8?=
 =?us-ascii?Q?qmvvVPNVPJfwR0vNpm7lS/JcBZzZPBAipG/8by+vXp7KmZVfdfSTf9jqJBLT?=
 =?us-ascii?Q?kPfhl/QMTywVdFAYihHd+u1veHhTJGMGIzH9IBrDJm8mgZ4kNfOHqseo6osu?=
 =?us-ascii?Q?eRtO/PWgPK/DHcWdsOR4z/2koRBVBJzap/wLUIn2kn3AKnelZ4lFfDopDKrp?=
 =?us-ascii?Q?H2/4Zu/wAAgbsa6BovIvjyJA+y5/f5q4v9LRm2tWMwY41w4TFujEib9V91Hy?=
 =?us-ascii?Q?a74ACnYGDaEvLCUV5MUNHdfelGnzsPkczf4QkjOW5yj+EMqyuERZn/loY/VY?=
 =?us-ascii?Q?QoBXfBUZ3BMmUphmFoW0jkzktKAt+y8nitO/TZDXUIKmFNLU9KJumObTshk3?=
 =?us-ascii?Q?N8UDtgJDYYg1BhhNfyP3Agc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fc33ba-6fe5-4144-109d-08db7353982d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 19:05:07.5444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvmPW7CAmiyjpOpU8ygGTea1cwReYv3Urf7vt77fI80jKVqsDAtnRkUXPcOS6VvX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4556
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Maxim Kochetkov <fido_max@inbox.ru>
> Sent: Friday, June 23, 2023 12:22 AM
> To: netdev@vger.kernel.org
> Cc: Maxim Kochetkov <fido_max@inbox.ru>; Robert Hancock
> <robert.hancock@calian.com>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simek,
> Michal <michal.simek@amd.com>; Andre Przywara
> <andre.przywara@arm.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v3 1/1] net: axienet: Move reset before DMA detection
>=20
> DMA detection will fail if axienet was started before (by boot loader,
> boot ROM, etc). In this state axienet will not start properly.
> XAXIDMA_TX_CDESC_OFFSET + 4 register (MM2S_CURDESC_MSB) is used to
> detect
> 64 DMA capability here. But datasheet says: When DMACR.RS is 1
> (axienet is in enabled state), CURDESC_PTR becomes Read Only (RO) and
> is used to fetch the first descriptor. So iowrite32()/ioread32() trick
> to this register to detect DMA will not work.
> So move axienet reset before DMA detection.
>=20
> Fixes: f735c40ed93c ("net: axienet: Autodetect 64-bit DMA capability")
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> Reviewed-by: Robert Hancock <robert.hancock@calian.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 3e310b55bce2..734822321e0a 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2042,6 +2042,11 @@ static int axienet_probe(struct platform_device
> *pdev)
>  		goto cleanup_clk;
>  	}
>=20
> +	/* Reset core now that clocks are enabled, prior to accessing MDIO
> */
> +	ret =3D __axienet_device_reset(lp);
> +	if (ret)
> +		goto cleanup_clk;
> +
>  	/* Autodetect the need for 64-bit DMA pointers.
>  	 * When the IP is configured for a bus width bigger than 32 bits,
>  	 * writing the MSB registers is mandatory, even if they are all 0.
> @@ -2096,11 +2101,6 @@ static int axienet_probe(struct platform_device
> *pdev)
>  	lp->coalesce_count_tx =3D XAXIDMA_DFT_TX_THRESHOLD;
>  	lp->coalesce_usec_tx =3D XAXIDMA_DFT_TX_USEC;
>=20
> -	/* Reset core now that clocks are enabled, prior to accessing MDIO
> */
> -	ret =3D __axienet_device_reset(lp);
> -	if (ret)
> -		goto cleanup_clk;
> -
>  	ret =3D axienet_mdio_setup(lp);
>  	if (ret)
>  		dev_warn(&pdev->dev,
> --
> 2.40.1

