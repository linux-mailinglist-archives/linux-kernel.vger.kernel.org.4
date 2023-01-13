Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BBD669B96
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjAMPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjAMPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:13:13 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910A963F6A;
        Fri, 13 Jan 2023 07:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673622180; x=1705158180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AfyHsZJfTgZxvPMtqQMjI9CoTukaw6Js0BiK4Qus7D4=;
  b=De/NLS8FCBOoqfEeVK6s7iFtpoETBs/5f1ZjAfwlOY9Cb5Fzf9ikaT1E
   gZLAHX2iEFAnhoaLfY0Zw6bc3zhwAgcL0dH9WFESwa/1XnEagna1uG/t3
   7pflJ5xMO0/FfcAVvCHyv1Q+CQ3vXnltRUcG4fHk4LHZsLZcSQTwGSjzY
   gsCkF+6bVwDtgeZKHHIMpUFN407Wi77Q5NVdO7KECqpsjcsTBRms/spqf
   PPNf6Y6tqQqg1on8kiQlwLkEbGERUVg6zc9qDEj1fGJ8Ku186QO7YtY+M
   4lrbAvwDNesUKn/ZZpYQ9mIcHfZIdwLVD1mmD2xABw7HOu349A20d5O67
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="386355197"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="386355197"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 07:02:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="608188105"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="608188105"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 13 Jan 2023 07:02:58 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 07:02:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 07:02:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 07:02:56 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 07:02:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcZh2J1SP9bahpQC7jrpMFAhSJeSD7CEavbL+9BxdnQhD0ZpZrJiK92ih/wUBsBzm8Cmcaa7zobKMqajOnp1bvyNpspNfr1Z0JYgEUt3m3Mx7BBovtaTDWdspoq1T2g5kuMi4SPhjw/Pzj83SCZkb8bJKAB4pcggPwkPbV2oXWrxYP7+YmjgZHANBnRZgw+nL7kpMzGInSOR9C+GkIDWVZf0VRHkk3hHByudVZ/sF1wYqDGBZ1V0lYMJUdj7OcDhZQB4XNzBetwBgxQltzAIxS3WXOBHZmk7NPsxaQiPmnLZcBE4k1haEm87X4PSvUxbitzWO29xF7hYHVzsvX85cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfyHsZJfTgZxvPMtqQMjI9CoTukaw6Js0BiK4Qus7D4=;
 b=EZlkQ/krZU4eBkemWtzJqWX0fQSz91hItgu/6XwfT+Ts5uevaW/ziaELlQtqARsseS4ezzVG5xdbF/WgMTiA8tvvXSuy/Qlygd0T/0SbC6CcuxwoGetAkaE0BXweKDBdhizKlskZRhDKO+nhYGX8Zb31AfL1sDBvocX2PsB08BQs62da+qyFzAr9fmSfoiXkVIzdEdrLrDBhZPsGvtOJfjGwc8EeZVzY0733wuW4Ca5II8B/d+EvUVW5Am9LOHXn2o7M/FSsoW3wqqRjJSt8XDoaQOOi8YynhmAd4jOJvApueX+6bLptQEzz6FGoSdfnt0sihFKEkxfJdm90cOMl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MW4PR11MB6886.namprd11.prod.outlook.com (2603:10b6:303:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 15:02:54 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 15:02:54 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Fix the start_poll_synchronize_rcu_expedited() be
 invoked very early
Thread-Topic: [PATCH v2] rcu: Fix the start_poll_synchronize_rcu_expedited()
 be invoked very early
Thread-Index: AQHZJlrAbelW6ZjuBUWwM88Mxg3+Hq6bJV4AgADo4SCAADQ80IAALT2AgAAAnAA=
Date:   Fri, 13 Jan 2023 15:02:54 +0000
Message-ID: <PH0PR11MB588004418C299781FE6738BFDAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230112075629.1661429-1-qiang1.zhang@intel.com>
 <20230112190656.GR4028633@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588074A87AC454A7F0E42A5ADAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB588008A9BBAFA6BEEC8685ABDAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20230113144919.GY4028633@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230113144919.GY4028633@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|MW4PR11MB6886:EE_
x-ms-office365-filtering-correlation-id: 40ac75f7-62d0-4dc2-20ab-08daf5773f77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yeu3Q606+ujYpgIWy62noNkAMJcJA1uF94CwvmXr11x+EEaKKxi8lG+pyfrp//eHHmpl89et2zXmppIQo6KPrV2AKG0b1F7tA6cuVvDrJe13o5W1p4LD7LpQHJw1GpVQs8W5RL4IiX7wRq+tB6aIvj0oLasJhnuoxTm1hhiTW0p+JVktJg7HDu2X4Fd/GEc59zsMW9ZEOCZNQ/uNmJxQ8Tj3V9DzJhfx1e07ncQTRkSfCU6gdiIvs+7jvFALmLu+eNu5QXWyD8+iKpOxktFt8CFobB/4LoQLokhn0t9y2ljLu3iFzPciwRFy+A6zJGR1iiy7eOQfTTbkG+uOL04NamDXCdHquKLdtqFLEuZ4+OHoxLgtoqrf0hp7OWYiUEhVRZjVkYrCJrfVJFG6aWovnBmqX1KrwFwtB2rT+d9vDWclR8GQ/O7RhL5ceWXpFjtnS4SQ0f+Py75BWfZx8jUgOCQ0O2xdnmJS+J0sbNOBOqQgiO35NLM2C3F53auoVX8P5pa77Yd0UfubZEU2z3uMXFEU0jBExvhORRsW8+DkY/t7n3Uzggfgvd1zEq008HSjfkIv8YQTKZthgleomyeQviNGvMlsBpW9+tNYhJpkbgzBSwKCL0yagNkfe3tGf7gTl/dWQ5pA36N+bNWKlF7x/eTbfr7FlreG4f6Nw+hu/kDUmzC0BjBdCFztXNidhauMKAyrnVSU0e+2E7BK2Tc29Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(41300700001)(4326008)(66446008)(83380400001)(66946007)(8676002)(54906003)(6916009)(64756008)(76116006)(66476007)(316002)(66556008)(86362001)(38070700005)(5660300002)(8936002)(82960400001)(38100700002)(122000001)(33656002)(52536014)(55016003)(2906002)(6506007)(71200400001)(478600001)(9686003)(186003)(26005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzR6QlFjai92MDNIR0JCcDBldlR2V3FGSFJlSnp0cjB5L2hIRDhyeDlCOWV6?=
 =?utf-8?B?RFFucDBwMW5HUmRhRy9YTXFqOFBQU3ZkYXRrenEvSjlJaDc4dGgxWVIzNm9o?=
 =?utf-8?B?UEFXd3R3UDNRRi9Zb00rN1lGZzJBTnB6d1FWOVIrRm54ZnVHMFU2YjRRaDhn?=
 =?utf-8?B?WmR4RURGVnRqc2UzbDk3em1BNWZYN0pBMnNFT1p5MjJqSkRWYWY0U01rQVln?=
 =?utf-8?B?Qkd3RVFNbWQ3NlNDK1Erd080R2ZxVkhmMHNYZ0t1K0Y2dGZJTkovNzN0ekp5?=
 =?utf-8?B?bUVVMHFoMG5wT0FXcFJiM0ZZKzByNWV5N2Y1aVRxOUtyUm02YW1XeGJ5eVhJ?=
 =?utf-8?B?VnJETnRiUVl2d0U5alVSa09yV21vU1FnK2hIbWNaR09BKzBvamo1L1FkZE1F?=
 =?utf-8?B?VzM5bC8zQ0x2N2VlQ2RaTU5mL1Q4WFVGMm9MM1lRZ3VUbzJPOGNidk05ZWRl?=
 =?utf-8?B?VjdRZnZYL1NFekcwdmlrS3pNWnFSeWhQVEVuOWtSZW5VMXZuSFJrRGNoQ2NL?=
 =?utf-8?B?Sk1LdlZSY0xoeEE1d1ZRT3hyREJpYm5CYjdqTTVhQlp3bUFmclh6Mk0rd2g0?=
 =?utf-8?B?cndPOGROeWxsTHdZUWFBa21VN3Vya0twV0Y5TnRveGZrNWNUM09BVmlHTmQ5?=
 =?utf-8?B?VnEzd1FZSzE3YStEczg2V29kcmZTNnh2azNUUEtlV2QwUHdCTTFOaGUwMUwz?=
 =?utf-8?B?Tkh0Q1VIVU40WXVReXAvUHA0YjRIZnpjMmlVMjlvQnBNZ2Y1TVNJTDFtaDVu?=
 =?utf-8?B?eEFVdkwyaWoxWGMxRHJxb2ZYV3ZwWkpsbWdoM0VpdjRHSkVyNDBKUzhFV0pJ?=
 =?utf-8?B?bmRuUC9NMWhHVERBdHFjSXNDM2xpQzJxZEk4aytoTjJOVGM4YngrOW1pUUhr?=
 =?utf-8?B?L21ZaGJzQWx6Nmc2SUZMd2pUak5tV2RpZWM5Rnpjd2R0NlB3ZXYxZkJITzc2?=
 =?utf-8?B?LzRQYjk3RW5tc0V4aFRvbUpROWppL1dVQW5QUXZTNEVOQ1RjVndZRVdmR0pH?=
 =?utf-8?B?RTJ2dmNHUy9pbkl5ZzRJZHFBSXBaNEhYRTd0L1NHMGMvYVFUT3kwN1ZQWXVV?=
 =?utf-8?B?QWZoMjRKTVEwMjlVUUtxc3FEYWZZcVBIRE9iZ3RQdVIwQTNSSkZPeEhKaFZr?=
 =?utf-8?B?b2NPcDZSQ2txR3hxRWo3OEF0RU5RblBNcGE0QmVkcXpOSi96OXo4MEpsSzgx?=
 =?utf-8?B?ZHpsdlExTlVhR2lCcnNxU3dHcEpkOHZyVTNBc1ZqODhUeEFKMkI4SEc2L1dM?=
 =?utf-8?B?dFF6WksvVWR1STRoOGd0OThISnR3Ymd4eGVXL3I2QXUyRk9ONzQvaXlwQk5X?=
 =?utf-8?B?V3lqVEo1SkVlU1ZkNTBzdnFpMDI4QlZRL1J6aWNKb0psd3EyWW13MVhWTHIz?=
 =?utf-8?B?cUFxYUpSZk4vOFNhc0xpZlhWK3Q4blA0TmpuYVgxYkNaQXkxNjl1SDNGdm9D?=
 =?utf-8?B?T2hWVW1FbWt0eTlZekM3MnRjVzdUWUtnNUtzczdiTjNjaGJwaU85a2QyVllF?=
 =?utf-8?B?V2kvUDhJU3UwY2lDRVVvVGRNRWlVN3Z1VkJBVnpYdWphQlNBUDU3M2Fxb2c4?=
 =?utf-8?B?QTg4VmlNMlFQajdTOUswWW42eXFNQnpLaGszNkhlcG9WWWFuRUlRTzNBaW9p?=
 =?utf-8?B?QmZtZTlVUS92TVU3MmNtU1RwNDBObDlra3ZwdEFZVUxlcTFsQUVTd0tSVXpZ?=
 =?utf-8?B?dXhDeC9CQVpLQ0NXQ3YyZlFWcE91YTdFeU5FOTJkRDB4QVVzaWdRdTNPWnNs?=
 =?utf-8?B?Qit1d1d1NGJnUS9pcDBDZjhqamVYWW0zNU1iZ3Z4ejRkVnRocG1xTDE4UGt1?=
 =?utf-8?B?Q2JRNDRReWtOanQvK0h4dzZweG5LTEVYV3Y2MWFlMnpqY3A5WjhURUxNN05k?=
 =?utf-8?B?UWMwb2FGOVg2b1lqOURSaU0vcnVFcUJLZDcrLzhUZzV0UmpVN1Y4aU10WjZX?=
 =?utf-8?B?YTZRMkdtSVYwQXp0NUNhbDc3akpoUUVTYi9Lclo1L1FyRHZEZzlFaFNwVzdT?=
 =?utf-8?B?cDlMR2ppYlIxUUVneDdUclpwaW5WRHVDSXl1aU9OVllKdm1UZEhvdi9pS0Rw?=
 =?utf-8?B?dEFHSXVZbFR1RnZMMjI3SFlLTm9JcFF5TDhKei9qWjBEYjdoRy83Z1ZtcFIz?=
 =?utf-8?Q?G2kZgoPTOqRTDlNVVxWghTiLT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ac75f7-62d0-4dc2-20ab-08daf5773f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 15:02:54.0406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhhW7YK2bYXWMjRBtRfwpJvhPR2seWvUdGUCdYpbc52JEKJggN4lFIvofcwswzRVD0WmPmIFPNk3jeLfTAkSuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6886
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKYW4gMTMsIDIwMjMgYXQgMTI6MTA6NDdQTSArMDAwMCwgWmhhbmcsIFFpYW5nMSB3
cm90ZToNCj4gDQo+ID4gQ3VycmVudGx5LCB0aGUgc3RhcnRfcG9sbF9zeW5jaHJvbml6ZV9yY3Vf
ZXhwZWRpdGVkKCkgY2FuIGJlIGludm9rZWQNCj4gPiB2ZXJ5IGVhcmx5LiBiZWZvcmUgcmN1X2lu
aXQoKSwgdGhlIHJjdV9kYXRhIHN0cnVjdHVyZSdzLT5teW5vZGUgaXMgbm90DQo+ID4gaW5pdGlh
bGl6ZWQsIGlmIGludm9rZSBzdGFydF9wb2xsX3N5bmNocm9uaXplX3JjdV9leHBlZGl0ZWQoKSBi
ZWZvcmUNCj4gPiByY3VfaW5pdCgpLCB3aWxsIHRyaWdnZXIgYSBudWxsIHJjdV9ub2RlIHN0cnVj
dHVyZSdzLT5leHBfc2VxX3BvbGwgYWNjZXNzLg0KPiA+IA0KPiA+IFRoaXMgY29tbWl0IGFkZCBi
b290X2V4cF9zZXFfcG9sbF9ycSBtZW1iZXIgdG8gcmN1X3N0YXRlIHN0cnVjdHVyZSB0bw0KPiA+
IHN0b3JlIHNlcSBudW1iZXIgcmV0dXJuIGJ5IGludm9rZSBzdGFydF9wb2xsX3N5bmNocm9uaXpl
X3JjdV9leHBlZGl0ZWQoKQ0KPiA+IHZlcnkgZWFybHkuDQo+ID4gDQo+ID4gRml4ZXM6IGQ5NmM1
MmZlNDkwNyAoInJjdTogQWRkIHBvbGxlZCBleHBlZGl0ZWQgZ3JhY2UtcGVyaW9kIHByaW1pdGl2
ZXMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4N
Cj4gPg0KPiA+Rmlyc3Qgb2ZmLCBleGNlbGxlbnQgY2F0Y2gsIFpxaWFuZyEhIQ0KPiA+DQo+ID5B
bmQgdGhhbmsgeW91IGZvciBGcmVkZXJpYyBhbmQgSm9lbCBmb3IgeW91ciByZXZpZXdzLg0KPiA+
CQ0KPiA+QnV0IEkgYmVsaWV2ZSB0aGF0IHRoaXMgY2FuIGJlIHNpbXBsaWZpZWQsIGZvciBleGFt
cGxlLCBhcyBzaG93biBpbg0KPiA+dGhlICh1bnRlc3RlZCkgcGF0Y2ggYmVsb3cuDQo+ID4NCj4g
PlRob3VnaHRzPw0KPiA+DQo+ID5BZ3JlZSwgdGhhbmtzIGZvciB3b3Jkc21pdGhlZCAg8J+Yii4N
Cj4gPg0KPiA+DQo+ID5BbmQgeWVzLCBJIGRpZCBwcmVzdW1wdHVvdXNseSBhZGQgRnJlZGVyaWMn
cyBhbmQgSm9lbCdzIHJldmlld3MuDQo+ID5QbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IGRpc2Fn
cmVlLCBhbmQgaWYgc28gd2hhdCBkaWZmZXJlbnQgYXBwcm9hY2gNCj4gPnlvdSB3b3VsZCBwcmVm
ZXIuICAoVGhvdWdoIG9mIGNvdXJzZSBzaW1wbGUgZGlzYWdyZWVtZW50IGlzIHN1ZmZpY2llbnQN
Cj4gPmZvciBtZSB0byByZW1vdmUgeW91ciB0YWcuICBOb3QgaG9sZGluZyB5b3UgaG9zdGFnZSBm
b3IgaW1wcm92ZW1lbnRzLA0KPiA+bm90IHlldCwgYW55d2F5ISkNCj4gPg0KPiA+CQkJCQkJCVRo
YW54LCBQYXVsDQo+ID4NCj4gPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+DQo+ID5jb21taXQgZTA1YWY1
Y2IzODU4ZTY2OWM5ZTZiNzBlMGFjYTcwOGNjNzA0NTdkYQ0KPiA+QXV0aG9yOiBacWlhbmcgPHFp
YW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+ID5EYXRlOiAgIFRodSBKYW4gMTIgMTA6NDg6MjkgMjAy
MyAtMDgwMA0KPiA+DQo+ID4gICAgcmN1OiBQZXJtaXQgc3RhcnRfcG9sbF9zeW5jaHJvbml6ZV9y
Y3VfZXhwZWRpdGVkKCkgdG8gYmUgaW52b2tlZCBlYXJseQ0KPiA+ICAgIA0KPiA+ICAgIEFjY29y
ZGluZyB0byB0aGUgY29tbWl0IGxvZyBvZiB0aGUgcGF0Y2ggdGhhdCBhZGRlZCBpdCB0byB0aGUg
a2VybmVsLA0KPiA+ICAgIHN0YXJ0X3BvbGxfc3luY2hyb25pemVfcmN1X2V4cGVkaXRlZCgpIGNh
biBiZSBpbnZva2VkIHZlcnkgZWFybHksIGFzDQo+ID4gICAgaW4gbG9uZyBiZWZvcmUgcmN1X2lu
aXQoKSBoYXMgYmVlbiBpbnZva2VkLiAgQnV0IGJlZm9yZSByY3VfaW5pdCgpLA0KPiA+ICAgIHRo
ZSByY3VfZGF0YSBzdHJ1Y3R1cmUncyAtPm15bm9kZSBmaWVsZCBoYXMgbm90IHlldCBiZWVuIGlu
aXRpYWxpemVkLg0KPiA+ICAgIFRoaXMgbWVhbnMgdGhhdCB0aGUgc3RhcnRfcG9sbF9zeW5jaHJv
bml6ZV9yY3VfZXhwZWRpdGVkKCkgZnVuY3Rpb24ncw0KPiA+ICAgIGF0dGVtcHQgdG8gc2V0IHRo
ZSBDUFUncyBsZWFmIHJjdV9ub2RlIHN0cnVjdHVyZSdzIC0+ZXhwX3NlcV9wb2xsX3JxDQo+ID4g
ICAgZmllbGQgd2lsbCByZXN1bHQgaW4gYSBzZWdtZW50YXRpb24gZmF1bHQuDQo+ID4gICAgDQo+
ID4gICAgVGhpcyBjb21taXQgdGhlcmVmb3JlIGNhdXNlcyBzdGFydF9wb2xsX3N5bmNocm9uaXpl
X3JjdV9leHBlZGl0ZWQoKSB0bw0KPiA+ICAgIHNldCAtPmV4cF9zZXFfcG9sbF9ycSBvbmx5IGFm
dGVyIHJjdV9pbml0KCkgaGFzIGluaXRpYWxpemVkIGFsbCBDUFVzJw0KPiA+ICAgIHJjdV9kYXRh
IHN0cnVjdHVyZXMnIC0+bXlub2RlIGZpZWxkcy4gIEl0IGFsc28gcmVtb3ZlcyB0aGUgY2hlY2sg
ZnJvbQ0KPiA+ICAgIHRoZSByY3VfaW5pdCgpIGZ1bmN0aW9uIHNvIHRoYXQgc3RhcnRfcG9sbF9z
eW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKA0KPiA+ICAgIGlzIHVuY29uZGl0aW9uYWxseSBpbnZv
a2VkLiAgWWVzLCB0aGlzIG1pZ2h0IHJlc3VsdCBpbiBhbiB1bm5lY2Vzc2FyeQ0KPiA+ICAgIGJv
b3QtdGltZSBncmFjZSBwZXJpb2QsIGJ1dCB0aGlzIGlzIGRvd24gaW4gdGhlIG5vaXNlLiAgQmVz
aWRlcywgdGhlcmUNCj4gPiAgICBvbmx5IGhhcyB0byBiZSBvbmUgY2FsbF9yY3UoKSBpbnZva2Vk
IHByaW9yIHRvIHNjaGVkdWxlciBpbml0aWFsaXphdGlvbg0KPiA+ICAgIHRvIG1ha2UgdGhpcyBi
b290LXRpbWUgZ3JhY2UgcGVyaW9kIG5lY2Vzc2FyeS4NCj4gDQo+IEEgbGl0dGxlIGNvbmZ1c2Vk
LCB3aHkgIGNhbGxfcmN1KCkgaW52b2tlZCBwcmlvciB0byBzY2hlZHVsZXIgaW5pdGlhbGl6YXRp
b24gdG8gbWFrZSB0aGlzIGJvb3QtdGltZQ0KPiBncmFjZSBwZXJpb2QgbmVjZXNzYXJ5IPCfmIo/
DQo+DQo+QmVjYXVzZSB0aGVuIHRoZXJlIHdpbGwgYmUgYSBjYWxsYmFjayBxdWV1ZWQgdGhhdCB3
aWxsIHJlcXVpcmUgYSBncmFjZQ0KPnBlcmlvZCB0byBydW4gYW55d2F5Lg0KPg0KPk9yIG1heWJl
IHlvdSBhcmUgYXNraW5nIGlmIHRob3NlIGNhbGxiYWNrcyB3aWxsIHJlYWxseSBiZSBhYmxlIHRv
IHVzZQ0KPnRoYXQgZmlyc3QgZ3JhY2UgcGVyaW9kPw0KDQpZZXMsIGJlY2F1c2UgZXZlbiBpZiB3
ZSBxdWV1ZSB3b3JrIHRvIHJjdV9ncF93cSB3b3JrcXVldWUsIHRoaXMgYWxzbyByZXF1aXJlcyB1
cyB0byB3YWl0IHVudGlsDQp0aGUgd29ya3F1ZXVlX2luaXQoKSBpcyBpbnZva2VkLCBvdXIgd29y
ayBjYW4gYmUgZXhlY3V0ZS4gYW5kIGFsc28gbmVlZCB0byB3YWl0IGZvciB0aGUNCnJjdV9ncCBr
dGhyZWFkIHRvIGJlIGNyZWF0ZWQsIGFmdGVyIHRoaXMsIG91ciBmaXJzdCBncmFjZSBwZXJpb2Qg
Y2FuIGJlZ2luLCB0aGUgY2FsbGJhY2tzIGhhcyB0aGUNCm9wcG9ydHVuaXR5IHRvIGJlIGNhbGxl
ZC4gIHRoZSBjYWxsX3JjdSgpIHJlcXVpcmUgYSBncmFjZSBwZXJpb2QsIGJ1dCB3ZSByZXF1aXJl
IGlzIGV4cGVkaXRlZCBncmFjZSBwZXJpb2QuDQoNClRoYW5rcw0KWnFpYW5nDQoNCj4NCj4JCQkJ
CQkJVGhhbngsIFBhdWwNCg0KPiBUaGFua3MNCj4gWnFpYW5nDQo+IA0KPiANCj4gPiAgICANCj4g
PiAgICBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+ID4g
ICAgUmV2aWV3ZWQtYnk6IEZyZWRlcmljIFdlaXNiZWNrZXIgPGZyZWRlcmljQGtlcm5lbC5vcmc+
DQo+ID4gICAgUmV2aWV3ZWQtYnk6IEpvZWwgRmVybmFuZGVzIChHb29nbGUpIDxqb2VsQGpvZWxm
ZXJuYW5kZXMub3JnPg0KPiA+ICAgIFNpZ25lZC1vZmYtYnk6IFBhdWwgRS4gTWNLZW5uZXkgPHBh
dWxtY2tAa2VybmVsLm9yZz4NCj4gPg0KPiA+ZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdHJlZS5j
IGIva2VybmVsL3JjdS90cmVlLmMNCj4gPmluZGV4IDYzNTQ1ZDc5ZGE1MWMuLmYyZTNhMjM3Nzhj
MDYgMTAwNjQ0DQo+ID4tLS0gYS9rZXJuZWwvcmN1L3RyZWUuYw0KPiA+KysrIGIva2VybmVsL3Jj
dS90cmVlLmMNCj4gPkBAIC00OTM3LDkgKzQ5MzcsOCBAQCB2b2lkIF9faW5pdCByY3VfaW5pdCh2
b2lkKQ0KPiA+IAllbHNlDQo+ID4gCQlxb3ZsZF9jYWxjID0gcW92bGQ7DQo+ID4gDQo+ID4tCS8v
IEtpY2stc3RhcnQgYW55IHBvbGxlZCBncmFjZSBwZXJpb2RzIHRoYXQgc3RhcnRlZCBlYXJseS4N
Cj4gPi0JaWYgKCEocGVyX2NwdV9wdHIoJnJjdV9kYXRhLCBjcHUpLT5teW5vZGUtPmV4cF9zZXFf
cG9sbF9ycSAmIDB4MSkpDQo+ID4tCQkodm9pZClzdGFydF9wb2xsX3N5bmNocm9uaXplX3JjdV9l
eHBlZGl0ZWQoKTsNCj4gPisJLy8gS2ljay1zdGFydCBpbiBjYXNlIGFueSBwb2xsZWQgZ3JhY2Ug
cGVyaW9kcyBzdGFydGVkIGVhcmx5Lg0KPiA+Kwkodm9pZClzdGFydF9wb2xsX3N5bmNocm9uaXpl
X3JjdV9leHBlZGl0ZWQoKTsNCj4gPiANCj4gPiAJcmN1X3Rlc3Rfc3luY19wcmltcygpOw0KPiA+
IH0NCj4gPmRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWVfZXhwLmggYi9rZXJuZWwvcmN1L3Ry
ZWVfZXhwLmgNCj4gPmluZGV4IDk1NmNkNDU5YmE3ZjMuLjNiN2FiYjU4MTU3ZGYgMTAwNjQ0DQo+
ID4tLS0gYS9rZXJuZWwvcmN1L3RyZWVfZXhwLmgNCj4gPisrKyBiL2tlcm5lbC9yY3UvdHJlZV9l
eHAuaA0KPiA+QEAgLTEwNjgsOSArMTA2OCwxMCBAQCB1bnNpZ25lZCBsb25nIHN0YXJ0X3BvbGxf
c3luY2hyb25pemVfcmN1X2V4cGVkaXRlZCh2b2lkKQ0KPiA+IAlpZiAocmN1X2luaXRfaW52b2tl
ZCgpKQ0KPiA+IAkJcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZybnAtPmV4cF9wb2xsX2xvY2ssIGZs
YWdzKTsNCj4gPiAJaWYgKCFwb2xsX3N0YXRlX3N5bmNocm9uaXplX3JjdShzKSkgew0KPiA+LQkJ
cm5wLT5leHBfc2VxX3BvbGxfcnEgPSBzOw0KPiA+LQkJaWYgKHJjdV9pbml0X2ludm9rZWQoKSkN
Cj4gPisJCWlmIChyY3VfaW5pdF9pbnZva2VkKCkpIHsNCj4gPisJCQlybnAtPmV4cF9zZXFfcG9s
bF9ycSA9IHM7DQo+ID4gCQkJcXVldWVfd29yayhyY3VfZ3Bfd3EsICZybnAtPmV4cF9wb2xsX3dx
KTsNCj4gPisJCX0NCj4gPiAJfQ0KPiA+IAlpZiAocmN1X2luaXRfaW52b2tlZCgpKQ0KPiA+IAkJ
cmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnJucC0+ZXhwX3BvbGxfbG9jaywgZmxhZ3MpOw0K
