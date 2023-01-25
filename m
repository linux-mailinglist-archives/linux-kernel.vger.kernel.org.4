Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C7D67B291
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjAYM2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjAYM2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:28:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EB1577F0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674649700; x=1706185700;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ijy8DADJfLrNPKE/SfvXOQaV8Brgkr6MMziN9hdY7F0=;
  b=UPEITFFQwsi8sLzJZODALuwvH+zIztThJBaUB1RjWDTRZsdjAYttYiyH
   p3nUqstzeIX2fdLO4tMmGEpA2QzGWM711dat3yxj1eACXqayHZ55VqNvc
   FrnUZpFDGjASJtOrZtd1EQ5HPo9iZGvyStEv8gwkdGjP2Cp8scPB/celQ
   Dae5dOkkQJ5ydDPO0UtBG/naKx8fLKwhp3TOek6UcTqIlf2pR4sqyjTEK
   WebYAR5ybef3YSiAbdV61RsQXeqVZRr/z0MhN4Zr/V+6GPT6M1b/SOwNr
   4sZrzk66qRxmUpPJKjfS5DUGeY08OP9GzatTNNXDdodiWyASdIcuMWu0b
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="327798157"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="327798157"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 04:28:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="907859088"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="907859088"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jan 2023 04:28:18 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 04:28:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 04:28:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 04:28:17 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 04:28:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD64suQ7ios218oEvOUG53nnC4CCdHIMoGx7mn37qMdGQDrqd0YZiWmzqr24OuQkJRnZypH2lgqvuvkElcyZts6UyZCV+i8jXyUwrP64ylwic7dSlmyFl1HhQtcwBMW1R7OlGe1aJMZhVLJrQgOwGbV51tU94ilATJ3xuR30nGKzxtKAwpB23x5ooCRusFlrYP2KrqslA5nmo4EzCJSBxgrWAR97Ny8KDFrA7bJ7t8pqLnmh/j1rQ4SYilBTtsvkq+uz4A7aUzFyk4B7O0eGII3AeOLpzSWFThTbvm5DH/I1z75iN71pUypfgdfFVa0X+lZgA0VP0YJ0tdAa30WVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijy8DADJfLrNPKE/SfvXOQaV8Brgkr6MMziN9hdY7F0=;
 b=X8DcT/457Qqs3/WXpCFjqlWIDyLpcI6lwJiT+zBGaOahTYXB36+CHpoSHojDW7HZ5Mod1SxVkLZhttEDvr8QQhz8cnjAqr8pz4CR8Nw16KzPX7Qn+ug0Dj1VIEWtf49D18KKGJ3ZUFDDrCbrfSakY1GbiZsGIGyyNJs6NDMejLU4bjC6I1aL/yJnGj4j0651keWZYIlfgJFeja3k8beiOFzhtO3shrNgPWYk/jBMo5h8qnkduQUL78JAm4NZKlxs1NEsT8TjqCft5MZF2rXSeG6qyYuvCatKh+XcTU0Ncba6ZDCigd6FnikE8lxlhETS6YRgsMdxMAHxgySBrOh+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 DM4PR11MB5456.namprd11.prod.outlook.com (2603:10b6:5:39c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Wed, 25 Jan 2023 12:28:13 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%4]) with mapi id 15.20.6043.021; Wed, 25 Jan 2023
 12:28:13 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Linux guest kernel threat model for Confidential Computing
