Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1F6038C9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 06:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJSEDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 00:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJSEDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 00:03:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427A16336E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 21:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666152188; x=1697688188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WIb8nZZS9rM/NYKopdy6R5YLaA9VxTS8iBvWnsVmhvc=;
  b=gHhG6m4csztkgb+YF89Mr4bB71s4jx/a5b5eQ4c6EQ+N7Z33Q8LpyDRA
   uW4eC03o40rpJgBiZVu8GMDA91BDmgjR2yimdDBS2BxetgEb/cs8mKTHl
   z3wLEB6h9XW9EPLAtHs3yQP2C6quAW3TD+jBMX/lUd04EN0Kd7STY0mrc
   sR1sF228AOtqEdqV4O4dZmJI9NcFlJx9BslBy1clgLWhBS4DNqz1m5M/I
   1fPjGTvKUYAZ82iFSKPqBDC94mmX6xyFEyfVQO66EhD29xPPjOVI2Na2/
   sW9Jc4v2EW86rcg7dBFGwudyn6/L2wgJwiOaFhKIVM4PVIkNJPoIlHDkn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332849422"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332849422"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 21:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="580134837"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="580134837"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 18 Oct 2022 21:03:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 21:03:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 21:03:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 21:03:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 21:03:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3sPmQru+rsu1lGoD5C2cw1eD8014j7/OyjMikZbQwCEgeOZk6/ipSv9uCY/nUt7huViiQyS3H23ZECSWl/GLkEiDhLbmloRqudqtF1VOj/CpfSgK/vpKrJIQuo9bcSdhqD5gCdV8fjAcPCvj3k/2Uj7VdoIwtMs65UsIDUzu2WpIUE4NGfuV7U8fw4urcT7waTpR51K5M9UIAPoVytZt8Jbiy+CXHAI3BxDoLEmquO2sWjaC4OMeNsylmMdv1HRqHp2zvheeJiAP0cw+ez/h4NT1XBJvdjlqbCosFs/j3aJtvdUXDJCehgaYF+QXqS5nYLK4nzRt/AsfY2M/8mCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIb8nZZS9rM/NYKopdy6R5YLaA9VxTS8iBvWnsVmhvc=;
 b=dsREcZyey73inzv7RxmOIg3lzEcxxkFlBBLzWkFPGcvTTJ8eYggWl49ouAqehKd23hq8ep9Glbb9tvnL2wXMObCyKhyTTtVq+8TG8lNhJU9e1FYhUKMHYiEug5dmE6CxPUu6cYR3Rz1hmpMSuxW21zF10nKnTBX+anp5WFxpTp762wsNqP8ndw0eVbZkkYPMAExDgQOQd4iOMylnC2aTpCZqCks64h+jGePH0n16giaYb+XQJ7HIEgFnDNRb7iFbt6Hxuq9Ga0syLAbosUcbxQ75uCyHOX4M2vrm4U7SySChQ3vJ1u7oC7TGdrXY/BV4qgwIF6hhF+0UryTrTpJDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 04:03:04 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::6eb:99bf:5c45:a94b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::6eb:99bf:5c45:a94b%3]) with mapi id 15.20.5723.032; Wed, 19 Oct 2022
 04:03:03 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Raj, Ashok" <ashok.raj@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC:     "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 09/13] x86/microcode: Add a generic mechanism to declare
 support for minrev
Thread-Topic: [PATCH 09/13] x86/microcode: Add a generic mechanism to declare
 support for minrev
Thread-Index: AQHY4AkYVawWI5hAiEm5lXUj4pQ6b64VH0sA
Date:   Wed, 19 Oct 2022 04:03:03 +0000
Message-ID: <06e6c0b1e2624096038925bce787e7e8f0bb356d.camel@intel.com>
References: <20221014200913.14644-1-ashok.raj@intel.com>
         <20221014200913.14644-10-ashok.raj@intel.com>
