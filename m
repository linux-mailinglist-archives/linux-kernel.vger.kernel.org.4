Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7077383A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjFUMXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFUMXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:23:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56381718;
        Wed, 21 Jun 2023 05:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlkw69kpA2qT4UBcM/El02MqDpxgRwIOqNcF6hoBfKqBlMaGH9qVyBBmPVun+SyjSwwW06pYQJGKzNapnYf4uMWQLooC77ODKLgcd5quXrPkrhE8SHqyvzVMPurB4fqsalgHMl3dxLAQqT3o+DkI6ig8qB2BgdIAPP51EO0gUSCXkuppFvXIARHnL/0jG7fX3lHYg27WxV7RdZG+f/kSUHV3QPFUoIjCdSDtpy7p+blGfOs11GJ91PZ+IlIAHxc44l5ZSpPyjp2xSLM3OmkbHOroyo2HgBAq2xEJbY8TRjTGcFT+xxhwdIMUMCtDkmVBOOuzgDXbK+E9J6l9K6ahQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZvuNX65CYgLpxYT48+dITYmOysmTNlO7yWEvVyT57w=;
 b=HDY843jD1jeRs1FXDiMf4cc7+zSd2fuHCGOokOvhF8QVkVknKiBNz2ER6wwmxkeCXjtr5wgEA4laaMIZInoCzb1bN1GScMeJJuHThveX/eQxafab9S61WnHEjT5lW/LWgFOFANltwRMmKWE60gys554ApkefEOoUays80JLs3ptzfzNmt0fkTO2Xrqxx2PJNz1zVH/CZ6Ok4Lbj8X1VxyYRqaw0L7X3/Nf/87smc6/9SZbkVFyNQV0+oCJ0vF/gNdoUSSvZgx6+SuDYW2HrjUVrxMetUb3V3PljAMxs6jyzpTyCUVBVtegjl8WKvPK0JM3vjnzcSWl2U0tulKD/fqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZvuNX65CYgLpxYT48+dITYmOysmTNlO7yWEvVyT57w=;
 b=JfP8UmpEPWSQi5rf1EL/EXSLZ6tgIEvAN8riuzm4Ro7Yn8coiZGlPRKJYsCMcR2AlkxBYm7bwj9znnhfbeotGxZe2QuoK5F2Il484TjRiCBPug6M62E/18YLYFyTjgLCXvl+B5Oobw1x8QdJpjVLJeDaPpoDbmeZIWmUkeToweU=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.39; Wed, 21 Jun
 2023 12:23:34 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::8368:23:db50:8f88]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::8368:23:db50:8f88%5]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 12:23:34 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Maxim Kochetkov <fido_max@inbox.ru>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] net: axienet: Move reset before DMA detection
