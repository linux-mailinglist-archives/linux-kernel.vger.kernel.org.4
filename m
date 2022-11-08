Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6998621293
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiKHNkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbiKHNkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:40:15 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9971A4FF9B;
        Tue,  8 Nov 2022 05:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667914813; x=1699450813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wn+iRvL3iia8RAMFhCHV+NbbtnnH0z0Gu40+kscGLJQ=;
  b=THDTKY48eT5mfXxVWZFWZajsC6KjRmzgZLhsE2ZnrzUuipsID6LW5Vpx
   v+srNYe2+5lclVQKPIH5nUTYIZjKqcIlFtW9bM6MP2Cas0Jnulqwaj8gi
   Bub+5swxm6rOToMK2jAkoUAVjT+guKC9koNFys4n7FQIwpjG/NTmpU8RR
   dbEUr98IFdnw5lGy+DTBfXFkAinoOM6R4Ea5YfnG76sFzlfkRs1H6xDD1
   4y96HEHuU6nTmqba7AmhujnoBTBWkjGlm8bGmHhL402rBPf+O6wWqwelw
   dnhGVmwxokEk9Fmp2Ji5j9Iifz9Gon6MGCShKMSPKJrHZiBMxiY7sPsWX
   g==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="216098815"
Received: from mail-bn1nam07lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 21:40:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QF24pb6P1JslfcytD8yKgBN3BIjuMe4brojGBDUVzHS4cKoOvporAb4R+vSOEqsRu5LzO5oZggY5X+iD1dXt/JYNE5OBBR6GLsvVik/gPclEb2WwneAMVXiLaVZGbc/cdDexBg8afMCklkDMVEP/xptvQpdaGOUQxTW3QAes57z9qssKFkeAfCPBohsjCfRzaBjNkq1urjC+Ht9R/ZC20gh3grFRmNm0QRaBxEaFNR/7SvijHUO6m69M7rmZFtykWyUO7KCCPoEbV63L6punxWn7x6pvnfgNlzKPTk260hKeS9Cn5qkGMbT+86Nk6zepoyPQ/gN1q5luH5QM6hunwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Yu4gToVWbK/rT1bgtGsqGZUOmvpn8oPMTZ36RTIA60=;
 b=Au6DzaM6rGzCibDzeT1cwrkziwJcdaFheBOr94D7otEVak8MWVQR2qpeuqpH3fI4/Do10GQnLAz2CHvhFISQgL01HphVbC8Ux/gBuZRBFYGD0Q0egG3B60SsOjr976HaPNfrvmaInhUCl05C8MAopebBOnUv3G5+7I+pBKYeKXxUEZJ/2OGndLaL7nbnAqWn2BDgaYT3G+vFu28U0hxSgQk0neKcD38byNBkLMG5bHq31bgdHemIeZWffDgNV0xX81iTyOdMHMqdK55Gy5E7yfrvE2uIG8LYsHGNQw8GRpLRmNDttHOaLNOJPjsGNgoX/06wcD/ZoMvyuRSH6CJsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Yu4gToVWbK/rT1bgtGsqGZUOmvpn8oPMTZ36RTIA60=;
 b=yvMfjbjZuaDB0EEubUJ4Sl5RlIIXSFoKb19PjB0vRoPmrKgnCkomaQYPx12PtYxA675Bo9BF0pBLGWzCzv+GqD3H+mzie5qCGXV/yiE44c3y623fGWJF1MSM/CWURDG+RIXnEpcH0q4D2KMAvwdV5NoKnP1P1IN1Ep+k16yQtR4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB5475.namprd04.prod.outlook.com (2603:10b6:408:50::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Tue, 8 Nov 2022 13:40:08 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%4]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 13:40:08 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "hare@suse.de" <hare@suse.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v1 1/2] ufs: core: Advanced RPMB detection
Thread-Topic: [RFC PATCH v1 1/2] ufs: core: Advanced RPMB detection
Thread-Index: AQHY8qptSXvFlqlwnEWjfKOYjvP9p641Bisg
Date:   Tue, 8 Nov 2022 13:40:07 +0000
Message-ID: <DM6PR04MB6575145B168BB80F3D2910A7FC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221107131038.201724-1-beanhuo@iokpp.de>
 <20221107131038.201724-2-beanhuo@iokpp.de>
