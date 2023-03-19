Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834D76C02E0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjCSPnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCSPng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:43:36 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A1776B3;
        Sun, 19 Mar 2023 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679240614; x=1710776614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t9osJ8v18d/jDzwB2blqScayTQA3Gt05h1vVELhtGLw=;
  b=QAVZlvP2DcKdFY+9WQMBPxlw5Gs6/dLksgJCMeyobvcNO3FwEfkBjB0m
   q49/UOy1Fsq116vZ5ADf8Lz4BqYnrlQP4Ovcn0/BKFbMaiqTkE1yBC6Y+
   ewXsAscQRTKs+snpNY1Il2/xbyICYEOt/URkkPDVusx/iCXGrpt4CNxR4
   QDNaiN7FbiK7XSNTcoEE+vBlormrTNjUFqmAJjINZF5ij4fApnff3lih1
   W+5OGnxgT+5ZDZlJBVUAgUz7VM322ZHE0hdUOefnlJRUhnceN/D3Ml5j9
   XBA5xRaBUz2h5evvYqbzVFjFTroCTF+acvukbWKcCjYOkrnyS81Y/u5Y8
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,273,1673884800"; 
   d="scan'208";a="225776791"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2023 23:43:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQZyVUerarn9jiy+73huZW5QL4CBg5IP037U+6AYVE/f2NsWwGTAtXry0YWeE+wTAO+8VWuUy2nllYHoSx4+sLr+3NfG3ZEYh9LIgVBx2vQsLzu7dix60dj2xrFgl2NV2oty/Llh0XE/BJIMrmkq/Gq22x3uOcnijG1jI74qf3sr0iULtJbRhdSK6i0WzfYdnEg2Uaohx0oofoBEvWG1JWlMFHKUp0e11HuC609z7SiFL13D6MoWmaxcyv69igIDhWUZZvZGUAv+jZUWtEfD5kLk0kGqUMwSrFBus6iEffHHCQbFjCuAm07kKMTWwCV69Np8mWGpQH+SQtGYbopBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meoH1lC2rU7Uo2/8eW8HosqP9I5RKFQUbG1VzfVKEvg=;
 b=TnedTUuEZNKsdHJdC3oUinGJmJuA5Irhjcklw5llnE/Pk325MwYQgJLqDIr089RDWau79vize9ZA37WNVRustls6nE+m0rlLD+y7xIus8MAh7wVEt+Zh11O4oCEPGr2AnJHHO9Bf0wLYXnKV1IbbMn8K2kpMHoDEPmuk9B6FfLZ8Uf8FA1FVzwNKKXvoZKgKFgEMkcLbxgrIfT1dZyOXrPodxHjCl9p3HDm3scEAY4jyauJ+JY6PY0b7VhBYYfhZnoU1upPD6HXT7V9gsPAPAsIStn26/Hi2S4ZysYbPsQdBIu+UF3M4ciz+Dh22jLUY46KVbaRXMfvjyaYYdg7cNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meoH1lC2rU7Uo2/8eW8HosqP9I5RKFQUbG1VzfVKEvg=;
 b=okICq4Vjf5DYLTJ0P1fizjTtFTqok92owzKsHrNlm5YDY56Q+PyJKKSfXrGBkP1m2PSE+7lvmr0S6hyqYrfMjIxr45u7VfgWquuNjLpLenYM7jDe6irkJspmgXN+x4d3WKk5nCbOG+5AfBdY7R866GCXV2+kYylWD5dKsWdFpno=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by SJ0PR04MB7181.namprd04.prod.outlook.com (2603:10b6:a03:2a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 15:43:24 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::d4d7:5772:65c9:e4d1]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::d4d7:5772:65c9:e4d1%2]) with mapi id 15.20.6178.035; Sun, 19 Mar 2023
 15:43:24 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] ufs: core: Add support for qTimestamp attribute