Thread-Topic: [PATCH 1/1] net: axienet: Move reset before DMA detection
Thread-Index: AQHZpDNISCde3I6gbkWQWU09f2/31q+VLImw
Date:   Wed, 21 Jun 2023 12:23:34 +0000
Message-ID: <MN0PR12MB5953C2C8784514E9270787DAB75DA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20230621112630.154373-1-fido_max@inbox.ru>
In-Reply-To: <20230621112630.154373-1-fido_max@inbox.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SJ2PR12MB7941:EE_
x-ms-office365-filtering-correlation-id: 979f8cc7-3180-4d8c-93f4-08db725254fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yp7kYLfEvysAj99+YAB8Xh5Sdj84DaYYH0zwCYgjOjeh9YLVXMpWvXfUYY4NZakJKxBEZgqcQr2GoDjlVaWW4IearmWwYxhVFXuvmNo2NkxtJ9uf1iDQVjvDjW9+hoiLaZU+v8wjYuCMhkx6UEVJ7bpXerAOT6sj4IAZitQy9lrtmuZqID95qUD1ilkbeDbWteVKMLrCRAPv2gIKs9ZPMgkTCsitX4q3sp3Fp/WCxB5mDjppR8cpTqG1CVHZVTkRv118Th1AFLnPq5NTEfHvDvAkw3SO3n7j092fTPk7l3msmLtWzd363rALfydkednQeG7BwthR4UnUeyuJjwtL2uWmimzBSjQB+I8dQez6RD1P3DtO56lqRJGAMy71jpOM0M+U8AfMXGwm6NfxYQ8KZbyf5gfnlke9SgnjVtBUrZk1ErRgz0+Ah7OZhzLbTwKPnsov1m5HXfv+fr9UNgKNeyJOTA674q3we/WlLNtmTKpHnIroVb170aTKTUtymDh3xXlqAu/m+Hc5QWSDbVgoa32gZhyO4FY8OKm2++cYk4ABc3K9sLeMhXFymg7ggOweqyPTVI7WwCXx+1VFSpg4dnknOUyHidapziCK1Qaq94VjzXpDGqx9Whum7dHgzGXt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199021)(38100700002)(122000001)(9686003)(53546011)(6506007)(83380400001)(186003)(55016003)(52536014)(2906002)(33656002)(41300700001)(5660300002)(8676002)(8936002)(71200400001)(7696005)(38070700005)(478600001)(4326008)(64756008)(66476007)(66556008)(66946007)(76116006)(66446008)(316002)(54906003)(110136005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uGRrsFaJb3RJVbm1359z8BvZVT/pQqFZJ6ny+a313M5/sILX0Hun5CG1ru3i?=
 =?us-ascii?Q?aTqc7w/zmpnQGMitkcp/AHK1rzaSaPu6fn1uuM4Eh3ceU7mMZ47OI+jU3vph?=
 =?us-ascii?Q?04fPZ68LUlT/HVu5zDZ8iHOAyaDpt/6cCUSRkzzbd+VTp6HsZo2gjaO1djJ0?=
 =?us-ascii?Q?fq3/Jf1FKf0XmGoBHITC4PmwoTY1ZQIWJEnRWQgeHpLjenZBySHyRf/wP4p+?=
 =?us-ascii?Q?SPtkbnmTg5dd9P6SEx7k9/gNJeVhCab0pAmdv/1bX4vF/xZyVhCELKP744D3?=
 =?us-ascii?Q?6gEhVpYWb5+JsbqraC8AbtKmT304XQwhhX/ig9gbmiPfpM2FYAYAobxJeGDF?=
 =?us-ascii?Q?fnHNLd/sYi3GxO+IBCMM2Bang5HL3ATDPES2AsxTHjhnrcLPG5RArD79jQ4T?=
 =?us-ascii?Q?UA7G59ZbnxZlRm0IPSnA6yjYuAp5ZNmuj0sZ/wmWL490R7ASXW+q+N5xylZV?=
 =?us-ascii?Q?r8+DuWvpLnTUv2jHQA8Vd4Ca9rQgtREDlhjbyvKVDROIiI79D4jqNooPrdgF?=
 =?us-ascii?Q?yKU3uu1Z5yvmNTRbPXFMKCRXd48MhQeLMr1uc38RdhqY2defke0vFKSFf4Ct?=
 =?us-ascii?Q?/NDp/5ii4Ll7Ua+SKgMydxSJuoIxXYvd+DBMK956klgnKlm81OBB9OAP06Y8?=
 =?us-ascii?Q?JXDinT3RmeMiCLrY5DHQGg9xARPWuOHC6czbrnhm8TeD4jdSX8lEcDiwNSdY?=
 =?us-ascii?Q?GLdeQ5X/MIi48cFG/2mxUYJEoHdq6O7ATA4QY9uDSfesTOIYdV61JOCUZ/8t?=
 =?us-ascii?Q?5pqVtKQHw0bPIAoF2grGSQ/GAYJBoViw7nIKA0OxJzsjISxRVHYHu8FYi4nk?=
 =?us-ascii?Q?qYw43whdsD2TB5J+4CUDkVZ8vcvwy9bHC/e8MyZvfPTdJ6Rtijtwpz4yaWwz?=
 =?us-ascii?Q?Q80JA2bUXKadiqHMfc17UPXjml3ueot6pfYuWFYsY91f3ziwIq9T/5m9n/w0?=
 =?us-ascii?Q?glzh8B7NWKuH7Vn5aDhk2PNp8aLG2lemUGjvil+HHIzANGRiQciXDPitW+n1?=
 =?us-ascii?Q?ibNhU2L7grMl/BrsA+q79XeYjGu0l8kkSiJZWAUic6eVByl4t8yALMK0ATXq?=
 =?us-ascii?Q?CXSmaENzL+JEZfGBZhgtg2XBEydBtK9vgR2oobI6oM0mBGMVLkKzRJJGdEPA?=
 =?us-ascii?Q?+msel2l3mwNGqa3SRpB2JeW5k6RWKxvGpJcPoOFpLGbNItSQ2q16bYays95Y?=
 =?us-ascii?Q?6HpkVqCZdosvCcv3sNRUtUpMMy5nqkjHfZI26V6kos6+4Myl4t4Fe1OMbRtr?=
 =?us-ascii?Q?lXmo/R6hMQNFhPqUo0e2TV73IXn0Y7tb4445BwQcIXdPSpmo5efpcI3UAFnC?=
 =?us-ascii?Q?bhq6B0Il17ZJIZv4LIkpOXcpxNWWn7SouIBbvSxcr2abFp6AwUkXqBkecvhK?=
 =?us-ascii?Q?5gZai1X0LIfa3fu9b9k+/5aiHmiJrDblIpbVL6sSZud67Qq0MULGUMFTCmeE?=
 =?us-ascii?Q?x23CrWjubWrtQRIO3SbMscQHjb6WC+Wc024TIhZHS038A69QH4YHH8FCKkLh?=
 =?us-ascii?Q?BTA5Pbc38eflV5xYmKZvto2mUT0xTUUNaHgCgEFrCTBYPmi24zY3S4hNIsq6?=
 =?us-ascii?Q?+GGuuwMgGyEebL830bHnjhSyvF47TYCEMZONcZPqjh2N67vuxSllBIDb91cJ?=
 =?us-ascii?Q?WIITlJrwaXM4GxcTWdz5NUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979f8cc7-3180-4d8c-93f4-08db725254fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 12:23:34.1447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+7e1Q0YGx12xmQi/5wKhP52estyJyiJjl0DBgb177Crdio6OMRMCa475bVLeHy2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Maxim Kochetkov <fido_max@inbox.ru>
> Sent: Wednesday, June 21, 2023 4:57 PM
> To: netdev@vger.kernel.org
> Cc: Maxim Kochetkov <fido_max@inbox.ru>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simek,
> Michal <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH 1/1] net: axienet: Move reset before DMA detection
>=20
> DMA detection will fail if axinet was started before (by boot loader, boo=
t
> ROM, etc). In this state axinet will not start properly.
> So move axinet reset before DMA detection.

Please provide more detail on the failing testcase. In which scenario we ar=
e=20
seeing DMA detection failure? What is error log . Is it random?

>=20
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

