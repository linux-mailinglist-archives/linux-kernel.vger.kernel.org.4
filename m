Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBC25FE805
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 06:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJNEhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 00:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJNEhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 00:37:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA218D457
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 21:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665722257; x=1697258257;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m1kZTvCqEVfZ4sbGtmpppc3P4VD2rBjTYysZ2AqJuGU=;
  b=cvPimhHCsNzhgRL8NziLrEtZ4sMNTM7jpnxxZ1trS0neTynp5GMmT0jq
   lxh0QRPFISpzvoAX1P6qL9EdkuUKfglP1+NFz+XLJv1/ahn8DuASbpUkT
   iKMZZwcFnvfLaWuCid1Sdc838ELImXhWJrZy+bVW6/gSiU7OBM/hiumIg
   WqriDp7N4ql89Maf1jAvilMcQY5QNcTsebpZQGukbRxpGl8XBY7AbCU4k
   3+4FrJvonR+GHMtj3fYVtkXONAsQPurY3UEDxMPDPoCHAYDyFZ8Sl+D8o
   9pVqxuDsYAWoq5ZuFVxzuWYPW1RPPBc4L9wnMj8y7moaBwuv3aLKVT1bp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="306934431"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="306934431"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 21:36:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="769894072"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="769894072"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 13 Oct 2022 21:36:47 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 21:36:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 21:36:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 21:36:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 21:36:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPBRgf28jtRYpWD3kbf+Yms48Ag5dhSUiIy72UN2yDyDwGB7Xkl90BVnPfHtoPm2VQkaQE0yyaLowcSe+F0GM01hiENFZoHEg9TOxk9z1iueuPpW216cGm450Zn2apPbiYyJQ2qqNp/qIsqGL1JnTCHJouUx04JVpZAwTOptSwya3wjtYnKfI6FUs5TEYCbPQmksbzp4YJGTGYnoa6URABFRgLUhW4MxaPraS6iBXvqaU4gn5HoraWH7m7LXnPVVJurmgrOAUzqAMKwUiqCYbYTAstP4GtJdrnKlGDjzhul3CeF95igKZTg5gX5O1/2XSl7+B0T2S9Nvl+VLsG4a1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1kZTvCqEVfZ4sbGtmpppc3P4VD2rBjTYysZ2AqJuGU=;
 b=Y5i7R8/J5uzz8IY5mwJmeDZhMjU3UGrTskPYyNjZO75OY5ghyeAvMW2Bo8dTVLx215rn83xBx1Wg6DhtB7mtRJ44Rp51ujUp+0mcUHWy5S809882tk0jrAtkDXKtBwhHwNUi1dbR7iDDSh8MQOWWos24GNSmPeTgGoeT0Dj7XjQj4TJTDB331T/fiwUfjaFGACYRkgHBMEwFKL68JgkHthBbjuIbr16RuaEQ9hrTNaCdNc+mdb7XmBp6b97BQN2FAHxtywvoovXNkXBghNzRbveHbOPxl6xPQnZwy/CJ7XK0sYbr9h2+hcQ9qsogIJsrAdbGCptEHlKEo4Q6STcWZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM5PR1101MB2172.namprd11.prod.outlook.com (2603:10b6:4:50::12)
 by PH7PR11MB7051.namprd11.prod.outlook.com (2603:10b6:510:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 04:36:22 +0000
Received: from DM5PR1101MB2172.namprd11.prod.outlook.com
 ([fe80::7c71:1b0e:5f0e:43fe]) by DM5PR1101MB2172.namprd11.prod.outlook.com
 ([fe80::7c71:1b0e:5f0e:43fe%4]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 04:36:22 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: RE: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Topic: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Index: AQHY2Z1YsyE3enznIkOfLcepaehVE64DBB+AgAA15gCAABeEgIAACuQAgAAFu4CAAAKlgIAJ5vxQ
Date:   Fri, 14 Oct 2022 04:36:21 +0000
Message-ID: <DM5PR1101MB2172AB54C9EAA20FF530F2A1A8249@DM5PR1101MB2172.namprd11.prod.outlook.com>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-7-xin3.li@intel.com>
 <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net>
 <BN6PR1101MB21611798953AADA4DFD71719A85F9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <Y0B83cSSwJnRtGAn@hirez.programming.kicks-ass.net>
 <80AC2E90-D842-4EA2-A413-3CC5CFF088BC@zytor.com>
 <Y0CKz/wjvYYYgH3P@hirez.programming.kicks-ass.net>
 <b2943f49-41ba-59c9-2592-d1a91a151138@zytor.com>
In-Reply-To: <b2943f49-41ba-59c9-2592-d1a91a151138@zytor.com>
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
x-ms-traffictypediagnostic: DM5PR1101MB2172:EE_|PH7PR11MB7051:EE_
x-ms-office365-filtering-correlation-id: f1cc4c25-d4c9-410c-8e6d-08daad9da538
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6W7+2MQXlu76NEra40JFzsOZYdRNV2r20/AD/bjA/sdpUFae3x1VSZGrQbfpQvjBJIzMQMfIiHa9k6F8QOCGr+oDH0HSUjqY+Gqhj2XFsu70h+PXz5xqg2v72FMyL+07I69jM9NsgrnfFLCYS5MsUEl9gvkx3UYh5oWhAMH6TyQwjzppLLn/fKhwMGsQLUnP8un8XPGw9et2KYzf4bFqNLGhmrESt9LyPy2z1NCLGz7+Hibd0Ku7DPN5RZxnuPVUL6jtdyrQWtBrJqgKN9IZx6DicxbYWYGTB6A1N7D0/TIaFQSC1GXyCzoXgdI2P6usVoxlDSn8//hXxwBFkjMcSPWDDLOFuxMKHtU4AzH138LN/YVtyACwsu+hAHR5ujHFA/w+5HEEMcILDS0dkt7YMmRWhtTzP2BsX+zBrEEYV8WlrxjqQJM/WTaV2cwENWcE1W8bS72PgU5D54QBCY4ST2kTcPw2C75hXCrfkenXainwskfBLc45XzsQ1TORuQa/gEHDT86k7uBmsaY+sqyOtY9x6RoF0eOdjyDCb/A5UPCEMoSBF4X7F2QMlCM3fAG/+ItQYd7hk40pVUddKuUtr3PR1kvHA9zLbunnRjc11vdkQpYLwxDMlkMyJTWWQ4b2hVGeRWavjGftsbPl+MoXN7cWjAnArmbqFZFHcSlUvnplOxHGSjGMcigc9rQRxL6XDO3QR8LH+BDRoYRf8tqVjmhPEU78aRh2X0OF7HtaplbbHFx9RxxTZOLeE8lel7mLxKd4o2coPD7J6S/rzcwyxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1101MB2172.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199015)(82960400001)(38070700005)(55016003)(33656002)(86362001)(26005)(7696005)(4326008)(64756008)(8676002)(66446008)(66476007)(6506007)(41300700001)(52536014)(4744005)(66946007)(9686003)(66556008)(5660300002)(71200400001)(110136005)(478600001)(76116006)(316002)(54906003)(38100700002)(122000001)(8936002)(186003)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2ZDNWNOWUExOU5mem9hRDR2K2l6cnNjLzEwUlhlU1VXYTBrdk85dU5UU3R5?=
 =?utf-8?B?MjU4MjZ6NktPRXJtSFl5bmZUQUZRb0YzQ0xPSmwrU3hOWndYanNMUXBkWmtP?=
 =?utf-8?B?aE1HQkNmR1YwcVFsTFVqb0hLVEw5TFNodC9KNlFrKzRxVXBtdmczVEtrMjM0?=
 =?utf-8?B?dFpvVWR0U2VSWnJXTFNVZmkyRGsrN0YzaDg2azBVVnMvRGwvRDh1WlI0U2NE?=
 =?utf-8?B?MG93SXFTd1F5VmFWcnF4T1Q5dG9UczczcEU2Qk5JOEhlakhybFVoWUFyYmFw?=
 =?utf-8?B?WHBpZU4vQ2lTK1lQeUsvR0xiMi9sNmgrSTJWSm9FVVZ1REwwUHlxTXZCZGtS?=
 =?utf-8?B?ZkhDemFvalpOdTR1NStZcG9wMUhyY3dCK0JHeDFXZEg1Z1VNL2lGUmZKVEhh?=
 =?utf-8?B?OXB1VzNHemdkWTFHTGpSeGhxMEFMd1BpWjhDNUJKWm1lUzFpME9uSC9NUVEw?=
 =?utf-8?B?QWRvK0EzVC9wR2pMVit6bXNGdThCWjZCQkRSeXpnQStxN1Mrb0g0Z3c1L3pW?=
 =?utf-8?B?RGY0MSt0NHRDb3c4c1VDaHRMdlZqYUxMMkVKOUxiOHhFaTZSNTh1engrTlk1?=
 =?utf-8?B?dWZQajM3Ri8vN20zc0hJYlNiMWhIYkh1cm9yOXZuS0tOM2wvelRHSlRzN3Fw?=
 =?utf-8?B?Sk5ESExwaFVMdzl2MmlGUSsxTlczOStZQm4rZTdQSC93REtmc3hEVTRGZTBX?=
 =?utf-8?B?dEJOMXlhZGZrbE1laEp4djZzanpLQXNsWENnSFZVMTZ5bTVsbzdaZW5yQ2VI?=
 =?utf-8?B?TmcyK2NxeUYvenR3RTZwanF4UFNTbStubGpUQk9qRlFlbXF0bDJaaGJKRW1o?=
 =?utf-8?B?ZW5Fakh4SWF2akcvM3JXeENVSUVnampoQXVYNDVLU2dUVmkzY3dLY1JOSE5x?=
 =?utf-8?B?TmZENkc3SWY1ZUYvRllMYmxOVHFBNVhBRGFZbnRtTjJuUnJvL3JIeXZLWVc0?=
 =?utf-8?B?dVJHdG9TajNaRVd2VGZpb0pOODY1VkNZUlBVTTdPbzhnNG1BTmlxczgxOTFp?=
 =?utf-8?B?MkJWTkZuYm5tZ1Btdm5RZTZDdGx2WnJDRkZJcjc3T3ltb21KODAwSTVWTFlE?=
 =?utf-8?B?c20yMFlIZmViQVNsR3RRcW9OUnBwVVA5ZThtU2NQQWI5dkw0RUlXdU4vcVR2?=
 =?utf-8?B?MXJ2b1Noc0tJeE0yQ0V4bmk4Wld5blNCMUswU3JhakFMMGtaU1E2N25LMjlC?=
 =?utf-8?B?NTc4VkNTYW1xYnZDYXh4MnVFN2svQ25YN25KWmFadVBpOGF0MlZDZExvMUV0?=
 =?utf-8?B?OTduT3BmWWhlMjduczlCUHdZQ2hFczNLNmxHZld1UWllVnBxRDdWU1gvOVhO?=
 =?utf-8?B?VDVEcTRxdFV0eDhFZ25VaTZaWE9pMk9tTStoWDNUdU52VFNWTEFaZVVYZEdo?=
 =?utf-8?B?WUlPMFh0T2dQK0xvUlRiQmtlc2F4VllDOEpSRk9vRWlZMENkbzZrMjlZdTk3?=
 =?utf-8?B?bnZyNEhkVEdPNFhuUzVlZmFZWXVmeXQzOVpYR3ZaUjF6SzVuS1FZSWdqai9r?=
 =?utf-8?B?T2pCTUE0eHFVbDRoc2IySm9DNDNQVXVXaTcrejRkczlNUitPM0hxcmR0clZI?=
 =?utf-8?B?RnFNMWtZS013ZnkrNmk4K3N1cTBHczVFWDZqWnVQSVV4UnFlVXAzTHluSU43?=
 =?utf-8?B?OEZBSktuc1daNzBIMGszVnUvKzBTcGJvelM3OVpwUHhnSmVGMzVVSFZQQ3Rs?=
 =?utf-8?B?OUovRGErY2YxQ0NpQk5qdlljRE8yRVpZUFIzc0g2WWJGcjFBa2JEamorc01j?=
 =?utf-8?B?Ym5mK09mQ1FxMSsvRktYQXRvYU5BSzVzMG5WcitHSGlqWDJtY3NlMUYzTFdT?=
 =?utf-8?B?QTd3Wk1OTTVneGN6M0c2T09wOFE1UUpFaDRPNTZhU0xZMlZETlBLb3NMdTFi?=
 =?utf-8?B?YktMZDM4enl1NUJXamNpZzZWQUV3L2NRbjFvUnJtak0wK2k3VnZtN201UXBw?=
 =?utf-8?B?T0hXYnQybG9ZNkZMTUdPeTgxdmhRb3dKZzlFTDdMd3B1ek80RFlaRlF1QXlh?=
 =?utf-8?B?Ukt3azVSTy9oekRsTFdmYmFaa1VZcEJZTnk3c2thd2EzQm9nc2F3QkRaaU02?=
 =?utf-8?B?RmF1YmJWVzhYbXA1cXhQWTVneCtaOVlJODE1V0U3QlpNVzEyV2NZclFEeTJM?=
 =?utf-8?Q?4tkM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1101MB2172.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cc4c25-d4c9-410c-8e6d-08daad9da538
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 04:36:21.8989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7CiSVXoxgXhmrhZbjRulteh4L7mzPlA+yt0j2VCC0+myVXyTZLlrOn5qQZDWPV3icx3HtL9MoaB/yi7pqT4Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7051
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEFuZHJldyBDb29wZXIgc3VnZ2VzdGVkIHVwZ3JhZGluZyB0aGUgb3JwaGFuIHNlY3Rpb24g
d2FybmluZyB0byBhIGhhcmQNCj4gPiBsaW5rIGVycm9yLCBvcnBoYW4gc2VjdGlvbnMgYXJlIGJh
ZCByZWdhcmRsZXNzLg0KPiA+DQo+IA0KPiBBZ3JlZWQgMTAwMCUuIFRoaXMgaXMgYSBuby1icmFp
bmVyLiBGcm9tIElSQzoNCj4gDQo+IA0KPiA8YW5keWhocD4gLUxERkxBR1Nfdm1saW51eCArPSAt
LW9ycGhhbi1oYW5kbGluZz13YXJuDQo+IDxhbmR5aGhwPiArTERGTEFHU192bWxpbnV4ICs9IC0t
b3JwaGFuLWhhbmRsaW5nPWVycm9yDQoNClRoZXJlIGlzIGFuIGFyY2ggaW5kZXBlbmRlbnQgY29u
ZmlnIENPTkZJR19MRF9PUlBIQU5fV0FSTiwgd2hpY2ggZm9yY2VzIGxpbmtlcg0KdG8gd2FybiBv
biBpbXBsaWNpdCBuYW1lZCBzZWN0aW9ucywgb3IgdGhlcmUgaXMgZXZlbiBubyB3YXJuaW5nLg0K
DQpDT05GSUdfTERfT1JQSEFOX1dBUk4gZGVwZW5kcyBvbiBBUkNIX1dBTlRfTERfT1JQSEFOX1dB
Uk4sIGFuZCBzb21lIGFyY2hzDQooYXJtL2FybTY0L21pcHMveDg2Ly4uLikgaGF2ZSBpdCBkZWZp
bmVkLCBhbmQgdGhlbiBsZCBnZW5lcmF0ZXMgd2FybmluZ3Mgb24NCm9ycGhhbiBzZWN0aW9ucy4N
Cg0KU2hvdWxkIHdlIHByb21vdGUgd2FybmluZyB0byBlcnJvciBvbmx5IG9uIHg4Nj8NCg0KPiAN
Cj4gCS1ocGENCg==
