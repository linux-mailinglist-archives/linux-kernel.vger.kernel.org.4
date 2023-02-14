Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76D86955DC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjBNBXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBNBXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:23:31 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074D8A5FE;
        Mon, 13 Feb 2023 17:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676337810; x=1707873810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pmK8ZOM9aInAnAC3oigByd8DwVSvcZrDItxcNTPegc4=;
  b=kYjc+FvKbjsqxFBGv6vZEBtswxfm7NzQMHl7xa0gF1VDq6kjr6RFe0PX
   EA3Vai/cIxUiTV2K9DEXAUtjEchnvzi1zAvniBdtBBx1hRgLe7vrM4uZw
   qqbDPvwUkBSnQWpSkLjY0ZYglXfANzduSHcBFoOCSbnjqWUj45QFBKJY3
   1+t89qYx5Wa/jFUVE9Gu/Q8YO57MPSc9r5jloOsUiefxVF4MaNTHDTX3+
   D1SiSuyebLDRySbQ4ftoX0xegPfCqd6dIBcHo7yf3CGfHkEGHaob8sOGN
   j2/0ZnJPeGFEwtHWksbSq3rBKqDNAtoxMGBalg244fJRx6ZEXqJwj4dAi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="332360535"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="332360535"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 17:23:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="618848615"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="618848615"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2023 17:23:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 17:23:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 17:23:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 17:23:28 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 17:23:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zr/vSESiQ15pvATd6/iQjaYcSWAF7N1Jt0l1dSUEiBXFegWJ74Am1oCmU6g5Q3xPPKgGcBORZHj/vh9SZ29wxaf4MtSiLLJhtDozsgZbXuoPcNgecJwAca7epUCk+iQBv4kFvIqMOK+aXllGc9LDsywxQchAKK5NiIr/KyCWbS4Ujf/jOCGLP5bGSaOzexg6w9NJUrZsjJtOnWB8YsgFcd0DdYCos014QA/vGJHic44QFal1qWF0A6PAjxy5IM0lacKfixpIIflxPCCPchf1CqhZcNK6yoGawnlUDN4KJvS0l0s5D04Qjq43hfIZTOz7b/QVlI8p+NHYCXYNUDpAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmK8ZOM9aInAnAC3oigByd8DwVSvcZrDItxcNTPegc4=;
 b=jGIg3npJ23qi2hNg62WRUm7xa9J+Kh9isqjUJTxoP//bugtyyAMbWZNxre14iBxwtQ364Vcpf+GK+urAvRfRqnFfEuBUxFcepMNzQOGq0XP/hVdkOsHxxLwfp13dyY1mAnm5YEHdz+/VlpPIT0IjqtdrV2Ys1iVRjs+a+MyHyySNKtEFnGGh+pFCzF4IPuirmHwBL1Yh7DKEvwaEdCOzZ/OYMp4R6PmonP4dME5ThFB6WuBpcvAj0tDSdNJE/h2e77wP6Old5e4DA8YBISkieawN4kpbWEush1MUiO6zUwnzavQuprETneL9dmS4XnxBLcTm3AJXEcg4EgOw0FL/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6503.namprd11.prod.outlook.com (2603:10b6:8:8c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 01:23:26 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3f19:b226:ebf1:b04a]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3f19:b226:ebf1:b04a%7]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 01:23:26 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "jarkko@kernel.org" <jarkko@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: Re: [PATCH 23/24] Documentation: x86: correct spelling
Thread-Topic: [PATCH 23/24] Documentation: x86: correct spelling
Thread-Index: AQHZPFY8O9KL2OTX/E6LP2NYj3O6Na7HjlGAgAYe3IA=
Date:   Tue, 14 Feb 2023 01:23:25 +0000
Message-ID: <7cf8ceb4ceaf92d3f4da9e6dbb1b88a3eca1c9f7.camel@intel.com>
References: <20230209071400.31476-1-rdunlap@infradead.org>
         <20230209071400.31476-24-rdunlap@infradead.org>
         <Y+XAKUjZQRByJJyL@kernel.org>
