Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE965CCB1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 06:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjADFzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 00:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjADFzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 00:55:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB2E13DE2;
        Tue,  3 Jan 2023 21:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672811717; x=1704347717;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LLfV/xt7eqCAX/ZoAY4v6tHptUFRFZG2wc+13CsffDw=;
  b=atIvgbgQhrrgfoovsa4IQFIEuLc2CjSb7wKLahwdXD12eBf1SK61k9hM
   832+QAl14/Qkp3qUdl7NxOB/I2bu6RU15wYDM03AKlCdBspIL7pFUneiY
   j3tDT8usTfCPNH5243SPM32hSPWSn8CFKXR9VnRlDsi36P7OyCre4ifUm
   a53W0UuyBYAkR75tKY584pyI0xlREPQhsnYi5CjENDr3KGEkv1fY/whLh
   FZOY0NO0l6NaBVmXMBO7fuYVfOmduWe9uqMzMcjx08e/H8x+91a6BQggq
   8iON8Vnog6k3GLCiZ82QXKqX0ZjRwYWkCqcrHiirG7NooA/bzoQXhJ1Z4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="384132943"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="384132943"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 21:55:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="718347689"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="718347689"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jan 2023 21:55:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 21:55:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 21:55:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 21:55:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 21:55:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDNM4Aai2HoiEJGsvzA1faWrDeNkamezttu+AUItcOGKlPvUdQrRsvLiO1o9eFMl5Phl0iTp7S26mJ139FVRGGYs7k4+jNU9ZD/ZQrmaISoS5hZ3lnjn6nXiOLvKaR39AMjCOrcl4+2bEkh4MfEmCcV9+2JdR9YPtBuEdDS6nWUTHynAYWmiajh5ryMeCnVe4OVif474tcwWQvw+97By7yMw673lrzyFX6rboUoxmjTUt+SINyFMWn6nsNSg1qtLapRjg+ly7DgykRYP8cI1cqFWrYC4M1tYcvVrUYb5TVMzaI8c4OVUBEuPPd1FPwbr9uSkDICRTd4pygIXgHwJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLfV/xt7eqCAX/ZoAY4v6tHptUFRFZG2wc+13CsffDw=;
 b=Eyz4UvCxxzU4FpbVF0r1VQJtxo9A3MtG1YVw/97rCQacYBRLKBgt6Hoa8LJQpkFy2gCWrsbafRGRA7vujuRQZBsAgPpD1+8vu7zT6fNQbFbfKbksydlcALfiPF8lbCzJq1aG7AuFNrkGghX3J6uDyXamh+4djn/o3vSBk6IQMGH+K6VTJFwo3UY+Mi8ATDPFklZLMp4DEll+Ykigi+6Y0P8iJQkmUDV4XjSsIfDu0yEV2BLKLtLjcGhw8K0HReOn4bKDPcBvhzhP3h6pdcHbmlikj1zZdI6W058UOsrGncFIexx7bBkYtwFGdiE3ZV25ov/FmERE1VNj30gZL0nBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA2PR11MB5066.namprd11.prod.outlook.com (2603:10b6:806:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 05:55:08 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 05:55:07 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [RFC PATCH 2/3] x86/resctrl: Move the task's threads to the group
 automatically
Thread-Topic: [RFC PATCH 2/3] x86/resctrl: Move the task's threads to the
 group automatically
Thread-Index: AQHZH7+6IS3iSRVh50246JsSDXTFrK6NwNyg
Date:   Wed, 4 Jan 2023 05:55:07 +0000
Message-ID: <IA1PR11MB6097CF779BF29E7F716108849BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
 <167278360189.34228.2442698916556329960.stgit@bmoger-ubuntu>
In-Reply-To: <167278360189.34228.2442698916556329960.stgit@bmoger-ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|SA2PR11MB5066:EE_
x-ms-office365-filtering-correlation-id: ebb93234-430a-4949-0132-08daee183be0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: amT3XmCV99zLvVvbPrfZngWfPJy57/4fHk44olkK80O/i55oFFaS3aKcA9ihLFXUDI05SAD8hOKYs8R3evrVyAN9b6R+oB+U9KSL7fXtve30lxgsBVKHcve25tlHZg5HLcBoRlNvbzzYwiwSzQI/cWFyAUGK8/2xm0BVOgNcA0aTO4UMx4pMo45u2UVY4/ktwsJLDKKppJCJxNo+yID7N0AzoHo1cIO0KalcAdXpM1o0nPf2MQzB5+TkSInExCbEN1loZwUDGlyf4Hkk2r/cR7ZW1b6TtKuQYV4TLdAzPSyW/X2DALnvApt/0RKJMC3iYsQBjVaQIptn+K1hHEBFOGzU1Gy1rJyHBI/kGeBdLsqcqZ3GqA58XGVIGY9oRdwxT1VX0ESad/1RSP8Jiv9JyIxpW5cosLE3kx//TZ5y0CtaQ9JGdd+sR8fyBRg8mHGYTeSiTEIGmD4n6eol2dFb0OCV9APu1PGq/raRTEHyOCRgEsjOy4NiDt2d2qAnl/PmkQ327rcJs7wMq/OAz+TUKniLRLsL4kFOkiDi1saX67Vru/d2daAOo00q4CW48FoLffULzIxH1TVQtsc2ARBa9Gh96AfHhxpc6d3BaKykj+AKGVFfSDWRUp1SlUbUe7pWsKOiPi1U/lEcNCxSD69dzVLm+LBzS8vTcn4Jd+dZQij7b23z+u8jgtBOS0Ytpz5Jkj/S+TpKptpREcetstTEjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(86362001)(8676002)(7696005)(66556008)(64756008)(6506007)(4326008)(76116006)(66946007)(66476007)(26005)(66446008)(9686003)(186003)(83380400001)(478600001)(55016003)(54906003)(6636002)(316002)(71200400001)(110136005)(33656002)(38070700005)(38100700002)(122000001)(2906002)(82960400001)(7416002)(8936002)(52536014)(66899015)(41300700001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFZQblVEeElKcnBzaFVKUWhJVTliUU8rMjVCVDBPV1RlYkg0RVgxS1Qzb3Jv?=
 =?utf-8?B?ZnlmSkF3UGc4THFnV0Jlem1ZbDhBWXppcTJzS21qOWZqc3dEZDBsdFI3V3d5?=
 =?utf-8?B?aGpicldmNkp0Tkw0Z2VRRXU5aFg1OEcybjZiVXZUUVBEeG5HNEEwTXJvd3FE?=
 =?utf-8?B?U3llSFlpMzA4WmNHY2dVaEdKVVhMTk5uZUx1Ni9IaDUzb0Vvc0JOQ2ttR1h5?=
 =?utf-8?B?MFluV3JOK3RsUitVU0dONHdSaW00QkpRNWd2eU5HMm94TC8xVm5xN0poR3lB?=
 =?utf-8?B?MHM1eDdWd2ZDcTI0WTd5aFBPOVpSMkxNT0ZqYnJnaS80UFMvMnJwRVpzd0wy?=
 =?utf-8?B?NFpSOWZVSUdjckJrRkNYNnUzK3JiRGNNQ2Z3d3VJYU9OK1pxTnU1K0creGxs?=
 =?utf-8?B?Q0haeVIzeStFKzdTemVFdVE3dTZ4OEZ1NkwzUGNWSUJjZXBsUHc2a1dEdmRL?=
 =?utf-8?B?VGhCc1BmbVIxK3BqUU14VlhjaU03enp6Vk9aZm1JM2V0MXdyTkZTcGptV3lm?=
 =?utf-8?B?YWtoRkpVeGE5dzZvam5KbzYrK0MxM0x3WWtDRGM0Sk5tMHI3bHc5M3l4KzI2?=
 =?utf-8?B?YVp2MVIxYm5zQXY2V2ZETzNicmdRYVlsV2tXZi8rM09JY3hENDJIa1VVSTJG?=
 =?utf-8?B?ek1rRmtURUZ1cmpvVmZDZEM0ZzM1d2I2ZFRUUFVxWDZ6NDcxdDFRSGFsYTVh?=
 =?utf-8?B?K3hrelczeU9CbjE5TzY0eG9CME9US0Raa1dGaHhFMFNEdC9xM3kzeTdCcGI0?=
 =?utf-8?B?SU1ZK0lKdGlkaGFHdjNDL3RXcXdJVVJQZ1E3V0ltVElaRFlYZGx5Y2R6SnBy?=
 =?utf-8?B?SFJBTW80T0YrVWQveHFWL2cxb3VVWmxkdXpybWJGZE5HdllXZWpyTnJ5RHpw?=
 =?utf-8?B?aGVVWlZXbW9mQlc4NkpYZmFDUlAvNkFHZmNlUndUeENkSUY3NzIwRkRRcW9J?=
 =?utf-8?B?bWxzTmZnRVgxcGh1OFo5cFZ1SVhwcmJjL3htTEVwaXRURXhwQUorZmEyQThk?=
 =?utf-8?B?dzhOS0hiVEQ4N2ZmUENWWURsVE9CRk1SZWdaSWxIeUQvWFpSd0pxZ0xjWE14?=
 =?utf-8?B?Sm5laTkySmVwZkRvVUUxd0dqY24zUWpST3htNFE4cml3UmNGcVpCcGZmN2dT?=
 =?utf-8?B?cE5KOVJ2Z2FYQnNnaFRtQU1qcDlFakxRMGlxbnBEM2JZcFhab25IYU5iSlo2?=
 =?utf-8?B?dWF2ZGFjVkpNTXNyazcyVzZjSWFjbUpabitlV1hOZm5TS1lGUk5GUlExNGNx?=
 =?utf-8?B?M3hFRWwwSm8vckwyZWVMS0NYbS9MVGduTVVVaEx0TFFmZmxTRnhCNGVaNGdQ?=
 =?utf-8?B?UHhBMmF4REl1dDc5WTdjK2JzWEVpeWlKSXN6OW9OVUYxQS8vWk1zYkxnbW9h?=
 =?utf-8?B?czF3MTBlQk9aNlJMZXYzK1E1TjUyeDg0MHU3OGdlVFI1RXRUTURvTUtHVjJ1?=
 =?utf-8?B?Wmp0MVd6N1NZL0dyNnl2aEp4RVJKQVFhcFU1eUgyMlZwa0RXeFl1dURDU2hi?=
 =?utf-8?B?UCtvRm11K2czekdDSnMvSFRHZURZc3ZqeGU4QnE3TWZoU2JjR3F2ZFJJVnpv?=
 =?utf-8?B?SS9Pd0p5ZmFWYkVSMUhEcmJmSm8xOHZWdmJueUFNbVNETFRJZ3JlQ1Y4UUxj?=
 =?utf-8?B?bWVUck1aaCtKcTMwMFMxSzdJSk92ZHU4dVhYSElSREVMYkpiMnJldFh5Vjhk?=
 =?utf-8?B?UHdUY2JPN1FOYjA5RmU1WGhGTjZaVlRUOFdBV0oxaG8zSDVGTzE3VkpjRWor?=
 =?utf-8?B?VzNUOE1Pc3NYMXVGRzh6NElPMndhdktnSU9iUDFZbzJDL014Vit3bGlyZzUv?=
 =?utf-8?B?L1dXeHlkUlZSYi9XYkF6WjZhNUVMRXVMaFpBSFVGTmp2V1ZXVXVQcmptcVdD?=
 =?utf-8?B?REVUdGRSM3JaSG1CSW5RYWR2TExDLzV4WDZrYzE2d0hGS2w5amh5S1JDMHBx?=
 =?utf-8?B?UXM5NXZXR0o2RHQ3bG9mT1I1bmJWdmNiblYzZTFHQ0NYWWZEcVFZQXdtOG5G?=
 =?utf-8?B?T2lneDJPWnl4YksyMHJJMkt3dU8rY3V4QjFZOTBvVHlIWlF6eXdHaDBXSlE4?=
 =?utf-8?B?Z0N0NktSYk1ocGc3R2JOVmc1TzFVY1F1YmJpaWtib05tUHQ3WThvZ1dZZklz?=
 =?utf-8?Q?iAoMg8KX8iCd90zPZSvju54J7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb93234-430a-4949-0132-08daee183be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 05:55:07.7352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4yf7zxZBaTey9bh4+wV0hpNo/j3+AEsKw4dzwTiePdD7wXxNY7NKGPFbdUBvtJiWA/iv70bWHVSAkw+S+05IQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5066
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJhYnUsDQoNCj4gU29tZSBtaWNybyBiZW5jaG1hcmtzIHJ1biBtdWx0aXBsZSB0aHJlYWRz
IHdoZW4gc3RhcnRlZC4gTW9uaXRvcmluZyAob3INCj4gY29udHJvbGxpbmcpIHRoZSBiZW5jaG1h
cmsgdXNpbmcgdGhlIHRhc2sgaWQgaXMgYml0IHRyaWNreS4gVXNlcnMgbmVlZCB0byB0cmFjayBh
bGwNCj4gdGhlIHRocmVhZHMgYW5kIGFzc2lnbiB0aGVtIGluZGl2aWR1YWxseSB0byBtb25pdG9y
IG9yIGNvbnRyb2wuIEZvciBleGFtcGxlOg0KPiAgICRzdHJlYW1fbG93T3ZlcmhlYWQgLWNvZGVB
bGcgMTMgLW5SZXAgMTAwMDAwIC1jb3JlcyAwIDEgMiAzIC1tZW1NQiAzMg0KPiAgIC1hbGlnbktC
IDgxOTIgLWFQYWRCIDAgLWJQYWRCIDAgLWNQYWRCIDAgLXRlc3RNYXNrIDENCj4gDQo+ICAgJHBp
ZG9mIHN0cmVhbV9sb3dPdmVyaGVhZA0KPiAgIDY3OTMNCj4gDQo+IFRoaXMgYmVuY2htYXJrIGFj
dHVhbGx5IHJ1bnMgbXVsdGlwbGUgdGhyZWFkcyB1bmRlcm5lYXRoIG9uIHRoZSBjb3JlcyBsaXN0
ZWQNCj4gYWJvdmUuIEl0IGNhbiBiZSBzZWVuIHdpdGggdGhlIGNvbW1hbmQ6DQo+ICAgJHBzIC1U
IC1wIDY3OTMNCj4gICAgUElEICAgU1BJRCBUVFkgICAgICAgICAgVElNRSBDTUQNCj4gICA2Nzkz
ICAgNjc5MyBwdHMvMiAgICAwMDowMDowMCBzdHJlYW1fbG93T3ZlcmgNCj4gICA2NzkzICAgNjgw
MiBwdHMvMiAgICAwMDowMToyNSBzdHJlYW1fbG93T3ZlcmgNCj4gICA2NzkzICAgNjgwMyBwdHMv
MiAgICAwMDowMToyNSBzdHJlYW1fbG93T3ZlcmgNCj4gICA2NzkzICAgNjgwNCBwdHMvMiAgICAw
MDowMToyNSBzdHJlYW1fbG93T3ZlcmgNCj4gICA2NzkzICAgNjgwNSBwdHMvMiAgICAwMDowMToy
NSBzdHJlYW1fbG93T3ZlcmgNCj4gDQo+IFVzZXJzIG5lZWQgdG8gYXNzaWduIHRoZXNlIHRocmVh
ZHMgaW5kaXZpZHVhbGx5IHRvIHRoZSByZXNjdHJsIGdyb3VwIGZvcg0KPiBtb25pdG9yaW5nIG9y
IGNvbnRyb2xsaW5nLg0KPiANCj4gICAkZWNobyA2NzkzID4gL3N5cy9mcy9yZXN0cmwvY2xvczEv
dGFza3MNCj4gICAkZWNobyA2ODAyID4gL3N5cy9mcy9yZXN0cmwvY2xvczEvdGFza3MNCj4gICAk
ZWNobyA2ODAzID4gL3N5cy9mcy9yZXN0cmwvY2xvczEvdGFza3MNCj4gICAkZWNobyA2ODA0ID4g
L3N5cy9mcy9yZXN0cmwvY2xvczEvdGFza3MNCj4gICAkZWNobyA2ODA1ID4gL3N5cy9mcy9yZXN0
cmwvY2xvczEvdGFza3MNCj4gDQo+IFRoYXQgaXMgbm90IGVhc3kgd2hlbiBkZWFsaW5nIHdpdGgg
bnVtZXJvdXMgdGhyZWFkcy4NCj4gDQo+IERldGVjdCB0aGUgdGFzaydzIHRocmVhZHMgYXV0b21h
dGljYWxseSBhbmQgYXNzaWduIHRoZW0gdG8gdGhlIHJlc2N0cmwgZ3JvdXANCj4gd2hlbiBwYXJl
bnQgdGFzayBpcyBhc3NpZ25lZC4gRm9yIGV4YW1wbGU6DQoNCkJ1dCB1c2VyIG1heSBjaG9vc2Ug
bm90IHRvIG1vdmUgdGhyZWFkcyBhbG9uZyB3aXRoIHRoZSBwYXJlbnQuDQpZb3Ugd2lsbCBuZWVk
IHRvIGhhdmUgYW4gb3B0aW9uIHRvIG9wdCBpbi4NCg0KPiAgICRlY2hvIDY3OTMgPiAvc3lzL2Zz
L3Jlc3RybC9jbG9zMS90YXNrcw0KPiANCj4gQWxsIHRoZSB0aHJlYWRzIHdpbGwgYmUgYXNzaWdu
ZWQgdG8gdGhlIGdyb3VwIGF1dG9tYXRpY2FsbHkuDQo+ICAgJGNhdCAvc3lzL2ZzL3Jlc3RybC9j
bG9zMS90YXNrcw0KPiAgIDY3OTMNCj4gICA2NzkzDQo+ICAgNjgwMg0KPiAgIDY4MDMNCj4gICA2
ODA0DQo+ICAgNjgwNQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dl
ckBhbWQuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91
cC5jIHwgICAgOSArKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jl
c2N0cmwvcmR0Z3JvdXAuYw0KPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91
cC5jDQo+IGluZGV4IDM0NDYwNzg1M2Y0Yy4uMGQ3MWVkMjJjZmE5IDEwMDY0NA0KPiAtLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiArKysgYi9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiBAQCAtNjg1LDYgKzY4NSw3IEBAIHN0YXRp
YyBpbnQgcmR0Z3JvdXBfbW92ZV90YXNrKHBpZF90IHBpZCwgc3RydWN0IHJkdGdyb3VwDQo+ICpy
ZHRncnAsICBzdGF0aWMgc3NpemVfdCByZHRncm91cF90YXNrc193cml0ZShzdHJ1Y3Qga2VybmZz
X29wZW5fZmlsZSAqb2YsDQo+ICAJCQkJICAgIGNoYXIgKmJ1Ziwgc2l6ZV90IG5ieXRlcywgbG9m
Zl90IG9mZikgIHsNCj4gKwlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssICp0aHJlYWQ7DQo+ICAJ
c3RydWN0IHJkdGdyb3VwICpyZHRncnA7DQo+ICAJY2hhciAqcGlkX3N0cjsNCj4gIAlpbnQgcmV0
ID0gMDsNCj4gQEAgLTcyMyw3ICs3MjQsMTMgQEAgc3RhdGljIHNzaXplX3QgcmR0Z3JvdXBfdGFz
a3Nfd3JpdGUoc3RydWN0DQo+IGtlcm5mc19vcGVuX2ZpbGUgKm9mLA0KPiAgCQlnb3RvIGV4aXQ7
DQo+ICAJfQ0KPiANCj4gLQlyZXQgPSByZHRncm91cF9tb3ZlX3Rhc2socGlkLCByZHRncnAsIG9m
KTsNCj4gKwl0YXNrID0gZmluZF90YXNrX2J5X3ZwaWQocGlkKTsNCj4gKwl0aHJlYWQgPSB0YXNr
Ow0KPiArCWRvIHsNCj4gKwkJcmV0ID0gcmR0Z3JvdXBfbW92ZV90YXNrKHRocmVhZC0+cGlkLCBy
ZHRncnAsIG9mKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCWdvdG8gZXhpdDsNCg0KSWYgZmFpbHVy
ZSBoYXBwZW5zIGluIHRoZSBtaWRkbGUgb2YgdGhyZWFkcywgd2lsbCB5b3UgcmV2ZXJzZSB0aGUg
cHJldmlvdXMNCm1vdmVkIHRocmVhZHMgKG9yIGV2ZW4gdGhlIHRhc2spIG9yIHdpbGwgeW91IHJl
cG9ydCB0aGlzIGZhaWx1cmUgYW5kIG1vdmUNCnRvIHRoZSBuZXh0IHRocmVhZD8gU2VlbXMgdG8g
bWUgeW91IG5lZWQgdG8gZWl0aGVyIG1vdmUgYWxsIHRocmVhZHMgb3INCm5vIHRocmVhZCBtb3Zl
ZCBhdCBhbGwuDQoNCj4gKwl9IHdoaWxlX2VhY2hfdGhyZWFkKHRhc2ssIHRocmVhZCk7DQo+IA0K
PiAgCWdvdG8gbmV4dDsNCj4gDQo+IA0KVGhhbmtzLg0KDQotRmVuZ2h1YQ0K
