Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A962D5FBB29
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJKTJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJKTJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:09:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCF590804
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665515338; x=1697051338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=74VBaFRNxWzHwyfX80LAQvS03+nwOQ9rO48H+Xs9II8=;
  b=dwgi5LUh5zpINVimrjD5nf4TcIN+aRCMaAcutBBiEfsklM9CwDBtWjrc
   SYElvsaOrl5ZUQEgYZ084PJbuFlL9MOkvR+6ldR0qR1TX1N2kVb+SVd5R
   CvVnSHtc5NkGS1xS866eEVo9vdCVnSj/dsboGkLNjZnI4jEdm/h8tn+DP
   ug47gO5BdWxeEn++1jjGYr34oSVvArLAZYfVmF3rzjOFtgpZWK7wou7kS
   EOTP2/BW7hPyYxPpwpzI5rf9fzS8lLbfJxedAfAjBj0LM/1tysZjPKsv0
   WXcZfHCS9zNqBjjUBYh87W8uizaNR7z8eqZ2t1gWSOD8G9mGmtqTDKotk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="304589445"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="304589445"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 12:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="751848700"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="751848700"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2022 12:08:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 12:08:57 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 12:08:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 12:08:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 12:08:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyAdHE44dGu5D5Ns8b3tcqjbsW/gSfAVNCP9DecIhCdSIQTDcVT+2S3yGPBdCZIr07amjEO5wioqxrebe8ojZfoxgxkqMOXDjc1lJGFizvul1kQgP4DX03ZhJahxYnvBhvZeH830qKqRKO+rfbQTOZVtn6RSGiXAOpgFZZY3OzIUO2CeWUwYpaFuQiym0JHnDPZXkfjwS7BFTocE6rEFLfJ1z+4f/vLAuwdkkBJ0XsdKHwoxenGg/pHc1LJYw3RBlLj92GS7JdUssX0o0VUT19E1wzboQ7ZRunwkVMpCTwHxmn2WAHneQMBNTpTgLk/Bmc4JtWx+su0qcRxL/Lz2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74VBaFRNxWzHwyfX80LAQvS03+nwOQ9rO48H+Xs9II8=;
 b=iDm07naOaR3xR2w/yymF9KplDyXGzvcgcJRU2Cb/fSMPSn4koN0ArsIOkg3I8v2/qEwkJ5/dqNldMaC3B52W7cx3TxfZ/f1b0Tck9AuS+/exDpaTlZqs1zXkBdAV3yvhPU+fV0i94GHITKC+hPCEuVFYLzl+spGJ1qhsYQ/oJPKmbEwPgSe3YTrSC4s1pQOZIBxUL0jFpbhelqDUxQbjwWHxspvjiaZzi+BVvAjmWpZZWjYOCjHYacMKrWTYVlBmrywPwO4VIiAOZK1qgGG1pKOAEi1qevD/QbfxmInq7bT+ArLSUA/exA22dBnMqlBjIUn3tTgAN6eqdSSMyAZx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6432.namprd11.prod.outlook.com (2603:10b6:8:ba::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.20; Tue, 11 Oct 2022 19:08:51 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%5]) with mapi id 15.20.5612.022; Tue, 11 Oct 2022
 19:08:51 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Daniel Verkamp <dverkamp@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: RE: [PATCH] x86: also disable FSRM if ERMS is disabled
Thread-Topic: [PATCH] x86: also disable FSRM if ERMS is disabled
Thread-Index: AQHYzufCn81lK4uiX0SZXRx4bJPwP63s3TMAgABn1ICAAAdlgIAWBXKAgAXZaICAAF59YIAADP+AgAATsSA=
Date:   Tue, 11 Oct 2022 19:08:51 +0000
Message-ID: <SJ1PR11MB608345C36F1D52B8185E46E1FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220923005827.1533380-1-dverkamp@chromium.org>
 <Yy2U2BW6Tx0imGpK@zn.tnic>
 <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
 <Yy3yJfz213Lqo4KC@zn.tnic>
 <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
 <Y0VTS9qTF/GaMihP@zn.tnic>
 <SJ1PR11MB6083203F6D6EFF8E562A2593FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y0WtdarNtdIXCuhC@zn.tnic>
