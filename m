Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E072763CFFC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbiK3H7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiK3H7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:59:38 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3154B2E9EE;
        Tue, 29 Nov 2022 23:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669795177; x=1701331177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C5iCrJ6McGMlYeRyLa+ZO3Kjd365YLf+ESGPkpH+6gA=;
  b=P6XPY4nh8pGZk6IjtKYr3GVLi+9/I1VXMT1tzgM4TBQg0kKP+jKBH+vM
   1m0POQjvi+9Gc73Q89j3WksH79oo8WxnznuU2QPJIBsOtaoMN29MzlBUa
   yOk4KTaH9NQCJIYlWSiOwG1m+CtzmgakUbBox8tt0roLV+l/9lUxqoWc3
   DFpMC1xODI0dFmu4tMpwO3LltREj8jo1ZE5z7NLDbsYYwhUMAQJdmj59h
   U62RaErOQ7THhfy+cjwbSHBCqvXNVeeFh6ZcGie40cbUdhGD70gobdPp5
   bQyQEAEyv5EViJX+YpDJ+0GuSeUIUhRLJYIvsVf2nipGs9YmLS0REpMVX
   A==;
X-IronPort-AV: E=Sophos;i="5.96,205,1665417600"; 
   d="scan'208";a="217529789"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 15:59:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4J9Ae2qNLIwnBpWCUwgRUOAS6E+QwrAKhjXocNShHCVUuoA+EsyPPGn8CRCKDS/HNbq2hIzSlsC3vu36LNy/58PAURkhfT7kEP/kKxMoVnAe3UtcGYrEfG0rkpux6LYJQ6NOZjQygwPgvx7lp45mvv0GbW1IXwVZNG4BMrdLEGhWWVX5j/IbhJx6esIlatEMN4KAU5atGlMC11hGKCZz4FvO4v8BQMKFjCpk7DGorLIgvLaxkNjHBBukFFOZKnRrGmclkdgvRI8zTxXWzmJya+zHPNIdIBMwHJdCH47erNqe/vB5kLm3XqM6iWQU1aMfk18PWBZkZk99xE+wQjeFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuDlIl3yVfX7G51xG3eXjQyOouaCg+L/APRErWXYKDE=;
 b=AQtSt9VV/tF/ssvZsCHjcWAtprpOxoUQ0zw45+XZQ/+mXSKnvhhOwTgLtJQChwtPn2GCinnx6lO3GukMiigJiLLCOkdAP0DLaAHVo7/c3i5CwRk1DWCzy60n3bPIzGuYS7ZeX3BlBaFZPHfQRrzc6v3OPFXHjqnT0jgmGpW9763bN3yr318ueDHX4/oyjAo2SwR1Tve4yMnYHU6msousACxjGvw3t0H5H5CsEBF7p4Z9oQKq3D+fyzjh1ylhpRYhq4tfvRr+uoJug8ozOP0eQDjvkqq+pJp2A6dWVvxrUGGiAjCF+28fIvlr9rDT9OU2PaYE9MdPi7FDsRgx6TOzAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuDlIl3yVfX7G51xG3eXjQyOouaCg+L/APRErWXYKDE=;
 b=hvRDMIcakI78oIoeaXIztH/rWFmr5AhJmmV/PiEdSH6zUGD5Wp3SQ5Z+bOqzlYE52CGsBQW+FOWR1L1sAGJrB1aMEuWmspj7ZmnKiuGGWvvBgSqdi9ZS+6Z0FxMjqFjw6T/lrTALsqnZHbsNtlzzHB+tev/xZONYsPZ6Cai399k=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7336.namprd04.prod.outlook.com (2603:10b6:510:c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Wed, 30 Nov 2022 07:59:33 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 07:59:33 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>
Subject: Re: [PATCH V4 1/8] null_blk: allow REQ_OP_WRITE_ZEROES
Thread-Topic: [PATCH V4 1/8] null_blk: allow REQ_OP_WRITE_ZEROES
Thread-Index: AQHZBEpV3/vIPNnSTUWn9aHpK6AE0a5XGscA
Date:   Wed, 30 Nov 2022 07:59:32 +0000
Message-ID: <20221130075932.nfbxiixykfpxrweh@shindev>
References: <20221129232813.37968-1-kch@nvidia.com>
 <20221129232813.37968-2-kch@nvidia.com>
In-Reply-To: <20221129232813.37968-2-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7336:EE_
x-ms-office365-filtering-correlation-id: ebe0a6f5-4f71-4c0d-657d-08dad2a8d107
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LzNjN+dSWgvZnl+vM8TQ3Qji4LZY3UA12Pm2Bxpn2qNaKRfi0+PUZ5XI/yjyFEo0uT+Mt6lUB85y9YIdPvlRb3Nu75Xummv8hbgsiDK1LlhzIFekiapwoTdxSh87QhfR/b15A0jOLhMHeuz1N9ymQPYWuJ+RSmT93zEjNBeQWiBZu87qG9O+EMMJgFsZ6gSEAMM81nZ9LEbItzH3LhW0GTLDouutwIsp7fss2DTQ0U+4oNVsB/ejxmOAYB9+HW+uZTswBw2QP2NBYjiCxvnce3a/MKWfVMtfLoSQ/IKDAvzj+aISf+JcyxZ+tfCyH9PA5NBPxBXhQhZb46bKInPwme7FWT1r4LsxoK5usjTnHQqkT/xom2HUK5pVa6v+TqAJsKizIDLEYXuZ2VAe60PDoxXABfvgEei0pJGVBQsmuvpe4PLUlhyjPj5CnSXdLZXbB8/p2JftE/x7XUKjjtMnm8FcpH1AWDZrp4EPva8G72vucnmbRh2vgX2D9zdSvRUD7wfzi3pdUKAVaHZDAzy4Gyh4KAKM85u+Jkpm7OS4SrZKbyVs9zNtofrynz5eA4QehMdUz2zhcykOigTRQdP+x98VW/nRiau0mSSARHzSx452Oxqc6ky81t0to6l8GJg7vsesYSeOqD4aUt9PD25QPnq1vXtoD9ZtW4pGGbzo2YrgZsSRhyWImOhqrYVvaEur4FihjISuwLEX1JP40D9OiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199015)(71200400001)(6916009)(186003)(66446008)(54906003)(33716001)(4326008)(8676002)(64756008)(8936002)(66556008)(66476007)(41300700001)(5660300002)(91956017)(66946007)(76116006)(83380400001)(82960400001)(38070700005)(38100700002)(122000001)(9686003)(478600001)(6486002)(6512007)(1076003)(86362001)(6506007)(26005)(2906002)(316002)(3716004)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5inh35EY443juo+0wGiHgV2z6iaidxWEPEJwg/FAWWBm+lZqaBjobQZzN/Hf?=
 =?us-ascii?Q?1KXgHnlZkE9xLoV3RlCS36TnqQBTIqP16AWt4miNduV++ALCW3E/ZqAF7xkW?=
 =?us-ascii?Q?WC/VhxK7OL8dFvZwCg4dosaav4jS1q7XoPWVmN/DXlheCwjlEuAWq8LcSBCR?=
 =?us-ascii?Q?mTielOOPxNYyGZ7HnJ6926pOm9pVU65DFKKBKPnB3aJKQsBtJ60kKOfsA2C6?=
 =?us-ascii?Q?S4K3Pe/73wlPNRKtxCWtvfzDJnRgF//ywZh0xzy5lSbY9ah9h189zPQplXZh?=
 =?us-ascii?Q?I1od2yTWnLQpKGbly8EBZFi0u9Tvm7IiE5U95RG4hHI2VB/IMeP9PqOOp5I7?=
 =?us-ascii?Q?AnuxFtInwEhB+vkclBgJb57YsDTQB7eY7aIULxBucfon3sXgJYO0dIK48cTh?=
 =?us-ascii?Q?C4LLSyY3ODsc4F4U3gYZv2jMgsPqy+Q/zgNp5kfs5UkvHEaNWYu4BEo8kQ/W?=
 =?us-ascii?Q?WuecnnR/gXrIT63u8VNKIPXfCNiCmeRhNZiU0rMRKC+6nxNlXpdNOk+hANQC?=
 =?us-ascii?Q?F+/LzB7BZSgmOfM3wzK/ripydXw8hb0IxAMqEwGQf6SX3kucIntS1IeIwd/w?=
 =?us-ascii?Q?dMGLq00cC3b3FAMp7NeLclk6rkhpiHEucnHmLbunrWlyRnzZGy0CGhOp61Eh?=
 =?us-ascii?Q?TCyb1Q5vpk7XSBWWWMjC74CY2ToZOf4mFuNjb9A5rEyn5+45ZMfj0y2GR+Q1?=
 =?us-ascii?Q?O32vYDO6YFHHQy/0UaO90nPmU7+AjYOz3Uvl91EP9MuSHyZeVRopN57ooPlr?=
 =?us-ascii?Q?jqHHyBanNSCpyrBMz7Lf86/T2yJL2Uyct6wIeMLQt1HnVpmpWK68qy+yVFNp?=
 =?us-ascii?Q?JEeZamamFnBQLfjedn8V9Us9a6RXj/4ZHtZrjuzu03Mvfwe5rscBVpzdqOhj?=
 =?us-ascii?Q?Ry+Ajyv7WYdKCCcEjCV3LUoHAHa2UfGNLvbJ/fxMCenC3boqyYl6O0ep3LOo?=
 =?us-ascii?Q?iwSf3uZKdhJX1UrU9vjjWL6w9EHGk9ZhBJWvIyC6EDc1WhAlkqukYsDTFJMd?=
 =?us-ascii?Q?r7jw3BcZE+GLrpy17y16Wj+yezQBe9NeKmH/0oIKEgyv7pQMTR27EyjX8wuf?=
 =?us-ascii?Q?cDL7OrGfELBfvRL8rnRMH+n7pVqIoaVw+KOZgv0A1+oH2F+0d54XPHztfOaD?=
 =?us-ascii?Q?nagj5uDgiFozUVhLtFdK69M7ySRqpaiA9RpJtmGpNw1ieYZdeRpNVA03K++e?=
 =?us-ascii?Q?Y+uAtLtgL/YrKzmJM6e7clthSVeNL8MsjeQxtaE5yj3VjLtT7P4E5oRC8Jsb?=
 =?us-ascii?Q?FnqeuWzoH4Z08SCp/9HnlR71BmPs3tyDFLKfP74kqywxyyFR1GstlqvGu5nZ?=
 =?us-ascii?Q?/2jjkUxftBPU8aXmGfJvGibvrHWhy/o7nWG9o3rqAKZgH0jCP6habG4Z+NP/?=
 =?us-ascii?Q?V6DvleLivW7v25UxBvnLzOPt51TKe3gp6udFwt7mld5akyZIvtZEx9njbBJC?=
 =?us-ascii?Q?CSiAKqkZQUL0gxHRhHLxEY5BGPO2+rRn7Da2FN00YT/J0+wIodJbxLWra9Vz?=
 =?us-ascii?Q?SOgNAlwBLw1CqKUbrScvV67FICdO0SH302hdD65Ohj8D9toB93i0mIpj+bno?=
 =?us-ascii?Q?J3sDtkSF68LOcR0YinccNDJ9G3eNsdu2KjCQHyLaCvFCGUnTgHhlVI6eBDXw?=
 =?us-ascii?Q?2tYKOHD6LINUnLFHgAgKnvM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA94C8264A5BFA4F959473B3B42F3B53@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?s59o/7Wk94rh9/G4KnRtEMc3P6tZ5FLu+92hTTzplDQkh7yyMSVanYvkhDfP?=
 =?us-ascii?Q?xMuJijOBtOBYyO4HYcaVOIN3tiWQND4koCJzwmz5TdjaRsOLMW20ov8SsZzN?=
 =?us-ascii?Q?oXayPSa9c99D2t5kvnv0/hWQRFQOHRbVSyBPllBIt8C8I6lHDIaVcLcjrepZ?=
 =?us-ascii?Q?8ETtgmyzypH9g0R+rHyLDnpFixY/AlyjZURDlsPAGcKGS7VjCinZGmY4ekZd?=
 =?us-ascii?Q?0LPxt3VdG92p7uHurHgLZam9SIViq23j7U9Xt8G21Rb6KtJhZagSvekI+kDd?=
 =?us-ascii?Q?rfxNoNvdiI4tP0q7aPBEtSGEU+ugrr/OwTk7St0Wba19vLLx+5KeTkDYhyhO?=
 =?us-ascii?Q?vLjDUpGJkNcptEMlTugw+WFSVFuSFz/Tb36EmnVFTvgvFt/dFpWLT4VQ2cwh?=
 =?us-ascii?Q?wAedg8LqK4wgokgJ/mbspQRJxKK314zQUU6ydtToic6o24WHr6QX+X3etd6S?=
 =?us-ascii?Q?gPABwLa4Zpq5ysXJpvYesZLI4rNQVSeFz64KhzrkQaU6a7ih8xmgulkrMzYR?=
 =?us-ascii?Q?6OXG9yjbchcuXh6UCj0QrMM3/V7sKtSbouXOmrBUNO9jq6iG/8Zl5oqs2BpC?=
 =?us-ascii?Q?YqAo9rXPijyNvg3Y2rcz4xkBl8TtkeYwIJ/jallUl55VscoLx2L197Rm0mRy?=
 =?us-ascii?Q?g506jx1Eu1WJ23RaYjcmtUNnhTtPyzdA016+LQuO7BoPj2UPTAwLDY8vT1km?=
 =?us-ascii?Q?CI4/qopfcb3Qde9tsA4NaW5KAW8tvJwpkgreQ5D3XTGWmwicN64b4ExLrY23?=
 =?us-ascii?Q?HnkcQeoG3U5PdHk3qwLZ+q/lXwgKafY5tkoGCJC3G7lxHY2c4NCEetmizw+K?=
 =?us-ascii?Q?PaumjUoHu0f+Rs7uX5NM80dkAmZR4ONVD/wE2RfkhiCVqzu8GsN64RX9sck/?=
 =?us-ascii?Q?7Rbq0iHVsa5LVBVwZBq+3xYnLrDefMCQjLaKgdUhaDZ2E2LYyqkxdv2dR0Lo?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe0a6f5-4f71-4c0d-657d-08dad2a8d107
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 07:59:32.9452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OiYhwhJu3f4VvSgsVkwmE6ma2qXRF23Pax6HRxQ1X6okbFplc8nMcy8HAqCtV0RLaGNRgroGrFcuYZsWee/nXuMJLkQbhjFCmcWafAmIz+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7336
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2022 / 15:28, Chaitanya Kulkarni wrote:
> Add a helper function to enable the REQ_OP_WRITE_ZEROES operations
> when null_blk.
>=20
> Since write-zeroes is a non-trivial I/O operation we need this to
> add a blktest so we can test the non-trivial I/O path from the
> application to the block layer.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

