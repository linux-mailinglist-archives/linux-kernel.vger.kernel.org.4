Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F3B6AE767
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCGQzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCGQzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:55:23 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F2690B4F;
        Tue,  7 Mar 2023 08:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678207877; x=1709743877;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n2OmKQJ3qQ9Ig/MF+dOMO5Oh1LknP7oKDKwYtZcSWOA=;
  b=QNg9+Cg/K44e/n2BfTHzUrNQM4XwNTW7NZIV2P9uu0P2IkcDncwstB/x
   zpuJXTDZU4z4qm4vDcwfaO46sGOPvq1OyW1mhWUMRHaz6HkxawfpFZvxy
   prR+h45HNvrAuYplmKaoecx6FdGohO3HpVNjnefRqe6OzpwsdA3f3cNdF
   cOex7En4tc3toHRH9sdpyHGfWZVetIbwi3r9S0dj0K5iD/Nr4FjbaFheL
   P1nT8xRYogu+evrdMRrbtVoZl9fOf54MI5WcScky4RsdjYqqlX9JErlKC
   Wf5KODpTkJ21L7d3XgfPRBYYvAY0VsP5ZRRxraAnLX0wNJTU2WvZBiqyt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="334615773"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="334615773"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 08:51:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="819816012"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="819816012"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2023 08:51:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 08:51:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 08:51:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 08:51:04 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 08:51:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICIqj1qCWP9ZKFZIvg9kmKERsyfRDSQhlIgJzQD4CLehZsPUXjMqWxb6O3+ggyAGvDmLkgJTKgiEbMmVSfctA0yx1CtARCrjn9atiRVJX5JQQi3WjML0IokUzqnmRAnV5UyM44dKzFA05Jo9nfTcBrwMPCmy5waOV/QPE85LSHplXRZws1LSEehBJ+YJPwqW4wx/jHVlzsIouCmqNZ5Yq0klaZO8bBQ4XbNNI60UrrJ8htD3FAolXUm8GfskM1fFW4UDOOwJgbh1GHIA471/cSBrZ1oKRlo3pr2+cTM2BrdfQGD+f1RkjPWl42aPhKEK57umntW96pX7d677jdAu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2OmKQJ3qQ9Ig/MF+dOMO5Oh1LknP7oKDKwYtZcSWOA=;
 b=aQvVuXkTGG1lWzOR/ieoaMTEgixqTuxxSQifMukkD9A47vHWP6dpNb60BPm7GfuKSQTgZYKuZFJFUGn40N4BJomo1C1pwvuSkjZ97ybOHxar/uD9qm68SwV594KEKzxaHMx9DncV5Pqdcz0Ty7VSCSx1yc8RbGUzyPGZ6enPFXXiGdVxiPUjxDY2tViY6rV2cb3KVcRw/x9veQ4w/ZrFwDt5ANiaTLPl/u3NeeMWTnxKVoDoaeDxUfiOjtX12McVuAuflzrbcymClJzVbEkoTSvRBxRBzFiH7iOAYLW5CRoQhxAXc8t5jgEsuAQ2wHFeWfPHqYUW1rMFSlkuiNRobQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by DM4PR11MB5437.namprd11.prod.outlook.com (2603:10b6:5:398::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 16:51:02 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6134.024; Tue, 7 Mar 2023
 16:51:02 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] ACPI: processor: Reorder
 acpi_processor_driver_init()
Thread-Topic: [PATCH v1 1/4] ACPI: processor: Reorder
 acpi_processor_driver_init()
