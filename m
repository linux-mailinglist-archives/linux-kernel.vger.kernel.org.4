Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7D56D717C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbjDEAmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbjDEAmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:42:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C41705;
        Tue,  4 Apr 2023 17:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680655352; x=1712191352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BZWMkS8XOVdlG34HOio4gijG7NJqwNpduahho6JHjHk=;
  b=jW22XWHWTPyCWKdaxiKdp8sbADtoaUUc3UYeS2RM1QUs/LDlo19jQrW+
   TwZ0gzuXJ3L/Eolg/+BpQLuyWjMknW2DWASPhCtqHt0SacmVZnyBMNPiz
   mwN1Mw5xLiIpmHBoHaGhYASMomTlDrb7olSSp1QrZ5RaQjseNXws8TYRu
   NTbGKcjG7OF08K7j1470ACThIIqnMn40pOssW7dzmfCZd89crFtG7tifX
   1SuLIL6XEmIZkPYI0RkcllNAU2KvDA7OK5rI7jc5BGsTPFLa5/qYy8oR8
   Fh++wzsZb/Vuoqw2l9VrWZYBUVnjGI+KDooZ1l97GQzCEF4hgoqRtqWmv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="428625986"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="428625986"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 17:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="797701279"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="797701279"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 04 Apr 2023 17:42:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 17:42:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 17:42:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 17:42:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 17:42:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b67jmYGqRFU83BWozy+fLVO6U7Fykj+DHUOwlsIxSElCHVr0YFW4VQIKx6FmprTZ1y7xoTollFYmacix1/27Tg83jIVdFTsxU2Z31Ux84nOaiEDpnwI7pe3AfQyWRmPDhmx59e/crsaVIJtlPJ2OEkfVsksiUKHMBq7uB7sQpuqZs8BIIoZVj90dGJJpx38FGj6YK2SvfDO/1gVXuUYl/5Fr4PjpgIBPHm06T/Cg7LRcSfzQcy7b+hTNNyILx4UIA0N481DCySwbxVEmRUY9At6VA0aimedW1l6YuMBjUPnL3EVTq1q7d5j5fnv1EM5KfmOvaoSxXuqKuyXQENrw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZWMkS8XOVdlG34HOio4gijG7NJqwNpduahho6JHjHk=;
 b=my1NYOR31KU/q207Bw1PQOC904y/wL0T2TROu0QV2sU5K07zr/aX/bfQGHa5vlXKK9eyTrEZyAq4v4HVpZHOM1PTB17D/Hh4gf64INrGuvxFxGqJ+sFk63v6IPwoXT9gvlP9NrfMiw5H04DtIhA4qt1odzTWG+W51xbzJRAFp6wgZaMvv1Nr74Lud+tGFhxgUi6Xpdo/BrV2pLeSpexja2ufVKPyyCZFzrea/iSrAO1s+y06CB8M1bHAvtBdXg/bcTHehlG0X7KNyXAtqKtgDTnp1ScD+5djlldbMUXUK33bmcRX8IR5AHTxB+tOVrvV4d9zr6rIi9N1d4AuvXPzzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8)
 by SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 00:42:27 +0000
Received: from MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::ed53:4f52:abd:bbe8]) by MW3PR11MB4522.namprd11.prod.outlook.com
 ([fe80::ed53:4f52:abd:bbe8%7]) with mapi id 15.20.6254.028; Wed, 5 Apr 2023
 00:42:27 +0000
From:   "Box, David E" <david.e.box@intel.com>
To:     "Brown, Len" <len.brown@intel.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
        "svenva@chromium.org" <svenva@chromium.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "Jain, Rajat" <rajatja@google.com>
Subject: Re: [PATCH v6 1/4] PM: Add sysfs files to represent time spent in
 hardware sleep state
Thread-Topic: [PATCH v6 1/4] PM: Add sysfs files to represent time spent in
 hardware sleep state
Thread-Index: AQHZZnHqiBQhvrVW3ECy9XdhlnzvP68b4hgA
Date:   Wed, 5 Apr 2023 00:42:27 +0000
Message-ID: <b6000a3d5d4d6a3e9f8a57414c0b795e8cff6855.camel@intel.com>
References: <20230403211831.4010-1-mario.limonciello@amd.com>
         <20230403211831.4010-2-mario.limonciello@amd.com>
