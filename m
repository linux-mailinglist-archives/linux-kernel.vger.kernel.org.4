Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1335D6C7AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjCXJCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjCXJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:02:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DB9199D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679648566; x=1711184566;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ipvqM8LRCTctIfpsFuoJeBvpByp1k9+e4gFAR58JzgM=;
  b=Ib2p6vYB0vSg31zGC5G/nhAcT8vCicOQbMLhaJCn2ZkRcqVfai2cIvNK
   /ZMGFo9/Cic7URODjRwZCeHp96y1h3M6mhINltPaaWIu/vCbtxMx+i0f+
   9XbKNmIq8FstIZka4RNCBOZWjA7gdpnXJi6iUy42IKVhb8PwsQmAyxsg0
   o4SDnJxihjjYAIQZn22uTvNvFdSDdVzCT2cKzEj4Yk/E/zlfEuXrsJkcV
   coKxtS77AAzp+A9rP4nix02MA+VwiDUqSPYMvt7fVWGdWbbiJKHMpWAgs
   DU+P0eliVE388Wu3Ap2rT1ARzADEfNiFNmKiNiX3A2q+NZ3nE1oe0gcZX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="338453657"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="338453657"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 02:02:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="747085993"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="747085993"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 24 Mar 2023 02:02:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 02:02:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 02:02:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 02:02:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 02:02:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDDRN7Mh16kCnEvhRLf/o0XdTc/nbHyk2CIxiLgJsz8jpKxQt9DyPjR1bKKKAkcbt9Ndc4zSJqESjlBmiVbmixCmPnKY9ozYSueIWHkAZwYGR1E9dEhO4QALlCESRvaAqIrcK3qYPDvk3CgHzEFuA/BfENB3FniX3IVYaFBozy7e0RQLq1BujC+qm+hpbtP0CA3Je3I880caz3CNI3xZf5ZtCXHj/lAfFyA/ywBl/B8IIRvt5sWokWabb5R8MbE5Vx81ZYxlU7fdBOM/LYw9zuX8NcyAaCGCoMsiqFkvyqu0+J76VJ6ZtpWidkYsnCNUu/TkDEKsbr5MQdiTCP1K6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipvqM8LRCTctIfpsFuoJeBvpByp1k9+e4gFAR58JzgM=;
 b=jRlKE1xglr/vRbs+nyentM7fAjv/A3iLtMAa2/YxJaUcv66rYdMjOChmzbha9XfXv/9nx50glKa69jy7BJAlaq5C0uNKHyf3Hhuxbq143HHK034pqxjNScYU6AJsg4yKT8dwGbnaIoD5vvqSuu3YVQiN07+5pGV60yu0qtwTYM+XV5wK5VdhGQfewggEIGh0vbrtMEj+SCTK8osOlcM2uUJGQMwUjBPb5mOyb7WL6Nqc60nTgeof1I8gkSOtBZzglpQh5x+KYCuG8JItt1mlywSUdgEnDuP9gFPYovMQ+tl6/SB2hVYvA4FWza4c65XCntfVK7dpNCVrX5y6En5cMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39; Fri, 24 Mar
 2023 09:02:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.039; Fri, 24 Mar 2023
 09:02:34 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Thread-Topic: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Thread-Index: AQHZUnWe1bQRwtfhAUSI/T7BqHBa167yh7YAgAALsACAANbagIAAyRsAgAqMnjCABPKxgIAANdgAgAAeawCAAPG3IIAAOI6AgAE8z4CAA0qgoA==
