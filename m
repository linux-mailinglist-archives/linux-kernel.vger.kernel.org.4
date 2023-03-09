Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754286B18F5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCIB4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCIB4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:56:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAEA7C3EE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 17:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678327001; x=1709863001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kawHnMPv86JPWzwh6NFkSlvrSwYa8SHCEhqTsZCOcfs=;
  b=RsOR9Rv1mkPB9F3CswZyS9UTJpJnbSKD0RVAJlTA03+SGPjjNZ6UosLY
   Zk1lK0GyJdZYlH+bhtMNxhwh+dm9hUg8jkzOYMu7s5bcfZOjEuri/nOsT
   R13E6ufAcNlDEDPWu+btyh49OURIdCp9Gze3z20lT5/UIZiL9kug3Cr/G
   r5PdnbnIJzhORqFu+tskFfNcAMT6nbyRKNywNvdyOLMdztv9eN3lmZpnl
   9LzlzNgtbmk+t1Vo58OhXtvEiPw2bCqmtu/NGLNg7Q/VCfR/Ay4GlcVfy
   c86TYT6wCzbPFMPGL3jLA68rRimK8xmvyAjMqFJhIW3Ixw60QR4eQolpv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="335033622"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="335033622"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 17:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746130373"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="746130373"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2023 17:56:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 17:56:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 17:56:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 8 Mar 2023 17:56:39 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 8 Mar 2023 17:56:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp0KRCh0E9bpniNDGLH4DfR1xf4TxGRSZZjE1kjG9FM6tlWBlvauGjr22rzwEVkY/VkDF9ztQINZzOW+xD2pn+43xCkUq5/4c5mb2J25yL9eQ5t+yGm0GvBvoxB5bXGv7Y+GWsk4VLqrMml+sB+2c5PTF26bIaAl6anHNzEAewXgazupWA4zyIaQdROgGEnw1TmTTIreFKfieVn3Vj8pe3pq5gmLfK2/0XrEsWXNnhLzpX0Ii3efUQBrAe3NC4iN0ys4D7ucge2CIkPf1EoYn115jMq+JWN/runix4RWvykL1J+bj7Bc0mDSLHV8GLIoGTx/+ZVC7dYcek/lzlBhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kawHnMPv86JPWzwh6NFkSlvrSwYa8SHCEhqTsZCOcfs=;
 b=bAd0wjR51/ue+DdGPBOcripUFytLxOpKtNnnUNP3M0RlaNpsPGB2fnkrBBqpw3ot3oKaBGHjilfvZtv1Af3XfnShE+icUCEy8DLLOAHo+BHM3RdkD8nza0AVLanNjfDc6JB11vHi8h55GdQK9LnnVYH6K1k25nBdbVHvMMavncHCmfc0OS5TX9CvSDlZn8xDO0dZRi6zTIE5hLEcel3IrBl8M7Xs8cxrkixZaIvOH7AxXo+mdGVu0/soql/iaO+yoKPlHv/4qFpoib2WG3rdnfq0JsKaOSWHdmYjQ7I9ibwGKtv9M+USLfedwf3DtBztAyQTcwHMI5ATD4RsW9WYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN0PR11MB5986.namprd11.prod.outlook.com (2603:10b6:208:371::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 01:56:38 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 01:56:37 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "rppt@kernel.org" <rppt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "song@kernel.org" <song@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
Thread-Topic: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and
 unmapped_alloc()
Thread-Index: AQHZUaIuxKgpIsIIt0SQaVbqG0tFBK7xsX4A
Date:   Thu, 9 Mar 2023 01:56:37 +0000
Message-ID: <47b5156d814b88ec894f38d245d0a09061112f85.camel@intel.com>
References: <20230308094106.227365-1-rppt@kernel.org>
         <20230308094106.227365-2-rppt@kernel.org>
In-Reply-To: <20230308094106.227365-2-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN0PR11MB5986:EE_
x-ms-office365-filtering-correlation-id: 4eabe74e-3cac-4dba-1f77-08db204184ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Pg8RViAKDdJvSNFWnPOOI8zvFuHHoV+Koh1GelBJx9um3+kQCVfbs+JXmz9FES7rOcnI0BgDxsRFPYdE/XZtX4KxNiHO6Zk5t4iBNqp4ln2SO936sM+6zQxb2y6RSYocj0fpYThYgtKEOdHlWLGMt82s2I7uxM4LNFkWLull/uYSsPMFfUUY3LBCrz33YJbcWo+pMZagOceslgesNHqHsh0OIAbAt0seDeD6UQHOcINejqThQsfkgTRP4913fWHJDJyh4CdHkhQO6NY9aflPxQv54u4DczPQGoZXq63XjVXQVbcQhiy4HduGmL2soSVNAzORsiHgcu4ugPW9xsYdaEWyfTIwxN+Pwh6q4advYTpKNAxk6wyIvKhz1ugNmPFFKSpRHSG3iMY6l5L3kBmWAQ0eL1qKx+KR2yW2MBSkmhdSFWzphdbrNmt64Vkfx6kPOToJ4e2NOJ6EWu4SJOxdQPDoObpy4cVkrn//Eq4/uXWch1dKXmT1z4gnKuAqIvbVSLu3rYw2xfXSwqYrZo+BAZj27BYcey5dc6vzw18vXyG+/COMgjAlVGHwEsTrG/U8gvEgYa8Dcb+BcJ68c5Dk022KJc5i1+K18/9iKfqq4jDpiZPG5dh33OVrzBVqaXGhghpDov5s6R6TbQGzftCC8B0+6Q8cELNe9NCflUsz+KxhaTMrsUzchJSO+1ktsgsHgLucdoRrZhDXWdZR+V3jCB0kLRBJEF0WXPsIJ4QXnQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199018)(36756003)(110136005)(54906003)(71200400001)(5660300002)(478600001)(6486002)(316002)(7416002)(41300700001)(66556008)(2906002)(91956017)(8676002)(64756008)(66476007)(76116006)(66946007)(66446008)(4326008)(8936002)(122000001)(82960400001)(38100700002)(6512007)(38070700005)(86362001)(186003)(2616005)(26005)(6506007)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S05WdkJMZzhtWWN3eHZnRGVDQk5kcmxrQ2RWTkFPUDczV3RoNzZGNGdNTnFz?=
 =?utf-8?B?NkdrYkNmZFU1M1lTYW9iOC9kWDlaK292Uzh6bndjV0hnQ3BNWUVnZGc0eUl6?=
 =?utf-8?B?Sm0vYTM4TjRXcVZ4eVhubmpHbzQ4RGxVZnR2NTlVMGlvdjlGUkZZTGM0ZkVX?=
 =?utf-8?B?RmpyK2tGWlA5TXhkWG92SER5a0FvL0RYeVpNR0dxaldiczFDeERHeWd5STdo?=
 =?utf-8?B?NG55WEcvc2VpY29sMFRjdFp0Mmp0NmszUERkUmZkSGQwOXY2VDBxYmxHUHpQ?=
 =?utf-8?B?VmI5c29aNUh6eml0cUdCR1BpZExsR0F2UTY3Rk00U1JsMzBOR2NjcGx1TzN6?=
 =?utf-8?B?L3RoQjFwTHRnMHJoT05Tb3VZUjBhbWJBd21Ba04wRitMZ0tKMm0rUjlLVzVQ?=
 =?utf-8?B?aHpkRUxuVVpCOE5jR0tFRzF0ZHBLZUkzRGc3dUFwT2owdklNbkx6dFB3MVpy?=
 =?utf-8?B?N3FCQmhlUFQvT2xTU0RDUUsxVWtrMCt1YnltdU9hYTBrWXU3KzFmdmwxck01?=
 =?utf-8?B?azBpbTk1UDZZVGNBWnUwMDY4eEpueWFQUklJaGpOM1lNckFkVUVnVXNMazVj?=
 =?utf-8?B?cGRHWXd6WWZsWW42dEM5czlmYWc3L29rL2tKYkQ0bkl4OVZOM1ZWenppd0NN?=
 =?utf-8?B?QjM0SmcybkdreFAxbEd0MHVDRy8wUFZPSDF5ZXZDNUJtVzdBUTZwakl5QmVY?=
 =?utf-8?B?eklJTWRTd0hrL2oyQjducVQzSVRydkRyb05mS1lDSS83MDBvUnY5di82VG4w?=
 =?utf-8?B?RE1BL1lGZ1FFMFhZK25PTDBYNE15ZTRDcGFnTDZNSHozSTJheTBlR0FKVncz?=
 =?utf-8?B?aERLUytjRHVHVkFNM2d4YnRjUFNUN2dkRzFLdmtNalRJZHM3MjdZSE8ydEVV?=
 =?utf-8?B?Z3ZvMjZVbjdqaDNRVnVzOWJOUjEweUhubFlnZjVpQmxiMi95M0xCbWpCYjNm?=
 =?utf-8?B?cUdlbUlrR3JyOWEyMmNNaUw3bTVpSXhrTFo5a2V4V29wbkNuSDYzNW13djFO?=
 =?utf-8?B?ZkltMDRlK25OalpLdmp3dHVOaTJtRFl0UWlRR0RoSi95UzZDWHJVd0crTG85?=
 =?utf-8?B?QWNBeWlvd1MzaDNPczFHeVU3cENrK0pPdGpQSko3VlkySWVRZUNtYzlnVVNn?=
 =?utf-8?B?L0tLbG1mVDNNTGs5N1dtTVpaNzA4eEhRSXdVa0prMnFPNnl1ZTdTOGx0ZzVV?=
 =?utf-8?B?MkN5T0txM0FId0Y5ZnpwNkxGcWtrcXlDRW5HanFZWU9TNE9nQVFVMk16eEFp?=
 =?utf-8?B?QXVBYVRUUWpOd3NQeVgrWElRL3BUZ2JrOUR3bXBrTGhsdlBjd2R0SnRRanJt?=
 =?utf-8?B?d1IwVWhjL1VLaGxuRUpiSkFKOVRuQm8wSTAvckducjlqejcvb0tTVjAybmh6?=
 =?utf-8?B?VjZla1VCb1pZK0dDbzBMUGdLWCtTVWp2N0M0dWhIbnRrRDBhMEt6SU1tQmVB?=
 =?utf-8?B?QjdpSktnQjdLUVAySXBCSldVUU5kRnpsMUlJVFQvQm9kRWVrMmRadmE3SHM5?=
 =?utf-8?B?U3d5WmtKMzduMTZqQXN5UlBDMmlwRFcvYUszSUZtYllIbVFWcS9wbDlGajE5?=
 =?utf-8?B?TFp6V0dTZi9MWjlFZDJuYTBFVmozcDB6aXRtZmNxOWQwSkpOMkVudjlzV0Y2?=
 =?utf-8?B?SlY3TVh3UWxtaExSNDZ6eWJoZ0NnTFF4V2tvM1lQQkJ3djgvNytQZ0hFRkh0?=
 =?utf-8?B?bzdFdUdXellhdnVYYzBBOGpFVFpRenZPaUY2MjBUbjdZclJObmNxTDhwa214?=
 =?utf-8?B?WWM1QUFJTTJ4dkplUXY5Uk0xWWwyd0owa21zMU1kNkVaeEtHeFZNT1g3YitW?=
 =?utf-8?B?UDR0SlVhUkROdE5SQmpQUlRwSitCWWx2eEt5c2ZGb1hvOUdBRGNIeWRzRnF4?=
 =?utf-8?B?VjNVcjVyUnZvMS9JcEh3UVRITnBVbFhsQ3lDQ1BuV1h2cm4xSG5kYUIza1Rz?=
 =?utf-8?B?MDNHQlA5bXVBdmhXU0pMTmVkSm5FcGsvTEpJQ0NpcXhGSFJCYWpQT0ZRMDYz?=
 =?utf-8?B?OFB1MVlzVU51S0c0bnhtZ2tzSXhJWUZtdkFRQlVveEd1WnRtSG5OVWloem56?=
 =?utf-8?B?Q3Njc05TQWZjdW5Leld3U1E3UzJVODJlUzEvWWswUGdPNFZXMXZYYTNISC9N?=
 =?utf-8?B?YW51dzBLenlYL3ZRVXNsaDEyc3RsYjRRVzk4Z0FXUTd2anZib1hrN1pNN01t?=
 =?utf-8?Q?nhI2okMi/Ic1DN1k26JUMbg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BF54AFFD0093B468F9FAC5BDB37F78B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eabe74e-3cac-4dba-1f77-08db204184ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 01:56:37.5964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbARQp8aNtENNQcJYe9uJEjYKpkSAjWg/z7tbv/pLCCSmIShd6u1L9hNP+CmK9JIAzk4GTL3ROZrLwdFHaNZqIUAnVHcsmRwvygCqabsfbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5986
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTA4IGF0IDExOjQxICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiArDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgX19mcmVlX29uZV9wYWdlKHN0cnVjdCBwYWdlICpw
YWdlLCB1bnNpZ25lZCBpbnQNCj4gb3JkZXIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYm9vbCBjYWNoZV9yZWZpbGwpDQo+ICt7DQo+ICsgICAgICAgdW5zaWduZWQgbG9u
ZyBwZm4gPSBwYWdlX3RvX3BmbihwYWdlKTsNCj4gKyAgICAgICB1bnNpZ25lZCBsb25nIGJ1ZGR5
X3BmbjsNCj4gKyAgICAgICB1bnNpZ25lZCBsb25nIGNvbWJpbmVkX3BmbjsNCj4gKyAgICAgICBz
dHJ1Y3QgcGFnZSAqYnVkZHk7DQo+ICsgICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gKw0K
PiArICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZmcmVlX2FyZWEtPmxvY2ssIGZsYWdzKTsNCj4g
Kw0KPiArICAgICAgIGlmIChjYWNoZV9yZWZpbGwpIHsNCj4gKyAgICAgICAgICAgICAgIHNldF9w
YWdlYmxvY2tfdW5tYXBwZWQocGFnZSk7DQo+ICsgICAgICAgICAgICAgICBmcmVlX2FyZWFbb3Jk
ZXJdLm5yX2NhY2hlZCsrOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHdoaWxlIChvcmRl
ciA8IE1BWF9PUkRFUiAtIDEpIHsNCj4gKyAgICAgICAgICAgICAgIGJ1ZGR5ID0gZmluZF91bm1h
cHBlZF9idWRkeV9wYWdlX3BmbihwYWdlLCBwZm4sDQo+IG9yZGVyLA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZidWRkeV9wZm4pOw0KPiAr
ICAgICAgICAgICAgICAgaWYgKCFidWRkeSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIGRlbF9wYWdlX2Zyb21fZnJlZV9saXN0KGJ1ZGR5
LCBvcmRlcik7DQo+ICsgICAgICAgICAgICAgICBjb21iaW5lZF9wZm4gPSBidWRkeV9wZm4gJiBw
Zm47DQo+ICsgICAgICAgICAgICAgICBwYWdlID0gcGFnZSArIChjb21iaW5lZF9wZm4gLSBwZm4p
Ow0KPiArICAgICAgICAgICAgICAgcGZuID0gY29tYmluZWRfcGZuOw0KPiArICAgICAgICAgICAg
ICAgb3JkZXIrKzsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICBzZXRfdW5tYXBwZWRfb3Jk
ZXIocGFnZSwgb3JkZXIpOw0KPiArICAgICAgIGFkZF90b19mcmVlX2xpc3QocGFnZSwgb3JkZXIp
Ow0KPiArICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmZyZWVfYXJlYS0+bG9jaywgZmxh
Z3MpOw0KPiArfQ0KPiArDQoNClRoZSBwYWdlIGhhcyB0byBiZSB6ZXJvZWQgYmVmb3JlIGl0IGdv
ZXMgYmFjayBvbiB0aGUgbGlzdCwgcmlnaHQ/IEkNCmRpZG4ndCBzZWUgaXQuDQo=
