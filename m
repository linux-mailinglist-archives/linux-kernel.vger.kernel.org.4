Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AA96AF745
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjCGVLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjCGVLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:11:13 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66366A5696;
        Tue,  7 Mar 2023 13:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678223470; x=1709759470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lHpurijlkRoOT7X3Eup54t7gkwO9QmeTPSkdlYfwgiU=;
  b=IU7fzBWlMENly5nn42996NXI2Uky9kSlj0+narYBIO9koSAg+0rhtjB1
   K+Af+Le0uQ24K7hO+4vbJjI7hVBM3JxPpkD9VbxTagC1uNrzIdtRnxi1A
   4GDxFmi4FuCGAjlSA5oLx+xIj5tI6oebM1HTNzcdAdcVvJMC6Alsk7b0Z
   YSU7dvuJtiSlUB/FwrMm3S4gyI8bgKjYzf/p+EW/kzqhzfQaEtCOL2anj
   8qqgZjsHXeDFTUZLnqM7nV2ibMbwuiKvgPEFRjVIYLircqRSetBQ+Kp/T
   DIee7uBCij/5Sqr/VcH4TiBQERITVV/kA1wk/B6sAlxqgc8brWg8fxep8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="333446416"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="333446416"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 13:11:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="850836407"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="850836407"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 07 Mar 2023 13:11:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 13:11:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 13:11:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 13:11:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 13:11:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zk12SHLr2YsEG9wq1g8HbuF8aVnuLAXP21yWfN1GdTyPl/UYT3E+KrEPET1mvM/N2zWZEcwmDpECD3nTph+IYid7SVTRjGQ5Bgjs9fSvMpSWyMd9/gAbbGjujQjFDOQZO81sTBHb8re0ft859cvnPVsIsW7AMWyZXc8wsyTrE8lpns0WJvPZw4XOc3NUwg4SWZj5SOoF1Z2tYUf/wCUZ9QZmQ0GOlfFpZSs3beJrcrnz4SL4ddQEko0a8zRCGK6J1k/XoGKkJ52O+mMifIDRb6Ks7vWK3AOusELCBWxqYeuF75qlNDIKrtCCdXOzAYMptsT6CDCwOdYlJiZm0F/X3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHpurijlkRoOT7X3Eup54t7gkwO9QmeTPSkdlYfwgiU=;
 b=i6bLtEX228tx87gtP2ebJjHBeugr2k1Ln36GYJTRZjhziJPHTlOttAw8oZeQ9Sm0r9OBZmpj0KCnXov9lVd18S08wh+illZa2HRHa5NHOq0kxiimx6ddXykESbk29LpW89a2TEEiKUZ6qzYzdL490Zea4IbiHUaNq+CFlbwTi0fDn0QBSccjXiAIHERq1Pb9jRCobx2fvU9exOYMJYp946KGs7ied22o32h8hV2nLuVM/V/8mQIh/8RL32JXT7QaZwKtGmD0dVaG/iX5l4zanqOYYqMqLEE7oKBg4AuBvuEWHEXUAwPZMBvSY6EPmTYDoVDiZK+8kjpA01hsE1GMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB6176.namprd11.prod.outlook.com (2603:10b6:8:98::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Tue, 7 Mar 2023 21:11:05 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%8]) with mapi id 15.20.6156.019; Tue, 7 Mar 2023
 21:11:05 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>
CC:     Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>
Subject: RE: [PATCH] x86/resctrl: avoid compiler optimization in
 __resctrl_sched_in
Thread-Topic: [PATCH] x86/resctrl: avoid compiler optimization in
 __resctrl_sched_in
Thread-Index: AQHZTiWcwVo9jaQOt0u1ztY/yRpe/a7tql4AgADNkgCAAL2tgIAAd3MAgAAhmACAAAL3gIAAA5lA
Date:   Tue, 7 Mar 2023 21:11:04 +0000
Message-ID: <SJ1PR11MB6083CADB2B6E859915D456F7FCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230303231133.1486085-1-eranian@google.com>
 <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
 <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
 <20230307184315.GS25951@gate.crashing.org> <ZAeh8g0nr3IFRSVI@tucnak>
 <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com>
