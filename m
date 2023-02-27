Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C026A4B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjB0Tob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjB0ToR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:44:17 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CC71C7DF;
        Mon, 27 Feb 2023 11:44:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRqvHat52wQBPk/OBu3EPWZp9lusxkZGWPv2Zrm/vxl1UP2IZqV8cJveJu+7x6wfcnuB1ukiVy6ZaeEBsM5nlfWInQeobb4RxB9hvyDqJDmAohkuimvrExY/+zoXlGKwUnB40WnZnTib2ir1KOazfaQhkuJOjQdOpKIiVYGLluDltEnHMRl5P3qmeRQzau4p9ugYpkRPTM+TalR9RDaxsg/O4GcCdiGP57pqODHcu0cYStScVpVWYWR2FHJdgSsywelc+dC0FNr70sYm+BQQRJU9WZwkZUp3MLwMFJgxNiPqy5Wn7oS/YbX+OJotLGlJkWBt9Ogyo8wt4lnOhoUOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQNgZplUiRjC1k3NS1nqhDPh8yC9GoPoIOfiVCclPx4=;
 b=mNcwzQf4uNY145FeRnOXMKLkD0eOv3nYn2NfdlN9dRUw7XiE3MFJPctjo9qlOsem+8b+QAATGY1Z5JQr6BetYusqkW4i3YAuKYluhkxTtxifGV3wzLkeTYTDvJnkY/cjfLWq71peO2PBu3pjh4B+SS5qbRo+xc/VKO/XQggwSNS8VlCPsb5BAEars2yYTZI5XBo3pO1COOGTnGZmjpG7qrDkc/bUo2uc/gwbc0W/Y45B94iBS0Jl45L4uKUKUWsZmz7owkEW3TZc/mkhZCvVzFzpQehxH4J+QeSD/PQCTEvcAJgf1YAVs5ZUeeB8LeVInidKxC+pE46oaA+Qyp7XQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQNgZplUiRjC1k3NS1nqhDPh8yC9GoPoIOfiVCclPx4=;
 b=arA7qJ8RfObhQUanpLuavjo69ByHSk3zHrzJ7eeVa81huD5M7ra22awJXtzxLIzMT8xf7ila4X3KRp1nL1RRVU25O0mA7tMPWQfxzaT+vPVyRLh3tkgx/0LMEcT5PhuTg/HO+mhlmTYUetMCIh9a4u3Tq/x2pqTsbQucLCirepTFisKEgjgqYHdek4+GsmxmOJYp8DNYMogOFhNy2vhnjx4H4FZPkbyAYPiSeUrJJkW2uHLGdf73Fo30zRMJE7ZAmcCeYkex80KjSSRPZLyqoDtBsSEkBenRasA2yBM8dWHy1ha8GzZAXgIvqIB0linLI9Fps3YoOxmi8nR4bnE1pg==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Mon, 27 Feb
 2023 19:44:06 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 19:44:05 +0000
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
Thread-Index: AQHZSG4K8+wSVKmZRkimkrAiwHDmq67eTmSAgAAAM/CAABMSgIAENYWggACJEQCAABVWIA==
Date:   Mon, 27 Feb 2023 19:44:05 +0000
Message-ID: <DM4PR12MB57694C0EEA61D168D3267197C3AF9@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230224163513.27290-1-kyarlagadda@nvidia.com>
 <Y/jqCRAenwbqc1Uu@sirena.org.uk>
 <DM4PR12MB5769BDB91342A9768207BD84C3A89@DM4PR12MB5769.namprd12.prod.outlook.com>
 <Y/j6MxmOkZj/TKej@sirena.org.uk>
 <DM4PR12MB576994B630B7D8F43BD21F73C3AF9@DM4PR12MB5769.namprd12.prod.outlook.com>
 <Y/z1Eu3DUaU/Dbfh@sirena.org.uk>
