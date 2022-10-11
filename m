Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD85FBC3F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJKUlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJKUlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:41:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A0F18E1C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665520860; x=1697056860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Md3e9kp/u426Vrb6gor5WY4PwpnqDw0Zutl0zYRj3tg=;
  b=E5ItoP5bL8ATuBC6gaQSJCwJPMcLayHSOBuG7+FgqUpnEyrUKOeoWVzP
   HA/acWGblkbznPBgrIYifUs3cH7SA7veSslpzqYfeSaA4DW85TyUXtXXW
   jLAB44Q/EL2wBrrJBVjssYqDbQhn/UbPOjnyGo5TYPLQp3Puw9iPOSBPI
   2DUdtbblpW3SPGobAZL1JEleeqSwWDiK7ry40uYrz5PLllofTAbMM+XwB
   RQMZ86W+Epx+iAdXCigR/HaAT20r/RVIj3bCytCaYfkto6N9oAW2AE71q
   wwoCAC31WpkYczvPsyggALXmktJ/b/J7EZ892Bh43M6POLK5CIYpR+CHz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="287886776"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="287886776"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 13:41:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="689391562"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="689391562"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 11 Oct 2022 13:41:00 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 13:40:59 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 13:40:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 13:40:59 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 13:40:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2vRGOAl0+wCyn4DdJ48zSwvZ1yje+CHIBW66Xh+hFr5QgYYJrPZsxyGHY3VpuOXaQQcsq/J9zq5Ek/muwwyOM5cQ3/sToe26SPpio+Cu/VKktfc7unsHgdgQhn69tXd0CcZ5X8DlklviXdWz8s3K+4/9AqM4O9pDrR0zViwQ9QydJb1tmQInrR5u0wHjFzAy8xLUCal+dankXL3u4TDuGMu6pHYk5tY9e1gTENSXWV9q5H/TkVXCAc1E3aqBDpQpBawFnYHwq8WDv0X7yBVgH4efempjL9PvcGy4OCw0/uxF6XPALbWozsmn1El8vTmtvTC4fZrtCDAZvlOB1sJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Md3e9kp/u426Vrb6gor5WY4PwpnqDw0Zutl0zYRj3tg=;
 b=WfegHYhTtn9bnzTe9rCUMtrzWUPAqIxXT3nC/KHuRwOSAVphP6ahRMXSn8uTvMaaDJaroWDiwgIFQyhvObJA/R113RgvoWg/+1m9k6amT6HsG0UKPVkzLWfJYIudQ4fIBzjM6guKAq5i/JhIYrN3gOlvi1fyTt//we/MwM6MtfLF82uOJUj4klZpKbIg49/SwCx+oY08oqu/Vdtl0e6TvcdNw0mDyuX3+W9uwENnm1cEnKC/atDqbsQTEilAIqRjqdrVKYNyBdqOqTsYeJ4cRmy6hGD9CAmCVUsiye5X+AqYBQ0US9sqdB3lbGhe+40OcPSnkbuKK0o4TJVonjQV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN7PR11MB7114.namprd11.prod.outlook.com (2603:10b6:806:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 20:40:56 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 20:40:55 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "songliubraving@meta.com" <songliubraving@meta.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [RFC v2 4/4] vmalloc_exec: share a huge page with kernel text
Thread-Topic: [RFC v2 4/4] vmalloc_exec: share a huge page with kernel text
Thread-Index: AQHY2qcSuA+QF3WN10KzhnOoNUAfaa4H9+yAgAAKP4CAABD5AIABU8+AgABHQ4A=
Date:   Tue, 11 Oct 2022 20:40:55 +0000
Message-ID: <99201f0c3509e1ea3d08a462beaaea9d60382cff.camel@intel.com>
References: <20221007234315.2877365-1-song@kernel.org>
         <20221007234315.2877365-5-song@kernel.org>
         <af5c148fb3b9c56d1eb7e92b05db7c6c04bcfc3c.camel@intel.com>
         <B849A9FF-1054-4D5C-AEBD-72AED8B8F277@fb.com>
         <3842f1e7cfdde4f848e164872f62c0c1da654fec.camel@intel.com>
         <2B66E2E7-7D32-418C-9DFD-1E17180300B4@fb.com>
