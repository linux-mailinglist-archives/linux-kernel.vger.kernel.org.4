Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D095FE993
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJNH3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJNH3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:29:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021201BF85D;
        Fri, 14 Oct 2022 00:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URNb8VCO5ScKA2h7I8O2SgF04rJyN3GfZ3o7o24Yy0fFQJ4r6BxYPUgWVBGzsx09EDZkvWdKcZIWrJQ2hHGpetLLgno+8gA0cP5oUq73Bk6ixVxXYZG06LfbpOJ6Q/slDBbXLk8h36ct/tqYYYR8ufWZzI0U02i8Ik5oD4jJLrVud/PIFd/0WunY1kZ6gvpDg/g/JifMXQIkLwvKNct3mjX+c7OkYm738INd3pY/lLVkGHCOnumIbS992O0DIDkPR9dpXyZyN5CclpyGRWR6+ZWdjxEnC9DO8FMjreMcMEI2GqcyIdeJyCLEaSAdySNDPipJlJ1uPjPMlbi+C8Ja7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5yoHfTmLrtwPQlcUDk/YIxIIslyvVUQl1aR9ZNKl7Q=;
 b=Wvw8wfu6s+bRQt602akixx+O+gwmgZc8XDFp8p0W09dX70deNWxvddqu00Fo1Pf0eXb07dYySsaTZuVNvrstZgtG7rGOMKFCnmAAWjZ9RbPa4TDXBnsEpS9274l1yTm5/cyORwde8OtAOBxqZhBTHSDWjIXh9DE5DEvwkBxl4PkX29bBMu6HPCPF7axrwBs8vIF9NUOI/yiTxvMfjPNs3s0vgDLQPb9iuwfYQDW244KjbWktBRS+JzDhDPQ9ypR8S/p7A4CRBAc2VhY0GI5Fr+myIUEiFlYKCHMi5SkUSh6kIMFjUgvrwrmIt8ObXp2X1LEP/uEhP6XjTrheqgX11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5yoHfTmLrtwPQlcUDk/YIxIIslyvVUQl1aR9ZNKl7Q=;
 b=Q/QY2JwYOU2xkSQ+BA6MiseYz64nPiEDXodvK1tINNzuK24QBjxLEiUo5w9EibDINDvByRnw63FSxOm++PG/0yyJSKHBi5AQ/2D2sCwwttF3v3UBl3i88gOSMHacXorb02GO+9jV4Upj5oxbWpoVf+RHGQYZK7GlFX6GcLFx2ylkqaALnEmDJffvx1I5tkJiiq3uZ+gcJhrlQ7LUTSiK9Of/m3Rv0mDCaPGptihLQilv9lFd8qv1lHUPOB50BVc8vau5teB7feYC/uYLwfYqQ862/IVAMguPUx3BGAOLg9XQMhVQJfj3lsYgjw71fbs1iE4w2OATKDgmNqDGK7yMmQ==
Received: from MW2PR12MB2412.namprd12.prod.outlook.com (2603:10b6:907:b::33)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 07:28:58 +0000
Received: from MW2PR12MB2412.namprd12.prod.outlook.com
 ([fe80::d56c:50d7:f0de:e3f6]) by MW2PR12MB2412.namprd12.prod.outlook.com
 ([fe80::d56c:50d7:f0de:e3f6%7]) with mapi id 15.20.5709.021; Fri, 14 Oct 2022
 07:28:58 +0000
From:   Prathamesh Shete <pshete@nvidia.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Aniruddha Tvs Rao <anrao@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: RE: [PATCH v8 3/3] mmc: sdhci-tegra: Issue CMD and DAT resets
 together
Thread-Topic: [PATCH v8 3/3] mmc: sdhci-tegra: Issue CMD and DAT resets
 together
Thread-Index: AQHY354oMJLO8R7MiUaTXWAsX6IV0q4NfYOQ
Date:   Fri, 14 Oct 2022 07:28:58 +0000
Message-ID: <MW2PR12MB2412E92633E4A6B670DFC93EB7249@MW2PR12MB2412.namprd12.prod.outlook.com>
References: <CAPDyKFq5hNTdwT7CMvsxG=_5u+xvG2k3-PfbGhAbHfHbGqK81w@mail.gmail.com>
 <20221014072456.28953-1-pshete@nvidia.com>
 <20221014072456.28953-3-pshete@nvidia.com>
