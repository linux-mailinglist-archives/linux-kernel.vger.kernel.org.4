Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8E663721E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 06:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiKXF7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 00:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKXF7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 00:59:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942015BD7C;
        Wed, 23 Nov 2022 21:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669269568; x=1700805568;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yuzgZocLXf7+KqYo4LN8oMvsxwtvMZsyacYpzx9w4ZI=;
  b=Xk/ArdxTDWyPVcuLYJgv9JmWe30yppVqln0GKIdJcPMNDivHPnTYHIOI
   GOAGVDX6mvjLJEmNDBM1ZobsoEdAhWw+Nd6kPOqhVQTk8BgZCQ+8pI4cB
   9jefHH8GQQXi6NlnK6bkpSizF+FQsRDSjNFVL7oFvvjFalXsIK8A5SiCd
   MU3W4nRy1Px0DOgAwuAdB2VILL1DEp+6nZM/aJ2CHrc/FHvvTG28b/lKy
   f1dwsAO6efIzGKuiLxq4VEOY2rwjGvGpurYM40dGQWmT2v83cPUXueQRO
   Ct0eQJZ94JZCPadeVyO1KQc00OC7x4e9Y24u7uSpRPp/ut/0oBcCC/ltr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="314257665"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="314257665"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 21:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="673121743"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="673121743"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2022 21:59:27 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 21:59:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 21:59:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 21:59:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 21:59:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nT4f0EkttEMl8rH3FK5Swc8p9dh+OET5iD/nCP1oJanFFrhTfFyq6ODminbngmVWva4vhwJYkpSSTLL21+6b2SpwMzXjPls/cMdVmsFYlJB9JZRBUWT6gswzrS7luCUuvkY1IMzVr3LORl3jd7Mr69hf6Qzkbe3ImWFci7hfMux0tOPmPdXJbGnOrCBwJSQINc0iHhhmkrcj1R27CoVMsYg9LEnKdsSeJUN8pysn5bedd7SO/X1otnh7RDm60QkzAhJvWzaL1bg5Nb14/VidkYnXcdo7JBrO/2nkdHALNTJM3lTDiwvhxFvZa6QqE2qcwDftY1glANCcOwIoxkBQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuzgZocLXf7+KqYo4LN8oMvsxwtvMZsyacYpzx9w4ZI=;
 b=mMlvnwgE2ixngwEO1c4Z8NKwx4s1EBqfX9XEkz22836eWNRZxQjUOE0aa0AKRmIetnVwqQhMTKVzVwsxZJ/Touvqej6k3W2yWFSuB8O5Ai95Qige9adtzGkpqeNTK2LdycsgBs/6nRCdGKdrkFg9j8RBViTslIAVDjhHfrNec4xlydPeVNOH6TWQLjQElaA4EdXpCtAC9SuUnL04jLMKRGLv4tO7PQv4E/4TS8k3eicym6s/GutbDtbFWBecg2oiMUym4IKccGQSU61ttPHHS9XRb4K9vZozR9aXg8ysPUVlkV6k9Q/06sa+O0v/+VeFcEttBYQjgKmJr399fz1VpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA2PR11MB4812.namprd11.prod.outlook.com (2603:10b6:806:f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 05:59:24 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%6]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 05:59:24 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] srcu: Add detection of boot CPU srcu_data
 structure's->srcu_cblist
Thread-Topic: [PATCH] srcu: Add detection of boot CPU srcu_data
 structure's->srcu_cblist
Thread-Index: AQHY+nXe3fxP1SzD7UGw8RnvZujcXK5DKoyAgADb12CAB8DjcIABIMEAgABp9yCAAEOOgIAACF6w
Date:   Thu, 24 Nov 2022 05:59:24 +0000
Message-ID: <PH0PR11MB58806AEE4AB9ED152607F977DA0F9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221117112050.3942407-1-qiang1.zhang@intel.com>
 <20221117142025.GE839309@lothringen>
 <PH0PR11MB58807CB6626A08CADD822409DA099@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB5880F073FEFFDD11B1AA0642DA0C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221123190456.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58809D9378BF040EB2AA2DE6DA0F9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221124052559.GP4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221124052559.GP4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA2PR11MB4812:EE_
