Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6491C6DF847
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjDLOVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjDLOVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:21:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB7849C6;
        Wed, 12 Apr 2023 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681309275; x=1712845275;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TokJCbkE7b70w03s3VUT7WnIlqvVhfEys/v+FMp6lrM=;
  b=fYEDK4I0OHCGRNGFR0s0AoMcNvpI4UegtmJUV9zccBgpVVp4HR/XQZy0
   TY1sZxIKGd13aoQd05vcbq/37YTtEfVY+0ol8hMkBllC5KWQbyl8HzkSb
   Upl+lmWcNJ5N3GW8XNy98Wt/TrggvaOqFDPnFQSWveiwgv67NF89oQPRx
   SndBTXeezpD+ldSfxl1HWT/iBtCcb8hVU3LnRTN6zOFR/ml/kSmqlMguU
   Lgu9e1BCcTSZJtLY0oFd6oG6TBHS1pBlr08E1kbgW2vUM0zuL6pWvuM6e
   y6ik8IZAInIh3OIrxMUJOVZ/OlixCwO/ZSAw84C+O8u+QrvW4nJC37J2o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="430196507"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="430196507"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="832723928"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="832723928"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2023 07:21:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 07:21:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 07:21:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 07:21:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 07:21:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA78i9rFuW+uTLRkpdU/vjvCUM9mhPuxJ0a68gKcxF2IqZ5FiAzodHtW+vcA19LvxnABNm2/K8O8AnvCcAvfVnbzVL1MttF1PmaKvUreaWBA+PTVuE8kjBi1quoRDUoV3vNHCtVDrku3l5jV2+eMlkbYAxu83CmdmSmUtd9+xDe1xr2gbeoBP23+wIs2r5IG8hp6PaVvUlAF2afxhX6S2BWKMORtC05hapUNsU1JugKoEJGGO9M31XhPmyhWO04nmlwY6r6nPs2a2ZEEJ8eML37+FaF1LmHnSBK402tfRmwiUratR5krAe6KchJD8Lk7NLYedaojmiO8B3jN0PHirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TokJCbkE7b70w03s3VUT7WnIlqvVhfEys/v+FMp6lrM=;
 b=TeU9xP3O/qiPoKzwiXcXRkmIdF/dPZTHMgofuBgzOa4eDT+pJT2RBb3DJWKbfobb1ZthHpP55N30Boyq53y6kGVZowxLXvLmRCYVL0tS6BEo4kKdasL6m1yFWq4ataRcpme4sA57gKsgUbJc5z0CphWsVQcyV2lJBJL7JtwznL1z//z+CYkEcZf3GUXvHEiQLGbXmMiYqTGYaxyHrm0HYcigt0eQSbvvt65hO2xukTok3u+boNIVTvG9KW6HxQ+6LDW5NY59kAoKy0UwSNTdnGVMxjwI8sFmsnxfNcc1ibU3HOhht7JDktMDdbAslutlKhkb9nEbhgKyoWAjjGmbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN9PR11MB5559.namprd11.prod.outlook.com (2603:10b6:408:104::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 14:21:11 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0%5]) with mapi id 15.20.6277.035; Wed, 12 Apr 2023
 14:21:10 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Topic: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Index: AQHZaiXby4kI/lAQlUSTC1cR7UMpS68lNdWAgABJBmCAAK/VgIAAAf6ggAAHJACAAB0hgIAAB8aAgADFFUCAAH+YAIAAHRWg
Date:   Wed, 12 Apr 2023 14:21:10 +0000
Message-ID: <PH0PR11MB5880DF817C8F8D6364DA666EDA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <PH0PR11MB588072A12543FD617C833AF9DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDVt5eUAlp4VmbFy@pc636>
 <PH0PR11MB5880C4B181B6237402B1FBA7DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDV1jhENgED4ctxO@pc636>
 <2159c88e-ec99-4ad6-a166-baf4199d138f@paulmck-laptop>
 <ZDWUgygOqJjs07pp@pc636>
 <PH0PR11MB588060C9B6BE6F08540E74DCDA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDak3oyPlHvMB+CR@pc636>