In-Reply-To: <20221014072456.28953-3-pshete@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB2412:EE_|CY5PR12MB6406:EE_
x-ms-office365-filtering-correlation-id: 7d561b0d-ac3a-400c-e974-08daadb5c206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DSn1lnTgUHNdCetfCHLY5EJSw2bMX7jmRSfzieO57s9CkfHErgWCkx4IVLSpYx18ETqquXEaJWOG68bF2S2EyxSbIvnmciyUP+ARVtGLlAjuabxs8q0X6w+fZHFoJDsok0lre3buZ/SMgn2EKmK+sciT5iBY8viRQ3BTM7A8pcvsVREEi8FppNVTLRWIeR4YO/RHAUfd+Kwm1UVgww9XwrGLbsD5WEYlLsU2TDsTbokqlCzFWzGiD7qifDCdg01JTk0mG0BEhQB71hH0p7ojdPsbAmL6AvlJwNne3O5J85EUJp9agUWXbQ/h2NuJ39iyhCEgC+wbjGSFNFfIVr7O6/A191L2dAue0+MWNe+oAFhysKvEgiouW9LViTjE6I136yVM9Q4+Xhmv8uQoHW5B4e0QVLbzWRuQnOoDzb4vaCHeidXItlflyloWXhuJyPbFrBzOCBu9PHKYQ7QQPeYOyfdHv3BsKKS7/9A/ETPs2IqoojywfQpe3vOYYZYH9NDkp59qIf2BeLjmRuEtiNjOf0Y+3aJlBPAcnboP6LzhkF5NJIGxRR1SLHy4vxEST7SzPp9xfMrRkspeEpABDqzJmkR8foRNRgvpTHBGm5FU8dS971H2o+ePXA3uR+DqsSJ+xdW3ITLJ/aEqF36fNpJZFd8rd1rirBDVh57YLnokptx/GslaG8FGc06EJkAN2jSpqg3Oyvz1Zo+f6Y1uwjMUnO4GPMiaAyRQnzw3UC4dHnhtetrJuMYCsyGH9ljcyGCqg+s2HpTqBOAD+cJi4JTfIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2412.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199015)(316002)(83380400001)(71200400001)(66556008)(66446008)(66476007)(64756008)(8676002)(4326008)(107886003)(76116006)(66946007)(33656002)(186003)(8936002)(54906003)(5660300002)(55016003)(38100700002)(110136005)(478600001)(53546011)(2906002)(26005)(38070700005)(9686003)(41300700001)(7696005)(52536014)(6506007)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6A9zs2ebsYvyKY0SHVDkXtttivS41aF8thwbZ/8OpTfkRisx8ppohCONmq8Z?=
 =?us-ascii?Q?BqD66vTBz0Hr9834YIu83GXKnsDDhlN3sXFnX0Dxk1JkuaaVkRT25jIuocl0?=
 =?us-ascii?Q?KATiDtaTstVhkPL3DOkMmR3zvjLteFP9W/Z7PtrDxv13C+qRoDK8Jof8xsNI?=
 =?us-ascii?Q?GXk7EOLYFlybofQ5Bz2qmstS7nmhNMELTWyyqvQJrsgrFwGkQXiN+84j8LFS?=
 =?us-ascii?Q?oPUFekatgns7RNHnOXlrVxM5JXtcdpWR72mRSe8GaeWoX6A9gI0KF0mR1ACK?=
 =?us-ascii?Q?CowKsQ+qovSsDXu+JWr/xoFeWkUxwfhbb1TcEiKw1ekaGtxHTF6y0YWyhUv+?=
 =?us-ascii?Q?unYA6+rGaVJwwUsxIu7ZU5dm8jBobtL01XK+xAanuGJJJpV1+9sEpH0AwgCJ?=
 =?us-ascii?Q?KLfEIvWu7MBV2e/LfhjAeNgiR89XqnWre2M14CnQ5XSWQ4kPFJaJ782vGLzo?=
 =?us-ascii?Q?gpUHMBgwWuqskqML9EUY0EbvcHjp4rjHUFQtTvMeNJDYF1SzH63UE0haQoUA?=
 =?us-ascii?Q?bdfZmBWqPIjazku5s1UJoKRinRqTAWOWDBWPUGGfCFsM1HTEwX2rMJkSQvoA?=
 =?us-ascii?Q?y6iCzHlB0xFLXAG718JnVCdfVQGvKU8P57DRv2xt6wHBDoHwrpuXbQGPW9R3?=
 =?us-ascii?Q?0ONCPFeUtQqXVLoL7eafk9/j9/vdEnBjWuePcIfCa9yq4xvgv1r0+nch/bPQ?=
 =?us-ascii?Q?2iUese6P33y5Z9L8vmsEor/ZqDQ5n/h0I3qJRzd195SSa84G135JhvhnSYri?=
 =?us-ascii?Q?zSq4muNWCNaUqe8h0ww26jY3/TPcwMsC7VV1saF0ldVB+8i5yGoO37C49bOx?=
 =?us-ascii?Q?l5e8ev+FgTciji+WNCyJlO5NTQRLIxPkujjmymwbwMPNWBCsToW/UeK+GOvI?=
 =?us-ascii?Q?7PS6ri8qHlqoAPXhtzONjyVRT5wARS+zsNvkvxaDPlYFUiK8DM8wQWAQMpKM?=
 =?us-ascii?Q?gbaEELYNcMNn3vwlGl9kXEhvGuHfQgWZtY54NqJXOjUJojSbNvJIwXg3xaAB?=
 =?us-ascii?Q?Aj1q0DrfnYY6BkkDvaJgatkO/2AVOYGFy5EWRsr/zil7erC/ZxVqQo6dNQod?=
 =?us-ascii?Q?KxqI5mNJT6IdHlm/HpLbDOBu3W94kv0EkPfxmTzjx7zJhpHx4+U4DbrHir8J?=
 =?us-ascii?Q?lT3cgXO6IbKi7th0yb5mrCjQgF3TGYvc2Ve/OZQWEWXfhMajiEdZ/BwRAhi9?=
 =?us-ascii?Q?iD+lgEQ3FADMyvpvAPVMKW7/F56shEKhfv8K5dBjAJZ1mn259VdmoG46qVE4?=
 =?us-ascii?Q?/OmNhEFIfxlDfGmQ8Sdku1WxuhEDXmGJp3fYGVe2CBPSgyUxAwdOPKpr9j27?=
 =?us-ascii?Q?HHbgu5emrwGqpvhDIeIvbxJv1MzpTQS1OEkiSmmq5ixU4i53hRMM9hSgHfzD?=
 =?us-ascii?Q?rVQx8jH/4GwWbDFxNHAPfycjNUXS8KZw1MKSGl000Ckg81wwpo0kSRf6lwar?=
 =?us-ascii?Q?q8+AzPybdJe1r18V4HHn+MesAcLwhHiiof3753W+3xpXH1APaSW8iKNJ2Nil?=
 =?us-ascii?Q?jJoUdjXyla95LC1WmQh5nBOxVJA7ex15EsNGlK6g3jZ+TeE4I7S/hxfD6+d8?=
 =?us-ascii?Q?DoKPbgWyPUu74aJrCr8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d561b0d-ac3a-400c-e974-08daadb5c206
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 07:28:58.1952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6s5F8baOUZvPjpwjQTMnSfZXLEUgsoKl4wm016QC0u6yoxGAlv736HRRlBkR8Wng11dHOysTbJZ4miMQvYzXAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dropping 4th(following) patch in this series from previous versions as that=
 fix is applied.