In-Reply-To: <20221014200913.14644-10-ashok.raj@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW3PR11MB4665:EE_
x-ms-office365-filtering-correlation-id: 0fa060b6-a87d-4413-8d34-08dab186d242
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YJ2j7jmchh9b8mcZafzEi4b5HyYTI19XnAXRfSbAjLyAYpRwG6f+PB/h/VH0bBDpC4LGQyQ9KlfOA/XSGnSImfn2zbYQjuwmkK/uHPHVKb2hyj2mE4aJXHMPKuKV2SHseJI/vrb03aesJQK3ezupu7PwsO39cMKj4ZcVscAKfwNhux7AyMsCy2MtJfokSIgzueYdFr2ttpD2uXpPCSBFMpfga04G6j1h0BTzh+uo9qv1w2fxw6q6Znp9spXvREvxKjO7IsNgaqcvMzBWeDjOJGJHHdGoNBvozqdV29KzifSeKfl9qguNbahV70O5cFoIsWJrMIzBrux9IVE3bmBZqapiVph1+HF493VyvKsDPvJzUDf6P4DZPGcoqTo6dgK+mtVAGX5TReILnMrjRxYxfgtqzGvOi43YfjLfGssw1IRNGz1UhZxmnDQtaEBsRMmNregm/Xx9c0/D4TWrO0Gnp4ic3UIiU8scUfjqmvMp3YkZXc7WR+yzNwzEpTYqNL/CEc6flRK9FSQJ/CTYaf2uzC2u3FhkUkwaHTiO0fRZXOabnzxi40PC9ccWDRk1z2HQVJXHGArnG+yL4IyCG6sp2u2611uQDZ/A49oXqDkgYUiN2DxSLeyvXfIJVuesr4Ky96ZfeErxdXLRERkK06hXpsyb9FwRRCc3CeFQCIm9aBNsZR6HWwl96STWhrcyxtwZkrPw/kjMLS6ymLzpxvBNcavNNWBC9qJVSOPOVQ812Utbv8BnSsE6fa72P4le5OZv+ytCugoWSYbc2yU2gLfUhWHtl+gmzblS0FDFzgyuXNk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(110136005)(5660300002)(54906003)(6506007)(8676002)(66446008)(76116006)(66946007)(66556008)(66476007)(91956017)(36756003)(4326008)(8936002)(316002)(6512007)(26005)(41300700001)(64756008)(38100700002)(82960400001)(38070700005)(122000001)(2616005)(186003)(2906002)(4001150100001)(86362001)(478600001)(71200400001)(6486002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTl2czI4TjJtOWQ4bDI4K1NyeFV5OXQ3WGVxT3NVREpJelBsR3U1eHA3Z2VE?=
 =?utf-8?B?dy9KQmZjdVFNVTJpN05kMW41T21idGl4LzQ0NVYyRjhqeERTVFdlYlk2b01D?=
 =?utf-8?B?WVFrYitIM1dWU3JobW1WNVVic3UzWXlGejFzN0VRZUdJVkY1WkRhR2hjMjl4?=
 =?utf-8?B?ZHVqanZCWW9ncWRjL25kZWJVN1FsSjY3ZmxCUVRMcWNEWjFhMWZ3M0lEbkZO?=
 =?utf-8?B?Rjd2b2p6U0NhemlXMkVTdGhwM3NaSGtYUVNVckZlYXY2RVZaQWw4eDVZWUZs?=
 =?utf-8?B?cjNXOWRScWJPZnB6cmVwb21qbEJGREdDODFtaldLUHcvQzMzdW9xZGRjUjRD?=
 =?utf-8?B?aFRuVVUrNlNVUzE5ejVnS2VIZ3lKdDJ6REtla3p5S0ZvRFhrU0hjamRSUVZ6?=
 =?utf-8?B?N25xOUVmOGpHYVNhZmJaRUF4SWhGNXkrdkZBUklSRStGdTNyK2tsYmlOZmtn?=
 =?utf-8?B?N2ozZ2gyMytPWXVhYjBsdXJWbERpMm9WWGw3WDNKRHYvZy9NNXRRaDQ2Q2NZ?=
 =?utf-8?B?bGFJeVB1MHRZbjBZSWNYZ1lhRDRaYklyR3QvYWNpeklzZ3RUY0llbjJpMjk4?=
 =?utf-8?B?N016OXdlUTYwS0NSdWJoQzQwam1OdDRSTlhuY2VDcmpzUUZ0ZDNiUXpYU09w?=
 =?utf-8?B?VGxPVUZ3WjB6eSthazlNd1hDRWZhY1lMeTYrQkRYa2N5STM4YTh1TDJmeWNK?=
 =?utf-8?B?bDUrV1dBbERXeFlBUHVtc0pQcDF3NFFMOTU2cUR3aDhwUnJPS0dIdnNGNWxx?=
 =?utf-8?B?MXNUakRwaXFDdXk5TFV6dnBaeTN3bUE0L3BuRWFCdUE1NWVHemhOS2JRV3FJ?=
 =?utf-8?B?SldKM0FEbnkrSldGSnlYeFJLQUt1S21PN1JlNUVEOWYxUndIWS9NYXZMZ3NH?=
 =?utf-8?B?aXd0cG5zZ2Vqb2VZbVZmSWRzbUI1eTFLT3dNS0ZtbjRtVXowTUc4RGFsdDNy?=
 =?utf-8?B?OEZGRFVuZTQzcUVzb1hEczRlOFUzZlBzZ3FDN2d2WW0wQU01K3p3MUpTTFda?=
 =?utf-8?B?c2ZNbmpmVnc0RFVsU3liK3hqRnVKMjZwNC9UbDFNS0xBVlNDUU5vUWc2Q2FI?=
 =?utf-8?B?aytyTkc3djlFRmV6WlZnbGZrWTdTNW5SZ2lyS29HQkhSamcvcEQwMnhvSjgw?=
 =?utf-8?B?SlNjMm0wZ3h1c3FOVk5qOFhUYXNocGk2aDNKZ3FWeExnRFNMMUNwQkFjODVn?=
 =?utf-8?B?Z0RqTUpvbjh6L016NmVhWUJqYTV1T1pIUGJjenBFenJ2a0VmZGNsUE5NV21k?=
 =?utf-8?B?bEZyOXI0UzFMVHZOcW5ONEVmNEQ5VFlUQ3JKN09BZko4RDRHcW5aR1Z2Vm5G?=
 =?utf-8?B?T2FnOTNCMDNWTFBGVWc3SkFHNVZTVjF2VEV5Rjd0RzVSSHlQbDE1eWp1OHVM?=
 =?utf-8?B?b0hsbS8vSDFvZjhqQXNobjVkQS93TXFsSTBYZzNhVjBiOVlJNUI0ZlU0NE1v?=
 =?utf-8?B?WjRpZG9lUXREQlFrYUlpSnlpeXlPb0JUVnVWSHNZbjJZYlVucW1QVzh5VTZa?=
 =?utf-8?B?eFFIUStTT0hickgxRm9TdUZqdWVxb0xxb0lPK2ZTQS9oaEpGY3NEbXlscTdP?=
 =?utf-8?B?ZmlBSEdqYzRMNVJ4OEp2aEhuYUN1VWRRUm5aQTBwT1ZRcDY3Zks2Kzl4NVZ4?=
 =?utf-8?B?d2llbGo2bDE1cExUT29aSlFBakxXSTl1SHlSRFRiOUNhZmE3UE5pOFdBUjJ0?=
 =?utf-8?B?WXFyMnljak5DVFBQdS9CMCtiWmV4M0lNK2Z4czE0VUIwZFhGRTBSMm5TM2h6?=
 =?utf-8?B?YVJVVWZQQnZBOEV1SG5nTnByWmpOV3IxOUkwdTZjTjRmcVRrQUhrMXlDaEpO?=
 =?utf-8?B?TDBHRGpROXc3c2dhbkpSOU1PMDdGakJ3dEt4dmY2VkVSako5by9kQzhpaVBK?=
 =?utf-8?B?UWI5dEdaMktLVlZSWDBqODdXZHdFcmtNcHFuZUFnSStmV3ZFdkN5TnZrb0J5?=
 =?utf-8?B?MkdubnRWNnVkTWlPYmhhYUhkV1Fib2sySWNzTWJhQWxhbGtiSjYxNGp0ajJz?=
 =?utf-8?B?SWVQSWxoamtuZDlTam5ZZzkzRFJ6RHNpNnNlckxwdDgzWGFHNVJHblJlN0Qx?=
 =?utf-8?B?RXNVVUxuS3BaWDk5a29NTXo4SmtlQmY4dE9VWHgvbUVOUG00VkVzYmZvMzBM?=
 =?utf-8?B?aXZWMkhGK3hVMmRhWjUxdU1sQ2FLcWRDVUN1Tm1SRjM0RnllemV2QW5oVlFa?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E080AA6F030E447995373568CA5FDA2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa060b6-a87d-4413-8d34-08dab186d242
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 04:03:03.7501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpzQBplOPqms8F+ZCWURjyuh9in+KggW9c4zbHQ+hFc2ApGJ5blqCjPysZ2AauKJYHwOwQoZjNGNfak8fcsC8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4665
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTE0IGF0IDEzOjA5IC0wNzAwLCBBc2hvayBSYWogd3JvdGU6DQo+IEBA
IC02MDYsNiArNjA2LDcgQEAgc3RhdGljIHNzaXplX3QgcmVsb2FkX3N0b3JlKHN0cnVjdCBkZXZp
Y2UgKmRldiwNCj4gwqAJZW51bSB1Y29kZV9zdGF0ZSB0bXBfcmV0ID0gVUNPREVfT0s7DQo+IMKg
CWludCBic3AgPSBib290X2NwdV9kYXRhLmNwdV9pbmRleDsNCj4gwqAJdW5zaWduZWQgbG9uZyB2
YWw7DQo+ICsJaW50IG1pbnJldjsNCj4gwqAJc3NpemVfdCByZXQgPSAwOw0KPiDCoA0KPiDCoAly
ZXQgPSBrc3RydG91bChidWYsIDAsICZ2YWwpOw0KPiBAQCAtNjIxLDggKzYyMiwxNCBAQCBzdGF0
aWMgc3NpemVfdCByZWxvYWRfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiDCoAlpZiAocmV0
KQ0KPiDCoAkJZ290byBwdXQ7DQo+IMKgDQo+IC0JcHJfZXJyKCJBdHRlbXB0aW5nIGxhdGUgbWlj
cm9jb2RlIGxvYWRpbmcgLSBpdCBpcyBkYW5nZXJvdXMgYW5kIHRhaW50cyB0aGUga2VybmVsLlxu
Iik7DQo+IC0JcHJfZXJyKCJZb3Ugc2hvdWxkIHN3aXRjaCB0byBlYXJseSBsb2FkaW5nLCBpZiBw
b3NzaWJsZS5cbiIpOw0KPiArCWlmIChtaWNyb2NvZGVfb3BzLT5jaGVja19taW5yZXYoKSkNCj4g
KwkJbWlucmV2ID0gbWljcm9jb2RlX29wcy0+Y2hlY2tfbWlucmV2KCk7DQo+ICsNCj4gKwlpZiAo
IW1pbnJldikgew0KPiArCQlwcl9lcnIoIkF0dGVtcHRpbmcgbGF0ZSBtaWNyb2NvZGUgbG9hZGlu
ZyAtIGl0IGlzIGRhbmdlcm91cyBhbmQgdGFpbnRzIHRoZSBrZXJuZWwuXG4iKTsNCj4gKwkJcHJf
ZXJyKCJZb3Ugc2hvdWxkIHN3aXRjaCB0byBlYXJseSBsb2FkaW5nLCBpZiBwb3NzaWJsZS5cbiIp
Ow0KPiArCX0NCj4gKw0KDQpIaSBBc2hvaywNCg0KSUlVQyBhIHZhcmlhYmxlIGluIHN0YWNrIGlz
bid0IGluaXRpYWxpemVkIHRvIDAgYXV0b21hdGljYWxseS4gIFNvIGxvb2tzIGlmDQpjaGVja19t
aW5yZXYoKSBjYWxsYmFjayBpcyBOVUxMLCB5b3Ugd2lsbCBnZXQgYW4gdW5pbml0aWFsaXplZCAn
bWlucmV2JyBpbiB0aGUNCmFib3ZlIGlmKCkgc3RhdGVtZW50IGNoZWNrLg0KDQotLSANClRoYW5r
cywNCi1LYWkNCg0KDQo=
