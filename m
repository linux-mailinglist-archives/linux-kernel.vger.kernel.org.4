Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9911C676280
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjAUAir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjAUAip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:38:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA4EFF34;
        Fri, 20 Jan 2023 16:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674261524; x=1705797524;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5ftsI4FG20GF/VH1nh7QAMzNEZzZh9cbIze6VJOP3rE=;
  b=ltM01OKED9TnhlyrT3N6tj/rMWPYOagZzttf3HiTvAxNQQ3tzdVHrDBK
   mF0xQz2fdetYzAkyCcREoUuEX/6Gq6aNYerhKjvVg4N79lAeOR9jGtXO5
   IXHUg5F/+oRlJp+v9TE8YAgLNbYsAPf8sPvJ+HJ1fdNEPYNGWRjbIHzBT
   1/cc9G1Oglil5EcooDUUhFXvi0evJl6ajsTV84bOGjZka8R2+aFnRp8IO
   2tYh2eC5Yfg3hZQ6LytPG4qPWQ0QXII6xd9KHtFyBjYzZeRfmKKt3Ui5E
   NHDwpIFcOlpr1l2eq9aVrXe4hwMStTk3XuYE+QXfOCP/UWch5kr9Xk+H8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="306096120"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="306096120"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 16:38:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="803256717"
X-IronPort-AV: E=Sophos;i="5.97,233,1669104000"; 
   d="scan'208";a="803256717"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2023 16:38:44 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 16:38:43 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 16:38:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 16:38:43 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 16:38:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo9/40JzYaAnkT0y22sogx3NmuXNPEwpHLjqh+3GfqN/iBp4QB438UnfT4G7q5X1iic4Xu4zkN4+p/5TfwcwSrmQv/gvTJnGiT5wF8sQ7Bl5ZuPthkaZWDKBDtJvY2HphG+VVtxrUgHO1CGUBJ+KQ+LB91iSYlvIaqXryiJ4Qw10Lu5Crf3lrB2cflIUXN/WPLWlw6DjILSJXjfEqnB86zcFVE/Wuxz+Xf+PI90DKq0D7u7YQF66jvS4RLlUR9U/Bz23+GNh4skhjSr3WSWcIAb27McKSMIq3gb+mhsikcIJOqQCTj5Eu2lFRg3WswmfqQqHn/dgLI1CC/yFMwEtKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ftsI4FG20GF/VH1nh7QAMzNEZzZh9cbIze6VJOP3rE=;
 b=FbB1bSsDyVkXS/z9WysJ1yKckqSUY9YI/FYMPzpORNTavdq5LcFI47Zn6A0jTq3qcxwSJ5peV+WUNg5VRdxZ6Y2n7QEdqh6jLudFBX+Sw4gGeCBmZpXNegd+vLi2exfqkUjOscxu0PwOVv0wT0yXQUWeMin93pbG4v5kaBjgXn8MogwbgsiFJRp95Bqo27A3wFaeQz08i46motk5QTiKxSJxO1RFGmSuTX2WJX4UqfumeunTzYMsEbiosIAGxU+lmIFyrRBFiE4/8hECb6rkJed8Gd3NgAaOCTz0x8btt3TDU9uK3oR9JANJULOafx+xKjwXWIMGkr1JYt8zUJVUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB4773.namprd11.prod.outlook.com (2603:10b6:510:33::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Sat, 21 Jan
 2023 00:38:35 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%5]) with mapi id 15.20.6002.027; Sat, 21 Jan 2023
 00:38:35 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Thread-Topic: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Thread-Index: AQHZKxIPnor+2NW260uOVFogeINpU66keT4AgAIrWoCAAAaHkIAAEYQAgAA0PCCAAF7AgIAArgAA
