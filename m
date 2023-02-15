Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A6169772C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjBOHJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjBOHJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:09:43 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D0A35249
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676444979; x=1707980979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LiGti3TStCWXaeZS1Ek72i31Y0BC/YsvGX56aQCG5FM=;
  b=G9sk7lX6xjkTn4lDaEnzyaF2eYArSr4A8Lu6TIXkM69g5q/Y1AnTdoJx
   DBb6+RtaSStlEVkrvWHzXgvLD2V1Iqxgf9OLzDMcyR0I9PBceMGnsFKkN
   J3n5CM7Ah0qZKbxTQ33065CMCrhXoi8nWkTmrpdhpIZs30vJvZ3Hk8+3l
   619dWA9cSgK0zhAUS+84QJdj0AX05lWYdHVnrr3bPd8AnYJ5qi402Zoj/
   hh5FfPnwbcRWWuU34z4ujE706koApGocRWkssbmWd7qpcYOM8toEtvby6
   VxrB1VSMYF4HtH844twNBHK2YUsIvXFT8Ac1m+SrC1FHcOBs49p1hbUff
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358782666"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="358782666"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 23:09:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="758297042"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="758297042"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Feb 2023 23:09:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 23:09:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 23:09:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 23:09:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 23:09:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkovjcANsJb5yIhEgErOTnE+gKFQC919ZI+CQr4LSIzBQJrWFXLNpwrpIeXm0gHtU8ngJDUJ0YmHfPgTLLof/EHfc0nFc83UcxUCo9RuCPEdo6pTJBr2fyJkecRls/sV8gMl49AMgXi02E7V8U4gaIagCD1wZjyDxayxhTmC9sDimI1cBatLcaI0pWd2Hs2PH0KxHqpxUqUGpQwEslUjfJ3fXhuOpWTGWRWGpNUgXU7EWHeXrsNPLax+9I+GPyBlZz3ghE8AE14iy4RBl/2gPK0QzFeZC5gi/jIsm8Pgr4slOac07l/5NJsWosqiLiCRrv7gIYQlsd7kebp9OFUIbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiGti3TStCWXaeZS1Ek72i31Y0BC/YsvGX56aQCG5FM=;
 b=h61xJuUqUSLCvoTdT8GyKzPKibGEhOn3oxRMLs52Dr8gX0lRBtxd1X9oJZbWuZRy5gR7U2SYMHkiqI2N8KvQ+g9p71fzWTp9XJGdwJV52UWoYhLGMfGH11hP49QYmGJzj+SwO9IQJtJTMiTdBi5s9VcxZ0HcoDMnYMBp9tWz0z6o5Ky6UaOyEi5ZfFvBaZ3DHswnnMJK2WrKPaXHaClEMxQeh/Km2XDtcNm4Sal2QxAo/gHkN4qOqDNzCTAMjA3osz0ZxR1dBDUYG4mxBL+OoZw28LlgLYMV5eFj5ggNT9sWmcn4NWtXEy52uFrpp5t1FNjFz4cFH9QtmMXtuBeVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3240.namprd11.prod.outlook.com (2603:10b6:a03:18::19)
 by DS0PR11MB7734.namprd11.prod.outlook.com (2603:10b6:8:df::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Wed, 15 Feb 2023 07:09:01 +0000
Received: from BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::c42:6379:b57f:4a59]) by BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::c42:6379:b57f:4a59%7]) with mapi id 15.20.6086.023; Wed, 15 Feb 2023
 07:09:01 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Gross, Mark" <mark.gross@intel.com>
Subject: RE: PPS functionality for Intel Timed I/O
Thread-Topic: PPS functionality for Intel Timed I/O
Thread-Index: Adk0qfZfZVvAvtJ8SP+qSzpYuQsN4wAByXCAAACHHGAAAOuigAFW0rTQAAGFloABu/WBcA==
Date:   Wed, 15 Feb 2023 07:09:01 +0000
Message-ID: <BYAPR11MB3240C6789B4C04F3BDAE34D5E1A39@BYAPR11MB3240.namprd11.prod.outlook.com>
References: <BYAPR11MB3240A86B426158623DB9983EE1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <fa3f1765-eb59-bf69-7f7b-14621caef6ea@enneenne.com>
 <BYAPR11MB3240801F21598EEFAEA79605E1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <1e02cc71-baee-1e75-9160-062d563af795@enneenne.com>
 <BYAPR11MB32408E2D9758BD01EC65FB49E1DA9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <f2788a74-19f8-8992-5b92-427c7b2a27ab@enneenne.com>
