Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF196060E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJTND2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiJTNDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:03:25 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D5258046;
        Thu, 20 Oct 2022 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666271004; x=1697807004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ATHSvk5w+NvRSSXquZp+93hUCOhcy1AtijRfw5TXKLw=;
  b=EKVtRxPF8VDMIxOgEVUzTYqo7UpjpuZY8Oj2yI3wcqWEau0n0MvgdqEK
   el7qnPpnhWAUJDXlBAwsb1O8/KGnAijFHSrJqGfKc9AmV2Rg0HWaqMb0J
   hliShEjLlyeG8WX9pcg1+eja/3m2CRnDjK98MoLe98GWRmRp/cpf2LlX6
   N0y0t88m2xQiNBWl0QqgkuuJJZ1dq8GvxnQkK4FEPHUNcftYvwNVhq52k
   toYhFFhtZzPOt5Jv7Frorhxy+yyLVYaGw1876YUvueY5KHW1h0EfiO/hl
   kgtbEWh8rRoWuInIIRVdM6NSMMSf549UkFYeJzdiBl+cwSkKqYuRTbPvg
   w==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661788800"; 
   d="scan'208";a="214325288"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2022 21:03:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgCiPeVwQ3/89QkXZDD/7TNRWZbowMYl3P6wc459Yu0rz73uwoTqeFFEYpuh5HwGzJ8E2AvqsiJrrBjOwlmpn18lx85Owwew7R0Wt9huX4Feok81O/DgkB0QY8TbHcVeZ3x8QncbulydcYfn5u1QyL8oVzdsO5G80SlxIQYI8dx+oU4Uo4OQKaQ04jRxhXHqg2jY+n9KcDIMp+PQ8Y2u6PQ8E4wVXfIdLa8o3zAI9WJGfjdemh5bEEM+qBNnlVf5QRROKS39fLIlOY7wIKtGUvuYBi6wLHkeIm2UGzErscbqSV0THWZBQj4qmheqQ03CeXozTR4iFQM1QCW31gtyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8/QWsBzHd/0gN36PXdxH/70L/HJaBYAkKejS++OZ18=;
 b=WAsrFI4A76s1z3KZeNeiLYm6wAe2qv8wVjl1iosjwDlGBojeGuuve7tph3W/ZrEbCUciW2najYK5tJB1skUqmoxUDGcJFUHPFahYjzNCLUWu4fn9SRjw2eRPx/24+ByK4YNtzGvJ+rbuquSYydhaW2hi177U/so4xw5b/kgYDctgSHPhBHHGBD6kMToCHSlS/ykqmIUfi94l3XxTaqzahOWiLABe53VdgKqPNPaR58GYr6LmAmasVhb+5aJcmfxXsi5a7byebaclEXA04Hu+bSHbHi9AB5BWqEuvJ4rfAr1ziT3XnsWTTBN36pNe3KmdeQqINNSoirHakrZag6i4yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8/QWsBzHd/0gN36PXdxH/70L/HJaBYAkKejS++OZ18=;
 b=YvzWrlAJn+TUd/+p83RQmxXwLf665MLaEEeSZ04lJKRzDSoV7a7kOUa7gyXNNGuUImXbOpiQoRvp8cqTU8v/XLRkLlS22+EVQSxIP1sGKfMucllYu++hgKtrYutU7vb//ige63KWgilaIJJ9kHxBWtYSkAFFCYryKfcabSmuLho=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BL0PR04MB4532.namprd04.prod.outlook.com (2603:10b6:208:4f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Thu, 20 Oct 2022 13:03:20 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5180:bfb7:53a8:7c52%8]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 13:03:20 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "kernel@axis.com" <kernel@axis.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: Fix WRITE_ZEROES CQE handling