Date:   Sat, 21 Jan 2023 00:38:35 +0000
Message-ID: <PH0PR11MB58803DFEDD61EE66AF49074EDACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <PH0PR11MB5880A16045A842AB80A25C4BDAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <B3E458A6-9279-4716-B242-873C77EC1E3A@joelfernandes.org>
In-Reply-To: <B3E458A6-9279-4716-B242-873C77EC1E3A@joelfernandes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH0PR11MB4773:EE_
x-ms-office365-filtering-correlation-id: afe93436-483b-448e-1342-08dafb47d4da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pnuvg4YOTV7hP2kzBhiDf98zAE5DBM7ZUwIe1dKgGsQm4DAnbsO0c/gOzqRsHAkcwSt2xf5zM5Uar4OuhghFo3ALfq4NOwTWWX3DAZ/CsKJxZpQ/AwX1eK60Ddtp3tO1/2IXaXnN4U/wzWcH0W2Rf43cKHgo0wJusWrxzo/lL43zDGKTFS6M/4+ZmTttcrF+PKLUSOWNlTh1vluIqGuR/FsmnnzXwdtQjLXtDkxHVuVm9ES+d0KlHNBSnOsdVjvpZxXhoKWZgzWOa/WEoOcQ9grUPo76lOM2y2oV1jERI4eKeE938W2R52dLi2vnU69x2IAJ8a5J6TE5U4AcndeEQJtzwXmbMgX+VQ2lKVv+4b9Ed6pOhuLvEesCHhBfCV+TSKIfMaBqzmTxRXM8/Pj9Ydp526u0Rp4T760TO/jXiASaktvumgBst8pG6QXM5/TFWNWpr5r1Y3ga1qSXBeY6AbofWagAORoc9CV508sRDLOo1kS8Gvr40hHiuc4rUVZ/MH/a126abWLKm/itrks1Jf29OXIFulj5Bs1Rh8tgn0bLxHGjs9LZetsHs1g4Q1aqhDEDbEWcQYqIsfTaxcjv7eTaTq1KyGx0Rs/qAIdo75L3BNAO8oEo4yG2/ldKdEoBhk/zXkcQD4T+AIkoFGEksImCYPG+GbSjWc/oHzS9q2r21HxS+SZvYnKydhNOonP60d6WHNd6uSKAetf0i4JMYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199015)(71200400001)(5660300002)(8936002)(4326008)(66446008)(8676002)(6916009)(64756008)(66476007)(66946007)(66556008)(52536014)(76116006)(38100700002)(53546011)(122000001)(6506007)(186003)(9686003)(2906002)(54906003)(26005)(7696005)(316002)(478600001)(83380400001)(66899015)(41300700001)(82960400001)(38070700005)(55016003)(86362001)(66574015)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFFxRXJpajRYUU5OaEMvbzJjUUE0QTdOVTN3NmxsNGtRbUZXaDVxTTNHaThK?=
 =?utf-8?B?bmhBNFgweWlSeDZUQm5SNFNFTXpFcUFaLzBuaFFIYU5ScDV5aUVtZ1VaZnV2?=
 =?utf-8?B?dU9DcU52Ky9mb2txMTVKNnl2K2tpNG0rUStyRWdTS3A3TlNhWEI3dnpIM0Jo?=
 =?utf-8?B?Y3dlZ2JPMlVOZVByNUlGU3drYmxKVFBnejVFMWwzVFZMYVBGelZQV1dTSXBh?=
 =?utf-8?B?K2tERW51bVRTQ0toaVUzaE9sS0J0d203OERBMkJERnh3dEoyU21YcTh0eDNP?=
 =?utf-8?B?bThSZzNDSkU4UWFsR3NtYWpoaStOeWpvem5Uc1luUDBqWktyUURnQWlDd0dB?=
 =?utf-8?B?dzZkSmZ1c1VtNGxTUnA0cmpYTjdVeEFrK043N25ReWFha0xwN3lhUWtGcFdq?=
 =?utf-8?B?czVKWkgxTEFQamxEUmszeFMxQ3JDTjBKNm1IWjcxVm9oU21oRDdGU3FGblNE?=
 =?utf-8?B?MDhtYk1WYWdwMkU0OWJYeHNXQmVwcHZ0MVJocmxYb1Z6YzBJcDBvMFJ1alRC?=
 =?utf-8?B?bkpTa1BGazJSYkNlWUhWYjJhblVlN0Jmd1h5bWpyWkRtRzhXUDZwTEVQOE9a?=
 =?utf-8?B?dzFJOEVMY0RkZFBRbFhsNmFucTVLeEdVU1lzdGtYUHgxdTVJYlducnlFWHBH?=
 =?utf-8?B?WXBHZ2JnbzFoWEpIVUsxbndpZEVXQTBsQnBBWmhmeUdQalFscVdPelF4dlVD?=
 =?utf-8?B?bElrcllZbzJlUGluREc5RVlwU2JqVDRtNndJR2JLRmJhNW5UTWVFdE8vTVZW?=
 =?utf-8?B?UWZZTkVTYVVHdlA2L3hheElKVnRxV3cyR2VvMlkyQlNWSzN4cGQzTjVBaDhI?=
 =?utf-8?B?RmJMdDVXZHlVQ1VFUzVuN1pGY1hqa1doY2tkaTFJTXEwbjRkYTVmT2tocmFq?=
 =?utf-8?B?eDVFZnFJdytVK3dnRExuMUNQa2l2OHhaekhKcUw3OFRCbjd5RnhuVkt6cGIz?=
 =?utf-8?B?MjZNSVpQWml2a2V0Sm84bURESzBqUGlSRkl1RTV1QnB0UlA5NFdLb2hqZURs?=
 =?utf-8?B?YWJBWnk5V25rbnp4YUYrOFFVcmg5ZU40bG9wbE02eUYxVEhieENnREZabEg0?=
 =?utf-8?B?bVVRYUtva0lXcUE3MzFseDhxSDJEYTZ3VFJkcjdkTUQ5T29mZzB1VjNyYSs0?=
 =?utf-8?B?VjlBQlFQRWFsRkQyeWV4VkpIR3JQV0FCOWxTZVpqYlN4amRuV3VwblpsVHZM?=
 =?utf-8?B?eUlubE9GRnZUdDlyS2F3blFHMDdMblNsRzNDa0VVdnlKbFVscWdtVGQyZUY2?=
 =?utf-8?B?TDd1RytCb1RmTzZHbmo2UVZmNmU4dVMwQTBpTFRIZm4yTFg4d2s0eFF3dWpC?=
 =?utf-8?B?bVUweTdZWnZWVktwemlOYkhEK09ISndsK1d0L2dubllHMmZJMzV4b3pkMGts?=
 =?utf-8?B?YlZ0TS9uYUhvSnhQcVFXNk10OGlUYWJZNmUyNzBOUWhJaXBBcnZxTFRra082?=
 =?utf-8?B?TzRBa1V6dk8wLzh1OTJ0UjZVUk9EYWZYeEhpWnVUdDQ5RnNuQzZqZnFVZDMy?=
 =?utf-8?B?YUN5aWFNaTE1eDZBQlUzOFY2OHVPVGFmcnpnTTFGbXEvYkRIcG5jUmVTSXR4?=
 =?utf-8?B?eFNCdUkyZ0tSelZTZGcyWHkvWU9OZlNEVm9mZ29wRE4wcEsvYkFYeXByTWxr?=
 =?utf-8?B?QTlrL0YveTVvdEFvWXVkQ1piYjQ5VjJJZEI0enZVUXIwYTNsL0ZzMXJ1UlUz?=
 =?utf-8?B?a2Z6S2ZOYWt6Z2IwN1FlbWcvMmMxa1o0elg3R2MvamtmekRQblVETjNMWUJx?=
 =?utf-8?B?NDZMS3lqS2VYS3VTRXpmK0lzMGJjK2VuNk9LVDgydlhMTnkrZWVRU1pUWW5U?=
 =?utf-8?B?cUR4Qmg2aGVNS1NXL0lhLzZEN3ZjUVpxMW5ybzB1TmdHS0FROFFYaTZiUHI0?=
 =?utf-8?B?V1J5aDRkQmRtVXlBTENpYkxTT2t2QzJNQU1UMlU1cjV6a2hEYjlyblpFU3ZB?=
 =?utf-8?B?UkRQU2hCTDNzL3FaWTVXN3MrSy9RSTRNR0hzOFVneTBBcTFhVmpoNmtMTERZ?=
 =?utf-8?B?MThaekFvUEwxNUh4ZE5icUh5cmNrbEFaUWU2OVZ5SWpEZTBXK0FZaENpd1RR?=
 =?utf-8?B?OXE1dWtRUVU4dzNKbmREcGlUQTRqcHQrNjBiSlB0aGlkR2lwUEFPb2pZYXla?=
 =?utf-8?Q?a1g+kyC9ocQ3MBe/+X/hdxeWz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe93436-483b-448e-1342-08dafb47d4da
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 00:38:35.8032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uhGCEzgNqKEeXQiHkfcLEm3XxLrmDapAPyo1Kx8bfKKFbgqV55IlGiJW8gN4fUR4Le6eaKV57K6++HlprJShpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4773
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

