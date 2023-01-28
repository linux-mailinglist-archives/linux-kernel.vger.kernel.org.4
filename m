Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E589267F3FA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjA1CZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA1CZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:25:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894DC24C99;
        Fri, 27 Jan 2023 18:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674872747; x=1706408747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xDuSzPFMF/KzHdNT3jxr7C2fCt46QpC7qkaQ4jLULrA=;
  b=IEJg/tEKQ5Jr6G4Fb4jFy/7z04fyhGo4EQLBJm7SiplG1Gc9ZwAoxiNk
   EdEg3LmqjsWaSBOjGZxSKjr7SvUPuCicXSbHgWk+r22qV45yRCgGTedg3
   rS8s41Ruo4mea9OyAsd684PXpEnr+R4QJITSDTHVwblEZ8I3ZTc58f9NG
   1Ych52MKJNY7rI/S2H+U1HngLdW6TFlpcwfnk+UtoznySNOLsVe9Gsp+A
   bK3wGaNXOompmGbI16lXb4aXx5eeh5a0Pkr48XwHd9u1AY6SiBy0SGV8c
   dQyNWxUtmc8CwL3lWgy2TutCLOYT77DyRWxEp+6ZxLm2p/50TeTQJmQca
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310874648"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="310874648"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 18:25:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="663484942"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="663484942"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2023 18:25:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 18:25:45 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 18:25:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 18:25:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 18:25:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPkzSfHXLp1YD0ZJzcVCFD/3joGi/0XVLtTYXxcT1BzCFdLVWBsPkrWNLDxgaSwPZ3dVYOsixRfMaFKKxP+PPYO1F1RhvKJEBKfUN3ZjRsVJM23roKQpXlsMmBkA2fkWucwhHv2Wlvxbuede+6LenvNRTTKP4iOT2dBBdTL5p90E83R7/8wH8j4Bn1Z9LB2pa3CCDA4g3li1yoOV9I8OsFG3LZzHDaPWtYX3SukCdht9YKMxTOLnj76L55aC9mvmCwWUtAFMpMyLq9qLXV/iq31XxTLluHc01BhFnt+v+Be+6BsOE+khhCIQeW1GCjAD2/0Drv9H8VLvoyfpbtYuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDuSzPFMF/KzHdNT3jxr7C2fCt46QpC7qkaQ4jLULrA=;
 b=EE+PXf27gxkJhThSTHBkp3SKbWgWvLB6VnfUPjG9TV5mYwp6SonwV8JtknoFDb9zpWir5EmuCdbRGkDQu5ZYdqsXPh5tagg/3IWdLssWs9TQQYT03AeYDYngj4mgh+bFPmDd4aHrSasN+yWe6wUpBzZb3vPKd7eq0+QSK+5dONIiZf828z195deAqAuTM0xGQC5cXL/O/oLCtB+H2zLB+mtLbhPjHDUMzz4XNXcoqbOMb00WLraaRct5ll/8gEZzgRWbnfChoKUSwzL9XVsOE59jVKAUGEwj1Ppg5fUgwrJcRXIfJ/Vhoz27ER5N7hKY6sLskXIkyiAfh40DpubHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA1PR11MB7680.namprd11.prod.outlook.com (2603:10b6:208:3fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Sat, 28 Jan
 2023 02:25:43 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%8]) with mapi id 15.20.5986.018; Sat, 28 Jan 2023
 02:25:43 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 3/7] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Thread-Topic: [PATCH 3/7] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Thread-Index: AQHZMbXlA1Use0JcAUCVct/GPJuaw66xNcCAgAFfsID///WaAA==
Date:   Sat, 28 Jan 2023 02:25:42 +0000
Message-ID: <IA1PR11MB6097E8649636CBB040A064EA9BCD9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-4-tony.luck@intel.com>
 <IA1PR11MB6097400A3056553FCC8E193C9BCC9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <SJ1PR11MB608302C99598570098E40102FCCC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608302C99598570098E40102FCCC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR11MB7296.namprd11.prod.outlook.com
 (15.20.6043.007)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|IA1PR11MB7680:EE_
