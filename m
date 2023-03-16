Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAD66BD185
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjCPNyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjCPNxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:53:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB8AB1A64;
        Thu, 16 Mar 2023 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678974827; x=1710510827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HErVSN0Hcl64M7kIVlUw6mPslWqxZFO+cMD0IPCed1s=;
  b=NrHpZay92OaIfqhA8lcn9fheBkXKzaQPoLdil2XeSU5L4ydlSL72Hd9+
   Zh2AjiF5Fv7sYgoecPdEplDKKKpH19Q+O4Coj6ItqtMzq6moZ2DMFZxVw
   YonCL07j5zrJ3aWx8OxcNYzHsIoyOxMDrfEo/OniuoRoi5ebvPUm/4iZB
   nYexbPFhhRF3vHxXTtY0yj9EQnmrfdhLiGylYNZeJzTmQB87b8vjOC57V
   pzPQnc2yYkoQUnuxkmpuFqNYzsHnnLpWHC7H1qU9FhHgGDOjQ3IZVc/OV
   4yduj7YZTBwwSMhmKqCHDWrUc9zIjIz7tcgiC/TBU+qh0lBGQ/PVc7QUQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424265352"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="424265352"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 06:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009225340"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009225340"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2023 06:53:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 06:53:46 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 06:53:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 06:53:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 06:53:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mn5zWjDf60DWGUUZN25lIJCuumd5WGCD4jpfM4Pv2S+wdFbYgsjBog2UkqzN1SvJrEplbD0rGZOHWfUmqloXCxVVe3hHVigbnYz2OT+07GkABdILXiI0esKXgKzjuNYGdpDbJDMXggOYEzbZc/PkNcXS+TxMnJohddh9zGNuheONgHsEPJ4cLu064k8Yq8ziQFpaTHKb/pc9h+Jo2mNGgB4FVELn+RelxP6Oc941OokdrBjjGm2WpwCm3X4oykgaT8gdST23Cc6YuYoz9U7IohSCwIaaRTgv6acZeifbI+wYFAJ6nEoCou7HR+uFsRI9+70kwlxv7d/w5pdh1dvHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HErVSN0Hcl64M7kIVlUw6mPslWqxZFO+cMD0IPCed1s=;
 b=TpHaSTVnyLtqPFGc0RcZL28aGcFuKHDqAQg5p9lB93VO2IZvq/y+3A8rRUIHxeNHX06OigiuXxBdRHGm3N8LzioO15i7HF1NNPPSqbAOOJ0K55lWOwaPA9eT38hnKu3XTYOoOgoOb8ys0un/o8FZd0UFWivUyJeCINJpgmkpAgDiprn2i/M9BI7XoVXlLJKMn2j8oBUjeU0I4CLdxgaFP7nD17MTty+oVVGu45t1oj5QLszl6FMsZljrO8XmEDO7uyZBya2cbruDdzcdxsBWTNrAjmJ2N3/0oX/wJdcaEwq6vezII5JQEJ3E8OpnDRbVBQNWE17EB9M8hStS4bCRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 13:53:43 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601%9]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 13:53:43 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s) after
 unloading rcuscale
