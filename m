Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A890E6A1FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjBXQuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBXQuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:50:04 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82C636FF2;
        Fri, 24 Feb 2023 08:50:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX8CLkn3ExUCE++Rh7N5jb3DfvT9CloOrC8uMTIGAXdRhMjzx3TKsLiAd/16nUxPiBsPV1wX2QP5kgkhNV5rLTDxodtHQtk+CN9LwBOcZoLBOUVt6WsXvZGQ7B12pSqJ3NtC9aWkewdJwcOcHPb0cmspArmI04DLUpuaT/dzQdZUc7q6BJt+MlahukAjHndAMLeRSaJTpY1WQ9WA6LMOvV1XBw0yCO7mTpmM4ok5PCMN2S0WjEX3Rk5gfnJsT4n2yjwBG0S51RJnGSfV7Uyyfce66R7ef703pRQBncpmeWIdYZnLE+6cpnyB9X8WhiS1SOxF4K39R1d+xRpAAqI80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZVW7eg44ql2RcwEHNzPD0t5C/RDt6JPBcl52YJatt8=;
 b=UW4/N0tcgnxexJqVgBztp4W4oWzcJMhWqN9Ygb3LokjGDA/Jq8TUEodg5q8nPbz5zEWH7uJT+kIJj9O5lJ2mi/pFIXSaMS6ePUQK/9/Iu3qT5ynkGTICLbKe8AbuPll5WxXPr/0r5pUiFcEoOUh4bfn/tbUPrnzuGZ+pTip4I/jTxNVNKIBz5sPhePLzuSMhTVEKaxNAUZteqc5CH6yiaRdq8GpKFLKPbIDdY8cYqt6a/oWUGD4zXfBA8IMJO0RJ48lNRB3mtRRrPfmJ0tAIoJ3o43OdBOa0vWzg65TJ+GiiWmHgx3fJ4Qhq81bdvMkJ5JkUqKGFLbk1HrvldbrLDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZVW7eg44ql2RcwEHNzPD0t5C/RDt6JPBcl52YJatt8=;
 b=eznZOc6Vl8OwnaJpiHcg0ixLDozwcy35E89N9TawKVznPbYhPUJIANKh+m8sCg7FsiBEuiQNIc/9Y2kmlE1xJgiVITnuhyhmbv9I8SoLaSUZO0+fnFoyvCmVIGHvSfru1Rucv7FCeUtlr/eNbNSYs7tzQu6FrQ7G/cN0qxsJKMrOajeWCc7/SVdWfCSUiOVh1tpHiIHvCc9l+ur2E3YW6C7kIAo1t41/97WgY7tw1UUxkd2DaPxD7Mjs9jujEye/dqHWxlFdJnkfx9Ks32B4HQWwCA994wFzLwElqivy2qe4pkWDOfVg4SUtpWSi1eYvyilUB6M04M3m4DWREseUOQ==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 16:50:00 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 16:50:00 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: RE: [PATCH] spi: tegra210-quad: Fix iterator outside loop
Thread-Topic: [PATCH] spi: tegra210-quad: Fix iterator outside loop
Thread-Index: AQHZSG4K8+wSVKmZRkimkrAiwHDmq67eTmSAgAAAM/A=
Date:   Fri, 24 Feb 2023 16:50:00 +0000
Message-ID: <DM4PR12MB5769BDB91342A9768207BD84C3A89@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230224163513.27290-1-kyarlagadda@nvidia.com>
 <Y/jqCRAenwbqc1Uu@sirena.org.uk>