In-Reply-To: <Y+XAKUjZQRByJJyL@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB6503:EE_
x-ms-office365-filtering-correlation-id: 152fbcd8-02d1-4973-11b2-08db0e2a1233
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YAmJvK6zIY1paGsvy/r1TXsglhjyeqFAM4kE6n2lCkBrFewz8spJP1HX3xx/kLoOR0L1YWrNlGlJ7B+WUI8py7c9DoZ0ff3iDCkO97aExqW471fmb2qiUfVqvWlSPPxQwvhiDoeKqmXS4H1mPVJfNiBv5kX3q9IxGB36zWdmSDLBrYWcNzKNeMfXthx5UJKBoZ1S++wg8ab/YtM6Zl/iI7WR6DAQjQXctfLXiRUXJpg9JAWwQC7Vb1lSf3td/wdIAguv3wY7GKv6Ch6Cm5GZ5JuG78ul0WwKlHW0rmzd/LmOr9gCk4NvTxFFUEsOynedeyPvn9ptSSAJ4P/skHMQObY8AdTGz9La/Xxx4+pLoye/efNKowxK8sG0ooHeSeZ4nnejZI8zioFRYAEDdSIlXiFOj++IE87LFzdZNf0o7AOSieVhrIlHH5iHh8yHPjjwWq8GWEDDmC0NKV5z+oAkiG7/k6fYsv9ta7Dt6wuAcHoPTs5QuFLPt4PGZN2pKxqfgzgQvmTahsivmdE3YgHK0hBDucxujRwoJR7cERW/g0GmxAVZcBSx1x8NRT/9VXvBxQIimDqyMNdox8J40oaQNN61YWX0OsoCOnXC/9y7cL2njvGd+hym8hHF946V6ns2SThIguuIrznV/EWDuKg2sxRJrxgID5jIQfGvHWqWrWG/BU9qpzV1onmj0p3nDT81tS6dmDeZtoaB8X/+9WLftg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199018)(2906002)(4744005)(7416002)(5660300002)(8936002)(41300700001)(66946007)(4326008)(91956017)(66446008)(66476007)(64756008)(66556008)(76116006)(8676002)(316002)(110136005)(6506007)(54906003)(478600001)(6486002)(6512007)(26005)(71200400001)(36756003)(107886003)(186003)(83380400001)(38100700002)(122000001)(86362001)(2616005)(82960400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUN5MFE2bE5ORzlOMlZlQlRPcXpwQ0xOcFlGallldVN5VmJ4ZEdoTmp5WEJE?=
 =?utf-8?B?bmEwUWRFNDVUeFh2UmRvYXJzNXlzWHY2WnhCZlU3QktBV2pxQVFkZkN1cnhZ?=
 =?utf-8?B?WHVKVkJTbWFxMDlpUnpTREd6eThrRW5tdXVTSWJmWXJLd3FSd21KbTBjQmNS?=
 =?utf-8?B?dUkvVFN2eDQwL04xWjVvM3lJZGV4U2dibDdsZkNjMjhHRHZqNytNRHJtRytZ?=
 =?utf-8?B?em9xSGw3NFVtdFdtTFVjNFE3Q1Zrd25idmRBcGJocEM0L2JLQmdTU0UzYXJ1?=
 =?utf-8?B?Q3d0M3JROTVDNDc3bHFLOUQ3MndDaUIvbFJjVE93Y2tiZTBJZ0kxaVhLNTdY?=
 =?utf-8?B?R1BDR3k0U0xqU1lOc3pZZlhQUURPNjM5Q28yNEp6VUQ5Q0trd3dGOXZkWTJh?=
 =?utf-8?B?VE4zdXdSaUFDcXd5dUxxMVUzMDZEYlBlUERKQno2R0Q4UmcvSGdZUmU4NEZL?=
 =?utf-8?B?d1VlZHc1dzRjanVrZ0VjQmJiWC9pVlZEWEFabXl4TER5dFVsVTh1WnNzTVpI?=
 =?utf-8?B?MkcyOFdFaUN3ak1HMCt3YmQ1MHA2WGFCZVdYdm9mQ2E4RkNWcGxzYTloVWNw?=
 =?utf-8?B?eFErT0lldFc3Y3hCNDlWSGVIVHNxclUrZUpaM1dudFlnSkE0QXQ2ZzJHVmJU?=
 =?utf-8?B?bUo4VHRreHRESjlnVW8xeDdFTUJDOGpGQmV1Zk9TTDQ5VWdvSmdqRWRZWnYz?=
 =?utf-8?B?L25jU2hYbzcyWEI2L2RyaGRLREFCRk4wd0IyWER5bS9WMWdHYlJWYm1wU0c0?=
 =?utf-8?B?aDcrQmRyelA5S1BURkZ6TjZ5cDJhVmMzWWh4cW5jYk44ZjNzV2pLL2RXcFdV?=
 =?utf-8?B?TmdYY2F1akJUbFNwVWM4TzdxTXpqc1lBS3NSa1JQT09UQ3l6YlE1dDJrMHpY?=
 =?utf-8?B?THdsZit4ZUJmemV4dTdQRW5LTlRrQ1BaUEprTWpOY2xzQ05RanA4ZVE2di9h?=
 =?utf-8?B?WjRRcHJzbHlESWlHN3NqTDhLRTdId2dBS1hpaVhoRWpsWmhxaUY4VnIzMkNU?=
 =?utf-8?B?ejludFdNTE43cC9iT2d1TExEb2s3eHpRUk5NTDBLRk1WM2pQWkNITWcyN0dz?=
 =?utf-8?B?YlRnQTlscFFMY25oVFZiRkZ6M0lDUDE1QkMzVWxjM3Z1eWI5UXZxZWRvZHZu?=
 =?utf-8?B?ZkM5MHVyNmFDMWFndVI5ZVI4TVV3ZmIyRVN1SS9UQ3NxSlJNY1dYQXozcFNB?=
 =?utf-8?B?K0p1U1h0ZDdIREc3SmpzM3NETkZjclJqNG51MW1Ld2N3bGgvUlZVSkUzNmo4?=
 =?utf-8?B?bDdzOThDdTZTMU11UzBzcWdWWXlBNHZla2t2S3RodmJnbkdDZ25zOW9MN09T?=
 =?utf-8?B?TVAzeHhOYy82dVg5MlJuczRpSXQ4Yi9hTWxSNDRJRFVqdEVPNXRlNTFySko2?=
 =?utf-8?B?dmEvNHRLQWUzS0tOYkNrZGZGWk1OM1FDL0NmelJJV2hrYTBPMzFJS3BZMTBk?=
 =?utf-8?B?dXB1T3YvemJhaGttdHY2RmVwd3RQanBjVlFZQ3pGRXR1VmV3eGhqOUovQ2Zy?=
 =?utf-8?B?Y2JlQ21jS0dhS3M0YkxBajFpOGdyNHF1cHQ4bHdTQUVVV0dyU3VpMnM3dHRE?=
 =?utf-8?B?MCtRNE5uWmdaU0JwODF4c1RxK1pONktvQ1RQdFJlVFhpYWMyNU56dnJFZWtH?=
 =?utf-8?B?dHhvOVY4aGRBeC90V3lGMnU1bGRON2lqN1hIYXcrMnBid0d5ak5ibHE5U0sv?=
 =?utf-8?B?cGFjNG13OHN0U1RUcVMreHdaY3R0TFcrKzV6cFV4KzhhMVdvVXNieWdrK3Z5?=
 =?utf-8?B?SXFEazAxL3ljN0JEaGI0b09WL25yR2ZGUkxmRk0rV3phZ3JSNE1iZlZvRjlE?=
 =?utf-8?B?Y24rVnFBQVk1SzhlNEJGeEFySVd5OGZFYzhzMzc5NXJDNGdZdHlSM1ZJSklq?=
 =?utf-8?B?YnovK2t4enNjcm1RTi9oVHBjOWhKLy9HWWZEOUF0SUpQRmVLb0kyZnZGb1Ux?=
 =?utf-8?B?aHRrc0Z6Sy9pQS9ITHBxdGtTdG0xRG5CS3RBdVQxUENQUGdDLzVucmpVZWEx?=
 =?utf-8?B?bHpvY0FtaC9CY2dTSjh5QWljMkJLTmIwL1V5U1BYazNCc0JMK2VISE04S1ZO?=
 =?utf-8?B?dGhlSlFyM0N3SEc1WThSM1o5MHZVTzhyb0U2QmlpdW0xcmoyMm80R1p0dFEz?=
 =?utf-8?B?R25jWTJZaUViYmE3QmE5UVc0VVlqRUdjSmNvSGpYOGFZSlQ3enFDSFBmRm90?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6A90FD73040DD42AB88737964C87856@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152fbcd8-02d1-4973-11b2-08db0e2a1233
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 01:23:25.9496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MTSMvkSX2HOsCfLICREDJnqGL0uwzhpOeYzfqYtjNAhLlqYSKcU23IRp829e5EjXCwoOZRtcvkAXtwW/mLLQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6503
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gZGlmZiAtLSBhL0RvY3VtZW50YXRpb24veDg2L3NneC5yc3QgYi9Eb2N1bWVudGF0aW9u
L3g4Ni9zZ3gucnN0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi94ODYvc2d4LnJzdA0KPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24veDg2L3NneC5yc3QNCj4gPiBAQCAtMjQ1LDcgKzI0NSw3IEBAIFNH
WCB3aWxsIGxpa2VseSBiZWNvbWUgdW51c2FibGUgYmVjYXVzZQ0KPiA+ICBsaW1pdGVkLiBIb3dl
dmVyLCB3aGlsZSB0aGlzIG1heSBiZSBmYXRhbCB0byBTR1gsIHRoZSByZXN0IG9mIHRoZSBrZXJu
ZWwNCj4gPiAgaXMgdW5saWtlbHkgdG8gYmUgaW1wYWN0ZWQgYW5kIHNob3VsZCBjb250aW51ZSB0
byB3b3JrLg0KPiA+ICANCj4gPiAtQXMgYSByZXN1bHQsIHdoZW4gdGhpcyBoYXBwcGVucywgdXNl
ciBzaG91bGQgc3RvcCBydW5uaW5nIGFueSBuZXcNCj4gPiArQXMgYSByZXN1bHQsIHdoZW4gdGhp
cyBoYXBwZW5zLCB0aGUgdXNlciBzaG91bGQgc3RvcCBydW5uaW5nIGFueSBuZXcNCj4gPiAgU0dY
IHdvcmtsb2FkcywgKG9yIGp1c3QgYW55IG5ldyB3b3JrbG9hZHMpLCBhbmQgbWlncmF0ZSBhbGwg
dmFsdWFibGUNCj4gPiAgd29ya2xvYWRzLiBBbHRob3VnaCBhIG1hY2hpbmUgcmVib290IGNhbiBy
ZWNvdmVyIGFsbCBFUEMgbWVtb3J5LCB0aGUgYnVnDQo+ID4gIHNob3VsZCBiZSByZXBvcnRlZCB0
byBMaW51eCBkZXZlbG9wZXJzLg0KPiANCj4gDQo+IEFja2VkLWJ5OiBKYXJra28gU2Fra2luZW4g
PGphcmtrb0BrZXJuZWwub3JnPg0KPiANCj4gQlIsIEphcmtrbw0KDQpGb3IgU0dYIHBhcnQ6DQoN
CkFja2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