Thread-Topic: [PATCH v1] ufs: core: Add support for qTimestamp attribute
Thread-Index: AQHZUQ7JPGFIrKgc20Sqn2czlPTLfK8CUOKg
Date:   Sun, 19 Mar 2023 15:43:23 +0000
Message-ID: <BY5PR04MB6327B93C10FD442903BD3343ED839@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1678205182-13943-1-git-send-email-Arthur.Simchaev@wdc.com>
In-Reply-To: <1678205182-13943-1-git-send-email-Arthur.Simchaev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|SJ0PR04MB7181:EE_
x-ms-office365-filtering-correlation-id: 6b96274f-865b-4080-52fb-08db2890acb8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d1oNviyJHEA2qeVHLmBaDcchiEBAm+rsU+hcYRrVdHCw20ZbFZn+zqyeRGOX7zU3rUD8lMPT86tYRLfbXpPD/53L4CfJY3zTUKGfwwyCzfiMRWgReh8x+M6V6cFNHcS2JhtMnXbkQbDTeGxLwQyi65394XfyfQcaiHGoaTnm3EM0sf9f1Bqn/QJFvhk1/5EtsJ1kMh4jTdJKkYHRyAztZLx/qE9LxMCjy7ziY1Yb9N9KvCHPrWYKXkz4sYD7LTeC3z0ZrD6Sy7F3HsJeRcoQY+eRqCzwdlUzcRVKCyt3TVk1lwP21SU9e+ujgtOuxLTashjD1WmtYJPYg2ekbi4Du7o7YV/loKso12HWEpkSVP7EtvlRIcJ57etDb8MSikbel/aoyGhhisDUpkUujjGCqYqNUiRO/MnvYMibyYlfixTWvRQ0cv2ay5RcBxOmjt7VDFVqYV8U7kR/zYtVVx/cZ4kLjAW5kMmNBwLMNeo5K3ta5MIfTwUhWnENQ7OHIXeRrSK3zd0vyq/HsQrbtWGkvSNjBQIYoAYTLUYlVAYrIy1d3Ij6EygIp/kc9CiLzd682nOteRKfFTcEM3F28bKuM+tWWdtl0L1s97DtydgszzU125pAWQ4JzaELexTC0K/HVokrEZceLnpGhOaiWYJxYVHMtd12Pfq6L7I6QQKKTER07cq7LGFx78tC1JrdFD9aOXayOBrpJ8qPUWrF5cfgPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199018)(83380400001)(38100700002)(86362001)(38070700005)(122000001)(55016003)(82960400001)(66446008)(4326008)(8676002)(41300700001)(64756008)(66476007)(66946007)(76116006)(52536014)(2906002)(8936002)(66556008)(5660300002)(33656002)(26005)(9686003)(53546011)(186003)(316002)(478600001)(110136005)(54906003)(6506007)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qh+18m3inA5av5f9YuylFF7dXtM35pE+9siSQS7x5LC9BDOLDK5A9CQAxBWP?=
 =?us-ascii?Q?LUMajROROckEWmWPcB3nCmsA0ab3tdf2Z0uQHSP9egqVieEj+A7jbaE/t2MV?=
 =?us-ascii?Q?o/vK7RtFoX0X5RzyAq/lmJQvp94WCVUjcrY6xsSi6aVxtY9yucAHbst5SDYX?=
 =?us-ascii?Q?OIBGhcnps8CM7Z4RQcrymjXAy+mTMRFiT6+40NHwpB9e4A9GRGUD8KC9xteZ?=
 =?us-ascii?Q?2I8dKYbHht549PyA0nNHNMmd4+R0sEWOX5T5hAWIuMt3p5OhTcLailK1RKT6?=
 =?us-ascii?Q?HL8dcLXMaVP1+rldTr3uIN6IYyESA+XiOfvoJB1XtC7s4H3hy5mkOp1S2GrL?=
 =?us-ascii?Q?Hk8gnrzJSm+7dRnk3bL0qHHzIM2PmrwppzqIDMU0HAJgWiyrYcTRsks0KA/o?=
 =?us-ascii?Q?0YHmaWUMdTwogP1ANSRAFvjBOQoHEpnMqlDKaSY5lPpilvybS4L2XWch4OD4?=
 =?us-ascii?Q?sxPF/AeduzjFs/c471GIn5kykzlerkpztbPES/u6ZSOFh/4WPzv2YyW4hZs/?=
 =?us-ascii?Q?Ph/UM1UC0h8J9VIKd+c+AuCymz41E5be0f7gDccEXYIFACRxL5zz9exZnm9E?=
 =?us-ascii?Q?+jIeshUJwz8a3e7sqSVp7NeiJrheuppB+oiePNE3+JDNI2brRFiY30+bhgbt?=
 =?us-ascii?Q?XL0MOm9pYdUlpUonvPR9JTmcPy7aXIU1l88NqJ909cIAhoYFtlwmSOpiDjXT?=
 =?us-ascii?Q?dE2LtUhkAz5RayoRlfp9CdEA0IWHDHA2P1rb2Iyg3hazC6X2f2wl3vIPfkz6?=
 =?us-ascii?Q?Z/qXox+YJa3uKL6OevXn/gkvQ76J2YegifCs96nF8CYBwjFWHu88Nw04pabx?=
 =?us-ascii?Q?JzOwFj+nuitIp05gZ+DK5i7LXkr8n4Eoza9vmNS1aQ0rh4aW/0pVsnAT/bqC?=
 =?us-ascii?Q?cDUpV41rC2ZE6MkI6XSy3kSc58ntpM5urcrwGBSoxsu1ko+p2gtPRawuxIgG?=
 =?us-ascii?Q?ha+AHN7GSrlUo5/58X+l6FYxqvQaP8D76W85Ypym3qo2ksSqFBZkMXZhxG6/?=
 =?us-ascii?Q?+YZRsVHoVhFKCxzao5JJhUY5a0sD4A6NOFtlQUVDa/jjh2CEyuAYC3EldX/Z?=
 =?us-ascii?Q?9F0D2V8m3tVlQz9n9COMW8BD5ExfUJ5PU+4Ebw9+96CVuBizmu/R7k2oTjiD?=
 =?us-ascii?Q?DhferAytrkK/NGoEDTpO74I9vJqNejZovSB3+hRsqfnYY4hk6oXBTDxzvnsY?=
 =?us-ascii?Q?8hfVNHC2+AaBLEt/DRfrrdDSnJ0nPDVmFdOcXfm/ZJ5JdH7OrJ+otFbqE8KF?=
 =?us-ascii?Q?k85sL3wgNXpJgT5kFSpaHGW9Pk5w7JlbZY4Fst0SdiWj5YoOgEwdFnxn5OJZ?=
 =?us-ascii?Q?cDrrL64LDiSyapHfUkb/DMfeFnBpgOrtE528sjNnNZ02hzkNf3liRfVu+HYp?=
 =?us-ascii?Q?fASQR2XsIEW4qdTbeagi+rDh4+ujTJOmvugtsyAFZCuKUt18ErSwIEgpHueF?=
 =?us-ascii?Q?lrAQdh9HiZjj+X66dhZSN1OroVga5EckRuWqgstLxx375p6gd7i5mRBBVZIf?=
 =?us-ascii?Q?H3ihYIIG1xYhrgH4TWm1cq48+wPEOuf4gkdHAh+Sn/60zcVsCBTkYiFgWOUJ?=
 =?us-ascii?Q?qEul4aezYgJUm0kul4fDQssqIBVfOj/ibyRLKupF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HeqSijiZcS006H8DjU20l2Zg2IVe2XRhxWuZXnp7+0T1+67gGd3jhvVjGJXiZ/rwypThnXBc87Mw3/5RJjAjoJd7wCBA4P0TFMvgU3SzBw5a/+9hfQG3hMTxeyYd4OCG783OQOkWFSi1DSA/GK7fQITcNV3xtzGbljpPYYohAcKiwCcJ0luBvel09/zDez+vCa3xve5aMUQSuPEOKDZXW3aZiHce64x7rkdd9g8eDJEimsCsnnUP4E6Fr21vg4PVZ+X2haUcAkpD6oLTxd8mSH4lax9ZlhlXRr5Hc+lNxViF9E2Q9Z/iWkwBz6byrK2kF89WK3jnFx7YC9wMqDXomkqLg8ImeH8x9/yrE6UC8RzMI5lcRU4jOP44mLdJAUOeZ3ozG5t0dfTIJycvYoHrv7UhR+AYvEk4S7jx1+qxnAG/Yw0VEgQhsQrQSjyBQbIRqdhcyw+JxjtX2Jzp1RFhE1hCpKyVyirQFjPpLr4MGY6ra9p4bu36Yhsp4JthaLS/oJRJqhrC2Sj9+caeIDvd/blg7fGdWZvq7fO8GoaUQC1A+bAIGV2lZ8q/xKp5yyw7slIYx8obneUa7DgQPmhbw4sgtu9D/dQBYl6PFTtS5lEByLMT/hVKDVz1A5SUSk5Pta45oqjLwZQxl/ScE/OLrsJIvzst/g1/YNCAY/VETyocftXJiufQSRUrXuacSeUkOjAw6KzufM5nBplPtmBguefMqbIj+fg8kqwI4A2pgvAvLqkeJ7vfR14U4YIqRby53G0eo3KCBjIZXCsfzUTFYd6GiAbMMVIor7ztxROoQUsoeMdtMobZPLNnzLvzcxcO0JxltzBwEbwGEP1+726Fdy6A5gMXJmC8wc2Xc50p3Ts=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b96274f-865b-4080-52fb-08db2890acb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2023 15:43:24.0594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hiyQ8YFHwF6Ml745NolDkiaX5mtpDRtWcLHbwfeElgkQMykaFEwxRafFH8Z+1zC5ByqY9xzYlonb9o+sArKtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7181
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle reminder