In-Reply-To: <Y0WtdarNtdIXCuhC@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6432:EE_
x-ms-office365-filtering-correlation-id: be3a1c71-643f-4a1e-0bb8-08daabbc08be
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: of+jKBrSTRqwZp0Hk3Q5Kz272yxQkNvCTEvUAiAfnPByaxmSSK4lPws9IrrgYFwvNXydjaD0cB98qXTToNa3EKJVEWFRfjStHZyTzBBfrN9i2CpMaOwxkq/Q8ZZ3Y4hNcrp48R8l5CGiSCWsIn84jjEbCgzlBnMSSR4bSZBIzaR8dtQ1NvV2MNGL6gaTUiPy3vj+EihVdtGVPOileZffrFTiwSj3A0wL1jxaLn0Eou53l5CsMn8fYeliZm24tKcZb19Tfr8cBwCvhxanFtviewk1XhT3vB2JuS6kMn6hEL1XLEDdHVdFwdadlle5oN0W46+2fMct8UKaDPTI6ZuXvA8JSWFBw8WJh8AzZXUrCuLPBQKj9aRgd7VquQZG1H/gXm2wOHmzXGwoiBQZ+/NMf84HKdgZGfovs7kFRoRMP3wwkx9u66zPFaxVrv5xAW9Fhvf7Pgb+7FAV/PJTBmn3Ibz8nk2wFJTmQoSkkwm/KIxbkXAn+cwTCpUiY/U5Q0795hFAvgMGTcwM2lvUNex4YWs9TRymIMOefEeGGmY6fNQEkJNmJ2uu13bMF3HxWdJy5q5QXUlvFUbSgvBYrgOAAld8hBWJZ8JsENIR//oaGw6rrnDZ6YW9DeyJnaG8QGfX+PRkPvGaRBaufS8nIZzkaJkqNs1qk/7N47e62/nyBamlFjWVHYNcUHs8TVK7zQaze9sRWqmX3PUYBHtZfAeoLwGsot5LyY8ZLb5+E/jkn7huI7rSRiJ6cLXEhtx0Hg7VMSm2yrd87CK5Llije1bA0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199015)(6506007)(9686003)(316002)(71200400001)(55016003)(6916009)(7696005)(41300700001)(5660300002)(52536014)(26005)(82960400001)(38100700002)(86362001)(8936002)(478600001)(33656002)(2906002)(4744005)(186003)(54906003)(38070700005)(4326008)(64756008)(76116006)(122000001)(66946007)(8676002)(66446008)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amRmL0RXanVETkNrZ1NJRXN4ZmxXQ1RiQXZTWk85WUE3eHZ0QksyVkZ0SDNS?=
 =?utf-8?B?TWduN0pOb2psMSs3TXoxMzZOZlRtS0ljNHk2Ly9XckNVdE54M3hxWEZVdzdu?=
 =?utf-8?B?bVBQSXowS2g0WXZnQkFXQldZZmFZRDdxTXZxQ0F6am1JY1RzOFFtb0NUUmZH?=
 =?utf-8?B?NFZFUldkT1hwS0lkaWJGTnpmNVVadjVFd0t0dkVCWlMyUnBBSHdqdEk5cWRO?=
 =?utf-8?B?eHN3aVRiUzNwYk1mbys4TDdjWlhicmRtM1ZlVDN5SHR1dmJ3bVFWOFc5RndN?=
 =?utf-8?B?Tys5RjNnVzRIa3dtSkVBa0src2pkcENRSUVvTkwvR1VjcmxrSlk1eUptdkdr?=
 =?utf-8?B?TysybmNScmE3Q0VjZzRQYzdYVEpmQmh1ZFRKSnRZV2JvY0F5YzhIYVluTGQv?=
 =?utf-8?B?aHdwZFhEQ2JpTXNmeVAwaEk0d1JNWit4ZDc5Sk00YnJoZk8ydnJqeEhhd1Fv?=
 =?utf-8?B?Y252WXJ4Vkp4eDlxeTFOK3MraFNaZU1BajIxZ3dRdVB1RnNaOTFuQ1cyWnY4?=
 =?utf-8?B?U2xKRVNRSXh6SU44U3IrUXhMMU44cDBzNXlzWUFFaHRMalVpNVArNE00d1d6?=
 =?utf-8?B?OTNOamlwcVNaNGs5RURMc1hFYVR5MVhYeTZBQUJTMkl0U09XU2diUzREWjdh?=
 =?utf-8?B?Sng3WmdlR1BRU2pnZ0NRemN5QTZjbzZ2SmVXV1p3NTFjcjI1OHBaUnpsQW5X?=
 =?utf-8?B?b00wdmR4SHQ0c0NRcHJlV2tXei9BSU8xUkdvK3lwOVFieUMzUmJEL3BJL1hP?=
 =?utf-8?B?YWY5SGtsTWRpbzZhUkRXcG9sNjlrWitnbURlTDNwSDNWaG1mbzM4Q1FZa1ZX?=
 =?utf-8?B?WHh4U0poakI5NXpJL3VENDRNUmk0bmQ3OGNkZUZDWWxGRTJuaWF6ZU9rMVU2?=
 =?utf-8?B?d0lSeUdlMVQzbGgvU0p1akw3bmxKeDBmSEtHREV3ZS82VXpUK2F5N0h1TjVV?=
 =?utf-8?B?ZmNDd2grbk04Vjh1b3Vyc09ZcmVJVENiOE52ZkxhQ3Z0Q3RnOHBqaFdiNWVB?=
 =?utf-8?B?aTdwLzJhZlNGQjZpeTRYVk1udGFsWEs5MTVzUXdVeUJmWGhOOGRaUFk5aU12?=
 =?utf-8?B?TEFMM3MyWUUzVDNxcmhBTFRXQjNoSXJjOVVGRTI4V1FPTHlWVmJ1U09yblJM?=
 =?utf-8?B?R3EzRGNDU3NxQVFGTFk5RVN6U0s2NC9uVVhKSHhaOTduYlVyK3hpMURHU1ZW?=
 =?utf-8?B?NWNGQWJHVDlpTmZ5aHhBV2lnTHl1YnBQaUZZdkZVTmlSQXRkbzRuampPN0hq?=
 =?utf-8?B?QnZUVm9PSGwvc3NLMFRSWUg1dHcrdTNIU0pNMC9VWk5ualpqSHJVMG5iZnky?=
 =?utf-8?B?dFBXS05zQlp4UWxZOHowRmxkWXhtdjF5ZWlxa2JXYmhBankvTG8rQ2dzRVVT?=
 =?utf-8?B?YVdlMVNKWEVKWC9leGJ1am00b1VIYTRkSE93clZmT1ZZQXBEV2doTVRXblZz?=
 =?utf-8?B?UjdTZDU4eHg5WHdDWkliOWd5NDZaSzhUQ3FNc0d2WENBc1pNZkxqcW5JNmwy?=
 =?utf-8?B?bm4vWk5CcFdqMlNsUjE5dXAveEduazlLWkZMenlGV2pCcC9wOFFjWE5sMEtw?=
 =?utf-8?B?OGdlaUZkcjF3d0lVMFUxaFRERTRZRVlhanprMFNhZWJMeUREbHBCNnF0WVBQ?=
 =?utf-8?B?SVBZQ3FzSHdjUU4vbk13d0V6R2tJOGFaN0tVSzU1cFZCWUpOUXgvUW4wNHRJ?=
 =?utf-8?B?L1BnR3BZRGo1RGFqclZWRVMyMjNpRHhIcXR3UHRqYU1UMjRiTlJJcWhCSzdB?=
 =?utf-8?B?U2FnUkxLSDJjTUh2MmNZVVlvdGRQalU3b04rTnIrM0VZMGZ4U2pLTmYwMzBq?=
 =?utf-8?B?ZnBLRnRPWm9pay9TY2x0ODcxUExpaEtadmE3SHdMVGg1L2Q2UytVY2I3eWh1?=
 =?utf-8?B?eGJIMjhlMmRKQVBSSjI4WEsrSEFOZkdzamxhMUhBTE1YNU4zTlEwaDFvc3g0?=
 =?utf-8?B?TXBJUTBjT29iZE5PZWdnOVdVYWdOeldMTFZ3TlpRcXI1V2tVdXVXNUk2T2Fv?=
 =?utf-8?B?SnIyQTAzenVMS3JyMzRaS0tmczBpWWlxN3diSEJmYlJQRHpaZTdWZGdUTVJz?=
 =?utf-8?B?S0JmOGtwWkVFcU4yTGlSMzZWelROa0VNTktnNjFvNVJnT2ZEWWd5MG16Z280?=
 =?utf-8?Q?QnDI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3a1c71-643f-4a1e-0bb8-08daabbc08be
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 19:08:51.4595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJR6Eg33eoIZhr9sBCV04UkECMR8caN74Py1FJiZiEGFGaPLpkxVoE1TSTkgGZbMJRM2vHTDIA4gO4craBT+bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6432
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJZiBzb21ldGhpbmcgY2xlYXJzIE1TUl9JQTMyX01JU0NfRU5BQkxFX0ZBU1RfU1RSSU5HX0JJ
VCBhbmQgd2UgZ28gYW5kDQo+IGNsZWFyIG91ciBmZWF0dXJlIGZsYWdzIGFuZCBsdXNlcnNwYWNl
IHN0aWxsIHF1ZXJpZXMgQ1BVSUQgdGhlbiBvaCB3ZWxsLA0KPiBpdCdsbCBiZSBmdW4uIEl0IGFs
bCBkZXBlbmRzIG9uIHdoeSBzb21ldGhpbmcgaGFzIGNsZWFyZWQgdGhlbSB0aG8uIEl0DQo+IGNv
dWxkIGJlIHNvbWUgcGVyZm9ybWFuY2UgdGhpbmcgb3Igc29tZXRoaW5nIGEgbG90IG1vcmUgZnVu
a3kuIEkgZ3Vlc3MNCj4gaWYgc3R1ZmYgc3RhcnRzIGV4cGxvZGluZyBsZWZ0IGFuZCByaWdodCwg
dGhlcmUgd2lsbCBzb29uIGJlIGEgbWljcm9jb2RlDQo+IHBhdGNoIGFmdGVyIHRoYXQuIDotKQ0K
DQpZZXMuIEVSTVMgQ1BVSUQgYml0IHdhcyB0aGUgZWFybHkgaW5kaWNhdG9yIHRvIHMvdyB0aGF0
IFJFUCBNT1ZTIHdvdWxkDQpkbyBzb21lIGZhbmN5IHNwZWVkdXBzIGlmIGNlcnRhaW4gY29uZGl0
aW9ucyBhYm91dCBzb3VyY2UsIGRlc3RpbmF0aW9uIGFuZA0KY291bnQgYXJlIGFsbCBtZXQuIEEg
aGludCB0byBzL3cgdG8gZGVjaWRlIHdoaWNoIG1lbWNweSgpIHJvdXRpbmUgdG8gdXNlLg0KDQpG
U1JNIGlzIGEgaGludCB0aGF0IHRoZSBieXRlIGNvdW50IHJlc3RyaWN0aW9uIGhhZCBwcmV0dHkg
bXVjaCBiZWVuIHJlbW92ZWQNCnNvIHMvdyBjYW4gdXNlIFJFUCBNT1ZTIGluIGV2ZW4gbW9yZSBw
bGFjZXMuDQoNCkkgZG9uJ3QgdGhpbmsgSW50ZWwgd2lsbCBkZWxpYmVyYXRlbHkgcmVsZWFzZSBh
IENQVSB0aGF0IGhhcyBGU1JNPTEsIEVSTVM9MC4NCg0KLVRvbnkNCg==
