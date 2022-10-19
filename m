Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B6060408A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbiJSKDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiJSKDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:03:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F1A127909
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666172505; x=1697708505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=IF3mtBCfbCaJsL0XDmXH8LL2zRqyBQoUyKtfsKogI/0=;
  b=f5WPGEwQNaAJ7ofbEuzhV/IoZr99Ve4Mz6DnfsQVMJX/KcIhhmmfqQzk
   eU0F6ZyyU+YZpGzYjM3RI9xBY9/7OAfw/dwKfCvhYwSYKYw07rGB5a2vS
   E7vaxk1onpAr9PdOi+XcD3Tl3U/tF2vt/d/2/kjXnYrMOnrHr5ShAH40y
   2VbNYvx4oxToh1vsZ7L8Tn6JUvLKgY2gSzHBlgCy2TUW/oTvt7eH+aTlg
   921Dxpx9GiKTcY5lxl0B2kwUdXMRRnE2tsbStBWXHjtkxt8P5kH7scc54
   rH1MlAJZJU994K8h+Hr31OOb0a5rlFQlETQ/9pwJjeFA1YGNiRKu3NvWP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="286752532"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="286752532"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:37:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="629173179"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="629173179"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 19 Oct 2022 02:37:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 02:37:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 02:37:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 19 Oct 2022 02:37:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 19 Oct 2022 02:37:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjn1dyrA0s+wXOtyJlB8kLCnRv8v9nvc3zeT4cS4YarPNKZh2QgGztSdXguHn2BfxGkMRpEoEUsTwCLsxllBt1J1MB4BsK6u5KTI6cK2pXquMKBH5oxmnzC5NYiyDF+7oM4/ptI38jV8UHRoV0j0k+8mxmKyjgWGv76S1QV6BCTI1aiPQ7QYYUxLnI+Jk//cwI1V4OcA/S8auph2NmNjZjGGDkvdN3qS24DyXtljAGAku4RKHjNxF9Xoe/jMcKjtEOPLYAIkoaYFKPp9n3vCYd/WEig96Dm3xBYguUkk0U73KZyM5Y+Ny++mftivq+lJB1QFCE9ZBJG7lGqsWbnuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTAARzrq2NV6G39TPMzlgjUtMNlFklfR03KlFkMwCwg=;
 b=XFM4X+GwzOIxylASz2D86qfycmrIxH3Xn1c65F4Nnwb1x7HwfeaTxeg8CrMi5rEdDyC3V88tm3OPedQaeYnMInnq72WPbPUnLYhfH+WReYeS7NODhA9jEHYk/kfozHWqTdmbKNW1ViZIdHv2Q13j1RfOER768IwjUbEGjwholiqHWqkcUqTIZiM4UWb2As8mje7TcQetswN4cWEk4VpWejGTpXRwxrq5ajQXT3goLotLZpCc0vCZDikdsDwq/5XU/3LaSAb/2vnaaLqnL0EJAIoHxbHpZUpKXrPC4zq6CnNcJsEqhntLJmtX96RicI6rTHGfxNxikY8NTHWu/VmkdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4401.namprd11.prod.outlook.com (2603:10b6:a03:1be::13)
 by BL1PR11MB5335.namprd11.prod.outlook.com (2603:10b6:208:31b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 09:37:38 +0000
Received: from BY5PR11MB4401.namprd11.prod.outlook.com
 ([fe80::34aa:22dd:94b:d48b]) by BY5PR11MB4401.namprd11.prod.outlook.com
 ([fe80::34aa:22dd:94b:d48b%7]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 09:37:37 +0000
From:   "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
To:     "eperezma@redhat.com" <eperezma@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] vdpa_sim: Implement resume vdpa op
Thread-Topic: [PATCH v4 4/4] vdpa_sim: Implement resume vdpa op
Thread-Index: AQHY4sz6LkltapBFYkewELVHAF2DPa4VdXYAgAABxoA=
Date:   Wed, 19 Oct 2022 09:37:37 +0000
Message-ID: <c1849397292bd036132c15836d0ed8e8e4d5b27c.camel@intel.com>
References: <cover.1666082013.git.sebastien.boeuf@intel.com>
         <56c045ac70e44e7d80f3f9e901deae3d7485b2a1.1666082013.git.sebastien.boeuf@intel.com>
         <CAJaqyWdePmapASK060=k+LvqHJHWppMApcQ65N2=THfuCmbjkw@mail.gmail.com>
In-Reply-To: <CAJaqyWdePmapASK060=k+LvqHJHWppMApcQ65N2=THfuCmbjkw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.1-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4401:EE_|BL1PR11MB5335:EE_
x-ms-office365-filtering-correlation-id: f7b78c9c-51f5-43e8-e95e-08dab1b58ef0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XZy4TDPo3swoG/AuQg/p0fMZuX046AkaD0zelB0gMrhcu6jTyH85u2TO5DS2YrrEvplYDqrvAaIysopfrvNZtJfnvEPGRQbOJFMceUZeqPuh4U1UVL483p+tRHMOWu8XyRG5URexDgWm5mO3E4Ie8Psc1ZGbf6rDGNkfQBowfUGekFP9cjq520U0pXevi/8VAbXWk/ncCZrfsf7FMl5elBORl39io0yzB9r9s+3impY0ecafzkp6GkJp1DI7yxtQ3BqAXfC5pm2JlfWLdtCuwu+nBwXLKDs3Hhar5KNPR0oG2T2fBical01JWj8Gd9ZId08fIH+SV1YYGJLcWUsedHQUjOVUIxrJL5qPOymGCSBmOCXEMTKA80dqAO3XUFmIYNVnsfh2TF+2q4qfY/CgK5addJNlDBTce2kv1iM85QS1Ag1IwDBpvGUOhJ3ztAEnNAmv/V/JpuP6Yom7Mkx/asX9W/oX7psxa+tkUj0wtS2ArU5PeU7DnCbK2J6V0khhLEmk053VeOpnl5xq1uIER7RyTHhxQSmV1wTJH9q/01dzwTBe2UWrwbih1tmWQCNN1VBHK3WLBbyCwVG7Z6k8C8BY594JyRtnpJV09sQyjsoV/p5PVA0yU5gWqTp6Z4lab/x6dRw+nzn4CDMYdsPoYISvnW7P38obn2ybog7LZZAGpD9hcGw1J0u6nnHxmj/cP4YHxMAXizH5TiTfNuXW3+PdLcnL3nG88Bc4X5o657FYXith5q3px8jtw3DTsq2wLCK9JgrDVtMZF5LzeQn43g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4401.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199015)(54906003)(5660300002)(64756008)(6916009)(66556008)(316002)(6512007)(76116006)(66446008)(6506007)(41300700001)(26005)(478600001)(4326008)(8676002)(53546011)(4001150100001)(66476007)(71200400001)(186003)(8936002)(66899015)(2616005)(6486002)(2906002)(82960400001)(36756003)(38070700005)(66946007)(38100700002)(83380400001)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTNjYnJuVkpwS1YyNDFudFA5MVRlWncvLzkwUW9pc3IwTDE5WUFzRmhMWVZW?=
 =?utf-8?B?NElvYnpXaEdFTjFtdXg2dFF5VXAwV0FScW1yVnhuWjZkRkhHSTg4b1NDR1FI?=
 =?utf-8?B?amM1bzFJTElkYXRpNjdGUjlKYnJlWHc0cnVibUxDbXVVa0t5OThvWm84U250?=
 =?utf-8?B?c0dobjFOQXUzT0xkU3NqN25tNDhtSjVSQmw5bC82NXVGSzEyNlpFeWxGYysr?=
 =?utf-8?B?U0w5RVZhTFdRVGliV25RU2JvTjVKMlMwNDI5QXdicGdNS0hJeW51WmREMndq?=
 =?utf-8?B?aTgrK09KSTNSaEF5dTlkV2szeUhsNU4zMTlrWTJlcXZzNmNSL2NWbFNTeUxq?=
 =?utf-8?B?MFVjNExDbk1LclYzT0hkYmxza2p6VDlPMnJpZk5GWmRUSkd6a05rcTNrSFNs?=
 =?utf-8?B?T2NLdnZOTUFvY0J6S3NhK2RJckpmZmcxUTAvaFFtVEtVd0ErSWpoSFo3dk9z?=
 =?utf-8?B?UG1BU1pxNyt3T3BMckszckZEYjdLQmVrNG5iMjFraXZiaDN0M0J3ckM3clhG?=
 =?utf-8?B?OUlHcjFod2dIVGlVUHdqaHlNTWJUczhFVjdaVERqU2pmNlFZNkxweHhEQkl4?=
 =?utf-8?B?bmpSSTRFbmp5RlhVY0RCa3R0N2lhVnFic0p2TWpiM0xNVVFHZWhCWFNWSkJi?=
 =?utf-8?B?TWxvVHI3R0VPWEtlSnhVM1hPU2c5UTRTVDI3RWxsTTBxd1B2QTAyNjdOMS9D?=
 =?utf-8?B?aHpDNUlXYUtCU1g3cFNBL3gva3NGSUFEcjYzTm94UDVCNlNDRDkxWXJNYjA3?=
 =?utf-8?B?VmRCNlVsSm9qcXRQUWdYQUd2ODJHaWhMREpjQXVpcllJOUhVLzlmV2NFcnA5?=
 =?utf-8?B?SURMWDJ6SHUvWlBqSUdkUUtheDlGNG9aRVF5Z0crY204VDBQbDZPeEFPM1BO?=
 =?utf-8?B?QmdNb01MMzZTaG9pS1RNS09OdFlMRk5hRlVRZnk0cnhUNEVRdVhRajhaRmhX?=
 =?utf-8?B?SURmQmFFMGYzYXUzYXZKc2xuUm9zU1N1RW9uRWNIMWpXNkhLYlFVTktlUzRG?=
 =?utf-8?B?QjNYbUZ4Q2ZiVXNYL2p6MWhCeTBDWWlYR2FubjBNMTVIbVZEemxFdFc4aXA5?=
 =?utf-8?B?aGtUSEZURXhTUXpkUWcxQzVBYUtHZ09UOC8zLzRUVmMvK0FiSUFPUHlMbnRi?=
 =?utf-8?B?TGt2cjFpMUt5NSs4WFAxRGxGb1d4bzR6dFBuTnR1UWxkSWVnbEQ1NS9kb1ln?=
 =?utf-8?B?L2NpK3B6NXp6ZWJpbElodXFpWjJQWUlYcnZKUjU2QkJRWG1vTWFiaU9qVlll?=
 =?utf-8?B?akF0YUZ1UlMvbkZRZk55UElodmhYb0pWc1pSZmdUTFQwZDlCTEcvWkxOWXl5?=
 =?utf-8?B?VVZPR3hneVdITnVYdUJ0V2VVZEk5NWtuMnBEUTRoQlp6QlI4OU15dmxuNE1T?=
 =?utf-8?B?TEczUzlacWJ6SzZxdDhFTkJXWFBlOGt6cUkvT3Y2Zk9BWXhCenRkZTc2T2Vj?=
 =?utf-8?B?enJORDJucWZPcWk2aGI2UWhieWVydXJ5K3B2RU4wUER2a09XZU43Zys0NTRG?=
 =?utf-8?B?ZzNuUFgwNmNyZkFYVGI4TTZpRDJnVDdaek1LWHFZZ3hxNHJBTlRwcjltbXFR?=
 =?utf-8?B?cGVrclcwTkJkZUtCQXF2RnNQMU5JVFdiSXVlK0pZMDFtZXA1V0RwUkxNcEtv?=
 =?utf-8?B?aU5aWDd0bS9xb01NNEdzYXdmQUlObG5wRlpjL2pZVmFQNGRNeXQzUys3bnBx?=
 =?utf-8?B?QTRReW0zMUVyRlBoQUJ2aUxPSGlKZE1oZ1ljQURZQ1UxRmlEcExMc0ZPcEhw?=
 =?utf-8?B?d3dEV0Vtbk9GWUI3SEVxOVJtbHBLQXE0cllkK3BFdE5yTi8rckNhKzhVcmY2?=
 =?utf-8?B?NnJreng3SmFRV3krR2Rla0V2ZFdrNmRobVFpa2wxMXQxZ2txcjZLNnNPbFhX?=
 =?utf-8?B?VHhFVmpHUDQ0RWxNZEtIeFNMUXpNU1h5cU5Uc3N3bU83Vjc1blhuNHJxcGp3?=
 =?utf-8?B?SThYam5UMnVtVmV5S1B2UjQ4VVlRY1M2ekgxREVpaVVtbXc3c2ozRHlpV014?=
 =?utf-8?B?U3ZOWkx5WWdiV1VIRmZiY0wzZUt4NWRWUjdxWVlIYTNobDB5cGQyWkNhcmNy?=
 =?utf-8?B?OHZvYlZNcFFUUWhWTzNDdmlJYnFzVE04RVkvN3FQU3Q1SFhqWVc2OWJYNnJ3?=
 =?utf-8?B?MkkrbHl1K0MyVVZCMjJsLzZtd09ZcHBIeFVYdEEwamhBZlZCNW4zNFptMlk1?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9678769025F0EF479D3427B9415747BB@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4401.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b78c9c-51f5-43e8-e95e-08dab1b58ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 09:37:37.1383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vY38X0OKxcEBBcog/Dy/aFv2tV6WJjNJbt3qypc9nQC/JdUURdmgnnmcK60IxAZoKV+hteWEMQz+vexmkFz2eHc2e2NBoQXDRiPKqYKQk5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5335
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTE5IGF0IDExOjMxICswMjAwLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3
cm90ZToKPiBPbiBUdWUsIE9jdCAxOCwgMjAyMiBhdCAxMDozOCBBTSA8c2ViYXN0aWVuLmJvZXVm
QGludGVsLmNvbT4gd3JvdGU6Cj4gPiAKPiA+IEZyb206IFNlYmFzdGllbiBCb2V1ZiA8c2ViYXN0
aWVuLmJvZXVmQGludGVsLmNvbT4KPiA+IAo+ID4gSW1wbGVtZW50IHJlc3VtZSBvcGVyYXRpb24g
Zm9yIHZkcGFfc2ltIGRldmljZXMsIHNvIHZob3N0LXZkcGEgd2lsbAo+ID4gb2ZmZXIgdGhhdCBi
YWNrZW5kIGZlYXR1cmUgYW5kIHVzZXJzcGFjZSBjYW4gZWZmZWN0aXZlbHkgcmVzdW1lIHRoZQo+
ID4gZGV2aWNlLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpZW4gQm9ldWYgPHNlYmFz
dGllbi5ib2V1ZkBpbnRlbC5jb20+Cj4gPiAtLS0KPiA+IMKgZHJpdmVycy92ZHBhL3ZkcGFfc2lt
L3ZkcGFfc2ltLmMgfCAxNCArKysrKysrKysrKysrKwo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2lt
L3ZkcGFfc2ltLmMKPiA+IGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiA+IGlu
ZGV4IGIwNzFmMGQ4NDJmYi4uMDVlMzgwMmZiNzQ2IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92
ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92
ZHBhX3NpbS5jCj4gPiBAQCAtNTI3LDYgKzUyNywxOCBAQCBzdGF0aWMgaW50IHZkcGFzaW1fc3Vz
cGVuZChzdHJ1Y3QgdmRwYV9kZXZpY2UKPiA+ICp2ZHBhKQo+ID4gwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIDA7Cj4gPiDCoH0KPiA+IAo+ID4gK3N0YXRpYyBpbnQgdmRwYXNpbV9yZXN1bWUoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZHBhKQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IHZkcGFz
aW0gKnZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2ZHBhKTsKPiA+ICvCoMKgwqDCoMKgwqAgaW50IGk7
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIHNwaW5fbG9jaygmdmRwYXNpbS0+bG9jayk7Cj4gPiAr
wqDCoMKgwqDCoMKgIHZkcGFzaW0tPnJ1bm5pbmcgPSB0cnVlOwo+ID4gK8KgwqDCoMKgwqDCoCBz
cGluX3VubG9jaygmdmRwYXNpbS0+bG9jayk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIHJldHVy
biAwOwo+ID4gK30KPiA+ICsKPiAKPiBUbyBuZXZlciBraWNrIGF0IHJlc3VtaW5nIGlzIG5vdCB0
aGUgcmlnaHQgdGhpbmcgdG8gZG8gOikuCj4gCj4gTWF5YmUgdG8gc3RvcmUgaW4gdGhlIHZkcGFz
aW1fdmlydHF1ZXVlIGlmIGl0IHdhcyBraWNrZWQgZHVyaW5nIHRoZQo+IHN1c3BlbmQgd2luZG93
Pwo+IAo+IFRoYW5rcyEKCkxldCdzIGhlYXIgd2hhdCBNaWNoYWVsIHRoaW5rIGFib3V0IHRoaXMg
YXBwcm9hY2g/CkkganVzdCB3YW50IHRvIG1ha2Ugc3VyZSB3ZSdyZSBhbGwgb24gdGhlIHNhbWUg
cGFnZSBiZWZvcmUgSSBzZW5kIHRoZQpuZXh0IHZlcnNpb24gOikKClRoYW5rcywKU2ViYXN0aWVu
Cgo+IAo+IAo+IAo+ID4gwqBzdGF0aWMgc2l6ZV90IHZkcGFzaW1fZ2V0X2NvbmZpZ19zaXplKHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiA+IMKgewo+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0
IHZkcGFzaW0gKnZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2ZHBhKTsKPiA+IEBAIC03MTcsNiArNzI5
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMKPiA+IHZkcGFzaW1fY29u
ZmlnX29wcyA9IHsKPiA+IMKgwqDCoMKgwqDCoMKgIC5zZXRfc3RhdHVzwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgID0gdmRwYXNpbV9zZXRfc3RhdHVzLAo+ID4gwqDCoMKgwqDCoMKgwqAgLnJlc2V0
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IHZkcGFzaW1fcmVzZXQsCj4gPiDC
oMKgwqDCoMKgwqDCoCAuc3VzcGVuZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IHZk
cGFzaW1fc3VzcGVuZCwKPiA+ICvCoMKgwqDCoMKgwqAgLnJlc3VtZcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgID0gdmRwYXNpbV9yZXN1bWUsCj4gPiDCoMKgwqDCoMKgwqDCoCAuZ2V0
X2NvbmZpZ19zaXplwqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX2dldF9jb25maWdfc2l6ZSwKPiA+
IMKgwqDCoMKgwqDCoMKgIC5nZXRfY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgID0gdmRw
YXNpbV9nZXRfY29uZmlnLAo+ID4gwqDCoMKgwqDCoMKgwqAgLnNldF9jb25maWfCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX3NldF9jb25maWcsCj4gPiBAQCAtNzUwLDYgKzc2Myw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzCj4gPiB2ZHBhc2ltX2JhdGNo
X2NvbmZpZ19vcHMgPSB7Cj4gPiDCoMKgwqDCoMKgwqDCoCAuc2V0X3N0YXR1c8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCA9IHZkcGFzaW1fc2V0X3N0YXR1cywKPiA+IMKgwqDCoMKgwqDCoMKgIC5y
ZXNldMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSB2ZHBhc2ltX3Jlc2V0LAo+
ID4gwqDCoMKgwqDCoMKgwqAgLnN1c3BlbmTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
PSB2ZHBhc2ltX3N1c3BlbmQsCj4gPiArwqDCoMKgwqDCoMKgIC5yZXN1bWXCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCA9IHZkcGFzaW1fcmVzdW1lLAo+ID4gwqDCoMKgwqDCoMKgwqAg
LmdldF9jb25maWdfc2l6ZcKgwqDCoMKgwqDCoMKgID0gdmRwYXNpbV9nZXRfY29uZmlnX3NpemUs
Cj4gPiDCoMKgwqDCoMKgwqDCoCAuZ2V0X2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA9
IHZkcGFzaW1fZ2V0X2NvbmZpZywKPiA+IMKgwqDCoMKgwqDCoMKgIC5zZXRfY29uZmlnwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgID0gdmRwYXNpbV9zZXRfY29uZmlnLAo+ID4gLS0KPiA+IDIuMzQu
MQo+ID4gCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiAtLQo+ID4gSW50ZWwgQ29ycG9yYXRpb24gU0FTIChG
cmVuY2ggc2ltcGxpZmllZCBqb2ludCBzdG9jayBjb21wYW55KQo+ID4gUmVnaXN0ZXJlZCBoZWFk
cXVhcnRlcnM6ICJMZXMgTW9udGFsZXRzIi0gMiwgcnVlIGRlIFBhcmlzLAo+ID4gOTIxOTYgTWV1
ZG9uIENlZGV4LCBGcmFuY2UKPiA+IFJlZ2lzdHJhdGlvbiBOdW1iZXI6wqAgMzAyIDQ1NiAxOTkg
Ui5DLlMuIE5BTlRFUlJFCj4gPiBDYXBpdGFsOiA1IDIwOCAwMjYuMTYgRXVyb3MKPiA+IAo+ID4g
VGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwg
bWF0ZXJpYWwKPiA+IGZvcgo+ID4gdGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGll
bnQocykuIEFueSByZXZpZXcgb3IKPiA+IGRpc3RyaWJ1dGlvbgo+ID4gYnkgb3RoZXJzIGlzIHN0
cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZAo+ID4gcmVjaXBp
ZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsIGNvcGllcy4KPiA+
IAo+IAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpJbnRlbCBDb3Jwb3JhdGlvbiBTQVMgKEZyZW5jaCBzaW1wbGlm
aWVkIGpvaW50IHN0b2NrIGNvbXBhbnkpDQpSZWdpc3RlcmVkIGhlYWRxdWFydGVyczogIkxlcyBN
b250YWxldHMiLSAyLCBydWUgZGUgUGFyaXMsIA0KOTIxOTYgTWV1ZG9uIENlZGV4LCBGcmFuY2UN
ClJlZ2lzdHJhdGlvbiBOdW1iZXI6ICAzMDIgNDU2IDE5OSBSLkMuUy4gTkFOVEVSUkUNCkNhcGl0
YWw6IDUgMjA4IDAyNi4xNiBFdXJvcw0KDQpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRz
IG1heSBjb250YWluIGNvbmZpZGVudGlhbCBtYXRlcmlhbCBmb3INCnRoZSBzb2xlIHVzZSBvZiB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpLiBBbnkgcmV2aWV3IG9yIGRpc3RyaWJ1dGlvbg0KYnkg
b3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRl
ZA0KcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsIGNv
cGllcy4K