In-Reply-To: <Y/jqCRAenwbqc1Uu@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|PH7PR12MB5830:EE_
x-ms-office365-filtering-correlation-id: 32652841-4d08-4f1a-4dcb-08db16872b2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cSICjLas7/UIiCwjxE/xlRBmN7+zwVOY7Ju+pNB7fLGtXBCSdvrbIgizwqHhH9XiJ7iKF8/9VkOUR0l/Z3mAaicyWdqDlc5MS0+Y544yye0RSPzRUab9/+cu9vdSqLp3pW8o4AVYeXk2q50vYKow3DvNsDudIdKfcz8Q2TCB4uTrNd40aBNsiL+lYctACg+maZWmkiihc8O2Q8IZlb3E2cIJRzLG5pcFz/0XgeyWHG4Npk1/m4veCxkbT021nJut1KPYRsJD/5t8zMMWcFyhMVWJYV4noC6KfgmS3KPo7OYeTmq1QrE2721FrRpjyEXbA2/numvgupVS2P5Ga0Yc3vOg8AySb/lTKTyFibn3TON2c/pxiCBuJxA0gy40Gq55uqn5GP7/gNfq6UN+4I9tYk1bTo3zMFC5l75g22DaqcZ21eThElNA5nygoZ7/aIo/Z/IBws4qM0L7b/LyJCQYWXN/YK3QpKVlH8u3+/C4CxjzQYKC2hm/UHEyGjqS46SVefxb12z5KkLXLuKNBGa25/7Gee5+3Qg0XAW0z+qILR28XeIZeRQvi7cjacB6PiTQxQVwYH/2Ar4x4o4srKgTIWMNOnYgHP+3OIEj8IKaoAdQ+eVVdIfCvuvmKEBg0jSly80QwY/yckVhpMNePpRbbWj3FwpIP+Xem0fHCMyj13qPGdDZVU/YjdlJps65X7YBlRnPP2BqOhgxIjkCDpuXNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199018)(122000001)(54906003)(478600001)(316002)(5660300002)(8936002)(52536014)(8676002)(66556008)(53546011)(6506007)(7696005)(41300700001)(107886003)(4744005)(71200400001)(9686003)(186003)(26005)(38070700005)(2906002)(38100700002)(86362001)(83380400001)(33656002)(66946007)(55016003)(66476007)(76116006)(66446008)(64756008)(6916009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YsY+5uB9uwqg21Oo0OJhVlOloOYzMRgU/fZ0wRqUEgJ75cI7BPdSkG6NbiRQ?=
 =?us-ascii?Q?iSJMvEFD2G1ITAtyWriyYjvsQV6jaIvw3rJrPkIlrAGGguEmnf56Z6R0q6uH?=
 =?us-ascii?Q?mIyOqagh4QJxGMmRFnCDSg6OOtQVrn+QPhjsqJ7c3vryr4NUQFmMrHQMxfex?=
 =?us-ascii?Q?rrhitSTCDbEvK/dxppGK8AfTRkH7NC7n8yZYKgu/71bWPDLYRtjylyv5Y4ce?=
 =?us-ascii?Q?OfO5BFYAw9v9jkbrVWpX9S/oJxpw8Dl17pJQpiDmYpJ7kDYTQ6SnUtIbHsWX?=
 =?us-ascii?Q?QuJlW19GsdmB2N2o5PpwQmBG9ml8/TmMsXiIqAGnOIiiPTh+gHhpZZxOK2dc?=
 =?us-ascii?Q?6rpiQ0GbkJH1y5rSXsGxqwt+irkjjk9rboVdU9GAEc0wHaX8kiCl2Lbcohh4?=
 =?us-ascii?Q?qfPTR/in9TiWJoXskoS2v4altT1N85TVpibnlT70f0Oh2cRWxjfY4/lFFPKK?=
 =?us-ascii?Q?mesXAYid3MNiWtMMc/ftkmUVvb6W88AR5SmqLg2grV+xgieclFT1HX7n/W/S?=
 =?us-ascii?Q?NFklL7oiTk2P0+gOAgCyRgMDaG1n9YRMpm/z9WTArD+RJhnyNizoZEYF68K9?=
 =?us-ascii?Q?gddSIEA/KSsHL4HwAHRT9M/HPaY17F8frTOMNkqwtUDI8sN/GV8T6eTYNZ6B?=
 =?us-ascii?Q?4X2qCHtBYOVpsCK5F3UIzicmTEV/5W0Q2T7hN0qcdYfokexm7WR2p7WaoWgs?=
 =?us-ascii?Q?8GsT6utVN/z0mqJw59obwxPRNY5toa8lRN3S6cnwTbUMhtFm3mqK/SvlkEjq?=
 =?us-ascii?Q?422rO4NPNn3HevpUp4tdxeejftW2X8RA7Yo023NPBzT2s5QdoG327QTw7gu+?=
 =?us-ascii?Q?RYEacFYIw647MJTCePKK7sLrqjBibbDFwmivlMSsVuaIoxcz+ipRz4w49vM1?=
 =?us-ascii?Q?GAUyJgSti6+mWrwdf5U6VaxMCaDQy+EqS9VibZQkZl48Taknnl6MPYVDyXc3?=
 =?us-ascii?Q?cap35eUYpZCuMF3g+1yQHXASzCqJ9Jo+vvf/4Xuq9AVcHrlCy2WdyPOUSrVb?=
 =?us-ascii?Q?kPnPB6UBGyI25h3OBRwwte+iwjoAmRTK27Wp0x7LrelxCktIf/rwuv4BPhwE?=
 =?us-ascii?Q?BtjRShasij9bHzCELEE6dWO18ECR5g3cFQcxJminiJJwgZ0SQl0Bt1n2EMpO?=
 =?us-ascii?Q?9QT++sn0CtX2x5Um0StmIqz3IzZWghe+AEal22IY2hoHHes8m+GKrvJ1ZL0w?=
 =?us-ascii?Q?UqwywI7sr3/xjZJjV4g0hPpteNim8KoctaMP65uAPFPUD+I5pm73eQMygbWN?=
 =?us-ascii?Q?EVxw48mOCkH0zxz7noeDT1RTdbMozxeMNQH38ALkqG1sfZRBYj/sJPnxk4s1?=
 =?us-ascii?Q?Mv0uFzy/4kGLdDR8DKiy3FBqgUTCJXUe/OxZiC051pGcDAJzG59Z+dYy66Xk?=
 =?us-ascii?Q?6+ibRkKQifHGnIeEHFAryn4AHdcQLhtQPAvJwAUqIJHxSa3zwtQ3Vsr1HEwD?=
 =?us-ascii?Q?QIdeDASp26cECDbPf/jtRFiqXNWDESeZryJogDFeiVR9NEDNUBVaYZ+zFRpl?=
 =?us-ascii?Q?FkbtclEkuj7BLnKyAXao1CMa56hnobqVvwrmmxfdj4n/xAJSXgS13gOPUZLm?=
 =?us-ascii?Q?OJp6XXfrJ940B6VZNc4plTZOhtCKyZtC3nWXf3L1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32652841-4d08-4f1a-4dcb-08db16872b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 16:50:00.3348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1xm2FXaenA+qyfsnIDWuOsTP9B5ZVBVQUmenRCIwiQ5bL6Fy+OWdTmSMbbjIrseHZ6lRgkvqpskQX47OBDnFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: 24 February 2023 22:17
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: linux-spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> kernel@vger.kernel.org; thierry.reding@gmail.com; Jonathan Hunter
> <jonathanh@nvidia.com>; Sowjanya Komatineni
> <skomatineni@nvidia.com>; Laxman Dewangan <ldewangan@nvidia.com>
> Subject: Re: [PATCH] spi: tegra210-quad: Fix iterator outside loop
>=20
> On Fri, Feb 24, 2023 at 10:05:13PM +0530, Krishna Yarlagadda wrote:
>=20
> >  		msg->actual_length +=3D xfer->len;
> > +		if (!xfer->cs_change && transfer_phase =3D=3D DATA_TRANSFER)
> {
> > +			tegra_qspi_transfer_end(spi);
> > +			spi_transfer_delay_exec(xfer);
> > +		}
> >  		transfer_phase++;
> >  	}
> > -	if (!xfer->cs_change) {
> > -		tegra_qspi_transfer_end(spi);
> > -		spi_transfer_delay_exec(xfer);
> > -	}
>=20
> This looks like it'll do the wrong thing and do a change on every
> transfer if cs_change isn't set?
This condition is hit only in data phase which is end of message.
KY
