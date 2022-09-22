Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFC75E5D51
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIVIUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIVIUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:20:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E0A901BF;
        Thu, 22 Sep 2022 01:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663834822; x=1695370822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S3u/09poMiomIFJqBgzZZLr29xwbQaKyKYW9lcvjS68=;
  b=jACQkT8lG7uJQELpowxVSqxslUK7I7Oge2MDVW9/7EafRD5+SY84smCP
   6umcMaZL3ziHEAsRyZi8bR+aqdvnt8DyBDg9YjR+w0FZ37QW3aaxag5Vj
   KymjtAZ1cr6jnkchyyd7De9PZ5dMdNbNXI8LVpETSd7E117AZE7satZh7
   jjhVDMWYgv+1OGvmJS8d69urjcfNnDzN/IRKiAmD+CXtrgicZKHUNovyA
   ti+EX/oCIAhgTsrBzzlp7q5wWUaZZAY+egE6RLoOhaTSjDw2nl7bnHwrq
   KBSAVGRC2J24jqx2m/0dZJ1iXmMWGLQZTo92a8/mj8Mz3kBU8ijXzH32R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="386524191"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="386524191"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 01:20:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="682121528"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 22 Sep 2022 01:20:20 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 01:20:20 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 01:20:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 01:20:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 01:19:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeKj+noo5YaLLuSBplBL+zZeBNhYd9ZyTWWYJQT9piGtREBN2Xp5jNp73FwbJfhH2hMO47qf1wz2lhvT/ovd9OjU2mdCn3Mm6PNDD0oov11caghg6S0j7MxjMvdv242YluYni6u6JclKeHPr6lF2EMQAM3u4NdSqjgYZNpWzjI/w4q08Nv+Y8gInO71RIIVThPiMhOJTUAGZHnOqFA/54/qtqzlNwddleiFOatatF+B3hOEp7RFnt8TX2VPHaicrxYB7dipGEBlYBgOF1ZYqWd3jqxPFxYHkURcbxtZuP0rKVMh8PUMQ8cv4TMj3plTMdp+ZB89aFAeBINokZiXFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3u/09poMiomIFJqBgzZZLr29xwbQaKyKYW9lcvjS68=;
 b=FbLLgJewlpR9xaDd6ockENjtkalWeklhyRgq+lwf5IAEknQTaQXp76WNE6mg5O+Xe77MlgoKDIn7TtBSzSdcO3mlXcNpfIIZiL41QvAohMPGDrxzOKao1DDxApdpU9TZcp5y8CGkF3GjcWA/kX2+v2Ryp/tW/6S3pGtfnmV0/r2Y4mZCs2d87XdT6dZXSghib7crOobt85o0ANwMJsCsuPzqr3JKPylVizTXUGxvVza/w4gTF8/UnYuJ+mMeqJE4HUJqAnE5NZt0XT0cWT+evqSTCGP6S/hkugd3i2YvPw9ocbihEbsNkOv/XhnfyBRY9gjBLppxWpDdpQ+4NpSU6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB5989.namprd11.prod.outlook.com (2603:10b6:8:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 08:19:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 08:19:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "sricharan@codeaurora.org" <sricharan@codeaurora.org>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "quic_saipraka@quicinc.com" <quic_saipraka@quicinc.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH v4 5/6] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Thread-Topic: [PATCH v4 5/6] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Thread-Index: AQHYzZOD/Ler6ztw7EubDf/Yvg0l3q3rHNbg
Date:   Thu, 22 Sep 2022 08:19:30 +0000
Message-ID: <BN9PR11MB5276E56CCBDDE1F7EADADC788C4E9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1663744983.git.nicolinc@nvidia.com>
 <4469b88b4460fc230b8c394f806c134e627aa5bd.1663744983.git.nicolinc@nvidia.com>
