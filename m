Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB196974E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjBODYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBODYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:24:23 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75A12BF02
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 19:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676431462; x=1707967462;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2STTRWE5W1Se6DM2A+xp0KGGcf/mUnBNdnp5FgTk8SU=;
  b=AIm7siGxYYz1gy3sDDWsUniHHne1g+8cnFdROAuYRysUMf0ABRQdULNx
   ZVTermRwOZ6JJ9X1NqZptA+tEGtO57aMq7D1bsdYGvSL8gTl6XRRwhrCV
   ViGSXMynXoq9LUbeIc7Jhur1RQ6ZZeYNE/PB4Eva2iQwls9K1c9F+MxyP
   ccZrk/dP4VWmSXvUiEYjSb3+KVKQO9J6QCY2yVjzqvMtLEs6g4Cz0mFzq
   v9ZBsWba92XtifYubFAUVdVqAvoW+73Uy7LhUxKPcmuBZvvUsXeYw3RwW
   fz0XosB2e4WbZDFOFDomWFGJzZSPykBpPUCuJDaCWqP6TrbZ+So+uA8vF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="311700420"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="311700420"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 19:24:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793333247"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="793333247"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 14 Feb 2023 19:24:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 19:24:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 19:24:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 19:24:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 19:24:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nnkq016oT+i+rI3ITZdUsRDmq4OURSizmabx5HQ2FKxnAdSaIy3c1S5YjVmICAg5A4A9f7AsEaja7oG5ASimTI8ltSXkWYVKf8AkCpGmxzpXLcxemJMm3Zr+Tzy+HaZ/j/rZu92VwGMHluzBO8EegaV4EU7+vxTYOcJqhHuDVsef7ZIaM6zXMkSuY6XaAJB4fLZApRgsZQ2r6rf7Eao/qskUo8T5VAYCM3eN3f8ts8IEaQ49OF86cdCHQbVSacOIWbuleMwQKkL+4LU0A6Bg0bjseGy5reBYXzGpvqa0jUFA8zZ8AC5yjzR7lYsA1JdQ1KuWe6bTxxOOi6ZyVimRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/cBxD6UG9e1EKNURthL4ldGbPk1tTwwBaPvxWh2OMw=;
 b=a59g5q/P+kK1ZLkHm63CrBjp2DVFCUjsR6UCPfA6rPymdUiFwzqEXihJ1Si3QwceQsfKCsUnwFu7ylzNEPn2EVKW+clQC/BpVwcM+u/1a78Zkh6t1yd9+3R79YGl/8NABZmNbmOE2UV5R7j7Nlp4DWzkqjXG8ejsoBK7eQMhPeRM1lx+fnL5+1Yor5Eo/T2hNF5ytbf25AGRKVYTMY6+nSeUwf+ChH+e0AX8Bm93gyrKVnqpLOTh9rZlIZkHIJc8eSg9/pH77yycYSk/7vrTv0UR2cOkqm3DYslCpNGik6vW68wdUp0cWB01JnHbOrQrrJX6s64l79mHOBzZQ7qsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Wed, 15 Feb
 2023 03:24:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 03:24:19 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 2/3] iommu/sva: Stop using ioasid_set for SVA
Thread-Topic: [PATCH v2 2/3] iommu/sva: Stop using ioasid_set for SVA
Thread-Index: AQHZQD9F7KUt2c8R1ECOqV7mphNOEq7PV2IA
Date:   Wed, 15 Feb 2023 03:24:18 +0000
Message-ID: <BN9PR11MB527670F77FADCB351E41F8B78CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
 <20230214064414.1038058-3-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230214064414.1038058-3-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6375:EE_
