Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0965DD48
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjADT4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240305AbjADT4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:56:02 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D5A17881
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672862159; x=1704398159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pKxozd1hfOqkArq0Cz0kX3jgJRiWK2SOPfKppEQwHOI=;
  b=Uxf08zNAFWELYCVqUyo3gx3wQBWJ32HaytrjMC8LQnUOJHFRIneGzHhF
   pkM1bXw6W1kJ06VZ+FIlUhYxaxBNhIgQAXHblHD4H/AJ+vEmqdnzoZ1xl
   fIlnWAUGsOEoGiFhXutGJ8CGYav3rSq09yOFMfZZB1eRhCfOUlIXlyCyL
   49FNJmNQighrp6nvwyNVI1z7lOnANf7ZJyLLT9ecbaLgj7xHyd0sYVJFT
   cWvYShS3N+MpaenvDkBoa+CJ+RGGG7wYwLX/HaULTBntFTHRkmR+H8XqW
   MEzyJR6E6JIf73ZldPgXvUbgK0XyVnts3WHwv163dHB3MN9m7YcBHtxbW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="320737480"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="320737480"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 11:55:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="655296815"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="655296815"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 04 Jan 2023 11:55:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 11:55:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 11:55:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 11:55:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 11:55:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eo31qKaIQc/mwaUtF/1KfpptDfycrpp1mURhlTK9ecJsodAVx1Rspl9WDbaYSWe/32r+mIDjjH+4QFpysLTbDchoC5aRiZpr7JS/AyVKCh2p0jct7MWHoteHyk9UjazWyThImTGqZfOUEV9lKg2mHLPg3ON0xnXMSLI5nhHnW4s9qVpxqyM1DNEKkBUfNDlNw51con6ad8V8/mFwO24SHP9a3ILTb0SspxeBdSIUXfQ3ToHjOEc66MBx43Pm62DTbAeIqgpgG32Jsy0rgZUcGmd0H98UFho+PAoXRTADxk9lEMaV3ovAnnOFUqsyZglWWVM10Mn3WoYiWe62T2WCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKxozd1hfOqkArq0Cz0kX3jgJRiWK2SOPfKppEQwHOI=;
 b=ShdkLRW2ynTrgcKg12AvYf3couuErd4770HtudLUu4HzyO0j5nQg6j3eIQWhhyRm2y/pS9IJXzKG4dqvIDD7iN5x/2cwLguckEIn2ue6bAjg8Fh9zt0jaTNZClIZL0o+o6muwalAwNSW/qfCaNK9Jb6hp16lml71EUfhXt556Fj4c0Faee6cPc+jqeByu4qO47Dp7ZyW/BzI9Wv6ArsYUMHQCkprH5/9U1XUjlhxn3Ofus4dIjP9m7iwuAtO4i5XwgFTcT6kVqXfX8ARp8ZPmoQcV1OIyNNQpQ59PbqHNKe/uZLOmVqu92Z2R7sblYFRq3cUgTrxGQUy+2wuuGHcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 19:55:46 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 19:55:45 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "tarasmadan@google.com" <tarasmadan@google.com>,
        "bharata@amd.com" <bharata@amd.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv13 06/16] x86/mm: Provide arch_prctl() interface for LAM
Thread-Topic: [PATCHv13 06/16] x86/mm: Provide arch_prctl() interface for LAM
Thread-Index: AQHZGaCQyBY3o2xKokKTEArrEmqzu66Ouc4A
Date:   Wed, 4 Jan 2023 19:55:45 +0000
Message-ID: <ed28e8a56b64f1bb3855a5d2a9b40672af9d6a14.camel@intel.com>
References: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
         <20221227030829.12508-7-kirill.shutemov@linux.intel.com>