In-Reply-To: <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB6176:EE_
x-ms-office365-filtering-correlation-id: 11c822d2-ebd7-4656-c874-08db1f50767c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yE/LKq67CtDixO1zd1qVccAYUcPyiAN991gzsBTaSK7VRvNDCsNhy7GHaa8SRA+rXJKCESEZFZEAQRY/y9zxejRGV+DfIaX+hgh0jLAgGNGj8C8T3Y51aAA3WVJB1DiZnc73KD64c3CW0w3Drf8rLWraVo+aHTV7deDvU3GYSs6t9cEkRORlYF3LSJi2yRAhiZuRGSWH/kcALIxcuBDQ54NGUmZBb3GyWF3FZ7KmlG1zFTqDAgzi3rO0xfCJOTQhdHo4U4HSYF9LDe3/bRUJ9Wa/v6iTck+vsIHnryA/dHCKG8i6SRI9HEdaGj/bbkEUsNmHujKVRWPPnp5b7WXvHt4Un2ZIdAVJOsaITUSJ/+/idg6FPQD93S4RRUuN7Bo1njZ3EOkFSoa2t586yioIN2BhLHtP4a4J7HLtW2lIiZ+0cDuFVf5I5yWDbYkj1q+X9w7yVcdn8GiVPzR3y60az5wN3v3Gd/hyZ62qEuBqstcQ0kj7PcBIoceOsAcIqtSF20tqTVu4KayJMBgVOyZRKmOSqa6BbKVt/RA9S9qi0lhKjX7YFaLVKuR33UO5bRMCPZ8eWbD30rCsmMd243w144P6EfrweviFcGpSNaoaJ+I87jfHNv9iSiEVcKIaQXxPOw6lgDbrm8jChCCmKmM47hCAzNHhyqNrrk7Jze5MDkaTvgl7pL/y7NRflswxGjEd2sy5pOWqeUZeEr/b4sE7jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199018)(33656002)(38070700005)(7416002)(41300700001)(66556008)(4326008)(64756008)(8936002)(8676002)(4744005)(66446008)(2906002)(71200400001)(76116006)(5660300002)(66946007)(122000001)(86362001)(82960400001)(66476007)(38100700002)(7696005)(55016003)(54906003)(478600001)(316002)(110136005)(52536014)(6506007)(186003)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck9zbVBmbEN2WHFCQUMvQlRrZmZKUk9BU2xsbENXL0ppRldPaCtJMzRuRW1p?=
 =?utf-8?B?SXpuVlJFbkpTRVhZbHFCOUlMZWFJQ3NhSlhQeDhmQW5GU3pJWVRYRmdqRHRG?=
 =?utf-8?B?UXl6Q2kxVks3SWVSVkdTak1wSzZlR3hBWmNqR25OTmJza3djbENNUkRUbjNh?=
 =?utf-8?B?SHZhT0VIQmZrMnpVRTIxcHNSb2dNTkV4RWY1V1A3UHBFK1NPcXNVaVc2RzIz?=
 =?utf-8?B?bmZXOThDNk9MQ29ubHNtcVUxcU02WWtCTzd1Mlg2eVZCK3R2WjkvOXMvVTBR?=
 =?utf-8?B?dy84STArQWorYVdHOFgzMmhKUlJvY24wSWZISktxbFZYL08vQWhjSG4rTUVP?=
 =?utf-8?B?UkF0Tm5NTlVIRzRjdTcwVnA0VFVLdFRlN1FabWY1alA3U25TdXFqYk9CaHBD?=
 =?utf-8?B?QnhJbUEvUHVobHFHemRpZk1HSldpc1BmUjR1LzhYZlc0SnNSMVVmMXRzZzc1?=
 =?utf-8?B?Y1pqcjB2S05hdDBnWW9JTFZNeXp2dnFpbjV4U0w5S3NVUmRkcUhxVUVSeS8y?=
 =?utf-8?B?U1diV21NdVVmRkhjQ3VJbXRxMnJMUTZjTis4TmE1OW1LYVEwdytRNjNqWDVn?=
 =?utf-8?B?SUFSTVFHZkhKOW9NNThDWEt3QjJGWGlmTU5vcEVDSm5HZGdTd2xobjdlc0xU?=
 =?utf-8?B?QXk4UGhzNzNwbHcvMVZqMThybHBtUER1N3FSTXVnSUZuaTM0UDljenlDR0ZT?=
 =?utf-8?B?Slp3TEFjSjR4MGNPMGo3WnVaQ1BMZlNoVG9OYXFXQnlBSUtSWjEwcHl0ZmNn?=
 =?utf-8?B?Z2lsVkM3UWljMDQ0RVZQazBFbnptd3ZrRjZVL3IvandlZHRBR1ExQkI1c0ZJ?=
 =?utf-8?B?eDFuTk1ITTBCZ0dJOWl2b2l4cjVaSUYwclFUU3lDaDZaWmtJKzhPT3FTRVYy?=
 =?utf-8?B?Q3RVNktmdmJ4NUJBdFJTUis3cFlmVFZBM3RCYUFNOVJvb2N2OEx6Y3lJaEtJ?=
 =?utf-8?B?QjdvLzhUdzd4NlFINzhMYTFEQUJGV1ovdnU1cUh4ZkJZRlBRTGRwL0FtZFZ1?=
 =?utf-8?B?d0wrZFc5bHVFWmdpSENxRGZRQ0hKdlFiVGNMOFlFL1lKTmhCQ0xmMlZpRGZw?=
 =?utf-8?B?R2lYeVJsdGNkZG1rVW5XMUlBUmJpQWxHOW1HM0lFeEdXYzRSem10d1hCMWZP?=
 =?utf-8?B?WXNOa081Rk1TSFpiSHBrSFM0bWFwNFlkWFJRM2NNZjYySkM4eTFXdVhxaEM2?=
 =?utf-8?B?THpOazB5a0RZdHFNL1BrUmp0R1JWUTFad1lKYWgvcVVUOTV1ejh5MURweVlX?=
 =?utf-8?B?VGtDcktleDZFbS9RTnZlRFZuNTVFem91elhpNUdDYks0YnpOZE90S3lDditu?=
 =?utf-8?B?VGpST0N1dWdzSEhyRDY4enF4L3UxTHBPUExRTWZmQnY4SUtvSDl4UjVqK2Vz?=
 =?utf-8?B?dnc1K3MwTng0N2JqRjlQQnpSY3J3SjQyYUIyWmwvM09FL2laMEVlM1JjRXRR?=
 =?utf-8?B?bUNPb3dZbEZaRTRiN2Y4WHJvSSt0dm1ReGhDNWtGcFc3cmNTV3RJWWcycmxV?=
 =?utf-8?B?UHRNQXhoUk84NUZwa2VNN3lrc3NYZ1hKSWdIS3JUQUpJTDFETlYyZUxkalNR?=
 =?utf-8?B?SmlLemRkbUU1VVNPbzVSWmFVNm1pYU1DMkhjV1FTRDVXckZUYVZ2QklsU0oz?=
 =?utf-8?B?ODJFQWN6dVBFbFl4SVI3TnNRTklpNWFIM1A1NjJsRklQNVBsTDRSOUN0N09E?=
 =?utf-8?B?d0Nwa3dTaE9xSEcraEhjQjV4WmxPQzFuQ2dCQ01mN2lsb3lBUjlaQ2RGV0JC?=
 =?utf-8?B?WlhpNFpBTzI3RW5yc2NhUytSZ3lFUTNCR05lVWVhWmdjWHpaNG5QWllZSnZk?=
 =?utf-8?B?Z0hxSVlVN1FiblN6T1FHUVpJc0tZZXdhSlorMjVOeXFCQXNPdEZWT2R5aTJp?=
 =?utf-8?B?WVpCR2FLRTg3am92UzhIN0NUYkZJVktKNGIzN0g5MHYrU2NmYndIM0NJQ25X?=
 =?utf-8?B?VU5GZHhjQm42dUtzVGNPZWh1c0lXZ04vNFFTTFNCVkJqeUprdWdlR25wMWt0?=
 =?utf-8?B?TzVEZmZRUncyeW4yWTlJb2pyMzdCZjA5dEhPTkpzbWZjWVJLbmd4K1pBamJw?=
 =?utf-8?B?cVRYQVJHQUs4QlN6dXd5WVRQS2U0YW15c0ordGJ0ai9pK0VMdjdINlR5bk9z?=
 =?utf-8?Q?JONpnakAY1oU1B4kWnXpkBWOb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c822d2-ebd7-4656-c874-08db1f50767c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 21:11:04.8166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5H5dl1cp2qg+z8QJwtkleHsUkKCVu44GGgm5MKKVCEM5OeLbAUKkfa3ewh9lWJHBqDol9U84b9ggHJy0Cq2lkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6176
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