x-ms-office365-filtering-correlation-id: 19a1f534-a44f-4f2c-5914-08db0f041fb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 06+QOsxhhetA5hJx5h8tQy+SeiC2JjRDEbHCnNwEJsqEFoNePGAAoTwKnHm/zkV5zzCecTvp2z7Qq3g1DdxHI5w/B4K+yiSYktPb4lKOsO3DDXMsYpyzr/ZLQ2TD4xGsWCcE3f0YX6RN2NBQk6bOZuQJdI+CdEVSnUs6wkMZVL2d5agqf4eqWhEqsqGpk5YwL48kAikdJASK7ChSBpkWTmpxstunQ6t1/6M7m65UgSjsYEcRSefiE/VCsqukFOqzIh6vVaSz0S/aQQdP+jcCDMRL+stBWjB8Bs4hg4ugJQgrLVYuBVdYSrF443Oj9nLly7zPnUZzN4fS8R7xGkKhxZNtbQr1Gouqi1nEmORkqS0eDgbVm5GXAY66ZGxOm5IguFe6vZRhjCFkvLjBIgOyqIgOJ3+OqGOt9j049RgdtFCckyL0CBELPqyYV3sqLAQiv0WJLwYvDkuRui6BYdsq2Fwsqo5udv5ahoIJHPjJblqn8nNvs3sp5BzWewYbUN2rdNhbxHwp9HUN1NtDI3AYWb/UZvwkAeDWuDtyDxy8ym9mMhTDlugMKPvERs+XhMbjKuzZN0luTH4xpGM1z3TFf/OwBmNA/eFV6azbdRSr1w+mBsZkVBJRDniuM6SjkHrnJ72iih5htvJXaGS0ECeFqn4tnxddoIsyRF0P6YBr5WXzSiv0abMK7RPT+CCnVcqFn4bhO2PWdGPVijwTTWZ7VA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199018)(7696005)(478600001)(71200400001)(83380400001)(86362001)(6506007)(110136005)(316002)(54906003)(9686003)(33656002)(66476007)(66556008)(66946007)(76116006)(64756008)(8676002)(4326008)(66446008)(38070700005)(26005)(186003)(2906002)(55016003)(8936002)(41300700001)(52536014)(5660300002)(7416002)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o3dXjlDMzV3x6Ul96Pg44hOXchdAYCTJA8d+BtuLC4lzkHxKEuUh4bni1sVx?=
 =?us-ascii?Q?nTJaoJK3RbgUSZPHQu2k74oqYPeqdsHyUdVCBR3xdnfVYRTwdL+jonyf+jEH?=
 =?us-ascii?Q?2doHd8I4QfGHbbwoDh4zXHgyNi19NFUJpZQmHtM14dsrEe/ikZXLY2TH7utS?=
 =?us-ascii?Q?9O3e8ijOPGHv/2x/t2rTlTPIwQi1wq70YvnHGu94dm3VJRMtJe3OsFtdQ3kb?=
 =?us-ascii?Q?FwhE0jOSo/0Kn8vQll8pSEEFRH+J/2yMourO5DsY/KAkqwohS6eZsFDtYKbn?=
 =?us-ascii?Q?BPg1D+QTkMdciINMZZw0gv1EYAmqulvk+99oiebVLhOCHtHAcO+EhOtA851U?=
 =?us-ascii?Q?0f3ParjD/PaQNbLSggZTCpkwmNwqq1pJAlCi3MzZEeZivbOrRmt8vk1HZ2V1?=
 =?us-ascii?Q?v+lVYHWw0oVmR3pTw+Y3c7peAaccBEH+kdutBxA3HkKwpjup8k5fXjhMD7sj?=
 =?us-ascii?Q?Qa8RQDGra91o4rWLW6b/jveuaggJaBLiTOpZdhN6W+zJViMblLiR1bjodKbv?=
 =?us-ascii?Q?eXXJdNwfsEzjTc6Wl0+a84tEoNREZMgFxZoFoJ/vEM8bA2sdMB7JJarppM7r?=
 =?us-ascii?Q?I8Q88IzA8QHXHuPIVC7JDlhqT8iIuieOQSkQ8RPZCdRk1wCAmbGRauQN0Z2B?=
 =?us-ascii?Q?R6U+Kl4KVe55I0HkUVM3ctu4TJnJ6SpZEKnvVvAOlVFKiJYXbc+Hl3Edi0Of?=
 =?us-ascii?Q?8ewBB5Xkgr6uvPAFs6ll0kBZjOZGr9dl3oI/wPZkq5TVRuTbGbYJXYxCJUmz?=
 =?us-ascii?Q?uZ4atiiaRw80CW5o5vINJYEbpn1cnZPXQHz8Qs+DE6Lkxb+wQJaUXRFC/9n8?=
 =?us-ascii?Q?4zKjxOVntmqJ0iU2ooyl0cf5u2EnFHDcwuoKWp3Qjx5nBrT6xBaiQuTl98Pd?=
 =?us-ascii?Q?6bot5c++rrn7FZnVVOVlfVGg+ES/rYcvrFoTujZ+K2u6cLyHlXoRX3KcKF4w?=
 =?us-ascii?Q?AjMBeDUrLwqbdSgxVYsiIORxsT/QjXrKCuDNRVZmWzKy6NXhd/N7Gwn7fura?=
 =?us-ascii?Q?JBJV023frLEnu8yXg3uql1Dj9K8DYpPjuPiOiMCEvEQJN7f4kPaDAX2lF+Qt?=
 =?us-ascii?Q?OP9u+lZFVUSDwgyHEx+DR3KDlOlUTa9KgXFibW6yqo2vY3GPAf7kZB0+WCYu?=
 =?us-ascii?Q?NAXnNG0FCEpWUYei+qbNvHYnA+Ssh/etPE8W4qTcJXi9Nu8TniP86is+5l2W?=
 =?us-ascii?Q?reNvPzVuTTi0uIuXZ5042jG5GS+fxPipCEm9GDE8nqmUriwxkd4wcAli0QRB?=
 =?us-ascii?Q?3nvOtvD9WWmEnQ7zBaer5LusS0v9i6vbrWQIqBMDk1M5FPdT+VyXq9V5fQvN?=
 =?us-ascii?Q?gl7JNd6WuYPP37i0bMpXwhrUq/Y0ibuOS/8myoMwMDW9nNzEIa5a11S18xug?=
 =?us-ascii?Q?xhv5yEB0vMZjW+lIOyIGrxSB7Gl8vrGElSxkT6Cjg9MfVG6UtoAXOM2YQtDK?=
 =?us-ascii?Q?0YnKFKorfFl9O4OVWhPI+5CYGFBgaG+SbztxTUYAtCJH1cupM30d96jVS0S2?=
 =?us-ascii?Q?mlqe29nyNH8LwDSP8wY90KspLUudFQ1t5w1g+fubfsF/rW5ug/4atEdALeey?=
 =?us-ascii?Q?UPi/hIvXljee0JNlrOPwznsg9K4keo9NYRVxeuJO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a1f534-a44f-4f2c-5914-08db0f041fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 03:24:18.9009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjZbG0RzPIBU6+Uef0w9OZqoMm6XUjXO0EK3s64AtJ/tvP/A738blUQxLbyB681nB+IH628eKwz2xLmeFUbczQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6375
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, February 14, 2023 2:44 PM
>=20
> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> each mm_struct.
>=20
> Future work would be to allow drivers using the SVA APIs to reserve globa=
l
> PASIDs from this IDA for their internal use, eg with the DMA API PASID
> support.

I think DMA API PASID will need new API around this IDA. SVA APIs should
be just for SVA.

> +void mm_pasid_drop(struct mm_struct *mm)
>  {
> -	return mmget_not_zero(mm);
> -}
> +	pr_alert("%s %d", __func__, mm->pasid);
> +	if (likely(!pasid_valid(mm->pasid)))
> +		return;
>=20
> -/**
> - * iommu_sva_find() - Find mm associated to the given PASID
> - * @pasid: Process Address Space ID assigned to the mm
> - *
> - * On success a reference to the mm is taken, and must be released with
> mmput().
> - *
> - * Returns the mm corresponding to this PASID, or an error if not found.
> - */
> -struct mm_struct *iommu_sva_find(ioasid_t pasid)
> -{
> -	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
> +	ida_free(&iommu_global_pasid_ida, mm->pasid);
>  }

when moving this function following line is missed:

	mm->pasid =3D INVALID_IOASID;

btw the current placement looks asymmetric. We now have
mm_pasid_init() and mm_pasid_set() in mm.h while mm_pasid_drop()
in iommu-sva.c.

Is it cleaner to introduce a iommu_sva_free_pasid() helper and then
call it from mm_pasid_drop() in mm.h?
