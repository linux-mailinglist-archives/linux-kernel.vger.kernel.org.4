Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB38612A99
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 13:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJ3M2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 08:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3M2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 08:28:40 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66A5BF4;
        Sun, 30 Oct 2022 05:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667132918; x=1698668918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T5i3Udqg1Av9/pwSJ2ESMK5ah+akhZmMy+tpQrDNgzA=;
  b=LSL13QmT/s8I0Aep1PW64mb/J/iXrCc2vb/v94zLVk6zyhkMcAUo4tPx
   lrJpTBfhu0+xMwJeIUB06KGFSYKs6C+cm0mlh2Xm5HBP/Mhtsjo1NqmHt
   bd/3l+L8njGktAzhzb9j9grZ1Yf/G3Uts4F0w7lE7ckYpNHz+vX51X/YW
   GApxYdW+XX6PpxXWR94cwKMES/gazPTcYfdFi4dqGWnJoyi1y3ERazLBh
   JRRQai5xMcgmufyoQNS3dL5nrShHKht/bgwZNnPMtr6QAt3R6burk3iCZ
   06jPe+mYkZn/1qccD6vTiaYJeuh1CFXo4ZS8FX9JasbQuN7qjiGCErS6K
   A==;
X-IronPort-AV: E=Sophos;i="5.95,226,1661788800"; 
   d="scan'208";a="213362066"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2022 20:28:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y91MRQ6Txcn9CezWoTCfvTFvZAEIIdiHdAX2D9cKBOSpLCftlBVuF9enMDmSctC8qjmsjPnGlxdjbZ0nffUxtHA8AeHhR/CNkviHC3AoJd308n3Oetoe/1vMuSdD3Z6v2wSHGMswcEd1yhnDWJh1pQ3bdp1sHJ9T922fwQQ0gtmqxOIdVztMpWZImYQmnGqmu7NWJLpzAkpSqlD7qiDXAIzdQE+1mTFD0Xes4RzhvQwMaIEsgs+uzGANEaqOkI5DCC5XuL7n36fBG1Snicy+mPnYf3t05G2ID2IBNKXz3cEm/UVrRT00iZjXY52gTthzRP8avXKPMXpLyne14AVCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85yWRnof67qTQPs61sqzE0llR8SNYFIntqks1mSUuSc=;
 b=HCtxiEK5dIdhbLmWLF7MC1Ge2aTzrEK0l2J1i1fktvpgZloCLMX9rOO6FA7X3RMNpXMpmgEjkUIwK8ZPFuqgCNrdOLmLPwEywztZ/L34Uxxrs0BGJLIdFcnTNzKGwn64N8KsiOo7aZf6L09Hyns/nXUGioN1afeECff3lSvMTg24qcLq+gWjgsBwoW9LPziFuJia6OUbVmkXRC1lk5YgPepCDlTtllICSrHg+hbNVXQbSZNZkOD9LgqpVWDtFIXSiAKEdJSxfZ3O172l29X2KUWTLXAQ/TijsqfxaSSi/E50gBH2kFn6rqCA3IHVPK4i4ARMDLMEhsw4LwkOho60Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85yWRnof67qTQPs61sqzE0llR8SNYFIntqks1mSUuSc=;
 b=COqtj5suH3fXMKrJjQQXb2e7X9SbDsnRvcCHZDDbSGPia7u1+VRte76TQSeS97Tduw6jW4nHkXcYC+kZsYPve9NM7orkphFl3uZblIeFLUBUTYiA2xBz/9BQm5yPD22jSA94UhPCT4ljI/4a2OpWDgwrlbXyT5Fz+4sk6Jvg3nc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CY4PR04MB0582.namprd04.prod.outlook.com (2603:10b6:903:b5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.18; Sun, 30 Oct 2022 12:28:34 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::28ea:75a7:9653:f151]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::28ea:75a7:9653:f151%4]) with mapi id 15.20.5769.019; Sun, 30 Oct 2022
 12:28:33 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Asutosh Das <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "eddie.huang@mediatek.com" <eddie.huang@mediatek.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 08/17] ufs: core: mcq: Allocate memory for mcq mode