x-ms-office365-filtering-correlation-id: 3bbbad4f-efc8-499d-db5f-08db00d6f4a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: alX7t8aAKYHcFPZrPtgUtgfJp5GWFG/MzKM4Rq5DUeAkViPCyMH+uErbIPUuYHDWb8vsBa6+oOKaQ7ZJCgXqMRSMueSm3djAzXcqs/exkbdgsZ+14tATh9C31k+Be64+CkF49xU57BGJWx5qxOTtSHGKupuQduT6n9GiQgDMsz7I6ydPMjDPFwY/v6CSo2WL98jmYHKoQtT3g/mO1hIABGPzY6iDGROEzFSmm5cO5IKtfVyR4PBZDpii66sI6TELAjH3cN4TqBTti8Vqp1pvJKpnVBIIHbpfeK1xgyA64VykS2GJW3T6fQHNq1QO3yD7XfQ0i+CPrTdM6xBbO0FDlczKKiFhPd9efbQnlMXuyrDrBTh4iIReqkGz+3PBwpMSvMq4KpkboXoiWvCFNF1BoaodynczXgAiDnERENwWQC8+H3XjVAC2qRaovJuHKQohhHk4mIZZtlM8gc/kRkoad0gk732g1vSv8ZllMth8EIpkHozNWktMMSDoo4MourSXDMO01Azkj4/LUhI4yv4N/tMjpqvH3WsPrYYz+5cQAiUmX8Tyw9nmRh+/s9knZf3upBAxnDuVojGBhynj683XMEbfgkChV9aNP7OGfkONUUf5YJAzWQToYovvNKAnZengrQ61BCyVYCgSl+zW9lc4SUYzgrTdiqcpaK/S/5ujlHehqoR8Za0clJ2LlDI5gSAE5VZkmtMBMYEy00f1hwY1qvpXfvaKWyEl4N3aXCFLcQKK2Ko/8hUBXHrym8OOAV3E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199018)(54906003)(8676002)(71200400001)(7696005)(55016003)(83380400001)(122000001)(186003)(38070700005)(82960400001)(26005)(86362001)(9686003)(66476007)(478600001)(7416002)(5660300002)(110136005)(2906002)(33656002)(316002)(38100700002)(6506007)(53546011)(66556008)(41300700001)(8936002)(52536014)(64756008)(66946007)(66446008)(4326008)(76116006)(65966003)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akV4bEdPdTNpR3JsZW1aZTNDNmRPZXI4OGRCK2pFS1hIRENwZVMycmttdU9C?=
 =?utf-8?B?UTh3eHRkdVQyTEpVd0Nsdkk2d3ZibzhTaUZUb2trcjFWbk05S3ZWTG16dWVF?=
 =?utf-8?B?RTViZ2MrVTExRGYzaDZGVjhzbmxScHpoZDFWamJCYk95QkJzcldENEJjRlNz?=
 =?utf-8?B?eUxVekpCT0tQS1E4OW1Wd1VIbUN5S1I1NExnR0xlbXBsUWJEVEh0RW54azNi?=
 =?utf-8?B?Rm1rb2g2RFhqbXREaDFXblRXbWVYeFFFYVJiR2VlUUdIbmptd2YxYU01V1lq?=
 =?utf-8?B?TjZnV2FOaEppaXoxbDVMQXpGMTJXSU9tdFNhZksxT24zWGVTSWVxZThpY05z?=
 =?utf-8?B?aTEwcmR3WWx0eXJIN2IwblpJaWRHbUpFZU9heXZpYU9SQ3ZFTk0rK1BNNyt6?=
 =?utf-8?B?d0h5NTRLYWlTWFhOR3l2Zy9oazh6ZnpiSDVhQ3l2eU90ek5WTVlaSXZPUUkw?=
 =?utf-8?B?NU9jSkdVQUlTcmVoUXIyMzdwN3ZTNkRKTEFMR2dhRzg3QkIwa2x4b3oxNFpx?=
 =?utf-8?B?OXBOUmlIZVhZdDdFZG1raVlJSENzemthZGp5dDVVOTRJRmE2Y0pVczZUanlD?=
 =?utf-8?B?RXl1dG4vRXEzZDkzR3RxMWp3RytUOWdubTAvNEVGMklkdFlibjdyeHFmUk5E?=
 =?utf-8?B?TTRrQWpTWDNKNm82dmRWanFDOFgwcjMvYkVLK0NPejEzb3JlQSs1Y2t0S0Uv?=
 =?utf-8?B?VDV1Q2taQ28xT2JLQW05c0dVRnhybUM2dUR1enpaTE1IMFAvL0ZKN01tK1Bn?=
 =?utf-8?B?dHh4NTVCb2dxQUVCVDBSckpqS3hkN0xRRkZaTkxxZGlUWTdiQTR6VzdiMDhw?=
 =?utf-8?B?blFWeTBKYk5LQ0RCTmNSU0ZMWDdrbnJ0U2VNcDEzeEtJWDhtcUtwU1pJaklN?=
 =?utf-8?B?SmkyRHM5RFA5ZXNjSDRSNXpzZG42RDV2L3J6QVJFbnVYMkFCeGU1cjRkNWc4?=
 =?utf-8?B?WmRJazZWZnpLaVZIZ0liMW1XSklZaWdJS2F0N0VQVVVzZktydDRrOFVxMHBO?=
 =?utf-8?B?RXZlb3M0L3J4cVk3aXpTbWNScnZwZHFzNGhwa09tTXo3Qnh5dkt5VDdLMkU0?=
 =?utf-8?B?R1dJTmZiSktEbnFrU1pwQ2VZOEZsejREZXdibkx3Q3hBZkt6NUhjQlRMM2kv?=
 =?utf-8?B?M0xaaW02UVZzMkZwemlvdDJ3WnBHZnY1QlNMbmtMZlIyNElMRVBpc2F5cCti?=
 =?utf-8?B?eHdXM1RRM1lZeGNVTDVrN2lkcFhnbzBoRkEyNmwwSHNPZ2tIRjZ5VXRmQ1FX?=
 =?utf-8?B?R1B3c2s4eU56c2Y5ZWp3RFBTN05PT0RpV1VSYXBnR1ZwczBqcXlnUDV3aThR?=
 =?utf-8?B?RFJwbkJHUjlrTU42eS9heHBCcUczaUIraEh1empMR3FiVG5peWdhNGlVRmlJ?=
 =?utf-8?B?c3lxakVwYy82TUp0T09IcG8zRjVqMGhHR2U5SFhrdXBkamlHK3Q0bTlHVzJ5?=
 =?utf-8?B?NlhQNy9xUUhKT2ZVWGVFUDJwZGtZV3MyQW14T1grQnd6emZWelpPRjJMOWw5?=
 =?utf-8?B?UVhxUXp0Q0hYOU02c1duMkRvS0F4SDVSYzlXaUo1UlhwWjZ1ZDZBS3BaTGNK?=
 =?utf-8?B?RUIyaWNGNnNiOVRXdkl4WTZGOURGSFozMXFoVU41M3pwUURad0tjaVIvR2NV?=
 =?utf-8?B?Uk1Zb1BXaUo5dzJDY2NZZnplK0NaamRpeHpWYTJXY0VGLzUrdTZsRUoySW1N?=
 =?utf-8?B?VFV1amwzL1R2c0ZvQW9EOUdHZ1VvUit6ZFRIYnJETHVuRk14WnRjN25Zem0z?=
 =?utf-8?B?amJkNE11R0plWTBOSkxCOTFlM0VsVVhtTERTRHhzUlpPRzkrZXA5YWFpV1NN?=
 =?utf-8?B?ZTdjVVlOTVpaN1BGUlFiYURLdUdaMmNFVUorbjFidWluZzJVRnRMSngxZ2s0?=
 =?utf-8?B?WVJUc1BSWlp3MmlCNFdRV2dNbzBRMU94YTRMTFE5cHkzcFdMYnF4QXJGWUZt?=
 =?utf-8?B?WjNRSmpKbXNVOExCR0FkSDFPeXJFd2x2Z055dlViUW52NUtPMysxTDNNUFht?=
 =?utf-8?B?YmMreWFPVFJNMElxR2M4WnpzdjhiWVFGdG1MRlJ5TkpYSmlKbWd4NzQzRUxk?=
 =?utf-8?B?Nlhmd2tFVXZpRDRhMXpZa0FWUjIwWjVsSVVIenFsT1JwZTR1WlJNRXNWNFc3?=
 =?utf-8?Q?h5YwkT85POgXLHA9yR1sqxAZc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D3B801FB0DA99479A0B00683C3F6694@intel.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbbad4f-efc8-499d-db5f-08db00d6f4a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2023 02:25:43.0009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: evBNkscWViDIADOsqe984pDEkIMXPnH8Rd8w0GMcP89j+/5PrXaI9y66XfQtY9MNHXh5RK3owMHc7p+g/8a4wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7680
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFRvbnksDQoNCk9uIDEvMjcvMjMgMTA6MjMsIEx1Y2ssIFRvbnkgd3JvdGU6DQo+Pj4gKwlb
UkRUX1JFU09VUkNFX05PREVdID0NCj4+PiArCXsNCj4+PiArCQkucl9yZXNjdHJsID0gew0KPj4+
ICsJCQkucmlkCQkJPSBSRFRfUkVTT1VSQ0VfTk9ERSwNCj4+PiArCQkJLm5hbWUJCQk9ICJMMyIs
DQo+IA0KPj4gIkwzIiB3YXMgbmFtZWQgYXMgUkRUX1JFU09VUkNFX0wzIGFscmVhZHkuIFRoZSBk
dXBsaWNhdGUgbmFtZSBoZXJlIG1heQ0KPj4gY2F1c2UgZHVwbGljYXRlIGZpbGUgbmFtZXMgaW4g
aW5mbyBkaXIuIE1heWJlIHJlbmFtZSBpdCBhcyAiTDNfTk9ERSI/DQo+IA0KPiBJIHRob3VnaHQg
dGhlIHNhbWUsIGFuZCBteSBmaXJzdCBpbXBsZW1lbnRhdGlvbiB1c2VkIGEgZGlmZmVyZW50IHN0
cmluZyBoZXJlIChJIHBpY2tlZA0KPiAiTk9ERSIgcmF0aGVyIHRoYW4gIkwzX05PREUiKS4NCj4g
DQo+IEJ1dCBteSB0ZXN0ZXJzIGNvbXBsYWluZWQgdGhhdCB0aGlzIGJyb2tlIGFsbCB0aGVpciBl
eGlzdGluZyBpbmZyYXN0cnVjdHVyZSB0aGF0IHJlYWRzDQo+IGNhY2hlIG9jY3VwYW5jeSBhbmQg
bWVtb3J5IGJhbmR3aWR0aC4gVGhpcyBzdHJpbmcgaXMgbm90IGp1c3QgdXNlZCBpbiB0aGUgaW5m
by8NCj4gZGlyZWN0b3J5LCBpdCBpcyBhbHNvIHRoZSBiYXNpcyBmb3IgdGhlIGRpcmVjdG9yeSBu
YW1lcyBpbiBtb25fZGF0YS8NCj4gDQo+ICQgdHJlZSAvc3lzL2ZzL3Jlc2N0cmwvbW9uX2RhdGEN
Cj4gL3N5cy9mcy9yZXNjdHJsL21vbl9kYXRhDQo+IOKUnOKUgOKUgCBtb25fTDNfMDANCj4g4pSC
wqDCoCDilJzilIDilIAgbGxjX29jY3VwYW5jeQ0KPiDilILCoMKgIOKUnOKUgOKUgCBtYm1fbG9j
YWxfYnl0ZXMNCj4g4pSCwqDCoCDilJTilIDilIAgbWJtX3RvdGFsX2J5dGVzDQo+IOKUnOKUgOKU
gCBtb25fTDNfMDENCj4g4pSCwqDCoCDilJzilIDilIAgbGxjX29jY3VwYW5jeQ0KPiDilILCoMKg
IOKUnOKUgOKUgCBtYm1fbG9jYWxfYnl0ZXMNCj4g4pSCwqDCoCDilJTilIDilIAgbWJtX3RvdGFs
X2J5dGVzDQo+IOKUnOKUgOKUgCBtb25fTDNfMDINCj4g4pSCwqDCoCDilJzilIDilIAgbGxjX29j
Y3VwYW5jeQ0KPiDilILCoMKgIOKUnOKUgOKUgCBtYm1fbG9jYWxfYnl0ZXMNCj4g4pSCwqDCoCDi
lJTilIDilIAgbWJtX3RvdGFsX2J5dGVzDQo+IOKUlOKUgOKUgCBtb25fTDNfMDMNCj4gICAgICDi
lJzilIDilIAgbGxjX29jY3VwYW5jeQ0KPiAgICAgIOKUnOKUgOKUgCBtYm1fbG9jYWxfYnl0ZXMN
Cj4gICAgICDilJTilIDilIAgbWJtX3RvdGFsX2J5dGVzDQo+IA0KPiBUaGUgbmFtZSB1c2luZyAi
TDMiIGlzIHN0aWxsIGFwcHJvcHJpYXRlIGFuZCBhY2N1cmF0ZS4NCj4gDQo+IFRoZXJlIGlzbid0
IGEgImR1cGxpY2F0ZSBmaWxlIG5hbWVzIiBwcm9ibGVtIGluIHRoZSBpbmZvLyBkaXJlY3Rvcnkg
YmVjYXVzZSBhIHN5c3RlbQ0KPiBlaXRoZXIgaGFzIFNOQyBkaXNhYmxlZCwgYW5kIHVzZXMgdGhl
IEwzLXNjb3BlZCByZXNvdXJjZSwgb3IgaGFzIFNOQyBlbmFibGVkIGFuZA0KPiB1c2VzIHRoZSBu
b2RlLXNjb3BlZCByZXNvdXJjZS4NCg0KVGhhdCdzIHJpZ2h0Lg0KDQpUaGFuayB5b3UgZm9yIHlv
dXIgaW5mbyENCg0KLUZlbmdodWENCg==