PiAoYSkgaXQgc2hvdWxkbid0IGRlZmluZSBhbmQgZGVjbGFyZSBhIHN0YXRpYyBmdW5jdGlvbiBp
biBhIGhlYWRlciBmaWxlDQo+DQo+ICAoYikgdGhlIHJlc2N0cmxfc2NoZWRfaW4oKSBpbmxpbmUg
ZnVuY3Rpb24gaXMgbWlkZXNpZ25lZCB0byBiZWdpbiB3aXRoDQoNCkZpeGluZyAiYiIgd291bGQg
c2VlbSB0byBiZSB0byBqdXN0IHBhc3MgIm5leHRfcCIgdG8gdGhlIGZ1bmN0aW9uIHRvDQp1c2Ug
aW5zdGVhZCBvZiAiY3VycmVudCIuDQoNCkNhbiB5b3UgZXhwYW5kIGFib3V0IHBhcnQgImEiIC4u
LiBMaW51eCBoYXMgemlsbGlvbnMgb2Ygc3RhdGljIGlubGluZSBmdW5jdGlvbnMNCmluIGhlYWRl
ciBmaWxlcyB0byBoYW5kbGUgQ09ORklHIG9wdGlvbnMuIE9uZSB2ZXJzaW9uIGlzIHRoZSByZWFs
IE1jQ295DQp3aGlsZSB0aGUgb3RoZXIgaXMganVzdCBhIHN0dWIgZm9yIHRoZSBDT05GSUc9biBj
YXNlLg0KDQpXaGF0J3MgZGlmZmVyZW50IGFib3V0IHRoaXMgb25lPw0KDQotVG9ueQ0K
