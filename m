Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9009B5F4C14
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiJDWml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJDWmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:42:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C51C6E2D4;
        Tue,  4 Oct 2022 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664923355; x=1696459355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pUZu669TqDi2QqL/trPkOvwR7EAWNHs1AtpgYIrtqpk=;
  b=ZTpHss1hhaFzXfdyh31Gixm4KISa09W+L8F0X000VaD3YmzMyjZJUvOh
   RpAOX/RBi043WdKvuVEz2cxHi7aOcmbPJl+T01voTcC7qUbWoBifrUpO2
   O/mN1oirH8I0u2AZYqZTQteSU/7pR5/cnibP8EV3yNMy4+m49soje24/5
   Sd55fz9NseI9G3RzUuX98F/AdivoWNk0kHphfRee+SQgbe3TOzcyaFSO1
   hrm7T9J66XP8P1kJaPJ69b3nqTJH7JVyg8sRB3tBSiqGmZFeINYnVT0Q5
   g1m386TMu6Tqk9kxzqsFZeK1Em91BzfJ+382qt5c6e41AL0+plqFgEuiU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="389334624"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="389334624"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 15:42:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="624122933"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="624122933"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2022 15:42:34 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 15:42:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 15:42:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 15:42:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 15:42:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUo47I131wjXSRWPtM6tgt9xNRvNCW/Ls3dq3VZ6ehD1zL7UTQj4Put2pF3lVsh6Z2qwlXhAP7CJ//S2GxnwVkh3gwgP5GhS8jIm/XuKuPUhNkyioB+IsQpJ/ps5GIY0ZR7CQCT2PNZcbb0pM2MUmWcIQKxadEsm+0sRymoxZcflnUXwChpHxsxMe+1VVPDUZyxWjWDhTVmVwnCoCLTFt1Ow5B+FXChIKnqFKde8n60daDqSyuk+FNSfZVPyMVl5CJoUAfyWtxw4fobYb1Vhz7GPGWm1eavws4176mQo/3BkgTyJ7w5duqMYSc1+ac2ApfHeEOcCazdRMw/VfNzQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUZu669TqDi2QqL/trPkOvwR7EAWNHs1AtpgYIrtqpk=;
 b=OoBXS7QnitfXa60SNGNsf0EUUIfYh8NW1gdzIRCZxfnisM/B2veyI9gseg0QfFrruIF/vvt8/P7/Lv5Vb17sM7m74MpxGN9D0lNgdRnoVP5m3wupBg6WMidHr3QpWtseeA1qP3OTvgQ7lNsUcR1N1+N7wSRdwskqlQ2HAx8B/cK/S/HObbbkqFWI85Iafi2Rt0yk77Jmzr7IV/dSfJkJX0T8J9IVbYdF7nJrmAdaPIInyYJbCCQet4P2ETAlz+znzfZgyCkw+4GxczNU/w3rECKflpTvb2yMBguU8mOHUcJpB/sOOh0lkhBjLlfg0O+XLg+Hcc6kHl0sJZE6Asq9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Tue, 4 Oct
 2022 22:42:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::6eb:99bf:5c45:a94b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::6eb:99bf:5c45:a94b%3]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 22:42:30 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "jarkko@kernel.org" <jarkko@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH 3/3] x86/sgx: Add xa_store_range() return value
 check in sgx_setup_epc_section()
Thread-Topic: [RESEND PATCH 3/3] x86/sgx: Add xa_store_range() return value
 check in sgx_setup_epc_section()
Thread-Index: AQHY13Pfg2WQsgd00UuSgGOh0H9u1K3+0GKAgAAF4IA=
Date:   Tue, 4 Oct 2022 22:42:30 +0000
Message-ID: <57b607fa66a84996174fd16be415ec65dbffe8d4.camel@intel.com>
References: <cover.1664834225.git.kai.huang@intel.com>
         <c02b60d3b92469a2ccfc0780e974d29da578be73.1664834225.git.kai.huang@intel.com>
         <Yzyx5333eIuX0zaT@kernel.org>