In-Reply-To: <20221107131038.201724-2-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN8PR04MB5475:EE_
x-ms-office365-filtering-correlation-id: 73ef1483-baaf-4172-af05-08dac18ec029
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pItGnkL1N0Rrk9Vu9iHJYfXRVdY6uuZ4xBL79ldC9exymS6FoM/Ya7XhkvlTdgbCEA3xGvu0q+ejsiLjzvTS1oowOKS/BSz3MUKZkP790IY7scwQWoeG45mJ0YnxzweFSZNdSJLucwRrLEWEf4IkNdz3FPlj48L+5ZF/aoMLYqqMiqxak+gf3y1xVm2IyUDjPBnPBJzIAPlbFM7DtE7pMIal3V5Gj7DSHvbdk0eJscVfUtZNweXb3CT3t9RGrrtYV2SftRAsNrzE9BF9KbSQtIkdoeMk0Lo0TtRUvqhO1PXUZhMC24/zFEX6t7obTTA0zwVk0F9rAoVE9GMhTfSGV/+AcqhYaxVIdUpKymX2A2qwdB3LIT7XZL60D3SpnjnMKpeW4vEIxclDgG6wwA8of2Dsp8gQwNnt3VjPeDy0SXL2xgLJEqCftBqUicWouTWKgmkXrYxS0Gq4QI/9BKhCrFrjEZ3jt6SR6Gz9G4ji1FMwBn8tPx5ciSEXAQKYcprhVGYG95NuJYAwRMGZyZfTaP7tTT5F7KONVSSleJmWQtElII9M/RXv2fRW+PyGgRrVIM+mR8gvAwnf5azfJAUV02JSDXdT/u5LqOsdhxyETlZadNWEBFWdxel/eQGIionKlFKv4P9bdjR6l8kEdQ4fSUABTOkPvqWUAOb1+MRIvgxisbB2J+w9kfBSfW7Pfi+wh6w6oClOfAQA/RzWmGsG6P4eeotZV1cRPtu2Z3RXPBEtRBqaqeyGAOiaqYOv6FDzYK0Cl5cWbEH48taSHtRMMcLjMzj48WTFaX/CAY2d2zU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(64756008)(41300700001)(82960400001)(7696005)(52536014)(8676002)(5660300002)(66446008)(66556008)(6506007)(71200400001)(7416002)(122000001)(8936002)(76116006)(4326008)(55016003)(110136005)(54906003)(66476007)(66946007)(316002)(33656002)(38070700005)(921005)(2906002)(38100700002)(26005)(478600001)(86362001)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZWE04QCvd2lFLcvn+L8tTVHyJ9thP4bjWbzmB1qeZlhDukCLlbWsRtXD4mS2?=
 =?us-ascii?Q?8UtM2Ab4wbXj/oa0r6zD7ipSCKghK2R13TPGDKIL95hWCR62yc/467TIQkpA?=
 =?us-ascii?Q?DDcymj+ZA1iz2kggZ6BWNNDcF6WMmqldtl0CJJuSGO2X9oFyzZP0To1VxEmq?=
 =?us-ascii?Q?IawHXtcLzqfZsI3d4TGGWtxLS0VlD0Ic5FbyN8FV3PAT+ESqSasJWlzrGwIM?=
 =?us-ascii?Q?AGqnnhhbw290FFN5L62XM1i5hs73ffFmvgcw1iU3e9viD4Z6ZctrkMY5kTrw?=
 =?us-ascii?Q?ztwmhOEaoTrnyu5xTh03QdyYCMGxATx3F7vZzdSKfao/3XOi/PIPDnsPspPt?=
 =?us-ascii?Q?tIcaMLGLiG+xOUGvdCSZ4gpXFy5oQdyCLAwkbzU85hqBF1USdV9y9x5HQ7Cw?=
 =?us-ascii?Q?LmA7YRCupBIGhlaM8wbtVLyMrwasUwnb2x2jOijZ+0fH8YBkO00r8X74+Lp0?=
 =?us-ascii?Q?Y4UL/Z6PIQcx6jEXnDLhOUIi+Dymf7FAzO/JH6/Hf5E6aSIQWdNwOlHhnjBh?=
 =?us-ascii?Q?CeP/Disqmy7Gqqq6BkraSYIe8uuDO/UKKMSP2tH/7TTQmnp7E+DavUIqMrpQ?=
 =?us-ascii?Q?vo7AoY5BfIFqSCklSItRBya2sw3ZaZhJODGtZLINXgIhBB8pUWfWbBe7NFRq?=
 =?us-ascii?Q?rpD4apxxT8IUrZ6kyAJ6FwJt5GOTtrrQpmBM5BOywb1cBzo6J1rwwvhlk+9j?=
 =?us-ascii?Q?lq7l6ThteMhdNDFPHEqW1CrXaFS4jkEOf7L/sJi5thiW3i3yNLnZaXOMPO5E?=
 =?us-ascii?Q?ZS1L+HQbT0KCx5DZ6g9O3qQP0CKXvp9WLdLYD5XR6LBEOfYnPLiy2BraQ9eo?=
 =?us-ascii?Q?B4krgont8RatPJkSsNKvXbXvMgz5jaQ7WBudg1vADWRimGDgz3k6krsR8yva?=
 =?us-ascii?Q?oYX5UCG6/rmRO2XjMNXdvFeJAuogVpwrMT6+f984KUT5iuXUFFxERwFlCRtA?=
 =?us-ascii?Q?ovEuqlx/Y2T4zjo+zykM76MbxjhxoewXTIeWJ1qZlDqAlKWpT2J1XarSjnoP?=
 =?us-ascii?Q?I8GWQu5nGeYb5auPGjFoKxONHsj0EZjaWJMb/BxQB6LUVfLQGLoQ0esfsKmq?=
 =?us-ascii?Q?MC+ETMvLSBZBsYM3q9PA4OYqHBFnGFgvPQe5c+KGA9FW7+TM9xIYMYe017Y8?=
 =?us-ascii?Q?t8BAssCjg2oBZoSteq0LnoEzE/seN7G44+jWfggj4FauFiThX+0B3Qh4JUP8?=
 =?us-ascii?Q?wC+mYfzPkAnsS1/rh0MYvfQmXQbzJ6LMQQpVfopzBHYfwNjWNRT8X2lNUAAw?=
 =?us-ascii?Q?Fd+KrpWqtM/Xdcy93m2PIV4U48vLKCwWHLn4pM1QgMFBsR2jbixdXenxGkfD?=
 =?us-ascii?Q?ZyPqj/W1b9iZ76V0ssVZt35xGi4L/EPDFhy4F8tscoNkjYUWTvUpbkIBwM0R?=
 =?us-ascii?Q?FymyegscXQ9XxSjTsPeCB26uWz60jRzGR87agg0WvdnQt1X7q9uFq7wWspqp?=
 =?us-ascii?Q?9rQaiM/zP1Au9t+IcNUM/ZXmZLRA8TNwCAaDsaxZg3Dsu/wbmgdIGioEboQi?=
 =?us-ascii?Q?7FXxvEhR6oFYe3B7KM/xWthpa6Qj2ezPeI6GctJEK5L9Wl/G/9O6mTdI+qCc?=
 =?us-ascii?Q?fjV9HRQ/YwscYAqQsJeqV1igi4eu/LRMB7zqBcRR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ef1483-baaf-4172-af05-08dac18ec029
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 13:40:07.9664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MiDSiqk1uukS2KBYQM5EeI0Z7TqRVUNJWPKLOso9/AUXgHUAvPhr9P15/lY4I0waQ3mOr2xl3u9Tlvr0vTRjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5475
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bean Huo <beanhuo@micron.com>
>=20
> Check UFS Advanced RPMB LU enablement during ufshcd_lu_init().
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/ufs/core/ufshcd.c | 4 ++++
>  include/ufs/ufs.h         | 3 +++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
> ee73d7036133..d49e7a0b82ca 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -4940,6 +4940,10 @@ static void ufshcd_lu_init(struct ufs_hba *hba,
> struct scsi_device *sdev)
>             desc_buf[UNIT_DESC_PARAM_LU_WR_PROTECT] =3D=3D
> UFS_LU_POWER_ON_WP)
>                 hba->dev_info.is_lu_power_on_wp =3D true;
>=20
> +       if (desc_buf[UNIT_DESC_PARAM_UNIT_INDEX] =3D=3D UFS_RPMB_UNIT &&
Please remind me why do we need both UFS_RPMB_UNIT and UFS_UPIU_RPMB_WLUN ?

> +           desc_buf[UNIT_DESC_PARAM_RPMB_REGION_EN] & 1 << 4)
(1 << 4) or BIT(4) ?