In-Reply-To: <ZDak3oyPlHvMB+CR@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BN9PR11MB5559:EE_
x-ms-office365-filtering-correlation-id: ac249a8b-a7ca-41f7-7a4c-08db3b612a33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GcFsXoECuZevfRHp5h3Xhg59/of8alokz973MAfcVX/JYZxX4NLNJWGeWZDkS0xXyUJKjeMBoqcNaJG/NHXAAE1FtE0kjbBKd5GitR5abiVftW7o+X45uLm8u+FI3S0ClrDuue2yniE8mycAAJvD3bUBYOXbiaKBeVGgNg15mzLl9hhWBpRzWRMRe9HUbu8Qkfv/9HPOZVqtLe8oYXteAMCtcvDJ0e3xobuDgTYczhbJJlNUvjeW+xNXSBg+R0aB8jsWa4AzBS0FFEGRE6bZQ7m7BrWJcN17qI523h0iMZXYqJdzwZRhtifpFC/q/rb4uBCP530O5l3pWIxomt41iLctlU7RhgLYbA88SMf+923JxD2MAqnwX8KRmyrJJPw2Tf6wHKDc66zoNf5l9QQ7v6orXh+Bk7dKCaYM6J6N2hDqdZ4D2+tLHGP0Gn1Ixt227+ACn1VjnZSy7Z7+KjclrxBfhaGu4oP+P6RszMwR2zuJgFJUpaFgttSb0OIONSWCNXOphzKisu19HHVmD8i8Phze1X44+HEAyrYlSkhoLwCMiKkfHJN6t+hXbhEXZFT9EpQRVM0Pl0kcI0KdeBMJWZHDDiNpC/mA95rToeP/4ZVbY9Yf/yUot7YT1CCFXwdFI3MBJL0X42UQrE3gDzC23w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(52536014)(478600001)(71200400001)(7696005)(33656002)(26005)(54906003)(186003)(5660300002)(66556008)(9686003)(6506007)(2906002)(4326008)(76116006)(66946007)(41300700001)(64756008)(66446008)(8936002)(8676002)(66476007)(6916009)(316002)(38100700002)(122000001)(82960400001)(55016003)(83380400001)(38070700005)(86362001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enN3T0RlNEhBWlpXb0lCQW54UE9rUytlbHFDZGNZRitQMTJaYUtFbFNJa0lJ?=
 =?utf-8?B?K082ajRyc3RSMmNkVnVadG1ibDlTeHdZa1YzejJmYzU1MWZqMkwzS0Q0Q2U2?=
 =?utf-8?B?ekx4T3R0SnF0Z2QvT05FTVNDeS9sZWhTZ3Z2NVNSc2twcFVxR1FXNHFDb002?=
 =?utf-8?B?RnljVWM0TVBJb1U0K1JTWnF0V0FVc20vYU5hWVdJUlZsaUJ0RHlLUU1sZlU2?=
 =?utf-8?B?bUx3MDJva1JXTHVyZ2MxeC9mcTdpS2xkVW8ySDVjK1NuNlhWNUVHSUY0NDlq?=
 =?utf-8?B?VWhXUjI0RW1abVhLRmN6anV1aUw5NzFUOE5vNzFsMWhmbUlsQmhpUG5ZVUpt?=
 =?utf-8?B?RjVCRktUT1VUT1d1bDRlSlM0YUZZYloyV0J2YUlKaDhEZ3g3Y0RMc3o0bGpO?=
 =?utf-8?B?LzB2ZFBuZUgyUnBkVnpYQmJLNEtIcHhpOW54c0FBVnhlMUtiMTZ6QkpoeXdo?=
 =?utf-8?B?d2wxb1gxMFBXUm5lbmhaUUgxdXZjc2Fqc00rS1AyaEUrRnprd1dBSko5dHJp?=
 =?utf-8?B?RFpCSWJqTUVnZEs1eFNGZkhqMVA4NS9LUWtScGk5K2g0NDhBQlZ2b3UwOTE5?=
 =?utf-8?B?SzlxdDFCbDFHV1QxOFVrb2xDTDNMSGZLRG94UUJVbVhvUVdtV3JKazVseDhl?=
 =?utf-8?B?d3I5UUNKY3h5L3lYcUJPcjJDek1NS1BFRjN4Zi90MkVZVGR1bnJYejhjRksv?=
 =?utf-8?B?ZFFtK3F1MDRQVWVwQnFIa2hFRU8wUTVaMkVCTGV2VVN6NGdadHhEM2pBekZP?=
 =?utf-8?B?eVhaMzF6V3VvTFFocTRDbkxCNDVBZVhsOU90K0w2VmNEZXFMUGI2bFpJMmR5?=
 =?utf-8?B?cVlFVkVzY0xmT3pXSWl6OW0rOXpDWWNsNWZGdGdhWGJQckZVMHdpSnhGSmZT?=
 =?utf-8?B?cG1VdVBRQjNveW03V1pUOXhOeDQzTnlreFl5WjczWnd6MjdiWk1ZTXg3bHZq?=
 =?utf-8?B?bWpSc2k2VE9tRUFXc0I1SjVTa0hVbk5aZTR4MDJYdzRkQWpJUERGdGZJalk1?=
 =?utf-8?B?aGhVU1pJVmp4dHdJVTdrNGxsblhFMEpMV2ZTb2RXc052TEF1UkMwbUFhWURI?=
 =?utf-8?B?YjltMFRxQ0MrVjlubW5PNDdhUE5ycVJMdERkTTlETHpYK3JxR0Z6YWducnBj?=
 =?utf-8?B?aEI3UEJCdlZXUjJIZGt1OFZxVlRxOWtvcTBnejRYdk1xbzF2SHg4SGM2SjRM?=
 =?utf-8?B?MzNGUy8yK1BPUFk0UGxPZGhwOERrMk5WdTA4VzNJMGd4UWVuMkhuY0ZMWGNN?=
 =?utf-8?B?blJsdTBkakFKaW9mVkxFTkFSUDdPWlU1R1BaYUdrTHhXNm9ZM1VjYlY1UEhh?=
 =?utf-8?B?SG9rc0w5Z2VqazZ3a2gzWmdiM1BsSi95SHA4am1JSlZzV0x5Qy84ck1xUnd6?=
 =?utf-8?B?QzVoWUtTTjRIVFVGTWlBSjh5QW91UzdXa0x4Sm92cDdFRFdTSlJVWlBZZzM3?=
 =?utf-8?B?VGZYTXRjeTVOazZWd0xGbWx1Qjd1blNHUzk2cHNPZnVyMTZnaVJuWVA3Nzl4?=
 =?utf-8?B?VGVSUGZHMCtrWjJHU1FqZzcyR1ZGUUpWSXJ2cDVCS1FWbzR0cE94VlBBNWg2?=
 =?utf-8?B?K3dhQVdJODhrVDdOSnJpcHhGSDRNY1FXUjZDTlIrQlBvY05rUjFoZVg5T2NR?=
 =?utf-8?B?Ym0rc0RHTFcrSWUvOGJGVGZXOE5jV1BVeFFEUUdYTVdBMHJ4U2xYZTBRQjRF?=
 =?utf-8?B?amR4N2x4bFBiQWoyTDkzNEt0cmMrMVo5VFVDdzlkYUI3WHBCYWlXZE9iUTho?=
 =?utf-8?B?L3YzY0prMUJxUVFQTTE0MVc4eWZZNWhEK1VSd0RRWkw3WDBKRFg0OXJ2cjIy?=
 =?utf-8?B?VkJ1dGNwejRQVXgrSlJPV1hEeHNvek1jQ3lPOGUwQmg2cHpTeEdrZlRFZWtu?=
 =?utf-8?B?ZnhSb3pJZE5KNlJiRmNOTmZkemJRYldwYm91V2dsaVM2dW1zeXhhWUxINHV0?=
 =?utf-8?B?dmkxakViRTJudERjeTlyam9acy9BTXJTOFh2KzR1MzFDUzNONzVRYU4xdFo3?=
 =?utf-8?B?TUZqQS9lTWRXcjFFMGt1M21kUHMwa2FzY2h5a2d4R1B4L3RTT25jWUZQSkdj?=
 =?utf-8?B?OGJJc3kxQlIxVHJLcmFBYS9odm1oZUE4cjlOYkhFQ2I4eHpzelU0Ymc1b01u?=
 =?utf-8?Q?HRmkDealFhtAXCTvIIcLerZ/c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac249a8b-a7ca-41f7-7a4c-08db3b612a33
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 14:21:10.8837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CsNteSZe5YWW/mzEUf8dJtno2SOL7sn6shjeOpjuR5r6shk8zx0e628g+Zpe5KiuRTZ9ZPjDWbfnMleTgm/D2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5559
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

PiA+IE9uIFR1ZSwgQXByIDExLCAyMDIzIGF0IDA0OjU4OjIyUE0gKzAyMDAsIFVsYWR6aXNsYXUg
UmV6a2kgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIEFwciAxMSwgMjAyMyBhdCAwMjo0MjoyN1BNICsw
MDAwLCBaaGFuZywgUWlhbmcxIHdyb3RlOg0KPiA+ID4gPiA+ID4gQ3VycmVudGx5LCBpbiBrZnJl
ZV9yY3Vfc2hyaW5rX3NjYW4oKSwgdGhlIGRyYWluX3BhZ2VfY2FjaGUoKSANCj4gPiA+ID4gPiA+
IGlzIGV4ZWN1dGVkIGJlZm9yZSBrZnJlZV9yY3VfbW9uaXRvcigpIHRvIGRyYWluIHBhZ2UgY2Fj
aGUsIGlmIA0KPiA+ID4gPiA+ID4gdGhlIGJub2RlIHN0cnVjdHVyZSdzLT5ncF9zbmFwIGhhcyBk
b25lLCB0aGUga3ZmcmVlX3JjdV9idWxrKCkgDQo+ID4gPiA+ID4gPiB3aWxsIGZpbGwgdGhlIHBh
Z2UgY2FjaGUgYWdhaW4gaW4ga2ZyZWVfcmN1X21vbml0b3IoKSwgdGhpcyANCj4gPiA+ID4gPiA+
IGNvbW1pdCBhZGQgYSBjaGVjayBmb3Iga3JjcCANCj4gPiA+ID4gPiA+IHN0cnVjdHVyZSdzLT5i
YWNrb2ZmX3BhZ2VfY2FjaGVfZmlsbCBpbiBwdXRfY2FjaGVkX2Jub2RlKCksIGlmIA0KPiA+ID4g
PiA+ID4gdGhlIGtyY3Agc3RydWN0dXJlJ3MtPmJhY2tvZmZfcGFnZV9jYWNoZV9maWxsIGlzIHNl
dCwgcHJldmVudCBwYWdlIGNhY2hlIGdyb3dpbmcgYW5kIGRpc2FibGUgYWxsb2NhdGVkIHBhZ2Ug
aW4gZmlsbF9wYWdlX2NhY2hlX2Z1bmMoKS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+TXVjaCBpbXByb3ZlZCEgIEJ1dCBzdGlsbCBzb21lIHF1ZXN0aW9ucyBiZWxv
dy4uLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+CQkJCQkJCVRoYW54LCBQYXVsDQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAga2VybmVsL3JjdS90cmVlLmMgfCA0
ICsrKy0NCj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwv
cmN1L3RyZWUuYyBiL2tlcm5lbC9yY3UvdHJlZS5jIGluZGV4IA0KPiA+ID4gPiA+ID4gY2MzNGQx
M2JlMTgxLi45ZDlkMzc3MmNjNDUgMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9rZXJuZWwvcmN1
L3RyZWUuYw0KPiA+ID4gPiA+ID4gKysrIGIva2VybmVsL3JjdS90cmVlLmMNCj4gPiA+ID4gPiA+
IEBAIC0yOTA4LDYgKzI5MDgsOCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgIA0KPiA+ID4gPiA+ID4g
cHV0X2NhY2hlZF9ibm9kZShzdHJ1Y3Qga2ZyZWVfcmN1X2NwdSAqa3JjcCwNCj4gPiA+ID4gPiA+
ICAJc3RydWN0IGt2ZnJlZV9yY3VfYnVsa19kYXRhICpibm9kZSkgIHsNCj4gPiA+ID4gPiA+ICsJ
aWYgKGF0b21pY19yZWFkKCZrcmNwLT5iYWNrb2ZmX3BhZ2VfY2FjaGVfZmlsbCkpDQo+ID4gPiA+
ID4gPiArCQlyZXR1cm4gZmFsc2U7DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID5UaGlzIHdpbGwg
bWVhbiB0aGF0IHVuZGVyIGxvdy1tZW1vcnkgY29uZGl0aW9ucywgd2Ugd2lsbCBrZWVwIA0KPiA+
ID4gPiA+ID56ZXJvIHBhZ2VzIGluIC0+Ymt2Y2FjaGUuICBBbGwgYXR0ZW1wdHMgdG8gcHV0IHNv
bWV0aGluZyB0aGVyZSB3aWxsIGZhaWwuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID5UaGlzIGlz
IHByb2JhYmx5IG5vdCBhbiBpc3N1ZSBmb3Igc3RydWN0dXJlcyBjb250YWluaW5nIGFuIA0KPiA+
ID4gPiA+ID5yY3VfaGVhZCB0aGF0IGFyZSBwYXNzZWQgdG8ga2ZyZWVfcmN1KHAsIGZpZWxkKSwg
YnV0IGRvZXNuJ3QgDQo+ID4gPiA+ID4gPnRoaXMgbWVhbiB0aGF0DQo+ID4gPiA+ID4gPmtmcmVl
X3JjdV9taWdodHNsZWVwKCkgdW5jb25kaXRpb25hbGx5IGludm9rZXMgc3luY2hyb25pemVfcmN1
KCk/DQo+ID4gPiA+ID4gPlRoaXMgY291bGQgc2VyaW91c2x5IHNsb3cgdXAgZnJlZWluZyB1bmRl
ciBsb3ctbWVtb3J5IA0KPiA+ID4gPiA+ID5jb25kaXRpb25zLCB3aGljaCBtaWdodCBleGFjZXJi
YXRlIHRoZSBsb3ctbWVtb3J5IGNvbmRpdGlvbnMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhh
bmtzIGZvciBtZW50aW9uaW5nIHRoaXMsIEkgZGlkbid0IHRoaW5rIG9mIHRoaXMgYmVmb3Jl8J+Y
ii4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPklzIHRoaXMgcmVhbGx5IHdo
YXQgd2Ugd2FudD8gIFplcm8gY2FjaGVkIHJhdGhlciB0aGFuIGp1c3QgZmV3ZXIgY2FjaGVkPw0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gIAkvLyBD
aGVjayB0aGUgbGltaXQuDQo+ID4gPiA+ID4gPiAgCWlmIChrcmNwLT5ucl9ia3Zfb2JqcyA+PSBy
Y3VfbWluX2NhY2hlZF9vYmpzKQ0KPiA+ID4gPiA+ID4gIAkJcmV0dXJuIGZhbHNlOw0KPiA+ID4g
PiA+ID4gQEAgLTMyMjEsNyArMzIyMyw3IEBAIHN0YXRpYyB2b2lkIGZpbGxfcGFnZV9jYWNoZV9m
dW5jKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gPiA+ID4gPiA+ICAJaW50IGk7DQo+ID4g
PiA+ID4gPiAgDQo+ID4gPiA+ID4gPiAgCW5yX3BhZ2VzID0gYXRvbWljX3JlYWQoJmtyY3AtPmJh
Y2tvZmZfcGFnZV9jYWNoZV9maWxsKSA/DQo+ID4gPiA+ID4gPiAtCQkxIDogcmN1X21pbl9jYWNo
ZWRfb2JqczsNCj4gPiA+ID4gPiA+ICsJCTAgOiByY3VfbWluX2NhY2hlZF9vYmpzOw0KPiA+ID4g
PiA+ID4gIA0KPiA+ID4gPiA+ID4gIAlmb3IgKGkgPSAwOyBpIDwgbnJfcGFnZXM7IGkrKykgew0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+SSBhbSBzdGlsbCBjb25mdXNlZCBhcyB0byB3aHkgd2Ug
c3RhcnQgImkiIGF0IHplcm8gcmF0aGVyIHRoYW4gDQo+ID4gPiA+ID4gPmF0DQo+ID4gPiA+ID4g
Pi0+bnJfYmt2X29ianMuICBXaGF0IGFtIEkgbWlzc2luZyBoZXJlPw0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IE5vLCB5b3UgYXJlIHJpZ2h0LCBJIG1pc3NlZCB0aGlzIHBsYWNl
LiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAtLS0gYS9rZXJuZWwvcmN1L3RyZWUuYw0KPiA+ID4g
PiA+ICsrKyBiL2tlcm5lbC9yY3UvdHJlZS5jDQo+ID4gPiA+ID4gQEAgLTI5MDgsNiArMjkwOCw4
IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCAgDQo+ID4gPiA+ID4gcHV0X2NhY2hlZF9ibm9kZShzdHJ1
Y3Qga2ZyZWVfcmN1X2NwdSAqa3JjcCwNCj4gPiA+ID4gPiAgICAgICAgIHN0cnVjdCBrdmZyZWVf
cmN1X2J1bGtfZGF0YSAqYm5vZGUpICB7DQo+ID4gPiA+ID4gKyAgICAgICBpZiAoYXRvbWljX3Jl
YWQoJmtyY3AtPmJhY2tvZmZfcGFnZV9jYWNoZV9maWxsKSkNCj4gPiA+ID4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID5UaGlzIGlzIGJyb2tlbiwg
dW5mb3J0dW5hdGVseS4gSWYgYSBsb3cgbWVtb3J5IGNvbmRpdGlvbiB3ZSBmaWxsIA0KPiA+ID4g
PiA+ZmlsbCBhIGNhY2hlIHdpdGggYXQgbGVhc3Qgb25lIHBhZ2UgYW55d2F5IGJlY2F1c2Ugb2Yg
d2UgZG8gbm90IA0KPiA+ID4gPiA+d2FudCB0byBoaXQgYSBzbG93IHBhdGguDQo+ID4gPiA+IA0K
PiA+ID4gPiBUaGFua3MgcmVtaW5kLCBwbGVhc2UgaWdub3JlIG15IHY0IHBhdGNoLCAgIGhvdyBh
Ym91dCB0aGUgZm9sbG93aW5nPw0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9yY3UvdHJlZS5jIGIva2VybmVsL3JjdS90cmVlLmMgaW5kZXggDQo+ID4gPiA+IDQxZGFhZTMy
MzliNS4uZTJlODQxMmU2ODdmIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9rZXJuZWwvcmN1L3RyZWUu
Yw0KPiA+ID4gPiArKysgYi9rZXJuZWwvcmN1L3RyZWUuYw0KPiA+ID4gPiBAQCAtMzIzOCw2ICsz
MjM4LDkgQEAgc3RhdGljIHZvaWQgZmlsbF9wYWdlX2NhY2hlX2Z1bmMoc3RydWN0IHdvcmtfc3Ry
dWN0ICp3b3JrKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBmcmVlX3BhZ2UoKHVu
c2lnbmVkIGxvbmcpIGJub2RlKTsNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICB9DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIGlmIChhdG9taWNfcmVhZCgma3JjcC0+YmFja29mZl9wYWdlX2NhY2hlX2ZpbGwp
KQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ID4gICAgICAg
ICB9DQo+ID4gPiBJdCBkb2VzIG5vdCBmaXggYW4gImlzc3VlIiB5b3UgYXJlIHJlcG9ydGluZy4g
a3ZmcmVlX3JjdV9idWxrKCkgDQo+ID4gPiBmdW5jdGlvbiBjYW4gc3RpbGwgZmlsbCBpdCBiYWNr
LiBJTUhPLCB0aGUgc29sdXRpb24gaGVyZSBpcyB0byANCj4gPiA+IGRpc2FibGUgY2FjaGUgaWYg
YSBsb3cgbWVtb3J5IGNvbmRpdGlvbiBhbmQgZW5hYmxlIGJhY2sgbGF0ZXIgb24uDQo+ID4gPiAN
Cj4gPiA+IFRoZSBjYWNoZSBzaXplIGlzIGNvbnRyb2xsZWQgYnkgdGhlIHJjdV9taW5fY2FjaGVk
X29ianMgdmFyaWFibGUuIFdlIA0KPiA+ID4gY2FuIHNldCBpdCB0byAxIGFuZCByZXN0b3JlIGl0
IGJhY2sgdG8gb3JpZ2luYWwgdmFsdWUgdG8gbWFrZSB0aGUgDQo+ID4gPiBjYWNoZSBvcGVyYXRp
bmcgYXMgYmVmb3JlLg0KPiA+IA0KPiA+IEl0IHdvdWxkIGJlIGJlc3QgdG8gdXNlIGEgc2Vjb25k
IHZhcmlhYmxlIGZvciB0aGlzLiAgVXNlcnMgbWlnaHQgZ2V0IA0KPiA+IGFubm95ZWQgaWYgdGhl
aXIgY2hhbmdlcyB0byByY3VfbWluX2NhY2hlZF9vYmpzIGdvdCBvdmVyd3JpdHRlbiBvbmNlIA0K
PiA+IHRoaW5ncyBnb3Qgc2V0IGJhY2sgdG8gbm9ybWFsIG9wZXJhdGlvbi4NCj4gPiANCj4gPkFn
cmVlLiBTbyB3ZSBkbyBub3QgbWFrZSBpdCB2aXNpYmxlIG92ZXIgc3lzZnMgaW50ZXJmYWNlIGZv
ciB1c2VyIHRoYXQgd2UgbWFuaXB1bGF0ZSBpdC4NCj4gPg0KPiA+DQo+IA0KPiANCj4gVGhlIHJj
dV9taW5fY2FjaGVkX29ianMgaXMgcmVhZC1vbmx5LCBVc2VycyBjYW5ub3QgYmUgc2V0IHJjdV9t
aW5fY2FjaGVkX29ianMgZHluYW1pY2FsbHkuIA0KPiANCj4gLXItLXItLXItLSAxIHJvb3Qgcm9v
dCA0LjBLIEFwciAxMiAwMTowOCByY3VfbWluX2NhY2hlZF9vYmpzDQo+IA0KWW91IGNhbiBzZXQg
aXQgYXMgYSBib290IHBhcmFtZXRlcjogcmN1dHJlZS5yY3VfbWluX2NhY2hlZF9vYmpzPVhYWA0K
DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWUuYyBiL2tlcm5lbC9yY3UvdHJlZS5jDQo+
IGluZGV4IDQxZGFhZTMyMzliNS4uMGU5ZjgzNTYyODIzIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwv
cmN1L3RyZWUuYw0KPiArKysgYi9rZXJuZWwvcmN1L3RyZWUuYw0KPiBAQCAtMjkwOSw3ICsyOTA5
LDggQEAgcHV0X2NhY2hlZF9ibm9kZShzdHJ1Y3Qga2ZyZWVfcmN1X2NwdSAqa3JjcCwNCj4gICAg
ICAgICBzdHJ1Y3Qga3ZmcmVlX3JjdV9idWxrX2RhdGEgKmJub2RlKQ0KPiAgew0KPiAgICAgICAg
IC8vIENoZWNrIHRoZSBsaW1pdC4NCj4gLSAgICAgICBpZiAoa3JjcC0+bnJfYmt2X29ianMgPj0g
cmN1X21pbl9jYWNoZWRfb2JqcykNCj4gKyAgICAgICBpZiAoKGF0b21pY19yZWFkKCZrcmNwLT5i
YWNrb2ZmX3BhZ2VfY2FjaGVfZmlsbCkgJiYga3JjcC0+bnJfYmt2X29ianMpIHx8DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAga3JjcC0+bnJfYmt2X29ianMgPj0gcmN1X21pbl9j
YWNoZWRfb2JqcykNCj4gICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gDQo+V2UgY2Fu
IGVsaW1pbmF0ZSB0aGUgYmFja29mZl9wYWdlX2NhY2hlX2ZpbGwgcGVyLWNwdSBhdG9taWMgdmFy
aWFibGUgYW5kDQo+anVzdCBjaGFuZ2UgYSBuZXcgb25lLCBzYXksIG1pbl9jYWNoZWRfb2Jqcywg
aWYgYSBsb3cgbWVtb3J5IGNvbmRpdGlvbi4NCj5SZXN0b3JlIGl0IHRvIGEgZGVmYXVsdCB3aGF0
IGlzIHRoZSByY3VfbWluX2NhY2hlZF9vYmpzLg0KDQpUaGFua3MgZm9yIHN1Z2dlc3Rpb24sICB3
aWxsIGJlIG1vZGlmaWVkIGluIHRoaXMgd2F5Lg0KDQo+DQo+SSBjYW4gcG9zdCBoZXJlIGFuIGV4
YW1wbGUgaWYgaXQgaGVscHMgdG8gbWFrZSBpdCBtb3JlIGNsZWFyLg0KPg0KPi0tDQo+VWxhZHpp
c2xhdSBSZXpraQ0K