In-Reply-To: <Yzyx5333eIuX0zaT@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY5PR11MB6366:EE_
x-ms-office365-filtering-correlation-id: bcd1ead8-c9b0-4577-253c-08daa659b8ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BIkmICehW8tI9jUytNESwHrL7kdC57ozOgURwMIYxwcQxAlBLSP9UDqJcg60+o2lglg5n8H/Yo6HO74XMnvKYyfBNUD+dmW9Zig/mZw3Tvwd3Av3Ysu7M1zRk7cjWrtS5X1jI9DegJ6Odos3WcZqxFg/nL2wTK4B4uOCO4tlGMF6F0oIuR3NC/M4y/NxjffNW1qJANzXvD2BJG/VwT2tVMlV5IBqbcIzxnnMUEccoCs6l+YJfCzn3f/zNQlvbgm3ou4vzqyZ8j6qlT1qJNlaU3IXenUiOw7cq5wyFYc95WxNa/aCFd+pTZIYRiqGVXcEqsRzSRlVLN+BYFjx39KEn2SJG/GjQUeykZ4EZWHpbUerk+7sWpEudOubqhYz5DjBjrsVSnHhcEVCJ5J59KPgAT0at/MWmUOLFDWNhMMLCxBlKA/WiMQliV/FDSEp12Z2a74zplilSTqT7xXuLfg9TqT210rC9xQAI1TbZNMkJh/oiEpHRCeZLfwomctkuhUU0lYKhWxI5eNLi61PcVxa7HBFxA7WOKZtK/GjChLMLu3wNMhUEtk6+ZJ9CK9ifmWtILdpQQpXe94NDk0cM1vW2aFhNLo4Xp4nVNXhO5tDYWidH4LFh3N5PLxxh2FCzUaw4UFHbTCbRgNwPFKnKcaI+M5dLEE9tevVkiMFA/bPJwsiSdo6sgAtQN1X6Ll16CwxKq7HLnr81ff5RrYl2ggH7QFieHaktfe05ty7BYYlvD2gU/yODTWakgiSgJagIQ86t1Sr4T696N1LvyVOYKBuMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(6486002)(64756008)(38100700002)(122000001)(82960400001)(86362001)(54906003)(66446008)(110136005)(4326008)(2906002)(8676002)(36756003)(478600001)(76116006)(66476007)(66556008)(91956017)(41300700001)(316002)(38070700005)(5660300002)(26005)(66946007)(8936002)(6512007)(6506007)(71200400001)(83380400001)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZURobHA5blFxaWR1WFkyQmJrS3UxcFJTbkI5emw5L2hLMGp3anBDUW9YMnB3?=
 =?utf-8?B?RVkraVh2bCtrbngrNmR5RkpndGNMQ2J4OS8xUlprYW1BUjlNOWxtZnVXUEZz?=
 =?utf-8?B?NHd4Um5nSWMzbys2R2pvZk5EOWU0MzJWMmlVMndPM2lGU0tPQXQvR1pFQzI5?=
 =?utf-8?B?ZVRZdHhYM1FLMWhVVkgrWHlXalA3aVZXeHd6YldWV2FMeGdKbGpZQnlFc0J3?=
 =?utf-8?B?L2p3SU1pWXRGNHAxR2NUVWtPU3FmYmRDY1dDYUEwZVUzekU4czJOcWc5NGxy?=
 =?utf-8?B?VlNBU1krKzEwVjZLbUdsL1ZIVm1xZ3I2ODZ6c2dWb0w3eE15YVBQRGlsVk9V?=
 =?utf-8?B?UzZDMXVVSEdqWlh4dGFBT3hQOHVnZDRVY0lnVStNcFcwMTRQR0k1MzZHN05G?=
 =?utf-8?B?eExaU2xqU1N2T0FYUmozZUI0a2lZNjZ5NDRPQ1ZqZzRKaHlSamxBWm54UkMz?=
 =?utf-8?B?VnFwWk5yRVRMam1zc0dIcHRtckVqeTRMUEdYeUlFU2V6a0JqaGZsa3FxeFRP?=
 =?utf-8?B?clkwcXg0cTcwejhNQUsxOVh0N2gxVHI1a2hmdkRxR0lETWNPdXFRcnk4UDlP?=
 =?utf-8?B?NkJNb1RWZXlRTktod1d4QzJ5bFRIMElFWGcrdjAxN0MwdTJSZzBmWk1PRXJr?=
 =?utf-8?B?V3IwdmVYWlFKMW1QQTNTbmIrSE1WdXJ3SGhtYXZjWUswM3BQR2dxTE95K2l2?=
 =?utf-8?B?RWFWOWJKRTQxS3BXVVhHcE1UZ1hHZ0xCV3RMTHJScVRRZ1kvSkw5dWNUUTI0?=
 =?utf-8?B?TVBxWFUwOGgrZUhCaE9jeW0vVWlhYVBqZHZsVGxMbktzTTRSdWFrWW1tZTlx?=
 =?utf-8?B?Q0p0anlsdlMrbjFnb0YxMThObjB0aG5TTEIvcFRvNFhDVWxQejI5L2kwTVJq?=
 =?utf-8?B?VlJqN3JJbnFYcEZqLzNnZzVMa0ZUWWgvb01sT0RrZnNKUHlTcFRDSlFLSVEr?=
 =?utf-8?B?WHV5aU5PSW9ISm54bTUrU0R0N1VDOXc0TVdOdEV6YTVZaDdwNVJiZk1YS2Qw?=
 =?utf-8?B?QUxaanBjcGlZMzdnL0lVY3ZwSU1WemxTYy9TR1U4RU5PQ0djTmRnUXE0QWJ6?=
 =?utf-8?B?S21kQkV6b1JQVUNJTFVzRGlQaTMxTWp0OGpZSjZGT1hYM0swdG80VXlwZitj?=
 =?utf-8?B?cnV5Y29ZWmxONmxtQWFLVUNvTHZ0Z2ttQUZTZXNwcmY0OU00SGFiS1dZN0tK?=
 =?utf-8?B?RW1iaFBVd05jS0JIZmp3N2JmdE14R1hWUy9GZWZVcFppM0ZkYjhkQ2wrekdB?=
 =?utf-8?B?aWl0YVlLQlFiRFB5d0N4QXRwY2d4RTN4K1JTa0RRQXdJUm1ad0ZMb3ZOT1pY?=
 =?utf-8?B?dW9Lai9kZW9JNTlkSjgzUFBZcVRVSFBhcU05QzlCNTVyT091MGtZdDQzd1pN?=
 =?utf-8?B?aVRuQkErTTBrdGtYekJHOXZ1L3QxRXE4TzB4eTZRdXVFQUFjZ2dLMTVzYlJI?=
 =?utf-8?B?MnQ0eGFFcUE5b1BlUjk3bnMvMUdYTkRubTN3YjcwdHpjWk8wV2dWbWMzUjEy?=
 =?utf-8?B?NnJtUjJnVllZcU55SDRhS01JL25BYmovUVNmSkZIZzJLWDNBcjdzRDFPb2Jl?=
 =?utf-8?B?dW9oUmU0R2loRzJSS3k3QVdRWkhsaXhSVTV1SHF5YWdEcUlCY29Db0dEVmJB?=
 =?utf-8?B?a1U5VGNtL3Ayek9aVFJOT0JlOFF5Qi9BY1pPd3kxRWVPbUpHdlloWVVqWGgy?=
 =?utf-8?B?TVV2NTJLVStGQXdBclJvZENYVmx4NjhMb0xBT01kL3F3S3NZQUVxM1pUV1FN?=
 =?utf-8?B?NDVmMi93R1ljT0RxbXVqZ3ZQdnpCa3pZSUlmTit6SnlFV1RsWDA1S1VJZ054?=
 =?utf-8?B?d3R6a3pGeDJUWlpkQ2hBaEZjWGZTZ2lacTB5MTY2M1k0K29VM2Y2a3g2V3ZX?=
 =?utf-8?B?ell4U2RuYU80NXFDUmV0bDc3SjZzWlNIZklETWZUVi9xbjFqT2RmeENxYjRt?=
 =?utf-8?B?WFFaUnV4dEFNeTU0Z2QwZXlrMzNqNUtIWEZjM2ZtaWJvcENSdHV2L0ZFRzRj?=
 =?utf-8?B?VkJkQUM0VHVNVzNLRXB6SUM4RVlNZy9lOFpjTVlYOFJwQUZhWDFTUzVudFVS?=
 =?utf-8?B?Z1pLUVlJQkd5UVV1a0RjdmNaZTVET3JIZGsxU2syZEdEbktqbnQ5RC8xdnZr?=
 =?utf-8?Q?UXNH3RWvMuItzxsUwI8X0t9NW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F6EC10AFEF56544BE55FC4027A9361C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd1ead8-c9b0-4577-253c-08daa659b8ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 22:42:30.8851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LoB52Uku3XiDD00GW+q2q96Xs/jn37p1zHQcptLM7sZtL6D1u8J73PSo1gJ2Ci7LoI9EnOHrhzlQdl4UORik/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6366
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTA1IGF0IDAxOjIxICswMzAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+IE9uIFR1ZSwgT2N0IDA0LCAyMDIyIGF0IDExOjA0OjI5QU0gKzEzMDAsIEthaSBIdWFuZyB3
cm90ZToNCj4gPiBJbiBzZ3hfc2V0dXBfZXBjX3NlY3Rpb24oKSwgeGFfc3RvcmVfcmFuZ2UoKSBp
cyBjYWxsZWQgdG8gc3RvcmUgRVBDDQo+ID4gcGFnZXMnIG93bmVyIHNlY3Rpb24gdG8gYW4gWGFy
cmF5IHVzaW5nIHBoeXNpY2FsIGFkZHJlc3NlcyBvZiB0aG9zZSBFUEMNCj4gPiBwYWdlcyBhcyBp
bmRleC4gIEN1cnJlbnRseSwgdGhlIHJldHVybiB2YWx1ZSBvZiB4YV9zdG9yZV9yYW5nZSgpIGlz
IG5vdA0KPiA+IGNoZWNrZWQsIGJ1dCBhY3R1YWxseSBpdCBjYW4gZmFpbCAoaS5lLiBkdWUgdG8g
LUVOT01FTSkuDQo+ID4gDQo+ID4gTm90IGNoZWNraW5nIHRoZSByZXR1cm4gdmFsdWUgb2YgeGFf
c3RvcmVfcmFuZ2UoKSB3b3VsZCByZXN1bHQgaW4gdGhlDQo+ID4gRVBDIHNlY3Rpb24gYmVpbmcg
dXNlZCBieSBTR1ggZHJpdmVyIChhbmQgS1ZNIFNHWCBndWVzdHMpLCBidXQgcGFydCBvcg0KPiA+
IGFsbCBvZiBpdHMgRVBDIHBhZ2VzIG5vdCBiZWluZyBoYW5kbGVkIGJ5IHRoZSBtZW1vcnkgZmFp
bHVyZSBoYW5kbGluZyBvZg0KPiA+IEVQQyBwYWdlLiAgU3VjaCBpbmNvbnNpc3RlbmN5IHNob3Vs
ZCBiZSBhdm9pZGVkLCBldmVuIGF0IHRoZSBjb3N0IHRoYXQNCj4gPiB0aGlzIHNlY3Rpb24gd29u
J3QgYmUgdXNlZCBieSB0aGUga2VybmVsLg0KPiA+IA0KPiA+IEFkZCB0aGUgbWlzc2luZyBjaGVj
ayBvZiB0aGUgcmV0dXJuIHZhbHVlIG9mIHhhX3N0b3JlX3JhbmdlKCksIGFuZCB3aGVuDQo+ID4g
aXQgZmFpbHMsIGNsZWFuIHVwIGFuZCBmYWlsIHRvIGluaXRpYWxpemUgdGhlIEVQQyBzZWN0aW9u
Lg0KPiA+IA0KPiA+IEZpeGVzOiA0MGUwZTc4NDNlMjMgKCJ4ODYvc2d4OiBBZGQgaW5mcmFzdHJ1
Y3R1cmUgdG8gaWRlbnRpZnkgU0dYIEVQQyBwYWdlcyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogS2Fp
IEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEphcmtrbyBT
YWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+DQo+IA0KPiBUaGlzIG5lZWRzOg0KPiANCj4gQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2NS4xNysNCj4gDQo+IERhdmUsIGNhbiB5b3UgcGlj
ayB0aGlzIGluZGVwZW5kZW50bHkgb2YgcmVzdCBvZiB0aGUgcGF0Y2ggc2V0DQo+ICh1bmxlc3Mg
b2ZjIHlvdSBoYXZlIGNoYW5nZSBzdWdnZXN0aW9ucyk/DQo+IA0KPiBCUiwgSmFya2tvDQoNClRo
YW5rcyBKYXJra28uICBJIHdpbGwgYWRkIHRoZSAiQ2Mgc3RhYmxlIiBwYXJ0IGlmIEkgbmVlZCB0
byBzZW5kIG91dCBhIG5ldw0KdmVyc2lvbi4NCiANCi0tIA0KVGhhbmtzLA0KLUthaQ0KDQoNCg==