Thread-Topic: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Thread-Index: AQHZVYJ6y9lPL1nBiUy5prGqw8pyma765zaAgADmYLCAABeigIAALuYAgAFQWLCAAAbrgIAAArGA
Date:   Thu, 16 Mar 2023 13:53:43 +0000
Message-ID: <IA1PR11MB6171C7FEE026F421A3CD6A9689BC9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <IA1PR11MB61714FEEAF2C46639891401A89BC9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <2B9F2C1A-B274-41EF-8ABE-1E660521BCE4@joelfernandes.org>
In-Reply-To: <2B9F2C1A-B274-41EF-8ABE-1E660521BCE4@joelfernandes.org>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: paulmck@kernel.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH0PR11MB7447:EE_
x-ms-office365-filtering-correlation-id: a5f28345-2d52-4624-0a1c-08db2625db06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RizwKL4bJ52ZrckL7S4RYG2cr+8RrWotQvfMUqiaA5+Gw2Uv+Ukfn2OuNtAXr6Dtuoi6bJF7onwWHETusMb27/KOJYzwp5C/7s49ELLLzNft+k+1DJ095HaKeX5DEjoqPR8qOs02MZUJltjvY9BaOGBEmR84GZ4ToZKezUBaLJVwYvtKzvHo3HfqUGgVt138GNtAk4RFEhf7dH0ykDkGYy5Fpp8M4JRJ/zkbYz5dlr2Y/w4fAnJVxzzM9EsCL+gtxGfn4I1M+FwVoOCaalwaQFpY2SIIKu14QrGId4LdQz9/t719CyVhksKN73wjKyv4NbND0tkdG3I9lGeYFpSRFuVgMk+89z+DGNy+Ski6Q3pN0FbRGcdY324OsrOkQdY06iD/ij4tDIV3iApw+VuWWdXdFu3fbAkBOyHDrgX6LczPP8HDU2JtbgEfzYgAQq2XA6EHdOH/QBoFG0iB975o8kHRRhoUprknen0oo8AWdLpxO5u9+Iu8at76kJVR6x22cjFtSJcVDet0ipgNSRAEH4lHSCH8taStIcGZw1CtiLmBuIZRhckUalH94FrppxlcclHtT5d4CfKVjIXUa+Idm5fenZQCQesde0jYM1k/WAkqChe3PwSBG5RzlnJNLdy0VLsIVame4rmftIAewC/fuRL3PNrmU+gboJaSJ82CfTjeAqxLfFWp323m1GEHypbVEU5o/rB7OMMTCAaEeJKgRgUEZjwVT+CrO3/pYyp5hG8qegk2AafK0zn0IRIjYpRq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199018)(33656002)(52536014)(5660300002)(41300700001)(7416002)(8936002)(2906002)(38070700005)(38100700002)(86362001)(82960400001)(122000001)(478600001)(66556008)(66476007)(64756008)(66446008)(71200400001)(8676002)(76116006)(66946007)(7696005)(4326008)(9686003)(6506007)(55016003)(54906003)(316002)(110136005)(83380400001)(186003)(26005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEZIWXRVNTc5cWlwTDdiV1VJYVJZdHJTVFBEZk1weUhuV21vQzFuRGdSWkg5?=
 =?utf-8?B?VStKQlRBbkV4SmhZM0pUQ2RNQkdES1ptSlhLR0ZGcU1paHR1OGtUVEtPS3Q1?=
 =?utf-8?B?M0ZVblpuNzhaY0lUWGF5THUxeCtSNkJUWHhmamhsSHgyVkZCRFplSytTdnNa?=
 =?utf-8?B?cDFGY0N6QzJIM2s2SU1xeUloZ1R5UDh6cXF5VmU0TTBzMzcyWW9xbHk4cmZy?=
 =?utf-8?B?RHhzbENBN2lxaXVXR01ILzVyK1ZrMEtsMWJadnI3Y0M0ek9BbWtFdU0vS1l1?=
 =?utf-8?B?ZFp5U0lWd21zeTNpWldlUWtMRDlMK1NVaTRzMnBySWFLRzNJbkJFSWhpVTBt?=
 =?utf-8?B?WXNOOXR3dzd6bzNGaFJDOFQrWjZ5ZkloNkN5UU80U3NiNExlNEdYazB4eDYv?=
 =?utf-8?B?bnIxUmNlY0cvMVRGRml1SlBudXo0cEpuN2hWVm1BUzQycHZiV0IwbXhRREtt?=
 =?utf-8?B?c3RmWDdYeTBzQXcxbHgvQVdHTHptcGVOc2h2MGd5Vmt2dUw3aTZ0aFRWTU9E?=
 =?utf-8?B?ZGp1TUFJZXlzZFMzdUhoV3ZSVXkvSUI0dS9NcWVPaTdxbjZZNGVpWTRVZ3BO?=
 =?utf-8?B?UExzK0VJaHoyTCtzMVhlVlg2R1FnbGpTVFdXZ3FhS2hQc3ZmUVRLK201UUR5?=
 =?utf-8?B?VHVmQnVMVk04V1h1VHllY2xaN1d6NDFjVVRxb2ZVYTU4dFU3aE5oNEJuK0Rz?=
 =?utf-8?B?M3U1blhIdXNMWUZpVHFwb3dFYXNLb3ZqMEhnNXNTTzRGdWlBa3JWaExBNGNE?=
 =?utf-8?B?THNoNUZKTkZtYllSVGJmeGtRNitwME5VV3JkSXdHYmcwVzhzcmpyT0dqM0Vn?=
 =?utf-8?B?RW9Zdmc5VjVCUVc3dHpFRmhLNk82KytYNENLNFM5NmhxWlpkeGNwVkU3bnY3?=
 =?utf-8?B?cDhYUDd6aW1NUStxU3RWbzlzZXRZdnM3K0lZczVCNzROVGQ3Uk9VZ3IwbUhj?=
 =?utf-8?B?bHBKNWtDNlptcUZjT2RKcHV1YWFBREw5T3FJWlV4c0cwaUdxU2Y0eGtjZnN2?=
 =?utf-8?B?d1g0N0Q4NzdUMmdtSzhLVXFOZUNNVFZYZ09SMnJIcnZmZEdPOHRBdmcyYmFK?=
 =?utf-8?B?WnlNZUlSb0Q4RE5FUEJMTGN4eUUrS1dhcWxtVVUxMXpYT1RCSnlERnhDL1Np?=
 =?utf-8?B?dU96aGIveTFMMVhXMFhQaXlEN2dpV3FNbzdpWFc5NzcrMWdaSnkzck96TVhG?=
 =?utf-8?B?VVlDWnZTeDdBUXp4S3FCRFR5NTl3RFlZZFpwQ0RtUHRGRWpJMXJaZ0JxOEwv?=
 =?utf-8?B?WHVvWmFpVnJFc2lkb083V2FOeU5MYUhhcTlnMVZNNDBKNytTNDNPeGw1YUxL?=
 =?utf-8?B?NjVQa0tWSitmcFJPa0ppTHVGTFNDdC9aUEY2c0hlMXIxaDFFb1dYbUhTd0dq?=
 =?utf-8?B?WEx1cTJvajBWVWhFYkt0Wmd3RU1FT3JkdmhwWU1DWEd3YjJCOCt5cCsyZXBM?=
 =?utf-8?B?U2lXU1RKbTZCRktvUlUveWtBVGQ2cUxWWUp4Z3NTWmY4TDgxSWNoazBhZ1Zy?=
 =?utf-8?B?R09DczNpUkNMdkFoK0MzWFFsRnErM1hCU3pZdExXZkQ2YUkvSXU2UG1XYTRm?=
 =?utf-8?B?UU1halRpd1poVDFUdi8xRzA5d29BaXNZaktEbkp4T1R6VGRXYXpkUDlhY2xX?=
 =?utf-8?B?bnNqV2NBeFBzb1VjZjArc3BsNVhIQmFFejM3ZjEya2VGSEllL3JjUXgzT1Uv?=
 =?utf-8?B?eWJuMWxBSUwyelZtbHFRcmx0d28zOTZGeFlmS0gwbmNHMTVSc2RlZTVxYW91?=
 =?utf-8?B?TEg0RzhMR21zNGgyNWV2amF1SE9PZ0daRWduRUdYZktpSjJRdDQxRjQ0OWpa?=
 =?utf-8?B?ZVFENmVtNVNhY3k4MEFQdnAvOUpNT1RCMUF6Y29LVHUwR014MDZoODZIVy94?=
 =?utf-8?B?RkNvdm9PbFVqSnpqbXVyL3NaNk9vcDN0eS9OZzNsQmJlcFU4V3I0V1ZjcytC?=
 =?utf-8?B?Vy93M28xN2QxS3Z2MzhGbGg5Smd3cmxsT3RiVmIzQ21GcGJ3VlRHdjdLVVRY?=
 =?utf-8?B?b01kc2tnZzM0OGhrUm5hYjVvd1EyVFRkTlNMUllrNkNCVU92a25SS05teFkv?=
 =?utf-8?B?VnErcFJNTVBtV292aWRkRk9VTk50cWR4bVppMTNiMjcxSS9lcVl5cnVMNWN4?=
 =?utf-8?Q?Me+22t6fmLUz9ByNOIk7NRs66?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f28345-2d52-4624-0a1c-08db2625db06
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 13:53:43.2683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +EG6z/XJ1ThZUSxKkb4kkZ2qYoNXDEuAfOHvTNT6xBJTyw+Z+Vu4Rkm6iZN5ISLoVEcgrMFdiub7UmoIb6HDrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVybmFuZGVzLm9yZz4NCj4gU2VudDog
VGh1cnNkYXksIE1hcmNoIDE2LCAyMDIzIDk6MjkgUE0NCj4gVG86IFpodW8sIFFpdXh1IDxxaXV4
dS56aHVvQGludGVsLmNvbT4NCj4gQ2M6IHBhdWxtY2tAa2VybmVsLm9yZzsgRnJlZGVyaWMgV2Vp
c2JlY2tlciA8ZnJlZGVyaWNAa2VybmVsLm9yZz47IEpvc2gNCj4gVHJpcGxldHQgPGpvc2hAam9z
aHRyaXBsZXR0Lm9yZz47IE5lZXJhaiBVcGFkaHlheQ0KPiA8cXVpY19uZWVyYWp1QHF1aWNpbmMu
Y29tPjsgRGF2aWRsb2hyIEJ1ZXNvIDxkYXZlQHN0Z29sYWJzLm5ldD47IFN0ZXZlbg0KPiBSb3N0
ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3JnPjsgTWF0aGlldSBEZXNub3llcnMNCj4gPG1hdGhpZXUu
ZGVzbm95ZXJzQGVmZmljaW9zLmNvbT47IExhaSBKaWFuZ3NoYW4NCj4gPGppYW5nc2hhbmxhaUBn
bWFpbC5jb20+OyByY3VAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gcmN1L3JjdXNjYWxlOiBTdG9wIGtm
cmVlX3NjYWxlX3RocmVhZCB0aHJlYWQocykNCj4gYWZ0ZXIgdW5sb2FkaW5nIHJjdXNjYWxlDQo+
IA0KPiANCj4gPiBPbiBNYXIgMTYsIDIwMjMsIGF0IDk6MTcgQU0sIFpodW8sIFFpdXh1IDxxaXV4
dS56aHVvQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiANCj4gPj4NCj4gPj4gRnJvbTogUGF1
bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPiBbLi4uXQ0KPiA+Pj4+DQo+ID4+Pj4g
SG93IGFib3V0IHRvIHB1bGwgdGhlIHJjdV9zY2FsZV9jbGVhbnVwKCkgZnVuY3Rpb24gYWZ0ZXIN
Cj4gPj4ga2ZyZWVfc2NhbGVfY2xlYW51cCgpLg0KPiA+Pj4+IFRoaXMgZ3JvdXBzIGtmcmVlXyog
ZnVuY3Rpb25zIGFuZCBncm91cHMgcmN1X3NjYWxlXyogZnVuY3Rpb25zLg0KPiA+Pj4+IFRoZW4g
dGhlIGNvZGUgd291bGQgbG9vayBjbGVhbmVyLg0KPiA+Pj4+IFNvLCBkbyB5b3UgdGhpbmsgdGhl
IGNoYW5nZXMgYmVsb3cgYXJlIGJldHRlcj8NCj4gPj4+DQo+ID4+PiBJTUhPLCBJIGRvbid0IHRo
aW5rIGRvaW5nIHN1Y2ggYSBjb2RlIG1vdmUgaXMgYmV0dGVyLiBKdXN0IGFkZCBhIG5ldw0KPiA+
Pj4gaGVhZGVyIGZpbGUgYW5kIGRlY2xhcmUgdGhlIGZ1bmN0aW9uIHRoZXJlLiBCdXQgc2VlIHdo
YXQgUGF1bCBzYXlzDQo+ID4+PiBmaXJzdC4NCj4gPj4NCj4gPj4gVGhpcyBzaXR1YXRpb24gaXMg
bGlrZWx5IHRvIGJlIGFuIGVhcmx5IGhpbnQgdGhhdCB0aGUga3ZmcmVlX3JjdSgpDQo+ID4+IHRl
c3Rpbmcgc2hvdWxkIGJlIHNwbGl0IG91dCBmcm9tIGtlcm5lbC9yY3UvcmN1c2NhbGUuYy4NCj4g
Pg0KPiA+IEFub3RoZXIgaXMgdGhhdCBpdCdzIGEgYml0IGV4cGVuc2l2ZSB0byBjcmVhdGUgYSBu
ZXcgaGVhZGVyIGZpbGUganVzdA0KPiA+IGZvciBlbGltaW5hdGluZyBhIGZ1bmN0aW9uIGRlY2xh
cmF0aW9uLiA7LSkNCj4gDQo+IFdoYXQgaXMgc28gZXhwZW5zaXZlIGFib3V0IG5ldyBmaWxlcz8g
SXQgaXMgYSBuYXR1cmFsIG9yZ2FuaXphdGlvbiBzdHJ1Y3R1cmUuDQo+DQo+ID4gU28sIGlmIG5v
IG9iamVjdGlvbnMsIEknZCBsaWtlIHRvIHNlbmQgb3V0IHRoZSB2MiBwYXRjaCB3aXRoIHRoZSB1
cGRhdGVzIGJlbG93Og0KPiA+DQo+ID4gICAtIE1vdmUgcmN1X3NjYWxlX2NsZWFudXAoKSBhZnRl
ciBrZnJlZV9zY2FsZV9jbGVhbnVwKCkgdG8gZWxpbWluYXRlIHRoZQ0KPiA+ICAgICBkZWNsYXJh
dGlvbiBvZiBrZnJlZV9zY2FsZV9jbGVhbnVwKCkuIFRob3VnaCB0aGlzIG1ha2VzIHRoZSBwYXRj
aCBiaWdnZXIsDQo+ID4gICAgIGdldCB0aGUgZmlsZSByY3VzY2FsZS5jIG11Y2ggY2xlYW5lci4N
Cj4gPg0KPiA+ICAgLSBSZW1vdmUgdGhlIHVubmVjZXNzYXJ5IHN0ZXAgIm1vZHByb2JlIHRvcnR1
cmUiIGZyb20gdGhlIGNvbW1pdA0KPiBtZXNzYWdlLg0KPiA+DQo+ID4gICAtIEFkZCB0aGUgZGVz
Y3JpcHRpb24gZm9yIHdoeSBtb3ZlIHJjdV9zY2FsZV9jbGVhbnVwKCkgYWZ0ZXINCj4gPiAgICAg
a2ZyZWVfc2NhbGVfY2xlYW51cCgpIHRvIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gDQo+IEhvbmVz
dGx5IGlmIHlvdSBhcmUgbW92aW5nIHNvIG1hbnkgbGluZXMgYXJvdW5kLCB5b3UgbWF5IGFzIHdl
bGwgc3BsaXQgaXQgb3V0DQo+IGludG8gYSBuZXcgbW9kdWxlLg0KPiBUaGUga2ZyZWUgc3R1ZmYg
YmVpbmcgY2x1YmJlZCBpbiB0aGUgc2FtZSBmaWxlIGhhcyBhbHNvIGJlZW4gYSBtYWpvcg0KPiBh
bm5veWFuY2UuDQoNCkknbSBPSyB3aXRoIGNyZWF0aW5nIGEgbmV3IGtlcm5lbCBtb2R1bGUgZm9y
IHRoZXNlIGtmcmVlIHN0dWZmcywgDQpidXQgZG8gd2UgcmVhbGx5IG5lZWQgdG8gZG8gdGhhdD8N
Cg0KQHBhdWxtY2ssIHdoYXQncyB5b3VyIHN1Z2dlc3Rpb24gZm9yIHRoZSBuZXh0IHN0ZXA/IA0K
DQo+ICAtIEpvZWwNCj4gDQo+IA0KPiA+IFRoYW5rcyENCj4gPiAtUWl1eHUNCj4gPg0KPiA+PiBb
Li4uXQ0K