DQo+IE9uIEphbiAyMCwgMjAyMywgYXQgMzoxOSBBTSwgWmhhbmcsIFFpYW5nMSA8cWlhbmcxLnpo
YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu78NCj4+IA0KPj4gDQo+Pj4+IE9uIFdlZCwg
SmFuIDE4LCAyMDIzIGF0IDAzOjMwOjE0UE0gKzA4MDAsIFpxaWFuZyB3cm90ZToNCj4+Pj4+IFdo
ZW4gaW5vdmtlIHJjdV9yZXBvcnRfcXNfcmRwKCksIGlmIGN1cnJlbnQgQ1BVJ3MgcmN1X2RhdGEg
c3RydWN0dXJlJ3MgLT4NCj4+Pj4+IGdycG1hc2sgaGFzIG5vdCBiZWVuIGNsZWFyZWQgZnJvbSB0
aGUgY29ycmVzcG9uZGluZyByY3Vfbm9kZSBzdHJ1Y3R1cmUncw0KPj4+Pj4gLT5xc21hc2ssIGFm
dGVyIHRoYXQgd2lsbCBjbGVhciBhbmQgcmVwb3J0IHF1aWVzY2VudCBzdGF0ZSwgYnV0IGluIHRo
aXMNCj4+Pj4+IHRpbWUsIHRoaXMgYWxzbyBtZWFucyB0aGF0IGN1cnJlbnQgZ3JhY2UgcGVyaW9k
IGlzIG5vdCBlbmQsIHRoZSBjdXJyZW50DQo+Pj4+PiBncmFjZSBwZXJpb2QgaXMgb25nb2luZywg
YmVjYXVzZSB0aGUgcmN1X2dwX2luX3Byb2dyZXNzKCkgY3VycmVudGx5IHJldHVybg0KPj4+Pj4g
dHJ1ZSwgc28gZm9yIG5vbi1vZmZsb2FkZWQgcmRwLCBpbnZva2UgcmN1X2FjY2VsZXJhdGVfY2Jz
KCkgaXMgaW1wb3NzaWJsZQ0KPj4+Pj4gdG8gcmV0dXJuIHRydWUuDQo+Pj4+PiANCj4+Pj4+IFRo
aXMgY29tbWl0IHRoZXJlZm9yZSByZW1vdmUgaW1wb3NzaWJsZSByY3VfZ3Bfa3RocmVhZF93YWtl
KCkgY2FsbGluZy4NCj4+Pj4+IA0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZzEu
emhhbmdAaW50ZWwuY29tPg0KPj4+Pj4gUmV2aWV3ZWQtYnk6IEZyZWRlcmljIFdlaXNiZWNrZXIg
PGZyZWRlcmljQGtlcm5lbC5vcmc+DQo+Pj4gDQo+Pj4gUXVldWVkICh3b3Jkc21pdGhlZCBhcyBz
aG93biBiZWxvdywgYXMgYWx3YXlzLCBwbGVhc2UgY2hlY2spIGZvciBmdXJ0aGVyDQo+Pj4gdGVz
dGluZyBhbmQgcmV2aWV3LCB0aGFuayB5b3UgYm90aCENCj4+PiANCj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRoYW54LCBQYXVsDQo+Pj4g
DQo+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4gDQo+Pj4gY29tbWl0IGZiZTNlMzAwZWM4YjNlZGQy
YjhmODRkYWI0ZGM5ODk0N2NmNzFlYjgNCj4+PiBBdXRob3I6IFpxaWFuZyA8cWlhbmcxLnpoYW5n
QGludGVsLmNvbT4NCj4+PiBEYXRlOiAgIFdlZCBKYW4gMTggMTU6MzA6MTQgMjAyMyArMDgwMA0K
Pj4+IA0KPj4+ICAgIHJjdTogUmVtb3ZlIG5ldmVyLXNldCBuZWVkd2FrZSBhc3NpZ25tZW50IGZy
b20gcmN1X3JlcG9ydF9xc19yZHAoKQ0KPj4+IA0KPj4+ICAgIFRoZSByY3VfYWNjZWxlcmF0ZV9j
YnMoKSBmdW5jdGlvbiBpcyBpbnZva2VkIGJ5IHJjdV9yZXBvcnRfcXNfcmRwKCkNCj4+PiAgICBv
bmx5IGlmIHRoZXJlIGlzIGEgZ3JhY2UgcGVyaW9kIGluIHByb2dyZXNzIHRoYXQgaXMgc3RpbGwg
YmxvY2tlZA0KPj4+ICAgIGJ5IGF0IGxlYXN0IG9uZSBDUFUgb24gdGhpcyByY3Vfbm9kZSBzdHJ1
Y3R1cmUuICBUaGlzIG1lYW5zIHRoYXQNCj4+PiAgICByY3VfYWNjZWxlcmF0ZV9jYnMoKSBzaG91
bGQgbmV2ZXIgcmV0dXJuIHRoZSB2YWx1ZSB0cnVlLCBhbmQgdGh1cyB0aGF0DQo+Pj4gICAgdGhp
cyBmdW5jdGlvbiBzaG91bGQgbmV2ZXIgc2V0IHRoZSBuZWVkd2FrZSB2YXJpYWJsZSBhbmQgaW4g
dHVybiBuZXZlcg0KPj4+ICAgIGludm9rZSByY3VfZ3Bfa3RocmVhZF93YWtlKCkuDQo+Pj4gDQo+
Pj4gICAgVGhpcyBjb21taXQgdGhlcmVmb3JlIHJlbW92ZXMgdGhlIG5lZWR3YWtlIHZhcmlhYmxl
IGFuZCB0aGUgaW52b2NhdGlvbg0KPj4+ICAgIG9mIHJjdV9ncF9rdGhyZWFkX3dha2UoKSBpbiBm
YXZvciBvZiBhIFdBUk5fT05fT05DRSgpIG9uIHRoZSBjYWxsIHRvDQo+Pj4gICAgcmN1X2FjY2Vs
ZXJhdGVfY2JzKCkuICBUaGUgcHVycG9zZSBvZiB0aGlzIG5ldyBXQVJOX09OX09OQ0UoKSBpcyB0
bw0KPj4+ICAgIGRldGVjdCBzaXR1YXRpb25zIHdoZXJlIHRoZSBzeXN0ZW0ncyBvcGluaW9uIGRp
ZmZlcnMgZnJvbSBvdXJzLg0KPj4+IA0KPj4+ICAgIFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlh
bmcxLnpoYW5nQGludGVsLmNvbT4NCj4+PiAgICBSZXZpZXdlZC1ieTogRnJlZGVyaWMgV2Vpc2Jl
Y2tlciA8ZnJlZGVyaWNAa2VybmVsLm9yZz4NCj4+PiAgICBTaWduZWQtb2ZmLWJ5OiBQYXVsIEUu
IE1jS2VubmV5IDxwYXVsbWNrQGtlcm5lbC5vcmc+DQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9yY3UvdHJlZS5jIGIva2VybmVsL3JjdS90cmVlLmMNCj4+PiBpbmRleCBiMmMyMDQ1Mjk0
NzgwLi43YTMwODVhZDBhN2RmIDEwMDY0NA0KPj4+IC0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jDQo+
Pj4gKysrIGIva2VybmVsL3JjdS90cmVlLmMNCj4+PiBAQCAtMTk1Niw3ICsxOTU2LDYgQEAgcmN1
X3JlcG9ydF9xc19yZHAoc3RydWN0IHJjdV9kYXRhICpyZHApDQo+Pj4gew0KPj4+ICAgICAgdW5z
aWduZWQgbG9uZyBmbGFnczsNCj4+PiAgICAgIHVuc2lnbmVkIGxvbmcgbWFzazsNCj4+PiAtICAg
ICBib29sIG5lZWR3YWtlID0gZmFsc2U7DQo+Pj4gICAgICBib29sIG5lZWRhY2MgPSBmYWxzZTsN
Cj4+PiAgICAgIHN0cnVjdCByY3Vfbm9kZSAqcm5wOw0KPj4+IA0KPj4+IEBAIC0xOTg4LDcgKzE5
ODcsMTIgQEAgcmN1X3JlcG9ydF9xc19yZHAoc3RydWN0IHJjdV9kYXRhICpyZHApDQo+Pj4gICAg
ICAgICAgICAgICAqIE5PQ0Iga3RocmVhZHMgaGF2ZSB0aGVpciBvd24gd2F5IHRvIGRlYWwgd2l0
aCB0aGF0Li4uDQo+Pj4gICAgICAgICAgICAgICAqLw0KPj4+ICAgICAgICAgICAgICBpZiAoIXJj
dV9yZHBfaXNfb2ZmbG9hZGVkKHJkcCkpIHsNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgbmVl
ZHdha2UgPSByY3VfYWNjZWxlcmF0ZV9jYnMocm5wLCByZHApOw0KPj4+ICsgICAgICAgICAgICAg
ICAgICAgICAvKg0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgKiBUaGUgY3VycmVudCBHUCBo
YXMgbm90IHlldCBlbmRlZCwgc28gaXQNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICogc2hv
dWxkIG5vdCBiZSBwb3NzaWJsZSBmb3IgcmN1X2FjY2VsZXJhdGVfY2JzKCkNCj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICogdG8gcmV0dXJuIHRydWUuICBTbyBjb21wbGFpbiwgYnV0IGRvbid0
IGF3YWtlbi4NCj4+PiArICAgICAgICAgICAgICAgICAgICAgICovDQo+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgIFdBUk5fT05fT05DRShyY3VfYWNjZWxlcmF0ZV9jYnMocm5wLCByZHApKTsNCj4+
PiAgICAgICAgICAgICAgfSBlbHNlIGlmICghcmN1X3NlZ2NibGlzdF9jb21wbGV0ZWx5X29mZmxv
YWRlZCgmcmRwLT5jYmxpc3QpKSB7DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgLyoNCj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgKiAuLi5idXQgTk9DQiBrdGhyZWFkcyBtYXkgbWlzcyBvciBk
ZWxheSBjYWxsYmFja3MgYWNjZWxlcmF0aW9uDQo+Pj4gQEAgLTIwMDAsOCArMjAwNCw2IEBAIHJj
dV9yZXBvcnRfcXNfcmRwKHN0cnVjdCByY3VfZGF0YSAqcmRwKQ0KPj4+ICAgICAgICAgICAgICBy
Y3VfZGlzYWJsZV91cmdlbmN5X3Vwb25fcXMocmRwKTsNCj4+PiAgICAgICAgICAgICAgcmN1X3Jl
cG9ydF9xc19ybnAobWFzaywgcm5wLCBybnAtPmdwX3NlcSwgZmxhZ3MpOw0KPj4+ICAgICAgICAg
ICAgICAvKiBeXl4gUmVsZWFzZWQgcm5wLT5sb2NrICovDQo+Pj4gLSAgICAgICAgICAgICBpZiAo
bmVlZHdha2UpDQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgIHJjdV9ncF9rdGhyZWFkX3dha2Uo
KTsNCj4+PiANCj4+PiBBRkFJQ1MsIHRoZXJlIGlzIGFsbW9zdCBubyBjb21waWxlciBiZW5lZml0
IG9mIGRvaW5nIHRoaXMsIGFuZCB6ZXJvIHJ1bnRpbWUNCj4+PiBiZW5lZml0IG9mIGRvaW5nIHRo
aXMuIFRoZSBXQVJOX09OX09OQ0UoKSBhbHNvIGludm9sdmVzIGEgcnVudGltZSBjb25kaXRpb24N
Cj4+PiBjaGVjayBvZiB0aGUgcmV0dXJuIHZhbHVlIG9mIHJjdV9hY2NlbGVyYXRlX2NicygpLCBz
byB5b3Ugc3RpbGwgaGF2ZSBhDQo+Pj4gYnJhbmNoLiBZZXMsIG1heWJlIHNsaWdodGx5IHNtYWxs
ZXIgY29kZSB3aXRob3V0IHRoZSB3YWtlIGNhbGwsIGJ1dCBJJ20gbm90DQo+Pj4gc3VyZSB0aGF0
IGlzIHdvcnRoIGl0Lg0KPj4+IA0KPj4+IEFuZCwgaWYgdGhlIG9waW5pb24gb2Ygc3lzdGVtIGRp
ZmZlcnMsIGl0cyBhIGJ1ZyBhbnl3YXksIHNvIG1vcmUgYWRkZWQgcmlzay4NCj4+PiANCj4+PiAN
Cj4+PiANCj4+PiAgICAgICAgICAgICAgaWYgKG5lZWRhY2MpIHsNCj4+PiAgICAgICAgICAgICAg
ICAgICAgICByY3Vfbm9jYl9sb2NrX2lycXNhdmUocmRwLCBmbGFncyk7DQo+Pj4gDQo+Pj4gQW5k
IHdoZW4gbmVlZGFjYyA9IHRydWUsIHJjdV9hY2NlbGVyYXRlX2Nic191bmxvY2tlZCgpIHRyaWVz
IHRvIGRvIGEgd2FrZSB1cA0KPj4+IGFueXdheSwgc28gaXQgaXMgY29uc2lzdGVudCB3aXRoIG5v
Y2IgdnMgIW5vY2IuDQo+PiANCj4+IEZvciAhbm9jYiwgd2UgaW52b2tlZCByY3VfYWNjZWxlcmF0
ZV9jYnMoKSBiZWZvcmUgcmVwb3J0IHFzLCAgc28gdGhpcyBHUCBpcyBpbXBvc3NpYmxlIHRvIGVu
ZA0KPj4gYW5kIHdlIGFsc28gbm90IHNldCBSQ1VfR1BfRkxBR19JTklUIHRvIHN0YXJ0IG5ldyBH
UCBpbiByY3VfYWNjZWxlcmF0ZV9jYnMoKS4NCj4+IGJ1dCBmb3Igbm9jYiwgd2hlbiBuZWVkYWNj
ID0gdHJ1ZSwgd2UgaW52b2tlIHJjdV9hY2NlbGVyYXRlX2Nic191bmxvY2tlZCgpIGFmdGVyIGN1
cnJlbnQgQ1BVDQo+PiBoYXMgcmVwb3J0ZWQgcXMsICBpZiBhbGwgQ1BVIGhhdmUgYmVlbiByZXBv
cnRlZCBxcywgIHdlIHdpbGwgd2FrZXVwIGdwIGt0aHJlYWQgdG8gZW5kIHRoaXMgR1AgaW4NCj4+
IHJjdV9yZXBvcnRfcXNfcm5wKCkuICAgYWZ0ZXIgdGhhdCwgdGhlIHJjdV9hY2NlbGVyYXRlX2Ni
c191bmxvY2tlZCgpIGlzICBwb3NzaWJsZSB0byB0cnkgdG8gd2FrZSB1cA0KPj4gZ3Aga3RocmVh
ZCBpZiB0aGlzIEdQIGhhcyBlbmRlZCBhdCB0aGlzIHRpbWUuICAgc28gbm9jYiB2cyAhbm9jYiBp
cyBsaWtlbHkgdG8gYmUgaW5jb25zaXN0ZW50Lg0KPj4gDQo+PiANCj4+IFRoYXQgaXMgYSBmYWly
IHBvaW50LiBCdXQgYWZ0ZXIgZ3AgZW5kcywgIHJjdV9jaGVja19xdWllc2NlbnRfc3RhdGUoKQ0K
Pj4gLT4gbm90ZV9ncF9jaGFuZ2VzKCkgd2hpY2ggd2lsbCBkbyBhIGFjY2VsICsgR1AgdGhyZWFk
IHdha2UgdXAgYXQgdGhhdA0KPj4gcG9pbnQgYW55d2F5LCBvbmNlIGl0IG5vdGljZXMgdGhhdCBh
IEdQIGhhcyBjb21lIHRvIGFuIGVuZC4gVGhhdA0KPj4gc2hvdWxkIGhhcHBlbiBmb3IgYm90aCB0
aGUgbm9jYiBhbmQgIW5vY2IgY2FzZXMgcmlnaHQ/DQo+IA0KPiBGb3Igbm9jYiByZHAsIHdlIHdv
bid0IGludm9rZSByY3VfYWNjZWxlcmF0ZV9jYnMoKSBhbmQgcmN1X2FkdmFuY2VfY2JzKCkgaW4N
Cj4gbm90ZV9ncF9jaGFuZ2VzKCkuICBzbyBhbHNvIG5vdCB3YWtldXAgZ3Aga3RocmVhZCBpbiBu
b3RlX2dwX2NoYW5nZXMoKS4gDQo+DQo+WWVzIGNvcnJlY3QsIG9rIGJ1dOKApg0KPiANCj4+IA0K
Pj4gSSBhbSB3b25kZXJpbmcgaWYgcmN1X3JlcG9ydF9xc19yZHAoKSBuZWVkcyB0byBiZSByZXRo
b3VnaHQgdG8gbWFrZQ0KPj4gYm90aCBjYXNlcyBjb25zaXN0ZW50Lg0KPj4gDQo+PiBXaHkgZG9l
cyB0aGUgbm9jYiBjYXNlIG5lZWQgYW4gYWNjZWwgKyBHUCB0aHJlYWQgd2FrZXVwIGluIHRoZQ0K
Pj4gcmN1X3JlcG9ydF9xc19yZHAoKSBmdW5jdGlvbiwgYnV0IHRoZSAhbm9jYiBjYXNlIGRvZXMg
bm90Pw0KPiANCj4gRm9yIG5vY2IgYWNjZWwgKyBHUCBrdGhyZWFkIHdha2V1cCBvbmx5IGhhcHBl
biBpbiB0aGUgbWlkZGxlIG9mIGEgKGRlLSlvZmZsb2FkaW5nIHByb2Nlc3MuDQo+IHRoaXMgaXMg
YW4gaW50ZXJtZWRpYXRlIHN0YXRlLg0KPg0KPlN1cmUsIEkga25vdyB3aGF0IHRoZSBjb2RlIGN1
cnJlbnRseSBkb2VzLCBJIGFtIGFza2luZyB3aHkgYW5kIGl0IGZlZWxzIHdyb25nLg0KPg0KPkkg
c3VnZ2VzdCB5b3Ugc2xpZ2h0bHkgY2hhbmdlIHlvdXIgYXBwcm9hY2ggdG8gbm90IGFzc3VtaW5n
IHRoZSBjb2RlIHNob3VsZCBiZSBib25hZmlkZSANCj5jb3JyZWN0IGFuZCB0aGVuIGZpeGluZyBp
dCAod2hpY2ggaXMgb2sgb25jZSBpbiBhIHdoaWxlKSwgYW5kIGFza2luZyBoaWdoZXIgbGV2ZWwg
cXVlc3Rpb25zDQo+dG8gd2h5IHRoaW5ncyBhcmUgdGhlIHdheSB0aGV5IGFyZSBpbiB0aGUgZmly
c3QgcGxhY2UgKHRoYXQgaXMganVzdCBteSBzdWdnZXN0aW9uIGFuZCBJIGFtIG5vdCBpbg0KPmEg
cGxhY2UgdG8gcHJvdmlkZSBhZHZpY2UsIGZhciBmcm9tIGl0LCBidXQgSSBhbSBqdXN0IHRlbGxp
bmcgeW91IG15IGFwcHJvYWNoIOKAlCBJIGNhcmUgbW9yZSBhYm91dA0KPnRoZSBjb2RlIHRoYW4g
aW5jcmVhc2luZyBteSBwYXRjaCBjb3VudCA6UCkuDQo+DQoNClRoYW5rcyBKb2VsLCB0aGlzIGlz
IGEgdXNlZnVsIHN1Z2dlc3Rpb24gZm9yIG1lLg0KDQo+DQo+SWYgeW91IGFyZSBpbiBhbiBpbnRl
cm1lZGlhdGUgc3RhdGUsIHBhcnQgd2F5IHRvIGEgIW5vY2Igc3RhdGUg4oCUIA0KPnlvdSBtYXkg
aGF2ZSBtaXNzZWQgYSBub2NiLXJlbGF0ZWQgYWNjZWwgYW5kIHdha2UsIGNvcnJlY3Q/IFdoeSBk
b2VzIHRoYXQgbWF0dGVyPyANCj5PbmNlIHdlIHRyYW5zaXRpb24gdG8gYSAhbm9jYiBzdGF0ZSwg
d2UgZG8gbm90IGRvIGEgcG9zdC1xcy1yZXBvcnQgYWNjZWwrd2FrZSBhbnl3YXkNCg0KU2hvdWxk
IGl0IGJlIHRyYW5zaXRpb24gdG8gYSAhbm9jYiBzdGF0ZSwgd2UgZG8gYSBwb3N0LXFzLXJlcG9y
dCBhY2NlbCt3YWtlLg0KDQo+YXMgd2UgY2xlYXJseSBrbm93IGZyb20gdGhlIGRpc2N1c3Npb24u
IFNvIHdoeSBkbyB3ZSBuZWVkIHRvIGRvIGl0IGlmIHdlIG1pc3NlZCBpdCBmb3INCj50aGUgaW50
ZXJtZWRpYXRlIHN0YWdlPyBTbywgSSBhbSBub3QgZnVsbHkgc3VyZSB5ZXQgd2hhdCB0aGF0IG5l
ZWRhYyBpcyBkb2luZyBhbmQgd2h5IGl0IGlzIG5lZWRlZC4NCg0KRm9yIGRlLW9mZmxvYWRpbmcs
IHdoZW4gaW4gdGhlIHByb2Nlc3Mgb2YgZGUtb2ZmbG9hZGluZyhyY3Vfc2VnY2JsaXN0X2NvbXBs
ZXRlbHlfb2ZmbG9hZGVkKCkgcmV0dXJuIGZhbHNlKSwNCndlJ3JlIG5vdCBkb2luZyBieXBhc3Mg
ZXZlbiB0aG91Z2ggdGhpcyByZHAgaXMgb2ZmbG9hZGVkIHN0YXRlKHJjdV9yZHBfaXNfb2ZmbG9h
ZGVkKHJkcCkgcmV0dXJuIHRydWUpLA0KYXQgdGhpcyB0aW1lLCB0aGUgcmN1b2cga3RocmVhZCBw
cm9iYWJseSB3b24ndCBhY2NlbCt3YWtldXAsIHNvIHdlIGRvIGFjY2VsK3dha2V1cCBpbiByY3Vf
cmVwb3J0X3FzX3JkcCgpLA0KYXMgeW91IHNheSB3aHkgZG9lcyB0aGF0IG1hdHRlcj8gIGZvciAh
bm9jYiBzdGF0ZSwgIHdlJ3ZlIGFsd2F5cyB0cmllZCB0byBhY2NlbCt3YWtldXAgYXMNCm11Y2gg
YXMgcG9zc2libGUoY29tcGFyZWQgdG8gbm9jYiksIGxldCByY3UgY2FsbGJhY2sgYmUgZXhlY3V0
ZWQgYXMgc29vbiBhcyBwb3NzaWJsZS4NCg0KVGhpcyBpcyBqdXN0IG15IHBlcnNvbmFsIG9waW5p
b24sIHBsZWFzZSBjb3JyZWN0IG1lIGlmIEkgYW0gd3JvbmcuDQoNClRoYW5rcw0KWnFpYW5nDQoN
Cg0KPg0KPkRvIG5vdCBnZXQgbWUgd3JvbmcsIHN0ZWxsYXIgd29yayBoZXJlLiBCdXQgSSBzdWdn
ZXN0IGNoYWxsZW5nZSB0aGUgYXNzdW1wdGlvbnMgYW5kIHRoZSBkZXNpZ24sIG5vdCBhbHdheXMg
anVzdCB0aGUgY29kZSB0aGF0IHdhcyBhbHJlYWR5IHdyaXR0ZW4gOiksIGFwb2xvZ2llcyBmb3Ig
YW55IG1pc3BsYWNlZCBvciBub2lzeSBhZHZpY2UuDQo+DQo+VGhhbmtzIQ0KPg0KPiAtIEpvZWwN
Cg0KDQo+ICAgIA0KPiBUaGFua3MNCj4gWnFpYW5nDQo+IA0KPj4gDQo+PiAoSSBhbSBvdXQgb2Yg
b2ZmaWNlIHRpbGwgTW9uZGF5IGJ1dCB3aWxsIGludGVybWl0dGVudGx5IChtYXliZSkgY2hlY2sN
Cj4+IGluLCBSQ1UgaXMgb25lIG9mIHRob3NlIHRoaW5ncyB0aGF0IGRheWRyZWFtaW5nIHRlbmRz
IHRvIGxlbmQgaXRzZWxmDQo+PiB0by4uLikNCj4+IA0KPj4gLSBKb2VsDQo=