In-Reply-To: <f2788a74-19f8-8992-5b92-427c7b2a27ab@enneenne.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3240:EE_|DS0PR11MB7734:EE_
x-ms-office365-filtering-correlation-id: 9904c5d5-e0ad-4f7f-610f-08db0f2383fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KgYIWb+0NJL9DRA1t2NVpB6lDR9IXah5oRinh3ndJhxg6KnSMXYxaJACE41+vwQlOVbG7HJn6Ifux3AFZebS7a6hUGupVnFJz8GCAJW9myyNkfMVV9ARrqmjEoNQs5uLrXO3Eph91u2lAhzQw6D8mdHv41ORgTcnao/wDaGdX+LqDUkGUYQhNL1C0LP+lkrsT7/ZCciVFNxoqyIa1x89tkFcm1CGiPy2ZIFGKrj9N3bScy491fZYbNf8XZ1YSUYLUin0eyThES1cJ16gYRp0YNDS5ElA6SfWYe2SQtU9OFUz2sdA4Ayc4BmJSJbYudqYUeW9jQUxRC2FdJpNqGTRo/B7pGtpzgzzPnzPOIw1J9MTqKdlrxBGtp1aKUMAsbz+AIuoKpazARHH6NeIVfThxstgWjGiy6uBTUnb9xx6/eambmgOL+hU5hE0ICKxhriNO4SJ4306kgAwnhJBfAYh+tRg04lwzGRAt8ButmnlxpRIIBQECPouzPrvt3t2W/cs48xs7KUeEJTaCV3B0MrmKQXbIp1tee2wMSju0OUSc93O4xiVcx6yoaAHP0P8wKX/sd7u5Z1iOlm3d3LeU1A5usyGfyp+0rRobSg5TI6j1CFM/iLvf3MoiHT7gyWoA/kQ0U36L+Jo9ZqDl847nwgZ/vzDB1knHGzH7W8uvz4VmDxe+VkSUn3mnl1rjiV5W5B5DGrSn8onRf0zGS3HvZrmMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3240.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199018)(83380400001)(38100700002)(122000001)(7696005)(33656002)(82960400001)(54906003)(52536014)(55016003)(86362001)(5660300002)(38070700005)(71200400001)(2906002)(76116006)(186003)(478600001)(107886003)(66446008)(316002)(4326008)(6916009)(64756008)(66946007)(8676002)(66476007)(26005)(41300700001)(6506007)(66556008)(9686003)(53546011)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEpnbkYxNkY0RXNFaTJ3S3VFcXlRMk5jOHVmY3ZOQ0ZHTGFKYnRQRlNJUG1m?=
 =?utf-8?B?ckdYRGs5VVVlWGJWblRYTVdlR3BJeWZ2TUs5d0pMUVlwRW5yL25WYjRxdWZL?=
 =?utf-8?B?MjUzY2F6K1N6UUc4T1Y0VHBhSWtCdjRrZUw0aEZRTUd2NkdaWk1qV1hHSytx?=
 =?utf-8?B?RDFGUHJBRmJXYW4xbk9ZaFpyTW1EUkM2RTVXTkZoZXM3TUpHaUNwRUxyYmVr?=
 =?utf-8?B?L1UxQThTdTVwQytEbnBLZ1R0eWFUU0NPUG9NM0hvRWtTM29ZUkoxV1hLc0ZN?=
 =?utf-8?B?b3czVFhlc1BxR2ZOL0tpcDlQeUtkQ29ianBWbnV0WDR4d2d2eFhGdjRXRWor?=
 =?utf-8?B?M3lKdkNaNGhLMTZtNmNOd2xHZ0ZVdXpGNGMyR0FoVzMrRlczdWorZ3RuR1RH?=
 =?utf-8?B?UUtXQlMyeEtTY2JzZS9BaGlySWNHd29keFYzcHlINmp2dlZBSG5tR0RiL21M?=
 =?utf-8?B?UDN5L3pOa24yK1ZLb0RScVdXQzVRUkJnTGZVclNLUjVzNktIaGVzWWp5V0ZC?=
 =?utf-8?B?OUVodXdxcWFnMnBUbEUvU3VlRnhWZVN4b0FVMTI4YWVBQTBiT2NxMU5sb3Jj?=
 =?utf-8?B?ZnpqUDg5WjRPb0NLTVdSVFZFdXFadnhJNzlDWTFJamdRa0ZCVEt1UFhmSmFq?=
 =?utf-8?B?Ujh5MjFCSEFXOHh3YVNMVmJMUk9QbW94d1ZrMFBubHFDR3E2VGRrci9KQ1oz?=
 =?utf-8?B?YVVRR0MyT0dWclcza0wxY1BHd2crMkZNTUhua3pHOVZvUXlnRVNYZmttZkN2?=
 =?utf-8?B?djRkclNMM0p3NUlUR2dsWmc2SzNLZ011ZGJrZXJRcGk5QU9uY0Y4dWE0WHp6?=
 =?utf-8?B?UXJCeGNXZHI3MDllY3lqYm5xRHlkdjEwRUFJOWQyVVRwMUlHMkpvNEg4NS8v?=
 =?utf-8?B?NHJHUXYrVDhzRVAvS1FjWG8vc2o1WGtCMDFjQ1pZMUt4TmVFNFZDb2E0RmdT?=
 =?utf-8?B?N2ZiUXdKRWdOMkVIbkJwZlpWQjA0aW1IUVZXR1JuamJub3EzN0JDT1VPeGFJ?=
 =?utf-8?B?dU5kb3dnK3NxYkVMallKb3hjM0Rob2FBT1FXY3RYaHNhanlNdVdXQTFpNVpa?=
 =?utf-8?B?cnlWaGd6S1FqTGRwWmxuYys5dnhlSm5ZNEM1alBReCtOTEZoU2FrdWlFc2lF?=
 =?utf-8?B?di9ESmNjMXhtWWJHTVlHMVh0d0l2dVA0ZG9LaXh1N0dsS1Y2TCtqdXZjRkdE?=
 =?utf-8?B?RDFGWmFRdHZKZzZJYU50N1VCZlhCVG95aU80VVlEb3BRMXRRTTVMNkszNGcx?=
 =?utf-8?B?UklmK04rU2oxQ3BldEtOU2lKU01LTk5FZEV3Y2ZqelA4M2IraytCTEpmd3d5?=
 =?utf-8?B?VndvR0NHa0IzRzN6UllIelQwRE9zQ2VFbm9WTEZhK1Z4YVRPZDRGK0ZJWVNJ?=
 =?utf-8?B?bHE2NEhzbFcvckRBYllrakwwZEQzZjFzOXVlSUV6R2dkd2c0UFhoZHJPdFY0?=
 =?utf-8?B?UnVmTDYzYzZsaDVHTHUzTzhwZnlBYktIelFtYjlsTFYzWGQ4OGtQT3cyZzMx?=
 =?utf-8?B?WHBiNzRtdTR6TUNVTC9aZnRab1ZmMm1qS2dZK0VuRnc4NGplelY0d3NDT0k5?=
 =?utf-8?B?bDZTZE1qeHdwUFpaZHJkUDVjZ2p6ZW9ZcnUxZWhiQThGUXptYktNZEdYTUMy?=
 =?utf-8?B?SWVRbUE5UEJHdWZhZUhwUHlvNmpCYUZBVXM1TlZ5anNYV2drYitDZTEvZkNH?=
 =?utf-8?B?QkFDb0FyRkU3elFGeE9oTnRiQVdIZzViWTBlSFFjZnRkVmpCb3FSeStkcFBk?=
 =?utf-8?B?cmJVZThJRUNPS3RwOXJDbDgwaERUcGZQOU1HcWdoZ3VYZVJ1a1VKY2gwTFhP?=
 =?utf-8?B?TVdxdS9QMFJPSFZjc3dGYldtUFM2Z1RhOFczL3BuRGhxRUxYSElDeVYwUHMw?=
 =?utf-8?B?NlNIc2tRSGhDemFuMFlRNHNxenBocmZoNkhyOHJ3ME82YTRVcWJvRTJjM3RC?=
 =?utf-8?B?Rk5wWWozbDZHcTlvMUhoVlpOOWg3Z1duU0Rkb1E3ZmR6VUk0ZVpnbFRWM25k?=
 =?utf-8?B?bnlVbkl6MHNNakE0UUt1eWtmeFEvUjhIVVowZ1puY2Nrc2MvdWNNUjNzNk1Z?=
 =?utf-8?B?bmxLcWRFZThPYzV6NkFna0hqWmpGUkVvZzFkdVJLWlJYbWJKTGlWcWJCa3Js?=
 =?utf-8?Q?/O+oMpvH2gZne/3ofIJW1FkoB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3240.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9904c5d5-e0ad-4f7f-610f-08db0f2383fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 07:09:01.5502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cktbI1sb08mVPh1nQ32wthUtMLg3BcEr86JMPBhvuk1XuVdjXNVt6kKw6calAlohPR5f41YTgifqe2Y072FDtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7734
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