This motivation sounds good. I tried this patch. With a quick test it looks
working good for me. Please find minor comments in line.

[...]

> +static void null_zero_sector(struct nullb_device *d, sector_t sect,
> +			     sector_t nr_sects, bool cache)
> +{
> +	struct radix_tree_root *root =3D cache ? &d->cache : &d->data;
> +	struct nullb_page *t_page;
> +	unsigned int offset;
> +	void *dest;
> +
> +	t_page =3D radix_tree_lookup(root, sect >> PAGE_SECTORS_SHIFT);
> +	if (!t_page)
> +		return;
> +
> +	offset =3D (sect & SECTOR_MASK) << SECTOR_SHIFT;
> +	dest =3D kmap_atomic(t_page->page);
> +	memset(dest + offset, 0, SECTOR_SIZE * nr_sects);
> +	kunmap_atomic(dest);
> +}

Did you consider to call null_lookup_page() for __null_lookup_page() from
null_zero_sector()? It may simplify this function a bit.

> +
>  static struct nullb_page *null_radix_tree_insert(struct nullb *nullb, u6=
4 idx,
>  	struct nullb_page *t_page, bool is_cache)
>  {
> @@ -1186,6 +1211,27 @@ blk_status_t null_handle_discard(struct nullb_devi=
ce *dev,
>  	return BLK_STS_OK;
>  }
> =20
> +static blk_status_t null_handle_write_zeroes(struct nullb_device *dev,
> +					     sector_t sector, sector_t nr_sectors)
> +{
> +	unsigned int bytes_left =3D nr_sectors << 9;
> +	struct nullb *nullb =3D dev->nullb;
> +	size_t curr_bytes;
> +
> +	spin_lock_irq(&nullb->lock);
> +	while (bytes_left > 0) {
> +		curr_bytes =3D min_t(size_t, bytes_left, nullb->dev->blocksize);
> +		nr_sectors =3D curr_bytes >> SECTOR_SHIFT;
> +		null_zero_sector(nullb->dev, sector, nr_sectors, false);
> +		if (null_cache_active(nullb))
> +			null_zero_sector(nullb->dev, sector, nr_sectors, true);
> +		sector +=3D nr_sectors;
> +		bytes_left -=3D curr_bytes;
> +	}
> +	spin_unlock_irq(&nullb->lock);
> +	return BLK_STS_OK;
> +}
> +
>  static int null_handle_flush(struct nullb *nullb)
>  {
>  	int err;
> @@ -1352,6 +1398,9 @@ static inline blk_status_t null_handle_memory_backe=
d(struct nullb_cmd *cmd,
>  	if (op =3D=3D REQ_OP_DISCARD)
>  		return null_handle_discard(dev, sector, nr_sectors);
> =20
> +	if (op =3D=3D REQ_OP_WRITE_ZEROES)
> +		return null_handle_write_zeroes(dev, sector, nr_sectors);
> +
>  	if (dev->queue_mode =3D=3D NULL_Q_BIO)
>  		err =3D null_handle_bio(cmd);
>  	else
> @@ -1800,6 +1849,13 @@ static void null_config_discard(struct nullb *null=
b)
>  	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
>  }
> =20
> +static void null_config_write_zeroes(struct nullb *nullb)
> +{
> +	if (!nullb->dev->write_zeroes)
> +		return;
> +	blk_queue_max_write_zeroes_sectors(nullb->q, UINT_MAX >> 9);

Just comment: this value UINT_MAX >> 9 sounds a bit weird, but probably ok.=
 This
value was introduced by commit 306eb6b4ad4f ("nullb: support discard") to c=
all
blk_queue_max_discard_sectors(). I guess you chose the same value for write
zeroes.

> +}
> +
>  static const struct block_device_operations null_bio_ops =3D {
>  	.owner		=3D THIS_MODULE,
>  	.submit_bio	=3D null_submit_bio,
> @@ -2111,6 +2167,7 @@ static int null_add_dev(struct nullb_device *dev)
>  		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
> =20
>  	null_config_discard(nullb);
> +	null_config_write_zeroes(nullb);
> =20
>  	if (config_item_name(&dev->item)) {
>  		/* Use configfs dir name as the device name */
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/n=
ull_blk.h
> index 94ff68052b1e..2c0c9c29158f 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -111,6 +111,7 @@ struct nullb_device {
>  	bool power; /* power on/off the device */
>  	bool memory_backed; /* if data is stored in memory */
>  	bool discard; /* if support discard */
> +	bool write_zeroes; /* if support write_zeroes */
>  	bool zoned; /* if device is zoned */
>  	bool virt_boundary; /* virtual boundary on/off for the device */
>  	bool no_sched; /* no IO scheduler for the device */
> --=20
> 2.29.0
>=20

--=20
Shin'ichiro Kawasaki=