Thread-Topic: [PATCH v3 08/17] ufs: core: mcq: Allocate memory for mcq mode
Thread-Index: AQHY5K6tQwOIDcsWF0qi0pjSyOfuDK4m7BAA
Date:   Sun, 30 Oct 2022 12:28:33 +0000
Message-ID: <DM6PR04MB6575D3CFDC51760EFF511F09FC349@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <054ec088877bd4b421f2e9cb2b0fd8c4e058af11.1666288432.git.quic_asutoshd@quicinc.com>
In-Reply-To: <054ec088877bd4b421f2e9cb2b0fd8c4e058af11.1666288432.git.quic_asutoshd@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CY4PR04MB0582:EE_
x-ms-office365-filtering-correlation-id: 2efdcce4-a383-474f-5303-08daba7242f8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lAElz4q77vGNSh4MO5e9qbyvGof1Gs7huCVQrVgTOgYTx6Cf8vCF3Q0PLRCJegEmwCyQuZDjhzN9Vo9XYqsa5Pbx0LCmKHUMOc3QOhT6cOxgPPVrqRQUf4IVgCMa/2+0pvJpE9+7R3VOWWwA13tfel7SbhLNwedaUkSX28V7dFGAtG+1gb1fYACMtVcKfDSsvcOJX6+aEXwQ02xZedIgPXae3GOP5o1j/APy4Dgk9xaDNbB9OT/ML6Zf387yae14cPeJKJKftqz4KixSfTuwEn0I1OxdkpMG7Mnd0E9yS5+0O2Xb/xbsmcZcT3jPRGQ214u72U4QEcdKHC4IfxmHjY8AI9qrKcBpLfPdyiGxMD13y2jLu6ORTwJuwKMn2lEyjEgTyrX5EmBbyhunzcSiCho2f7BTzK7suamCAYg5bnS3MtUbOe3CrTnd9EyRXw4Z7rb8tt2X/Z0o3DPqZF+F6y7kqLe3ca2lB5tOq/9wCVSSr0U/KtcySXdv5dLyw3dTRSBOztHXakCG++Jt1xhlPBCNu9H/H7pfnBhlJh5LBl0EU5ZupmfLZ1Dei9F4Ywo5/r/LPfls6zpDwFEaB+YeBc5OKJpV6NMMTWiyiKNCFj8YgLDHR+Mv3bA0bcZUHGtaRH/QAu/GjafWx1YayOO7rSkDrUwk61Ev2DfdlonuMLraw92tAZmsnGZ1lqncPqe1od7NzXwlD6yhV7WZlWBcTFlPmCcmOxdnpd3q+7jjYS/7kpyTUtg1oRL9TnltmeASrPllFmx7u3hKpEbet0sZiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199015)(8936002)(5660300002)(7416002)(52536014)(33656002)(55016003)(6506007)(7696005)(478600001)(9686003)(26005)(86362001)(83380400001)(71200400001)(2906002)(186003)(38100700002)(4326008)(8676002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(38070700005)(82960400001)(54906003)(122000001)(316002)(41300700001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T9leLojWwmszmEgiapA84dLdfEOb9aqdc0+URCRtL4q7KlhiDwdTproWt2b4?=
 =?us-ascii?Q?7I3/aTETIoZcLh6OqO/lMJXw62J9QdCdngfbBLk+0nqV++qm3KW1fuHF2iGa?=
 =?us-ascii?Q?4LAoJi1l9A+lmjnTI6pBtTEd2lYeYroYSvjA+RyuYUJMMB4QgUOpnHIQM4zz?=
 =?us-ascii?Q?QvZdQ3fOKY/8Bip4H5+8+ffLqfpe4ClVdeIod+JKLFLyeycwlIPEIzSwnR54?=
 =?us-ascii?Q?biibT0JQpUf+lZnGKbmYx+qapk7gA48Ceo8iuqVHSBLPS6wfeUp58xnSsg5C?=
 =?us-ascii?Q?g8XsUy/rYKx7hdsQCyKDgr/GKisDyUNBP1TIrlDYDqxRWdd32cTO94VHA99P?=
 =?us-ascii?Q?iDQE5s0FggSiNzu6lfbyf96adqAmaSYx2NBxqXSBW6GwLcyOzcz9BMMgzN3k?=
 =?us-ascii?Q?eU0tPLGhjQ1nuzY68BAdEzxlbpifftGBRZ7+j1qhsxfAhVFwTCy+CKiXMcC9?=
 =?us-ascii?Q?WHAkGdM3ZlZXmlLA5MbBH9Jw/e62GLnjqyuX1ln3tvI5agmMeQIuTXd+mHNc?=
 =?us-ascii?Q?nheeNY3c0Lu9MqUJ89kXboYlYIpNyhsFW7Bkd1p0qxivxL1nlxyuIQpOByp2?=
 =?us-ascii?Q?CcXedr5E2yhVVoO0t8oK503x2rC2t42YD8k9fET4xWzyqHjkK+GSiRpC+10C?=
 =?us-ascii?Q?O9JJdhbAtVCmLw4yC6L3e/iKJhFzLl318f/+j1GRVdpv3KVuTNJ13OCw4Cdz?=
 =?us-ascii?Q?7/xFY64sIahROTB1MCW40nQfhBgRVVo0ijPcTzlxRCgYPjXn21DHgeh/qFmR?=
 =?us-ascii?Q?+gr+UNGzkEy/UvqeydNf5hyo9tvwOr5EZeo8hai6pDHZMziHOgn5EZZgC/kg?=
 =?us-ascii?Q?valEmBsumRA8xMmns0AnQ9zKjHEyrNxwrDzrQsdSBXTklflsJUqr0ubfn0GX?=
 =?us-ascii?Q?OucHc0OfnaYP9L+AnKKjRflTZkeRDPKxJmC8Y6CBjyKW4iYUhoxHQQwZyijF?=
 =?us-ascii?Q?tK6VACiWtGxnWiF+2ZT4lWRPVXWJqUsq1TW/S0qfvCN3atBqVSQNn/FyHEG+?=
 =?us-ascii?Q?aFfpnU9f1G5XDN8yTIRiU1AWGTF+oLKK/1FiRc1narAAf2/CxD08wSnERL8A?=
 =?us-ascii?Q?5a0mcr8S+2fsoHeWtKSjzwD3Sn6YH7VsNRbQfdh2NEnwwAMRGqzyeZ1j/jjM?=
 =?us-ascii?Q?VZ1aQJMo+jGUZN3REJXMBUdfcyjUrDFy/2CIVgTWYRkZQ1vktR4lMgW8iYj0?=
 =?us-ascii?Q?QtrucGPFYTL5RjpjbzWVtBx90y3HSJkBjsMLIfYOum8ZQun7v9l8J8m8IFlu?=
 =?us-ascii?Q?rujJ9sA1UivnCZu4scX3+8eJfHd/fXMFu7UgL6aM+VWZdZnOkGysYyis0+le?=
 =?us-ascii?Q?NPevx9Q4WBFFydSm8Ox2a6ulzzPL+YdguYMuMfcD6fvO/i5GAWMZyUziVkwt?=
 =?us-ascii?Q?KdmmkrXYRITEWgWABvv0nIQeQbVzGH5domdv7OJBxR0ygpmL3IjM+PnlSjgW?=
 =?us-ascii?Q?XtTM1pgMLfpcGLYI/APWO1uhKWC5fCGm6NB4c1t9rHNNWKT0gS8Z6vSDSdoy?=
 =?us-ascii?Q?JVODWHkJnq2RxThyIseZkKVTZVLurpDn+ABkGibANM5viIQNSHv65RT6gItE?=
 =?us-ascii?Q?gex2Z9cc12CMMes4ovDF03H0ULwKk3QnUi/FysJU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efdcce4-a383-474f-5303-08daba7242f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2022 12:28:33.8486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CF/K2DXUQ/AICdDADkQeRubMl5axhZTw0YD66jtwmwUUFolKix6HLVpUfNRubyNdIZNi5OfSuutqZBUSQZAwNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0582
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  #define SD_ASCII_STD true
>  #define SD_RAW false
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index b928ed8..e32396e 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -3686,6 +3686,12 @@ static int ufshcd_memory_alloc(struct ufs_hba
> *hba)
>         }
>=20
>         /*
> +        * Not freed if MCQ is configured see ufshcd_release_sdb_queue() =
and
> +        * ufshcd_config_mcq()
> +        */
> +       if (hba->utmrdl_base_addr)
> +               goto skip_utmrdl;
> +       /*
>          * Allocate memory for UTP Task Management descriptors
>          * UFSHCI requires 1024 byte alignment of UTMRD
>          */
> @@ -3701,6 +3707,7 @@ static int ufshcd_memory_alloc(struct ufs_hba
> *hba)
>                 goto out;
>         }
>=20
> +skip_utmrdl:
>         /* Allocate memory for local reference block */
>         hba->lrb =3D devm_kcalloc(hba->dev,
>                                 hba->nutrs, sizeof(struct ufshcd_lrb),
> @@ -8176,6 +8183,22 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
>         return ret;
>  }
>=20
> +/* SDB - Single Doorbell */
> +static void ufshcd_release_sdb_queue(struct ufs_hba *hba, int nutrs)
> +{
> +       size_t ucdl_size, utrdl_size;
> +
> +       ucdl_size =3D sizeof(struct utp_transfer_cmd_desc) * nutrs;
> +       dmam_free_coherent(hba->dev, ucdl_size, hba->ucdl_base_addr,
> +                          hba->ucdl_dma_addr);
> +
> +       utrdl_size =3D sizeof(struct utp_transfer_req_desc) * nutrs;
> +       dmam_free_coherent(hba->dev, utrdl_size, hba->utrdl_base_addr,
> +                          hba->utrdl_dma_addr);
> +
> +       devm_kfree(hba->dev, hba->lrb);
Is it possible not to release the lrb here?
and then you won't be needing to call ufshcd_memory_alloc again?

Thanks,
Avri

> +}
> +
>  static int ufshcd_alloc_mcq(struct ufs_hba *hba)
>  {
>         int ret;
> @@ -8183,12 +8206,25 @@ static int ufshcd_alloc_mcq(struct ufs_hba
> *hba)
>=20
>         hba->nutrs =3D ufshcd_mcq_decide_queue_depth(hba);
>         ret =3D ufshcd_mcq_init(hba);
> -       if (ret) {
> -               hba->nutrs =3D old_nutrs;
> -               return ret;
> +       if (ret)
> +               goto err;
> +
> +       if (hba->nutrs !=3D old_nutrs) {
> +               ufshcd_release_sdb_queue(hba, old_nutrs);
> +               ret =3D ufshcd_memory_alloc(hba);
> +               if (ret)
> +                       goto err;
> +               ufshcd_host_memory_configure(hba);
>         }
>=20
> +       ret =3D ufshcd_mcq_memory_alloc(hba);
> +       if (ret)
> +               goto err;
> +
>         return 0;
> +err:
> +       hba->nutrs =3D old_nutrs;
> +       return ret;
>  }
