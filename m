Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D4E6BE660
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCQKRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCQKRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:17:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C9DB74E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 03:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679048232; x=1710584232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jxD9foekqSAHBzNJL5NlILxd9RTXGBli0jdxVhfnLJ4=;
  b=M3XDNwQYqyv7np1QbLU7sDqmN+2p3uAWDUfTzPms+3Gt57q9oGcSgRcB
   G8jFAcknioe0cZwYNPi4Tv1386XQxIGr6H93DPk3CE6vdJtPR/mkZn54I
   XJKACysZiJwkgr7cRN0jbrwkeiOa7kk/5eB0XVzWn4HyEon5pHurzXSEu
   EFVh7QxDOreNDMU0lrmks8mop1u/jeH+ohqWmq1B1zPy6ZDHddvY1GTHf
   eKMIgIks2lS8hEC/TcdPcQ5aVf2s915ZDDU6VFii37pEV7MwD1RcljD8W
   8CUY9MSK75QX/fIEksp3vXBg3Z/3xLCr/ULfSfLdMuv61PTYXFeAlDS4L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="340593424"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="340593424"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 03:17:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="682633547"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="682633547"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 17 Mar 2023 03:17:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 03:17:11 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 03:17:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 03:17:10 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 03:17:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+O7EcLl/LR2ilFeT6MyG2zayaqyg/aV9zOgYzYJD14tfIZMZY8/8japkrSNXKdOLJ/8Rb1kfogNQsxVA38GbrfDAeifLh9dIs3j++WbGfFXGiEsGq8Du3JVOgn+8XWCarLj7NH6WbL+XlQ6cF9iv0NTwjXCWKAlbVgMQXFNsl2Ck5lzoDcXMFw2UXNRlAT71bcqD36g75vLRH2mup0rC63BX5duvdLoikbLSt5rrmdGKHyoPdE5xm5kZHijGv4s1+akqNfsMqrV9o/OTAKZYBJwHw3WK8X4cloLW5A2zYqjUo/H6jUTq1CVM908eFUbqP64JAVXDyAnW8MA9LAw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxD9foekqSAHBzNJL5NlILxd9RTXGBli0jdxVhfnLJ4=;
 b=GePpEOBgnLz07H6sTDIH1qpGqezYUGoMmQGuAY16Etn4IvdyyZVxH/Ilv86znU5Go2r3BI+094BhDye/pw657oJmDMUxCDNPgokhnvKAKHZt5lwnjqjloXrMFaR6IjVrWnfFFE/wBEVR3SuN55fku38zd5ZiTQ3HBFnGKSsQo4stXwZpvOQ8a7djspSiZbIAtaTcG7Md+O7GgvODLveOgEx0cSxK5nINGLIhuDaj0vEIzMi+waVWW1gcD7rLZEAYOC/dVDyeThyJWHM4iI9Ejdrjs38gV6cllYvb0MnGZyxpEG+WeosgPnN+omiXg/oVGdaDEb1zm1q+wItWWFHIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5266.namprd11.prod.outlook.com (2603:10b6:610:e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 10:17:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 10:17:08 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v1 02/14] iommufd: Add nesting related data structures for
 ARM SMMUv3
Thread-Topic: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Thread-Index: AQHZUnWUiZWK9pEL2E+1+XYbwxtqR67ydQKAgAFuRACAABXnAIAK1NdQ
Date:   Fri, 17 Mar 2023 10:17:08 +0000
Message-ID: <BN9PR11MB5276F5598BD81796202991EE8CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <5288c0e9-b806-370d-e7de-8d69d5b8e902@redhat.com>
 <ZAsn2EkRnEmsfmmp@nvidia.com>
