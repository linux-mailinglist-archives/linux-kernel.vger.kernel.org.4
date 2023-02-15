Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009646973F1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBOBxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBOBx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:53:26 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9E9BC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676426003; x=1707962003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YjzMRrr79cvWHhnzBj3/lDYHN5uz17MKB6Bd7+tQo6I=;
  b=ccVIvoMUNKKdghLHp1i23APOpRgcUTyrkt3h7s5Hse9F9VRq5DQfjQlF
   4YROD+YOUCuR2FX50GsYx6jwu7lFN4HbU+W7hHv+YpMKH+yd7HlUfj+dl
   1W6Eiou5LuGOSffjqhYQei0zN3vQZEy4RI0QjBOA9Rqp8Sm1k0fd5y7Lv
   v50cfVJMRjl8GFl6/uzj2pMQ4x2cCUB7BK/52VXR4rHDPD3jDjadDcy+l
   ZSDe+wF7QsFSjyysxMIXuCCDHfhWm4KzU9y/XTpIePUtCD/CQM+R1a4OK
   TVl4bP/K8yJH0dxsgfu40gGGeNYeGhrRs33KtOkr2n90uWIW843iRfRvf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="333457964"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="333457964"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 17:53:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="733099146"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="733099146"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2023 17:53:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:53:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:53:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 17:53:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 17:53:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxZZ8y9MYQqNSikNNQgDesPlEsLIRxqBixxiHse4OQBRtEa5iOzgDHowb/xSn+hti1Zrf3jUIH/dU+KEAKV6bUKBN7yfatYBSAXjKA7FtxEH46ZzGKy+E0K47ZaWjSmM2q3Q/p2KNdSDHg8NYhrT1HAlfG54QvWRWcRU9K1+8N11eAxBMkgwYiAfQwUNUb5GoVEAB1aTlUmmfv8Q2VJvF5IW+M0J97mvZJ58S/96K+ggZh2il/28D40BVB5GRA8RXYjYfONWzwDx4/gMdGyD0/ImdvcPXChCw9j80Kx3f4twSpiiMLy5+BESfvQP28iZX5FYjYQ+5JkgEWVE0idNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjzMRrr79cvWHhnzBj3/lDYHN5uz17MKB6Bd7+tQo6I=;
 b=HXbi0aHfZgfKowfQNaIX2zuINNAgwe1mf3uWVo9f3PnbX6CqJ5P9FiyMWkj8OgQx9aDyl8bvtyghMPqRVs1UdIqxlWoTAnoKvHT9K20ixh50HI+F17/oXesgrd1DCfhk9BawCv8iCvXSeAZ0317BOhhjxrgBD/uk4H0TUPLkzQZsYyi3+5j5t/KhcRhrcixt6ipIziywaQjHS9ij0E4WJ1j9uZrfN4noChatctZhXtnpxcu5hq9UIh9bNwjJJGOUMPDgoK4oFB0SNPzWIxNms11JDJVmcOvm2PxhE+FtADirHc3b2vjbY+Q852YtfSf999RD+XC2YB0QIrXqsH1MJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM6PR11MB4561.namprd11.prod.outlook.com (2603:10b6:5:2ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 01:53:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3f19:b226:ebf1:b04a]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3f19:b226:ebf1:b04a%7]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 01:53:19 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] x86/tdx: Convert shared memory back to private on
 kexec
Thread-Topic: [PATCH 2/2] x86/tdx: Convert shared memory back to private on
 kexec
Thread-Index: AQHZQAXD7tsyIloqhU2IdZsgp2Dap67PQH4A
Date:   Wed, 15 Feb 2023 01:53:19 +0000
Message-ID: <39b41f5b5852c5e9d23acb84a4ed4d9bf8a7c092.camel@intel.com>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
         <20230213234836.3683-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230213234836.3683-3-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM6PR11MB4561:EE_