In-Reply-To: <20221227030829.12508-7-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH0PR11MB5045:EE_
x-ms-office365-filtering-correlation-id: 0166973e-0a1d-4173-a4c3-08daee8dab59
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4liL1v63PetB2zYbaHIOPuB3bdJ4sO4WwearB1w9DC4A+/P/WzrFbGW7pNLH/7j1vbPScQ7nGdwzuRa3yIs9DQpFbPwfReEU5+Vwr8maTKB1K1C2PaoEezojZ5TiNF0l/ln30x6fGneTTrqZFKEwNeygw0w0sKMsLD9joduf/Q2wPCbGes6oR+/H2doirLh12cPmnRuoDmt/8pHUiFkFhnLsdPQNpux1K0Ffvj3DaZymgQvWetRKpwxfQNSZnbLlNOHrky7xduM0cWh7adSknlkVCqBFQbKeFcbM8zL2XQP9aj85qkIssz6wdQNnkZGJRq59RI8+0a1sWssEXDBkXl74BRgj5+6wnRVHZ3XGya43SYiKWH3bwxouWmVs2TAlCTJMdxvN97HIkLPeSy+hTh2sGM4EgDM0zRTntgwPqTWipCbCpp7NsW/k28X8mz2l+K0tgdJMr//OEsfc6IhKaB/C16hsWSW+3SoraYgixTgs/f0ZB/O1th8fP1WVpEPwPMO0GNqVu8hgUtzqbXA3ao53blEqvDD4LLJ0xPWwGYSy76QdFagPeO4M+6g+dtuu7pCD88w8uHKWNe9zuj/j7MaxshhRosdKmsQ5QCnLHuYAHIGqsjnr3U4yfQIdED13Pgs2BK+OGrX79EBy6+iy4+XIGpyw3okZQbmduqhC7rI+NkuUs8uk9mgw81PhvGs4/M8dFMfTRWUJpI17jw2R/VGSIqRZlwQi1zxGXu/ihY0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(478600001)(6506007)(110136005)(36756003)(86362001)(82960400001)(122000001)(38070700005)(38100700002)(6512007)(83380400001)(186003)(26005)(2616005)(6486002)(71200400001)(66946007)(7416002)(8676002)(5660300002)(76116006)(64756008)(91956017)(66476007)(8936002)(66556008)(4326008)(66446008)(316002)(4001150100001)(54906003)(2906002)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vi8wTnlXbEUyaHFWT3ZWZ2h4ZGJmN3FKODMxSVNPeFZsTnNnNGIrek1wcEpH?=
 =?utf-8?B?TFFjRStpcS9jc1dsR21VdkVVcTlxMHZ5R1JsNlRuRzhKVW1ObWJWUDM0eHJy?=
 =?utf-8?B?QkZ1RzE1Z3Y3RVdVbjZka25lR3NvbFh4QVlsRWlEenFQa1B6YWlzemVwamps?=
 =?utf-8?B?aFduT2VlVnRab0o0eERsVzZ2VWV4TndEdFZSdmhrVXpxSVU4c2MyUFFONzlT?=
 =?utf-8?B?aVdIdnNURDVEaFV4ZU1LV25IVUVkKzdWRkNnT3J2V2NNQlBidllNZGZwNGs0?=
 =?utf-8?B?cnJBdk5tdHFPZkt0QUN2U2xYcEVoSStra0hkOUZNVEJXTGxiN3FvS2NOUFBw?=
 =?utf-8?B?ZVo5U3Bud1dEaE5HUFNkZkJITVBPczZDZDhHU0xVbWdSeU5RcFlLZlptMGRZ?=
 =?utf-8?B?eVBwcGxMdlhCcEtHMCs4S0VLeTJEYVp3N3lGZzlwY3ExUWcwVkJQRjhkdHJN?=
 =?utf-8?B?ZVU3N0ttZ2FuTXpDKzNYWEtCMXlBbW5TMS85NlhTcTNJYmFSemtpTnprY3RU?=
 =?utf-8?B?dlhkZjdudDJhODk2SEM0NGFqUTVlRWE1SXJPSE1IbEVkVmFZampvOFZaVjdm?=
 =?utf-8?B?S1hXd05rcTRIZmdxNE1zd3VhYmMxSkxseTZidFBhbTE4dytYTUJZT25NeVoz?=
 =?utf-8?B?Smttbng3eE1kRTV3bis4SytTV3FEbng3RW5sU1NyWENFRjN1K2xpVEhjcWgr?=
 =?utf-8?B?a3M5UGVleDhJUkRNd1RKcmQwbkl3SlFzZmpSbDRQUDNEOWxWblBaVEFGeE5o?=
 =?utf-8?B?cDNUUyt2alhLL3VnTWVVbmRSV0hyQTJRc3I3SHFLK2pGYitIcW9Td2U0ZUkx?=
 =?utf-8?B?dkFXZ2J6SHA5MjhBU3NCN1hiYUMrb2I4cU9DOTRkbFp5QWZyeGZEeXY5blNn?=
 =?utf-8?B?UzBrQmxhZFUxMm1GeGp2OVdSVjJ6elplTkNxQ3NjMWpyakgrL2lad0s3UkhV?=
 =?utf-8?B?S2xXbWlnRmxpTFRTZ3lOVnh4TE9yR3hLZ2ZyQW9LRFNyVEtRbjVNSjl5OUs0?=
 =?utf-8?B?N1dtblMvMmlPMFY0ZTB4NVVGeEJreGZyTURHVmc0TVpQczRaMGtvQ3hLV29a?=
 =?utf-8?B?ZDhMSVJabDRreEp0aWRJWWt0YWxhNjBrVDg1d0xIVWE1U3NGMHkrTFYvWlNp?=
 =?utf-8?B?SlduUTBlMHp3SWJtWWczRyt1Skpzb3dteFB2a28wZHBvWUF3d0hVOFg5MjF5?=
 =?utf-8?B?dWVucFV5SlpVUmlJc3BUbDdVMmh0dnVoNXJ0NVdKdS9keWdqclo1YTBQdTYr?=
 =?utf-8?B?LzhRVEMwUjAyeHU2MyttenU1STVRMjBzUWp2N2E5MTBuOUU4RTRlUkdHeXJU?=
 =?utf-8?B?VW4wTTlhTllIeElFNWtsYXpMTVpORU5LM255TjFQaDNENGJGdHRZTkJUR3Bu?=
 =?utf-8?B?MGh1d1NWMlAxMkJwa2lFdG9IM01HbVZBZ1lyZnY0dkNxb1U2Y2R3MDJ4ckRN?=
 =?utf-8?B?a3R1V29aWC9VSW9sNlJiWldjdERHOWw1Q2RIdjE2Z0xLSFdQWStueHd6a1FK?=
 =?utf-8?B?VGg3RkdlS3R1cy9rcDFFOTAwMjZPOFhCS2ZJYnZvZCtET3B1T1B3Q0ZHQkxI?=
 =?utf-8?B?bUJ4QVlnZGFmc0V2U2c2SGlCTVNtc0l6TForTTBhYmhnSzEwS0VFY2tFbFRz?=
 =?utf-8?B?NGlPTDRUcHQ2QVczNDJxeTlGVDRncXVreVRhU0xmc3JQMkdvcnVuYy8yRGF3?=
 =?utf-8?B?am5GR3lsV1dnNExLMnNRNkY3dFhKcTI3TWtoSTdCQ0hlVWIzQTJyM2I3aUZj?=
 =?utf-8?B?ZCtQNkpZSkp1VmUwOFRsajhvcFVPRVlrV1B5aG9KS3ZObFllSHlnc01qRUU5?=
 =?utf-8?B?MlRZWE5pV1pocmh2UExrbytsQ3JtRmF2NTcyS01ZSVBVL1lHRlYvQ1AvMnVy?=
 =?utf-8?B?RG5IelFlazdsUHViMURMcGhvZnJ1RVU3VHl3MXRSKzRhcFVaZmlPWC92aFA5?=
 =?utf-8?B?VU13RUVycTdPQzFFYUZFY2dUa3hOMHoxSkdkN2FyTnI0SjBLSHI4MUk5VnhW?=
 =?utf-8?B?bXJFaWVWbVdUbTlZY20yRDNiVXZZYmZMazM3WHdRQmFVcUJuTmZKc1h2YjZy?=
 =?utf-8?B?a1F6RWZSS05scjhOR0c1UytjajBVTVIvcnJkYVhBOWdKditxUmlZcW9rcVpt?=
 =?utf-8?B?VUlFZmU1UHEzNkRiemtMSmxGQlhLQmQ2cFFSUVBBL0g1N2VvaGQ2akVoN2JV?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6A5E80AA1A77A4D840141371A427D84@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0166973e-0a1d-4173-a4c3-08daee8dab59
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 19:55:45.8456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYJQw4dgGln70SwMDT9orITwhpwkZYaQkYUKKGm06TivmgYwo7CEFHupumCFiCRsIGE7In03aR+B9N4MhU4mNEoVQdQA4ihMdhsFWC7fJdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5045
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEyLTI3IGF0IDA2OjA4ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IEFkZCBhIGNvdXBsZSBvZiBhcmNoX3ByY3RsKCkgaGFuZGxlczoNCj4gDQo+ICAtIEFS
Q0hfRU5BQkxFX1RBR0dFRF9BRERSIGVuYWJsZWQgTEFNLiBUaGUgYXJndW1lbnQgaXMgcmVxdWly
ZWQNCj4gbnVtYmVyDQo+ICAgIG9mIHRhZyBiaXRzLiBJdCBpcyByb3VuZGVkIHVwIHRvIHRoZSBu
ZWFyZXN0IExBTSBtb2RlIHRoYXQgY2FuDQo+ICAgIHByb3ZpZGUgaXQuIEZvciBub3cgb25seSBM
QU1fVTU3IGlzIHN1cHBvcnRlZCwgd2l0aCA2IHRhZyBiaXRzLg0KPiANCj4gIC0gQVJDSF9HRVRf
VU5UQUdfTUFTSyByZXR1cm5zIHVudGFnIG1hc2suIEl0IGNhbiBpbmRpY2F0ZXMgd2hlcmUgdGFn
DQo+ICAgIGJpdHMgbG9jYXRlZCBpbiB0aGUgYWRkcmVzcy4NCj4gDQo+ICAtIEFSQ0hfR0VUX01B
WF9UQUdfQklUUyByZXR1cm5zIHRoZSBtYXhpbXVtIHRhZyBiaXRzIHVzZXIgY2FuDQo+IHJlcXVl
c3QuDQo+ICAgIFplcm8gaWYgTEFNIGlzIG5vdCBzdXBwb3J0ZWQuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+
DQo+IC0tLQ0KPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vbW11LmggICAgICAgIHwgIDIgKysNCj4g
IGFyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20vcHJjdGwuaCB8ICA0ICsrKw0KPiAgYXJjaC94ODYv
a2VybmVsL3Byb2Nlc3MuYyAgICAgICAgIHwgIDMgKysrDQo+ICBhcmNoL3g4Ni9rZXJuZWwvcHJv
Y2Vzc182NC5jICAgICAgfCA0NA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+
ICA0IGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tbXUuaCBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL21tdS5oDQo+IGluZGV4IGVkNzJmY2QyMjkyZC4uNTRlNGEzZTliNWM1IDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tbXUuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9tbXUuaA0KPiBAQCAtMTIsNiArMTIsOCBAQA0KPiAgI2RlZmluZSBNTV9DT05URVhU
X1VQUk9CRV9JQTMyCQkwDQo+ICAvKiB2c3lzY2FsbCBwYWdlIGlzIGFjY2Vzc2libGUgb24gdGhp
cyBNTSAqLw0KPiAgI2RlZmluZSBNTV9DT05URVhUX0hBU19WU1lTQ0FMTAkJMQ0KPiArLyogRG8g
bm90IGFsbG93IGNoYW5naW5nIExBTSBtb2RlICovDQo+ICsjZGVmaW5lIE1NX0NPTlRFWFRfTE9D
S19MQU0JCTINCj4gIA0KPiAgLyoNCj4gICAqIHg4NiBoYXMgYXJjaC1zcGVjaWZpYyBNTVUgc3Rh
dGUgYmV5b25kIHdoYXQgbGl2ZXMgaW4gbW1fc3RydWN0Lg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvaW5jbHVkZS91YXBpL2FzbS9wcmN0bC5oDQo+IGIvYXJjaC94ODYvaW5jbHVkZS91YXBpL2Fz
bS9wcmN0bC5oDQo+IGluZGV4IDUwMGI5NmU3MWYxOC4uYTMxZTI3Yjk1YjE5IDEwMDY0NA0KPiAt
LS0gYS9hcmNoL3g4Ni9pbmNsdWRlL3VhcGkvYXNtL3ByY3RsLmgNCj4gKysrIGIvYXJjaC94ODYv
aW5jbHVkZS91YXBpL2FzbS9wcmN0bC5oDQo+IEBAIC0yMCw0ICsyMCw4IEBADQo+ICAjZGVmaW5l
IEFSQ0hfTUFQX1ZEU09fMzIJCTB4MjAwMg0KPiAgI2RlZmluZSBBUkNIX01BUF9WRFNPXzY0CQkw
eDIwMDMNCj4gIA0KPiArI2RlZmluZSBBUkNIX0dFVF9VTlRBR19NQVNLCQkweDQwMDENCj4gKyNk
ZWZpbmUgQVJDSF9FTkFCTEVfVEFHR0VEX0FERFIJCTB4NDAwMg0KPiArI2RlZmluZSBBUkNIX0dF
VF9NQVhfVEFHX0JJVFMJCTB4NDAwMw0KPiArDQo+ICAjZW5kaWYgLyogX0FTTV9YODZfUFJDVExf
SCAqLw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYyBiL2FyY2gveDg2
L2tlcm5lbC9wcm9jZXNzLmMNCj4gaW5kZXggZWY2YmRlMWQ0MGQ4Li5jYzA2NzdmNThmNDIgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMNCj4gKysrIGIvYXJjaC94ODYv
a2VybmVsL3Byb2Nlc3MuYw0KPiBAQCAtMTYyLDYgKzE2Miw5IEBAIGludCBjb3B5X3RocmVhZChz
dHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGNvbnN0DQo+IHN0cnVjdCBrZXJuZWxfY2xvbmVfYXJncyAq
YXJncykNCj4gIA0KPiAgCXNhdmVzZWdtZW50KGVzLCBwLT50aHJlYWQuZXMpOw0KPiAgCXNhdmVz
ZWdtZW50KGRzLCBwLT50aHJlYWQuZHMpOw0KPiArDQo+ICsJaWYgKHAtPm1tICYmIChjbG9uZV9m
bGFncyAmIChDTE9ORV9WTSB8IENMT05FX1ZGT1JLKSkgPT0NCj4gQ0xPTkVfVk0pDQo+ICsJCXNl
dF9iaXQoTU1fQ09OVEVYVF9MT0NLX0xBTSwgJnAtPm1tLT5jb250ZXh0LmZsYWdzKTsNCj4gICNl
bHNlDQo+ICAJcC0+dGhyZWFkLnNwMCA9ICh1bnNpZ25lZCBsb25nKSAoY2hpbGRyZWdzICsgMSk7
DQo+ICAJc2F2ZXNlZ21lbnQoZ3MsIHAtPnRocmVhZC5ncyk7DQo+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rZXJuZWwvcHJvY2Vzc182NC5jDQo+IGIvYXJjaC94ODYva2VybmVsL3Byb2Nlc3NfNjQu
Yw0KPiBpbmRleCA4YjA2MDM0ZThjNzAuLmZlZjEyN2VkNzliNiAxMDA2NDQNCj4gLS0tIGEvYXJj
aC94ODYva2VybmVsL3Byb2Nlc3NfNjQuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vz
c182NC5jDQo+IEBAIC03NDMsNiArNzQzLDM5IEBAIHN0YXRpYyBsb25nIHByY3RsX21hcF92ZHNv
KGNvbnN0IHN0cnVjdA0KPiB2ZHNvX2ltYWdlICppbWFnZSwgdW5zaWduZWQgbG9uZyBhZGRyKQ0K
PiAgfQ0KPiAgI2VuZGlmDQo+ICANCj4gKyNkZWZpbmUgTEFNX1U1N19CSVRTIDYNCj4gKw0KPiAr
c3RhdGljIGludCBwcmN0bF9lbmFibGVfdGFnZ2VkX2FkZHIoc3RydWN0IG1tX3N0cnVjdCAqbW0s
IHVuc2lnbmVkDQo+IGxvbmcgbnJfYml0cykNCj4gK3sNCj4gKwlpZiAoIWNwdV9mZWF0dXJlX2Vu
YWJsZWQoWDg2X0ZFQVRVUkVfTEFNKSkNCj4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ICsNCj4gKwlp
ZiAodGVzdF9iaXQoTU1fQ09OVEVYVF9MT0NLX0xBTSwgJm1tLT5jb250ZXh0LmZsYWdzKSkNCj4g
KwkJcmV0dXJuIC1FQlVTWTsNCg0KU2luY2UgdGhpcyBiaXQgZG9lc24ndCBnZXQgc2V0IG9uIHZm
b3JrLCB5b3UgbWlnaHQgYmUgYWJsZSB0byB3b3JrDQphcm91bmQgdGhpcyBieSBlbmFibGluZyBM
QU0gaW4gYSB2Zm9ya2VkIHRhc2ssIHRoZW4gZW5hYmxpbmcgaXQgYWdhaW4NCmFmdGVyIHJldHVy
bmluZyB0byB0aGUgcGFyZW50LiBCdXQgd2h5IGRvIHdlIG5lZWQgdGhpcyBjaGVjayBhbnl3YXk/
DQoNCj4gKw0KPiArCWlmIChtbWFwX3dyaXRlX2xvY2tfa2lsbGFibGUobW0pKQ0KPiArCQlyZXR1
cm4gLUVJTlRSOw0KPiArDQo+ICsJaWYgKCFucl9iaXRzKSB7DQo+ICsJCW1tYXBfd3JpdGVfdW5s
b2NrKG1tKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfSBlbHNlIGlmIChucl9iaXRzIDw9
IExBTV9VNTdfQklUUykgew0KPiArCQltbS0+Y29udGV4dC5sYW1fY3IzX21hc2sgPSBYODZfQ1Iz
X0xBTV9VNTc7DQo+ICsJCW1tLT5jb250ZXh0LnVudGFnX21hc2sgPSAgfkdFTk1BU0soNjIsIDU3
KTsNCj4gKwl9IGVsc2Ugew0KPiArCQltbWFwX3dyaXRlX3VubG9jayhtbSk7DQo+ICsJCXJldHVy
biAtRUlOVkFMOw0KPiArCX0NCj4gKw0KPiArCXdyaXRlX2NyMyhfX3JlYWRfY3IzKCkgfCBtbS0+
Y29udGV4dC5sYW1fY3IzX21hc2spOw0KDQptbSBtaWdodCBub3QgYmUgZnJvbSB0aGUgY3VycmVu
dCB0YXNrIGlmIGl0IGNhbWUgZnJvbQ0KUFRSQUNFX0FSQ0hfUFJDVEwsIHNvIHRoZW4gdGhpcyB3
b3VsZCB3cml0ZSB0byB0aGUgd3JvbmcgQ1IzLiBNYXliZSBmb3INCnNpbXBsaWNpdHkganVzdCBy
ZXR1cm4gYW4gZXJyb3IgaWYgdGFzayAhPSBjdXJyZW50Lg0KDQo+ICsJc2V0X3RsYnN0YXRlX2Ny
M19sYW1fbWFzayhtbS0+Y29udGV4dC5sYW1fY3IzX21hc2spOw0KPiArCXNldF9iaXQoTU1fQ09O
VEVYVF9MT0NLX0xBTSwgJm1tLT5jb250ZXh0LmZsYWdzKTsNCj4gKw0KPiArCW1tYXBfd3JpdGVf
dW5sb2NrKG1tKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICBsb25nIGRvX2Fy
Y2hfcHJjdGxfNjQoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBpbnQgb3B0aW9uLCB1bnNpZ25l
ZA0KPiBsb25nIGFyZzIpDQo+ICB7DQo+ICAJaW50IHJldCA9IDA7DQo+IEBAIC04MzAsNyArODYz
LDE2IEBAIGxvbmcgZG9fYXJjaF9wcmN0bF82NChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssDQo+
IGludCBvcHRpb24sIHVuc2lnbmVkIGxvbmcgYXJnMikNCj4gIAljYXNlIEFSQ0hfTUFQX1ZEU09f
NjQ6DQo+ICAJCXJldHVybiBwcmN0bF9tYXBfdmRzbygmdmRzb19pbWFnZV82NCwgYXJnMik7DQo+
ICAjZW5kaWYNCj4gLQ0KPiArCWNhc2UgQVJDSF9HRVRfVU5UQUdfTUFTSzoNCj4gKwkJcmV0dXJu
IHB1dF91c2VyKHRhc2stPm1tLT5jb250ZXh0LnVudGFnX21hc2ssDQo+ICsJCQkJKHVuc2lnbmVk
IGxvbmcgX191c2VyICopYXJnMik7DQo+ICsJY2FzZSBBUkNIX0VOQUJMRV9UQUdHRURfQUREUjoN
Cj4gKwkJcmV0dXJuIHByY3RsX2VuYWJsZV90YWdnZWRfYWRkcih0YXNrLT5tbSwgYXJnMik7DQo+
ICsJY2FzZSBBUkNIX0dFVF9NQVhfVEFHX0JJVFM6DQo+ICsJCWlmICghY3B1X2ZlYXR1cmVfZW5h
YmxlZChYODZfRkVBVFVSRV9MQU0pKQ0KPiArCQkJcmV0dXJuIHB1dF91c2VyKDAsICh1bnNpZ25l
ZCBsb25nIF9fdXNlcg0KPiAqKWFyZzIpOw0KPiArCQllbHNlDQo+ICsJCQlyZXR1cm4gcHV0X3Vz
ZXIoTEFNX1U1N19CSVRTLCAodW5zaWduZWQgbG9uZw0KPiBfX3VzZXIgKilhcmcyKTsNCj4gIAlk
ZWZhdWx0Og0KPiAgCQlyZXQgPSAtRUlOVkFMOw0KPiAgCQlicmVhazsNCg==
