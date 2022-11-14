Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8EE628D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbiKNXP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiKNXP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:15:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7315165BF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668467754; x=1700003754;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=VN1ADM5Ug5o+uVpE4jcbHr2M2s2LXHNtyTYbBq3CxZY=;
  b=g9Rk00n9wFmcAzdBbyGInwjAg3Dan/9u2sdW3nUGrAHExwQIqYyj0e3Y
   MZsiddAuS9XtcdfuwJ6toqoNyvTM9csb9hWE8+Mp5lEOX9XgBZ0bsgFpJ
   GgAPEzA3C8vg05UnQFsiTfa57cZ7NM84jpM+u+//0vJWrb0yOvjZSzgJH
   dgVMN7LTi90jz9Ca7/i2AXYQxFkbs6eynr0NxMyLLvpGbM2bUnhhGz5SP
   ILutJq8ak9r+/VtKJG8R+OZO0dZl4XHBw5O5DB+XluYrTRq6eS0NNcYBb
   gbni0vVngtWoDkkkVGnufa2ElJ5ZBP4TX5HPsXUPVRyTQQHM4Jqjo1LSz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313914504"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313914504"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 15:15:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="669856273"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="669856273"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 14 Nov 2022 15:15:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 15:15:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 15:15:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 15:15:50 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 15:15:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odLzHjSNe1UEzWwmNc3Dk3zsCIHLsMrMu4yKLGu4TRxuIy3nUsyX8OmqWsx1vYJS1FYJrWj+o6GrdUHWMvj3rbnDBskn97rbTaR32JSRK9YEWdAe++jWnnOqG2A8MU0udcPM+t1VoX9MtVJeRqPxdCb+zpX1x9nHfhkNfoitspR74UKj5c+yEJwiCfZ+HDEcNF3VmuGBQl/TJ+OtW8/MRw21XdTlEe+Ol9ODuM6OgdEQAKKUigpsfDQrhmnq9RepOoP28hD9qkvz6mwof1GUcw0KAU28rjlYQTvVlzGJkvB1YBuvWRjUI/gfKA1f3rnPDBA8thm5E0rRzQyE9mtO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN1ADM5Ug5o+uVpE4jcbHr2M2s2LXHNtyTYbBq3CxZY=;
 b=XfnrtW8kaqHxl5OH/ECtw3sUHa77AqTiq+3QsFzQQo69TXFI5sZNTbTZRUnlXDyp99ABb/uIvNjDJ0DW+rd+q+9RDlTast6gerGGavWDXB9SekG1qk9B1x6vAug63njNQG0U0fhL4WgC7+foMTBvg+zVyM4H3DveLH1WJbd/1KqG/NH4zehuwyTeIwfgh1lf7tewv361X4muIF7AzMfYsOVIb6WubbGWWReStG01YEACd67fwHdHognPUVGX0/BKbkXfop0tWytetIUx27taN9lsLxmauKm4NeEPB+qj8K5EuE7CPDys4/ibUEGbmq4UMVNz6jZcxaOn2fOayS8DwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW4PR11MB7055.namprd11.prod.outlook.com (2603:10b6:303:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 23:15:45 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 23:15:45 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: CET shadow stack app compatibility
Thread-Topic: CET shadow stack app compatibility
Thread-Index: AQHY+H8FF0IkDR4atkCzeBv5Re4FSw==
Date:   Mon, 14 Nov 2022 23:15:44 +0000
Message-ID: <7d8133c7e0186bdaeb3893c1c808148dc0d11945.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW4PR11MB7055:EE_
x-ms-office365-filtering-correlation-id: b3dc0e29-5ca8-45d2-2c3e-08dac696284e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q26uaecidUmOATD/zd/049XMSh+t004YRxh4cRga/++DCPq4U0+XqjtIDPGNPgjQqSHeAw+FnQbhZO9jcq2TJ8ZD6Lih3BxOA545BbxMIIMNBpvx6vBCif8vHWwjIqHeIEg+M3yXfpzySvAHPqojhn1HtBbW7CeM9nPx1e/l2iQnEZssTMTJPp7FAB5QJc7osT8xdI2NSA45HZDVFeHEbOpyX/8+nBjxAbWHvjNmyibMIEMdF7BGpJdGBt0Gh6ESLiiGuV1B5X3mmq0npSLuDHto9TfxUojZhC1AICgXMFKnm0AK4f/sxd9/E/FcG0Cw7NJ1rxqK29ErpaoLrKXtCngYJCCs9zCWUjNUq1rqrcLGaPs0q8+eC2aFt09pBQ5PFjNMSTQZLEoXTorQ50ZHx1zPpGrvCykwefGogNOufecYXp53OhWCr4fYQzs1j6HcgwPOYmLcfMrz4n4/qrR2jX0tcYU5PULQczSSp+I3p1Sxt4HHGjDsscQWcxprI//0AElYQKpMs0Yc5/AfGtqZLLDrX+qtk/V1NrFcMb5pqT8Ya/HTbgi41oj/5ZGmqpPy1LtT78C7xzXCmc4Om3K+Q5TnEMyZDoLzwwhpmL+W2PIctZf5w19+ZADaNJnJWM6wff7dUxMrjV9bg4Yum12seeikE7PQ19cyUGo2kzEcSyKE5fgR+iNljKq17NJuoT4amwxxI0D00RydDY4HYu4d3WWZ8ozkGQq4f6Ouq5latV3/D8Wd6wZ5863Spu2Hf6Z6wCd49MjxMP05dVFwr5027Oyzp8GhuHMOKpvsREN1ehBVfBGsJCHeGgiTaZ/cjjIkwIgLqatGlXpsyv6cmZ2RXztJITm9cIxL4v56ehYKJmE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199015)(478600001)(38070700005)(54906003)(6512007)(316002)(2906002)(4326008)(86362001)(66556008)(966005)(6486002)(64756008)(91956017)(66476007)(8676002)(6916009)(66446008)(76116006)(66946007)(6506007)(122000001)(38100700002)(41300700001)(26005)(8936002)(82960400001)(36756003)(5660300002)(2616005)(83380400001)(71200400001)(186003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTdoRW1URkhJWnVjaktUN1hoOXZXQ1pVN0l6cVRpMDI4WlNvYUxZRTNOVGs4?=
 =?utf-8?B?SXJxUXBLeFduNjZGYnpGWnFDZng4QzFrYTFEUUhSNHQzYTZPaVk3dExKU29K?=
 =?utf-8?B?U1J4dDBHRUFEa1c0THF6ekgzWUtyQ1lBeEQ4bjY1KzNueCtibEJlRkt4RkE0?=
 =?utf-8?B?cjZ0VjBKSjZoTFZ1dU8vRFBYTkkrOEIrMGlKZDZhS1JLYndScTl2TUJ4bVNp?=
 =?utf-8?B?bjRFcmRtNnB4eE1vTElNZlBlcFg0dk94Q1RTYzdnTXBUV2NCL3dndUdFb3Uw?=
 =?utf-8?B?YmIwQ1QrY294SEdGTDg1cmR2eVlQbUlpeHdsSVgyZENlSjJheGNHa0RQalJK?=
 =?utf-8?B?YWd3cXllNkh1c291eHQ5Q1RCN2szVUkvNmtNaExYY3B2Nkd4amlqUllkY3Rt?=
 =?utf-8?B?Y3hNVU5GdVVvM2M1NU44SEpaMUxBbTdORnk4d3laSy9kQmd3dm8xMVZzS3Y0?=
 =?utf-8?B?OEJZR0srWE10bWM1RE9VRWtwQ2w4U09CTmtmY0VoakFjZE85QUdLbWZUQnFm?=
 =?utf-8?B?MW85VWpKY0syWWN5MmZkeENtcTVWeUdHdm5PVVZMQUdSVWovNTNnc2UvSnI5?=
 =?utf-8?B?RENrL1dtOHltNGJsaFJuTU5DdkJjSld3dDVtS2RKVm5qSUVXemRZWEdsUWtV?=
 =?utf-8?B?T0VYNDRYWFlXc21lOEM3dElqZUxzdU9WMGpOdGN3UHFqN2RuTlEzaUhyeVlq?=
 =?utf-8?B?QlNaN3laRnZ5ay9QNWNRNWlqemh2bVlvZERNcTVLb3JvM0hlVWVRdTRNRjVx?=
 =?utf-8?B?dnM4dmRFeHM5cENuRnhQWEhZeVlBd2FwUDVQZ25NK3Vub0VXZDBRSmJYMzY5?=
 =?utf-8?B?RlpSaHVYRUFMNHlSQU56VVpRemlKdGQ0Z2swZUhlV3JYMlVTN0RQc0RVbTFS?=
 =?utf-8?B?cWRCdm9tWXUzLzRoakJPSHhsTlhBbTRWOVdwMGU0Z1BQeWtJQmFzYmVZTjJ4?=
 =?utf-8?B?elRuRktEaWI1eDVSb2VZdlorNlRmTjF6T2Jra3QxWWNIb1EyaUtYMDNPNUhP?=
 =?utf-8?B?NmtncnJkUkprbmtLemxoWTg2S0RQSHVGWXIwUCthUVBpYXdSYjkrK013LzJu?=
 =?utf-8?B?ekRuRDcwNW52Z1M0WWlmcFM1cm02anpBUTkxV0Nwd0pkT3RiMGtNbFpnbFZ6?=
 =?utf-8?B?c1FteWlBb0YxYVpFSFAwcS9reGtoUXBuek1tWmN5c0x1SVBIcFJRTTJtMktU?=
 =?utf-8?B?MGlnb3VhQ2xzdHliR0g2azZHMGdEc1ZFMmNxTG81L3NiVVc5VjBrWFR4SXc2?=
 =?utf-8?B?UlNqbG4wOEpNa2txMUNGSnMrZEhjaTBqK1pFVTAwdUZTd2pWVzRETDlYV1A1?=
 =?utf-8?B?RFBGQWZqSnE1RklkT2ZMcmQ2bGVYMEdENUVweFF0QTluUk5uNjFnVWVGRGJU?=
 =?utf-8?B?enlJeEN6cVNxZENJRG5IQ1g0SW81VVk3anhhRERDUHBZdkF4dEZyb21ocjhL?=
 =?utf-8?B?M242c000OFdzOEh4c0JNWEJrRXk5Z0J5Nm44OFBRUWlTVkhwRDc0RFpGZE9Z?=
 =?utf-8?B?dUVFVkJsRTdoN1ZBL3dZNFd2aVN6R05haTlmdXRwQTRNU09jQzVuM2RaZGNH?=
 =?utf-8?B?c0tCUDZCSUtsRm9GalQ2S3ZLYVNqcE82bjJsa3VNSU1NQ3lqRUU3WW5KR0FY?=
 =?utf-8?B?U2laenBqRHY5QmwrNW1NOEJjOTFPeVdMUlZEOThGaWh6ait1VkpBREg1OVJG?=
 =?utf-8?B?ejhVY25DbnpWa3ZCY0ZxS0NIbjYrMkRxQlVVRTh6UmRiSVRHaDZGOTRacCtx?=
 =?utf-8?B?eUxmNnVzVVJtSGdFNmpDRll3NHdWdlhxSWlNU3JUaUlreWtkMTdZK1AzRzFR?=
 =?utf-8?B?WWRHYUQ2clBvNjdrOEgrY2p5akFVdER2ZmhwNXNDelpXRmhhN0lwVjk1b09I?=
 =?utf-8?B?eGl2dFVxQmVwdjFiek13SXFYRWFLTzFLYlVPTmtvUnF5bzBjN0NWYmJkYWhn?=
 =?utf-8?B?OXJOZ2M4ZHQ3OW9UbXJCZXBhZ3l2clhHQVNkaWdmZm1jWWZTdktScmZ1ZEcv?=
 =?utf-8?B?c0hKVnFXNUs2a1BPeCtFRjFZRCsxNDRpelFmVnVoZ1BkazZFb29QUkw5RVNq?=
 =?utf-8?B?Q29QSlVnSkRaU3JGNmJJWVFqZ0dBTnU0S044MEJ1Q2JnQ1pkaXBucWk0cUZ5?=
 =?utf-8?B?dGV1dGhHbXBoc0ZqRms5ejlYNG81aVZZaURqeERJZS9jemc4UCtzenBaenVB?=
 =?utf-8?Q?m2GXwez+YtHppETJ6IY3nt8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7CC95CE5D0CAF46B73C8C628A0D50E9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dc0e29-5ca8-45d2-2c3e-08dac696284e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 23:15:44.9639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2kHM8Dww7pnKboVu0V2/lePsKwWtrE/GPIVBkjuHsiiBuHHOguyYnvmxqyBJd0JbH4OtA3kevAj310nQWzkzgof8dHOUnie8eKkWUlqive8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7055
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCkNvdWxkIHlvdSB3ZWlnaCBpbiBvbiBzb21lIGJyZXdpbmcgZWNvc3lzdGVt
IGNvbXBhdGliaWxpdHkgaXNzdWVzDQphcm91bmQgeDg2IENFVFswXSBzaGFkb3cgc3RhY2tzPyBU
aGlzIGlzIHRoZSBDUFUgc2VjdXJpdHkgZmVhdHVyZSB0aGF0DQprZWVwcyBhIHNlcGFyYXRlIHBy
b3RlY3RlZCBzdGFjayB0byByZWNvcmQgcmV0dXJuIGFkZHJlc3NlcywgYW5kDQp2ZXJpZmllcyB0
aGVtIG9uIHJldHVybi4gU3VwcG9ydCBmb3IgdGhpcyBmZWF0dXJlIGlzIG5vdCB1cHN0cmVhbSBp
bg0KdGhlIGtlcm5lbCBhbmQgc28gdGhlIGlzc3VlcyBkaXNjdXNzZWQgaGVyZSBhcmUgZnV0dXJl
IHByb2JsZW1zIHRoYXQNCmhhdmUgbm90IGhhcHBlbmVkIHlldC4NCg0KVGhlIGlzc3VlcyBhbGwg
aGF2ZSBhIHJvb3QgY2F1c2Ugb2Ygc3VwcG9ydCBmb3IgQ0VUIGluIHRvb2xzIHNwcmVhZGluZw0K
d2lkZWx5IHdoaWxlIGtlcm5lbCBzdXBwb3J0IHdhcyBzdGlsbCBpbiBkZXZlbG9wbWVudC4gVGhp
cyBoYXMgbGVhZCB0bzoNCjEuIFNvbWUgZXhpc3RpbmcgYmluYXJpZXMgKG5vZGUuanMsIFB5UHks
IENSSVUpIHRoYXQgd2lsbCBicmVhayB3aGVuDQpnbGliYyB1cGRhdGVzIHRvIHVzZSB0aGUga2Vy
bmVsIENFVCBBUElzLg0KMi4gR0NDIEMrKyBleGNlcHRpb24gc3RhY2sgdW53aW5kaW5nIGNvZGUg
ZXhwZWN0aW5nIG9sZCBkZXZlbG9wbWVudA0KdmVyc2lvbnMgb2YgdGhlIGtlcm5lbCBBQkkuDQoN
Ck9uIHRoZSBmaXJzdCBpc3N1ZSwgb25jZSB0aGVyZSBpcyBrZXJuZWwgc3VwcG9ydCwgZ2xpYmMg
cGxhbnMgdG8NCmltbWVkaWF0ZWx5IHVwZGF0ZSBpbiBzdWNoIGEgd2F5IHRoYXQgc29tZSBleGlz
dGluZyBkaXN0cm8gYmluYXJpZXMNCndpbGwgYnJlYWsgYWdhaW5zdCBpdC4gU28gdGhlIHNjZW5h
cmlvIGlzIGV4aXN0aW5nIGRpc3RybyBiaW5hcmllcw0KYmVpbmcgdXNlZCB3aXRoIGZ1dHVyZSB2
ZXJzaW9ucyBvZiBnbGliYy4gVGhlIGtub3duIGV4dGVudCBvZiBicmVha2FnZQ0KaXMgbGltaXRl
ZCB0byBzb21lIHBhY2thZ2VzIG9mIG5vZGUuanMgYW5kIFB5UHksIGFuZCBhbnkgdmVyc2lvbiBv
Zg0KQ1JJVSwgYnV0IGl04oCZcyByZWFzb25hYmxlIHRvIGFzc3VtZSB0aGF0IHRoZXJlIGFyZSB1
bmRldGVjdGVkIGJyZWFrYWdlcw0KYmFzZWQgb24gaG93IGl0IGNhbWUgYWJvdXQuDQoNClRoZSBi
cmVha2FnZSBkZXJpdmVzIGZyb20gaG93IHRoZSBkZWNpc2lvbiBpcyBtYWRlIG9uIHdoZXRoZXIg
dG8gZW5hYmxlDQpzaGFkb3cgc3RhY2sgZW5mb3JjZW1lbnQuIEdsaWJjIHdpbGwgZG8gdGhpcyBi
eSBjaGVja2luZyBhIGJpdCBpbiB0aGUNCmVsZiBoZWFkZXIgb2YgdGhlIGJpbmFyeS4gSXQgdGhl
biB0ZWxscyB0aGUga2VybmVsIHRvIHR1cm4gQ0VUIG9uIHZpYSBhDQpzZXBhcmF0ZSBrZXJuZWwg
QVBJLiBCdXQgaW5zdGVhZCBvZiB0aGlzIGVsZiBiaXQgYmVpbmcgc2VsZWN0ZWQgYnkNCmFwcGxp
Y2F0aW9uIGRldmVsb3BlcnMsIGl0IHdhcyBtb3N0bHkgYXBwbGllZCBpbiB2YXJpb3VzIGF1dG9t
YXRlZCB3YXlzDQoobW9zdGx5IGRlZmF1bHQgb24pIGJ5IGRpc3RybyBidWlsZHMgZm9yIHllYXJz
LiBUaGlzIGh1Z2UgYW1vdW50IG9mDQp1bnRlc3RlZCBlbmFibGVtZW50IGhhcyBub3QgZ2VuZXJh
dGVkIGFueSB2aXNpYmxlIGlzc3VlcyBmb3IgdXNlcnMgeWV0LA0KYmVjYXVzZSB3aXRob3V0IGtl
cm5lbCBzdXBwb3J0IHRoZSBwcmVzZW5jZSBvZiB0aGlzIGJpdCBoYXMgbm90DQpnZW5lcmF0ZWQg
YW55IGFjdHVhbCBDRVQgZW5mb3JjZW1lbnQuDQoNCkluIHNvbWUgd2F5cyBpdCBpcyBhIHZhcmlh
dGlvbiBvZiBwYXN0IGNvbXBhdGliaWxpdHkgcHJvYmxlbXMgYXJvdW5kDQpkaXN0cm9zIG92ZXJy
aWRpbmcgcGFja2FnZSBkZWZhdWx0cyBmb3IgY29tcGlsZXIgaGFyZGVuaW5nLiBCdXQgdGhlDQpk
aWZmZXJlbmNlIGlzIHRoYXQgdGhlIGtlcm5lbCBzdXBwb3J0IGlzIGludm9sdmVkIGluIGRvaW5n
IHRoZQ0KZW5mb3JjZW1lbnQgaW4gdGhpcyBjYXNlLCBsZWFkaW5nIHRvIHRoZSBpc3N1ZXMgZ29p
bmcgdW5kZXRlY3RlZC4NCg0KRm9yIHRoZSBzZWNvbmQgaXNzdWUsIHRoZXJlIGFyZSBhbHNvIHBy
b2JsZW1zIGx1cmtpbmcgaW4gZ2NjLiBUaGUgZ2NjDQpDRVQgc3VwcG9ydCBoYXMgcHJlY2VkZWQg
dGhlIGtlcm5lbCBjaGFuZ2VzIGFuZCB0aGUgdW53aW5kaW5nIGNvZGUNCmFzc3VtZXMgdGhpbmdz
IGFib3V0IHRoZSBrZXJuZWwgc2hhZG93IHN0YWNrIHNpZ25hbCBmcmFtZSBBQkkgdGhhdCBoYXZl
DQpjaGFuZ2VkIG92ZXIgdGhlIGNvdXJzZSBvZiBDRVQga2VybmVsIGRldmVsb3BtZW50LiBJdCBp
cyBjb21wYXRpYmxlIGJ5DQpsdWNrIGZvciBub3csIGJ1dCBvbGQgR0dD4oCZcyB0aGF0IGFwcGx5
IHRoZSBleGlzdGluZyBlbGYgYml0IChnb2luZyBiYWNrDQp0byBnY2MtOCkgY2FuIGdlbmVyYXRl
IGZ1dHVyZSBiaW5hcmllcyB0aGF0IHdvdWxkIGNvbnN0cmFpbiB0aGUgc2hhZG93DQpzdGFjayBz
aWduYWwgZnJhbWUgZnJvbSBleHBhbmRpbmcsIHdoaWNoIHRoZXJlIGFyZSBhbHJlYWR5IHBsYW5z
IHRvIGRvLg0KDQpJIHdvdWxkIGxpa2UgdG8gbWFrZSB0aGlzIGdvIHNtb290aGVyIGFsbCBhcm91
bmQgYnkgaGF2aW5nIHRoZSBrZXJuZWwNCmRldGVjdCB0aGUgZXhpc3RpbmcgZWxmIGJpdCBhbmQg
cmVmdXNlIHRvIGVuYWJsZSBDRVQgZm9yIHRoZXNlDQphcHBsaWNhdGlvbnMsIGxpa2UgdGhpc1sx
XS4gVGhlbiB0aGUgYmluYXJpZXMgZGVyaXZlZCBmcm9tIHRoZSBwcmUtDQprZXJuZWwgc3VwcG9y
dCBlcmEgd291bGQganVzdCBjb250aW51ZSB0byBydW4gbm9ybWFsbHkgd2l0aG91dCBDRVQNCmVu
Zm9yY2VtZW50LiBUaGUgaW50ZW50aW9uIHdvdWxkIGJlIHRvIGZvcmNlIHRvb2xzIHRvIHBpY2sg
YSBuZXcgZWxmDQpiaXQgdG8gZGVub3RlIGNvbXBhdGliaWxpdHkgZm9yIHRoaXMgZmVhdHVyZS4g
V2l0aCBhIHRvb2xzIHJlc2V0LCB0aGlzDQp0aW1lIHRoZSB1cHN0cmVhbSBrZXJuZWwgd291bGQg
aGF2ZSBzaGFkb3cgc3RhY2sgc3VwcG9ydCBhaGVhZCBvZiB0b29scw0KYW5kIHNvIGFueSBpc3N1
ZXMgd291bGQgbGlrZWx5IHNob3cgdXAgZWFybGllci4NCg0KVGhlIGJlc3QgcGxhY2UgdG8gZXhj
bHVkZSB0aGUgb2xkIGJpbmFyaWVzIGZyb20gc2hhZG93IHN0YWNrIHN1cHBvcnQNCndvdWxkIGJl
IGluIHRoZSBnbGliYyBsb2FkZXIsIGJ1dCBkZXZlbG9wZXJzIG9mIHRoYXQgKG9uIENDKSBhcmUN
CmFnYWluc3QgY3JlYXRpbmcgbmV3IENFVCBlbGYgYml0cy4gU28gdGhlIGtlcm5lbCB3b3VsZCBi
ZSB0YWtpbmcgYQ0Kc3RhbmQgaGVyZSBhbmQgd291bGQgZXNzZW50aWFsbHkgYnVybiB0aGlzIGJp
dCBmcm9tIHRoZSBrZXJuZWwgc2lkZS4NCg0KQXJlIHlvdSBnZW5lcmFsbHkgb2sgd2l0aCB0aGUg
a2VybmVsIHJlYWNoaW5nIG91dCBhbmQgZ2V0dGluZyBpbnZvbHZlZA0KaW4gdGhpcyBzaGFkb3cg
c3RhY2sgZW5hYmxlbWVudCBkZWNpc2lvbiBsaWtlIHRoaXM/DQoNClRoYW5rcywNCg0KUmljaw0K
DQpbMF0gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzg4NTIyMC8NClsxXSANCmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvMjAyMjExMDQyMjM2MDQuMjk2MTUtMzgtcmljay5wLmVkZ2Vjb21i
ZUBpbnRlbC5jb20vDQo=