[PATCH v7 4/4] mmc: sdhci-tegra: Use actual clock rate for SW tuning correc=
tion

> -----Original Message-----
> From: Prathamesh Shete <pshete@nvidia.com>
> Sent: Friday, October 14, 2022 12:55 PM
> To: adrian.hunter@intel.com; ulf.hansson@linaro.org;
> thierry.reding@gmail.com; Jonathan Hunter <jonathanh@nvidia.com>;
> p.zabel@pengutronix.de; linux-mmc@vger.kernel.org; linux-
> tegra@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Aniruddha Tvs Rao <anrao@nvidia.com>; Suresh Mangipudi
> <smangipudi@nvidia.com>; Prathamesh Shete <pshete@nvidia.com>;
> Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Subject: [PATCH v8 3/3] mmc: sdhci-tegra: Issue CMD and DAT resets
> together
>=20
> In case of error condition to avoid system crash Tegra SDMMC controller
> requires CMD and DAT resets issued together. SDHCI controller FSM goes
> into bad state due to rapid SD card hot-plug event.
> Issuing reset on the CMD FSM before DATA FSM results in kernel panic,
> hence add support to issue CMD and DAT resets together.
> This is applicable to Tegra186 and later chips.
>=20
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 3 ++-
>  drivers/mmc/host/sdhci.c       | 5 +++++
>  drivers/mmc/host/sdhci.h       | 2 ++
>  3 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 0cd7c3f7e6f4..9fbea5bbfa4a 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1535,7 +1535,8 @@ static const struct sdhci_pltfm_data
> sdhci_tegra186_pdata =3D {
>  		  SDHCI_QUIRK_NO_HISPD_BIT |
>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 =3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	.quirks2 =3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
>  	.ops  =3D &tegra186_sdhci_ops,
>  };
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> 2b5dda521b0e..8512a69f1aae 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -270,6 +270,11 @@ enum sdhci_reset_reason {
>=20
>  static void sdhci_reset_for_reason(struct sdhci_host *host, enum
> sdhci_reset_reason reason)  {
> +	if (host->quirks2 &
> +		SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER) {
> +		sdhci_do_reset(host, SDHCI_RESET_CMD |
> SDHCI_RESET_DATA);
> +		return;
> +	}
>  	switch (reason) {
>  	case SDHCI_RESET_FOR_INIT:
>  		sdhci_do_reset(host, SDHCI_RESET_CMD |
> SDHCI_RESET_DATA); diff --git a/drivers/mmc/host/sdhci.h
> b/drivers/mmc/host/sdhci.h index d750c464bd1e..6a5766774b05 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -478,6 +478,8 @@ struct sdhci_host {
>   * block count.
>   */
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
> +/* Issue CMD and DATA reset together */
> +#define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER	(1<<19)
>=20
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> --
> 2.17.1

