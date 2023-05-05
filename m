Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C1A6F87BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjEERhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjEERhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:37:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81953C34;
        Fri,  5 May 2023 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683308218; x=1714844218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c93ociaAwfLBKIvF4hxneiBMfygD/PZ1L8NhQRLVyGs=;
  b=ZlR5lqa1P2nm/Od9eQC1SF7Rrmsmv7JeEunFvf5r0sEQqorA3TfnzxPk
   OQYw8n7puM7yMlWPSfFB2KV7Vppj7kkDu1p2c69Wn6p64OOrbyXrjMs0F
   avXTGc5Q7UFdfrNdEkW49gXLuVkbiclfNyQncpbRGXNQOVg1b740NK1wH
   LOiW7pJLrfcNCBTs/Gf4sFqHkaOy2YuwPvS8lE+ZVGg4xj05TKaNbiMwJ
   Wf5w7iw/0T81P85nSXanrSHxTUkz9k1nrNawWV8XeQxn7P7GFd3HNYR7Q
   piSKY6VJTIjJq6nUU/ENoA5t9s61mpX/geE+VuCNjupkZrqqCoICj/ir1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="333688274"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="333688274"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 10:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="871956830"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="871956830"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 05 May 2023 10:36:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 10:36:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 10:36:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 10:36:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 10:36:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQmqPTr7cTGzyCDWjDqjlaVewPLQMBYL2NjqiANmlAPWAFWQJ0B8r7/oOek0c52eJsflWuuFxtfnYH64V4tLgXf/2eT+yvPcKQTNpEuUqlaVN46TzPnKObdFkQhr2B9MI9DbNYKOxaVquu4NiP6KC39r5XQ7ZP3Hr85PwD5JLpEq3ZoSlcPjcXQh7SZe62cf6Gg0JerxvV2HIQjHe3MIaY0lFM+KJnbPEHtwI+hwhW/fo/a4uWMPsgfY7steqIytipQryOEDOIMUjMZI95hdDuRnWWsGCTgRcGMJOP2Rxea5thHt/Aaqu88vXzehSTpnQdOuYsOnLZrbNxcFrksExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c93ociaAwfLBKIvF4hxneiBMfygD/PZ1L8NhQRLVyGs=;
 b=C1s8TdydXFVD5l/mfn3PprCxm5RC+4qsnfIgllKz4j8iYrrTKyu0MvL8x5Xr384CbxFr8ViyHAcULHVxfa/ovoOmGpk9xfw2Uzt2gywfLFmu/CCKmsmN6LhhWjBYYtgTyai0tWVFrjpNCLB9U/GReTOzfeTbW2pUUZ/bwtoTPynVY01aDTzT2bMOe16LwhNjlq2iS5ZoD7GxYEf6ubw4TsIVe2D9JW2kCRaC8nZrf2Puzj49TowtK3jtnDBCM5z6RyPhoKmPDecfG9kOQEeBA2VyFrMSFb3Ir0HP8JWFktZZjea3xpJ3/bEqaL7cPEFATQezKWu3uLIuLdEoWQCUkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA3PR11MB7462.namprd11.prod.outlook.com (2603:10b6:806:31d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:36:55 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::33bf:d30c:12fd:b7e3%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 17:36:55 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>,
        "support@spotco.us" <support@spotco.us>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgkeyes@vigovproductions.net" <mgkeyes@vigovproductions.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] maple_tree: Make maple state reusable after
 mas_empty_area()
Thread-Topic: [PATCH v2] maple_tree: Make maple state reusable after
 mas_empty_area()
Thread-Index: AQHZf2JFRp0UhlQqOE+tBpAXLD43Ya9L8ZgA
Date:   Fri, 5 May 2023 17:36:55 +0000
Message-ID: <0f397dcef25fc57cf7e3ddf705992f5733f27365.camel@intel.com>
References: <20230505145829.74574-1-zhangpeng.00@bytedance.com>
In-Reply-To: <20230505145829.74574-1-zhangpeng.00@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA3PR11MB7462:EE_
x-ms-office365-filtering-correlation-id: af0e8442-da16-4551-538c-08db4d8f5213
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RQBT8m590pNUMjuqHrV3XrfBturN5dtJyD26fIsRQSVkyyfkkXLGUKtawNWREQckjSmID8QTN7MfVODoGwyRurea2ykMGkOi+8+nH/IdqfP1H4V67S+qLuEiu4rN0mVjIZs66rK2GwDeLfW9C2eSEW8yIcd3dMKz2TDAKVvpxovoIW0ypL5s15AC2022WkQqYebDSB6IaCTXTSjlQKer5QJqHIw1cxF5Bghr7Nl6hIZ6rPClpdj8Toxr9z03TdsPAeLTMYpkJbt1PyKw2h1for413rtNrGOM27odGF3ALnK/jrju5k/tVe6HwqUJ+CnxwLmI5l/VIQqi1sgvp5E3PH2HPWV1xmfTMQIVRlP7NhnxRTZDn3nOfnFNUlai0OmpLwRwqzC9BWRq1f0S+EYsEXyssow01Ykr7zei1i4v7BPCFOHkesbV7qlWARMlBZItONg4RKRFxYwED63g3CfRiWpK7RfJWD88H2c2tuzYIO568R9k96X447l8YVf1BsxRq8rlkHgH2OS5U5O20s4nvvdFYniMtYivDOFIq9+df3PzrLpLqkv5SuePQdNaIolfsYqDn3lxfXZmlZQz/3RKKFlNcLZ6C29/SLD281ljewOAqd708FYMRmcYU++DYek2qyAVwk03RKxJnezGl2MOCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(2616005)(36756003)(186003)(38070700005)(2906002)(4744005)(86362001)(82960400001)(38100700002)(122000001)(5660300002)(8936002)(8676002)(966005)(64756008)(66476007)(66446008)(4326008)(66556008)(76116006)(91956017)(71200400001)(66946007)(41300700001)(478600001)(6486002)(316002)(6506007)(6512007)(26005)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVpza0cyeDhYVHB5bnhrMGtQNHc2YmtNc2tEcnZZcHpmSzZTcEV3UG1PeXB5?=
 =?utf-8?B?VTd5YldDMlcrS2lvaTI2UDM5ckpJNzRGSXVYWForUklYUmovVFZYckNFNkpO?=
 =?utf-8?B?MmkyZTlpV2szY2RjZVIwak0zOW02L0tmaGUvbEdjVytZakViajcyT2NtY2Qz?=
 =?utf-8?B?aGlSZjBoN1NvbzNyZW1ib2s3UjBvVWJEWE5XSEhmdnU2cE5ubGxqdnNJNHAy?=
 =?utf-8?B?eUFhbTdFTlpGM2o5eDVFOXEyTWpXQnA3NkVSdi8vakxJQU9oaDg3S1AyY29h?=
 =?utf-8?B?UzFieHEzUS9VU0RmZGZFcjhiTERFOU9GS2ZTd28rS0pOWWZabVI1cGZBQXg3?=
 =?utf-8?B?ZlJmZkRHRloxWTA2aVdzUEZjQzFQbkRvUW5MVTNESmRmMmtleGRxWTNKN0Ft?=
 =?utf-8?B?VVBLU1dBS0JYMmN1bGJBK1hsZ1ZhdncxbDZsRDlpeVJMSnJuK0JOK0JUOVhP?=
 =?utf-8?B?KzN1ZVovN3UraW1lY3pzQ1NNUTlJamZHNVhwb1lRMnlxSlYvZWprZEp0Y0p0?=
 =?utf-8?B?V1hWWkZDdlhzcS9UaGdVRkhZNVoyMHUvZm1WblNwNjRaNGdkdEZ4RzlsQWNQ?=
 =?utf-8?B?M1VpM3ROVTQ2Y1JBOG1pQnYzeEJDeE9kMDMzZUVrWmtiYnN4dXNBakxsTVhs?=
 =?utf-8?B?UGVkYmk3VHpKVjV3elVmN3BISHYzTHdFa3lOYzFlM1hrZkJuamNwUG5DZ3dS?=
 =?utf-8?B?ckpkV3ZaK0hvVEI2eHAzWnlFem5WTjc0VEZLTTdhelVKbVRaN21TYkVKRHZ3?=
 =?utf-8?B?c3RNdnVXenByR0YxUVlXQk5FbTJLSzhXSUVDNGN0d3NJSjF4S3kxSVEvR2R2?=
 =?utf-8?B?NU9OaFpiUVpnOGdBUC81Y3dHcndKV1dqblZVSnNFcTlVQmhhMGxwblVBeW5u?=
 =?utf-8?B?bWlST29JdFY3dS9jRzhOcnRYL25IbE8zaENRTjZDWWtJaEhFbmg2cW5nd2sw?=
 =?utf-8?B?eXkxc2NKSldsaXpycVJVOXpJVHZhN3Z6SG9BVXNVQTVNUmFVYUJOQmVlVFFv?=
 =?utf-8?B?NDYvQlZiZFoxYnMwY1ZqSDM3Y2FKMTV3dElFWWRwTmdtSy9MV1kxcDN4V3F5?=
 =?utf-8?B?dDN2ZGkvZ0hyWDZOU2M2aVA5TmVZemxIb1c2Z0tFVXVnd0NwUUhjZnA3RFg4?=
 =?utf-8?B?VW45ZWthL1pzUnRkUFIyaGYxbnVtbDdpMWdtdHpXcVVJbVd6MThpOG94MHo1?=
 =?utf-8?B?VytmTVEybFhib1cvdU1wYXpzZDlCaDRocEFDalR5R3d2bTJEZkg0TXdoZ0tq?=
 =?utf-8?B?dFQwNDdhYlNOMnRqUC9PSVliblhrV0JaR0xYUmNrVXc2UFh1MUJFaHZiT3g4?=
 =?utf-8?B?c0tuNm9rdHdtTU9rRDlNNEVXSldYQ0I2WWJtQjdWS0pYbkFDMVRvU2JUWm1u?=
 =?utf-8?B?ZUNWU0sweEl1MlRkbnI2Z1hvZ012dmVYaEpHc2xMUXVMdGVsQy9hVXBTeVg4?=
 =?utf-8?B?Q1ZQQ2ZBL0crRnVvL0NNZEN3aXB6SStrcDBlZjZEUWNQRklqQVZkZGVMeFJl?=
 =?utf-8?B?T0ZzbXAxVitsN3lGM2FzWm05STV6ejZKY2hrVFNXZW5rQlk4SXNROVI3a081?=
 =?utf-8?B?TUREcnQ5UGZMZmQwRkpBalQ4QVZTWmM2dzNyWXNOSVZ4NHpkU0ZseGFTMDE5?=
 =?utf-8?B?ZnRsWWJWeTFPYUNuZ0Zxb1orV05tdHRaTXlYZEI3ZHJyMEtqOHdBcjNNL1po?=
 =?utf-8?B?WWtsOEZWVGdmOGNDaEJYYk9ZdzV5KzlCajNHdFdJZUZkNzJ5RTVRRHF0TWhm?=
 =?utf-8?B?eHFQcmRLT1Fvb2EzWmFpNkp1bzdwS3hJUmtEWDJCR1NzL2ZlWENZemk5M25y?=
 =?utf-8?B?U3NMZXRoS1lYcVZTc0VrWDA2MmNSaENJYjBiWWYySjRIY2Y4ZXErYlVjVGZj?=
 =?utf-8?B?ZFhCVVQ5b3grWldpcE56cGZKdXBXWlFFQnVjblJyTFQvMmJRYllLL01XSGRL?=
 =?utf-8?B?QzVmbTVYQ3FUQVJ4VnhkOEVQY3NPS0RLWWdNaS9abU1mZkZTL3p2V0N6dEhF?=
 =?utf-8?B?UENNNkZVcndCZ0Y3am9ETDlhU2krKzhaVnRlNk8xOVE0aXV6R3JKTVl5ME02?=
 =?utf-8?B?Y3NZUnBUUGc3bkNraXNseDh5MEFCVWFUVW9zcXQ5TVZ4c1NGREVmTVp6aXp4?=
 =?utf-8?B?ZVpjVmNZT2hqOGxlTzZFdzIyNlVBZU1PZ21WZUhDajZhbnRzanZWNVlKY0w4?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86DAEB79A2FD474CB120D441AA3D31FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0e8442-da16-4551-538c-08db4d8f5213
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 17:36:55.5200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0Z0JtwMJo3k14GEHKdgH3o8nQIIygO5sM9Jc9/ynYUie5UO9BkhivGdOrkh70JfigSIw/9e4jXBgQWB29XdH+ht1o6r8ojj9UgGljZrwFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7462
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTA1IGF0IDIyOjU4ICswODAwLCBQZW5nIFpoYW5nIHdyb3RlOg0KPiBN
YWtlIG1hcy0+bWluIGFuZCBtYXMtPm1heCBwb2ludCB0byBhIG5vZGUgcmFuZ2UgaW5zdGVhZCBv
ZiBhIGxlYWYNCj4gZW50cnkNCj4gcmFuZ2UuIFRoaXMgYWxsb3dzIG1hcyB0byBzdGlsbCBiZSB1
c2FibGUgYWZ0ZXIgbWFzX2VtcHR5X2FyZWEoKQ0KPiByZXR1cm5zLg0KPiBVc2VycyB3b3VsZCBn
ZXQgdW5leHBlY3RlZCByZXN1bHRzIGZyb20gb3RoZXIgb3BlcmF0aW9ucyBvbiB0aGUgbWFwbGUN
Cj4gc3RhdGUgYWZ0ZXIgY2FsbGluZyB0aGUgYWZmZWN0ZWQgZnVuY3Rpb24uDQo+IA0KPiBSZXBv
cnRlZC1ieTogIkVkZ2Vjb21iZSwgUmljayBQIiA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+
DQo+IFJlcG9ydGVkLWJ5OiBUYWQgPHN1cHBvcnRAc3BvdGNvLnVzPg0KPiBSZXBvcnRlZC1ieTog
TWljaGFlbCBLZXllcyA8bWdrZXllc0B2aWdvdnByb2R1Y3Rpb25zLm5ldD4NCj4gTGluazoNCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMzJmMTU2YmE4MDAxMGZkOTdkYmFmMGEw
Y2RmYzg0MzY2NjA4NjI0ZC5jYW1lbEBpbnRlbC5jb20vDQo+IExpbms6DQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LW1tL2U2MTA4Mjg2YWMwMjVjMjY4OTY0YTdlYWQzYWFiOTg5OWY5
YmM2ZTkuY2FtZWxAc3BvdGNvLnVzLw0KPiBGaXhlczogNTRhNjExYjYwNTkwICgiTWFwbGUgVHJl
ZTogYWRkIG5ldyBkYXRhIHN0cnVjdHVyZSIpDQo+IENjOiA8U3RhYmxlQHZnZXIua2VybmVsLm9y
Zz4NCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBaaGFuZyA8emhhbmdwZW5nLjAwQGJ5dGVkYW5jZS5j
b20+DQo+IC0tLQ0KDQpZZXAsIHRoaXMgYWxzbyB3b3JrcyBmb3IgbWUuIFRoYW5rcy4NCg==