Thread-Topic: Linux guest kernel threat model for Confidential Computing
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPw==
Date:   Wed, 25 Jan 2023 12:28:13 +0000
Message-ID: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|DM4PR11MB5456:EE_
x-ms-office365-filtering-correlation-id: b7adbe15-cfd4-4e36-3b8b-08dafecfa0a4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mo1F3n7d+G4hgw8mcBxcNi/7Qqe2+YkeBj1XWLmriP7ZWKje7pFbEuJ0KD+jyRLN1BEGKvL/pK0aS8FPuR8eBdIWeYxM7bSgbc2wlLD8RnKCnp6hhYGkl11HPlmCDCDyz8S9WzHfdib+R34K2u3xZVqtoq/pL1FUUKjILBpPE+epFo7ftjpdppdZt6ZXKqEBtMJUYj2DOE6Ui7Nc2qTIAerrkAzUq3F/AS5QQ8Gfyn2G5K04za8ErFhB5c3IKg8eJ/nnoW1Ks47I9Y5jPSm7Wy+YWKp/P5kp/CXXyG/I1Af4XdvXy4O2+SY+rfyA+QYPNsGpwPUUiTC7FSeOD1K6erb9ZvDWgwISAt1vvLItnpTd3WUYoij+X1cj8OHufTXu7jwS5KOVRuUbfZ4EsOCoANbNvoyrjH2BbMURK7T9B6thPDcQTtSYprp79SSHeXpL9NkijUN++Scg0kKN3ABW7bUPXH3r489zXbkSdTJT9wbuEl/kxHNC1Hv681Y04h15ZnbD+Msey93iE95A51jsCrI1VOaQf+o9bvmwTGPzcwtTNnJAFktpRLcp39t3PAGt8RNpuPhnp8gbYWi2BnVm+SiPZ8NnGEbC8ncyE1ljCik4RbfFj6t1F7P5GuFExRbuoWARDcoQWuBWLVKTQ68klaOcMzFv16rDewSi0c0TjrebRtmwtH3UVyafxuadPXggopPFc7fOOnVEiFpZ8xcTjTIzZkfV8wBlJJddAbrx5/zICmElEVx6hof3y4j4IvlN/O/SwZSJpbJqGl4hL/JKpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199018)(33656002)(38100700002)(122000001)(83380400001)(54906003)(6916009)(66556008)(66446008)(64756008)(478600001)(8676002)(186003)(66476007)(71200400001)(9686003)(38070700005)(76116006)(66946007)(966005)(7696005)(55016003)(2906002)(86362001)(7416002)(41300700001)(82960400001)(26005)(5660300002)(52536014)(316002)(6506007)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmVGVFhmU25vWG9jR3R6cFFEZktJbkVrV0o0VnQ0YTB0ZGt6aDRGUnMxYnIz?=
 =?utf-8?B?dXBGcGViYUloMDFlcEpIWS8rRkpORG1XM3dvbFR5MllxZ3Jrb0hnNzdpeE5y?=
 =?utf-8?B?Wis4T1BzZTVKZkJFYVdqRDNOYStMWElZVHpHN0tTdXJrbG1QVVowa1BpSGR2?=
 =?utf-8?B?ZmlEN1JjRzVBOUJpQkJTRHRoMUdGWUJuT0UzRm1lVVdwSVJmZEdSY2lWb2tu?=
 =?utf-8?B?L0ZxNEZBRVFLenE0YndLRWZsSm4vMTJlZW5XUG5yVnVFaUtJS0YzdTJScUdu?=
 =?utf-8?B?cmxEZ3hGczhseHpXRDZHdk1QV05WV2p5dFYyblN3aDlpS1hMVnh0bVJ6Uk1D?=
 =?utf-8?B?cXUwZzUzV2ZzOTRQbGZRRTgvNTd6c2JjUlVzMG84L050cnpwSHRqK0pvNlRL?=
 =?utf-8?B?empCRUdDaU51VnJ6Sk9UMEhoeXA1K1JpVW1zczFQbnFvaDByNW5mZjNUYWxN?=
 =?utf-8?B?UU1rTUpyc3dXY1BZdWxlVC9QUlE3QUk0YnJmamJmdE04cTYrdWlIUXFxMzI3?=
 =?utf-8?B?L1lhOGdMWmNTQ210dEdheWZ5bHl4U3hLZjljS09vdG9pM1lSL2pkd3ZXbndq?=
 =?utf-8?B?SDFzY1gyUWU3TkNteTdOakZEYW8rYmVIR2VjYk1sdFEyckxUOVNBZ09PS0JK?=
 =?utf-8?B?N1pGV05RS2JXdVRHcWs2b2NMTTluNmFPMEdGSEZUSVZ6QThISk1VTjZSU3lj?=
 =?utf-8?B?QVVvL0lPemFtQkM0RUtpRGkxeVh1VjkzMTBWQnZocXp6bkVmS09iOC9pWGZi?=
 =?utf-8?B?K0YybWFXZE5meC91OXJmV1N4QWMzbmxqYk5QVXhKQUFOeStIcmNvNHAxaUJ2?=
 =?utf-8?B?VXlxNHdWSVk1a1FzbTJCcUR1dnVuaitXRnJ6RDNoSEgxMWt5Tk5pUUNyais3?=
 =?utf-8?B?TDE3ck5RNEF5QlZZRFhvS25lN2s3S2RvbHZOUjgwLzFaeWhEbTVXVHFLbWlJ?=
 =?utf-8?B?TUJ0eGtFUTVpNGQ1UjJtS0ZiN3g5WC95ZXgweHNPRmZNNGR1RExiVWdKNCs0?=
 =?utf-8?B?akFDeVhsZEYySDNicUZJbUlGcDFEa0EzYWdGWWlDWFFGWndsMkxHWXcxaGpO?=
 =?utf-8?B?bVBDWkREanlnZ0JJdFFHNURkRFcwbmdzY3JhSnZhK3UxckZaR01mMlpYMnVP?=
 =?utf-8?B?Y0FlV3l0WUNRdFR0b3A5a1ovM21QZnBDQi9JVGFNV0VqeUhKSnJsbkNENktj?=
 =?utf-8?B?WVphYitETUtNQ3I3Q2RNdExxVUQvYm9zZlVEamxxVm1vaFB3OEVudTZQL2tr?=
 =?utf-8?B?eXE2ZUVnaU5mMENVMWlDTFdScjhXVkNOajJHS3Y0ZGs3eUtMVGdPOGx5bTJ3?=
 =?utf-8?B?dmttSy85M0dGcTk1ekZsaVc4bkVDOFM5SXdZV2p3bm00eFdGTlgwbjFYS1cz?=
 =?utf-8?B?NnN0Yzc1RnhsYTBSMWtFYWNXK0RJaXBtS3NTNHVzNHV6endGaEZXR1BXU3FG?=
 =?utf-8?B?cFBBWDdPQWlWOUNvZnJhZy9pelZFakdvL2xBU1Rvb3JEWktzSmkrb2ExZEVS?=
 =?utf-8?B?d2Z4WDJFNnBNaS9INDlCbnlMQWhhT0FKZ016Rmd2QStVeExtVXJYNlEvTE9H?=
 =?utf-8?B?bEZXZ2J2emZ0MGViWTBoYXUxL1VTTExyc3g1ZmF3WkVIZHk2d3NycTNsV3dU?=
 =?utf-8?B?RjJ4TXRrelFmek0xU25JLzZlZUx0U3Z3L3BTcUJaRkxkcTdwdUR0NjFWVU9o?=
 =?utf-8?B?SHpNb09HUHRIUHByQWxLZWQ3dktXV2s4aVp6NEdkQldicFlxZ2lFUk9lRHY0?=
 =?utf-8?B?b0RTSTVRa243Ni8xNzduTlRTQ0pHL2JqcmJHVzM2ZGlXZ2RkQkt4WlpFcmhK?=
 =?utf-8?B?VUpIWmhEYTIrbEF1Y3RLTmtCNHVLYWhlUzVIc2RzcWc2VmZqMGZ6NEVkYzRI?=
 =?utf-8?B?N1RKK3VrMUtQRmJHbnRsTFdXbEtjWkNvRFBFV0p4Kzh0MHpwRkZrbytHUGlJ?=
 =?utf-8?B?T0czbmtmYkVFc2ZHZW1haGUxcGd0TEkzVkVmdE9Nenlmb0M0TzJKSUgrNHdl?=
 =?utf-8?B?MjlKU0xNOUt3ZE5Ea0swTlBVZUVxNjhvTmN1REhaaEhRU1hHV0tINFc2NEZI?=
 =?utf-8?B?ZnZVeDltaHhRMU1XZUJteEwwK1ZWNExHNEFjY0dZL09WUWJjK2thejhRK2dB?=
 =?utf-8?Q?IBKKEGHUWLRPv/ZEhPVcNSKjy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7adbe15-cfd4-4e36-3b8b-08dafecfa0a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 12:28:13.2993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TSPZB6eKzlGQ2uqi7WwQfz71x6s9pyAKS8UZ/3SiwUXLT9690fNmzly0ZjrNzslDRiwthYW/k7yI/WOrDPjAS22Mkxju6gQa/NH0o2NPmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5456
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

