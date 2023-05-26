Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58C5711DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjEZCRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjEZCRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:17:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72866B2;
        Thu, 25 May 2023 19:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685067442; x=1716603442;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q99pQBk/8v+8khowXv5V2PggZM8TChJusRUnAxPrx6c=;
  b=KiG5W+1Q0MtSc9js5jF7SPUZaLRA95YOP1KKHmrLssKELPC4UKT1FAo6
   Hs3AZDVX7gI2urqYsb1ca3uP3bpV4k3DRvQux1F3ltaXzZDhyaOMAhMiB
   fFuR8BFXleoyC9Ke6rbRVZtpl3PrdAfgEKfnensgOBhUEYor8bPy/YXYD
   68VIjA9k0O8UNR3/O5dzi9VHgGf1JSkWWu0sMwD6RN4+Ka3gvzjh3XfEM
   Stabs9VHGpXfkzS1yDR8hpPaMmoehFt6oLbCNROZl+2B8UO8CMiMDPbJM
   Wjf5d67qvY+3yvFA5HfIIkEjS6fMKBFhziIU8+/FoCyWinvVY0fPuOEQi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="357343265"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="357343265"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 19:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="951708224"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="951708224"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 25 May 2023 19:17:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 19:17:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 19:17:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 25 May 2023 19:17:18 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 25 May 2023 19:17:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLgewLwJw0Dl8YP5mjtaC0UFtwiRwqKYGGB6GsdmgmnP8rK2FQLhVPVdUA6p3jFstZmtUxHcjdBy7doJCzSeS28cxR95mi5VBEtQQJQXhYWplO4odm9w/WJGjFV+LyX4DTKG3IPMVd/XBg/+yOIM1iDmcnf0WI1svctyPNnhYEn5s0zViAIaWls9d090Hlczl2eiCCCv3j+DhF10RMHYisAPEgKtum2kjVThQiR2WWLqQp8HUIYwAm+oTfp6dDsZyqFO2eylj7G7yqg8z8H8q1UzrqtjZOHY9KRfqnEhwYVmf9YY7baYZPY7XaWEuAOBepi298j9in5lLgUy30X1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q99pQBk/8v+8khowXv5V2PggZM8TChJusRUnAxPrx6c=;
 b=Vw0dUetU3UnKwoBk+G4s7uvas7mXvfXhbf8sEz0taOCSk00OiIHAhxJDvC7+QUus6XuBrDkD34DqsE6m0AWQR95rcMRpnhe+62eHiGdYz2qhesTQmAbbSXVCurG3pLh0ix4fC0XDX7pvnZR6W39BSDQ36vQMEyW1j6zJipgvaWWSSd+m+rVYv4/ZMo+WgQwGFHUvTZmXDUzxjJ7T0HzU+qC0ix6jqB568YYYOpFQ9qHUUd1oEYjjz07BFm6p/efmL5uSglwn6VZK31I9w2oGb2FpEhYi1kG9wa3UiyzVdFhDc8mrVGTDOyBUDZNOThnf+0b+xQYQh0LoAdLSKocifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW6PR11MB8339.namprd11.prod.outlook.com (2603:10b6:303:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Fri, 26 May
 2023 02:17:12 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3a8a:7ef7:fbaa:19e2]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3a8a:7ef7:fbaa:19e2%5]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 02:17:12 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "Cui, Dexuan" <decui@microsoft.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/mm: Allow guest.enc_status_change_prepare() to
 fail
Thread-Topic: [PATCH 1/2] x86/mm: Allow guest.enc_status_change_prepare() to
 fail
Thread-Index: AQHZj1ysggfKgu/okkaLKsgUiUNNcq9r0aKA
Date:   Fri, 26 May 2023 02:17:12 +0000
Message-ID: <7e243a32436c1ef68f0fb191c098ba9b3fad30d1.camel@intel.com>
References: <20230525225847.28592-1-kirill.shutemov@linux.intel.com>
         <20230525225847.28592-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230525225847.28592-2-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW6PR11MB8339:EE_