In-Reply-To: <2B66E2E7-7D32-418C-9DFD-1E17180300B4@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SN7PR11MB7114:EE_
x-ms-office365-filtering-correlation-id: 9485e6d1-c3f2-4be6-35d9-08daabc8e561
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BY7p5K01++lfttHrqCzOHa05P21DcVnTBLdCyKxKOLG35YfeBcG8ZDENUWkxPKtjd1H7YUdn6vC4x9GRlpkfJeZWOca+j3bPQMnT3B7AdvvhsDPzbccJLJhO9JZRN5PhaYZ58XWx9sTXshI88jK43EoZq9XeuJn0MG6Jbj6KMxHFyLio4el4Hnubu8qjvSRu1SsIiUi/kyS2pI0NQu1a30m2XootJylxo4/761U8H1dXt7Toy/U8oeXhE42adooTpQMdU+KuX8nwsL0gtWnb837BZ0DgnoBymmrUMXVfrt7QauLf4SXCJlEu6UgTgdLSD8kQJzqUYPH4o8KE/C0UXXaLTKWjFPywKCvZcDVxgBO6KBA2LgpvvXOTCpPl0w5l//WSZj6lrAxc39Y+Yyn7JffFsUjb9crLWsKHss/gfxnx1oWtvuDh+HMCvIYb4aGmNfcgK2EvJjpzdByY+mii7TOsK8ea9ppVYVqa5GryK2mTLdcbt9eO6kJPE1glQFCLpSQJbE6jgofyqHxSwMzJH2Rn5ZYjJdmm0veuNtRW0vVPtAgv5de6p6pL385Hp755KfRje1+73/GcuKFCbaO3oOg8BYAHpFps3VQrehnvogR+BaSddB+NSqYDpKz5KLv4qOYQL7hc8aA4k+af0dOCR4H2aqEhymmhrgNg4RjFeRw9IH+GKluQtlzgYAf4MqHmLvxPDiEcBQs2WWKnMc7msxD4qtMnzZbvrrIV5cru+Op3HgiKo0/qInRAltLR4KVkcOt7Rf54t10KbCKiwPtUlb7RlMH7SNFLZVg/J+ygauHGEdO66BpdEjpcUaXDLLIh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(38100700002)(41300700001)(5660300002)(82960400001)(122000001)(54906003)(26005)(8936002)(64756008)(6512007)(6916009)(4326008)(7416002)(36756003)(86362001)(316002)(6506007)(71200400001)(91956017)(66446008)(66556008)(66946007)(76116006)(66476007)(4001150100001)(8676002)(83380400001)(2906002)(2616005)(186003)(38070700005)(6486002)(478600001)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUs1ZHV0dG4wRENHTlFlMTBscmtvNU1GVlhEelo1WDRCa0FvN3pFY0Vxc01a?=
 =?utf-8?B?dzFRZW9JSWs2M0wya2Zjbkd0R3NrZzBLeUR0RjY4NG9meS8yRFQwNWdoL0RL?=
 =?utf-8?B?dmZDZ0JNUGR2bkdkelRZTnUrT0ZOckdMdUhOeW9JandlYXdrQWRZL3VxZlZY?=
 =?utf-8?B?c3Z2bC9XdzVkd1Iyd1Q3YnFjSG5NY2JuT3BwNThOUUY4ZExxaTgwVkd5N0cr?=
 =?utf-8?B?M2xiUVRmNmVQZENwOXBJOEJ4MnhYcXdYRld1Y3NqR2xzZ1dJY2RPY2k0dzZt?=
 =?utf-8?B?bXZlb3Bkb2M1T2FhMHljZ0RRekhyMFVUSUxJeGd4Yk8vL3dRcGNQNzBtWkxU?=
 =?utf-8?B?RE1KN3BTdzhzUkxoaXhXSW9rZHdWUjY2aXIxWjB3cDFlbTkyMWJpd281bGJl?=
 =?utf-8?B?QnZpWjVURVB4N1N0dk5mWFRzUm94MUI3UGJtVUVraEVrZW5JbjNMV1hqbkNB?=
 =?utf-8?B?STVHNFdVMWlvTGZsWE5FdTd5VEJPa3hoM2Zqd2JyRU96SHVYb0Rqci90T0lh?=
 =?utf-8?B?dVVBQklXVUxHVklMdTlRU3RVQ3BVMThsaCsvYkxrRlF6WUh0NXBjYlppQ25u?=
 =?utf-8?B?azV2UVN2SklSTU5EdGdkMmVtQmhWblZzbzRPRm9BTzY1VmVudGVPamxzV0FQ?=
 =?utf-8?B?VUVNU3FIMkdZY29XMHZsK0x5aXNZQmEwN0dnTkxpdjlXQjgzSTlwOXRCYThm?=
 =?utf-8?B?aXR0KzZHejVxTll6bVVvUVY0MlpWY0hjZ1JwQklrVXNKa0VIZGgxbjBSWU9s?=
 =?utf-8?B?TDNlVDVkR0JvQUdQeWhtSmgvMlVKS3ZtcVNjT2d3VkZNcEx0RTJKNDlUdjJR?=
 =?utf-8?B?SHoxNExJWk5WNFhIeDhKTzdjUzhYMnFRNTdHZG5FV1ZLRjBtOEVYbWFWOUhl?=
 =?utf-8?B?Z0hodFNzZ0R0Z3JPb2dPTDF6cDFSNTVHTWlPVjdWSXhhVnBud2JNSDRFSVlL?=
 =?utf-8?B?b055TG1raWZTa2dsOUJiQ05VemlhRll4ajN5R3BsWU5ySFh2TmxQWXVYK0Ju?=
 =?utf-8?B?YU9teXdFWlRmVStlQkNFY0N5Y0x5a1BIYkpNQkY1RGV2YzZWaExES2VDVFRk?=
 =?utf-8?B?bjhVYlY4YWdsU3lBSVhhcm9HRXJyM3BFandLK3AxUi8xUFdvd1dZQTR3enZM?=
 =?utf-8?B?ZjZTTXpiWkVvYXFmYTU1TkNjLzcrM0k4VWhjcDhuRmhZbkJoTWlsb1JnZUll?=
 =?utf-8?B?dVhZOURhV0t0S1phZzdPMFkzbXZCZFN4ZWhqOFJuUzJGMnNhZUJ1aXdCMGRH?=
 =?utf-8?B?RkVFWGxTM2hnaXA5V1pMNjBIaXRwTVZuYXV5bW15N0lCeU9vMmcxZUJKRUdG?=
 =?utf-8?B?cENSQVFWQzBubE9qRmdMYy92eHFub3IrazI2ODgyNW1Eb0laNXJ2RUo0STIy?=
 =?utf-8?B?OEwwUzFRallWQkM1L1U4ajVTVEtzdTYzcnI2SUFBdS9ndjFobEhaamZObjNl?=
 =?utf-8?B?eHVEY3dQQWZ0bDlhRW9VU3RBNnhDb1JqWmpObVo2RzdrZ2hITWYxbGJlcVlQ?=
 =?utf-8?B?eTlVc1gwdHoza1JDQUlnVGlyczdxaUZJa3oyQlZ1L3ltMUFVUzFIVlhUUXIx?=
 =?utf-8?B?VytodndWdi9YOVFkSFd5d1IxeEJFc2l1OXRDM0VtSWo4NnhjdHhyWXZuNHRq?=
 =?utf-8?B?SmRqckxSU2VWRlJtSmltZUtqQ2Q3NUpKNUZwQUljb3BRckFmaG14VFREcjdX?=
 =?utf-8?B?c0dScGN1ZU1VMW5TSjduYjBZemFMY2tKelpvK2NnR0w5WDlPTXJVS0VLSzZu?=
 =?utf-8?B?N1BvbksxbnFPcWkvYTdqZkd6cXplMUpSa0RoQ2pLTUNvS1Vnb3FBVFliM01o?=
 =?utf-8?B?L25jdXBpcEdBTU9QZzdYQlA2NmhFTHJ4NXlsbGNOVWNzclkybUdzZjFqUGt3?=
 =?utf-8?B?ang5OC95UzlZWklrYU5vQ0doWmxJN04va3cxNFhQTkJrSlFGUXpWMXllanF3?=
 =?utf-8?B?N3hGc0JTUjNGK3NSQzdBMnMxME5iOGY3MU5ibHl5WGd6ZmRYaE5SdTV3SGpM?=
 =?utf-8?B?b2p2eUtXbTYwcDNFL3poWTRFVWRzdHRqZ0duOE9yS211c2M4ayt1K084UHcw?=
 =?utf-8?B?TXFJWmRHeUc2dEt3VHliNVhxbkxJVGowamNIdHNCbWQ2S1ErcnlGV0NpTzhG?=
 =?utf-8?B?ZTJqQzVKZ0ZFVFd5VWZVSFEwWnlnZ0NlV29QejFacDlialQwZ0ZHbFRHTUsr?=
 =?utf-8?Q?dysK+/xhEcRgrwe+xqe3kic=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BEA69D3F43E2942BF8F857B78DC4484@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9485e6d1-c3f2-4be6-35d9-08daabc8e561
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 20:40:55.5883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjJkIiCrWmFOdcvIch5lBtUHq7UjsBsL8/2lnUNniZTwfZFtn079hPUMMvP6BA1xtqsKlqy2n07SZj3hX16NMbyJNuKDGKx0Y4tHBTK3eTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7114
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTExIGF0IDE2OjI1ICswMDAwLCBTb25nIExpdSB3cm90ZToNCj4gPiBN
YXliZSB0aGlzIGlzIGp1c3QgbWUgbWlzc2luZyBzb21lIHZtYWxsb2MgdW5kZXJzdGFuZGluZywg
YnV0IHRoaXMNCj4gPiBwb2ludGVyIHRvIGFuIGFsbCB6ZXJvIHZtX3N0cnVjdCBzZWVtcyB3ZWly
ZCB0b28uIEFyZSB0aGVyZSBvdGhlcg0KPiA+IHZtYXANCj4gPiBhbGxvY2F0aW9ucyBsaWtlIHRo
aXM/IFdoaWNoIHZtYXAgQVBJcyB3b3JrIHdpdGggdGhpcyBhbmQgd2hpY2gNCj4gPiBkb24ndD8N
Cj4gDQo+IFRoZXJlIGFyZSB0d28gdm1hcCB0cmVlcyBhdCB0aGUgbW9tZW50OiBmcmVlX2FyZWFf
IHRyZWUgYW5kIA0KPiB2bWFwX2FyZWFfIHRyZWUuIGZyZWVfYXJlYV8gdHJlZSB1c2VzIHZtYXAt
PnN1YnRyZWVfbWF4X3NpemUsIHdoaWxlIA0KPiB2bWFwX2FyZWFfIHRyZWUgY29udGFpbnMgdm1h
cCBiYWNrZWQgYnkgdm1fc3RydWN0LCBhbmQgdGh1cyB1c2VzIA0KPiB2bWFwLT52bS4gDQo+IA0K
PiBUaGlzIHNldCBhZGQgYSBuZXcgdHJlZSwgZnJlZV90ZXh0X2FyZWFfLiBUaGlzIHRyZWUgaXMg
ZGlmZmVyZW50IHRvIA0KPiB0aGUgb3RoZXIgdHdvLCBhcyBpdCB1c2VzIHN1YnRyZWVfbWF4X3Np
emUsIGFuZCBpdCBpcyBhbHNvIGJhY2tlZCANCj4gYnkgdm1fc3RydWN0LiBUbyBoYW5kbGUgdGhp
cyByZXF1aXJlbWVudCB3aXRob3V0IGdyb3dpbmcgdm1hcF9zdHJ1Y3QsDQo+IHdlIGludHJvZHVj
ZWQgYWxsX3RleHRfdm0gdG8gc3RvcmUgdGhlIHZtX3N0cnVjdCBmb3IgZnJlZV90ZXh0X2FyZWFf
DQo+IHRyZWUuIA0KPiANCj4gZnJlZV90ZXh0X2FyZWFfIHRyZWUgaXMgZGlmZmVyZW50IHRvIHZt
YXBfYXJlYV8gdHJlZS4gRWFjaCB2bWFwIGluDQo+IHZtYXBfYXJlYV8gdHJlZSBoYXMgaXRzIG93
biB2bV9zdHJ1Y3QgKDEgdG8gMSBtYXBwaW5nKSwgd2hpbGUgDQo+IG11bHRpcGxlIHZtYXAgaW4g
ZnJlZV90ZXh0X2FyZWFfIHRyZWUgbWFwIHRvIGEgc2luZ2xlIHZtX3N0cnVjdC4NCj4gDQo+IEFs
c28sIGZyZWVfdGV4dF9hcmVhXyBoYW5kbGVzIGdyYW51bGFyaXR5IDwgUEFHRV9TSVpFOyB3aGls
ZSB0aGUNCj4gb3RoZXIgdHdvIHRyZWVzIG9ubHkgd29yayB3aXRoIFBBR0VfU0laRSBhbGlnbmVk
IG1lbW9yeS4gDQo+IA0KPiBEb2VzIHRoaXMgYW5zd2VyIHlvdXIgcXVlc3Rpb25zPyANCg0KSSBt
ZWFuIGZyb20gdGhlIHBlcnNwZWN0aXZlIG9mIHNvbWVvbmUgdHJ5aW5nIHRvIHVzZSB0aGlzIHdp
dGhvdXQNCmRpdmluZyBpbnRvIHRoZSBlbnRpcmUgaW1wbGVtZW50YXRpb24uDQoNClRoZSBmdW5j
dGlvbiBpcyBjYWxsZWQgdm1hbGxvY19leGVjKCkgYW5kIGlzIGZyZWVkIHdpdGggdmZyZWVfZXhl
YygpLg0KTWFrZXMgc2Vuc2UuIEJ1dCB3aXRoIHRoZSBvdGhlciB2bWFsbG9jc19mb28ncyAoaW5j
bHVkaW5nIHByZXZpb3VzDQp2bWFsbG9jX2V4ZWMoKSBpbXBsZW1lbnRhdGlvbnMpIHlvdSBjYW4g
Y2FsbCBmaW5kX3ZtX2FyZWEoKSwgZXRjIG9uDQp0aGVtLiBUaGV5IHNob3cgaW4gInZtYWxsb2Np
bmZvIiBhbmQgZ2VuZXJhbGx5IGJlaGF2ZSBzaW1pbGFybHkuIFRoYXQNCmlzbid0IHRydWUgZm9y
IHRoZXNlIG5ldyBhbGxvY2F0aW9ucywgcmlnaHQ/DQoNClRoZW4geW91IGhhdmUgY29kZSB0aGF0
IG9wZXJhdGVzIG9uIG1vZHVsZSB0ZXh0IGxpa2U6DQppZiAoaXNfdm1hbGxvY19vcl9tb2R1bGVf
YWRkcihhZGRyKSkNCglwZm4gPSB2bWFsbG9jX3RvX3BmbihhZGRyKTsNCg0KSXQgbG9va3MgbGlr
ZSBpdCB3b3VsZCB3b3JrIChvbiB4ODYgYXQgbGVhc3QpLiBTaG91bGQgaXQgYmUgZXhwZWN0ZWQN
CnRvPw0KDQpFc3BlY2lhbGx5IGFmdGVyIHRoaXMgcGF0Y2gsIHdoZXJlIHRoZXJlIGlzIG1lbW9y
eSB0aGF0IGlzbid0IGV2ZW4NCnRyYWNrZWQgYnkgdGhlIG9yaWdpbmFsIHZtYXBfYXJlYSB0cmVl
cywgaXQgaXMgcHJldHR5IG11Y2ggYSBzZXBhcmF0ZQ0KYWxsb2NhdG9yLiBTbyBJIHRoaW5rIGl0
IG1pZ2h0IGJlIG5pY2UgdG8gc3BlbGwgb3V0IHdoaWNoIG90aGVyIHZtYWxsb2MNCkFQSXMgd29y
ayB3aXRoIHRoZXNlIG5ldyBmdW5jdGlvbnMgc2luY2UgdGhleSBhcmUgbmFtZWQgInZtYWxsb2Mi
Lg0KTWF5YmUganVzdCBzYXkgbm9uZSBvZiB0aGVtIGRvLg0KDQoNClNlcGFyYXRlIGZyb20gdGhh
dCwgSSBndWVzcyB5b3UgYXJlIHBsYW5uaW5nIHRvIG1ha2UgdGhpcyBsaW1pdGVkIHRvDQpjZXJ0
YWluIGFyY2hpdGVjdHVyZXM/IEl0IG1pZ2h0IGJlIGJldHRlciB0byBwdXQgbG9naWMgd2l0aCBh
c3N1bXB0aW9ucw0KYWJvdXQgeDg2IGJvb3QgdGltZSBwYWdlIHRhYmxlIGRldGFpbHMgaW5zaWRl
IGFyY2gveDg2IHNvbWV3aGVyZS4NCg==