x-ms-office365-filtering-correlation-id: f359f634-1265-4eb3-934c-08dacde10a39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LDlIcnsRkWmyMMXozrrkKWatAk8tmONLhKzCwnUW5tsUxw+3wFEqdyOvKMF4dynPStQbkFhm1frmkRaXyA6/ZzfSo73a8RquCsAwls3oVuzpVLSwFeEq9F9Mmug1fj8SYqXsMqgD6tHMYNDZ2APq/iCc3TYZyzlHZOGD72d1CEjHNhTH5flUSDvgHolXigrLrn2/GXknW/NHrlfegEoEBzPGY86NezXcMFh+7XgrDoWoND6pqDXVXFs7jRvItXza2WYdQ9nQCYDDPBezGzQArOT2ks9rJB+od61S37Sb+2GK7xg0td48tOdVODHRakdoZrT3U9a2wgx1F8Z0NG9ecwX8Ke6dSff6cpZ8waG2f4Yt7Bgq11YG9sOQ8hFAoPU6FJ7sWPgJqZyNpn9XBZQ/ELKWPNMsVd14XPgFvJFD2V0gitMwbtPmCBYBR/iTr0EYIv9draYrOfp8XEFjN3HQXsXvo6pi7egpUTbd261trynUQdQa4148IyRnfSz8DQ+FbEHh2lTlDmgq5P17hQmTDx23R18mF7MkZKuqu7M6/wK6CRPJXj0WJ0GYHiIT1i+3a1GIDvgckRhuUIqVNPWSLkxCvdFYhEazG8wvUpo4oe1PkEZmTrPxTjVZJWgb74o0s35gGUC3hkLo8sNepiDT4PORBlFwEP56vfn5VqfKpwBjrepLX1iCRjv4DxTZAnpZucfsnqx0XhfyUVBcz/abVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(26005)(83380400001)(9686003)(186003)(82960400001)(122000001)(38100700002)(38070700005)(2906002)(5660300002)(55016003)(8936002)(6506007)(478600001)(71200400001)(7696005)(4326008)(66556008)(66946007)(66446008)(66476007)(8676002)(6916009)(41300700001)(316002)(52536014)(64756008)(54906003)(76116006)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzdVZ2VqckV5V2tWQ2s3bU5jN0xiTkpZRStnZEEzMW81b2xCYVNScHlGc2pu?=
 =?utf-8?B?ZExzaU8yMC9hVzI2NEhvRWo4Nm0vb1ZKRE5HT2pPYkhlcmpYYUhXMmovN2dN?=
 =?utf-8?B?TlR0Qk5oWC9kZnMzUW90M1FNYW1oWUc3dVVzTVhhRHhRVEdER2pPYXRncC91?=
 =?utf-8?B?NmpvNCt3Y2ZXdVpLUmI3R1FCb0NhZWJCeERGNlZEYStnamZjVThINFg2UEQw?=
 =?utf-8?B?ZDBXeXcwVk8rS2pWS2VqQUk4NHlQeW5BYjBPbFdJbHVCNmNoOVBraGJvUEp4?=
 =?utf-8?B?anl1bEl1VjBjYXRBaWNmdWxlTUwyakRzaDcyeDh0c1Q2VmRxajZXeVBsOTNz?=
 =?utf-8?B?ZXpkK2JHSUw0cEJiZGJKUGxwNEEzQXFWMWo5KzA0Wk92cENkTjJhZ3d1dlhZ?=
 =?utf-8?B?T2tJdzNlOG81cDFYUGhlTW9nMFluWXBGQ1R2YlJhRkpZaDdtVE5US0JjWHl1?=
 =?utf-8?B?dEVRNFVGcVJWSHZIMEF2STN3L0EyVy9PNjBTTkZMU1Ruc091U2QwaGd0REVR?=
 =?utf-8?B?TVVVS01pNGRQSDFkT1BVdjZvbTB1aDF2VlNHdVRsTXk5VU1ZK2NyTnFMckRZ?=
 =?utf-8?B?dWcyd3k2dkh6SnhCY05IL0hCSldBY1NQRkJnWmN6L2dBN1o5MXlkRGl5TDVJ?=
 =?utf-8?B?MU90V1lHYU5IbXBkNG9lUklFK2JadGx6bTc3QTJQU1QwdGVMVlU4eDdHSG1z?=
 =?utf-8?B?TlZKOXFSNWJwWXkvSkIrZkNRS1N3aEN5aWppUkxMb3dNNTVXYkJBTldCSkZQ?=
 =?utf-8?B?VS8rL1ZPRkdLN3lmbXFVWHUrOEZhZUFUc2IrQlF1UHcxTC9ndnZzTWp3K0V2?=
 =?utf-8?B?UmFjMGdCcStRVE9FemFHN3pGZlJ2V0VkVGt6a1MwT2d1UzVjRmZoWWswR2tu?=
 =?utf-8?B?SndBanJXUHdiOFpteVR3UG9NNUtXMHVvQWlTdjN3WnhISmYvQ3VJMHRWNFVB?=
 =?utf-8?B?WlBjZHVLODA3VThWdUF6d09BVEJnYUs3RThYNWY1dEFYQU8wVkYzUXcyQjJ5?=
 =?utf-8?B?SHBubHNmalV0dXRYUFlxU1paZjJZMTM2QlN6bk5pb045dDZUWjkwbEd3d3A1?=
 =?utf-8?B?R01VZit5SzJLRnM3Z0V0ckQ0VHdwNis3Wkh2eHRubGpvWjBma2ZBaFQ0N3dP?=
 =?utf-8?B?WGhyM3J0dmpKajk4WUJkaVhDRDVlL3JITCtISFQxaVZ3SzJqcWpUZlNZR0s4?=
 =?utf-8?B?SDlOV0lWbXU5ZmlOVTZQKzk1UWJUMUFMOVkrSFZMQzFZUFBQL0MrUU5aa0Rx?=
 =?utf-8?B?bWFPK3g4bDkvN2Eya2F6MjVFRUIwc3g4c25Ydno1SmpkZU02TkwvQktqUEk3?=
 =?utf-8?B?NVMwN0RGVG1sRjZyaXh5QkxwM2xWekpaczExRUxkTnZsYXNuV2RBZmVpNXhD?=
 =?utf-8?B?anliYlE2b3NoajluYklYRExuUkUxN2c1S0s0QkZNMTQzaGkwR2RzaFRKOEpa?=
 =?utf-8?B?R3hPaFRMTUVRYU51Rm9kU2wzZ0QzTUVxNk9IQTV6UFRBMHFSRFVVQjdEbG5G?=
 =?utf-8?B?YTdBTEVuTktRRW5VTEFNdC9JK0piNkFiREdremVSZC9hN0lPVXpBUGY3SmM4?=
 =?utf-8?B?bFBSNlA1VndsSnVObDRvN1lKY2Vhem5KMThkQitTVmxLWjk0cnR1ellkV0NH?=
 =?utf-8?B?NmRETUlPUWY0WXVuYmJJVUZycC8rVnhJYUlqamlSVGxUa3JDck9sL1MwQXBy?=
 =?utf-8?B?M2RxckZVcit5L3VUUHhmWVFudVJUeEl3RCsrL1JKRFViek41WFJIdkp0VERQ?=
 =?utf-8?B?MnlVazB4NWFSRHV0TWNZSkZocVJYaHdpRC9WM2FFTWZBU0hreVRRYnRtWFBv?=
 =?utf-8?B?bVpobE82akVnUGYxSjNhMXdRcEF2QUp0YkpGUzVkT2dvMGJPN00wMDJEZWVH?=
 =?utf-8?B?UUtxckQ4QlM5MVI3aUU4UzZrSHU0b1Nmbk1uNTd4OGtLK1YyanJvVzlqbDli?=
 =?utf-8?B?Q1VDaXZJWTZUV1lCdGZLSHhVd3M0Rkk5ZWY1RWplK2JkMXNCVkl0VmhER2dZ?=
 =?utf-8?B?Y0NvNkl6K3hteXdiRXZqQW53SUFEUXpQQ2w0d05oMTVNemNIVEJ3am8vcG5x?=
 =?utf-8?B?VTY3TTJhTkNvazUrdlk3WWdUbVYrSmM3RTRuQzR6emhLajJmNENnbUNsYWtw?=
 =?utf-8?Q?qMZkKyBQ2g8OgPqpO4PZd+RJ1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f359f634-1265-4eb3-934c-08dacde10a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 05:59:24.9070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vag05GWGNV3eLlTooJdsG771TWiMVRbYn9zbFjuBKtkAU4yIluY3XqN/nYt7Pz/SeauXP22s5uRsjm5Vrm6ZyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4812
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBOb3YgMjQsIDIwMjIgYXQgMDE6NDM6NDJBTSArMDAwMCwgWmhhbmcsIFFpYW5nMSB3
cm90ZToNCj4gT24gV2VkLCBOb3YgMjMsIDIwMjIgYXQgMDI6MDE6NTBBTSArMDAwMCwgWmhhbmcs
IFFpYW5nMSB3cm90ZToNCj4gPiANCj4gPiA+T24gVGh1LCBOb3YgMTcsIDIwMjIgYXQgMDc6MjA6
NTBQTSArMDgwMCwgWnFpYW5nIHdyb3RlOg0KPiA+ID4gQmVmb3JlIFNSQ1VfU0laRV9XQUlUX0NB
TEwgc3JjdV9zaXplX3N0YXRlIGlzIHJlYWNoZWQsIHRoZSBzcmN1DQo+ID4gPiBjYWxsYmFjayBv
bmx5IGluc2VydCB0byBib290LUNQVSBzcmN1X2RhdGEgc3RydWN0dXJlJ3MtPnNyY3VfY2JsaXN0
DQo+ID4gPiBhbmQgb3RoZXIgQ1BVIHNyY3VfZGF0YSBzdHJ1Y3R1cmUncy0+c3JjdV9jYmxpc3Qg
aXMgYWx3YXlzIGVtcHR5LiBzbw0KPiA+ID4gYmVmb3JlIFNSQ1VfU0laRV9XQUlUX0NBTEwgaXMg
cmVhY2hlZCwgbmVlZCB0byBjb3JyZWN0bHkgY2hlY2sgYm9vdC1DUFUNCj4gPiA+IHBlbmQgY2Jz
IGluIHNyY3VfbWlnaHRfYmVfaWRsZSgpLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBa
cWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBrZXJuZWwv
cmN1L3NyY3V0cmVlLmMgfCA3ICsrKysrLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEva2Vy
bmVsL3JjdS9zcmN1dHJlZS5jIGIva2VybmVsL3JjdS9zcmN1dHJlZS5jDQo+ID4gPiBpbmRleCA2
YWYwMzEyMDA1ODAuLjZkOWFmOTkwMTc2NSAxMDA2NDQNCj4gPiA+IC0tLSBhL2tlcm5lbC9yY3Uv
c3JjdXRyZWUuYw0KPiA+ID4gKysrIGIva2VybmVsL3JjdS9zcmN1dHJlZS5jDQo+ID4gPiBAQCAt
MTA5OCw4ICsxMDk4LDExIEBAIHN0YXRpYyBib29sIHNyY3VfbWlnaHRfYmVfaWRsZShzdHJ1Y3Qg
c3JjdV9zdHJ1Y3QgKnNzcCkNCj4gPiA+ICAJdW5zaWduZWQgbG9uZyB0bGFzdDsNCj4gPiA+ICAN
Cj4gPiA+ICAJY2hlY2tfaW5pdF9zcmN1X3N0cnVjdChzc3ApOw0KPiA+ID4gLQkvKiBJZiB0aGUg
bG9jYWwgc3JjdV9kYXRhIHN0cnVjdHVyZSBoYXMgY2FsbGJhY2tzLCBub3QgaWRsZS4gICovDQo+
ID4gPiAtCXNkcCA9IHJhd19jcHVfcHRyKHNzcC0+c2RhKTsNCj4gPiA+ICsJLyogSWYgdGhlIGJv
b3QgQ1BVIG9yIGxvY2FsIHNyY3VfZGF0YSBzdHJ1Y3R1cmUgaGFzIGNhbGxiYWNrcywgbm90IGlk
bGUuICAqLw0KPiA+ID4gKwlpZiAoc21wX2xvYWRfYWNxdWlyZSgmc3NwLT5zcmN1X3NpemVfc3Rh
dGUpIDwgU1JDVV9TSVpFX1dBSVRfQ0FMTCkNCj4gPiA+ICsJCXNkcCA9IHBlcl9jcHVfcHRyKHNz
cC0+c2RhLCBnZXRfYm9vdF9jcHVfaWQoKSk7DQo+ID4gPiArCWVsc2UNCj4gPiA+ICsJCXNkcCA9
IHJhd19jcHVfcHRyKHNzcC0+c2RhKTsNCj4gPiA+DQo+ID4gDQo+ID4gSGkgUGF1bCwgIA0KPiA+
IA0KPiA+IEZvciB0aGUgY29udmVydF90b19iaWcgIGRlZmF1bHQgY29uZmlndXJhdGlvbihTUkNV
X1NJWklOR19BVVRPKSwgSSBmb3VuZCB0aGF0IHRoZSBzcmN1IGlzIGluDQo+ID4gU1JDVV9TSVpF
X1NNQUxMIHN0YXRlIG1vc3Qgb2YgdGhlIHRpbWUgaW4gdGhlIHN5c3RlbSwgSSB0aGluayB0aGlz
IGNoYW5nZSBpcyBtZWFuaW5nZnVsLg0KPiA+IA0KPiA+IFRob3VnaHRzID8NCj4gDQo+ID5Zb3Ug
YXJlIHJpZ2h0IHRoYXQgdGhpcyBjaGFuZ2UgbWlnaHQgbWFrZSBzcmN1X21pZ2h0X2JlX2lkbGUo
KSByZXR1cm4gYQ0KPiA+bW9yZSBhY2N1cmF0ZSB2YWx1ZSBpbiB0aGUgY29tbW9uIGNhc2UuICBB
cyB0aGluZ3MgYXJlIG5vdywgc29tZSBvdGhlcg0KPiA+Q1BVIG1pZ2h0IGp1c3Qgbm93IGhhdmUg
YWRkZWQgYSBjYWxsYmFjaywgYnV0IG1pZ2h0IG5vdCB5ZXQgaGF2ZSBzdGFydGVkDQo+ID50aGF0
IG5ldyBncmFjZSBwZXJpb2QuICBJbiB0aGF0IGNhc2UsIHdlIG1pZ2h0IGV4cGVkaXRlIGFuIFNS
Q1UgZ3JhY2UNCj4gPnBlcmlvZCB3aGVuIHdlIHdvdWxkIG5vdCBoYXZlIG90aGVyd2lzZSBkb25l
IHNvLiAgSG93ZXZlciwgdGhpcyBjaGFuZ2UNCj4gPndvdWxkIGFsc28gaW5jcmVhc2UgY29udGVu
dGlvbiBvbiB0aGUgZ2V0X2Jvb3RfY3B1X2lkKCkgQ1BVJ3Mgc3JjdV9kYXRhDQo+ID5zdHJ1Y3R1
cmUncyAtPmxvY2suDQo+ID4NCj4gPlNvIHRoZSByZXN1bHQgb2YgdGhhdCBpbmFjY3VyYXRlIHJl
dHVybiB2YWx1ZSBpcyB0aGF0IHRoZSBmaXJzdCB0d28gU1JDVQ0KPiA+Z3JhY2UgcGVyaW9kcyBp
biBhIGJ1cnN0IG1pZ2h0IGJlIGV4cGVkaXRlZCBpbnN0ZWFkIG9mIG9ubHkgdGhlIGZpcnN0IG9u
ZSwNCj4gPmFuZCBldmVuIHRoZW4gb25seSBpZiB3ZSBoaXQgYSB2ZXJ5IG5hcnJvdyByYWNlIHdp
bmRvdy4NCj4gPg0KPiA+QmVzaWRlcywgdGhpcyBzYW1lIHRoaW5nIGNhbiBoYXBwZW4gaWYgdHdv
IENQVXMgZG8gc3luY2hyb25pemVfc3JjdSgpDQo+ID5hdCB0aGUgc2FtZSB0aW1lIGFmdGVyIGEg
bG9uZy1lbm91Z2ggcGF1c2UgYmV0d2VlbiBncmFjZSBwZXJpb2RzLg0KPiA+Qm90aCBzZWUgbm8g
Y2FsbGJhY2tzLCBzbyBib3RoIGFzayBmb3IgYW4gZXhwZWRpdGVkIGdyYWNlIHBlcmlvZC4NCj4g
PlNvIGFnYWluLCB0aGUgZmlyc3QgdHdvIGdyYWNlIHBlcmlvZHMgYXJlIGV4cGVkaXRlZC4NCj4g
Pg0KPiA+QXMgYSByZXN1bHQsIEkgYW0gaGF2aW5nIGEgdmVyeSBoYXJkIHRpbWUganVzdGlmeWlu
ZyB0aGUgaW5jcmVhc2VkDQo+ID5sb2NrIGNvbnRlbnRpb24uDQo+IA0KPiBUaGFua3MgcmVwbHks
ICBJIGhhdmUgYW5vdGhlciBxdWVzdGlvbiwgSXMgdGhpcyBzcmN1X2RhdGEgc3RydWN0dXJlJ3Mt
PmxvY2sgbmVjZXNzYXJ5Pw0KPiB0aGUgcmN1X3NlZ2NibGlzdF9wZW5kX2NicygpIG9ubHkgY2hl
Y2sgKnRhaWxzW1JDVV9ET05FX1RBSUxdIGlzIGVtcHR5Lg0KPiBvciBjYW4gdXNlIHJjdV9zZWdj
Ymxpc3RfZ2V0X3NlZ2xlbihSQ1VfV0FJVF9UQUlMICsgUkNVX05FWFRfUkVBRFlfVEFJTCArIFJD
VV9ORVhUX1RBSUwpIA0KPiBpbnN0ZWFkIG9mICByY3Vfc2VnY2JsaXN0X3BlbmRfY2JzKCkgdG8g
YXZvaWQgbG9ja2luZz8gKGFsdGhvdWdoIHRoaXMgaXMgYWxzbyBpbmFjY3VyYXRlKQ0KDQo+VGhh
dCBleHRyYSAiKiIgbWVhbnMgdGhhdCB0aGUgbG9jayBtdXN0IGJlIGFjcXVpcmVkLiAgT3RoZXJ3
aXNlLCB0aGUNCj5wb2ludGVkLXRvIGNhbGxiYWNrIG1pZ2h0IGV2ZW4gYmUgdW5tYXBwZWQgYmV0
d2VlbiB0aGUgdGltZSB3ZSBmZXRjaGVkDQo+dGhlIHBvaW50ZXIgYW5kIHRoZSB0aW1lIHdlIGRl
cmVmZXJlbmNlZCBpdC4NCg0KVGhhbmtzIGZvciBkZXRhaWxlZCBleHBsYW5hdGlvbiAsIGxlYXJu
IG1vcmXwn5iKLg0KDQo+DQo+CQkJCQkJCVRoYW54LCBQYXVsLg0KDQo+IFRoYW5rcw0KPiBacWlh
bmcNCj4gDQo+ID4NCj4gPkFtIEkgbWlzc2luZyBzb21ldGhpbmcgaGVyZT8NCj4gPg0KPiA+CQkJ
CQkJCVRoYW54LCBQYXVsDQo+ID4NCj4gPiBUaGFua3MNCj4gPiBacWlhbmcNCj4gPiANCj4gPiAN
Cj4gPiA+V2hpbGUgYXQgaXQgaWYgc29tZW9uZSBpcyBpbnRlcmVzdGVkIGluIGRvY3VtZW50aW5n
L2NvbW1lbnRpbmcgb24gdGhlIG1lYW5pbmcgb2YNCj4gPiA+YWxsIHRoZXNlIFNSQ1VfU0laRV8q
IHRoaW5ncywgaXQgd291bGQgYmUgbXVjaCBhcHByZWNpYXRlZCENCj4gPiA+DQo+ID4gPkluIHRo
ZSBpbml0aWFsIHN0YWdlKFNSQ1VfU0laRV9TTUFMTCksIHRoZXJlIGlzIG5vIHNyY3Vfbm9kZSBz
dHJ1Y3R1cmVzLCBvbmx5IGluaXRpYWxpemVkDQo+ID4gPnBlci1DUFUgc3JjdV9kYXRhIHN0cnVj
dHVyZXMsIGF0IHRoaXMgdGltZSwgd2Ugb25seSB1c2UgYm9vdC1jcHUgc3JjdV9kYXRhIHN0cnVj
dHVyZXMncyAtPnNyY3VfY2JsaXN0DQo+ID4gPnRvIHN0b3JlIHNyY3UgY2FsbGJhY2tzLiAgDQo+
ID4gPmlmIHRoZSBjb250ZW50aW9uIG9mIHNyY3Vfc3RydWN0IGFuZCBzcmN1X2RhdGEgc3RydWN0
dXJlJ3MtPmxvY2sgYmVjb21lIGJ1c3ksDQo+ID4gPnRyYW5zaXRpb24gdG8gU1JDVV9TSVpFX0FM
TE9DLiAgYWxsb2NhdGVkIG1lbW9yeSBmb3Igc3JjdV9ub2RlIHN0cnVjdHVyZSBhdCBlbmQgb2Yg
dGhlIFNSQ1UNCj4gPiA+Z3JhY2UgcGVyaW9kLiAgIA0KPiA+ID5pZiBhbGxvY2F0ZWQgc3VjY2Vz
cywgIHRyYW5zaXRpb24gdG8gU1JDVV9TSVpFX1dBSVRfQkFSUklFUiwgIGluIHRoaXMgc3RhdGUs
IGludm9rZQ0KPiA+ID5zcmN1X2JhcnJpZXIoKSB3aWxsIGl0ZXJhdGUgb3ZlciBhbGwgcG9zc2li
bGUgQ1BVcywgYnV0IHdlIHN0aWxsIG9ubHkgdXNlIGJvb3QtQ1BVIHNyY3VfY2JsaXN0IHRvIHN0
b3JlIGNhbGxiYWNrcy4NCj4gPiA+dGhlIHRhc2sgY2FsbGluZyBjYWxsX3NyY3UoKSBtYXkgaGF2
ZSBhY2Nlc3MgdG8gYSBuZXcgc3JjdV9ub2RlIHN0cnVjdHVyZSBvciBtYXkgbm90LCANCj4gPiA+
YmVjYXVzZSBjYWxsX3NyY3UoKSBpcyBwcm90ZWN0ZWQgYnkgU1JDVSwgd2UgbWF5IG5vdCB0cmFu
c2l0aW9uIHRvIFNSQ1VfU0laRV9XQUlUX0NBTEwgcXVpY2tseSwNCj4gPiA+bmVlZCB0byB3YWl0
IGluIHRoaXMgc3RhdGUgZm9yIGEgU1JDVSBncmFjZSBwZXJpb2QgdG8gZW5kLg0KPiA+ID5BZnRl
ciB0cmFuc2l0aW9uIHRvIFNSQ1VfU0laRV9XQUlUX0NBTEwsIHdlIGVucXVldWUgc3JjdSBjYWxs
YmFja3MgdG8gb3duIHNyY3VfZGF0YSBzdHJ1Y3R1cmVzJ3MgLT5zcmN1X2NibGlzdC4NCj4gPiA+
DQo+ID4gPkRvZXMgbXkgZGVzY3JpcHRpb24gbWFrZSBteSBjb21taXQgbW9yZSBkZXRhaWxlZD8N
Cj4gPiA+DQo+ID4gPlRoYW5rcw0KPiA+ID5acWlhbmcNCj4gPiA+DQo+ID4gPg0KPiA+IA0KPiA+
IA0KPiA+ID4NCj4gPiA+VGhhbmtzLg0KPiA+ID4NCj4gPiA+ICAJc3Bpbl9sb2NrX2lycXNhdmVf
cmN1X25vZGUoc2RwLCBmbGFncyk7DQo+ID4gPiAgCWlmIChyY3Vfc2VnY2JsaXN0X3BlbmRfY2Jz
KCZzZHAtPnNyY3VfY2JsaXN0KSkgew0KPiA+ID4gIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZV9y
Y3Vfbm9kZShzZHAsIGZsYWdzKTsNCj4gPiA+IC0tIA0KPiA+ID4gMi4yNS4xDQo+ID4gPiANCg==