x-ms-office365-filtering-correlation-id: ebe76d3a-f199-4c20-c489-08db5d8f5134
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KuEMtbRdYucm00fEnkjiw+mFFp6hKiD9MMjhIHqIGxfMLygzqYZdSAhk4Wayw+Q08Y8VUTqzSYWgw1d/5Dn4ldkOYQ9D7yTYX7UlUTMh+k1ZVbk3kgvhsGpM8p8suRf3qlFtoQjhy/VaecpTV9AL/X1o+6QCQabDknwtUaLCBMxefE+MvPD2gGQ9yj7kx/X+5rgOFTbtmNTn1Uk1IMxdN4kjxfpdMa+1QLlk2vfXGJ8n0qWAIWIAieZPP8eEEWFEylmIvBy5VJVLKPFOtI616FxgmkEbY08eyzu3CFIjnnaBMNwVxY7lX4PhGym1gGE0WJZI7xrSVG8YUBINSkOIAiB2xnN+hQZMVb+huBQlRmO/c/qpnQ/SrW6j3ZBndZLPWFiLaDyPfjhb1Eh73NYrTzspuQY4DwIBi/9lp1TFvqTmBtXyr+okUQgfiY/qmlQykPsD7WIN2oBuSVknyAKH7Zytz2By/lLFBH38Q/rzlOs4oWZSbVtXmxilcI9DVLKOAkepXJM556YUz3FXb/H4SA9mFUojixKhw95wA1qXBrQbD3iritZ/Wf96tUtZOzG55ip+5hGByFb6ceJtrguXvFghWOh2uN/5FneqEl2O9cUuGc+CPuNXdEsUjaIUJ1a6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(7416002)(6512007)(6506007)(8936002)(41300700001)(8676002)(186003)(26005)(2616005)(86362001)(4326008)(36756003)(2906002)(66476007)(66556008)(66946007)(64756008)(91956017)(110136005)(54906003)(316002)(76116006)(38070700005)(83380400001)(5660300002)(38100700002)(6486002)(71200400001)(122000001)(478600001)(82960400001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE9kZEpsbWRXSXlZWXdESVZOMnVDbXovQTBpZUtKcXlSUlBRSC9WNlN6R1JK?=
 =?utf-8?B?VjUxUStLeEhJZ2F2cjR5N29iRmJOdXA1ckV1Sm8rRHdnckxDSUlKQXVGK2xv?=
 =?utf-8?B?SmdML3djQ1ZKU0ZoMmx2bkE1VDl3REIvQkYrVFJPenpHU3dnZUxYeFVCbFBM?=
 =?utf-8?B?K3U0ODYzeHZUOU8wSDZkYUZxZjM2N3YrM0g5VTIwUTVyZGhBQ24vODM5ZUto?=
 =?utf-8?B?UUdWVGxia1hFUzVmQm5VSjhxeG1JU294SHBIM0l0WXJpZzk2ZFZ4a0tXbE9r?=
 =?utf-8?B?TmE3L2IzVHFHNjFRNkFxR2hjaUdZZ2VJb0RJdkpsdWdaZUVNQmJhd1NvSEY5?=
 =?utf-8?B?VVlKSUpGdzZkR1lUQ2hWMTJKMm95S0NzS0dJL3VHNjJuNFEwZHR2UlFMZVMr?=
 =?utf-8?B?Z0hDSHpSajR1Nll6M0lTOEQzSnJ2dmdzWGlnWVcySytpaFppZGY4TzdadVZT?=
 =?utf-8?B?V3YzWityeFlKdW5GT2pBYkNMRGJKYi9EVlE1UXM0UUg2cTMxMnYrOGlYVE81?=
 =?utf-8?B?dU04UHJjVlJqKzlyMW5qelFZb2VDVWJvd1BOQWdwbThlMkZRNnlaVGVHbUpE?=
 =?utf-8?B?c1VlUHdKdG5TN1VIR2hlYmMwakwzcUFNQ0s4SHc0cnVwMHVNdUsxUEJna2RR?=
 =?utf-8?B?bTVhMHRFYVhUNTJrTHc2bmxUd0srYXdHVERjRHV5bFpwUkRSb0h5SFlQd3Ay?=
 =?utf-8?B?WWxPZnMvYm5UbWRnR0FGUU9YZXBVbHMvUUFlck01UFIxeXlicEl3Qi9DeGxW?=
 =?utf-8?B?dmFVVTdEOHI5THF5YmhvQnQrZ0FRQjRPMWV6OWlnSkRCQzViS0JiQlFLN3ZF?=
 =?utf-8?B?MjVSMGdsSEpoYUhCMk1NUm5kU2JlRU53cVFET2lhZEpLSHBOZjVpdlcvZDMv?=
 =?utf-8?B?NlkxQWpPQUNGU2pqR1hHSkNvYms3MTZ1d3BZcGtvR3dFTEM2RkJIclJvZFpU?=
 =?utf-8?B?dXQ4Z0poS2dtSjJyZnIvVFM2YkhINGU4dFhyR05RY0VTTm9lcWw2czMrTTNp?=
 =?utf-8?B?UnJ2RjdndklZQkRwQ21QbUgzZEJVMnV5eXF5TmhpSGZiYmxRTjYxNFlwTFNG?=
 =?utf-8?B?SkdTV1o5dlRDNzJmZWYxdXlGeDJXVnZPUHZPcXA5RnROKzEzWEJnaDZZTEQr?=
 =?utf-8?B?bjhiaDdKaGVsZ29GWitvRHNUMGY3WFNpU1daeUswL2hnTzA4SU4reUxlSk9J?=
 =?utf-8?B?eWx2UDdmQVB5UnRsWlpFSmRnSXJLR3RSdFhGWGNjUE4rMjhUOWRBczZ1TlUr?=
 =?utf-8?B?UnduYWhKQk8rL2srSkZkUGNHcFRCVDFzYmNhRW9hc3NFdmdoUEhQSTZiR1Rz?=
 =?utf-8?B?YXRnZmx2ckd2emlhaERneUxFdU9oM1BIV0xUV3g0RVh1SmYrVkdpRnpjVGhV?=
 =?utf-8?B?NHFmbitNTjFlQThQWkpyK2k0Sk05Q1I4QjVlTHdYdTNtKzdtdWVhWDlDWUkz?=
 =?utf-8?B?amYvZFhnWEh5OTNlbHZ3bGR3YXFhTnVCNjY4TGR5NmkyalR4WWFpQjNJbHlh?=
 =?utf-8?B?VSsxQTRTQy9tYVZUVU9FYnp5VCtjS0kzNy9vNWdsQzZSbC95aWJldVVnODN2?=
 =?utf-8?B?NHdvQWRlcitjZmdyTWlKZmdsSmtjL3VLTnpIZ04wZnNPMElmOUI4ZzA2Vms2?=
 =?utf-8?B?TWR5V2V0dHhrTU9XZm5RSFFyRnQxREtQZGNaRnFmTE5ZS1J2NHNZSHFVNm9z?=
 =?utf-8?B?RlExUEFnUDNXOEgrKzY1cDY4ekFEbEIxNFJyRzUrL3hGR3NtS1g4RkxYV2Y5?=
 =?utf-8?B?Y1pQZGdsQW1vQkZsSlF0NnZnWDEvUmNjVndQZDJsbTN6cUluSjNEUGxBSjRa?=
 =?utf-8?B?TVd2RGI2NkgzMW5zM1haeVpReU1ISTRZYTBnVUZuNlVxVjVFbkc2S0FZL3pm?=
 =?utf-8?B?K2J4OTFwTkdEYURic1htdnFpTGRMQkg2YUlOdzg0bWZKQkpza01nTysvSzZX?=
 =?utf-8?B?Syt5UkhSVjdvL2tkN3JrSWNQR29mWDlMQVJkV3hvWXpuSUI5d3RZMHE5QlJy?=
 =?utf-8?B?K2VqNUx5bFIxL3NaRFlKci9ENFNKL2p6MUxkSUNpMkRDdVFGMmsyclNadnJm?=
 =?utf-8?B?ajBhbm5GZHVTQ1lGaEMzRXNZUHp0QkRhSUJCK3lzQzBUd1E0WlY4dkRsM0hE?=
 =?utf-8?Q?m4fcqqDO/0ayJO5EPkktVr9qq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A310AC6B5455142ADC3BEDC214215A2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe76d3a-f199-4c20-c489-08db5d8f5134
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 02:17:12.6996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FQSMvj4d5Dd7xXmYll+a/VsB0wXP84xF0Tpca8KDOGp2IapurvcMmEp1MmxTD63go42D6s6CrKWe3y92UCzCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8339
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA1LTI2IGF0IDAxOjU4ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFREWCBjb2RlIGlzIGdvaW5nIHRvIHByb3ZpZGUgZ3Vlc3QuZW5jX3N0YXR1c19jaGFu
Z2VfcHJlcGFyZSgpIHRoYXQgaXMNCj4gYWJsZSB0byBmYWlsLg0KPiANCj4gQWRkIGEgd2F5IHRv
IHJldHVybiBhbiBlcnJvciBmcm9tIHRoZSBjYWxsYmFjay4NCj4gDQo+IFdoaWxlIHRoZXJlLCBm
aXggZW5jX3N0YXR1c19jaGFuZ2VfZmluaXNoX25vb3AoKS4gSXQgaXMgZGVmaW5lZCBhcw0KPiBh
bHdheXMtZmFpbCBub3cgd2hpY2ggZG9lc24ndCBtYWtlIHNlbnNlIGZvciBub29wLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tPg0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gIGFyY2gv
eDg2L2luY2x1ZGUvYXNtL3g4Nl9pbml0LmggfCAyICstDQo+ICBhcmNoL3g4Ni9rZXJuZWwveDg2
X2luaXQuYyAgICAgIHwgNCArKy0tDQo+ICBhcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdF9hbWQuYyAg
IHwgNCArKystDQo+ICBhcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jICAgIHwgMyArKy0NCj4g
IDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3g4Nl9pbml0LmggYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS94ODZfaW5pdC5oDQo+IGluZGV4IDg4MDg1ZjM2OWZmNi4uMWNhOTcwMTkxN2M1
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS94ODZfaW5pdC5oDQo+ICsrKyBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL3g4Nl9pbml0LmgNCj4gQEAgLTE1MCw3ICsxNTAsNyBAQCBz
dHJ1Y3QgeDg2X2luaXRfYWNwaSB7DQo+ICAgKiBAZW5jX2NhY2hlX2ZsdXNoX3JlcXVpcmVkCVJl
dHVybnMgdHJ1ZSBpZiBhIGNhY2hlIGZsdXNoIGlzIG5lZWRlZCBiZWZvcmUgY2hhbmdpbmcgcGFn
ZSBlbmNyeXB0aW9uIHN0YXR1cw0KPiAgICovDQo+ICBzdHJ1Y3QgeDg2X2d1ZXN0IHsNCj4gLQl2
b2lkICgqZW5jX3N0YXR1c19jaGFuZ2VfcHJlcGFyZSkodW5zaWduZWQgbG9uZyB2YWRkciwgaW50
IG5wYWdlcywgYm9vbCBlbmMpOw0KPiArCWJvb2wgKCplbmNfc3RhdHVzX2NoYW5nZV9wcmVwYXJl
KSh1bnNpZ25lZCBsb25nIHZhZGRyLCBpbnQgbnBhZ2VzLCBib29sIGVuYyk7DQo+IA0KDQpbLi4u
XQ0KDQo+IEBAIC0yMTUxLDcgKzIxNTEsOCBAQCBzdGF0aWMgaW50IF9fc2V0X21lbW9yeV9lbmNf
cGd0YWJsZSh1bnNpZ25lZCBsb25nIGFkZHIsIGludCBudW1wYWdlcywgYm9vbCBlbmMpDQo+ICAJ
CWNwYV9mbHVzaCgmY3BhLCB4ODZfcGxhdGZvcm0uZ3Vlc3QuZW5jX2NhY2hlX2ZsdXNoX3JlcXVp
cmVkKCkpOw0KPiAgDQo+ICAJLyogTm90aWZ5IGh5cGVydmlzb3IgdGhhdCB3ZSBhcmUgYWJvdXQg
dG8gc2V0L2NsciBlbmNyeXB0aW9uIGF0dHJpYnV0ZS4gKi8NCj4gLQl4ODZfcGxhdGZvcm0uZ3Vl
c3QuZW5jX3N0YXR1c19jaGFuZ2VfcHJlcGFyZShhZGRyLCBudW1wYWdlcywgZW5jKTsNCj4gKwlp
ZiAoIXg4Nl9wbGF0Zm9ybS5ndWVzdC5lbmNfc3RhdHVzX2NoYW5nZV9wcmVwYXJlKGFkZHIsIG51
bXBhZ2VzLCBlbmMpKQ0KPiArCQlyZXR1cm4gLUVJTzsNCg0KVGhlIG5hbWUgImVuY19zdGF0dXNf
Y2hhbmdlX3ByZXBhcmUoKSIgc291bmRzIGxpa2UgYW4gYWN0aW9uLCBidXQgbm90IHNvbWUNCnRy
dWUvZmFsc2UgY29uZGl0aW9uIGNoZWNrLiAgSSB0aGluayBpdCdzIG1vcmUgcmVhc29uYWJsZSB0
byBtYWtlIGl0IHJldHVybg0KJ2ludCcsIGFuZCByZXR1cm5pbmcgMCBtZWFucyBzdWNjZXNzZnVs
Pw0KDQo=
