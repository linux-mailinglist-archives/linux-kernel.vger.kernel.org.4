Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4706CD869
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjC2LYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjC2LYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:24:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2DF40D9;
        Wed, 29 Mar 2023 04:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680089082; x=1711625082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hBXBoxRNpEWTtLrUU8b1O5+zawSCCSt5n6ayYDgoYfE=;
  b=CBB3T7BZh3Uq3MZoFPASQGkYyFIp/3KZcr2wDj4ZYvTgRjB7WQBBg/5H
   GXIv2YpjIavnqZ9UhtduyDWnM89gQL9kza1IohLROuQfLzV2TCovw5H5u
   Y6FZoKvWWZUyug0d24bOK/Sltzjl19dcZGjkVIk8KwW1Gpk/CPI+4OdfZ
   Ki8x/A3TWwGc/NCOUmllQcIoY65UnT/y0Zu2i1lpmI0q4XI0nXODhLLbH
   q5WEMH626J/zZPiq84Cj/09iH/wRoeS0bxkF2BLLIj7Gfz/SOvhIC0KhL
   9C5wFAAmMXuUfwdgk5mHKbReG12CWfxm80odSHYyYjc95eAGzC9Ut3ILv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405791124"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="405791124"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 04:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="748764701"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="748764701"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 29 Mar 2023 04:24:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 04:24:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 04:24:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 04:24:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 04:24:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IM047R7JEpqFgScbZq9XsvniEVfyo4LVw8EsqvLcqRrzXhwi1ahuAcUd6skrlYRAG1apn+6DE/lGqzcJ9wcjoHm6ma1+tWBfxn0Bp8JeTzCUjiKlFTxc/52ZxsoXF20j0LDrCwZnuZ68XCisGxbspoMd8QiUWaj95yh8b8pQDMKjbRFEPauElmQAtHJmWKiE+2N2oKvUzZn/UaWITMJRQKB5ew7zxjbwyVSvYPr1B2cpzHQaVz28SP5bzqQ9Bn0hPiv7PcOxaWdynSN7i1OLthbt5cjW36zt2fgSFflre4/BWeIefwFtaBPpl2RYbPq4Xb4tHIp2MSN3fQIIx7Ofrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBXBoxRNpEWTtLrUU8b1O5+zawSCCSt5n6ayYDgoYfE=;
 b=dUGz6S25m/n1Fscrv/QrwFtTwC3ttqnNuDim733ZSjLQz2LHbSywwnctczUDUTOYmvqbtDoQi2/u2PHlhvre/hMGLO6vy1WDQLwcvyWwi6cTRySYaalHd3pApgdhLXjxM7/Cv6H7/W0ovKGPsEAJhzrttNFwh31mvZqeu2ml2SIe4BL1w/cj0cVOaFO3LfjNRrJpdwSUVMJLL0UhDcKMF0cD3JVd9WZEGn0Lp/zOYzTIEmogsT6c74Fxh6csj/PR3QYCjjzB+3VttMLFYqXSFavzc+bqzg2hHr3dYYnYS93fQnohAVQAZqNUZcvS2zk/0yLBJt/rcQNtkUBnihn57Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by DM4PR11MB6408.namprd11.prod.outlook.com (2603:10b6:8:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 11:24:33 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 11:24:33 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
Thread-Topic: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
Thread-Index: AQHZYh1uVnlfaKlfcU6JrYVgxsdgB68RhYcAgAAYTYA=
Date:   Wed, 29 Mar 2023 11:24:33 +0000
Message-ID: <794b4b0eb6a0181b5e01f17e720a56e5ffaaf2e9.camel@intel.com>
References: <20230329090055.7537-1-rui.zhang@intel.com>
         <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
In-Reply-To: <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|DM4PR11MB6408:EE_
x-ms-office365-filtering-correlation-id: 20af7bde-9231-4b69-447c-08db30482bdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U96yiaLtfADXwpF3dUyys7L5QQsE3858/TWkBgJU8Y9AewhSGSYOgWqE07XboafKZQ1kDsgx7V9n/mPV8kwxHc/z7oU5KDVmJvjmkEr/CJjGNZnbhnyVWs2PiZ45Pa26vAPnw9NRQVfvrcF/g2kzW7dAoP6mmL6rM9PW/0zkPUygAhanryT79GTZBjzBbEFJAxaJVp+pmY/EHAP90zHAjCkfkxzOcyQL4ULFgp+dFh2h4EbIecKi2kp3EwMPt1mEDR1BLgLyObIfWQIsMn2BAu5jG4OoAVGyZBAEG43VDgUeqMTs9qGd7ChOXT5ORXWp/ieEdQBKOUVcC52vGbtlTMN5YfsNSfSg9zMiitQzx3h5YZat54Y7CBsZp9oozCNOFNOIt2SkBNJ6y9TJ+j7jzzfA6Z274Wd4odOgTMyiulRFHSPkvAo6M8VO4Tm9/PxsXVr/gJQpjFOvYPjBPpN+ICmUkvHnGXt1Ia637hQCHPwf8rkAcU/qEM5JweeVoE3AXWrGqTy3puOvxLmREGoSk0+zkBuPpFBWCAmMZ2vKhkQsQBSZNS+ivppbL6xZLs14i7GK8BwWdJn+hKzJXISyxochI8QG/JHzdaeqo9/1HsemmJWJjEVHyCkXYKQE2OFs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(2616005)(53546011)(110136005)(316002)(83380400001)(6512007)(186003)(6506007)(26005)(6486002)(71200400001)(86362001)(38100700002)(122000001)(36756003)(478600001)(8936002)(5660300002)(38070700005)(91956017)(76116006)(66946007)(64756008)(82960400001)(66446008)(66556008)(66476007)(4326008)(8676002)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2JoZnY0N3F1VUg0RzFOT0dWZllTZHN2Sy9xb1phZk1panZ2L0RHQlRBOWty?=
 =?utf-8?B?N2xsaVRwSXVNNXYyVGtoek9EUGw5MWUzd0hKUzlZc1JMbFpWU1RDRzgwMjAr?=
 =?utf-8?B?N0JoUTNjVE1ybGljd1BoMXd6KzZBR1dzTUxWME9XT2dQbTExdVc5SkQ0OXYx?=
 =?utf-8?B?ZDBYKzVsT2ZpWE9mRkdXQ1E5bkFOZXhuWmtoYTQxTkNSd1ZseVVDN0Nrc0hB?=
 =?utf-8?B?dzFJOWRwOWxzaHRCeFlzZUhCdEJ2ZnRPbHRzOTFkV0RlcFVzZnREV3JOT2Jk?=
 =?utf-8?B?TUVnbnRMUjNxajFyOENSTmt3RHF0QUYzWjJvd2ppVFZMbXd6ZXh3clc1dGRS?=
 =?utf-8?B?S3NtTmhXenJweE5QVFJ5c1JpOTVQN2JhU1g0OFRubm5lNWZqRGVEUEJDK0pR?=
 =?utf-8?B?b2tlSFlhaUV3K0NMMWtIbWdBc0ppY0xZTWdodXVyeDdZdkRQdmY5enZtaWFw?=
 =?utf-8?B?a3EwSVAxUkxweTlpL2E4bXYwUWZzOFl0eDVCQVRxSDA2d2U2cnB6VnZUdnZ6?=
 =?utf-8?B?N2dTdFk5b2NNQjZTT21ZYUVsYTVVa1dPK3ptUEJnMk9UeEdNOGlwa3ByZmdT?=
 =?utf-8?B?aTZkd2x3WnNWaDRsd3AvUlJiKzlaeTZZekxvQkQ0RzY0UUY5L2hlS2FXTDZj?=
 =?utf-8?B?b3JweWxPVGdsOGdSaFFnTTFGL1RjOG5HbW9ENWtnUjc3TGI2UHFRanRPMjBo?=
 =?utf-8?B?VFY5T1F4WG1rR2ZCUFpGMDE5bW1SRGFJdEthY0VoajFLbzJRbGY0cUJJVkFw?=
 =?utf-8?B?dnpUeVk5K3ZlVkJjQW90aUtnNElvT0hUVWxZc3NxRURKYVlzdnRhWEVCaHlQ?=
 =?utf-8?B?RXdaS2d1Wm5acEZjVE5ITndCRHcyMzF3UldTSjY2cUVrd0dQb21VeDN6ZEpw?=
 =?utf-8?B?S29uM1IxWExlSVN5d1l5ZWxYU1lGZWloQytFSFY0dTFvM2ZkNnVFeFdvZmRQ?=
 =?utf-8?B?M2pxbTVzcnZqdFVkSXdqVWlwUGxPVVJlT3lLeGdiQll0M1Y5RllZb3V5M0JU?=
 =?utf-8?B?RktjT1RqbysxVlA0ay9EQzdJL2cxWHRsc0J5L3cyZVpwMlIrbGVnUEZRb0dR?=
 =?utf-8?B?dFJEZWJEWnB4dlpOcHdUcWd0R3NSOVU4NXdYRTRkMEhPOGtiV2tudGZjeExv?=
 =?utf-8?B?MWJQN0lsNjRlV0ZxdGdQbUFmaDBTYTkxdE51Zy80dDhIcFdsazhneURJU0VO?=
 =?utf-8?B?U1pzcEhyWEZrVk5UNmVkYVdjOTdudGRDZ0trOEF1MURhNW10YUc4bnAwVHIy?=
 =?utf-8?B?c2pwYTJTa1daQnp0cjJUVkhkQ1FaVmxCVjJsTUpaVG5KQmFWRWFvcnM4M0J3?=
 =?utf-8?B?cFVwUGFyOGpYZzdkWkcrNVBlVkU5Y3p1T1B0Q2FuQ0pGTEh4VlRJMHBaZEVt?=
 =?utf-8?B?NStsay85UEh0NmdpVWozdHdtcXVMM1B6QnI3R0cyTnJEWTF2SjhFeERETE5y?=
 =?utf-8?B?SlIxZWxWNU1RdXNnUnFrYWJwdUJ3dVZSY2NKYzcwNXYvcU1Jcy9WajR2QWhX?=
 =?utf-8?B?NVFhdzVmbnh3SnY0UllObFplYk9iYnZEcVFCaVI2bDBlVHhkU2dtWkxZNWxr?=
 =?utf-8?B?TWpHVHdpMW4vVi9DbmZYQXR6WDBoU3pxcDBCWmNyMFo5M3BqR0d5RWRXNG1m?=
 =?utf-8?B?RUsxeS9UbEI0aGNrMHNFSmgrcHZhTUZaLzJ6WWZJKzBoaExGTTFXQXptdlh4?=
 =?utf-8?B?NjZTaDJGMmgxMUlNOGRsN2ZuN0c1SjBuVU9Ybm1nN1RzWURXTXVNdEYzc3hK?=
 =?utf-8?B?TmNpdGhJY1crYUZPb0VaQ05PY0lULzRuaXNwajFYZW1KdnQxTmpPNHdjU0NK?=
 =?utf-8?B?RFJ4TjlpTERmNkFMdTFHMnVGSklSQnl4QVRsL3F5WTQrNGJ3azdOcU9HdXRP?=
 =?utf-8?B?alh5TzVVQmxtMTNCY2hsWWllVDJZYmZla2p3VWEzZU5IZkgvb0pvaGxZbnBP?=
 =?utf-8?B?SnQrbVVnRnZHOHBrbEJlcnNRTHNZQXQ0c01GbER1UThjSTZwSmNSYmtLZHE5?=
 =?utf-8?B?TnRiN2YvUnVOdzNJaVBEVmQ4dkV2djhobTBlMW9SNlJRL1VQWDBPNjJscGVY?=
 =?utf-8?B?cDc4dXZaMC91K3pVelFzaStKcURualM5VGVRVjhyaVhLb3JWQ0RCN1FYUDFq?=
 =?utf-8?Q?NCyQd1bfu8OZqcMnwYApmJ4ck?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85C7569655880247BA65D163DDAE8B7C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20af7bde-9231-4b69-447c-08db30482bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 11:24:33.4314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xztcMhmP4oq8l72lMMrcc+i3TI0yvyIbP1YS0Nv2JWFH4xlAUWhztQ67pPYnS5ZPOJNh9KFQYSbVUxbrkHUG5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6408
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTI5IGF0IDExOjU3ICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gT24gMjkvMDMvMjAyMyAxMTowMCwgWmhhbmcgUnVpIHdyb3RlOg0KPiA+IFdoZW4gdGhlIGh3
bW9uIGRldmljZSBub2RlIG9mIGEgdGhlcm1hbCB6b25lIGRldmljZSBpcyBub3QgZm91bmQsDQo+
ID4gdXNpbmcgaHdtb24tPmRldmljZSBjYXVzZXMgYSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVm
ZXJlbmNlLg0KPiA+IA0KPiA+IFJlcG9ydGVkLWJ5OiBQcmVibGUgQWRhbSBDIDxhZGFtLmMucHJl
YmxlQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0Bp
bnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gRml4ZXM6IGRlYzA3ZDM5OWNjOCAoInRoZXJtYWw6IERv
bid0IHVzZSAnZGV2aWNlJyBpbnRlcm5hbCB0aGVybWFsDQo+ID4gem9uZSBzdHJ1Y3R1cmUgZmll
bGQiKQ0KPiA+IGRlYzA3ZDM5OWNjOCBpcyBhIGNvbW1pdCBpbiB0aGUgbGludXgtbmV4dCBicmFu
Y2ggb2YgbGludXgtcG0gcmVwby4NCj4gPiBJJ20gbm90IHN1cmUgaWYgdGhlIEZpeCB0YWcgYXBw
bGllcyB0byBzdWNoIGNvbW1pdCBvciBub3QuDQo+IA0KPiBBY3R1YWxseSBpdCByZXZlcnRzIHRo
ZSB3b3JrIGRvbmUgdG8gZW5jYXBzdWxhdGUgdGhlIHRoZXJtYWwgem9uZQ0KPiBkZXZpY2UgDQo+
IHN0cnVjdHVyZS4NCj4gDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9o
d21vbi5jIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFs
X2h3bW9uLmMNCj4gPiBiL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2h3bW9uLmMNCj4gPiBpbmRl
eCBjNTlkYjE3ZGRkZDYuLjI2MTc0M2Y0NjFiZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Ro
ZXJtYWwvdGhlcm1hbF9od21vbi5jDQo+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL3RoZXJtYWxf
aHdtb24uYw0KPiA+IEBAIC0yMjksNyArMjI5LDcgQEAgdm9pZCB0aGVybWFsX3JlbW92ZV9od21v
bl9zeXNmcyhzdHJ1Y3QNCj4gPiB0aGVybWFsX3pvbmVfZGV2aWNlICp0eikNCj4gPiAgIAlod21v
biA9IHRoZXJtYWxfaHdtb25fbG9va3VwX2J5X3R5cGUodHopOw0KPiA+ICAgCWlmICh1bmxpa2Vs
eSghaHdtb24pKSB7DQo+ID4gICAJCS8qIFNob3VsZCBuZXZlciBoYXBwZW4uLi4gKi8NCj4gPiAt
CQlkZXZfZGJnKGh3bW9uLT5kZXZpY2UsICJod21vbiBkZXZpY2UgbG9va3VwDQo+ID4gZmFpbGVk
IVxuIik7DQo+ID4gKwkJZGV2X2RiZygmdHotPmRldmljZSwgImh3bW9uIGRldmljZSBsb29rdXAg
ZmFpbGVkIVxuIik7DQo+IA0KPiBBcyBpdCAnU2hvdWxkIG5ldmVyIGhhcHBlbicsIEkgd291bGQg
cmVwbGFjZSB0aGF0IGJ5Og0KPiANCj4gCWlmIChXQVJOX09OKCFod21vbikpDQo+IAkJLyogU2hv
dWxkIG5ldmVyIGhhcHBlbi4uLiAqLw0KPiAJCXJldHVybjsNCg0KQWN0dWFsbHksIHRoZSBjb21t
ZW50IGlzIHdyb25nLg0KDQpGb3IgdGhlcm1hbCB6b25lcyB3aXRoIHR6cC0+bm9faHdtb24gc2V0
LCB0aGlzIGlzIGFsd2F5cyB0cnVlLg0KDQpXZSBzaG91bGQgYWRkIGFuIGV4dHJhIGNoZWNrIGZv
ciB0aGF0Lg0KDQp0aGFua3MsDQpydWkNCg==
