Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72219690BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjBIOaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBIOaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:30:15 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEADA5D3DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675953013; x=1707489013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rkB8tUrtFcaX3bnyYa+dg6AjeLvZ23EXM+SHRt7A6Gc=;
  b=Ta0Gpw6az121zQjoOJr+d/sdP28AgHLr/TG1AtAWxfLgcSe7m/bz62DN
   2O0lKSC4eQUrv82D6HH6mNdgDijyL9AgtG7Npw9epfG5R9zigvQkREhY9
   Dy2TrOyXEd8BFFvZJJEQMCzJ8IENzgXfKE8UpGrKlUI6i7HuvSkLP/mPc
   QQhBlY3SoxzfwwzcRDc65hI9rmMSURL9eqRxdHUHkTrQKLzd3dwDOwXoH
   0vuJR046ai0WipSrwIt4GraOu9eCxtLLDWXeCYYzOhq/DtJGy0pLTjIPP
   FKYYFP7tB84t8AOMpyYEfXTPNlUV303RR67GVeRCJ1VRdAG6LARgDVTOS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="309765751"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="309765751"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 06:30:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="756413833"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="756413833"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Feb 2023 06:30:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 06:30:12 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 06:30:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 06:30:12 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 06:30:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7pMPXFi/r7skIACoE+WjzS6EFMUeC6ebr78sQ/Aj4aCAEHcLCqPwASRBjJPhgp1+y0M1DJLX7uvBp3ZWDnKkvBbYA+S9HmpClPCPeaiOvZPmYHTm1vCqR6g8jg0Y6j74SWP5cX3SDSK/S0raU6ecPY4Z4921emlbP9uMzKIY31bWj0Y3WlCttE/rzvuRgkylGVsrqn3eXjUEiTR6GuSVofRM0jUEWqInK1rdwbns2jL23I/MG7Y/5r5E09esbRe9QOVDXU0LGSmb1bSyPDtAHsW25A70USBgLnJVH97+v0VFGugAIthKnGi1h5l/kpcbMvznlyk5yM2VvPum+7UBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkB8tUrtFcaX3bnyYa+dg6AjeLvZ23EXM+SHRt7A6Gc=;
 b=COd/p5OuB5+xIQw0Uq2+9qbGK8n+Htm1aRl1FXfwgWtuEk8TUkyPBMLZEC2d7fcYAUtOSVrL9wcnQYnQesltY8ervwWzDsDZMdm1sVlUkXuPTMm7BD5/6sME+/0UjR2wAZ4+Z2QYc9yNn2JxJIcN964YKfUcK8kyaj6/xNo3n/6ykfpdRuA8OcOIF2AbZiAAt4WFQALN4iLdUMdhFQPxWKmHKAmLUU1xmhEK1Av+AWnkcxoHUD+bHWpdWWnxINS/iuDSSO5oM6N1BrB4aTv2ZiQaOWTgt1VIamTKCRvSTvV4b48yNFaufCZHEU7e7THaDrsKcFhzSVizrdglUSzDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 SA1PR11MB6712.namprd11.prod.outlook.com (2603:10b6:806:25c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17; Thu, 9 Feb 2023 14:30:04 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::c6d9:ec39:9492:f6ac]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::c6d9:ec39:9492:f6ac%2]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 14:30:04 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
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
Subject: RE: Linux guest kernel threat model for Confidential Computing
Thread-Topic: Linux guest kernel threat model for Confidential Computing
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwJ2YsAAAAu1hQAAHQE/AAAcTH2AAAgajYAANJDgEA==
Date:   Thu, 9 Feb 2023 14:30:03 +0000
Message-ID: <DM8PR11MB575055F96C938D09FC02B411E7D99@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <658272b5-9547-a69f-b6c9-a7ff2dd2d468@amd.com> <Y+HpmIesY96cYcWQ@kroah.com>
 <20044cae-4fab-7ef6-02a0-5955a56e5767@amd.com>
 <BN0PR11MB5758C701F81E701851ECA729E7D89@BN0PR11MB5758.namprd11.prod.outlook.com>
 <20230208080259-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230208080259-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|SA1PR11MB6712:EE_