In-Reply-To: <Y/z1Eu3DUaU/Dbfh@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|BL1PR12MB5753:EE_
x-ms-office365-filtering-correlation-id: dfae91ad-1f5c-4bcc-b79c-08db18fafc53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PfTnT3f4XGYG4b8ULMJABiyKe+fE4H2WKL45B/D/NP9jpXc86Jox1YBQm99FQ2LkGz9nwT6E1oKFMhxKvcCkj25Plw+uad0zC3r9y/Hk5XOQ8x8gX9WFQENAvidfesBdQ7ObSxqS2U2gxLoQD0QkIpMR4qkVihIQLKCWJay511dd+ecpU/hLGEPJFxermVhj1zyJ/9LZBLh/rRAvmCX7QlyqRGAQtTZJy4K/3yl1/qi9ndUVPvTKlzFcJVFG6naTiDoSykoZmWLTQHGsqpIhQZP+mjA6F47m3iCC4JC/Y2CkLSCL72XS6G5meGWfbl5qmWX0ui/zaEwWP14r+HvW3k+nRQarc4TquovaxCPAumIgL7jF5fM1siBVJewrzxCjWjYIdDThSQvWQQPBYH31gmRy91pW+cRLWZAj8gylWhkvC5dmh9FVQrw0bcNFGgdpPAQdjcaB1EGH4TtzjzLTbn46MVQMnp4nCCPudbv8rUYp+dcrDtkV9007T8XQgFDp6hpxjhpc4nJ1BgLvSCkzBSG4XkyX9WasJDWlR4VPrdW7VZWgvR08dh3jklvhGyGWy5dZzclwXJXb34Gv8slJ6xtpJVRA9TLnnNo9SbmR6nIpsonv56+OGo7Z5YgiXV4pyA1lQHPcd5aEXmT2hgJo+n989PZUl9QE4vIrGpW6wuprKRggezM4+9FXAMKAs6luvL0vuBTMrSSB6yDg0nL28w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199018)(55016003)(38070700005)(86362001)(66946007)(41300700001)(66476007)(66556008)(6916009)(76116006)(52536014)(4326008)(478600001)(8936002)(7696005)(66446008)(71200400001)(8676002)(64756008)(54906003)(316002)(5660300002)(2906002)(83380400001)(26005)(107886003)(53546011)(6506007)(186003)(38100700002)(9686003)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mZ8Q71suiYeDsM/vSd7frHcy1QjVp+bu1l6L8YgdgcemAiXlv9+iGDvNeXdK?=
 =?us-ascii?Q?ppcx90J1fhMNHpIYC46TR5fyc9mzDbaJm9DOmRMX5aazYsJwmdpaQ9yYTGer?=
 =?us-ascii?Q?hxjZGN/EkAcppoPopNts+5nE/wwYvTQS34hU7fLnhROoPbkpKHAemIb7ggVz?=
 =?us-ascii?Q?iflg6k8JyC1MgWjGPFE+iOPMMnjj8Tg+nzhrYzLcMtYYOho/Iq+RaiAaBvKq?=
 =?us-ascii?Q?qUAPtaaBdkqiOvUE9CruBBYN+/Ka1gWmTR09D4SpWAUXqBQEzS5IqpTTwUu8?=
 =?us-ascii?Q?K91PixQHFD1kcKfnUDZaIc579X+utSh/A7tQ2SlZkoXTTA2cokahvehTOHuE?=
 =?us-ascii?Q?m3tNiqcA58KrRlaY4bFrFaNbSvbVh7J67BooMB/GdQwZ6JnQjADVokXdchsH?=
 =?us-ascii?Q?jjaaFYlOrwY8Z+oyEe1Cz7hV5JxcypVjh+HhgJXSeRoN5zggDh8fscz1wFQx?=
 =?us-ascii?Q?Q6w/ELBHDgw9+o94YCSGR06poPj569BMcLEOVbYOJabzLm+IKcGtQsrA+797?=
 =?us-ascii?Q?zyXGoTIbuZufuRVHJp+B8W8Cr6RHijButdG5dzKfGIETNffuVvq7iD7vZFaF?=
 =?us-ascii?Q?lqQvWv2FoTQMjbTWdx3iGSqh8xlMUwp1R3jmXC+0aRx+ww+0hEWLJyoywZ11?=
 =?us-ascii?Q?tbv5sLYihRb3ZPR1X1VdQjJs/ZJLxmrQmibWhwMCP5qzR+Zcml/VYlLdLCMd?=
 =?us-ascii?Q?J6umWqrA3lfAFYtAnqdYE+AcElsrxIOs+6+mNLES3emgFLgy+jGMou0QWDNY?=
 =?us-ascii?Q?b5XxSfYwRceU09IB0z1WEzL7hdWyKBlkjTRHbmH2t3HcrpTCakmb4HFvFJj1?=
 =?us-ascii?Q?1PpSR4r4E3vvAN0dhOQmpGj07NSzs1zzXRtIJJIokVWD3XjYB312kKpvejvw?=
 =?us-ascii?Q?gKYNzKwbmO7KZqU/MDA00bLYUZUryV0YlVI2n85ojWOWmWAMwVHQJjwng8I1?=
 =?us-ascii?Q?yYcYfvaa4zWFWLlhx2cjuNrNy4HA3PPM/aoC9l2YduYMwQMnsyn1gWTjtCvI?=
 =?us-ascii?Q?kRugPtD6DjHRktVacfciumbN5XGBXIkheMGWrl1v+qBA0zerXbU/m/eYIP+j?=
 =?us-ascii?Q?OorLgK6FJ1Twtx6ioshaqMlZHvMWxb7YBS9t1zI/lswokp2rckBnInZKLEb3?=
 =?us-ascii?Q?mp5QFHtYYNEcQs24QZoTXF3mqCOdacy4aj9KPw1isn29ssIyymntdARRnrp2?=
 =?us-ascii?Q?0zSxJDwG9NyOjMzDpDdjwQ0zFO/2AUyCAlfYCD9kL7SnfY7zqkz7Dr5Re0bx?=
 =?us-ascii?Q?knJ+iHWKwrB99fG73I6AMmgDvft6GJ/Vzgdr//NGC7pOEBJ6dMUdHZybSYNA?=
 =?us-ascii?Q?pNsF+nHjSCRjuE7G7Vgavd292R1JYo64ZaVrsyCPr1MTOUNEAtxxREzCewog?=
 =?us-ascii?Q?nefVai7PGF1lMyJi4jOzp5DN14FEDrr4LUNnEKp8NRFh2gukIo8L5Fu2uc0A?=
 =?us-ascii?Q?FYsItXgiCcNPByxSUU7G9zWRkxtUojxp2scBRF3MAK8CnUg2X5WPMZn7Zr51?=
 =?us-ascii?Q?PZatymzYKzXBYlCGi9z5FvcGalQ+Gff0rlOHVUAE2pxLPfl7SVsgYrm+npB1?=
 =?us-ascii?Q?Ec4TUyZo07+bQJQXTwHIaAe4Ec0bMSFcSv46C4tP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfae91ad-1f5c-4bcc-b79c-08db18fafc53
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 19:44:05.6824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFwPt5AzNa0lcpWDKmoCTbqMqRGCubikSV0KREfU+Dfi8qvdjKy0nMSZxb12K8ZBegUy/9rGLTVmyc6VBEEzXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
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
> Sent: 27 February 2023 23:53
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: linux-spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> kernel@vger.kernel.org; thierry.reding@gmail.com; Jonathan Hunter
> <jonathanh@nvidia.com>; Sowjanya Komatineni
> <skomatineni@nvidia.com>; Laxman Dewangan <ldewangan@nvidia.com>
> Subject: Re: [PATCH] spi: tegra210-quad: Fix iterator outside loop
>=20
> On Mon, Feb 27, 2023 at 10:36:18AM +0000, Krishna Yarlagadda wrote:
>=20
> > > > > > -	if (!xfer->cs_change) {
> > > > > > -		tegra_qspi_transfer_end(spi);
> > > > > > -		spi_transfer_delay_exec(xfer);
> > > > > > -	}
> > > updating the length of the message.
> > > > > This looks like it'll do the wrong thing and do a change on every
> > > > > transfer if cs_change isn't set?
>=20
> > > > This condition is hit only in data phase which is end of message.
>=20
> > > Shouldn't this just be moved into the DATA_TRANSFER case statement?
> > Calling transfer_end after updating message length.
>=20
> Something seems to be mangled with your quoting/new text here so it's a
> bit unclear what you're saying here but if you're saying that this is
> due to needing to call tegra_qspi_transfer_end() after updating the
> length I'm not sure why - AFAICT that function doesn't reference the
> transfer length at all, it just writes out a command to configure the
> chip select?  There's no issue with the message being finalised since
> that happens in the caller.
Yes. Length should not matter. Will move into DATA_TRANSFER case.
Also need to handle error case.
