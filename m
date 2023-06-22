Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F6073A86A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjFVSnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjFVSnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:43:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99BC1FF2;
        Thu, 22 Jun 2023 11:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDeumnMobiZ6Pcol0fsK6Vxt8rdT7KqaCXevpIoV+UWQLIxQzNdb4Kw4nCueMuxZiIBUjh+pp0ewG98Jrvl+BboP8sqwqJTDATWEzT5y35mc5E2Rn4cE9FJ9U+jZzaBmZV4rHuVa+1xNvvTMmWBJM+M0yYoaa5mdedm36kZuxEnYp7+C6HxRHTG0+qlnJpMOkvVxP2SfEQVMnF11FxsJ4qrMCb8T9VH1enfjrP74BYJoDQgYNTEdSbly7zybxLoiDSTt1+YSiP8zDMou+IAWF6EbNZpwhj97OMSytCKcqcsqMez+Pic3TeLWBWQVLQf/rrpaBGOMqR4PbXUrDKbHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEvECoNC55ZVS1zTHfyboNmzZMpWU8e6bXe0QY+7xHY=;
 b=nWIi8iAnoYmIKsiU17MFpxlKRx+EMXxPI9srIgjkALJDDxRi/xS1OfFmLJ9z/nrpgII8bmsV8yZsF3xNJqolSWTHK/DTkKI+H4q2TJy64s7iS03ZvA3UjnKB0WyYvNnvfJAMGFAppKvhIprQjMyM3h0bYS3dXGNQ/vTPcDlTRHrK8UIslEKob/NHTzW5M4vCrGoky6LpJfco4M1KK3EaxqrEdhCRtDaCg7ZZAE8vKDs7p1+YRJkwLhOMLUCZ7iStxzLQ5paz/xXyXol65FclmopmPc67QET0BaMtOlJtfuPicatP9Ka5Lhkt0+xbSymjn6WIHDyLdtdPZmmZ5vqRDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEvECoNC55ZVS1zTHfyboNmzZMpWU8e6bXe0QY+7xHY=;
 b=mvdkIK1b1aKpQP0HZ4zDU4hExKMsPTfL+OLw3+CXg8vQJ4SA2gQAFNb7ANS4WbLc7WAytFTmpYh0nPv/QVxNk0tOheo5lISsofQ9BmIbMCoZpDXvov6u7F0yBxw7ecx3hdYuU1cHFq5pJLlaIAm4UFRVzNZn+paaPhSjQ0SFLAU=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 18:43:02 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::8368:23:db50:8f88]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::8368:23:db50:8f88%5]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 18:43:02 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Maxim Kochetkov <fido_max@inbox.ru>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Robert Hancock <robert.hancock@calian.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] net: axienet: Move reset before DMA detection
