Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3422F6CD215
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjC2G2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjC2G2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:28:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7903271B;
        Tue, 28 Mar 2023 23:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680071311; x=1711607311;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uKfSZcmsQaSkW4+1ChS96oxd8rZIdiPmkzZHH+yRzZ8=;
  b=EoNKgj6ODFeaybg1yEM7Gd9HL/vfPHh5KmYhr/PBsAXnRKr7IMxE4z8W
   xxBV47JsoG5CUvGgPrSIWoSdK6G4ROKvRmzMXnwd5LOniKlOKnDCL16JG
   gxi6+DyzGIpUD7qPWmDi2/FYyy9ViKWQmCY6pD+6m5KHsz7beQzvf1P+X
   iJX3U5iTC90ZgSjc51g7aXd1a6xDmQqZe/KbaxvrlWOW6tkx7xG/WYT+G
   +X8cN1UejGSl5/hynloeIcPdzzv1IwahhOAbc4I+8Xe6W9ULE+TDzB26b
   7QfSsMw/ga8GhcelxwijjQzO2dzR6EzaKjnVFT64U2+9lQVy6jp5aPH1q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405735629"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="405735629"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 23:28:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="677668307"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="677668307"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2023 23:28:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 23:28:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 23:28:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 23:28:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 23:28:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpjmlMUsvYnrWV6J5rbwQWy4jfWWxa84XWsa035+J/iIgWDxkOVlKRwWIDPUjqiqSoq1Qo5GsUUKYa3kK4/jE9X5v/+yp07W4B8PoSsBgf6yoi53FdS18D0bK0BQUtdTRNk4hw9PXTn+9y9PjnLLBKG2ewTTYsWCHy56lugPGRwWHINgSIicRIwNRvXqFdZgGyFJY5mNhxeXgtQqfif3HqiKAN13DTkgjNHwpMtlHPjfMaL0GafjvJcLvQ7K+eoz7fDxBHb3N3JjkBqZLPLgT7Wu3EbTUjLlnBAfUp2Oe7AvBpM2hCaxf0FHsyKSKhZSaQON1yszawar8f//g1aOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKfSZcmsQaSkW4+1ChS96oxd8rZIdiPmkzZHH+yRzZ8=;
 b=a90YzCYrJRwZTds0Q5p/81nag1JaQqQKyyO62eb91Ep6iu6zUCvwLa4XHUhCsMWF3M8bOYefNvUXe3hSjMulwC/H6PQ7Hljqe0cInKGfE3va8Yt5ecNJT/PBI37DFYqH0Oa6itLf19sVm5LAoBbp9UNUUamKFV6ZftydwL3ZBIPrh6NeZkhBS8uVgjBNy0MHiBApKLOyy//lkaY3yP1BfkDevElDrp2ET5LSK52OqMXc1ER00GjwWLIQdzEogOw/LQngO12/GUIZY8KLPLLdbqBDMuDKcM84sNEvEN+qSGRwY7qq3qc0LTOlmP4qIQ/wx9XcveQDjNIMuTfpWaKPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 06:28:26 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 06:28:26 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] thermal/core: Reset cooling state during cooling
 device unregistration
Thread-Topic: [PATCH 2/5] thermal/core: Reset cooling state during cooling
 device unregistration
Thread-Index: AQHZXh9xqEpW/nDCyUCGOxFmhxFRx68J6moAgATQMgCAAAZlgIAAwcsAgAD9wYCAANKIAA==
Date:   Wed, 29 Mar 2023 06:28:26 +0000
Message-ID: <03c9f107b75c84ebb69abfe22d6795788a315068.camel@intel.com>
References: <20230324070807.6342-1-rui.zhang@intel.com>
         <20230324070807.6342-2-rui.zhang@intel.com>
         <CAJZ5v0gze1wBEMcuEu4Aa9343rh-3=Bu+pdSYuY3stMd8QGf0A@mail.gmail.com>
         <528f7e58507df4b6137856828e371bb8913b8b59.camel@intel.com>
         <CAJZ5v0gL_7VPdcgkmuTz=afYSbGsWZi5wW9vUvyAgverjxsNdw@mail.gmail.com>
         <ba48eb3b3f4b82d33faa9233dc151f65d6380ed7.camel@intel.com>
         <CAJZ5v0h6PX8EmPtVKbPPG+e0FZn53CGG=RvpOH-vuO0fNF6-=g@mail.gmail.com>