Date:   Fri, 24 Mar 2023 09:02:34 +0000
Message-ID: <BN9PR11MB527622D86AE048D3394C12A28C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com> <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com> <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com> <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
In-Reply-To: <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6739:EE_
x-ms-office365-filtering-correlation-id: 5a95fa1b-f6ff-4600-cb19-08db2c46820a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9JCeVeifyLyAR+q1s7c8q25PpoaWekbLpzKlY+jW5y1qt9OaMa5ulyRBVkfz0/rDtA6sJY9z5aD5KGOh3aiAzFi/WycyPKNPc8wbL+P9GjvwnBBerHcEX85m7dbFA4a6PxQ5p0H4VvyYokWVdLuLYd7dDwDsmFtPaSNFsOdYFXJl9w0ZCjSgsen+CSPE4bfszw464thQu9vG6mjJSubwmcL5UoHcMmmcYc749eTTnBcYZlCxi9POsoaUp5+22t3kGLtACkINrYXvWCD0bLQT8oRYLrKf0CrsW6cIj7kwZ04U+VhDaqeMHdFzh5Faw2D/J/lkVuY66JJ0RPg53N+LiZ7pjrpASmnUqIP4WNNH3qXoIcd4Wcmx+f63OEOakanPSWPDZlUC/IOqcajVzrjSD8w+xlnrNFRWNfoOoA16wRhCS7X33eL+84vNABmCifUSfriFcxu2Wgq55cm3DIrYoJ31Tf6kr983VQa4dV1/FvgktDPxu/yxXL7HjXeovKHD4u7sAUWn6jh5jky9mXvN2c4KQx4LGQ2BwjzFDng4LFQKG6T0g6eRGpFF6z2K4D4Tthd35HWIojVjDYVoi5F1w9L87Gc9s2L0E+HZc/d3e3WH9oK1qoq5KEXPF58+n1hEFlhXWBnPn8CVQQc1dmrrAY1DzY7ANsbn/glDxlEd/ySHcmnGHcIdetF7gafr7jMXdhxLanB+ZjeYe8QclqLz2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199018)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(41300700001)(76116006)(52536014)(8936002)(33656002)(122000001)(9686003)(6506007)(38100700002)(86362001)(55016003)(38070700005)(83380400001)(26005)(186003)(54906003)(110136005)(478600001)(71200400001)(7696005)(316002)(82960400001)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VlFUz1uGUrKlqC+LWX1E1pt7w7RKBQnB8AsaH5kmEeOd0zZEUmlIq5DV7avm?=
 =?us-ascii?Q?kZjt1LQasWBZzRFiuRNz/gVyr/Gj1R4fxObxqh1KU6JRuFLWd4ecTA31Xr8c?=
 =?us-ascii?Q?+vJEbMbrhgcY4H1Z1bSQ6WZ42ieE4w00XWJS7Dl6upHr74P5PcOlT0NU0Sem?=
 =?us-ascii?Q?AXrU68aUqeFVqT+ikV5CZWMLU9m7ogYFt+g3EBVYYCh9KUNrptMV+qQBoBuE?=
 =?us-ascii?Q?3fuV9YOXjWoKu110upgb9YOPNpf0m12U24W4+1cyvLmd05wXusVlM24fYG40?=
 =?us-ascii?Q?v1iVNtpiepog5Zg9HiGg5eTN0OfOSOHg0z/uoSuHBflxzrpmoFeHlTqYCyK4?=
 =?us-ascii?Q?ew+eMMKnxjGDGib3YZHSMgEjywMEtLH/+IM+OT4Rpu6rf1QPA9kPkY4D2SLp?=
 =?us-ascii?Q?0TlZTL3w2pCzP5P2ucRWxi5l3dAHLBfNLHdxL0Hw/Kt4IwVghiZQxFIZOAkS?=
 =?us-ascii?Q?JNne/BTIwonNH0SgPZRg/hTyc1tD2TNZND9uNRG9wcSWISuzHasEed1kuxgT?=
 =?us-ascii?Q?CMA8+1Wqn6HVycJA/Ws3PD8fGiRXGbjCitM8Gc1bXIlHV9Bp8F16OXGivRjk?=
 =?us-ascii?Q?GNiI10aerM3F6GO2eayL/CdI8cQYFLGssA9aNgpRsn3qCZifn17Q7m0azO+w?=
 =?us-ascii?Q?rg7PhtvuTObHdTPZE1qkfFbSJ5G0wDGesa/rw/3OBpR9nQbvIGpOssXJIMUT?=
 =?us-ascii?Q?qs3mM2+Hax21aRErrrpwGOnwetgOHjtWf7CSv6zGg26HOxPz9rNUDHwvyHKT?=
 =?us-ascii?Q?zyAc5eCNQHMEBjul/jVNnyqVelC0Xrcf439vzAl4lYuQeyUcVuJqulDd2AaS?=
 =?us-ascii?Q?6le0/hm0F+UonVrItYCR10WqKS+soiTJiaVDXpXNRUl5dPHpyszmzOl0/BKH?=
 =?us-ascii?Q?gY+1jWtv9MXK94o9XwTe8CboKEIEvBlDAQem4DMll12TGu6CVVX/84VV2wP4?=
 =?us-ascii?Q?6i8IM8QzOKci3WDRE+QK2xKpNIsVKJBW8DE1gD8+d1yumFZogzRW3Gipr6Hs?=
 =?us-ascii?Q?XM3D/2QiERbj8NAEIjP0W9pv5WNeUIID7JZJod0qEjRdIaPpQY2DklsAtBQ6?=
 =?us-ascii?Q?JsysuGOMBt6TPTmlTlPWFuqg+bTH/BiM1bgaA95XnPZuhGi6fkJFrXISSGG6?=
 =?us-ascii?Q?QZL0nPsmZQVuQb4ltnIJRB26AYoEbeLI/2jgzlhxgLZU2ZKkT8IikYIz3bAN?=
 =?us-ascii?Q?oFTcBSZsDiV+6InAFe1gWDaf05N5ltIDeF5uViFJoUMrY1xOrnT/N9p1/7W8?=
 =?us-ascii?Q?Bt0zoK2d1X3Nv3J2VR5g+PrKST/pOk62HH6FQ0wvRAor9RR+oF9OW/5o+Joa?=
 =?us-ascii?Q?yNauCTIO6DpcF4avLno3gZBzJtSLdjw+DSX6DvnQvfEafYTS5TqEkqXteQa2?=
 =?us-ascii?Q?mcjyqm7cxwIv5FJ0WMN5Ilr55rXmF7gpixH4jwkuNGVmnUcx3v2Hjhhmupe3?=
 =?us-ascii?Q?p6Q///LZ7dKIS8YyaDvgg1uModsPJMQ7HMWuuxcgYME5+Njjx1fSWAQ7/yNy?=
 =?us-ascii?Q?hZRZc7tjzLkjNPmHAdLzGbQ4Y0jmNa3QgFmrI3G/i9quzGj1rvktC34FVoRM?=
 =?us-ascii?Q?vHttaEIgNtJy+cWR8APO1Bxq5vnCWMQrIM0jyffh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a95fa1b-f6ff-4600-cb19-08db2c46820a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 09:02:34.3510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9ScXR/oa9zRPZDFJRlqjrxEYDXl5zZnsUAbfjA91L2AUF0BROQU4gDesOlj4Ed8d6xEUKve4SvVF0FQ2NCKkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6739
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, March 22, 2023 2:42 PM
>=20
> On Tue, Mar 21, 2023 at 08:48:31AM -0300, Jason Gunthorpe wrote:
> > On Tue, Mar 21, 2023 at 08:34:00AM +0000, Tian, Kevin wrote:
> >
> > > > > Rephrasing that to put into a design: the IOCTL would pass a
> > > > > user pointer to the queue, the size of the queue, then a head
> > > > > pointer and a tail pointer? Then the kernel reads out all the
> > > > > commands between the head and the tail and handles all those
> > > > > invalidation commands only?
> > > >
> > > > Yes, that is one possible design
> > >
> > > If we cannot have the short path in the kernel then I'm not sure the
> > > value of using native format and queue in the uAPI. Batching can
> > > be enabled over any format.
> >
> > SMMUv3 will have a hardware short path where the HW itself runs the
> > VM's command queue and does this logic.
> >
> > So I like the symmetry of the SW path being close to that.
>=20
> A tricky thing here that I just realized:
>=20
> With VCMDQ, the guest will have two CMDQs. One is the vSMMU's
> CMDQ handling all non-TLBI commands like CMD_CFGI_STE via the
> invalidation IOCTL, and the other hardware accelerated VCMDQ
> handling all TLBI commands by the HW. In this setup, we will
> need a VCMDQ kernel driver to dispatch commands into the two
> different queues.
>=20

why doesn't hw generate a vm-exit for unsupported CMDs in VCMDQ
and then let them emulated by vSMMU? such events should be rare
once map/unmap are being conducted...