SGkgR3JlZywgDQoNCllvdSBtZW50aW9uZWQgY291cGxlIG9mIHRpbWVzIChsYXN0IHRpbWUgaW4g
dGhpcyByZWNlbnQgdGhyZWFkOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1k4MFd0dWpu
TzdrZmR1QVpAa3JvYWguY29tLykgdGhhdCB3ZSBvdWdodCB0byBzdGFydA0KZGlzY3Vzc2luZyB0
aGUgdXBkYXRlZCB0aHJlYXQgbW9kZWwgZm9yIGtlcm5lbCwgc28gdGhpcyBlbWFpbCBpcyBhIHN0
YXJ0IGluIHRoaXMgZGlyZWN0aW9uLiANCg0KKE5vdGU6IEkgdHJpZWQgdG8gaW5jbHVkZSByZWxl
dmFudCBwZW9wbGUgZnJvbSBkaWZmZXJlbnQgY29tcGFuaWVzLCBhcyB3ZWxsIGFzIGxpbnV4LWNv
Y28NCm1haWxpbmcgbGlzdCwgYnV0IEkgaG9wZSBldmVyeW9uZSBjYW4gaGVscCBieSBpbmNsdWRp
bmcgYWRkaXRpb25hbCBwZW9wbGUgYXMgbmVlZGVkKS4NCg0KQXMgd2UgaGF2ZSBzaGFyZWQgYmVm
b3JlIGluIHZhcmlvdXMgbGttbCB0aHJlYWRzL2NvbmZlcmVuY2UgcHJlc2VudGF0aW9ucw0KKFsx
XSwgWzJdLCBbM10gYW5kIG1hbnkgb3RoZXJzKSwgZm9yIHRoZSBDb25maWRlbnRpYWwgQ29tcHV0
aW5nIGd1ZXN0IGtlcm5lbCwgd2UgaGF2ZSBhIA0KY2hhbmdlIGluIHRoZSB0aHJlYXQgbW9kZWwg
d2hlcmUgZ3Vlc3Qga2VybmVsIGRvZXNu4oCZdCBhbnltb3JlIHRydXN0IHRoZSBoeXBlcnZpc29y
LiANClRoaXMgaXMgYSBiaWcgY2hhbmdlIGluIHRoZSB0aHJlYXQgbW9kZWwgYW5kIHJlcXVpcmVz
IGJvdGggY2FyZWZ1bCBhc3Nlc3NtZW50IG9mIHRoZSANCm5ldyAoaHlwZXJ2aXNvciA8LT4gZ3Vl
c3Qga2VybmVsKSBhdHRhY2sgc3VyZmFjZSwgYXMgd2VsbCBhcyBjYXJlZnVsIGRlc2lnbiBvZiBt
aXRpZ2F0aW9ucw0KYW5kIHNlY3VyaXR5IHZhbGlkYXRpb24gdGVjaG5pcXVlcy4gVGhpcyBpcyB0
aGUgYWN0aXZpdHkgdGhhdCB3ZSBoYXZlIHN0YXJ0ZWQgYmFjayBhdCBJbnRlbA0KYW5kIHRoZSBj
dXJyZW50IHN0YXR1cyBjYW4gYmUgZm91bmQgaW4NCg0KMSkgVGhyZWF0IG1vZGVsIGFuZCBwb3Rl
bnRpYWwgbWl0aWdhdGlvbnM6IA0KaHR0cHM6Ly9pbnRlbC5naXRodWIuaW8vY2NjLWxpbnV4LWd1
ZXN0LWhhcmRlbmluZy1kb2NzL3NlY3VyaXR5LXNwZWMuaHRtbA0KDQoyKSBPbmUgb2YgdGhlIGRl
c2NyaWJlZCBpbiB0aGUgYWJvdmUgZG9jIG1pdGlnYXRpb25zIGlzICJoYXJkZW5pbmcgb2YgdGhl
IGVuYWJsZWQNCmNvZGUiLiBXaGF0IHdlIG1lYW4gYnkgdGhpcywgYXMgd2VsbCBhcyB0ZWNobmlx
dWVzIHRoYXQgYXJlIGJlaW5nIHVzZWQgYXJlDQpkZXNjcmliZWQgaW4gdGhpcyBkb2N1bWVudDog
DQpodHRwczovL2ludGVsLmdpdGh1Yi5pby9jY2MtbGludXgtZ3Vlc3QtaGFyZGVuaW5nLWRvY3Mv
dGR4LWd1ZXN0LWhhcmRlbmluZy5odG1sDQoNCjMpIEFsbCB0aGUgdG9vbHMgYXJlIG9wZW4tc291
cmNlIGFuZCBldmVyeW9uZSBjYW4gc3RhcnQgdXNpbmcgdGhlbSByaWdodCBhd2F5IGV2ZW4NCndp
dGhvdXQgYW55IHNwZWNpYWwgSFcgKHJlYWRtZSBoYXMgZGVzY3JpcHRpb24gb2Ygd2hhdCBpcyBu
ZWVkZWQpLg0KVG9vbHMgYW5kIGRvY3VtZW50YXRpb24gaXMgaGVyZToNCmh0dHBzOi8vZ2l0aHVi
LmNvbS9pbnRlbC9jY2MtbGludXgtZ3Vlc3QtaGFyZGVuaW5nDQoNCjQpIGFsbCBub3QgeWV0IHVw
c3RyZWFtZWQgbGludXggcGF0Y2hlcyAodGhhdCB3ZSBhcmUgc2xvd2x5IHN1Ym1pdHRpbmcpIGNh
biBiZSBmb3VuZCANCmhlcmU6IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC90ZHgvY29tbWl0cy9n
dWVzdC1uZXh0DQoNClNvLCBteSBtYWluIHF1ZXN0aW9uIGJlZm9yZSB3ZSBzdGFydCB0byBhcmd1
ZSBhYm91dCB0aGUgdGhyZWF0IG1vZGVsLCBtaXRpZ2F0aW9ucywgZXRjLA0KaXMgd2hhdCBpcyB0
aGUgZ29vZCB3YXkgdG8gZ2V0IHRoaXMgcmV2aWV3ZWQgdG8gbWFrZSBzdXJlIGV2ZXJ5b25lIGlz
IGFsaWduZWQ/DQpUaGVyZSBhcmUgYSBsb3Qgb2YgYW5nbGVzIGFuZCBkZXRhaWxzLCBzbyB3aGF0
IGlzIHRoZSBtb3N0IGVmZmljaWVudCBtZXRob2Q/IA0KU2hvdWxkIEkgc3BsaXQgdGhlIHRocmVh
dCBtb2RlbCBmcm9tIGh0dHBzOi8vaW50ZWwuZ2l0aHViLmlvL2NjYy1saW51eC1ndWVzdC1oYXJk
ZW5pbmctZG9jcy9zZWN1cml0eS1zcGVjLmh0bWwNCmludG8gbG9naWNhbCBwaWVjZXMgYW5kIHN0
YXJ0IHN1Ym1pdHRpbmcgaXQgdG8gbWFpbGluZyBsaXN0IGZvciBkaXNjdXNzaW9uIG9uZSBieSBv
bmU/IA0KQW55IG90aGVyIG1ldGhvZHM/IA0KDQpUaGUgb3JpZ2luYWwgcGxhbiB3ZSBoYWQgaW4g
bWluZCBpcyB0byBzdGFydCBkaXNjdXNzaW5nIHRoZSByZWxldmFudCBwaWVjZXMgd2hlbiBzdWJt
aXR0aW5nIHRoZSBjb2RlLA0KaS5lLiB3aGVuIHN1Ym1pdHRpbmcgdGhlIGRldmljZSBmaWx0ZXIg
cGF0Y2hlcywgd2Ugd2lsbCBpbmNsdWRlIHByb2JsZW0gc3RhdGVtZW50LCB0aHJlYXQgbW9kZWwg
bGluaywgDQpkYXRhLCBhbHRlcm5hdGl2ZXMgY29uc2lkZXJlZCwgZXRjLiANCg0KQmVzdCBSZWdh
cmRzLA0KRWxlbmEuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMTA4MDQx
NzQzMjIuMjg5ODQwOS0xLXNhdGh5YW5hcmF5YW5hbi5rdXBwdXN3YW15QGxpbnV4LmludGVsLmNv
bS8NClsyXSBodHRwczovL2xwYy5ldmVudHMvZXZlbnQvMTYvY29udHJpYnV0aW9ucy8xMzI4Lw0K
WzNdIGh0dHBzOi8vZXZlbnRzLmxpbnV4Zm91bmRhdGlvbi5vcmcvYXJjaGl2ZS8yMDIyL2xpbnV4
LXNlY3VyaXR5LXN1bW1pdC1ub3J0aC1hbWVyaWNhL3Byb2dyYW0vc2NoZWR1bGUvDQo=