In-Reply-To: <ZAsn2EkRnEmsfmmp@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5266:EE_
x-ms-office365-filtering-correlation-id: 1db1247d-212c-41d6-c000-08db26d0c41c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O0OhR7RUV1U86Zgoy95cJh0rfjxsrfujbI2Sip/y/GLbfKvekL8zukmRRJYPg3QbyTlf2EtbRmyOIq6Wi/rDtUrMoy/d+KixtoCLUvDOIopBfbo43Ip4RQP6A3VfCSNpgzVaoFgjveRlT9tL/djOPP7EhzmPCNPC0sdzaoZ53zrZz6uGN9EEJe9Brb3g1gkL5JTQG/pm1niYt25McVg5kiUEb9hYXskgkjyO5RyKiPhHDRcb83xumZjZasMdMBn6s4rz+xD2Hqzt1+ASYHjsiPG8uWLxL7rgI1fXNJ9+FZJDdvavQVDpEuCzq+PRLo5O1KZn61QnQwQy2TTxE4Qzdtjev/+X4HOqPNng9qC60fVBW1n2egWHNO29YH6E89lY+UKjFFWy9gC4QN+1YuLuwNsd/UHPzuc6VtVDAmow3txCs4B+ACwmQoOsqrD6u+VxZadUJ1MeMRRJGsmRdSMSAuBrYItXCscqFvRufWyAuTWLzLqdBMeI9q9vSjVaylgJLmho+K6jY9vDh1sUOBM6FlEWNdl9Lz6CfMfwfiwOY8DnTMNeXEOZO64idEF07FnIMI/Z1fEQAHRE2Irs20YQNOgh5+PNpWMoxzcj3NjPKJ8iKX3ZYpsGI6S+C04SgIrKh26WnneOJDIarIMcQ/XEcGGZwQ4we9Niq4FaZLGehNG0djQYyGnIDTOywL5R5HY8aDCYclBLEMTY9/0UQW4Shw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199018)(38100700002)(33656002)(122000001)(86362001)(82960400001)(38070700005)(2906002)(8936002)(5660300002)(7416002)(52536014)(110136005)(71200400001)(478600001)(55016003)(316002)(4326008)(41300700001)(7696005)(76116006)(8676002)(66446008)(66556008)(64756008)(66476007)(66946007)(83380400001)(9686003)(186003)(26005)(6506007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BIJg+bkfvPkPt71O/SZgVb3c8EOgut4N4LhU2UAP2Qwj43Zho+dvX12PO1Y5?=
 =?us-ascii?Q?5HaM8+S5h/tu/wL1ITi7VMNuT6WUGqnk9BExIAUTPDCmOYyvaMvaoBj48ujs?=
 =?us-ascii?Q?ybd8c9UPSRb9+JiY/feMQ9QTcMqDHXcXthaasEnPXNK0iO8RalUfrVavvBWi?=
 =?us-ascii?Q?8VBKquwnGM0bCm5XyITRcWuF4kGh8jSLODUJr1PFkb34hue6/8oy+YSB2HA/?=
 =?us-ascii?Q?jclQ7cBFGLBQol2M5c0206EKi52ndTS5M+NEKlN6jXbxzlPfTx11C3WXLNO1?=
 =?us-ascii?Q?JwlePxDyZYW02g7Lgwptz3SzmW28CrOQK5IPnOs91l+ZKIlaymFoNLb/h2wL?=
 =?us-ascii?Q?3noxlCRoq2XVmyvHmLIPdqWT8Nrd2XLxdoBNkjflR+yAqgDQjEWPVXu+UQ5o?=
 =?us-ascii?Q?7wzBRLkaO1b7Fhqj2PSQsED398gunW052se6T0y9U9UxzZIq3AUDMPKRCbAE?=
 =?us-ascii?Q?Y3lxa8eTtu0ex+eNLozSP9maOsuCATTQE8BnY4X2PfaD1tGexDkw6WcMorHl?=
 =?us-ascii?Q?1uQydLqVYDLscc6GHFwV4je9xG7GFSIhsKQNkHY9saZOJpT4oUc1RC7/xNcr?=
 =?us-ascii?Q?52d/ERtqt+vy9/3Sx2h9qvmnuOxCeFI7Z/VEQV5I7lkpmhpmdM70JlH0L7vu?=
 =?us-ascii?Q?QNNpqs/x2LQ+PrtOm23N6tKkHijhdiTULTJeRC9Njd26tHpFZAsRCqNvmbMx?=
 =?us-ascii?Q?oesNdccvXvKYh7MEsLWzTkuUlQCK5NJDLywgEbkv48zwJiazaIJ+WXRkCqx+?=
 =?us-ascii?Q?M8XhIZ37tvCXyRJzObHFAaAwSjTYcZCDNmqQYuQWMUPn2a/3CzhcfyoVJsV2?=
 =?us-ascii?Q?IjsMKNM6bQJyjHsVG4RjszbhzoTVZlZDOHUT9RpWiptgp8IHgzDymQUTp/Yu?=
 =?us-ascii?Q?/m+sbMfd53cv36OsbOOJpODktp08jxxiUs3WYLWjGMGHf4e7VGg7Ls1PuuXR?=
 =?us-ascii?Q?IN7NzodtG0cOVjlgukENTy95ImATRao1md78/mXXQ8LbJlm7La4Fd534kxcY?=
 =?us-ascii?Q?akrgRMbm5kbO+Xc9YqM/us5Itx6qTxQYxPgxpSWoLicKAK9irjDhJ3xFlZ2S?=
 =?us-ascii?Q?CLQVGn3k/yJLsgk5IR8pEGT/+AwtRQ4LIDYpFgIWFYDotpWKSK6+PgTKTqat?=
 =?us-ascii?Q?6DyB77RJ4JoqDfF+CjNDUfU78OMUbaZHzl3CM18sEuOZlzkv3o0eOEhi86vP?=
 =?us-ascii?Q?y0ai4d2tb2q2GS26wnCHwgsP7JAp4yFHXYUJ3w57MUw4P2zjlFVqpAu5oIVw?=
 =?us-ascii?Q?IWvIReFxIvlJ77UmN4gr10f7DXmYIkeQuPmsJfhR11HMDTQ0b3eb+jR/41FC?=
 =?us-ascii?Q?m6FN4+6trpT2BCa4sF9Z6DfmEtk5xhs9SIJWQS81mEZ/K4z6To3uj1R6wcbk?=
 =?us-ascii?Q?6NppX6FMnfVOtAUW7B5puugwnNChnqb29FWMCKY4zbKS+Cljb9NRCQdjopBc?=
 =?us-ascii?Q?da39Mx+vmxA2qAr95N7kJ7lMInXqVIIHQ4DZ4uaQJaTlzTYBl4F/yJsIIFyI?=
 =?us-ascii?Q?2yKrhlKSZ5wCaRQS/vjwjqMowPdY8q36PoBOwxOP37SAOnYnx/wVSsDJk0b2?=
 =?us-ascii?Q?cWIm5GCQrdHaDNCVe9kGkrhynFTGb/eZd1AEseAm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db1247d-212c-41d6-c000-08db26d0c41c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 10:17:08.7703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: azNHr521zf4j2r7A0XViLFOAW/AeKCTu7+LCMWrefo6h+jPJDmf5ZfP6yMOxaYVLfbgwrSp8I50lfYj2X7F/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5266
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, March 10, 2023 8:52 PM
>=20
> On Fri, Mar 10, 2023 at 12:33:12PM +0100, Eric Auger wrote:
>=20
> > I do agree with Jean. We spent a lot of efforts all together to define
> > this generic invalidation API and if there is compelling reason that
> > prevents from using it, we should try to reuse it.
>=20
> That's the compelling reason in a nutshell right there.
>=20
> Alot of time was invested to create something that might be
> general. We still don't know if it is well defined and general. Even
> more time is going to be required on it before it could go forward. In
> future more time will be needed for every future HW to try and fit
> into it. We don't even know if it will scale to future HW. Nobody has
> even checked what today's POWER and S390 HW need.
>=20
> vs, this stuff was made in a few days. We know it is correct as a uAPI
> since it mirrors the HW and we know it is scalable to different HW
> schemes if they come up.
>=20
> So I don't see a good reason to take a risk on a "general" uAPI. If we
> make this wrong it could seriously damage the main goal of iommufd -
> to build accelerated vIOMMU models.
>=20

I'm with this point. We can add a virtio format when it comes.