In-Reply-To: <4469b88b4460fc230b8c394f806c134e627aa5bd.1663744983.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB5989:EE_
x-ms-office365-filtering-correlation-id: 0fb55d55-91fe-410c-9754-08da9c732c7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P8iQ57BMCD8p9syPDb4eY/1ZAOvsjkKUvsqgwj13M0pOz9gULCEOwZ0cYCfwztowl0ZuKI1UPXnahY2yMwFzb7DB7Fyh/AtcwDQBEKTtrO8T2bEdvE+1CUykUgfwxyPZPsqG3pDJdtI+HxOn1Rm5Zd76pkUH1RerlJT1+EqFBTxL2pxBMSDXPWmXA3LxV7ncMgOscjokTHYlzoHH+TJrlAMOJCRf477sTm+t9LtuRzGJrQIrDPY4vDqXEbIwQj+wp4QS5p4dvLuqOJITojF0kXUzOBil09+4oLm22ujVtWcJaoXe48qfKg1D0EGj7K9nPEwU8MzPzYg1HbdTnkQrRmFpE1+G+tjXPi27i63ym66muR/Ko0+cflW49QfhdeaYnGngH3BAeihPUbibM4MHO0DLBxwjaUm2vZ1yzdPu5kEzlpN4ojFfMxhyFYNxAZ9JcT2acL76g63XuuTVT9okl8EfPpQdTIkscf8ups0MPm1PSy3QSuArgVmnf9MH/lPQ0Bs+A8IQMV1Bt8QFIjK27syA+qT8dB2dss6VcnxU7WuaAcoFoxvSFJZByw71ocQmyuj/vtdeV0KzkI55/fIC/yyF1fk7kLo9WsstbmYwzvrsBxCJb8KILY0Ial/zIdrpDpSIv7LUkoi0Cn69LRJ4h5DaBqcWvxT9H43wzYNcx0cub7ZR8MQ04i5dHZLLRMhMyD1zwh8eL8OrHPVl5XLD01TL301ucmd3zZolnoIsKOsfRFDFe0F2X5HK/mUFBZsx/D4pJ14V0A/okG784thzzQBD600bDa67oMo7vka9Raw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199015)(8676002)(66476007)(76116006)(66446008)(66556008)(122000001)(82960400001)(4744005)(921005)(110136005)(54906003)(55016003)(5660300002)(8936002)(7406005)(66946007)(64756008)(7416002)(316002)(52536014)(4326008)(33656002)(86362001)(186003)(83380400001)(38070700005)(478600001)(71200400001)(26005)(41300700001)(2906002)(7696005)(6506007)(38100700002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RW+AfZ6WdTfer7LRy95rdRBplZ7TS4KTB6zlWmB5ieyST3jFaf9cqLANub7L?=
 =?us-ascii?Q?yt3SI/D+sENBaCCfxZ552od5V14/yXc4x+Ui2g6Q3kGsMu+t91svbp71I3RO?=
 =?us-ascii?Q?kJK7qjQ2rIiGUftGlScf8pEHEUo6bM9ifwf3nZvNn380UBH/xxDWcVJN3ITw?=
 =?us-ascii?Q?01IzFXKmUHX1V6tv3Z3p5iEd2fM4BGaXzuBdR9HlKtp5uUaXIjvHKCEuu+5i?=
 =?us-ascii?Q?8bVJaM92oU5Ccy0dFJS2KTST4weo5WRXezxVhaVFWBmNQ3CkwniC8BzmQB95?=
 =?us-ascii?Q?imAldxrGDIGagxDgOnSF/3zcwQmFunSTGLXNtNWQpLD4DV6imvX8R/6fE3lB?=
 =?us-ascii?Q?qz8ShsWiwz4omNjaRnUUD7dqOkcyI0nR18/8p5YOZwvP75TIG6alIPVGE5ea?=
 =?us-ascii?Q?gGskZBlk4YlKIt7M9EUQ9VDoR7YnWPHbFSPf2EWQTNwcufRXjmHtJxWrs2Y4?=
 =?us-ascii?Q?Iu/9BQxp3WXbx8EhieLnzh8D1cNe0SersoXmcOl2YbxOMiqGfcg5rzMakrsP?=
 =?us-ascii?Q?gjWYdcev4WqhQMlwMMuEjmc8gq3SjW1Kum7QQGgi1n0Pj635WQQm6Q+98Irp?=
 =?us-ascii?Q?QlMJxzwC01B8kDgtW0uMyxJU5lprinAyXe2XLTkeH5IvPwCu1bYuvgpstjKy?=
 =?us-ascii?Q?As9hqn0zpho73QOqMTsgDFtoFITgjMwHdbYUcBoBXwKEBh0+mx2yufk3WsXu?=
 =?us-ascii?Q?nSPZUNjze1zgZiUNZjUa6pw66QqtqM/RPqAJvYXkbcPUzMJBjBeeO+Fkkr4R?=
 =?us-ascii?Q?DxhzPlV5DGCrYSMS9T86sBXVmsa8BtKk8sdO5xjMREsOA/mOCnIJaCy031xt?=
 =?us-ascii?Q?ik+6WjGZrjhCRLdDupTg5AMf9RwnEWGBNi9Fj+1DC3eVho0FeiaQdgIuEcxD?=
 =?us-ascii?Q?jvmtDtlSKWkoTNLzmzQ/HvBpXIySmeOJ/A6m27tgsp6+MmxmOAX/uwqcsBaA?=
 =?us-ascii?Q?AH1intK1IHjLNOiJcBllJCFKnaXIU7pv8To1uTMM1ZarokAfd7jU24tu2vft?=
 =?us-ascii?Q?lDMiB/fjMz3fN6rG5GWCbmuypWWmfgLzgKRHZccMbqgQ5j8sGd6Ml/sDRpHo?=
 =?us-ascii?Q?ZPb8seT5VinwE7OQJFA0yA5HfohtByiaEHaJ255PghuhQv39nv32v3i6z9uD?=
 =?us-ascii?Q?Ui7+QfTTzfwwF1OXy7E0jYMXmG0J6un5K1ts+ha4wAsuYOYtVu/K3RfC5FKY?=
 =?us-ascii?Q?xcz0hvsbD69IUJP6bjj+pO0HzCPfdmIJQnOiQC/2r4thkQxulQr/+Qup30ug?=
 =?us-ascii?Q?iHFtqqx4DuC4UOSp/173Azii0S37EwNcCsATn1SmgB7FsjmsACYTqvQMB5F9?=
 =?us-ascii?Q?DXUC71v/nMhxcuzpdi/bLOjGjRCxMXwD6RomQeYRK5ZG2FKPJTu79f8lmMZm?=
 =?us-ascii?Q?7qQO+cah75SK3vUM16gS5tNVZD+o1jaKVy2xbUFHie5PGO9vj/mmXJgNlMVl?=
 =?us-ascii?Q?dC7BQGyabUNaAQmmu4qTX9Y7CPrENRp6KfIiOKmHSRAK7sb0NYziA7cX59iV?=
 =?us-ascii?Q?6sotzV2GeyJKK8VaawwkHHjhfJ4QdWAko1fuUeKpUOLpLt+l7vlwQCzB18Ry?=
 =?us-ascii?Q?j5TzkcVuWa14TRtcEcdpI/FFRJJi24k57/tZovqt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb55d55-91fe-410c-9754-08da9c732c7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 08:19:30.7765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/M0lAK7mwtI9trxHr6KUYxPOawYvdDBE2TKEdiaBOS2lQTNQxYxXMne4OzM2ryMaL7de9pwWqfoY/1lJE7E6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5989
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, September 21, 2022 4:24 PM
>=20
> Following the new rules in include/linux/iommu.h kdocs, update all driver=
s
> ->attach_dev callback functions to return EINVAL in the failure paths tha=
t
> are related to domain incompatibility.
>=20
> Also, drop adjacent error prints to prevent a kernel log spam.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
