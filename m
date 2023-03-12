Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7156B6747
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCLOo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCLOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:44:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3A09036;
        Sun, 12 Mar 2023 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678632261; x=1710168261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SLrjT9AKQpVjAwNcA9XEIXjLCliHbX1amwby0Kts7mA=;
  b=AmqKQzK3//lQjSAoFAIO85cxg64TnTJNVuLxHWdb1HPshjkb4aks0/4n
   +gEiyHVz8ctxWIo4TeNa9yVnI4uPUoN8eh2Rwdt8xBpZlBULG2K0ekKst
   zrKK5j+QmPPfdpuKzLbDLGLHH+YkWDxLCiyUage9jTbGqffB57RUu4Yp3
   fXB/r3XMZRpiY+x4bC06uSfRFZpt227dhbyRFmZGbITMWhU7RU25CxQji
   IpjS0FOTSJ2XpBOeh7TjtkVjLKAFCB/TRBrI4h40lRyDX8cvRjeN6u3If
   JCs0Ust/79ldTmb3crALXDu8ay9Ac45YJo5+RYg2F0OWhTERz9ff7pn71
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="316642368"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="316642368"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 07:44:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="1007688609"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="1007688609"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 12 Mar 2023 07:44:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 07:44:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 07:44:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 12 Mar 2023 07:44:19 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 12 Mar 2023 07:44:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSjQvTTNVv01LsDAHgPdr6YNNenms4inKmi5xDpthvKi2dkEEW3Z3xl3SoIp2z2khykRxQp6UJmVdoEKjKW5RL23fe7awvIUIzPaBXSe5i2HqJFXEDdh3DVJrusfY3XptJVEZyYiRPTWeXPB8rsdDdLb/V/jrNTRtnLLg79qR1sHHRm0VTRXk4bGVf4SN9jKFijDOXe3PNQu/qUEKQvq7DpG1At3QzZHqsY42P9bT6BUOvXgb71t5Zqrfep+M4blms16RM0GoDwbLveofdpSZR85CYNpyTxbssLfspazu1D5XeIsDmWJPTYt2rWJk0laOLudUp5fpn861r0HJ/gTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLrjT9AKQpVjAwNcA9XEIXjLCliHbX1amwby0Kts7mA=;
 b=UqR4zSi7FgXHbf0uuUboRxLG/rLCj3eUc9RCJ+DgJSxj/4rRtvwQHvK78ehPu6LKqVZEbojybxzr+0nLgKm2wp+VTcn13FeYCgN1RWocmK0wZRHTyfOIgHtO2AgWzifQwViY+oOJ8k6lUfJ4cWyfIIaxkSBZbJ1ycWPRwgWlKI8/ix7Tx5kafA4S4hzChlypCz1kMuSWU+c4IYiagVnkT/dSucA5I5vPsUEVuH1ICAvRoypiAm6/f3JVv7dcVmh9CAmrFxTWGITKK0XOzA+K5bV47ytBaYMh0A7dreG3eGq+WiYxdRi3Fhkv81kInrLAU6v/zCaq3dY3hAC7ydl42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by MW4PR11MB7161.namprd11.prod.outlook.com (2603:10b6:303:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sun, 12 Mar
 2023 14:44:17 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.023; Sun, 12 Mar 2023
 14:44:17 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] ACPI: processor: thermal: Update CPU cooling
 devices on cpufreq policy changes
Thread-Topic: [PATCH v1 4/4] ACPI: processor: thermal: Update CPU cooling
 devices on cpufreq policy changes
Thread-Index: AQHZTgXCADX3q3nR90eQLtuRLGZfaq7vi+GAgATUt4CAAuWXAA==
Date:   Sun, 12 Mar 2023 14:44:16 +0000
Message-ID: <8d1441fb730cb1ead3316fb5eb8651c2ce991dd8.camel@intel.com>
References: <2148907.irdbgypaU6@kreacher> <1936685.PYKUYFuaPT@kreacher>
         <f8c87ea7a1fd8f763ff4ccf3c43706ae43f81ede.camel@intel.com>
         <CAJZ5v0i=EL_1ZFyqH4C3cWEVtagL4BB2gg7Xdj4Li1iRjMyM6A@mail.gmail.com>