In-Reply-To: <20230403211831.4010-2-mario.limonciello@amd.com>
Reply-To: "Box, David E" <david.e.box@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4522:EE_|SA0PR11MB4527:EE_
x-ms-office365-filtering-correlation-id: a38fa77f-42cb-4644-73f9-08db356ea16b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NoDrdbFs9YKzng5CCNbFkP6jyzAzbTHX6471v8NEUgYUpLy6kp/UTuAxTZGLaI+nQxWDksYhp8MiqnoGv2HnWT+NWRCvZ9i+bgVezreA0M6KZcsXmElQHX/C7IBh0/IUyxGHahzq1Tzk7x/xlVwj+tUz/RIi+BFT5ObGJ5yILypVnpOW5lfuMaOdGG9CED76+z5yIewN1LuHhKACdhR2eXpHzy71L2x3+AdoxqF1iPndMBM3YFWhQ3ztOinkEYlBnHu8iLmDCEGzyHh+uNCYD6r8IcAb8MLb1bBEeqEYyNDrKIG4re/xpRx9v3Dlz1aVOXNT/x7Tt3VRyrKAloSdydx0e3+gj2vGuHNvkGfNqmWsFjdyC7KiliK4/UIy77fj0ZNYJ5ewRdUjYzGIE95ncgiLIs9T5Ym4EGiytNMdU9JEnPr95vaKnjAp/6WYXoX45gQL/zFB7XlSDPxr7PhwTwY5q6DiVvf9lsBOszB3s0a1htQnkL8QUbdO9i/FQtEEGdDi5+iR56R4Gu+hsBbpunUdneVHQ+JC2Tu5XRFq5geiY0JYkU44fGeSZq433MrIlgRAZhhZ1sv9VE+VM0fuy1AhEXkKJus3HwNnSF9+RGrlIC4ApfC8bnY8AydCjiNN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(86362001)(38070700005)(36756003)(2906002)(3450700001)(2616005)(6486002)(186003)(26005)(71200400001)(6506007)(6512007)(83380400001)(91956017)(316002)(8676002)(76116006)(66446008)(64756008)(66946007)(66556008)(4326008)(478600001)(66476007)(38100700002)(41300700001)(7416002)(5660300002)(122000001)(82960400001)(54906003)(110136005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a21mVytTOVFyTlA2cEpWNDZhWHkyRSswMGFLQS9DUFlISGR3akh3dVZDR0Iz?=
 =?utf-8?B?UkJyT1ArSFcyOXN6MldvYWFtK0ZhZHVqbkcxUHEwWG1WY0Exdk5VUldQY2hx?=
 =?utf-8?B?KzVXQlZBSzBhWkI3UFhqdDhSTnc1aWhCcUFYTUxYQzd3UGhGd1QwY0pVNXNY?=
 =?utf-8?B?MjUxMm1FUzhzaW5qOFZiRnI3RS9kdEtYZXNueXhDZ21NaDFkQ3JvWkNvdDNM?=
 =?utf-8?B?WU1uejIvVGNDVXdZcytHdmZyZk1wWW1sT0JVM3R0b2RON2Jxc1NXc3drdDNr?=
 =?utf-8?B?Q2dmSVcyVGxuSXVmNnh1RWs3enROVVF2OEdFS2ZKLzExZXoydkVxeTdoaWhV?=
 =?utf-8?B?RXpsYS9yOVlCcDV6RlBvOUF6RTNOblVHK3V2dzBQdzlOR095bC9KTjJEcVRX?=
 =?utf-8?B?U0dKZDZINFRhaFY4MWt4dUtjVFBnSmVpMXUzSHBJWVpmMkxCZ25ZSlRHU0dp?=
 =?utf-8?B?RjFwVzc4TCtIaEVrQjVHV2JGVHJHZXRuVWgxWnRRSVdYUEZMZVhtYXpKMzFl?=
 =?utf-8?B?UEkzYjNWbTZSSCszQ0tWeno4QmJVMFRiMktSN2FMTExLZG1uUmNhT2EvODRE?=
 =?utf-8?B?NjFwNjhnNDQ2OVZ6T3d4dWkwOEVCUGRQdDlwTnRPSWpPK0wxZE02ZGFoM25k?=
 =?utf-8?B?TnhUMGFOcE9JUXNCOUQySlJKWmNxVEpLRjVhMUNqMnl3eGV3RUliN0E1dVN4?=
 =?utf-8?B?elVCWWEvbkhZU3JZV0t3TmF0cnhpZFBnWGRTVlNNVS9MUXFOUGVHa2xhdHF5?=
 =?utf-8?B?V3cybFR0akF4TnFPcXVLK3JXNG1rR2YwdzVwOUNKeGZuVVBIMW5BVy80Rk5U?=
 =?utf-8?B?UWpvb3E0NXFXNEIwOWhQNllzWkFMWSsyaGRVZlh2OUtiZVJJL0dRbER4Yi9J?=
 =?utf-8?B?ZXpBbzVHNWdaM2VqazBzeUdyU3EwbXVBOTBqWTdIMm00OGVqcnNHWWVxWTBY?=
 =?utf-8?B?eGx5TjhDNDN5QlRSL1lHY0dSdFcyOVBhMHgwZ0NwdkZIQkppM0FxOWlsV0FE?=
 =?utf-8?B?MWd6MTNWVDdkdEFhVWdiR3VtbFJQSyt5NEQ0S1JCNXNHeXFTUUgvV3JpTWwy?=
 =?utf-8?B?RmZKNWRlYTc3b3ludmdTaG1LT1h5ZEh2bWJiMklEUlhPUFZ2OEcxTFNVaHV2?=
 =?utf-8?B?QU5SblhNQU1MVmZUQmV3S3NHbjVCc3cxWDlyZlBZSU8vR3IwN1dYcTlKWkM0?=
 =?utf-8?B?Z1BiZFQzVFByclZ3bFNsa0E0RUlkZFZ3Qi9nTkJJSTZPVmNMVWxoQVh1WXBs?=
 =?utf-8?B?TUpoaGZhOU1xZ3RmOENid3A4dEp2OGZMUFRWSzd5Tmx4YlRETGE2RnE1Nmly?=
 =?utf-8?B?RC9TenZRaWlvYXJrOTFyVHZiNXlyZUR2OWhka3dONW8yQVNkSzkzSDVkWHJV?=
 =?utf-8?B?SmpkSlJkdHh6VkRCNFphY0wxVEJZTXVwMDBxb1VnY0tERkZvUlhFVjRHM1hG?=
 =?utf-8?B?QzRSZWRLWWlZYXo4Nmh4RDFLMHdYeVFhYTZGeHVYYWw4N3ZmdGQzL3Z1cUw5?=
 =?utf-8?B?QzNLL1ErUllEbXBqcUlhSDkrSzFJZm5vRFZwTFYwRjU0YURibGZuRFdZVExG?=
 =?utf-8?B?cVVaYnJHRHA1SWZOT0x6dm95cWtRYXFKSnM4Q04zQUZob3NLS3RCSnNoWnFN?=
 =?utf-8?B?NVRtTS9KbzJsT0tiUTBmVVN5WW0yazFVc29rZGIxUEpyU2wzUnBVRTROYVI2?=
 =?utf-8?B?SVJONnpVaGFNVFYxTGlVcUI3RWd4Qlp4K0JxWFYybklUWGhkVmRPWHlpdHo3?=
 =?utf-8?B?eU82NFNVTVpheDFEbUtkM2F3K0pXU09QdTc2NWlwMkY2QVB6alMremtsNFp4?=
 =?utf-8?B?Nm1HUmF6K2NvTXZycFljYVNia01sTTBNZmlOK3pPbUUyK21GcllHK1Q2MDZq?=
 =?utf-8?B?Zmh6L3FOcFRFdG5UaU5MR3BneExkODdKTi9nZTJkYmFqcVQ4TTliUkZXbURp?=
 =?utf-8?B?dzh3Z3I3SXpWTW5KNW50RmZyRGM4bGhjQzluZDN6OVBTVjc0dVpxQ3h0bFpl?=
 =?utf-8?B?M0dsaXJVeXdyQ1FWL2pvbExlL2M3RytwNGI5bG9wU00rcVFtYURvckxMYWdV?=
 =?utf-8?B?WEJSZU82Qm03bUp3bXZLNE1EUzg4alQ4WHcvMFU4TDhsdUJ6R3Ftc3BJWmxI?=
 =?utf-8?B?blhZUkx5Tytqb1loWDVnS29HK3hmTjBLWStzcUs3ZGtrck5TRW1GRGxMQ1A5?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8D3391CBD216C4486B6FF820CEC8B7B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38fa77f-42cb-4644-73f9-08db356ea16b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 00:42:27.3542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OT0dNwRLvnkM66C04VNzAVwW25hnm1tMwiGkVCzzTFss4AhQiIbNth8W/dt7ZJkmYUXRw2Tihk+saINKNJdDPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4527
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaW8sCgpPbiBNb24sIDIwMjMtMDQtMDMgYXQgMTY6MTggLTA1MDAsIE1hcmlvIExpbW9u
Y2llbGxvIHdyb3RlOgo+IFVzZXJzcGFjZSBjYW4ndCBlYXNpbHkgZGlzY292ZXIgaG93IG11Y2gg
b2YgYSBzbGVlcCBjeWNsZSB3YXMgc3BlbnQgaW4gYQo+IGhhcmR3YXJlIHNsZWVwIHN0YXRlIHdp
dGhvdXQgdXNpbmcga2VybmVsIHRyYWNpbmcgYW5kIHZlbmRvciBzcGVjaWZpYyBzeXNmcwo+IG9y
IGRlYnVnZnMgZmlsZXMuCj4gCj4gVG8gbWFrZSB0aGlzIGluZm9ybWF0aW9uIG1vcmUgZGlzY292
ZXJhYmxlLCBpbnRyb2R1Y2UgdHdvIG5ldyBzeXNmcyBmaWxlczoKPiAxKSBUaGUgdGltZSBzcGVu
dCBpbiBhIGh3IHNsZWVwIHN0YXRlIGZvciBsYXN0IGN5Y2xlLgo+IDIpIFRoZSB0aW1lIHNwZW50
IGluIGEgaHcgc2xlZXAgc3RhdGUgc2luY2UgdGhlIGtlcm5lbCBib290ZWQKPiBCb3RoIG9mIHRo
ZXNlIGZpbGVzIHdpbGwgYmUgcHJlc2VudCBvbmx5IGlmIHRoZSBzeXN0ZW0gc3VwcG9ydHMgczJp
ZGxlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNp
ZWxsb0BhbWQuY29tPgo+IC0tLQo+IHY1LT52NjoKPiDCoCogQWRkIHRvdGFsIGF0dHJpYnV0ZSBh
cyB3ZWxsCj4gwqAqIENoYW5nZSB0ZXh0IGZvciBkb2N1bWVudGF0aW9uCj4gwqAqIEFkanVzdCBm
bG93IG9mIGlzX3Zpc2libGUgY2FsbGJhY2suCj4gwqAqIElmIG92ZXJmbG93IHdhcyBkZXRlY3Rl
ZCBpbiB0b3RhbCBhdHRyaWJ1dGUgcmV0dXJuIC1FT1ZFUkZMT1cKPiDCoCogUmVuYW1lIHN5bWJv
bAo+IMKgKiBBZGQgc3R1YiBmb3Igc3ltYm9sIGZvciBidWlsZHMgd2l0aG91dCBDT05GSUdfUE1f
U0xFRVAKPiB2NC0+djU6Cj4gwqAqIFByb3ZpZGUgdGltZSBpbiBtaWNyb3NlY29uZHMgaW5zdGVh
ZCBvZiBwZXJjZW50LiBVc2Vyc3BhY2UgY2FuIGNvbnZlcnQKPiDCoMKgIHRoaXMgaWYgZGVzaXJh
YmxlLgo+IC0tLQo+IMKgRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1wb3dlciB8IDI3
ICsrKysrKysrKysrKysrKysKPiDCoGluY2x1ZGUvbGludXgvc3VzcGVuZC5owqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgNSArKysKPiDCoGtlcm5lbC9wb3dlci9tYWluLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0NSArKysrKysrKysrKysrKysrKysrKysr
KysrKysKPiDCoDMgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLXBvd2VyCj4gYi9Eb2N1bWVudGF0
aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLXBvd2VyCj4gaW5kZXggZjk5ZDQzM2ZmMzExLi4zNzI0MDU3
NWQyODIgMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1wb3dl
cgo+ICsrKyBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtcG93ZXIKPiBAQCAtNDEz
LDYgKzQxMywzMyBAQCBEZXNjcmlwdGlvbjoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoFRoZSAvc3lzL3Bvd2VyL3N1c3BlbmRfc3RhdHMvbGFzdF9mYWlsZWRfc3RlcCBmaWxlIGNv
bnRhaW5zCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0aGUgbGFzdCBmYWlsZWQg
c3RlcCBpbiB0aGUgc3VzcGVuZC9yZXN1bWUgcGF0aC4KPiDCoAo+ICtXaGF0OsKgwqDCoMKgwqDC
oMKgwqDCoMKgL3N5cy9wb3dlci9zdXNwZW5kX3N0YXRzL2xhc3RfaHdfc2xlZXAKPiArRGF0ZTrC
oMKgwqDCoMKgwqDCoMKgwqDCoEp1bmUgMjAyMwo+ICtDb250YWN0OsKgwqDCoMKgwqDCoMKgTWFy
aW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+Cj4gK0Rlc2NyaXB0aW9u
Ogo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBUaGUgL3N5cy9wb3dlci9zdXNwZW5k
X3N0YXRzL2xhc3RfaHdfc2xlZXAgZmlsZQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBjb250YWlucyB0aGUgZHVyYXRpb24gb2YgdGltZSBzcGVudCBpbiBhIGhhcmR3YXJlIHNsZWVw
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXRlIGluIHRoZSBtb3N0IHJlY2Vu
dCBzeXN0ZW0gc3VzcGVuZC1yZXN1bWUgY3ljbGUuCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoFRoaXMgbnVtYmVyIGlzIG1lYXN1cmVkIGluIG1pY3Jvc2Vjb25kcy4KPiArCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE5PVEU6IExpbWl0YXRpb25zIGluIHRoZSBzaXpl
IG9mIHRoZSBoYXJkd2FyZSBjb3VudGVycyBtYXkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY2F1c2UgdGhpcyB2YWx1ZSB0byBiZSBpbmFjY3VyYXRlIGluIGxvbmdlciBzbGVlcCBj
eWNsZXMuCj4gKwo+ICtXaGF0OsKgwqDCoMKgwqDCoMKgwqDCoMKgL3N5cy9wb3dlci9zdXNwZW5k
X3N0YXRzL3RvdGFsX2h3X3NsZWVwCj4gK0RhdGU6wqDCoMKgwqDCoMKgwqDCoMKgwqBKdW5lIDIw
MjMKPiArQ29udGFjdDrCoMKgwqDCoMKgwqDCoE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1v
bmNpZWxsb0BhbWQuY29tPgo+ICtEZXNjcmlwdGlvbjoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgVGhlIC9zeXMvcG93ZXIvc3VzcGVuZF9zdGF0cy90b3RhbF9od19zbGVlcCBmaWxl
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRhaW5zIHRoZSBhZ2dyZWdhdGUg
b2YgdGltZSBzcGVudCBpbiBhIGhhcmR3YXJlIHNsZWVwCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHN0YXRlIHNpbmNlIHRoZSBrZXJuZWwgd2FzIGJvb3RlZC4gVGhpcyBudW1iZXIK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaXMgbWVhc3VyZWQgaW4gbWljcm9zZWNv
bmRzLgo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTk9URTogTGltaXRhdGlv
bnMgaW4gdGhlIHNpemUgb2YgdGhlIGhhcmR3YXJlIGNvdW50ZXJzIG1heQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBjYXVzZSB0aGlzIHZhbHVlIHRvIGJlIGluYWNjdXJhdGUgaW4g
bG9uZ2VyIHNsZWVwIGN5Y2xlcy4KPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oElmIGFuIG92ZXJmbG93IGhhcyBiZWVuIGRldGVjdGVkIHRoaXMgZmlsZSB3aWxsIHJldHVybgo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAtRU9WRVJGTE9XLgo+ICsKPiDCoFdoYXQ6
wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lzL3Bvd2VyL3N5bmNfb25fc3VzcGVuZAo+IMKgRGF0ZTrC
oMKgwqDCoMKgwqDCoMKgwqDCoE9jdG9iZXIgMjAxOQo+IMKgQ29udGFjdDrCoMKgwqDCoMKgwqDC
oEpvbmFzIE1ldXJlciA8am9uYXNAZnJlZXNvdXJjZXMub3JnPgo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3N1c3BlbmQuaCBiL2luY2x1ZGUvbGludXgvc3VzcGVuZC5oCj4gaW5kZXggY2Zl
MTlhMDI4OTE4Li4wNjllZjBjMGFlNTcgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9zdXNw
ZW5kLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3N1c3BlbmQuaAo+IEBAIC02OCw2ICs2OCw4IEBA
IHN0cnVjdCBzdXNwZW5kX3N0YXRzIHsKPiDCoMKgwqDCoMKgwqDCoMKgaW50wqDCoMKgwqDCoGxh
c3RfZmFpbGVkX2Vycm5vOwo+IMKgwqDCoMKgwqDCoMKgwqBpbnTCoMKgwqDCoMKgZXJybm9bUkVD
X0ZBSUxFRF9OVU1dOwo+IMKgwqDCoMKgwqDCoMKgwqBpbnTCoMKgwqDCoMKgbGFzdF9mYWlsZWRf
c3RlcDsKPiArwqDCoMKgwqDCoMKgwqB1NjTCoMKgwqDCoMKgbGFzdF9od19zbGVlcDsKPiArwqDC
oMKgwqDCoMKgwqB1NjTCoMKgwqDCoMKgdG90YWxfaHdfc2xlZXA7Cj4gwqDCoMKgwqDCoMKgwqDC
oGVudW0gc3VzcGVuZF9zdGF0X3N0ZXDCoMKgZmFpbGVkX3N0ZXBzW1JFQ19GQUlMRURfTlVNXTsK
PiDCoH07Cj4gwqAKPiBAQCAtNDg5LDYgKzQ5MSw3IEBAIHZvaWQgcmVzdG9yZV9wcm9jZXNzb3Jf
c3RhdGUodm9pZCk7Cj4gwqBleHRlcm4gaW50IHJlZ2lzdGVyX3BtX25vdGlmaWVyKHN0cnVjdCBu
b3RpZmllcl9ibG9jayAqbmIpOwo+IMKgZXh0ZXJuIGludCB1bnJlZ2lzdGVyX3BtX25vdGlmaWVy
KHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIpOwo+IMKgZXh0ZXJuIHZvaWQga3N5c19zeW5jX2hl
bHBlcih2b2lkKTsKPiArZXh0ZXJuIHZvaWQgcG1fcmVwb3J0X2h3X3NsZWVwX3RpbWUodTY0IHQp
Owo+IMKgCj4gwqAjZGVmaW5lIHBtX25vdGlmaWVyKGZuLCBwcmkpIHvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwKPiDCoMKgwqDCoMKgwqDCoMKgc3Rh
dGljIHN0cnVjdCBub3RpZmllcl9ibG9jayBmbiMjX25iID3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBcCj4gQEAgLTUyNiw2ICs1MjksOCBAQCBzdGF0aWMgaW5saW5lIGludCB1
bnJlZ2lzdGVyX3BtX25vdGlmaWVyKHN0cnVjdAo+IG5vdGlmaWVyX2Jsb2NrICpuYikKPiDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gwqB9Cj4gwqAKPiArc3RhdGljIGlubGluZSB2b2lkIHBt
X3JlcG9ydF9od19zbGVlcF90aW1lKHU2NCB0KSB7fTsKPiArCj4gwqBzdGF0aWMgaW5saW5lIHZv
aWQga3N5c19zeW5jX2hlbHBlcih2b2lkKSB7fQo+IMKgCj4gwqAjZGVmaW5lIHBtX25vdGlmaWVy
KGZuLCBwcmkpwqDCoMKgZG8geyAodm9pZCkoZm4pOyB9IHdoaWxlICgwKQo+IGRpZmYgLS1naXQg
YS9rZXJuZWwvcG93ZXIvbWFpbi5jIGIva2VybmVsL3Bvd2VyL21haW4uYwo+IGluZGV4IDMxZWM0
YTliOWQ3MC4uZmZkNGRkNDNjYmRkIDEwMDY0NAo+IC0tLSBhL2tlcm5lbC9wb3dlci9tYWluLmMK
PiArKysgYi9rZXJuZWwvcG93ZXIvbWFpbi5jCj4gQEAgLTYsNiArNiw3IEBACj4gwqAgKiBDb3B5
cmlnaHQgKGMpIDIwMDMgT3BlbiBTb3VyY2UgRGV2ZWxvcG1lbnQgTGFiCj4gwqAgKi8KPiDCoAo+
ICsjaW5jbHVkZSA8bGludXgvYWNwaS5oPgo+IMKgI2luY2x1ZGUgPGxpbnV4L2V4cG9ydC5oPgo+
IMKgI2luY2x1ZGUgPGxpbnV4L2tvYmplY3QuaD4KPiDCoCNpbmNsdWRlIDxsaW51eC9zdHJpbmcu
aD4KPiBAQCAtODMsNiArODQsMTggQEAgaW50IHVucmVnaXN0ZXJfcG1fbm90aWZpZXIoc3RydWN0
IG5vdGlmaWVyX2Jsb2NrICpuYikKPiDCoH0KPiDCoEVYUE9SVF9TWU1CT0xfR1BMKHVucmVnaXN0
ZXJfcG1fbm90aWZpZXIpOwo+IMKgCj4gK3ZvaWQgcG1fcmVwb3J0X2h3X3NsZWVwX3RpbWUodTY0
IHQpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBzdXNwZW5kX3N0YXRzLmxhc3RfaHdfc2xlZXAgPSB0
Owo+ICvCoMKgwqDCoMKgwqDCoGlmIChzdXNwZW5kX3N0YXRzLnRvdGFsX2h3X3NsZWVwID09IC1F
T1ZFUkZMT1cpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiArwqDC
oMKgwqDCoMKgwqBpZiAoc3VzcGVuZF9zdGF0cy50b3RhbF9od19zbGVlcCArIHQgPCBzdXNwZW5k
X3N0YXRzLnRvdGFsX2h3X3NsZWVwKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBz
dXNwZW5kX3N0YXRzLnRvdGFsX2h3X3NsZWVwID0gLUVPVkVSRkxPVzsKPiArwqDCoMKgwqDCoMKg
wqBlbHNlCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN1c3BlbmRfc3RhdHMudG90
YWxfaHdfc2xlZXAgKz0gdDsKCnRvdGFsX2h3X3NsZWVwIGlzIHU2NC4gQXQgbWljcm9zZWNvbmQg
Z3JhbnVsYXJpdHkgaXQgd2lsbCBuZXZlciByZWFsaXN0aWNhbGx5Cm92ZXJmbG93IGFuZCBpc24n
dCB3b3J0aCB0aGUgY2hlY2sgSU1PLiBUaGUgb3ZlcmZsb3cgY29uY2VybiBjb21lcyBmcm9tIHRo
ZSB1MzIKaGFyZHdhcmUgY291bnRlciwgYnV0IEkgZG9uJ3QgdGhpbmsgdGhlcmUncyBhIGdvb2Qg
d2F5IHRvIGRldGVjdCBpdC4KCllvdSBjb3VsZCBqdXN0IHJlcG9ydCB0aGUgbWF4aW11bSBoYXJk
d2FyZSBjb3VudGVyIHRpbWUgYXMgbWF4X2h3X3NsZWVwIHNvIHVzZXJzCmtub3cgdGhlIHZhbHVl
IGlzbid0IHJlbGlhYmxlIGlmIHN1c3BlbmRlZCBmb3IgbG9uZ2VyIHRoYW4gdGhhdC4KCkRhdmlk
Cgo+ICt9Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKHBtX3JlcG9ydF9od19zbGVlcF90aW1lKTsKPiAr
Cj4gwqBpbnQgcG1fbm90aWZpZXJfY2FsbF9jaGFpbl9yb2J1c3QodW5zaWduZWQgbG9uZyB2YWxf
dXAsIHVuc2lnbmVkIGxvbmcKPiB2YWxfZG93bikKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgaW50
IHJldDsKPiBAQCAtMzc3LDYgKzM5MCwyMiBAQCBzdGF0aWMgc3NpemVfdCBsYXN0X2ZhaWxlZF9z
dGVwX3Nob3coc3RydWN0IGtvYmplY3QKPiAqa29iaiwKPiDCoH0KPiDCoHN0YXRpYyBzdHJ1Y3Qg
a29ial9hdHRyaWJ1dGUgbGFzdF9mYWlsZWRfc3RlcCA9IF9fQVRUUl9STyhsYXN0X2ZhaWxlZF9z
dGVwKTsKPiDCoAo+ICtzdGF0aWMgc3NpemVfdCBsYXN0X2h3X3NsZWVwX3Nob3coc3RydWN0IGtv
YmplY3QgKmtvYmosCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBrb2Jq
X2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJu
IHN5c2ZzX2VtaXQoYnVmLCAiJWxsdVxuIiwgc3VzcGVuZF9zdGF0cy5sYXN0X2h3X3NsZWVwKTsK
PiArfQo+ICtzdGF0aWMgc3RydWN0IGtvYmpfYXR0cmlidXRlIGxhc3RfaHdfc2xlZXAgPSBfX0FU
VFJfUk8obGFzdF9od19zbGVlcCk7Cj4gKwo+ICtzdGF0aWMgc3NpemVfdCB0b3RhbF9od19zbGVl
cF9zaG93KHN0cnVjdCBrb2JqZWN0ICprb2JqLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBzdHJ1Y3Qga29ial9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKPiArewo+ICvCoMKg
wqDCoMKgwqDCoGlmIChzdXNwZW5kX3N0YXRzLnRvdGFsX2h3X3NsZWVwID09IC1FT1ZFUkZMT1cp
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBzdXNwZW5kX3N0YXRzLnRv
dGFsX2h3X3NsZWVwOwo+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVs
bHVcbiIsIHN1c3BlbmRfc3RhdHMudG90YWxfaHdfc2xlZXApOwo+ICt9Cj4gK3N0YXRpYyBzdHJ1
Y3Qga29ial9hdHRyaWJ1dGUgdG90YWxfaHdfc2xlZXAgPSBfX0FUVFJfUk8odG90YWxfaHdfc2xl
ZXApOwo+ICsKPiDCoHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpzdXNwZW5kX2F0dHJzW10gPSB7
Cj4gwqDCoMKgwqDCoMKgwqDCoCZzdWNjZXNzLmF0dHIsCj4gwqDCoMKgwqDCoMKgwqDCoCZmYWls
LmF0dHIsCj4gQEAgLTM5MSwxMiArNDIwLDI4IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpz
dXNwZW5kX2F0dHJzW10gPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCZsYXN0X2ZhaWxlZF9kZXYuYXR0
ciwKPiDCoMKgwqDCoMKgwqDCoMKgJmxhc3RfZmFpbGVkX2Vycm5vLmF0dHIsCj4gwqDCoMKgwqDC
oMKgwqDCoCZsYXN0X2ZhaWxlZF9zdGVwLmF0dHIsCj4gK8KgwqDCoMKgwqDCoMKgJmxhc3RfaHdf
c2xlZXAuYXR0ciwKPiArwqDCoMKgwqDCoMKgwqAmdG90YWxfaHdfc2xlZXAuYXR0ciwKPiDCoMKg
wqDCoMKgwqDCoMKgTlVMTCwKPiDCoH07Cj4gwqAKPiArc3RhdGljIHVtb2RlX3Qgc3VzcGVuZF9h
dHRyX2lzX3Zpc2libGUoc3RydWN0IGtvYmplY3QgKmtvYmosIHN0cnVjdCBhdHRyaWJ1dGUKPiAq
YXR0ciwgaW50IGlkeCkKPiArewo+ICvCoMKgwqDCoMKgwqDCoGlmIChhdHRyICE9ICZsYXN0X2h3
X3NsZWVwLmF0dHIgJiYKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXR0ciAhPSAmdG90YWxfaHdf
c2xlZXAuYXR0cikKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA0NDQ7
Cj4gKwo+ICsjaWZkZWYgQ09ORklHX0FDUEkKPiArwqDCoMKgwqDCoMKgwqBpZiAoYWNwaV9nYmxf
RkFEVC5mbGFncyAmIEFDUElfRkFEVF9MT1dfUE9XRVJfUzApCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiAwNDQ0Owo+ICsjZW5kaWYKPiArwqDCoMKgwqDCoMKgwqByZXR1
cm4gMDsKPiArfQo+ICsKPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIHN1
c3BlbmRfYXR0cl9ncm91cCA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgLm5hbWUgPSAic3VzcGVuZF9z
dGF0cyIsCj4gwqDCoMKgwqDCoMKgwqDCoC5hdHRycyA9IHN1c3BlbmRfYXR0cnMsCj4gK8KgwqDC
oMKgwqDCoMKgLmlzX3Zpc2libGUgPSBzdXNwZW5kX2F0dHJfaXNfdmlzaWJsZSwKPiDCoH07Cj4g
wqAKPiDCoCNpZmRlZiBDT05GSUdfREVCVUdfRlMK