In-Reply-To: <CAJZ5v0h6PX8EmPtVKbPPG+e0FZn53CGG=RvpOH-vuO0fNF6-=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|SN7PR11MB7017:EE_
x-ms-office365-filtering-correlation-id: f4859678-38b0-43b0-671f-08db301ecdfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZAIZBvmZnsh7RTQHogrDcXFwDWF5crBmLdjIgkIKubJi3ig3N0IGF+jOtDNEnZFaAvAKp+InzrViFaZtiiduUO+WnEUhVvkIXMPYsnnmipXQ7pIPb5fqNJJ2ZnteoFEoYioyoQBD1zFjIG/F+bTtAgGHa4T4FSd4g5JTZ3P6x8pkuQ6K8lMt/m+/LDkonOhigOvp7Fe405C+KdtDTY1Es/LsyVpHUi4KZU0GoutHEtJpDviDDSHWjxu3kvZ8DU4vCO6a0XbKVcwSERwXEtEj6TvT+rYgPlUOPgdN/zVB/dLjstCVGbilZA0DtLca8+H/zyMLU5fTCyBYdgAqWw8QGPzRlNZQw7Yk9t9hCXMUrjtR6E8zc7AALxKgGNDcWlaLUqvOJZPXYVrt/0+mZkbonyWbu73vlHJq1hPgNZl1pd1qR2KrDMNNtGV7si+TErjkci/szjRM2aSJBrB7O+4JEVm1XcbHDKOyEgCF8fsrB1InpjCeT84hBa+egqf8wqLIo1COuT60xooAYtKquhftRlpU8AdDNXcZf1IfGJ+3NdflC3S3Q8+cnMLfz3wu6TDxN+JtLNeg36pDG49P3CotIuk0BEdM+AD/xD5CSyN+zfdGjFTPWJ76TtrjhO4BAALf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(66556008)(86362001)(38070700005)(36756003)(2906002)(2616005)(83380400001)(71200400001)(6486002)(478600001)(26005)(6512007)(76116006)(8676002)(66446008)(66476007)(66946007)(38100700002)(82960400001)(316002)(64756008)(122000001)(186003)(41300700001)(4326008)(6916009)(91956017)(6506007)(8936002)(4744005)(5660300002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3JsRUZ4VXRVZENBcHNZaks5ZWV6NzRBNEFWU3JGQmlqVEJianRwa0F5Rll2?=
 =?utf-8?B?cmxWd0U1a1gzalc4blUrMDdyb0tXWkV4b0NmemRkbGpVamdrTWkwQ0dnRlRV?=
 =?utf-8?B?YmRiQ0RVYzgxaG8yZDhoWmpjSTlmTlNKRStZQUZzRjJINUs5V2JzRmYrRXNm?=
 =?utf-8?B?dlVzandSa0NkMWtvank4cU5VbUhYc3NYK2RvUU1DQVp1UHZqcHE4MTdlZUNL?=
 =?utf-8?B?N2lpa2FSYVZFWnhXOVJVWXNLc281TXlJNEE5M3BrSVZ3eTJjai9iZ3N4K3VG?=
 =?utf-8?B?NHVpY3JadzZVRjBLZTVDeXdnZmJhNWpCcUsrMzd6dWtsMzRUVW8yWXJtUVVv?=
 =?utf-8?B?Z2FHSkZLV09sVHA1YVlDN2tTQlcxMUQvNm14NThPczBtVFp2RWhsUXdrbTBJ?=
 =?utf-8?B?MG84RnVkTTF0Q3FWNVJzOXgrL0dCajU0R3V1STlxcHMra21oTmhucE14RlJL?=
 =?utf-8?B?eG5IeFA3SlN2M0krL0hPMUlnOUhFTUNJeTQ0ZWZKZGd0VWlEL1krMFlDUXVD?=
 =?utf-8?B?YmVMVXI5REJtalBkYTVVUDFURmFkL3hXNHFwMGUwT1BEeTFEamFXS0JoWlR2?=
 =?utf-8?B?cVhQN01iQWJpSWxONlY2NC9FM2tLSCtDTkc3MzEzOXc5L3BqSzR0Z3puMW5n?=
 =?utf-8?B?SGRLZ1NURzhVRndDSFNQdnhzdWY0VVNqRUJESXJaSFlvME1VRVBFdk5wUHRl?=
 =?utf-8?B?VkloWXhhYzdEVDMxOVE5ZjZLc01OaktkT0pkclc0SkFRbWFwS3VlcjJQVlhw?=
 =?utf-8?B?WndEQlVFdVhxbURtS2xIKzI3RmYwNzl1UmxVVE5UblBuNWNZVHNzaTFSUkZq?=
 =?utf-8?B?T29udDRpSFZrdEltRWRMbHNmakU0dUtOeWJoKzkvdGozTWI3dnBubnJvVmM1?=
 =?utf-8?B?Rmc2cEdLaHp6eHdsejBSaHdhbGpsaGxmL2FNR0pkSUhzbFUzVXUwMytRQTYw?=
 =?utf-8?B?NDA0K0xkVURCYVROdUxoMXlRUmVqUHJ3MXJBSmlNTzFJTlpxYmlKdlBPNWJ0?=
 =?utf-8?B?K3BVYUE3aE5ZaWhoNWZkR2JPMk1kV2hrVDFpcG5tdlp1QWxEWWw1WkZlNlFW?=
 =?utf-8?B?endUS1l3VHFMOFl6a1c5dmRXK25qaVViaHZ5VjlrRUttYTFzNGF0Ty9xUFp4?=
 =?utf-8?B?QVpsUlFwR0FzdVh6MWVJenV6a3k3ZHVRc0IvWmhveG5oOWlqZGhBVkRkSy9B?=
 =?utf-8?B?Q0N3eitqM3VKWWEzSkxEMmcxYTF5Ukp0UnJlSDdHQmh2cnNmcm5MQUh2RXQx?=
 =?utf-8?B?a09TUHRtaXYzc0hYQ1p5RmwzNHByTWxYUHA2Ykl1QnRCUUZvZHVSWU03SU03?=
 =?utf-8?B?TnFpaHNCYzBzcGFoOTFuandxcFlYc1Z5RVZQckJ3UlNLRFV0TVduSFpXR0Fo?=
 =?utf-8?B?d2xOUU8zQUhVMy9GSWNUUU9BVjkva2g0TFp4L1pXRUx4YjkzdzVoTlFaNkQ0?=
 =?utf-8?B?dEpoWEJleVh0UFBqTmFiSytHRG9tOFUyaWRVQzVUUUNYdUE4MWhWdXJodnBq?=
 =?utf-8?B?K1ljY2RGYnBDNXhsVXM3TEg1MWs1cFRFVXJLWlhreVpkV2ZmbU9hVkd5NlhQ?=
 =?utf-8?B?S2V1SGdRWVZFeDllclB6Y2tpd2lKTng1djFOTmlCdE1sbCsvTFVoZTV0N0lW?=
 =?utf-8?B?dlR4RDBtM216Z0JjVmVzeE5nSTl1SGFZdVhWOXlwM1BWNlZGTisxS1JRK2JP?=
 =?utf-8?B?ZmpXeUpwN1JJaHpEV1pxMm9LQnBPNjVIVDFFRFI1ZzlQcXIvN3RmNlFabUkz?=
 =?utf-8?B?djkvSUNlT05YaHNWT2FMZ01GNmR0cWtkd0RYdG1uNFdyVWRhSnh6b083WlNV?=
 =?utf-8?B?YUMzVWtJc0dLSm5uZEJVWkUweTFyMms0aUNvZkgvaDFQZ0ZOVVRZU1hsZmpJ?=
 =?utf-8?B?cjFKWTZUalJJNDJoSXE3cTdPNG5jV2RkWWVPWHZhZXNFSHdWdVpHYzJRZ1JJ?=
 =?utf-8?B?T1JNaXgzcWdTT1JIaE1XZjQrNDhTeHcwMjRFMjVUTmhmdXZTVWt5cFVmcFUx?=
 =?utf-8?B?TW9WTUFWazV2TSsrYnUxenRvc0JKTGpSMmRLWEQ2YmZRUXY2UHZkY1J6RVBm?=
 =?utf-8?B?M0xKblQxM0ZVQjJ4Si9aK3hOVWlscTd2Q01xSXdyWFJjR3Y4WXhJZENaanAw?=
 =?utf-8?B?Nmt6QUtCdi9jeGExZmFZeW9vNXlla3pUZnlabmJhejlNd2hxM1N5YXdjS2JU?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D8DE39803448C40951CA457EF134C07@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4859678-38b0-43b0-671f-08db301ecdfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 06:28:26.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJtXIV48k1gpIYDWubgJKhxaigkaHtHMjxXfB3RT2b6eNNG+NAu0v2O/zgx1zNAiNhNg+TLa5FQwI4gK3+mEtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAzLTI4IGF0IDE5OjU0ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gPiA+IFdoYXQgZG8gdGhlIG90aGVyIGNvb2xpbmcgZGV2aWNlIGRyaXZlcnMgZG8gaW4g
Z2VuZXJhbCB3aGVuIHRoZXkNCj4gPiA+IGdldA0KPiA+ID4gcmVtb3ZlZD8NCj4gPiANCj4gPiBO
byBjb29saW5nIGRldmljZSBkcml2ZXIgaGFzIGV4dHJhIGhhbmRsaW5nIGFmdGVyIGNkZXYNCj4g
PiB1bnJlZ2lzdHJhdGlvbi4NCj4gDQo+IEhvd2V2ZXIsIHRoZSBxdWVzdGlvbiByZWdhcmRpbmcg
d2hhdCB0byBkbyB3aGVuIHRoZSBkcml2ZXIgb2YgYQ0KPiBjb29saW5nIGRldmljZSBpbiB1c2Ug
aXMgYmVpbmcgcmVtb3ZlZCBpcyBhIHZhbGlkIG9uZS4NCj4gDQo+IE9uZSBwb3NzaWJsZSBhcHBy
b2FjaCB0aGF0IGNvbWVzIHRvIG1pbmQgY291bGQgYmUgdG8gZGVmZXIgdGhlIGRyaXZlcg0KPiBy
ZW1vdmFsIHVudGlsIHRoZSBvdmVyaGVhdCBjb25kaXRpb24gZ29lcyBhd2F5LCBidXQgYW55d2F5
IGl0IHdvdWxkDQo+IGJlDQo+IGJldHRlciB0byBkbyB0aGF0IGluIHRoZSBjb3JlIElNVi4NCg0K
SW4gdGhpcyBjYXNlLCB3ZSBzaG91bGQgZ3VhcmFudGVlIHRoYXQgdGhlIHRoZXJtYWwgem9uZSBk
cml2ZXIgaXMgc3RpbGwNCmZ1bmN0aW9uYWwuIGkuZS4gaXQgc3RpbGwgY2FuIGdldCB0ZW1wZXJh
dHVyZSBjaGFuZ2Ugbm90aWZpY2F0aW9ucyBhbmQNCnVwZGF0ZSB0aGUgdGhlcm1hbCB6b25lLiBJ
IGRvdWJ0IGlmIGN1cnJlbnQgdGhlcm1hbCB6b25lIGRyaXZlcnMgY2FuDQpndWFyYW50ZWUgdGhp
cy4NCg0KR2l2ZW4gdGhhdCB0aGlzIGlzIGEgcmFyZSBjYXNlLCBhbmQgdGhlIGN1cnJlbnQgYmVo
YXZpb3IgaXMgbm90IHBlcmZlY3QNCmJ1dCBzdGlsbCBhY2NlcHRhYmxlLCBtYXliZSB3ZSBjYW4g
bGVhdmUgdGhpcyBsb3cgcHJpb3JpdHkgZm9yIG5vdy4NCg0KdGhhbmtzLA0KcnVpDQoNCg0K
