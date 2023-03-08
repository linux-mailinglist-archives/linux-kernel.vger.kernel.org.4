Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722F06AFB59
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCHAh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCHAhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:37:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F4D9F217;
        Tue,  7 Mar 2023 16:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678235835; x=1709771835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sxD10nKpyTYMgBx3/TgoYT6RnIZQpD17ghk+J+qVfV4=;
  b=BXtfLXAUY01uT583PZZ0S+dfMHd5Joh9y5XS5nnPXBnfLZDwRQqUfUxO
   5vPR1biyQq+J3+izw05aEvbPTHuOk92uLy0ByA1zzt4fzRg14lGzBQfrz
   RJPxyyxZFjIb9GpzAI0K10pfXSMp2fP3um7QyzBcLkCLRjLQ/w0tM6K4+
   K40YKKVoyQAMLGIfFzwvrhrr+QGItR9xDQx/ajK+q+GwqCUWWcJ2skRz1
   8kCQb0c+HeuLFrryj9USHTOwKNjJv4kkM1vxvFK2AuKxxM94dM2aczixa
   aoTPt7vj7kihdhFd7imjQbBA2uyU0qvN8IAfLQQqksaQmBB2s9SuOL4yF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="319843513"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="319843513"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 16:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="765825126"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="765825126"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2023 16:36:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 16:36:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 16:36:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Mar 2023 16:36:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 7 Mar 2023 16:36:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpVcHbyfg+Blxhu1OUvuG43TyZ7gehO+Y85sUqB57BUA0fCFapV72PzP44ulw1AquJe0ikefzrpgZqYvcGLzV90YhK6VubbTW4LGc4yMRHw5CpuUytf9AgX0s721Hpb0bqmYhwL2uScUh/6WK6s8OChKOZHHe+FoeV77TpHK4WAWKYj4s0AFa3DQnKoLTgiRlxzTDzIIvFHUtbwDgbi3Z8AXiVkYh+mFJEJH9nhldIyCpoZKbU+I8NStHRC+KqF1JG9/4oMH+pu5ed886SntODc0RMVBNkPWnxnGAXy5m2xhzF8dw21vkM0cSqf7slmGT20k+QK07HNg2MQVOhJ8aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxD10nKpyTYMgBx3/TgoYT6RnIZQpD17ghk+J+qVfV4=;
 b=ExTOCQEfRAZPV+j0S/g+Ka+JxeKtXzKsiO39qtHJP5ZyMaDw62hIb7EGT91IXbCro3kFonEbK1wiOk8uUXbAtjuIThuSoHTgRdYBV9cG+jq5binX0RvVi8nyrbQODSmaoK1RF2ClE1isdVUL9cT23PTRhUIH+XCPZqbPTFqAcYCs4BFMxN1rB2Afy8/mxfGN5RdO/wCcCUpv/TUVrNtJTn57k0k4lCrcJzbZXELKkOp11QpunrEEqksDXVW/rmylNdUPAef/M2QtJJ6B4zLCXs6mlq/Rf21fBtKhSPwueRZHa3Shw9jMQvcGV7glYE4+vBFN/u4VgJ4A6fq0abeTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA3PR11MB7582.namprd11.prod.outlook.com (2603:10b6:806:31e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 00:36:39 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%8]) with mapi id 15.20.6156.019; Wed, 8 Mar 2023
 00:36:39 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     Jakub Jelinek <jakub@redhat.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
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
Thread-Index: AQHZTiWcwVo9jaQOt0u1ztY/yRpe/a7tql4AgADNkgCAAL2tgIAAd3MAgAAhmACAAAL3gIAAA5lAgAACGICAAAGrIIAANPzQ
Date:   Wed, 8 Mar 2023 00:36:39 +0000
Message-ID: <SJ1PR11MB6083D732726BE2BF06DAC3CEFCB49@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230303231133.1486085-1-eranian@google.com>
 <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
 <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
 <20230307184315.GS25951@gate.crashing.org> <ZAeh8g0nr3IFRSVI@tucnak>
 <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com>
 <SJ1PR11MB6083CADB2B6E859915D456F7FCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAHk-=whzzd53rW5Uk0oK7bXVXS_X6sJiisnhrqaz+MkutO7qug@mail.gmail.com>
 <SJ1PR11MB60834C09C9F85D401C2EB0FBFCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60834C09C9F85D401C2EB0FBFCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA3PR11MB7582:EE_
