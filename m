Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244216BE5DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCQJry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCQJrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:47:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D6C442C3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679046471; x=1710582471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZWJ2ONoLVXYdNhBudPI7T4fHapuBJvo4M69OEvKhanQ=;
  b=IrMDXJDwxltJEcBt2AS4Kd+A+XJsPC8r7hdFEdcZndQJ6rsvdwrCp8J3
   duJjJBykGJVUmv5bmxozkh0tl6wGeYfmYhboDop/tzPCpbhcchrI/6WQx
   DK3RrcN70uoqd4lEUUKdRWNN2uXJ2OCrlXkVa5bSJEMJkZTzud7+4F17r
   z1iL969Hv1KfrqShCPjJ8ayz2meRv+z4UFQ7sOQqARAuCLaZMy7JO52pK
   TVjhVkRPiWO2Hob0x2giWlsuVHpPtQp8T3uDApfqggeuvujmNAVJ4eBZL
   TH3NkMyeOFe2k0l+lVf59pdDy7yly06ipNpEyAOqr+f1FlDRGmp0Jx+ai
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="400804074"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="400804074"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 02:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="712693344"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="712693344"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 17 Mar 2023 02:47:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 02:47:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 02:47:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 02:47:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 02:47:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SikgAPflZOR+0Tr5/S0lqaH7iZb1d5iRnJU2V+2adMHQYccS+8HfR+j7D+lO3kvdwJ60Yyq6Kn9EZq6b50PomOtMP4hxO9uE2ux/1gga5ztWq3Hs9AJOLOC/R4P9T3mXRkGlykaGJVis2DPjUcxICmGOa7tRiEF3qgoGjhuP08SpjvP9TilOkGLzdSXX2m6C/VGigSUSkb1nqXG8zqziRm3vztTcXv01r42kChxiCfaK6UjBnss28DNZUTZT9myjnwhRkaGTZry/5kRYTfTnPrBYUqD5spABucKZMu87KBEVnfKO82ZC9uMXUEf+E133S8ELEKyMAdyGnt3DSvhtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWJ2ONoLVXYdNhBudPI7T4fHapuBJvo4M69OEvKhanQ=;
 b=idlmC4GW1oJ0IRPx6WJkEJx6Ul/uls4mZRixgiUbwRk2IYRHDfLcPnxbm7qkBEX9G4OMsu9uqLeKQZqpzoemVBfj8kiLlULKFdD60IB0uDmLVBBvoPxaIwruiowR02U+KcE9RFOStC91cPSHrLDWVMKB1wm9fSKL4Rk2jkWG0Z149zgxXk3ggup5NF7MDkqTIAYDnU3w/hsge8DyIR6x30ASwvqvW3NmMWLIhmmEZpn2RZ7alAQz5IhGA3fNzmsc/DDwzH46z+beMcpwS8O4ZUV23C20fa7o6gQS5XJQqytckKw+LyfrN9nPyVIKPO61/AdRNS5Fky+G1PWeLWHIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB5800.namprd11.prod.outlook.com (2603:10b6:303:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Fri, 17 Mar
 2023 09:47:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 09:47:47 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Thread-Index: AQHZUnWe1bQRwtfhAUSI/T7BqHBa167yh7YAgAw88+A=
Date:   Fri, 17 Mar 2023 09:47:47 +0000
Message-ID: <BN9PR11MB5276CC29BB979D6093CA91F48CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
In-Reply-To: <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB5800:EE_
x-ms-office365-filtering-correlation-id: 494aaca1-e944-4319-fc49-08db26ccaa21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ban7sjCXbn3xrgqiN6XGbnZ9UE4IAh46UmClMhcGXwjwXerj+sCqRqfZJUfftBefXM8WpK/iAHyyvdHe2DJTtxEgmtvsPnHnopXbrvbnYhYrvHPq7/tbWqzvvyLkpZLA3OAFFa6fptH8Nu8bfStVSXwErOrbsRQsu1iPfOhgOYUO6/qk1RipBT/S+S+giPop83CvIgUS1P6CqPqtf7aUKnhAj/C2ywtwpYt2j54N1oRFtS//l87vsm/t6hvAljF7NAu5GOZ5nBBGFTZpISB3NzUwGX3LWFGUn2AtnKVSrzntKV+a3Ro0qkFD2wGj40L+VzQwbguLdkNPF4ESia/42VelrVFp2iIsrqtlFYuvrrcGMaO3qVfvZcQNWCPQtAsXSM8rsOW+79PIGHyCO8u1vkxzboAyKlm0wiMHdsyS/zMqGVIHq0ogSZ3Ix6sFhEYz80FaxlDCdyiX9+82bcPDUBxeKb3a7xmXVa0wNqKJwuoK3aZE5RpW3lK63kEO8mJAd8TO1oPG51b2XAf0SggHFGYofkMcPKZAN9HlO6lI0FK0Wt2w+QU9MvZLPXsQAJ3JB701zp++NjM4W2JLvriM+QoK5VJnXglyFAJWQQg19V0SUL9rj9SrppyIpop4gHGLiMKrfZjksSqswfzH8Q0U14Ipt2zbyXmvQ2cewi/G6TvkcsPc5bJBMhWkvTCZ9zZ42yUmCSZXgXKjQFRoCuNkTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199018)(110136005)(54906003)(8936002)(478600001)(55016003)(66476007)(66946007)(76116006)(8676002)(66556008)(64756008)(66446008)(41300700001)(4326008)(33656002)(38070700005)(86362001)(122000001)(82960400001)(38100700002)(52536014)(26005)(6506007)(186003)(7696005)(71200400001)(316002)(2906002)(7416002)(5660300002)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUdnbHhCV3kwMzF0dHVzOUx3Y1hGbGxJUTVQeldIazh0TVlWUGtGd3ZlMVZv?=
 =?utf-8?B?eG8vZmx3cm1PRkllNmtNYmV1dFhWVmdNR0RCcG1vRXlmeEIzNE5sSENPazNE?=
 =?utf-8?B?eFFROHhjSGhIN0ZEeThtb1NmUi9xRkVMVDlaNkNjZXF5NmhVWk80aWZURklI?=
 =?utf-8?B?L3REV1NzcXBRelR5NnNKV1pvMDhKbFVoNTFENXpxMTNEc2NkRmpxRzBPQUd2?=
 =?utf-8?B?SXhPNVBVMFNCeXpWVnNMN2JENU5JT3BLQm1PR0xBZ2dJenh3ay8xUDZOTkNv?=
 =?utf-8?B?cktFMzZXWkNWemUyWkFtSjBKQmE5TFBXaW1iZlpodmsydEp2U0prS05jdEwx?=
 =?utf-8?B?TEtHTjBjaW9QV2lEWkY0em1VdnZsaTdmZ3hORGgrUTBFMHFuNFpDMFpyTlRm?=
 =?utf-8?B?bGlEajdxRlp3Y0ZseTJEUGR5V2VHRE16UVk2QWh1SmFncWdrdWljMjlMaHpH?=
 =?utf-8?B?QlBxOGpJY1FoYU10UDVCNDczUGh3US9JYVgyMjhudnVraGphek9VTng3K3Br?=
 =?utf-8?B?ajJ4MHlzR0ErcXNqVmNEb20xVHF0K1NCd3BrVW1WNkVHZ0ZOa2hOelZxV1BS?=
 =?utf-8?B?QzlNYkpLUVQ1YVlwOFdXM1JyWlVBYm1tTUZtMDZ1dXQ1TlhGN09SR21HMFNp?=
 =?utf-8?B?QjVkV1FJNjg2bFVjZEF0UjFXb0ROU1I2dGJUUWNYTStMdHVTVk8vYkU1a21w?=
 =?utf-8?B?WEpuM3I5YzdFVHM5a1dvSDViTVhXNXNKUHMvSklXeUlJSEU4VHU3dnpMamQ0?=
 =?utf-8?B?R1NpZ1JTNzJSUUZXaEpvUExmMUpwaUlxQjVFOGhYKzhsbExVcm1ZZjBhYXZD?=
 =?utf-8?B?Qm0rcmxNNDNXM1NUakU4anJudnFjeTArQkw0QjJaNTcyUWV0TEZ0cnZONUd2?=
 =?utf-8?B?ZVdvTmlnZ29wS0dSTjdkdElNZHRlWGtncDVmVFpKeFNWdEUxalV0Q2Z6Z1JW?=
 =?utf-8?B?ZElCeEt6U0VVL2c3MW1xWHkyU1I5OUZmbDZuc25TYmlNbDA3OEpjT1RWQXpJ?=
 =?utf-8?B?a01BdHhhbzI3aXc3Vi9LT2hxWk5GdENPQ2tNdWlKWGliT1lyd2JRR2ZBU3N1?=
 =?utf-8?B?K2lxVnUzVEd0LzVtQU9LN3hmYU14Mk1IekVzR0NIZEZmK1I5ZU52ZFhscjJY?=
 =?utf-8?B?Mkdjb01pY0g4T2pGRFpmQXpGVjlkRUxUVDFMM3J6MENUWGdYVEdYV3pSVEEy?=
 =?utf-8?B?RHU5RkxEWjh5YVp0SjVYZHVKTlpRMThxZXdmUzZYaU1Ba2J4Q3EwUkR6UFRM?=
 =?utf-8?B?NC9XNHorbURsODYybHdJY3laeUJ3cUpidWJ1UGZnVW9xN3hjRjJjeWVFZWlp?=
 =?utf-8?B?RytWSllPam1TTDc0MmNxc2MwVmRnbkdDVXdRVVZoMTI5SVArZEltNW8zNEox?=
 =?utf-8?B?L0ZCT2ZxZHJJMVo3REtJYVoxNUp1YkZPM01rOFF0eDlZMDRNdnJvYWVwYi9l?=
 =?utf-8?B?b1I0SU8vT09aUVhCSUp5dGF0QzZmSzFDK1Z4bE8xTEFONkltaEVPaGo0MEN3?=
 =?utf-8?B?OXhUMklQNjVVd3lsUFg5ZkpOdXpWZkt2UWRVaEVtekhoQ2psUlFmN2RzeWh1?=
 =?utf-8?B?YXBCMWd5OFBmUGNsRGRvKzJYc0NlNTZYSHp3SCtCRXpaY0g2cmMxSENDc3ho?=
 =?utf-8?B?QlhyclZuNEhXbWo2MzV0TW9kTE5IWnR2Q0lZbkoxdi82dVNSeHBlYlQ1cUZC?=
 =?utf-8?B?ajI2aC9jcXJmMEI3M0NPSlQ1M2VKckdQNnNsSTlDbkw4WTcxcGtMNys1SXk2?=
 =?utf-8?B?SW4rdlZBWFpiZnArWnMxeXM0cnhjN2Z1aHF3aTc4bld4NmpNT00zMlRuR09O?=
 =?utf-8?B?WjNDM2VaSWFDK0tjMDhaODVMenoxR1Bpb2lob3RBaU5GWngxRmRUMWtxR1hB?=
 =?utf-8?B?UUlZWitkOUd1WnY3UnA3SStHZlZYYUFoZDJPbEZlZXVPc2liQVA3UHl0d0Iv?=
 =?utf-8?B?b2ZONytJK0hDMjFyeDcxanJGazRpOGQ3TGoxcVZtRGtLblNpYW1VeEhpWlNU?=
 =?utf-8?B?MWY2bTd1bzh1VW9QU3kxWTVoU3ZUM3NqNE00NVUrWXJqVHhSOGlENTk0ZHRi?=
 =?utf-8?B?Q0ZMWGFDNG5Jdlh4QTRrbm9zb0p6ZDZ0THBOSWdkdzloL0c1TEVhVTNEQ3JR?=
 =?utf-8?Q?sfQyv2F2wkuEbR4FX6CQSQh9E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494aaca1-e944-4319-fc49-08db26ccaa21
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 09:47:47.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7tczvCw8vJeYA5brInaZgLZq0fKZl9bmGC75n71MEtkTUJPdYXnmtKW0TdIm9qkJrP57iT4l0SvnuufwfrOVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5800
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

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgTWFyY2ggOSwgMjAyMyAxMDo0OSBQTQ0KPiA+ICsJY2FzZSBDTURRX09QX0FUQ19JTlY6
DQo+ID4gKwkJc3NpZCA9IGludl9pbmZvLT5zc2lkOw0KPiA+ICsJCWlvdmEgPSBpbnZfaW5mby0+
cmFuZ2Uuc3RhcnQ7DQo+ID4gKwkJc2l6ZSA9IGludl9pbmZvLT5yYW5nZS5sYXN0IC0gaW52X2lu
Zm8tPnJhbmdlLnN0YXJ0ICsgMTsNCj4gPiArCQlicmVhazsNCj4gDQo+IENhbiB3ZSBkbyBhbnkg
YmV0dGVyIHRoYW4gbXVsdGlwbHlpbmcgZXZlcnkgc2luZ2xlIEFUQ19JTlYgY29tbWFuZCwgZXZl
bg0KPiBmb3IgcmFuZG9tIGJvZ3VzIFN0cmVhbUlEcywgaW50byBtdWx0aXBsZSBjb21tYW5kcyBh
Y3Jvc3MgZXZlcnkgcGh5c2ljYWwNCj4gZGV2aWNlPyBJbiBmYWN0LCBJJ20gbm90IGVudGlyZWx5
IGNvbmZpZGVudCB0aGlzIGlzbid0IHByb2JsZW1hdGljLCBpZg0KPiB0aGUgZ3Vlc3Qgd2lzaGVz
IHRvIHNlbmQgaW52YWxpZGF0aW9ucyBmb3Igb25lIGRldmljZSBzcGVjaWZpY2FsbHkgd2hpbGUN
Cj4gaXQncyBwdXQgc29tZSBvdGhlciBkZXZpY2UgaW50byBhIHN0YXRlIHdoZXJlIHNlbmRpbmcg
aXQgYSBjb21tYW5kIHdvdWxkDQo+IGRvIHNvbWV0aGluZyBiYWQuIEF0IHRoZSB2ZXJ5IGxlYXN0
LCBpdCdzIGxpYWJsZSB0byBiZSBjb25mdXNpbmcgaWYgdGhlDQo+IGd1ZXN0IHNlbmRzIGEgY29t
bWFuZCBmb3Igb25lIFN0cmVhbUlEIGJ1dCBnZXRzIGFuIGVycm9yIGJhY2sgZm9yIGENCj4gZGlm
ZmVyZW50IG9uZS4NCj4gDQoNCk9yIGRvIHdlIG5lZWQgc3VwcG9ydCB0aGlzIGNtZCBhdCBhbGw/
DQoNCkZvciB2dC1kIHdlIGFsd2F5cyBpbXBsaWNpdGx5IGludmFsaWRhdGUgQVRDIGZvbGxvd2lu
ZyBhIGlvdGxiIGludmFsaWRhdGlvbg0KcmVxdWVzdCBmcm9tIHVzZXJzcGFjZS4gVGhlbiB2SU9N
TVUganVzdCB0cmVhdHMgaXQgYXMgYSBub3AgaW4gdGhlDQp2aXJ0dWFsIHF1ZXVlLg0KDQpJTUhP
IGEgc2FuZSBpb21tdSBkcml2ZXIgc2hvdWxkIGFsd2F5cyBpbnZhbGlkYXRlIGJvdGggaW90bGIg
YW5kIGF0Yw0KdG9nZXRoZXIuIEknbSBub3Qgc3VyZSBhIHZhbGlkIHVzYWdlIHdoZXJlIGlvdGxi
IGlzIGludmFsaWRhdGVkIHdoaWxlDQphdGMgaXMgbGVmdCB3aXRoIHNvbWUgc3RhbGUgbWFwcGlu
Z3MuDQo=
