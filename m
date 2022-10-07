Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AA55F80DB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 00:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJGWlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 18:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJGWll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 18:41:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72AB816BC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 15:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665182499; x=1696718499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tqBFrftQMmmSMcnVxq2dRMlB7BAGIUmAL5/SWsJnFcY=;
  b=I6BhzjUWizeAVDJ96x1UYNzqag+S8TSRgnurZgNCsyxndhPVWBcFOo+u
   j39sErn77RPWyKxdL6IMmseLtvAT4Ugu3az2yOfxnxL5qd2DXOj14rAGc
   W8EahR0aLkn81ya7Q2uuLnLsq6e7quT5qsCMZjwvVqhdJqj6TOkrVGEem
   XKIY5tA9+2ULdDx07fbf5cyjSlXTxBRU156U0AFBDnGIcvd8030t41Jyu
   OH2Wy8KXe9/N1f/OMFfR0N6N8vkLW3d5WTJT6aczqGkOTk5pWpzG9M20Z
   7x9NI7N42bEK3Y8v/yyMPOvowMBf4h4q11M0upyNl/1QCeEGZKXX96FI0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="301456305"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="301456305"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 15:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="576399215"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="576399215"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 07 Oct 2022 15:41:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 15:41:38 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 7 Oct 2022 15:41:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 7 Oct 2022 15:41:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 7 Oct 2022 15:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCGXFNQxhICqPBTm/lqkHQ3V3km46hIJQjsN2G9gJfS3FGSt/qaZPkXOiveN7Zd9NDegsNjXg+G94CPmc53Dbo1vUw9np/mLf+YZppla9M4NWeWyOnsC74U9MpHgnrgwzbEo361L+o5V51lIiwKoF6Qf5fequ/75TKKvREU3wHR3oWbYZBtc2WorLfX/huWc1uxjcbd7lt2/mSG1fxt46s96qODWyehcA/7Tms8G+hzubQSHHx0oX+WkjGJzTHsa3YoGwxVSGlu1FnsGQofAfNDuu719Xi4LaH3bT9Gi88GS446i9cJerLrbpEOSb0T+TtDcfO6IRGEylhu+PDGRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqBFrftQMmmSMcnVxq2dRMlB7BAGIUmAL5/SWsJnFcY=;
 b=d8HIMD0SK8yxLtyBFtrKDW7dM8rOWQnVf+rg8uTeqrEUtJ8nhJCAK4zmaciOyTLbzSuOM3nTF1jAhOpgWfS9LzWh2hkPuGmBXN30tGNjzBHii0xRgQvfK6hTUnf3nzedtl8xhoVfuGsH+VFlsq/ZAhTfcppziZMpXgmXzeuJHtQhOh86S4bt7OuOrYNoUMd3iFo6IFuWkYhCB+GxEHJUVsUbU0LGxB2PXserXaCsjWXVvl9fLYbupY+PZFiUghxXQw+Y9Pxtt2K9gYJHqVKWgWMsDEr9+/CUZZ/7EQw/PX68nBU1XFs33kPK9RdiVkgLlPONqpFcQw45lT0zsZUIYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by BN0PR11MB5712.namprd11.prod.outlook.com
 (2603:10b6:408:160::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 22:41:36 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 22:41:36 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: RE: [PATCH 5/6] x86/gsseg: move load_gs_index() to its own header
 file
Thread-Topic: [PATCH 5/6] x86/gsseg: move load_gs_index() to its own header
 file
Thread-Index: AQHY2Z1rWj9ta4RoNEKoPLhyCs4gA64DExSAgAAiVQCAAE5KMA==
Date:   Fri, 7 Oct 2022 22:41:35 +0000
Message-ID: <BN6PR1101MB2161FA3D7F1DB25C7F2C83ACA85F9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-6-xin3.li@intel.com>
 <CAMzpN2gYp0WXQYX1GHad3jCvoBBbO4yiEk_sJrfNUF1zGGapsg@mail.gmail.com>
 <6CBB0EC9-5EF1-4396-9B5F-C0A5592BFD37@zytor.com>
In-Reply-To: <6CBB0EC9-5EF1-4396-9B5F-C0A5592BFD37@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|BN0PR11MB5712:EE_
x-ms-office365-filtering-correlation-id: 4099ec6c-2421-454e-2380-08daa8b51754
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oeekpRTMJ3A6ZIpoxKHsSCk/pqsTCYi3Hpqvv/8O7S0TWHlyvWf8NGlLKDQ9Fi9NKWCPnseUnY0KaRIJAika9oHn2Yhy8nLWufTifut//Hw2im0HmI++5Qw/qIEn/ulnD7ZDZv+tcoANDESAGmgRGZzrlmX36CWRpb2VDSY759roGoD7myS7+GYHY4Vn5TUPPTSL6aJ4e2GiOCVnIlpX0UeTdwq3N08KbjxaN6zC5mmU1MA3ubQne317xtsY9mjNC2qInDAV5l1zVn1kHgGChzG+W3txFq0TKKRhNf8t3/fpv7kancwU4HQbpICkCGsJl+YkqiYAbgjAXSd/7j4lHOpQplgOhQPfzdbXc6QOzAhPdsMJBVU3uYBGfSitDi4V5Kn6VgdiB1sozOffwpIRrV/OrnHh4gfmoLZHpLsg4qeCtgQTKqbpt9h6flJOUL2Ci9wkjtSyoHnv4ayzlM2eNk5MHzRg2X97UY20ostJjwZCAKyEWQIPEGH8qjC54CKVmK4MnxKqNYujew0tQGqJsg6OTi8dr8YUUgfh4nQMDoGnBQm0AETUixkbL2IVtcWMBmsPLucYqkhWPCovhJsGGfeG6Zwxjoyxst7ybf0J5GQLCt1HS0wnGJcI8Nb0B8L6bad51S2/x4ag4tKFBJqzk+TvbPS2CZmmnZI7n2glQIpIHGQrzo1Tb+HVFQp7pLkOgDs9XJlPDD24HrEHu0Jc7Tf+qqKza+51ZEBXqU9tbSoAPUR2CsGmOAviNzKhMGsnibjceOg9OxJZBXCRPrtxsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(186003)(6506007)(83380400001)(52536014)(26005)(7696005)(54906003)(4744005)(478600001)(5660300002)(71200400001)(66476007)(316002)(8676002)(64756008)(76116006)(41300700001)(4326008)(9686003)(66446008)(66946007)(55016003)(110136005)(8936002)(66556008)(86362001)(122000001)(2906002)(38070700005)(82960400001)(33656002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTFEWWwvTHhGRlprODJUY3ZQaHNUYXlBQytzbmtYbmpCcXBVanMzZGlGT0Na?=
 =?utf-8?B?QThpUnNKcjRiY2YySlozZTBqTG1GVDEwS1BoOGNpZTYxZitLWVhrei9neTcy?=
 =?utf-8?B?eVJ6NU1ia2srbHB4bFg2MWc3WTQ1a01VRFBrWXI3NGNJcEo5Rkp2Q2loWTRI?=
 =?utf-8?B?YzJlOFhqRjIxenlybkNaN3RoVm5TMG1hQXRhMU1Ndm1MblNaMCtybTVvQlND?=
 =?utf-8?B?Nk9IZDNML21BN0ZiTVlTdDN6ZnZteFJBeGJKc1g4MXU4OGRtK2FDdnFKMjB5?=
 =?utf-8?B?QW1maWV3VHh6WVI4MEw2WmZiTHZta0JZNU1ZOVFaT2trOHhxUnVLWFlsbVlW?=
 =?utf-8?B?VEJQZ1A0WXdYdk1TdFg0WmRLWllEVG1PYjJRcWxTOFFreU8wWkFnbmtiT1dV?=
 =?utf-8?B?eWJSNDJ6Y2VQRkFrTWhCNCtoc3JONGZYemNINkZBUC9sL05jcWZJU3U0VkIw?=
 =?utf-8?B?N0tYblFhUUJvY1MrOHdLS0RENjBwdkV5b1NNRGRkN3l1ZFRqVXRPK29temoz?=
 =?utf-8?B?ZXdYS1ZBY1orSkZVdkd5d1Z6ZVVlL0lib09qN1puN0VOZmtBa1pFWlNwdDJF?=
 =?utf-8?B?QXhWUWFTV3dDMDhpRlY1amorRGhCU1hjazhxOGYzL1RrdmE4N3QxOGJPTHlY?=
 =?utf-8?B?RlpTQ0VNUjRaTEhZWk5peVNBcys5aHQ1L3ZYWWtlNk1yWGRvSVQ1Wk1HRU1y?=
 =?utf-8?B?WHlxdnQ0UGNtOFJ2aHUzSFFleGxGcmlhc2JFYmN5VG5QVlFVMzdsSWk4cmZi?=
 =?utf-8?B?ZDNvTHc0elN4cm9QdytsbFZUN0ZIYlJ0SWJpeW0ybk5YWU9QKzNoMVpnSy84?=
 =?utf-8?B?bStraGczVERoNy8rUytBZHIvQ1pKUlhhS1hQOWMxc0tra2Jzb0htOURLbVFw?=
 =?utf-8?B?eU1xZUlBb1FXc0RkMllvWERLM29wWXNodHNramZoWEZKSXpjaWdYYW95MmFp?=
 =?utf-8?B?THNvaWJxREd5S051djJqcDFMajNCSE9JZEFVN2JrZEJGVmpPZ01ndXdyNUFt?=
 =?utf-8?B?bWtJN3NVT0RTK2JkN2hnY241aFlPYjdMV2tCdGNmaU5QYlpsdGc1bUFsdlFO?=
 =?utf-8?B?YjlNeGVURC83TW1ybEtOY0ZKQlFsZ1RlcXgyU3VqeDNBL1E5TjFzTStKcWFB?=
 =?utf-8?B?Vklic2VMU3pZUmpHWFM1RDRmMnVDNnMwMHBTUGp6MDRMZzhEcEVQVy9VTy94?=
 =?utf-8?B?WTlwS2ZPN1VCcFJNMHZMRG1zOWhSVkN2M1BZZlBCSUViK3BCdVZwM2lkNklU?=
 =?utf-8?B?S3QrS3N5VlplR3NvZDdZc0hzMHcrNnNKUUdjdjZyeER3QzBHeGMzUUpTY2VB?=
 =?utf-8?B?QURVRUdiQUZKMVJFRkY2RVU1bnNZRG9CRjRHaHVGVGxrMGNVeXFmb0hkZUdL?=
 =?utf-8?B?YVRMMUYyNHVJUXpCQUc3UFY4ck4wb2dvSW95dFRqSHRrYml4L1ZhUndzZXMx?=
 =?utf-8?B?SzExRERoQVRLRkN5Yk55cEF1YU1tL21zblM5N1MzbXRtMWowTW5pd3hXU1Zp?=
 =?utf-8?B?My83dWZTNEJHUVg1RTRKV29KTkoycnViYkxFR1NuSGpYWW1rQW53enJxd3R2?=
 =?utf-8?B?UTZZd3JEYVdRMzkreHJ3UnRLN25OTjd0eWhFbTRrdGpMUDBpWjh6Wis1dC9a?=
 =?utf-8?B?c1lVSkxtWldoOUd5MmQyN0RCTkttYnpYbDJlbktWaVVseDBaRnZhOGg0ekQr?=
 =?utf-8?B?K29waldWL1U5QjVNczVTaHcwS1pKNENpSG4yZXVGWHplb2grYmVPK09XOHNq?=
 =?utf-8?B?ZUVtdVE3NWNkVUhuaml2ZUFVMk1EWVduckdMRjlkeXlzZFRjc1ROeXVkSUtT?=
 =?utf-8?B?dmdFbGVmTEo0OGRkV1hUQ2hjbTc0anhNby9YNDM4ZkZYNk5IejNBamdGTXNp?=
 =?utf-8?B?K2MzTkx0Qlk5WEtvSDhtOEFLMmQzRnhEbjlDREl4alFraFpMWUxPKysrOWE1?=
 =?utf-8?B?b0s5eG1EQWdid3QyNkdIUk4wczJINnpvVFBYSU13bFN1RlBtdiszdUcxT3ll?=
 =?utf-8?B?MWh2VlpGbVI3K0drb3BLUWE1TldqUWE5TVFQZmpXbXhONVBaT3lCdjFmVkxp?=
 =?utf-8?B?T0laRk4vSHkvaUpOek5WbDNiTTE2WmErSkgydkxHT1E1ZXNoeVpZeGQ0THl2?=
 =?utf-8?Q?qn9k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4099ec6c-2421-454e-2380-08daa8b51754
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 22:41:36.0127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nlFFxUBVl69420dK5wQcosQ0LDE2J/TOiExLvRfREGV0G6wh+YeaZ/f29Ktf1JOL+bZMl0ivhXq5ip8QCNBn7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5712
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBPY3RvYmVyIDcsIDIwMjIgODo0MDo0MSBBTSBQRFQsIEJyaWFuIEdlcnN0IDxicmdlcnN0
QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID5PbiBUaHUsIE9jdCA2LCAyMDIyIGF0IDEyOjEzIFBNIFhp
biBMaSA8eGluMy5saUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+PiBGcm9tOiAiSC4gUGV0
ZXIgQW52aW4gKEludGVsKSIgPGhwYUB6eXRvci5jb20+DQo+ID4+DQo+ID4+IDxhc20vY3B1ZmVh
dHVyZS5oPiBkZXBlbmRzIG9uIDxhc20vc3BlY2lhbF9pbnNucy5oPiwgc28gaW4gb3JkZXIgdG8N
Cj4gPj4gYmUgYWJsZSB0byB1c2UgYWx0ZXJuYXRpdmVzIGluIG5hdGl2ZV9sb2FkX2dzX2luZGV4
KCksIGZhY3RvciBpdCBvdXQNCj4gPj4gaW50byBhIHNlcGFyYXRlIGhlYWRlciBmaWxlLg0KPiA+
Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBILiBQZXRlciBBbnZpbiAoSW50ZWwpIDxocGFAenl0b3Iu
Y29tPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBYaW4gTGkgPHhpbjMubGlAaW50ZWwuY29tPg0KPiA+
DQo+ID5UaGlzIGNvdWxkIGJlIG1vdmVkIGludG8gPGFzbS9zZWdtZW50Lmg+IGluc3RlYWQgb2Yg
Y3JlYXRpbmcgYSBuZXcgaGVhZGVyDQo+IGZpbGUuDQoNCkdvb2Qgc3VnZ2VzdGlvbi4gIEhvd2V2
ZXIgSSBzdGlsbCBwcmVmZXIgdG8ga2VlcCBHUyBzZWdtZW50IGluIGl0cyBvd24gaGVhZGVyIGZp
bGUsDQoxKSBpdCdzIGEgc3BlY2lhbCBzZWdtZW50IGZvciB4ODZfNjQga2VybmVsLCBhbmQgaXQn
cyBtb3JlIHJlYWRhYmxlIHRvIGtlZXAgaXQgc2VwYXJhdGVkLg0KMikgc2VnbWVudC5oIGlzIGlu
Y2x1ZGVkIGluIHRvbyBtYW55IGZpbGVzLCBidXQgZ3NzZWcuaCBvbmx5IDQgZmlsZXMuICBXZSBh
dm9pZCBoZWFkZXIgcG9sbHV0aW9uLg0KDQpNYXliZSB3ZSBzaG91bGQgZXZlbiBmYWN0b3IgR1Mg
c2VnbWVudCBvdXQgb2Ygc2VnbWVudC5oIGZvciB4ODZfNjQuDQoNClhpbg0KDQo+ID4NCj4gPi0t
DQo+ID5CcmlhbiBHZXJzdA0KPiANCj4gQXQgbGVhc3QgYXQgdGhlIHRpbWUgSSB3cm90ZSB0aGUg
Y29kZSwgaXQgY291bGQgbm90LCB3aXRob3V0IGNyZWF0aW5nIHlldCBhbm90aGVyDQo+IGNpcmN1
bGFyIGhlYWRlciBmaWxlIGRlcGVuZGVuY3kuDQoNCg0K