In-Reply-To: <CAJZ5v0i=EL_1ZFyqH4C3cWEVtagL4BB2gg7Xdj4Li1iRjMyM6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|MW4PR11MB7161:EE_
x-ms-office365-filtering-correlation-id: c71b47c2-1767-41ac-d99b-08db23084172
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TvE8v8FLYc1Qr1J/HXjJCxzlFtCyhbD4lUKJ7M4/zhl3+C06EsQAoTqjguB30TsVLMcKeg9PpZ4J0+1CTGPS/ISRYOsjMK2o/tGKD7ztSjq5I3pV0WZ9WoNcHY/EJDvQEbQ/5nVojBrsyryAkY1cZt9Y1EiT+6VxemlUMgFsL2wQLRS2oDEu7yiRyrD/rlZ6jgbn5TQkXs/dOA23rldrDbp3NbwMKTIG+qtS4/irG9pm7qkX/zjjViIpQ2lNzaIbAHK/ALU3+qf/zI8OYzrtPeWr1WAvM+adGdCcHVq755ONJMvooEimuhuLZdUH+ukgmyd5bhvcOnWz8tWpgQyncr080ktXvX/WTFt/Zp5R8qumFKnkZ10HZ/nOdxNdjfo/1d7M3a2dPRRWMrtdKffeZfRoNQALjptqS0yNzgojj5vNMBWBnvr/QDxMTwulY2TVaAC9j0N7aIjxJ3u5nxnzsxb1/6RXQFJQgExemWuTO40/PyCCDEbstjf6S8K4zYQD8g4E9vwzJ8a16bScVrwBg5nOkRhprTFHzE4oVQGFpVqCwJCb+nCi3FVJC8EJyPigZzgaY7i+ykT26bRnHhBefrjmilclzgEnu3rmkIZ7OPfpTKtY5tLBGuU9WhoddDtf3mnMVtY/4bMvpsDRzT6v7XRMlh+kfAHGWVLJyM0DR0IjHCxRfLnrG2guYmyDv7M1Qa0+QOk9BwBu/W/A/11atfmc/VnDfvj2H6u90vt6BeY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199018)(15650500001)(84970400001)(186003)(38070700005)(2906002)(38100700002)(82960400001)(2616005)(53546011)(6512007)(26005)(6506007)(122000001)(5660300002)(8936002)(966005)(41300700001)(6486002)(86362001)(4326008)(66556008)(8676002)(6916009)(64756008)(76116006)(66476007)(66446008)(66946007)(91956017)(71200400001)(316002)(83380400001)(36756003)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Um14MjVNVGVUMUl6TmFWRmdQVnNodmoxQXEyTjhpWkJCSXlVL0NEeTBMZ3lp?=
 =?utf-8?B?YVJxZnZEbVBRekViQjJCUU01S3o4RGQwanFSbkN1T28vSnNCZXJROG9ybEty?=
 =?utf-8?B?dTRZRXFQR1VIMDhkYU1Ma3c4TUowVTRabVlBRmk3Yk5XOFJ4bmFveG9laFoz?=
 =?utf-8?B?bW9lcHFUNk9qUmRra2JucWNrMTBPRElRL1JpN2Q1UUg2ZzlCSlhzb1NBd3RN?=
 =?utf-8?B?MFhHQS92REp3Mkp2cm1iNnlFaFFwUC9MU1h4OFIwYUdDYlg2bFp0SDhjWE5X?=
 =?utf-8?B?R2hsb0hmYkd5TkxBenZ6aWxjWTdiRXhBczhPdUF1RXFRaGRseWhTQTJ3WS9v?=
 =?utf-8?B?NFpMTkMwWGVhUmNUeUVuTWxZbWZseVM1S3NmcTQ5TUczb3dHZVdEWXlzRjJK?=
 =?utf-8?B?RFJRSnk1dEZ6cFVUN3pjYldJbjlBUFNVbU9FMTlUM1FIN2FwWjUxSGFuL3JF?=
 =?utf-8?B?cWtpR0Nvd2VNLy84UHgvcTgyenIvUXUxS2lHRkh1RUlPaDVIM2RzV1kzRnlD?=
 =?utf-8?B?em5yWEYyL05qbmxJR3FFamtoMHFlZXF1YTJobjU3ckZtWTdHU1ZXaTJlU0Va?=
 =?utf-8?B?bEYvc2hla1JmQXI5bjBQVVNyWXBsZmVsb2VvWTl6UmdQZXNwTEovWHI0dnA4?=
 =?utf-8?B?RWxWYTZrM1RLaVEvYUVNaWxXNGFWV3NrTjRJS1J3anBtWnFHVkpaZWRLYjRV?=
 =?utf-8?B?cVRRbzRnQ0p5Uk1VMkNyMG5WZUpMYlJoMjcyd0xWK1l6dFFGYlZodmVDWm1n?=
 =?utf-8?B?anRqVWtxbkNTNzd6Z3pwejRRcmlUVE53VHg1Sk0rZUFmZkRoSmF4cU40YlpB?=
 =?utf-8?B?SGdJbUhaeW5WLy9mVkN6RG5SNlo2cUwwWkdhdmJiV3FXTWp4RXlhV3UzRWsz?=
 =?utf-8?B?ejZ1eEh2MHNzZGkxY1EvV21wRG5ESU0yU3VuMkJnQndwcDhGOTlwMXdOYmIv?=
 =?utf-8?B?V0YrR1hwWHlQak43MllaN1dVenROdWFzSURucFJNSmFUU2JVSFl4cnVwQXc3?=
 =?utf-8?B?R1Zzc2I2QUhYSU5rc0FtQlg1UThaTkVhOG5aR3RaQlNYUTVhSmNyUDhGYUg2?=
 =?utf-8?B?VTJ1UkVoWGowMS9ZWDVIb0ZoOEpIeUNoMFQxNDgyOHVvKzM1RGNhQklzZlFF?=
 =?utf-8?B?ajZ5SGlTaGZCOE5rc3JNT0JJazA4NXc5OERRQStVaVllWnlaSk1zSklrcllp?=
 =?utf-8?B?dTdPeWtQSFpvQjZ1RTZEVXBuVWlxbUgrV3lDQ2dRMHdXQ21ydm1SSzVmZHNk?=
 =?utf-8?B?TnRZZWRGbVB1NmNHMlZUWjFCUDhzMzUzbXhHakg4bDVhdG9JSVNZQ29QR3ZX?=
 =?utf-8?B?T3lRQ01WR3ZmSzBaYXp1VTlybDg1b0tNcTg5MWo5WXMvaFpMaFFlSFlrS2dm?=
 =?utf-8?B?Wm4zLytOaHNEcXFKS3hvNnZSQXltc09qM3IwT0w3R2MyeS9Nd2QwUWNjQTFm?=
 =?utf-8?B?bm1pbml6M00xR2dLZ0lsbWc1Q0lIU3RVQWQ5Tm5ibVpNSlo1c2Fjc2EzaCtN?=
 =?utf-8?B?T0dsQy8vbElwNVVkQUU0ZnAzUFd3b3g3dU1TMEpjdXhMSXdtclQrU1orcmpV?=
 =?utf-8?B?c3kwakFrUWFxTVdFNEdiZWJoSk1udnpIR0xlaXZzaXBNWUZMcS9pZUY3RDgr?=
 =?utf-8?B?bldhSis3c2pyNUJXdkE1dzYyQm1FTVpNbWtNT0dMRGdoTU9EWjVJeWJMNmI1?=
 =?utf-8?B?RithN29LazJVbm9tcjg5UE50ZjcraWtvOGo4RHcwWGJpR3pZSHU5bGFpZWNs?=
 =?utf-8?B?VlhxMm5LNmM5WjdNSWIrcWhJVkZMeHdOTkZsSFRJb1ZHazJYRTV3d3lZK0h4?=
 =?utf-8?B?MlJQWXZ4YXdROCsyYXJSM2tFbEZyZXFta0xRSXpTNG1aYnppNm1pclM2OHQ2?=
 =?utf-8?B?VGUwb1lGRmlIK3lhVS9FZjc3d1VtSmdvSGJseUJEM0czRFliSmdqbGpwRHdL?=
 =?utf-8?B?RUEyWUpOeDM5RXcvbUZld25oRllwTnF3RTNJcUEyWDVyNkJCcDQzYjVkSlZ0?=
 =?utf-8?B?ZEdiYzFubmR3bW5SbnVNNWVxRmxFNm01aEhPTnNSWmZsN1V4SG1RaS9YMEN6?=
 =?utf-8?B?K3FYbE1Td05DQUxqOHkxRjJlQjRoOU9YTUw5dDVRZmdnTG9JbzYrS2x6TG90?=
 =?utf-8?B?THVobmlRUjlvTFNYK3A2VFAwNjJrWXplV1NTbHBPaC9qeUpPbVhCSWVFZVFx?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F44A7F07F867294C805017D6ACAB58D7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71b47c2-1767-41ac-d99b-08db23084172
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2023 14:44:16.7188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orDIiCAQ8eEiNLbl4sri6BX+EXP0OwjYOELNHUrnlTvuw7FKp46C519IH+zrHPZOQ9K7nT5+eFKz22eSWGf1yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7161
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTEwIGF0IDE5OjI5ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVHVlLCBNYXIgNywgMjAyMyBhdCA1OjQ34oCvUE0gWmhhbmcsIFJ1aSA8cnVpLnpo
YW5nQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDIzLTAzLTAzIGF0IDIwOjIz
ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gPiA+IEZyb206IFJhZmFlbCBKLiBX
eXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCj4gPiA+IA0KPiA+ID4gV2hlbiBh
IGNwdWZyZXEgcG9saWN5IGFwcGVhcnMgb3IgZ29lcyBhd2F5LCB0aGUgQ1BVIGNvb2xpbmcNCj4g
PiA+IGRldmljZXMNCj4gPiA+IGZvcg0KPiA+ID4gdGhlIENQVXMgY292ZXJlZCBieSB0aGF0IHBv
bGljeSBuZWVkIHRvIGJlIHVwZGF0ZWQgc28gdGhhdCB0aGUNCj4gPiA+IG5ldw0KPiA+ID4gcHJv
Y2Vzc29yX2dldF9tYXhfc3RhdGUoKSB2YWx1ZSBpcyBzdG9yZWQgYXMgbWF4X3N0YXRlIGFuZCB0
aGUNCj4gPiA+IHN0YXRpc3RpY3MgaW4gc3lzZnMgYXJlIHJlYXJyYW5nZWQgZm9yIGVhY2ggb2Yg
dGhlbS4NCj4gPiA+IA0KPiA+ID4gRG8gdGhhdCBhY2NvcmRpbmdseSBpbiBhY3BpX3RoZXJtYWxf
Y3B1ZnJlcV9pbml0KCkgYW5kDQo+ID4gPiBhY3BpX3RoZXJtYWxfY3B1ZnJlcV9leGl0KCkuDQo+
ID4gPiANCj4gPiA+IEZpeGVzOiBhMzY1MTA1YzY4NWMoInRoZXJtYWw6IHN5c2ZzOiBSZXVzZSBj
ZGV2LT5tYXhfc3RhdGUiKQ0KPiA+ID4gUmVwb3J0ZWQtYnk6IFdhbmcsIFF1YW54aWFuIDxxdWFu
eGlhbi53YW5nQGludGVsLmNvbT4NCj4gPiA+IExpbms6DQo+ID4gPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1wbS81M2VjMWYwNmY2MWM5ODQxMDA4Njg5MjZmMjgyNjQ3ZTU3ZWNmYjJk
LmNhbWVsQGludGVsLmNvbS8NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJhZmFlbCBKLiBXeXNvY2tp
IDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMv
YWNwaS9wcm9jZXNzb3JfdGhlcm1hbC5jIHwgICAxNiArKysrKysrKysrKysrLS0tDQo+ID4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiAN
Cj4gPiA+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX3RoZXJtYWwuYw0K
PiA+ID4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCj4gPiA+ID09DQo+ID4gPiAtLS0gbGludXgtcG0ub3JpZy9kcml2ZXJz
L2FjcGkvcHJvY2Vzc29yX3RoZXJtYWwuYw0KPiA+ID4gKysrIGxpbnV4LXBtL2RyaXZlcnMvYWNw
aS9wcm9jZXNzb3JfdGhlcm1hbC5jDQo+ID4gPiBAQCAtMTQwLDkgKzE0MCwxNCBAQCB2b2lkIGFj
cGlfdGhlcm1hbF9jcHVmcmVxX2luaXQoc3RydWN0IGNwDQo+ID4gPiAgICAgICAgICAgICAgIHJl
dCA9IGZyZXFfcW9zX2FkZF9yZXF1ZXN0KCZwb2xpY3ktPmNvbnN0cmFpbnRzLA0KPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcHItPnRoZXJtYWxfcmVxLA0K
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBGUkVRX1FPU19N
QVgsIElOVF9NQVgpOw0KPiA+ID4gLSAgICAgICAgICAgICBpZiAocmV0IDwgMCkNCj4gPiA+ICsg
ICAgICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBw
cl9lcnIoIkZhaWxlZCB0byBhZGQgZnJlcSBjb25zdHJhaW50IGZvcg0KPiA+ID4gQ1BVJWQNCj4g
PiA+ICglZClcbiIsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNwdSwgcmV0
KTsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiA+ICsgICAgICAg
ICAgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgICAgICBpZiAoIUlTX0VSUihwci0+Y2Rl
dikpDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgdGhlcm1hbF9jb29saW5nX2RldmljZV91
cGRhdGUocHItPmNkZXYpOw0KPiA+IA0KPiA+IEFsdGhvdWdoIHRoZXJtYWxfY29vbGluZ19kZXZp
Y2VfdXBkYXRlKCkgaGFuZGxlcyAicHItPmNkZXYgPT0gTlVMTCINCj4gPiBjYXNlLCBJIHRoaW5r
IGl0IGlzIGJldHRlciB0byB1c2UgIUlTX0VSUl9PUl9OVUxMKCkgaGVyZS4NCj4gDQo+IFdoeSBp
cyBpdD8NCj4gDQo+IEkgd2FzIHRoaW5raW5nIGFib3V0IGRvaW5nIHRoYXQsIGJ1dCB0aGVuIEkg
cmVhbGl6ZWQgdGhhdCB0aGUgTlVMTA0KPiBjYXNlIGhhZCBiZWVuIGNvdmVyZWQgYW5kIHRoYXQn
cyB3aHkgSSB3ZW50IGZvciB0aGUgY2hhbmdlIGFib3ZlLiAgSWYNCj4gdGhlcmUgaXMgYSBwYXJ0
aWN1bGFyIHJlYXNvbiB0byBjaGVjayBmb3IgTlVMTCBoZXJlLCBJIGNhbiBkbyB0aGF0LA0KPiBi
dXQgSSdtIG5vdCBzdXJlIHdoYXQgaXQgaXMuDQoNCkkgZG9uJ3QgaGF2ZSBhIHN0cm9uZyBvYmpl
Y3Rpb24gaGVyZS4NCg0KSSB0aG91Z2h0IHRoaXMgd2FzIGEgY29kZSBidWcgYXQgZmlyc3QgZ2xh
bmNlLCB1bnRpbCBJIGRvdWJsZSBjaGVja2VkIHQNCmhlcm1hbF9jb29saW5nX2RldmljZV91cGRh
dGUoKS4NCg0KU28gSSB0aGluayB0aGUgbGF0dGVyIHdvdWxkIGJlIG1vcmUgc3RyYWlnaHQgZm9y
d2FyZCB3aXRob3V0DQppbnRyb2R1Y2luZyBjb2RlIGNvbXBsZXhpdHkuDQoNCnRoYW5rcywNCnJ1
aQ0KDQo=