SGkgUm9kb2xmbywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2Rv
bGZvIEdpb21ldHRpIDxnaW9tZXR0aUBlbm5lZW5uZS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRmVi
cnVhcnkgNiwgMjAyMyA0OjE3IFBNDQo+IFRvOiBOLCBQYW5kaXRoIDxwYW5kaXRoLm5AaW50ZWwu
Y29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2FuZ2FubmF2YXIsIE1h
bGxpa2FyanVuYXBwYQ0KPiA8bWFsbGlrYXJqdW5hcHBhLnNhbmdhbm5hdmFyQGludGVsLmNvbT47
IEQsIExha3NobWkgU293amFueWENCj4gPGxha3NobWkuc293amFueWEuZEBpbnRlbC5jb20+OyBU
IFIsIFRoZWplc2ggUmVkZHkNCj4gPHRoZWplc2gucmVkZHkudC5yQGludGVsLmNvbT47IEhhbGws
IENocmlzdG9waGVyIFMNCj4gPGNocmlzdG9waGVyLnMuaGFsbEBpbnRlbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBQUFMgZnVuY3Rpb25hbGl0eSBmb3IgSW50ZWwgVGltZWQgSS9PDQo+IA0KPiBPbiAw
Ni8wMi8yMyAxMToxNiwgTiwgUGFuZGl0aCB3cm90ZToNCj4gPiBIaSBSb2RvbGZvLA0KPiANCj4g
SGkNCj4gDQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFJvZG9s
Zm8gR2lvbWV0dGkgPGdpb21ldHRpQGVubmVlbm5lLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBK
YW51YXJ5IDMwLCAyMDIzIDc6NTcgUE0NCj4gPj4gVG86IE4sIFBhbmRpdGggPHBhbmRpdGgubkBp
bnRlbC5jb20+DQo+ID4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTYW5nYW5u
YXZhciwgTWFsbGlrYXJqdW5hcHBhDQo+ID4+IDxtYWxsaWthcmp1bmFwcGEuc2FuZ2FubmF2YXJA
aW50ZWwuY29tPjsgRCwgTGFrc2htaSBTb3dqYW55YQ0KPiA+PiA8bGFrc2htaS5zb3dqYW55YS5k
QGludGVsLmNvbT47IFQgUiwgVGhlamVzaCBSZWRkeQ0KPiA+PiA8dGhlamVzaC5yZWRkeS50LnJA
aW50ZWwuY29tPjsgSGFsbCwgQ2hyaXN0b3BoZXIgUw0KPiA+PiA8Y2hyaXN0b3BoZXIucy5oYWxs
QGludGVsLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFBQUyBmdW5jdGlvbmFsaXR5IGZvciBJbnRl
bCBUaW1lZCBJL08NCj4gDQo+ID4+IFdpdGhpbiBrZXJuZWwgc291cmNlcyBQUFMgY2xpZW50cyBh
bmQgUFBTIGdlbmVyYXRvcnMgYXJlIHBsYWNlZCBpbnRvDQo+ID4+IGRpZmZlcmVudCBkaXJlY3Rv
cmllcywgc28gSSBzdXBwb3NlIGlzIGJldHRlciB0byBkZXBsb3kgdHdvIGRpZmZlcmVudCBwaWVj
ZXMNCj4gb2YgY29kZS4NCj4gPj4NCj4gPiBXZSBhcmUgcGxhbm5pbmcgdG8gYWRkIGEgbmV3IFBQ
UyBnZW5lcmF0b3IgZHJpdmVyIGluDQo+ID4gZHJpdmVycy9wcHMvZ2VuZXJhdG9ycw0KPiA+IGkp
IENhbiB0aGlzIGRyaXZlciB1c2UgcHBzX3JlZ2lzdGVyX3NvdXJjZSB0byByZWdpc3RlciBJbnRl
bCBUaW1lZCBJL08gZGV2aWNlDQo+IGZvciBwdWxzZSBnZW5lcmF0aW9uID8NCj4gDQo+IE5vcGUu
IFRoaXMgZnVuY3Rpb24gaXMgZm9yIHBwcyBjbGllbnRzIG9ubHkuIFBQUyBnZW5lcmF0b3JzIHNo
b3VsZCBnZW5lcmF0ZQ0KPiB0aGVpciBwdWxzZXMgYWNjb3JkaW5nIHRvIHN5c3RlbSBjbG9jayBz
byB0aGV5IGRvbid0IG5lZWRlZCBhbnkgcmVnaXN0cmF0aW9ucw0KPiBhdCBhbGwgdW5kZXIgUFBT
IGxheWVyLg0KPiANCj4gPiBpaSkgVG8gc3RhcnQvc3RvcCBwdWxzZSwgd2UgYXJlIHBsYW5uaW5n
IHRvIGFkZCBhZGRpdGlvbmFsIHN5c2ZzIGF0dHJpYnV0ZQ0KPiBmcm9tIG91ciBtYWluIGRyaXZl
ci4NCj4gPiBTb21ldGhpbmcgbGlrZSA6IC9zeXMvY2xhc3MvcHBzWC9lbmFibGVfcGluIFRoaXMg
aXMgbmVlZGVkIGZvciB1c2Vycw0KPiA+IHRvIHN0YXJ0L3N0b3AgcHVsc2UgZ2VuZXJhdGlvbi4N
Cj4gDQo+IElmIHlvdSBhcmUgc3RpbGwgdGFsa2luZyBhYm91dCBQUFMgZ2VuZXJhdG9ycyB0aGV5
IGhhdmUgbm8gZW50cmllcyB1bmRlcg0KPiAvc3lzL2NsYXNzL3Bwc1gvIChqdXN0IGNsaWVudHMg
aGF2ZSkuIFNvIHlvdSBjYW4gYWRkIGFuIGVudHJ5IHVuZGVyIHlvdXINCj4gZHJpdmVyIHRvIGRv
IHNvLg0KPiANClRoYW5rcywgd2Ugd2lsbCBhZGQgZW50cnkgaW4gb3VyIGRyaXZlciA6KQ0KPiA+
PiBIb3dldmVyIHBheSBhdHRlbnRpb24gdG8gdGhlIGZhY3QgdGhhdCBhIFBQUyBnZW5lcmF0b3Ig
c2hvdWxkIGJlDQo+ID4+IHJlZmVycmVkIHRvIHN5c3RlbSdzIG1haW4gY2xvY2sgYW5kIG5vdCB0
byBwZXJpcGhlcmFscycgY2xvY2suDQo+ID4+DQo+ID4gV2UgY2FuIHN5bmMgd2l0aCB0aGUgc3lz
dGVtIHRpbWUgZm9yIHB1bHNlIGdlbmVyYXRpb24uDQo+IA0KPiBNbW0uLi4gSSdtIG5vdCBzdXJl
IHRoaXMgaXMgY29ycmVjdCBzaW5jZSBQUFMgZ2VuZXJhdG9ycyBzaG91bGQgZ2VuZXJhdGUNCj4g
dGhlaXIgcHVsc2VzIGFjY29yZGluZyB0byBzeXN0ZW0gY2xvY2sgYW5kIG5vdCBhY2NvcmRpbmcg
dG8gdGhlaXIgaW50ZXJuYWwNCj4gY2xvY2tzIGV2ZW4gaWYgdGhleSBhcmUgc3luY2VkIHdpdGgg
dGhlIHN5c3RlbSBjbG9jay4NCj4gDQpUaW1lZCBJL08gYW5kIHN5c3RlbSB0aW1lIGFyZSBib3Ro
IGRyaXZlbiBieSB0aGUgKnNhbWUqIGhhcmR3YXJlIGNsb2NrLg0KVGltZWQgSS9PIGlzIGEgaGln
aCBwcmVjaXNpb24gZGV2aWNlIChuYW5vc2Vjb25kcyksIGFibGUgdG8gb3V0cHV0IHB1bHNlcy4N
ClRoZSBkcml2ZXIgZ2V0cyB0aGUgc3lzdGVtIHRpbWUgYW5kIHNjaGVkdWxlcyBvdXRwdXQgDQph
dCB0YXJnZXRfdGltZSBpbiB0aGUgZnV0dXJlLiANCg0Kc3RydWN0IHRpbWVzcGVjNjQgY3VycmVu
dF90aW1lOw0KY3VycmVudF90aW1lID0ga3RpbWVfZ2V0X3JlYWxfdHM2NCgmY3VycmVudF90aW1l
KTsNCg0KdGFyZ2V0X3RpbWUgPSBjdXJyZW50X3RpbWUgKyBvZmZzZXRfdGltZTsNCmN5Y2xlcyA9
IHRyYW5zbGF0ZV9zeXN0ZW1fdGltZV90b19jbG9ja19jeWNsZXModGFyZ2V0X3RpbWUpOw0KLyog
VHJhbnNsYXRlIGZ1bmN0aW9uIGlzIGRldmVsb3BlZCBhcyBwYXJ0IG9mIHRoaXMgZHJpdmVyIGRl
dmVsb3BtZW50ICovDQoNCi8qIFNjaGVkdWxlIHB1bHNlIGF0IHRhcmdldF90aW1lICovDQp3cml0
ZV90aW1lZGlvX3JlZyhUSU1FRElPX1RSSUdHRVIsIGN5Y2xlcyk7DQoNClRoZSBvdXRwdXQgYWx3
YXlzIHRyaWdnZXJzIHdpdGggfjIwIG5zIHByZWNpc2lvbi4NCkl0J3Mgbm90IGFmZmVjdGVkIGJ5
IHN5c3RlbSBsb2FkIG9yIG5vIG5lZWQgZm9yIGRyaXZlcnMgdG8gZGlzYWJsZSBpbnRlcnJ1cHRz
IGZvciBsb25nZXIgZHVyYXRpb25zLg0KV2l0aCB0aGlzIGRyaXZlciBwcm9wb3NhbCwgSW50ZWwg
VGltZWQgSS9PIGFzIFBQUyBnZW5lcmF0b3Igd2lsbCBiZSB1c2VmdWwgaW4gSW9UIGFuZCBzZXJ2
ZXIgYXBwbGljYXRpb25zLg0KDQo+IENpYW8sDQo+IA0KPiBSb2RvbGZvDQo+IA0KPiAtLQ0KPiBH
TlUvTGludXggU29sdXRpb25zICAgICAgICAgICAgICAgICAgZS1tYWlsOiBnaW9tZXR0aUBlbm5l
ZW5uZS5jb20NCj4gTGludXggRGV2aWNlIERyaXZlciAgICAgICAgICAgICAgICAgICAgICAgICAg
Z2lvbWV0dGlAbGludXguaXQNCj4gRW1iZWRkZWQgU3lzdGVtcyAgICAgICAgICAgICAgICAgICAg
IHBob25lOiAgKzM5IDM0OSAyNDMyMTI3DQo+IFVOSVggcHJvZ3JhbW1pbmcgICAgICAgICAgICAg
ICAgICAgICBza3lwZTogIHJvZG9sZm8uZ2lvbWV0dGkNCg0KUmVnYXJkcywNClBhbmRpdGgNCg0K