x-ms-office365-filtering-correlation-id: 9a42e274-a81d-4da6-0795-08db0ef7697c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VSGvgC4PrsHVO0rVjVCNrxXBGlFGLZK2pSc6mZhEZudcnjXI0rLRnwVUVnz48Vy1uGmarL9pVTH/CeRYyAanvqIgVAT3rBQvemyg6Lz9VqnsT4zsKnuCgNNcBYPcr7guzCXp0Ro7dK3X0eAhAHTjxGuKn3yWKZeJ0levR433ezRn/47zywGvFwEGd8MUEZDRMGzQlslKv/+Ogi0IKYa3IqBtcDIuXSMUwEJbR+Aj4GnDoaBVjELZxELKEQBF9jG4w2lHTLdbuUG8E6BMGCcbsU5tQn4LCHvyWCuN981AURT2QCpC//k/qVoIvAydWhorjQQFHMi8P0AY04BX+vFlbxncnPVeWTNIE93zB/SpvObqIgddPOzWfLCrGcjo3XocYJeqPzQaXjH/QCl9WVn7+8YbpuDQp59gygPrDxnt6PTCWuipup++5UMRj7CA/xJ//11NsELdhq2VVfOKxlcYuGIsctqz6mWZy/UFSCsN4WtWDQ4kqXWhgSpUsxv772Gq8OMmnarbXpL6hMw4TmL2zVySE6DAo2aS5AIO5F+hydqaOOBOfrEh6SJRQln+ziH36ezZL5ApTwJiWUrtZf8MX2xAW1aXjAcRKZfFxJeKoHm7gNywl2fuZur0zd+/r+U5NqWQMomTuojkiQB6UKA98qm3lteIUuYWKOdTG+C4ufebQKisz7R4AfIMMl3PkUGP0MxB4ENzHLNsLBUBMMRTFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(82960400001)(91956017)(66946007)(38100700002)(76116006)(5660300002)(66476007)(4326008)(2616005)(6486002)(38070700005)(41300700001)(36756003)(71200400001)(66556008)(8936002)(8676002)(64756008)(478600001)(2906002)(110136005)(54906003)(66446008)(316002)(83380400001)(26005)(186003)(86362001)(6512007)(122000001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDNYMHNUZHlJOWdNekE1Wk9MQkp4dGZYdTNjT3RJbU0zcVdNbmdoMmYzWTNG?=
 =?utf-8?B?WVJxS3B2U2p4WU12aHRjaGc3QVgvTDlnS2JJK0l3ZVAwOVpoaU90cnl0SXFG?=
 =?utf-8?B?TWRzcXFCVytwR0MxU0tHazQvd2M3WnFRMlIxdUs0UVc4RkFoL2VTVGRBUmxS?=
 =?utf-8?B?TUVJV3ovU3VBanpyRTBUUFlvOUJQREtodzYzT0Q3ekJzSzgyd0s3eGQ4OGgx?=
 =?utf-8?B?NGIxSlBxV1ZENlVrWTlYaWlxL25tRmd4QWd5U1MwTStZSUhIYlZNVlJXZ1dp?=
 =?utf-8?B?bk1uazI1SXRJNWhFMUxjMjlTUml1ODYvWFZqSzA0cVVSQTF2b1lhazY2NDNs?=
 =?utf-8?B?dzlJWWpNcEhtQnE4aEh4SlpOWE5oQjNrUi82TkNrWmNFZ0xBSnhnZW1sWDRR?=
 =?utf-8?B?eE5hbXZBWEJpQ3dsMzVhZVVYUTJRRmdLeC9xYmVMWm95RU5DMDUrdTUvb2RP?=
 =?utf-8?B?SXcvdVZrWHlwYm00QXpRTTE0NDRUTG1qK3pqOVZjUWJqaEsvUnB3Q201K2JE?=
 =?utf-8?B?SmRsa2tGZXBneE4xeFY5a240bGpEemJRMUViVnNMUFFKUDFzZDEzRGN4ZDht?=
 =?utf-8?B?MTNZd0N2b21qQkdwdXVldUpWN1d1L2VXYThGbTJ3NVZiS3Yrc1BGT2Z1T0pq?=
 =?utf-8?B?WUMvWTdvWCtmR0pqYVFvVjB2VlBzTVU0eUt1aDdTT2hpUUVsVlk4dXlyZUkr?=
 =?utf-8?B?K0RxckpwNnpTUXU0YWs0UE05NHgva3hmbC8yUnBKUmxIazRqTXl4M3h1N1BB?=
 =?utf-8?B?KzBndUFXNHJIbFlhSGo0ZVAvemZOUGdTU05OMFB0SDh4VEg5QjcybityeXNN?=
 =?utf-8?B?YW5MeXg2MTVORGdwVUxveDQveUtMUUhqWDU3emVocDhkaVo2di9hYm1IaVh5?=
 =?utf-8?B?U2xrd3JnK0lhZFlRWE9UbTVIWTNXczVWZUFZU1lKcXY3MUJGSWRxQmUyQ05Y?=
 =?utf-8?B?YmVTdlFzUWoxWVVNazlKWmFqZisvTEdXMGlJZE82eTVPSCs3a3JQeVFvSkFM?=
 =?utf-8?B?OXJqUzhzVkozV3cvK3piUFRMbyt4NzVma2pHekIrN3ZrYlNZOVNUbG9FZFN3?=
 =?utf-8?B?TklhSTJqZ05LRDVTTFIxM0wvNUdPNFNnTXFLbG9tMVFhVGJmbEFuaUJrblV2?=
 =?utf-8?B?eTUzY0dvVEZ4VVBnbkhQdE5tcHQ2bVZiK2Njd2VqckVhbURVdk5XelhnbDhi?=
 =?utf-8?B?dmE0Q1BLdnBVQStNOTFHcFA5VzU0MGg4QTBmTVBQbGNpcXBpVVUwVENwRWVS?=
 =?utf-8?B?T21IY3NOdmh5NnRNTlFDY2lobG5iWGo2U1BERlVaVWhVUFdBZVQzRk5LNlVF?=
 =?utf-8?B?WS9SaEJuMFJJVmcxR3JKZDB6VGkxT0dqSUFocE9vdUVlOGNoelpHSWpZMmdY?=
 =?utf-8?B?bkpTWTNoeHQ1bklBTWRVN0tFeGpVWmlJeUhubk9SNzZFZ3pIRWZoN1E1MTli?=
 =?utf-8?B?NVFWQjJpbW0vYWZ4NndRUnZkRTB2ekhxVTRpa2dUR2VVc3grMXR0V0FpSDQ5?=
 =?utf-8?B?N3I2K2VrL3Jzand0WVNiVnBtdEhCVEdXWDZGb25LU1hsNHMzRXkzT2QxMVEr?=
 =?utf-8?B?NDZLeHI1ZFAxMisxUVZoT0NlcDBqbHp1UHdjZ0FZcDdRUnR6VFRXUkdqZWZi?=
 =?utf-8?B?QWVTQjQxek9wVnlXYzJlMjUrMkFmOGFaYWp0UE9ReWhBVkszKy9PeVlkbVJT?=
 =?utf-8?B?WjJ1cGhMOGlhT3BiRVg4QzdPVGxyWXVjbXhKL2JUK0hiVXN0cUVDVHpMajNy?=
 =?utf-8?B?TUhQU2svblllNWVLWjg2cjRQM093OEpCTUFyeHM1NFdoeEsxN2xrb1JhbElE?=
 =?utf-8?B?dkZZTjJuVDM5MHlGWTA5Z0JiL0xZMjJGbGF4NlIxSXBsNVpiN25jYVJMVWsv?=
 =?utf-8?B?WlA2ZC81Ynd3WTZBd05FcEVBeXVPTFZwcWQ1bXR1Z0RmdXNUWFBzczFuODJp?=
 =?utf-8?B?TWFZZmRTRU81ZmVEeGY2TC9IQStWT2hJbDVReWxVS09PSjhtSURWdEdvS1E2?=
 =?utf-8?B?dXlsdGwxMXJGNVV0QXNITUpVRkk4aW9mQ29KckRnQ1Ezbk5Wai9KUmRKWU9R?=
 =?utf-8?B?MXhXQzRNdHArKytPdVhRUnE1UjNWVjZXWmpFbi9RWHJQc1NoKzZBRzU3ZVdV?=
 =?utf-8?B?dUthWE5YY2hsSTNRTmRkdFlvOTQ1dmZvZ3d0eEI2TGxLSTlZSzUxS1djTVhO?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84C0A106BEDF754AB6C2B2D0730CF993@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a42e274-a81d-4da6-0795-08db0ef7697c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 01:53:19.2035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qT4NH8sUdf2GlhIIg3uxMI87Zbk1HWYA+gSDatyK5FtZiQKnIFeE42DfkBJiN1ymwVweSoNAEIuYdhA6IeEh8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4561
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ICt2b2lkIHRkeF9rZXhlY19wcmVwYXJlKGJvb2wgY3Jhc2gpDQo+ICt7DQo+ICsJLyoNCj4g
KwkgKiBDcmFzaCBrZXJuZWwgbWF5IHdhbnQgdG8gc2VlIGRhdGEgaW4gdGhlIHNoYXJlZCBidWZm
ZXJzLg0KPiArCSAqIERvIG5vdCByZXZlcnQgdGhlbSB0byBwcml2YXRlIG9uIGtleGVjIG9mIGNy
YXNoIGtlcm5lbC4NCj4gKwkgKi8NCj4gKwlpZiAoY3Jhc2gpDQo+ICsJCXJldHVybjsNCj4gKw0K
PiArCS8qDQo+ICsJICogV2FsayBkaXJlY3QgbWFwcGluZyBhbmQgY29udmVydCBhbGwgc2hhcmVk
IG1lbW9yeSBiYWNrIHRvIHByaXZhdGUsDQo+ICsJICogc28gdGhlIHRhcmdldCBrZXJuZWwgd2ls
bCBiZSBhYmxlIHVzZSBpdCBub3JtYWxseS4NCj4gKwkgKi8NCj4gKwltbWFwX3dyaXRlX2xvY2so
JmluaXRfbW0pOw0KPiArCXdhbGtfcGFnZV9yYW5nZV9ub3ZtYSgmaW5pdF9tbSwNCj4gKwkJCSAg
ICAgIFBBR0VfT0ZGU0VULA0KPiArCQkJICAgICAgUEFHRV9PRkZTRVQgKyAobWF4X3Bmbl9tYXBw
ZWQgPDwgUEFHRV9TSElGVCksDQo+ICsJCQkgICAgICAmdW5zaGFyZV9vcHMsIGluaXRfbW0ucGdk
LCBOVUxMKTsNCj4gKwltbWFwX3dyaXRlX3VubG9jaygmaW5pdF9tbSk7DQo+ICt9DQoNCkxvb2tz
IHRoZSBwYWdlIHRhYmxlIHdhbGsgaXMgZG9uZSB1bmNvbmRpdGlvbmFsbHkgd2hlbiAhY3Jhc2gu
DQoNCkkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gY2hlY2sgd2hldGhlciB0aGlzIGlzIFREWCBndWVz
dCAoZWl0aGVyIHRoaXMgZnVuY3Rpb24sIG9yDQpiZWxvdyBpbiBtYWNoaW5lX2tleGVjKCkpIGFu
ZCBqdXN0IHJldHVybiBlYXJseSBpZiBpdCdzIG5vdCBhIFREWCBndWVzdD8NCg0KWy4uXQ0KDQoN
Cj4gIC8qDQo+IEBAIC0zMTIsNiArMzEzLDcgQEAgdm9pZCBtYWNoaW5lX2tleGVjKHN0cnVjdCBr
aW1hZ2UgKmltYWdlKQ0KPiAgCWxvY2FsX2lycV9kaXNhYmxlKCk7DQo+ICAJaHdfYnJlYWtwb2lu
dF9kaXNhYmxlKCk7DQo+ICAJY2V0X2Rpc2FibGUoKTsNCj4gKwl0ZHhfa2V4ZWNfcHJlcGFyZShp
bWFnZS0+dHlwZSA9PSBLRVhFQ19UWVBFX0NSQVNIKTsNCj4gIA0KPiAgCWlmIChpbWFnZS0+cHJl
c2VydmVfY29udGV4dCkgew0KPiAgI2lmZGVmIENPTkZJR19YODZfSU9fQVBJQw0KDQo=