x-ms-office365-filtering-correlation-id: 7a183e59-d016-42c3-9e49-08db0aaa2256
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zLB7DB1wfHRKJ2EkSp8BA0pjvOQYKIX1KjBhxYXF+98yWU8wfqfU5q8IIgRP+W2BoE6ErtdSydY+MICASZerbJohJdCvrXhlx2zyBDoS1y520ORI6ImMlDEDLPCy3cVyzkUH/nZpKhWsAiG4wrAZtgQQbVExkJB97C/q7vM+fvogsmoCkI5nWmOjxz2ZPHVY1M94goJy1wG/FCBDGSKvrzz268Mn77s6kSHF0NAFrasF6szc0hFA7ouB3CY134FGg2NOGLiAltOYTF3NhGrVskzet6HJBzUXaHtrmbrZlXUCpNCO4/zEz2lsDMgISFzLQdEs/zW50dh+qK+/kp8CJ4DwCz+kkp/WsEonMI1PtEwhJeMHy/wJ0ZuNYKhzFTzJ7s9DUnScB66QmqLZMTDBb6PcRu84lNVHy/Vrl/gCOzEDtpOJp/KQbdKErhDD6gIiQRJpMFbZwK2QYQxKVj3F9sR+CKr5RaYn467kH7kkYKyI26Tnl9L+v5aBe8gUjTLvtNlWz5TgH4swKEBqKEPCMoMFk6oacOfH/ubfdditYx1bZwxOcBN+hc22GMYhzTGldlyO3hzH65oTeX2WA1cq0czPwj2Rj85CBIsU1f6YMjjqxpasNcg1SlzoKUCvY+nO9cKQgTuixnmvrNKmxVEBGejsaJPLEfq43zU/ek25n2tjVncxEeqayjyUQT1fMZQefmdbvztSrZUCaYdEL1Fl1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199018)(2906002)(38070700005)(6506007)(5660300002)(7416002)(26005)(86362001)(33656002)(66446008)(8676002)(4326008)(66476007)(76116006)(55016003)(316002)(64756008)(66556008)(6916009)(66946007)(71200400001)(82960400001)(54906003)(41300700001)(7696005)(478600001)(38100700002)(52536014)(9686003)(186003)(8936002)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M281OHRiNnhGQjBORnhmL0xyQlRKNUFrTHFUeE1NWGxvVXlRa01yZ3hNSjVx?=
 =?utf-8?B?Skl0a09LZmZGWjhLUit4MFhUbkllZHRLTVJFM3IwOWM4UTgvTTdFY1VuSlhP?=
 =?utf-8?B?SFhMQ0drTEhFQ1dPMnNvOTFMeVM2NXpnQjRZNFJ3VHhxL3lkelFPQ3NJL3Vo?=
 =?utf-8?B?cDIzSTlkY3F5OEIxZXArSElUNlZWZG0xOE05eWpFN1NqSnIrUE1YdkRWeis0?=
 =?utf-8?B?S3p2ZVMyYmNEaVNiUWZEb253Uy90Y2NvRVExTlNHY3paZjhYWkRYM2dnL1Nj?=
 =?utf-8?B?bGM2S2YwZ1JES2FvZkNNRVdOVndwZjBHbi8ycE9IL3B3ekFVTERIeWwrQXVG?=
 =?utf-8?B?VUdBYzYxYTRERGdIamZZRW1idndwYzErOGs5TGd3SU9QZHlROGluRm9IeTJU?=
 =?utf-8?B?TUI5K3hXcmRpQkNtMXN1N0NraXhKcG9LcWJzd1d3dlBtOVZKT3M2amo0NXgz?=
 =?utf-8?B?Q0c0akdRbUIzVFpWa0xyL2VCblNsRy9NMElPa3YzMUxEQkpIcktIUW5YaXdz?=
 =?utf-8?B?dXNxck1mVEpKRExaSXFYckZiT29LWWJ1V3VkOGZXU043aEZTOTl0YVdqSmJQ?=
 =?utf-8?B?RE93QXFKc1BnRTBqbnhNWVZSWkM4WXJpQlNGbVJYS0tDTTNuS2ZtSStadUh2?=
 =?utf-8?B?SFhPTnYzOU1wYktWOGVwcnBqR2I2L2VBVnZwenZiUUFvZUt5eFp5NE8wRWF4?=
 =?utf-8?B?SXltSzRlV20xeVNhWkhLeXErM2E5NzREQXZvczd2UGRZWGNrRW12RXk0WVNB?=
 =?utf-8?B?WkYxdUlBYXBaelhWQ3dZWXZETmxyWERYdVNIL09XSW9PTEZaMUI4WVl3L2Mx?=
 =?utf-8?B?TkVCYXNMSk1FOE4zNVdvT3hFaXZZUHZkNFZOWS95NzgrdEZob0V6YWxWaEdG?=
 =?utf-8?B?MElYTU9IV2M4Ky85aVpXMmUxRHFrU0FGVW9oUVNvUHJqakRPdk5Tdmo4Zktz?=
 =?utf-8?B?b3NvNnR1YVlwRHVVcE9aa09VYlRhL3ZWVElZRTlSTlRXcXgxd3loYzFNUXR1?=
 =?utf-8?B?Sk9oRW1BRnJUTlRFc2R6UHM3cmw2V1hhNXEvM09aRW9zd3JQZzdvTjJKZGlz?=
 =?utf-8?B?ek1rVkk3V0UrRGVXcDZIVEg4cVRIRmhhNngxMGJVb0h4S2lMS3ZKYVluV0hJ?=
 =?utf-8?B?QUU0eGZLbEVvQ3EySkJNaTZ4czR2MVA3LzA5TmJaTFNZUllUZFZxL1JwS0d2?=
 =?utf-8?B?UGoxaER6aFJGRUhqQXdpYVYyNUJocXZCSnVTVFY3M2dCZ09hUHVFOWV3MlVU?=
 =?utf-8?B?NFZhK1pyc2VTUlppUmdmaDAyNk9nL09LUWRmbS9wT1pzZlNFMDdSbjNLNGxh?=
 =?utf-8?B?aXUwS0djRHNzMHI1ek1qdHRVTmQ3RDZHQklGcUhsQkNJR3JreUVkUSsxQnE2?=
 =?utf-8?B?WDBKcFVZNzR6bDQ4N3JMNlliQ2VQMFl0MUxZRWdoY00vYnB3WDhYV0hld1ZY?=
 =?utf-8?B?ZUNWajliRnhoVzYxYkZIVEdVeHJMWkZ4ekU0RERGekFuU3UySVFUaW95djgy?=
 =?utf-8?B?amYzdytxd1IwN05FWVJFWElIa0Z4cjRCUzRhY2E1SmtjSjdLOTBzRGRhMlZF?=
 =?utf-8?B?RzJwUDQ3YXVEUEIxcUVTR0FmZzE4SDZsMlhFSFVUaGpnazlPdzBoLzZycnQ1?=
 =?utf-8?B?aUNBQi9MTGhIczM0NC9BWGdxRGVRTHFyNUtmRVl3ZWl2OHBncy9iNW8vOWdx?=
 =?utf-8?B?dTNlV2V1b1lCemJZVHFNeERlc3JIQyt0czNkb0FTZ2tTRGdqNUJxTVJSTnNC?=
 =?utf-8?B?dnY5N3dOejBqM3YrZjF6MXdMSGlVRzJtbTZuNXMrQW1RS3R0VHlON1dwVnJN?=
 =?utf-8?B?TjhoOFJ5SUlTc3EwNUJUYVFIWUpqbTI4aFRZSHIrYkR5bVFUZDJvN215dWZX?=
 =?utf-8?B?bnhDZUsyUmZwdnVuUkJiMkQ3eUtqMzYwc2NiUC9TcXZsSFJFT1AzaVpKdGJi?=
 =?utf-8?B?aS9CK1duMURGeGxKazRzSmk4SUlNQzJONzZBaUxNRkdSbVlzSlFkVTlyNEwr?=
 =?utf-8?B?YnNFTGlnVGM2NTZPZW52c3MyditPaitTeHdOV3Yrek1EeVdYblZCeEpwNkJP?=
 =?utf-8?B?TUlWak55QU81SFVKUzEvQTAyYWFYYjJDWHVMdGZnSWhTelpMSnIxNDBCeWsz?=
 =?utf-8?Q?2wvisEMzA24sCcr8zFENPC8dg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a183e59-d016-42c3-9e49-08db0aaa2256
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 14:30:03.9252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6wSGd1eWPyYfYkJ498xVWiv5tJjSV64tmsWAoX6lLI7fDbPWAuti7ij1mbN98pKgo/vWsontsqeW9wqjJAMQ80SroDbrwbbr+iOIMFYUkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6712
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIEZlYiAwOCwgMjAyMyBhdCAxMDoxNjoxNEFNICswMDAwLCBSZXNoZXRvdmEsIEVs
ZW5hIHdyb3RlOg0KPiA+ID4gTm8gcmVsYXRpb24gb3RoZXIgdGhhbiBpdCB3b3VsZCBiZSBuaWNl
IHRvIGhhdmUgYSBzb2x1dGlvbiB0aGF0IGRvZXMgbm90DQo+ID4gPnJlcXVpcmUga2VybmVsIGNv
bW1hbmQgbGluZSBhbmQgdGhhdCBwcmV2ZW50cyBfX2luaXQoKXMuDQo+ID4NCj4gPiBGb3IgX19p
bml0cyBzZWUgYmVsb3cuIEZvciB0aGUgY29tbWFuZCBsaW5lLCBpdCBpcyBwcmV0dHkgc3RyYWln
aHRmb3J3YXJkIHRvDQo+ID4gbWVhc3VyZSBpdCBhbmQgYXR0ZXN0IGl0cyBpbnRlZ3JpdHkgbGF0
ZXI6IHdlIG5lZWQgdG8gZG8gaXQgZm9yIG90aGVyIHBhcnRzDQo+ID4gYW55aG93IGFzIGFjcGkg
dGFibGVzLCBldGMuIFNvIEkgZG9u4oCZdCBzZWUgd2h5IHdlIG5lZWQgdG8gZG8gc210aCBzcGVj
aWFsDQo+ID4gYWJvdXQgaXQ/IEluIGFueSBjYXNlIGl0IGlzIGluZGVlZCB2ZXJ5IGRpZmZlcmVu
dCBmcm9tIGRyaXZlciBkaXNjdXNzaW9uIGFuZA0KPiA+IGdvZXMgaW50byAid2hhdCBzaG91bGQg
YmUgY292ZXJlZCBieSBhdHRlc3RhdGlvbiBmb3IgQ0MgZ3Vlc3QiIHRvcGljLg0KPiA+DQo+ID4g
PiBNb3JlIHByZXNzaW5nIGNvbmNlcm4gdGhhbiB3YXN0ZWQgbWVtb3J5LCB3aGljaCBtYXkgYmUg
dW5pbXBvcnRhbnQsDQo+IHRoZXJlJ3MNCj4gPiA+IHRoZSBpc3N1ZSBvZiB3aGF0IGFyZSB0aG9z
ZSBkcml2ZXIgaW5pdCBmdW5jdGlvbnMgZG9pbmcuIEZvciBleGFtcGxlLCBhcw0KPiA+ID4gcGFy
dCBvZiBkZXZpY2Ugc2V0dXAsIE1NSU8gcmVncyBtYXkgYmUgaW52b2x2ZWQsIHdoaWNoIHdlIGNh
bm5vdCB0cnVzdC4gSXQncw0KPiA+ID4gYSBsb3QgbW9yZSBjb2RlIHRvIHdvcnJ5IGFib3V0IGZy
b20gYSBDb0NvIHBlcnNwZWN0aXZlLg0KPiA+DQo+ID4gWWVzLCB3ZSBoYXZlIHNlZW4gc3VjaCBj
YXNlcyBpbiBrZXJuZWwgd2hlcmUgZHJpdmVycyBvciBtb2R1bGVzIHdvdWxkIGFjY2Vzcw0KPiA+
IE1NSU8gb3IgcGNpIGNvbmZpZyBzcGFjZSBhbHJlYWR5IGluIHRoZWlyIF9faW5pdCgpIGZ1bmN0
aW9ucy4NCj4gPiBTb21lIGNvbmNyZXRlIGV4YW1wbGVzIGZyb20gbW9kdWxlcyBhbmQgZHJpdmVy
cyAodGhlcmUgYXJlIG1vcmUpOg0KPiA+DQo+ID4gIGludGVsX2lvbW11X2luaXQoKSAtPiBpbml0
X2RtYXJzKCkgLT4gY2hlY2tfdHlsZXJzYnVyZ19pc29jaCgpDQo+IA0KPiBBbiBpb21tdSBkcml2
ZXIuICBTbyBtYXliZSB5b3Ugd2FudCB0byB1c2UgdmlydGlvIGlvbW11IHRoZW4/DQo+IA0KPiA+
IHNreF9pbml0KCkgLT4gZ2V0X2FsbF9tdW5pdHMoKQ0KPiA+IHNreF9pbml0KCkgLT4gc2t4X3Jl
Z2lzdGVyX21jaSgpIC0+IHNreF9nZXRfZGltbV9jb25maWcoKQ0KPiANCj4gQSBtZW1vcnkgY29u
dHJvbGxlciBkcml2ZXIsIHJpZ2h0PyBBbmQgeW91IG5lZWQgaXQgaW4gYSBWTT8gd2h5Pw0KPiAN
Cj4gPiBpbnRlbF9ybmdfbW9kX2luaXQoKSAtPiBpbnRlbF9pbml0X2h3X3N0cnVjdCgpDQo+IA0K
PiBBbmQgdmlydGlvIGlvbW11Pw0KPiANCj4gPiBpMTBubV9leGl0KCktPmVuYWJsZV9yZXRyeV9y
ZF9lcnJfbG9nIC0+X19lbmFibGVfcmV0cnlfcmRfZXJyX2xvZygpDQo+IA0KPiBBbm90aGVyIG1l
bW9yeSBjb250cm9sbGVyIGRyaXZlcj8gQ2FuIHdlIGRlY2lkZSBvbiBhIHNpbmdsZSBvbmU/DQoN
CldlIGRvbuKAmXQgbmVlZCBhbnkgb2YgdGhlIGFib3ZlIGluIENDIGd1ZXN0LiBUaGUgcG9pbnQg
d2FzIHRvIGluZGljYXRlIHRoYXQNCndlIGtub3cgdGhhdCB0aGUgY3VycmVudCBkZXZpY2UgZmls
dGVyIGRlc2lnbiB3ZSBoYXZlLCB3ZSB3aWxsIG5vdCBuZWNlc3NhcnkNCnByZXZlbnQgdGhlIF9f
aW5pdCBmdW5jdGlvbnMgb2YgZHJpdmVycyBydW5uaW5nIGluIENDIGd1ZXN0IGFuZCB3ZSBoYXZl
IHNlZW4NCmluIExpbnV4IGNvZGViYXNlIHRoZSBjb2RlIHBhdGhzIHRoYXQgbWF5IHBvdGVudGlh
bGx5IGV4ZWN1dGUgYW5kIGNvbnN1bWUNCm1hbGljaW91cyBob3N0IGlucHV0IGFscmVhZHkgaW4g
X19pbml0IGZ1bmN0aW9ucyAobW9zdCBvZiBkcml2ZXJzIGx1Y2tpbHkNCmRvIGl0IGluIHByb2Jl
KS4gSG93ZXZlciwgdGhlIGFyZ3VtZW50IGJlbG93IEkgZ2F2ZSBpcyB3aHkgd2UgdGhpbmsgc3Vj
aA0KX19pbml0IGZ1bmN0aW9ucyBhcmUgbm90IHRoYXQgYmlnIHNlY3VyaXR5IHByb2JsZW0gaW4g
b3VyIGNhc2UuIA0KDQoNCj4gDQo+ID4gSG93ZXZlciwgdGhpcyBpcyBob3cgd2UgYWRkcmVzcyB0
aGlzIGZyb20gc2VjdXJpdHkgcG9pbnQgb2YgdmlldzoNCj4gPg0KPiA+IDEuIEluIG9yZGVyIGZv
ciBhIE1NSU8gcmVhZCB0byBvYnRhaW4gZGF0YSBmcm9tIGEgdW50cnVzdGVkIGhvc3QsIHRoZSBt
ZW1vcnkNCj4gPiByYW5nZSBtdXN0IGJlIHNoYXJlZCB3aXRoIHRoZSBob3N0IHRvIGJlZ2luIHdp
dGguIFdlIGVuZm9yY2UgdGhhdA0KPiA+IGFsbCBNTUlPIG1hcHBpbmdzIGFyZSBwcml2YXRlIGJ5
IGRlZmF1bHQgdG8gdGhlIENDIGd1ZXN0IHVubGVzcyBpdCBpcw0KPiA+IGV4cGxpY2l0bHkgc2hh
cmVkIChhbmQgd2UgZG8gYXV0b21hdGljYWxseSBzaGFyZSBmb3IgdGhlIGF1dGhvcml6ZWQgZGV2
aWNlcw0KPiA+IGFuZCB0aGVpciBkcml2ZXJzIGZyb20gdGhlIGFsbG93IGxpc3QpLiBUaGlzIHJl
bW92ZXMgYSBwcm9ibGVtIG9mIGFuDQo+ID4gInVuZXhwZWN0ZWQgTU1JTyByZWdpb24gaW50ZXJh
Y3Rpb24iDQo+ID4gKG1vZHVsbyBhY3BpIEFNTCBvcGVyYXRpb24gcmVnaW9ucyB0aGF0IHdlIGRv
IGhhdmUgdG8gc2hhcmUgYWxzbw0KPiB1bmZvcnR1bmF0ZWx5LA0KPiA+IGJ1dCBhY3BpIGlzIGEg
d2hvbGUgZGlmZmVyZW50IGRpZmZpY3VsdCBjYXNlIG9uIGl0cyBvd24pLg0KPiANCj4gSG93IGRv
ZXMgaXQgcmVtb3ZlIHRoZSBwcm9ibGVtPyBZb3UgYmFzaWNhbGx5IGdldCB0cmFzaCBmcm9tIGhv
c3QsIG5vPw0KPiBCdXQgaXQgc2VlbXMgdGhhdCB3aGV0aGVyIHNhaWQgdHJhc2ggaXMgZXhwbG9p
dGFibGUgd2lsbCByZWFsbHkgZGVwZW5kDQo+IG9uIGhvdyBpdCdzIHVzZWQsIGUuZy4gaWYgaXQn
cyBhbiA4IGJpdCB2YWx1ZSBob3N0IGNhbiBqdXN0IHNjYW4gYWxsDQo+IG9wdGlvbnMgaW4gYSBj
b3VwbGUgb2YgaHVuZHJlZCBhdHRlbXB0cy4gV2hhdCBkaWQgSSBtaXNzPw0KDQpObywgaXQgd29u
dCB3b3JrIGxpa2UgdGhhdC4gR3Vlc3QgY29kZSB3aWxsIG5ldmVyIGJlIGFibGUgdG8gY29uc3Vt
ZQ0KdGhlIGdhcmJhZ2UgZGF0YSB3cml0dGVuIGludG8gaXRzIHByaXZhdGUgbWVtb3J5IGJ5IGhv
c3Q6IHdlIHdpbGwgZ2V0IGEgbWVtb3J5DQppbnRlZ3JpdHkgdmlvbGF0aW9uIGFuZCBndWVzdCBp
cyBraWxsZWQgZm9yIHNhZmV0eSByZWFzb25zLiBUaGUgY29uZmlkZW50aWFsaXR5DQphbmQgaW50
ZWdyaXR5IG9mIHByaXZhdGUgbWVtb3J5IGlzIGd1YXJhbnRlZWQgYnkgQ0MgdGVjaG5vbG9neSBp
dHNlbGYuIA0KDQo+IA0KPiANCj4gPiAyLiBGb3IgcGNpIGNvbmZpZyBzcGFjZSwgd2UgbGltaXQg
YW55IGludGVyYWN0aW9uIHdpdGggcGNpIGNvbmZpZw0KPiA+IHNwYWNlIG9ubHkgdG8gYXV0aG9y
aXplZCBkZXZpY2VzIGFuZCB0aGVpciBkcml2ZXJzICh0aGF0IGFyZSBpbiB0aGUgYWxsb3cgbGlz
dCkuDQo+ID4gQXMgYSByZXN1bHQgZGV2aWNlIGRyaXZlcnMgb3V0c2lkZSBvZiB0aGUgYWxsb3cg
bGlzdCBhcmUgbm90IGFibGUgdG8gYWNjZXNzIHBjaQ0KPiA+IGNvbmZpZyBzcGFjZSBldmVuIGlu
IHRoZWlyIF9faW5pdCByb3V0aW5lcy4gSXQgaXMgZG9uZSBieSBzZXR0aW5nIHRoZQ0KPiA+IHRv
X3BjaV9kZXYoZGV2KS0+ZXJyb3Jfc3RhdGUgPSBwY2lfY2hhbm5lbF9pb19wZXJtX2ZhaWx1cmUg
Zm9yIG5vbi0NCj4gYXV0aG9yaXplZA0KPiA+IGRldmljZXMuDQo+IA0KPiBUaGlzIHNlZW1zIHRv
IGJlIGFzc3VtaW5nIGRyaXZlcnMgY2hlY2sgcmV0dXJuIGNvZGUgZnJvbSBwY2kgY29uZmlnDQo+
IHNwYWNlIGFjY2Vzc2VzLCByaWdodD8gIEkgZG91YnQgYWxsIGRyaXZlcnMgZG8gdGhvdWdoLiBF
dmVuIGlmIHRoZXkgZG8NCj4gdGhhdCdzIHVubGlrZWx5IHRvIGJlIGEgd2VsbCB0ZXN0ZWQgcGF0
aCwgcmlnaHQ/DQoNClRoaXMgaXMgYSBnb29kIHRoaW5nIHRvIGRvdWJsZSBjaGVjaywgdGhhbmsg
eW91IGZvciBwb2ludGluZyB0aGlzIG91dCENCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQo=