> +                       hba->dev_info.b_advanced_rpmb_en =3D true;
> +
>         kfree(desc_buf);
>  set_qdepth:
>         /*
> diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h index
> 1bba3fead2ce..2e617ab87750 100644
> --- a/include/ufs/ufs.h
> +++ b/include/ufs/ufs.h
> @@ -199,6 +199,7 @@ enum unit_desc_param {
>         UNIT_DESC_PARAM_PSA_SENSITIVE           =3D 0x7,
>         UNIT_DESC_PARAM_MEM_TYPE                =3D 0x8,
>         UNIT_DESC_PARAM_DATA_RELIABILITY        =3D 0x9,
> +       UNIT_DESC_PARAM_RPMB_REGION_EN          =3D 0x9,
This is awkward.  Better to define it, or -=20
Maybe it's time for rpmb to have its own unit descriptor - it surely deserv=
e it.
=20
Thanks,
Avri

>         UNIT_DESC_PARAM_LOGICAL_BLK_SIZE        =3D 0xA,
>         UNIT_DESC_PARAM_LOGICAL_BLK_COUNT       =3D 0xB,
>         UNIT_DESC_PARAM_ERASE_BLK_SIZE          =3D 0x13,
> @@ -601,6 +602,8 @@ struct ufs_dev_info {
>=20
>         bool    b_rpm_dev_flush_capable;
>         u8      b_presrv_uspc_en;
> +
> +       bool    b_advanced_rpmb_en;
>  };
>=20
>  /*
> --
> 2.25.1