Thread-Topic: [PATCH] mmc: core: Fix WRITE_ZEROES CQE handling
Thread-Index: AQHY5IQdeSlWv4Wq9km8G48ujeqxG64XP2rw
Date:   Thu, 20 Oct 2022 13:03:20 +0000
Message-ID: <DM6PR04MB6575278202A8BA1B8B98BD91FC2A9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221020130123.4033218-1-vincent.whitchurch@axis.com>
In-Reply-To: <20221020130123.4033218-1-vincent.whitchurch@axis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BL0PR04MB4532:EE_
x-ms-office365-filtering-correlation-id: ee428a08-bf57-4747-9162-08dab29b7673
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYUIirEqdNhDYbkp5zDiBZOTUpubIAJG/n+BaHzYz/CQZfdowDRGkorjVtv+aAjpuTFIjSsG2yuNdnK+usH/0+F89ANu9QwDb5zIE9/BEq02qNa8YzA1lsrrrz1i/xpzG0fm7WxmuY/myhxTSCC6fJPm317aBEe38hGNjHoQ0ne2dnO89j8we9CAvbWbFlTMsaYkgefeZTqgOILMk3bpn7r+1w/7Ol8T1TV3IctKhgVPHTM/rabVcGpskWliFseh6oDTPIt0DDMKLswpgO5+EBE/ylT9lIDn7KuexiNcFNVbjs+4DUWFGKvC0QK8jyTHQfFfyPOlWNL9A5xeOEwrqE06aGfMCMjCKcrYwHQianRJnkGHEgr2baQI85RgAJZjAlA2Id2ADimPsJAG7S7mIOtVbDc7ZSjmw7Hvwa5vfopFj+T6cLdmG1UN9x2dc3l/4JlLAW5lPYXikYR/4fY1j3ZagrZW2sQ3lRIZUglK5P8krvtrQjWDIoIxluDqjb2mDiHP2MJHQR049dOve9p6P2usFhUb9U6tewgpXo2DSfBDzf8cv7iaGIZBDNDOLI3tgTaIhVR5gKk2CrpNPborwLCUDaeyzFWe8bED/bamOirc+pdyyrHwM511epPwjdZJUamlUbFtff8j++t4MDifC/j7TIW9UHMvoTOpk8dTvJYICKHDW1/1Yr1s3Dk+jArrhr4pYP/TM2rN2ZDoGSIF4K+zIlxU+ipf1C+TgfOERpdklroHitHhVNF2rXoMj8CXfuT1LSudDKotlofmBlhH9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199015)(38070700005)(5660300002)(6506007)(8676002)(7696005)(41300700001)(4326008)(66476007)(55016003)(66556008)(66946007)(76116006)(66446008)(64756008)(52536014)(8936002)(86362001)(478600001)(9686003)(26005)(82960400001)(110136005)(83380400001)(54906003)(71200400001)(33656002)(122000001)(38100700002)(186003)(2906002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1BW+RwyxmVH31n9Cq/njwU13e+fQzJE3p5mX4FYLYy3Jk97mT0dFetu1/wrr?=
 =?us-ascii?Q?mAo+Tm8nLehP/wpd4vGTLGa1uVJkxVwPdPulQhAxo4M7zcm3aAhB9EKzucmx?=
 =?us-ascii?Q?t0t35wFrKh+VhJqJMhBiZ2SRDVjOM+0KWulJfX0ID9HCBfdiCulEVllg+He4?=
 =?us-ascii?Q?UL8V/gru8RC2x6188H9RxrsWFUk+duZtxndYMA/ZBJRvaeHfWAlotsBCd30Z?=
 =?us-ascii?Q?tK0OkgfA71P1CPLs2bhhVYOHgcd3RvAc5r31MTerCzmoLfINz8xHSKyPTLbj?=
 =?us-ascii?Q?aM/lmgOC20ro0J8Ye0D6g8h0zmz5jZ+YnU5kfne9UKJDbBRDd+yYMYjzwqTP?=
 =?us-ascii?Q?QYOeU5F83n+U67jqDtSE0xpkQiDgSk/WHS/h86DvgoC7nPRqV7qcwY7pt47h?=
 =?us-ascii?Q?YpqyFfrGOry/Cw0sRWgKne9sd6kFg4Jpzc+f14B9/BS0giyOOPJfQGgKsehy?=
 =?us-ascii?Q?DmwZ6WCnt+i5/Y94LmSFeTPRCXyX0Zhw29DMPA72kT3I2i+ZDuiLNQzfsQiN?=
 =?us-ascii?Q?hiT8WIZL3lrV7yjF2FVCbHyCNP9QVKEfJGsOUJSy8FWQdAHRIEn6Vuyo8TzB?=
 =?us-ascii?Q?/5diHtcEL0sV9mquBAvnVRJDl6QsnGIu79QnUf+5yVy8iqoJvjh8nNAHTYby?=
 =?us-ascii?Q?HweeacxtUrO18chs9Ky/+YdysYTZQzOoh8z2DeCpt3g0Ei7fRVJj4gksN/Ly?=
 =?us-ascii?Q?6pSxh0ppeqXm3iWVWp4qJZdXesndlHOZtOTtBqHqNJvyUqnuQxHbzECyz4Vv?=
 =?us-ascii?Q?0iMhcuiIIcD+u/VFy0k7ka+npeaNsn0KUvt0KcdOlI6CuI8FS3bsqDusuKJu?=
 =?us-ascii?Q?NVMaJoATAm2RJxVipz0AKiaWBZgshlZeIb2qYU2PdfA9pYVpDl8uXgYA2+0U?=
 =?us-ascii?Q?zLpEH9ebqjAguuiysj5Rr4sqjitur6iikVPCwFdFEMMA/NiJJcqo+cSSEQ20?=
 =?us-ascii?Q?DSAq0KEvVqASmgPX6Nmt5zzYJTRcR3eSYnPYNYqY60EUyjuOEtjBhPol1mNB?=
 =?us-ascii?Q?AMDcJnSId/DEdCNobO8472ynVnez5S2vPgSXEhGxus09H0x28DGcaZte/CU+?=
 =?us-ascii?Q?0hw1E2Cu9COuCiA/m0YK8uSQWmHCFjGHXjsjdlh+BHUld6ApNkNfwuu8OhE2?=
 =?us-ascii?Q?2Hv/tvKbOA06aF5R56ELXsMsIFeZ0GzoH8isaeKrOiV80UPSLyrE2zfknn0e?=
 =?us-ascii?Q?1MyJbIupxnNjoI1VHksPYIFy+RkfyosIehn5G8X/oqt9i1na7GHzvVgpujML?=
 =?us-ascii?Q?hvVDm3zavwM93TwB93StBeZF71XZr105CPhs+eATZlT0mNgAg6XzQoTDv8aC?=
 =?us-ascii?Q?ZG/nly96kozdPgHCqSXRgyxPpbhp6xOyJQVZ5DNn2zhSY7mH9Lkb1YzZnvD5?=
 =?us-ascii?Q?UHPZpSnF2eyk+Ve4e0PogXV4PshdZHT+cv8ahfxv5mr0u9QRCP/zgERWRCea?=
 =?us-ascii?Q?T1dpSRbpbd69sojnF5ODi3oQsel03fz/0YR9rcdg8K5jUrFbdM55c/n7cvgs?=
 =?us-ascii?Q?xlaMTLIujUnVkrzl9urvG6ay5QuPBwjYS2oDbJPnCFzLtulGFsyvEMDeGUgE?=
 =?us-ascii?Q?DCbKnMDXaXd3N+/kHI2ETU1A2W+maGC1HZ1Z67Ts?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee428a08-bf57-4747-9162-08dab29b7673
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 13:03:20.2838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4u2fPkpEgN4vUgNsyUSzx480JmmE6ml95+OPkNNWW/eLJg74rjABFOx9vrJf0YBGWmf1c12ghWCZivuZxo7B+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4532
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> WRITE_ZEROES requests use TRIM, so mark them as needing to be issued
> synchronously even when a CQE is being used.  Without this,
> mmc_blk_mq_issue_rq() triggers a WARN_ON_ONCE() and fails the request
> since we don't have any handling for issuing this asynchronously.
>=20
> Fixes: f7b6fc327327 ("mmc: core: Support zeroout using TRIM for eMMC")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/mmc/core/queue.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c index
> fefaa901b50f..3661ba0bbc87 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -48,6 +48,7 @@ static enum mmc_issue_type
> mmc_cqe_issue_type(struct mmc_host *host,
>         case REQ_OP_DRV_OUT:
>         case REQ_OP_DISCARD:
>         case REQ_OP_SECURE_ERASE:
> +       case REQ_OP_WRITE_ZEROES:
>                 return MMC_ISSUE_SYNC;
>         case REQ_OP_FLUSH:
>                 return mmc_cqe_can_dcmd(host) ? MMC_ISSUE_DCMD :
> MMC_ISSUE_SYNC;
> --
> 2.28.0