Thread-Index: AQHZTgXV++ts3wGoK0aUxKpjfYeUSq7vjfEA
Date:   Tue, 7 Mar 2023 16:51:02 +0000
Message-ID: <bdafdb137ec992cee592606bc025f8f3e2cf3677.camel@intel.com>
References: <2148907.irdbgypaU6@kreacher> <2885079.e9J7NaK4W3@kreacher>
In-Reply-To: <2885079.e9J7NaK4W3@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|DM4PR11MB5437:EE_
x-ms-office365-filtering-correlation-id: d48ef8f8-6329-421f-dc20-08db1f2c22b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A6+ZTYWzMA8nhrSGVGOrwPcKFTNUN5zHS88I2PmYY4impxb2bol+IxD3qEhlakuYtUvDKQWK+4UZ3ss8Uyd3/GfDyOVDo1WHoZ0FF9Mb82g9yZ+sMQzELRgTRl/c6sIqHyDnWWXrHEXZ97XqFXYVNWgzL/afQ85FB13ZXi1+ulDpGOZlhfNxWIspl3XVQD2rdvVmPEBPRlFltCa+Xi3QtbVzhfbWzEqjGZj1imh1ILUuT1vbIvqaJ4i3Z6QoqBcQongGPyC5Ly+lS7djasPwe1/npkqoFtQhiBVRLj8d3Ekh0Avbjssbk/dRsfsR5BGO2BY8orctEJ1zy53Mc+iwk72ySKnfAXQN9xGbQmjfSEPJ+pv/tzvs3ItL+C3KXofvHWWwwfTzbO+pwIEm8fnE3mwlQBmzpi238/mYPaWniy2jg6FTH3U/OJPD2dfnsslIhJjUPhwWGpTVQuJgCckFu+3kb3NeYms2J9ugq5yPBrwyQqbcSjycUXQjdIHQ6DhmQ6cNs3SewdqqIpiD7tU/Or9pSOCqSNYN1yLQdIcfUKn/6CBcoxVqtybnAmZPFL/BuxGvZycDRfolMmoFyJkvirc03uRs0lkiZIJ0Kpvp5KY7dP7JjQK6+0nt6ICD0B5JSFxNt2rvQJx1v6iuKDCThx4wbV5IOdm8qTIRwPwg03LQo/3VS+z4hQm6nK9STrVYaX4UqHIaR2itpaQiLmggBGyfC5OEj/T/w5UBWMY8RhZCyh4B6uf9hF+emMYIkLuu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199018)(64756008)(36756003)(4326008)(66946007)(76116006)(66446008)(41300700001)(8676002)(8936002)(66476007)(6506007)(5660300002)(2906002)(122000001)(82960400001)(86362001)(38100700002)(38070700005)(66556008)(6486002)(71200400001)(26005)(966005)(478600001)(54906003)(6512007)(91956017)(316002)(84970400001)(110136005)(83380400001)(2616005)(186003)(87944009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFNEb3ZzcWRXV0dhRUlIdTYzQ1VITXBYODU2YWFxcHdIK3VaQTBnQlRCbkFE?=
 =?utf-8?B?TlBiYmVBOFhKNjZpYWZXenFpTE9KNlNoa1FnSW8rVWhoVG91bzRDZmpDSy9U?=
 =?utf-8?B?eHUzTGl6YUxYK2M3L3ZaYWR1djByNlZmWFJWUldvNnFXdmNYR1JmM3NTQ2pi?=
 =?utf-8?B?TGE4dG1aV2VqNnJjSGZRYkZNSlB6RkVwTTkrNmRSTDNNZTVFSHRKWkRKNERZ?=
 =?utf-8?B?S2ROMkF4Y0lGU2oyVkF6S0NhY1ovTHF2WlhHQ3V2QmlpMnFWQlNKNWd2R2RQ?=
 =?utf-8?B?NVFVdVkwaTJldjBudVpDSkZzMW0rOWZ6VFVSMHdrc3UwU3g4ckVKeFNyOWFX?=
 =?utf-8?B?MmZ3ZHJOMXM4WGNUTldFcHFhTWxocDZZN21oazVoNmJJTUZQdDZlbHF0cjdZ?=
 =?utf-8?B?ZFYwRGkxb0N1SkRPNFFmQ2pMTk9TNkFuVmt1M1ZERkZUa0J0NzlNcFJJY3Nx?=
 =?utf-8?B?RkYybEFOOHA0VGtjNmQxZUtmTzdyM045ODVvbFoyRURnUzJiSlcvZjVTbmI2?=
 =?utf-8?B?eGdBbUdBMUdGYVFmTWwrcFhvd3BJN3lTZjJiUndRZUFQTUt5WnViT0NKRjNX?=
 =?utf-8?B?bkxPTGRES3dhS1liMnBWdTJlcnRqMFpxNlJqb1ROangydTh1bTVYdlg3T2tX?=
 =?utf-8?B?UHpndVhHOEM2QnRzVVFzSkMvemN6ZGxzTEJmMnVMQlBseVppckZCY2laN0pm?=
 =?utf-8?B?TjJHTk9NQ3VDUEs4MTBhN3ZCT3BwQ3FnQmplUGYrRWxtU0twaVRDeUZWTXN1?=
 =?utf-8?B?dHNLdm9WN1J0ZzZlYWhVL09uanBheWhaZHZ0aWNhSm5adWtwZFdzY3VaUjdH?=
 =?utf-8?B?aXZ3MnNpaTdQT2lXQTBjYllrTEZ0dzJKUW1BNSttcXNNM3NmM1ZyMWhnd0U2?=
 =?utf-8?B?WmpUcjMxeGRQUEZUMjcwaGtiYmIzYjhENDlTZDJ3VW1IT0Rtd0hIdVFHbWpI?=
 =?utf-8?B?VDBHeTg4VlRxVmNvTG5JNDdMa1UyeDRKdC96OEpjSXdkTzcvc21BNWh6RDl3?=
 =?utf-8?B?VktETk1Nc0NKQkovWDQ0YzA3eWFrSzBYcTlWdXY5Y1RWdHZnOCtkbllUdGNE?=
 =?utf-8?B?ZTdzZzQ2bU1MQmRkR1dzcmc3T2lkb0I4SWpvNmhDUUJHc2hTcFlOOE4rMEdi?=
 =?utf-8?B?SE9hNXQyUXF5emowWElhSlZkenRETnJrOWZnY2Z6eUhwTFNtb1YycE9sSXQy?=
 =?utf-8?B?aGwxQ2gzT0QrYjFGZ1hPYkRBa2pKUmdQaVZobGtWWk5weUM2ZFpkQWdOdGZV?=
 =?utf-8?B?WHgzRkhLeFJRM1hKQSt3L3E2bXo2ejBIbDFxaVRTakF0TDdDTmlnMFZGdEZN?=
 =?utf-8?B?WEpJYVdDT0hTU2dsZW5XZ1VPODJVeDg2VVBHN2l2SDJ1SFY4UmRtRFVKR1BV?=
 =?utf-8?B?U2hxcFpNbmdzODhRa1FXQVk2eGUwMUNSOUl3bDNVL21xWjl1RVBvQS9PTFlu?=
 =?utf-8?B?V3JWV3VobjNiZWtuRUV5eHM5bXpEbWMrL1YxbEtwTmhKY2tnSG1NQWw0LzhC?=
 =?utf-8?B?NkJuV2d3bjFIT080SzZlWUFkSHo3QVlOUDhtYjRVaGlPTCtncCt2QWtBWDJK?=
 =?utf-8?B?UHFTT0tkVHRDK2lFM3daWnNXNnNjTyt0T0hFMWZPL3M1bTlGVDdZNkNjemVB?=
 =?utf-8?B?WTBSSURVSHdJdmd4dWRSYmZzTUkwT1haclI3WS9wVTRKQ3Z1ek5yN05ubkkw?=
 =?utf-8?B?QXMyOXBMTTdpdXRiS3JvS2U2R0ZsbCt2VkhvZWJpNm1UVEFqOFYwVG9rMGdL?=
 =?utf-8?B?Q2Jld3VmN3hUeFMvM3pORjlOWGJPbU1WZDZ3K2xuUExST2h5WHpFaHBFR3Vi?=
 =?utf-8?B?UjJBMTM3V2k3aThBQjNreTNNYno3NmRwTElPR0ZpRmx0OTZvdHMxUWFOWnBo?=
 =?utf-8?B?K3M2WERuazJaSnc3RER1VGtTYWVSUVJrSWRldG5RbUdYWC8rS2JmYVhtQ1lo?=
 =?utf-8?B?TGtQQitFc1FBQUJXNU13UWdDY1dEeEkwQ1ZhWGp0empYemhJM2FsZzluZ0lV?=
 =?utf-8?B?ZHkzNE5WNldyOFVFZnJwQ0l3K1ZxNC9CTzdIdUlnT1Vra1NWaUFUNEM1dU1X?=
 =?utf-8?B?MEhTYk1tcEVjUG1SZEtFOVhzdi95RWFhM2tEeHNyNERvSkRWWUJ4aUVVWTRp?=
 =?utf-8?B?c25QMWRiaXhhUndEMy9EMUFsMGFZejM2OEtkeWl4bUppd3B1NFMwN1NwMDBy?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEB7433E3F92A949B3B36F775D40362A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48ef8f8-6329-421f-dc20-08db1f2c22b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 16:51:02.4085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tey+B1hC9on/b/QIF9Mkrnsp5eU2S1hpUW2jQ35jJCyvcBLbaDSqYCLG5phOTmEOrmJyd5HSe8NhjppGVV3oWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5437
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTAzIGF0IDIwOjE5ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gVGhlIGNwdWZyZXEgcG9saWN5IG5vdGlmaWVyIGluIHRoZSBBQ1BJIHByb2Nlc3Nv
ciBkcml2ZXIgbWF5IGFzDQo+IHdlbGwgYmUgcmVnaXN0ZXJlZCBiZWZvcmUgdGhlIGRyaXZlciBp
dHNlbGYsIHdoaWNoIGNhdXNlcw0KPiBhY3BpX3Byb2Nlc3Nvcl9jcHVmcmVxX2luaXQgdG8gYmUg
dHJ1ZSAodW5sZXNzIHRoZSBub3RpZmllcg0KPiByZWdpc3RyYXRpb24gZmFpbHMsIHdoaWNoIGlz
IHVubGlrZWx5IGF0IHRoYXQgcG9pbnQpIHdoZW4gdGhlDQo+IEFDUEkgQ1BVIHRoZXJtYWwgY29v
bGluZyBkZXZpY2VzIGFyZSByZWdpc3RlcmVkLCBzbyB0aGUNCj4gcHJvY2Vzc29yX2dldF9tYXhf
c3RhdGUoKSByZXN1bHQgZG9lcyBub3QgY2hhbmdlIHdoaWxlDQo+IGFjcGlfcHJvY2Vzc29yX2Ry
aXZlcl9pbml0KCkgaXMgcnVubmluZy4NCj4gDQo+IENoYW5nZSB0aGUgb3JkZXJpbmcgaW4gYWNw
aV9wcm9jZXNzb3JfZHJpdmVyX2luaXQoKSBhY2NvcmRpbmdseQ0KPiB0byBwcmV2ZW50IHRoZSBt
YXhfc3RhdGUgdmFsdWUgZnJvbSByZW1haW5pbmcgMCBwZXJtYW5lbnRseSBmb3IgYWxsDQo+IEFD
UEkgQ1BVIGNvb2xpbmcgZGV2aWNlcy4NCj4gDQo+IEZpeGVzOiBhMzY1MTA1YzY4NWMoInRoZXJt
YWw6IHN5c2ZzOiBSZXVzZSBjZGV2LT5tYXhfc3RhdGUiKQ0KPiBSZXBvcnRlZC1ieTogV2FuZywg
UXVhbnhpYW4gPHF1YW54aWFuLndhbmdAaW50ZWwuY29tPg0KPiBMaW5rOiANCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtcG0vNTNlYzFmMDZmNjFjOTg0MTAwODY4OTI2ZjI4MjY0N2U1
N2VjZmIyZC5jYW1lbEBpbnRlbC5jb20vDQo+IFNpZ25lZC1vZmYtYnk6IFJhZmFlbCBKLiBXeXNv
Y2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2FjcGkv
cHJvY2Vzc29yX2RyaXZlci5jIHwgICAxMiArKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBJbmRleDogbGludXgtcG0v
ZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9kcml2ZXIuYw0KPiA9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IC0tLSBsaW51
eC1wbS5vcmlnL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfZHJpdmVyLmMNCj4gKysrIGxpbnV4LXBt
L2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfZHJpdmVyLmMNCj4gQEAgLTI2Myw2ICsyNjMsMTIgQEAg
c3RhdGljIGludCBfX2luaXQgYWNwaV9wcm9jZXNzb3JfZHJpdmVyXw0KPiAgCWlmIChhY3BpX2Rp
c2FibGVkKQ0KPiAgCQlyZXR1cm4gMDsNCj4gIA0KPiArCWlmICghY3B1ZnJlcV9yZWdpc3Rlcl9u
b3RpZmllcigmYWNwaV9wcm9jZXNzb3Jfbm90aWZpZXJfYmxvY2ssDQo+ICsJCQkJICAgICAgIENQ
VUZSRVFfUE9MSUNZX05PVElGSUVSKSkgew0KPiArCQlhY3BpX3Byb2Nlc3Nvcl9jcHVmcmVxX2lu
aXQgPSB0cnVlOw0KPiArCQlhY3BpX3Byb2Nlc3Nvcl9pZ25vcmVfcHBjX2luaXQoKTsNCj4gKwl9
DQo+ICsNCj4gIAlyZXN1bHQgPSBkcml2ZXJfcmVnaXN0ZXIoJmFjcGlfcHJvY2Vzc29yX2RyaXZl
cik7DQo+ICAJaWYgKHJlc3VsdCA8IDApDQo+ICAJCXJldHVybiByZXN1bHQ7DQo+IEBAIC0yNzYs
MTIgKzI4Miw2IEBAIHN0YXRpYyBpbnQgX19pbml0IGFjcGlfcHJvY2Vzc29yX2RyaXZlcl8NCj4g
IAljcHVocF9zZXR1cF9zdGF0ZV9ub2NhbGxzKENQVUhQX0FDUElfQ1BVRFJWX0RFQUQsICJhY3Bp
L2NwdS0NCj4gZHJ2OmRlYWQiLA0KPiAgCQkJCSAgTlVMTCwgYWNwaV9zb2Z0X2NwdV9kZWFkKTsN
Cj4gIA0KPiAtCWlmICghY3B1ZnJlcV9yZWdpc3Rlcl9ub3RpZmllcigmYWNwaV9wcm9jZXNzb3Jf
bm90aWZpZXJfYmxvY2ssDQo+IC0JCQkJICAgICAgIENQVUZSRVFfUE9MSUNZX05PVElGSUVSKSkg
ew0KPiAtCQlhY3BpX3Byb2Nlc3Nvcl9jcHVmcmVxX2luaXQgPSB0cnVlOw0KPiAtCQlhY3BpX3By
b2Nlc3Nvcl9pZ25vcmVfcHBjX2luaXQoKTsNCj4gLQl9DQo+IC0NCj4gIAlhY3BpX3Byb2Nlc3Nv
cl90aHJvdHRsaW5nX2luaXQoKTsNCj4gIAlyZXR1cm4gMDsNCj4gIGVycjoNCj4gDQpKdXN0IEZZ
SS4NCkkgbmVlZCBzb21lIHRpbWUgdG8gcmFtcCB1cCBvbiB0aGUgb3JkZXJpbmcgaGVyZSB0byBk
b3VibGUgY29uZmlybSB0aGlzDQpkb2VzIG5vdCBicmVhayBhbnkgZGVwZW5kZW5jeSwgdG9vIG1h
bnkgdGhpbmdzIGFyZSBpbnZvbHZlZCBoZXJlIDpwLg0KDQpJIHdpbGwgdGVzdCB0aGUgd2hvbGUg
cGF0Y2ggc2VyaWVzIGxhdGVyIHRoaXMgd2Vlay4NCg0KdGhhbmtzLA0KcnVpDQo=