Regards
Arthur

> -----Original Message-----
> From: Arthur Simchaev <Arthur.Simchaev@wdc.com>
> Sent: Tuesday, March 7, 2023 6:06 PM
> To: martin.petersen@oracle.com; bvanassche@acm.org
> Cc: beanhuo@micron.com; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Arthur Simchaev <Arthur.Simchaev@wdc.com>
> Subject: [PATCH v1] ufs: core: Add support for qTimestamp attribute
>=20
> The new qTimestamp attribute was added to UFS 4.0 spec, in order to
> synchronize timestamp between device logs and the host.The spec
> recommend
> to send this attribute upon device power-on Reset/HW reset or when
> switching to Active state (using SSU command). Due to this attribute,
> the attribute's max value was extended to 8 bytes. As a result,
> the new definition of struct utp_upiu_query_v4_0 was added.
>=20
> Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
>=20
> --
> Changes to v1:
> - Add missed response variable to ufshcd_set_timestamp_attr
> ---
>  drivers/ufs/core/ufshcd.c        | 38
> ++++++++++++++++++++++++++++++++++++++
>  include/uapi/scsi/scsi_bsg_ufs.h | 25 +++++++++++++++++++++++++
>  include/ufs/ufs.h                |  1 +
>  3 files changed, 64 insertions(+)
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 172d25f..cba9ef1 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8386,6 +8386,41 @@ static int ufshcd_device_params_init(struct
> ufs_hba *hba)
>  	return ret;
>  }
>=20
> +static void ufshcd_set_timestamp_attr(struct ufs_hba *hba)
> +{
> +	int err;
> +	struct ufs_query_req *request =3D NULL;
> +	struct ufs_query_res *response =3D NULL;
> +	struct ufs_dev_info *dev_info =3D &hba->dev_info;
> +	struct utp_upiu_query_v4_0 *upiu_data;
> +
> +	if (dev_info->wspecversion < 0x400)
> +		return;
> +
> +	ufshcd_hold(hba, false);
> +
> +	mutex_lock(&hba->dev_cmd.lock);
> +
> +	ufshcd_init_query(hba, &request, &response,
> +			  UPIU_QUERY_OPCODE_WRITE_ATTR,
> +			  QUERY_ATTR_IDN_TIMESTAMP, 0, 0);
> +
> +	request->query_func =3D
> UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST;
> +
> +	upiu_data =3D (struct utp_upiu_query_v4_0 *)&request->upiu_req;
> +
> +	put_unaligned_be64(ktime_get_real_ns(), &upiu_data->osf3);
> +
> +	err =3D ufshcd_exec_dev_cmd(hba, DEV_CMD_TYPE_QUERY,
> QUERY_REQ_TIMEOUT);
> +
> +	if (err)
> +		dev_err(hba->dev, "%s: failed to set timestamp %d\n",
> +			__func__, err);
> +
> +	mutex_unlock(&hba->dev_cmd.lock);
> +	ufshcd_release(hba);
> +}
> +
>  /**
>   * ufshcd_add_lus - probe and add UFS logical units
>   * @hba: per-adapter instance
> @@ -8555,6 +8590,8 @@ static int ufshcd_device_init(struct ufs_hba *hba,
> bool init_dev_params)
>  	ufshcd_set_ufs_dev_active(hba);
>  	ufshcd_force_reset_auto_bkops(hba);
>=20
> +	ufshcd_set_timestamp_attr(hba);
> +
>  	/* Gear up to HS gear if supported */
>  	if (hba->max_pwr_info.is_valid) {
>  		/*
> @@ -9592,6 +9629,7 @@ static int __ufshcd_wl_resume(struct ufs_hba
> *hba, enum ufs_pm_op pm_op)
>  		ret =3D ufshcd_set_dev_pwr_mode(hba,
> UFS_ACTIVE_PWR_MODE);
>  		if (ret)
>  			goto set_old_link_state;
> +		ufshcd_set_timestamp_attr(hba);
>  	}
>=20
>  	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
> diff --git a/include/uapi/scsi/scsi_bsg_ufs.h
> b/include/uapi/scsi/scsi_bsg_ufs.h
> index 2801b65..fd3f9e5e 100644
> --- a/include/uapi/scsi/scsi_bsg_ufs.h
> +++ b/include/uapi/scsi/scsi_bsg_ufs.h
> @@ -71,6 +71,31 @@ struct utp_upiu_query {
>  };
>=20
>  /**
> + * struct utp_upiu_query_v4_0 - upiu request buffer structure for
> + * query request >=3D UFS 4.0 spec.
> + * @opcode: command to perform B-0
> + * @idn: a value that indicates the particular type of data B-1
> + * @index: Index to further identify data B-2
> + * @selector: Index to further identify data B-3
> + * @osf4: spec field B-5
> + * @osf5: spec field B 6,7
> + * @osf6: spec field DW 8,9
> + * @osf7: spec field DW 10,11
> + */
> +struct utp_upiu_query_v4_0 {
> +	__u8 opcode;
> +	__u8 idn;
> +	__u8 index;
> +	__u8 selector;
> +	__u8 osf3;
> +	__u8 osf4;
> +	__be16 osf5;
> +	__be32 osf6;
> +	__be32 osf7;
> +	__be32 reserved;
> +};
> +
> +/**
>   * struct utp_upiu_cmd - Command UPIU structure
>   * @data_transfer_len: Data Transfer Length DW-3
>   * @cdb: Command Descriptor Block CDB DW-4 to DW-7
> diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
> index 4e8d624..198cb39 100644
> --- a/include/ufs/ufs.h
> +++ b/include/ufs/ufs.h
> @@ -170,6 +170,7 @@ enum attr_idn {
>  	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    =3D 0x1E,
>  	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        =3D 0x1F,
>  	QUERY_ATTR_IDN_EXT_IID_EN		=3D 0x2A,
> +	QUERY_ATTR_IDN_TIMESTAMP		=3D 0x30
>  };
>=20
>  /* Descriptor idn for Query requests */
> --
> 2.7.4