Thread-Topic: [PATCH v2 1/1] net: axienet: Move reset before DMA detection
Thread-Index: AQHZpTJJf5eUflWxuUSsEXI/drOhL6+XJ29Q
Date:   Thu, 22 Jun 2023 18:43:02 +0000
Message-ID: <MN0PR12MB59539C6540FA6B673A1A7FF8B722A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20230622175200.74033-1-fido_max@inbox.ru>
In-Reply-To: <20230622175200.74033-1-fido_max@inbox.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|PH7PR12MB9221:EE_
x-ms-office365-filtering-correlation-id: 0e43f27f-af55-4cb2-a9e4-08db73508236
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hQWpzn5cQkNK4nMfei0jrIa7byHFdCEvyKgnc30LIkpWFQwEVpknNa8++5ooeAwBDYN4qD8r+538EjqDGHhLWmVqBB4B/mVnozklb2vb+muSEgWcFK4a0MkDAKtGAvXvBXMNypngvh/3Do+PMQvNa1H4FO88c7nJj7xj/ozDi0KbyMpic2Xavknj+yYYTFTCNwheNbLL7yMUi5ES5RJ/n83BL5rQlMsqKkNEOKibb8N6TGcjzbCjGn5Lz4q1VAk6Cvquq2r5c04DlExZfY+e0I35122hr+jZOVZ/hE1ta3l1pma+XK0DXfW3L7C/FxtBa1anWqdzJc5yPQ28R8EaeHOPiDrpdpbEJlkPBWlD5JJRJMVmgXqzshg3yE2lTghpmF/iH1pyeDbpq5S/8vl6Deqaq7GUxjqh0A/EgjuidaqBLBjJiM26rnUZkRXL9NNd0Ne4PiWh8v9rQ7ratnPEoifrp6yUsIXKpdmq05D3wLxcjzRPS/rl2/cIL4pi4umJTKfXVDO5F5HGRpzoWpSOWyXn4V48bO4YHEBYsZlqiXe2d1ehPI/rKzmJYzYi5ElqAV6o7nIaFto0biuV3gZKJ7/H3vB1WBOSjODJU1GRkT3Z9Eb3rXdfksCxd9tN9HpU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199021)(7696005)(71200400001)(478600001)(83380400001)(38100700002)(186003)(122000001)(86362001)(38070700005)(55016003)(33656002)(53546011)(6506007)(9686003)(8676002)(8936002)(41300700001)(7416002)(52536014)(5660300002)(2906002)(110136005)(54906003)(66946007)(66476007)(66556008)(66446008)(316002)(64756008)(4326008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?70CfoE4y/TvUWzSuG8fWYEJWpBd3r+MxbKwoCmsj4KfzLNe3P5xQkHxOdsfw?=
 =?us-ascii?Q?o7B2UuCbhump8E4Uq9H/8Y1Shf4Oen2eQaCu6vMLUgPMsGl8VuKOO1EwLhHW?=
 =?us-ascii?Q?WcKiOkIx0dYOt3aVbHTA8Yqi5ZHKSpukj3kN3/nsAALEaZvbbSrSJCmJa8n1?=
 =?us-ascii?Q?e8SV+G1RuuPcBm8uv5T+XR1GEqhFsOozjmv0pgTg/iUi1tG8M5mNnWiYVhgv?=
 =?us-ascii?Q?e/4ykO4r1XsfUmA9xTNl73FF3brCaDpbtLY6q0bsXOXl193/jl/LhwPXbKD2?=
 =?us-ascii?Q?hd9aNE/FygWGIOX3otWT1mEuiUqeetd1uhJjz7yX7s1hl30Q8uvG7L+H2Qot?=
 =?us-ascii?Q?dWh34N2O86oJqp0Wl7ERl/bYJd47pM3tO4JsoXq/DD3HDWpLarHB7iYvdKbk?=
 =?us-ascii?Q?FndR3xQusCmyq4PVq8p2umJq7i2wweakJiuak2vZWMBZRm7akhAMqrXh7bwZ?=
 =?us-ascii?Q?kj6FS3qx1y95/tOP/p6Bqud5yKVQdNFkOsVTUE8tdrMYTsqbDZP99j6E9qBU?=
 =?us-ascii?Q?/9naL0pVRmbTWTILlyqVD5lzUE2pxWdr+wbj2zFUM3xq7mq3ihMH0YwLGXRP?=
 =?us-ascii?Q?/Sh/XZN1oxDk6/TpAyUHp9qw2R4mwDVx/fJbsZWiylwcIV1KgAUwI8w6Qpqp?=
 =?us-ascii?Q?ftpsaMMBH37vOb4v0tzh0W8dwmPTPXM0IcnRVmAr56X+K19go4DQmIwYcFXc?=
 =?us-ascii?Q?SkcNo6VbORJKcQgsUBMUJ+5U77doIbR3rl2FisA5S8amtKJGWYO2m6cHVNn8?=
 =?us-ascii?Q?NwnbCJSvhEh6+xirH6LheR8rsjK8C4/GNgH3FBDBmWo0CWEGQLy9hcCyQ69t?=
 =?us-ascii?Q?ibmbAgf8/JYdCdzxWc/eGXQHPicZZK6QQUzbvJsPC5FU3r6xUKHKzq2u1YtY?=
 =?us-ascii?Q?V4IV9JtGkVsUyQHETPx0EO1KnOiU/OHegMyaTFohdETCLKTdHNCufyzhHknv?=
 =?us-ascii?Q?MF9hkovpEvtOlzdGzpjgHLMNigmfh1I7zvxnSeFM2LP46DQjAW8javbeAdGe?=
 =?us-ascii?Q?lK8DrjxfrDKfBXXbRQdtsFVDybDNPviYqmhGnaW1g6yfFvU+MWAF+EO42X57?=
 =?us-ascii?Q?0KbK+M+91GWBqxDF+5BKjWxZl0kp1YxKf3gZA+zJ/jpM8Xgx539sAoJ2Sw7l?=
 =?us-ascii?Q?rGufYVHIvR9k1Wc+RIUZ/UbcV1IbbBKaiKjNmbOOpNL5ZU2KACSQAAHgcOjT?=
 =?us-ascii?Q?fvN7+M4Y0+Zd/xYM5UXohXOUEcICuWkcpsKFfF5Kj0tpnqWex6uO5CoBBZaV?=
 =?us-ascii?Q?9wH24We4y5/Y38PTcd+rcxyY1lHwNcH4/BIHnAQtlJfgJo8Zeqg7itj0TiXB?=
 =?us-ascii?Q?QMc4SYtyVZHm8jy93hykH1TnlZpcpZX5tzft9LwgBdKMHcZPzG/kH9JSjRZg?=
 =?us-ascii?Q?jIdkfUltpoyxFXH7L5NCoNqknpSfk8CHl1vD5ItIbnmomctlwTgXQikWROME?=
 =?us-ascii?Q?Cl9uCUDlXmBETwUZoCO5uszgltYUHlSZzCBa3I7MD1PX7Gj0Rz3icMZvGsi9?=
 =?us-ascii?Q?uOlGci6But0Jibjt/p5bSqj6fBDgkGAsnJOHWQfYoCWv3s+bpuLOhfWQtQjb?=
 =?us-ascii?Q?iyaNfZCbw/jsUnK6eOI1mMoQrmXmIu7qlb3td55+HJfZvyXRyK25kYreMCW1?=
 =?us-ascii?Q?soHpQpGcw7/B1anBGHgjQCk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e43f27f-af55-4cb2-a9e4-08db73508236
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 18:43:02.2120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWkfcAHU/wAx9qs2FylIXSgCaLJbXxSFl5JZtxgtlmzw5Ru5GNGSGPQnSIxO/u4L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
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
> Sent: Thursday, June 22, 2023 11:22 PM
> To: netdev@vger.kernel.org
> Cc: Maxim Kochetkov <fido_max@inbox.ru>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simek,
> Michal <michal.simek@amd.com>; Andrew Lunn <andrew@lunn.ch>; Robert
> Hancock <robert.hancock@calian.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v2 1/1] net: axienet: Move reset before DMA detection
>=20
> DMA detection will fail if axinet was started before (by boot loader,

:%s/axinet/axienet/g

> boot ROM, etc). In this state axinet will not start properly.
> XAXIDMA_TX_CDESC_OFFSET + 4 register (MM2S_CURDESC_MSB) is used to
> detect
> 64 DMA capability here. But datasheet says: When DMACR.RS is 1
> (axinet is in enabled state), CURDESC_PTR becomes Read Only (RO) and
> is used to fetch the first descriptor. So iowrite32()/ioread32() trick
> to this register to detect DMA will not work.
> So move axinet reset before DMA detection.
>=20
> Fixes: 04cc2da39698 ("net: axienet: reset core on initialization prior to=
 MDIO

Is this fixes tag correct ? I think the failure is introduced after=20
f735c40ed93c net: axienet: Autodetect 64-bit DMA capability?

> access")
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
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