x-ms-office365-filtering-correlation-id: 50126083-46ea-4587-a748-08db1f6d2e46
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wY2/o9LJZR8UzO3BF2x7oI647bcVdcO5u/kc4TAwSvq2j2/DTisiCo+MZ60iWfiKedGSWpBBG4PbM1zw2idTt1PCz8ZTeKR8jamIzc7lmiE5XkkmNYcWTjWBRUT5fDVoOSGCyc/G/g3YOSnhKTFXqfMUnScA7MMNCN8SikGxiuG7ZVomhF6u+UjDownPIHTnCKdVvg4trbUMzwAaXlF/MwL63jG1Bc1R08bWxUOdzmUirRWruvz9plaoDAsi2VEbHfyoqy6smzBrsoi9yRB1FhaZ9J+vQHhvD72RiGXp4nrHftC/rB8D42R7es8NANJlOOHiXo/3UuHcudV8ZFCPQ/qAI6IPOkyO+vAHiCKSa1zXad1/iFU3UrLH8uG3KxhLEGrjr61BvR5sIA+Y98IIjjhpnv/Djta8k1hzUUNKZp5RusE6BadOU3IYJDbAlbV4040qJwgPRbJm85KEtjjv1Licm2zN5GD/d6hNNlYExlwcv5e1XlOaHDpJ0B4WF7ZIks/3fyVVnspzqF52iS35Xl/hrrZqzBRrlcMXOZ8wgf08+YsMnc0T3zMal26MFfqX2i8vdAJNxW2BwFQOMY1qBVwpuSfwv+Oz0IkaXSKI1Z3ct/ColTNgb2hRrHJxsRYTEDJYe5PJiej38QyeUc6q0dne6yJMeLyh4i1k4/QXgeyC4rIefTDlra3351UIpBUz44B+dAFgDImOXWwJdpbUQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199018)(83380400001)(5660300002)(66946007)(9686003)(4326008)(7416002)(66556008)(6916009)(76116006)(66476007)(66446008)(8676002)(64756008)(2906002)(26005)(186003)(71200400001)(41300700001)(122000001)(8936002)(52536014)(82960400001)(38100700002)(33656002)(478600001)(7696005)(54906003)(6506007)(55016003)(316002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akZJaHoxRytPSTdXUExDMVNvNjYrcjd3S1VjeXpTcXZHOS8vOG5QT3RraGJM?=
 =?utf-8?B?UkgrdFlIQythQ0xxdDd0UFV4aFpzSloyTmN2b3BnQzhhdTFZMnlZbW82ajgx?=
 =?utf-8?B?MTZkK0xpKzZSMXpneFNweU50NUVQTU1wT21MNzBWR092REQvd09JVDB5Qi8v?=
 =?utf-8?B?dGVkcm1Zb2NkbXVEZEpCZ3RoNkJnR0xlQm82cHkrRktTZ2VhZEl6a0dXZzMv?=
 =?utf-8?B?UVd3YXhudzYwZjBOZ2M5SVNtRkduSG5LNmtrZ1JJYWIyVG9FY2xiYVFMNkIw?=
 =?utf-8?B?ejJEYzJnUXppTVNNS01XdFNnTnozdEJaZnY5Wk9SODZweTQyNG1OaVIrTVNY?=
 =?utf-8?B?QW1RNDRYeGlrSmFZRU1GaGozQmNaVWZrNk0velhyQUswdUwxWjVIZTdiTWNU?=
 =?utf-8?B?ZXRSZ1BTNXpsZnZ4WU14MTljKzE0SzB1ZmRYeGo4RzZ1eElrOEt3azc5eDFq?=
 =?utf-8?B?cFBwa01GZDBBVVFxNXpvM3E2My83KzZITDlNR2JrU2FBK1RpTXFBRlRYc0N0?=
 =?utf-8?B?ZURnc2dOcEJPM2VHc1p3YVR2VE5pL0tEaU56bmxwNHY2MWRFejBkN0dGL1Aw?=
 =?utf-8?B?WFl5RU85UURCamVXcnlvNk5Gazd1QlNhc1hFOGtDQWtXeG9ieW5sK3RsclNl?=
 =?utf-8?B?bmlmdHBYa3V6cUMxcUkyYWtkd0xOeWJDc1BMTFBSczNlendhbkMrVjlEQWpS?=
 =?utf-8?B?ejRSTFRTUHI1TXh5ZjQ3azRVMmNGRWdxOElyY2piZHNqdytRQWRQSVhVOVNC?=
 =?utf-8?B?bFpzYnRHQ3Fod3NKODgyNEhvWDhMUlRGdjRSdTI4YW9ualpBekhUTFdWTUl6?=
 =?utf-8?B?N3dTZWgyQ3BvSDdSRE9lYUVoNDdjcjJWVVQwQStjU2s1aHpMclJaUVAzMFBM?=
 =?utf-8?B?VExURmQzcTMwZGdPdkZsNmJXTk9BcHFzZW5ETDZ2bVFJZUQwNFpkdmtXMk5a?=
 =?utf-8?B?ZGoxVnFLYjRYclgwU254MUtBcjltZy85S21JcVV6ai9FTGZUWmh0SFFJVCtD?=
 =?utf-8?B?ZGdiZ2dJcHNOSVBZeGV1QWlLMW9PSDk3a2YvSnlONkI5NTBqOHE3eWVPOGtR?=
 =?utf-8?B?SlNBOW9QVkxjSjB0OWVzakxQeWF5N1RsWVdOa3hlWmMvN0M1VXkydy9Cb2tT?=
 =?utf-8?B?NEtmUDN6eWM4YmIzL1VVV1FRZXlNbCtmTEtQRk5NOGg2S1NXR3ZpRlprd0Rh?=
 =?utf-8?B?L1ZvZVNzTVJIL1BESEMyUGJ2UkFyZ3VrSmN4MjE2Q08xQ0RTSjRLNjZXZ3Zz?=
 =?utf-8?B?K283QzNtNDVHMWdPU2N2emtIR1ByV2IxbUlvWHJGQjluMmRRK2Y4Yjg0aXhm?=
 =?utf-8?B?d2ZjQVAvNEwxaHQvMkNhSkpNWFN2YmtCK21EMTczYzd0OTQ0KzMxTW92YVAx?=
 =?utf-8?B?SldwSTBvSkNERmJuVXRKbEhRVXBpV3FaWkh1RmlPM1ZXL2hDZ1c1V2JnR1VE?=
 =?utf-8?B?V1ZzWW5VdG5vYmFOaWVqWFRnOUx0dkdoUE5pYTVjNCtkYS9QUk1TUldZaEZ1?=
 =?utf-8?B?bzE1R1R5Rm9NbEk1dElQOFBNMyt3alEyS2JYZkUwM3ZEc2wxVU5Ja0Jic3NP?=
 =?utf-8?B?ZjdJaEp1L01YTFdJYjVxVk1nL2swMEFUN0RNcUFQcXQvMEdIUU1YVWd1YVVx?=
 =?utf-8?B?RkNkeGtuaEhLbFZTeXFzaGhDNnFDV0ZKWDNjeHJDVUtPanE5bjhEcEVHRnZm?=
 =?utf-8?B?RmUyMkFQcFNyNThRSFAybk0wVVpuNm1sdWVLMzdMTmwvQXBSOTJmRG9RYmtN?=
 =?utf-8?B?cXA3MjdrVFNYRTcxZExtckUwYXlDbm1tQlRmOWZETjIrY0h3U3lwRWwySFk1?=
 =?utf-8?B?OGJxN0tleVM3U0JPRnNMK3JmdlZ3b2xVcU5nSjk3QkV0K2ZvNnpBWkZoUmdP?=
 =?utf-8?B?Z0VhVVVBZ0xjR2F3cGlSdjc0ZjkwV1g0NmxiK1FMRHllL3paQkVaTWZocTI0?=
 =?utf-8?B?bGtSbWl0U1pHWHVOcWVPc1JIbjJyeDVWbUNCdnl6YVZHY2hNU2VlRHRUcVll?=
 =?utf-8?B?L2Y5MEN1YnFuOWtMT3ovYlJZZk5WeW9GeDN4T2FWSUYyRTNOSVFGVUVpc2c1?=
 =?utf-8?B?NnNwczhwQ0wxeVJsenNadnV1RytSREh5VGMySHJSVzUvaFNVWEVlaDM5U3dX?=
 =?utf-8?Q?hkCxfCB3858uPFA7KNe3s70RW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50126083-46ea-4587-a748-08db1f6d2e46
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 00:36:39.1023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4KUp51bI+BsrnnPJ+MGZsfkB2gTB14OwqRVe0okJHvtDWNySIFcLIAaddWxmH2Lj76+YUOhOyTogEVp+vo4Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7582
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIHdvbmRlciBpZiBjaGVja3BhdGNoIGNvdWxkIGNhdGNoIG1pc3NpbmcgImlubGluZSIgb24g
c3RhdGljDQo+IGZ1bmN0aW9uIGRlZmluaXRpb25zIGluIGhlYWRlciBmaWxlcz8NCg0KU29tZSBj
YXN1YWwgdXNlIG9mIGdyZXAgc2hvd3MgdGhhdCByZXNjdHJsIGlzbid0IHRoZSBvbmx5IG9mZmVu
ZGVyLg0KDQpUaGVyZSBhcmUgbWFueSBub24taW5saW5lIHN0YXRpYyBmdW5jdGlvbnMgaW4gaGVh
ZGVyIGZpbGVzLg0KDQpBIGZldyBodW5kcmVkIHNjYXR0ZXJlZCBhY3Jvc3MgY29yZSBrZXJuZWwg
Y29kZSwgZHJpdmVycyBhbmQgbW9zdA0KYXJjaGl0ZWN0dXJlcy4gRS5nLiBhIGRvemVuIGluIGFy
Y2gveDg2L2luY2x1ZGUvYXNtL2Zsb3BweS5oLg0KDQpzdGF0aWMgaXJxcmV0dXJuX3QgZmxvcHB5
X2hhcmRpbnQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0Kc3RhdGljIHZvaWQgZmRfZGlzYWJsZV9k
bWEodm9pZCkNCnN0YXRpYyBpbnQgdmRtYV9yZXF1ZXN0X2RtYSh1bnNpZ25lZCBpbnQgZG1hbnIs
IGNvbnN0IGNoYXIgKmRldmljZV9pZCkNCnN0YXRpYyB2b2lkIHZkbWFfbm9wKHVuc2lnbmVkIGlu
dCBkdW1teSkNCnN0YXRpYyBpbnQgdmRtYV9nZXRfZG1hX3Jlc2lkdWUodW5zaWduZWQgaW50IGR1
bW15KQ0Kc3RhdGljIGludCBmZF9yZXF1ZXN0X2lycSh2b2lkKQ0Kc3RhdGljIHVuc2lnbmVkIGxv
bmcgZG1hX21lbV9hbGxvYyh1bnNpZ25lZCBsb25nIHNpemUpDQpzdGF0aWMgdW5zaWduZWQgbG9u
ZyB2ZG1hX21lbV9hbGxvYyh1bnNpZ25lZCBsb25nIHNpemUpDQpzdGF0aWMgdm9pZCBfZmRfZG1h
X21lbV9mcmVlKHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZyBzaXplKQ0Kc3RhdGlj
IHZvaWQgX2ZkX2Nob3NlX2RtYV9tb2RlKGNoYXIgKmFkZHIsIHVuc2lnbmVkIGxvbmcgc2l6ZSkN
CnN0YXRpYyBpbnQgdmRtYV9kbWFfc2V0dXAoY2hhciAqYWRkciwgdW5zaWduZWQgbG9uZyBzaXpl
LCBpbnQgbW9kZSwgaW50IGlvKQ0Kc3RhdGljIGludCBoYXJkX2RtYV9zZXR1cChjaGFyICphZGRy
LCB1bnNpZ25lZCBsb25nIHNpemUsIGludCBtb2RlLCBpbnQgaW8pDQoNCi1Ub255DQo=
