Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8C260EF10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiJ0Eds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiJ0Edp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:33:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6970C148FF8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666845224; x=1698381224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V+5k0ErFyln+lenn4PRw0dVxTg8PzJnnCbThGJY4wu0=;
  b=m137MTK1Ix8dzn4TDuQMHmd6WT1O0IyrfFBMicJS5as8modPE8NxOmLS
   2iV6i99nNLOTiRHOBVEeLlMGiehwNAUsA+n5Wg/+UKEQ7DoDl2DVk5jvj
   XY51EKjG6wVdPbgH21Kk/eU5gkLTtkWlVbq/Q2oy4ynbPekR1ctrcVQS7
   bYJwzhGr88uEKhmPwWEHGTtEN3OWWgVBDnrOS9uSgWpNOVbieyHZCtAwF
   WjKsYXQHYrioJ6NYL7K+LuwH7UsW+wFBBbuylmWJualJxN17ZWo+oRpkl
   IBtyMoBo2P5phJIA/XHjHDTCC6o5+imYl0N2c4jo8k9dvgRSyqC1L4rkF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="287843324"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="287843324"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 21:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="663473899"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="663473899"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2022 21:33:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 21:33:43 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 21:33:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 21:33:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 21:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9fk4/Tg4Nksr0lcTWkgchhxOnp3lIliDQZfWAUAhec/Jt2t151OIUfJUT89YBKul3NA4jXEibExrD1KQTkQXu401DhRsNXNFWBQT0pYFKergXOCjQQNoAButqj+WxwZWyfpgUJQHBog80tvpXejxd9C1Zn/fDC/ciFM/zholUJmpIWzcepD2K8PDINh5iobdxT0r+oShOGYp+9NBEg1w1A2etqsBTILfKeAHjPMw72Wk6AmgkYzYEMCa8yOuYwuMyNbqoJKoOUgAUZCSYyaDuanpX72JNP9jodO/zFVOWXTVvnJcGlvPamc4GrwpaOx9XmDGvB4jd5pKNRB/1ZB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+5k0ErFyln+lenn4PRw0dVxTg8PzJnnCbThGJY4wu0=;
 b=NfluA+oO7SnEUwkNWusH6Fe5i3VWeC+k7CNM/tHMRndvF1upLloDOiNJVpeiDw9a3WvrjbxjhQQyAGM5dFca6G7z8QmevK07gV5kPHRl6Vp8BrivjmwM0iWJVu3WeAxOb34Afoyfa8IwF9UrQKH4uKFV9zks90/3I31FG/+MOBCXZAgr47gZsLHSxUCiekYI8iADrg0I5CrPxZWadEuTaodTkA6q8Nvb8M+dm4FPw9CJguzUtxYkEwqUQSquFryRfeWb+/k1TVAlvFdSnNlxGdMHQkvcN955JMOukbtsvI7FxeQ68x+oKHXWiCIGJRN3C+y1XF8E4TFya6UmeMMTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22)
 by PH8PR11MB6707.namprd11.prod.outlook.com (2603:10b6:510:1c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 04:33:41 +0000
Received: from CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::a351:42c7:fffd:fe88]) by CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::a351:42c7:fffd:fe88%7]) with mapi id 15.20.5746.027; Thu, 27 Oct 2022
 04:33:40 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "C, Balamurugan" <balamurugan.c@intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Chao Song <chao.song@linux.intel.com>,
        "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
        "Wang, Rander" <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Song, Gongjun" <gongjun.song@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Reddy, Muralidhar" <muralidhar.reddy@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Ajye Huang <ajye.huang@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>
Subject: RE: [PATCH 2/2] ASoC: Intel: sof_rt5682: quirk auto detection
Thread-Topic: [PATCH 2/2] ASoC: Intel: sof_rt5682: quirk auto detection
Thread-Index: AQHY6Qr4dnRepLZ3yUme7FfMkNEtiK4hIrQAgAAxQoCAACE2AIAAL5xw
Date:   Thu, 27 Oct 2022 04:33:40 +0000
Message-ID: <CY5PR11MB6257D662815EF9D3C141B50597339@CY5PR11MB6257.namprd11.prod.outlook.com>
References: <20221026071409.3235144-1-brent.lu@intel.com>
 <20221026071409.3235144-3-brent.lu@intel.com>
 <6916c126-c710-330a-ffcd-50dd3cdc47d3@linux.intel.com>
 <CY5PR11MB6257D168A60B712088BC7CF797339@CY5PR11MB6257.namprd11.prod.outlook.com>
 <bba5dc19-c0c4-2409-6cd2-c8fa91950444@linux.intel.com>
In-Reply-To: <bba5dc19-c0c4-2409-6cd2-c8fa91950444@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6257:EE_|PH8PR11MB6707:EE_
x-ms-office365-filtering-correlation-id: d2610053-1f31-4a80-bf85-08dab7d46c8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rUIEaB5fm4VxMUSDtzExnmwysiiQ1wuAFkQNZgGi596ahCO25/2/i5HfUJl7/sG9bG/zORWpniAdz5bh+PQmwstMgKAB+ZrUcktdEwFAU7AjDGsYgO89+USANj50OZiTHN6fEALB+RAaCiFKPYB3ARw6AxLqHCkTNRum6B3rM+eX70b02DSO+/qbIhz6DmIMEOq3BIxMdRBxroY7lp462+vxBBOswOTrcDIuiHDyOSjY7TON4SNV/AXympelk8JOZ8azjm07ds1PhMnMWMmtODJ201g5+Vm0WxJM/crAY3aAGale/Q+XzDN+xTFuHOtOAXpt7iOVFw+Acc+cu1L9hjCOyZWB5SxKA2/VuEEkHNGKaRUjZr+ueFHIXkkzYeDyzCrysZBp1HrLNEbS7kpmY/mf0kQAZwDbVjNFSHjFZSiPKhrPUy3izUaqGmjwP9cxtgKI6ClIdr2YG18nUolebMtqddOvBZSDX9++ushWrGXjyRNG/K5jbJo+A8QcePEwJQtWHKL3lwAE0nlO+oG3kkQqyKGOb0pdwXQSJQv5uzhwWjYegeIrGPuy7qSrPL0Kaic+ulpmJEXmSvKAi0iwPEwOp8qe4ij35GMXaO+cHIfHILIlGGmpyzZHaXmqYmbUyIpXf1XPOqUWIc1UrRQMOR0YbpzFzXTpQ3BhcYt83dnMeZ+8TA7N2u60s8ji9SdrlNsFzXwUoWorl7GcuSUJRSbLDAF7l8I4sFFWajm5beZRt9LG28Zd7zsz9nFMvZPaHzYAlBgePomDAcuTgXC2tE6+f74T247h0guY8qJx6is=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6257.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(54906003)(110136005)(2906002)(186003)(66946007)(64756008)(66556008)(4326008)(8676002)(33656002)(76116006)(66446008)(66476007)(6506007)(7696005)(52536014)(8936002)(41300700001)(9686003)(7416002)(26005)(4744005)(5660300002)(316002)(86362001)(83380400001)(82960400001)(478600001)(38070700005)(122000001)(38100700002)(55016003)(71200400001)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djIwSlBINDhuTUo0NXZLMnppZitNYldiQ0U5SFpRMDdCY3I3S3lwc2xkZW5t?=
 =?utf-8?B?SmlpWExyOFNmeDN4TkVJU2pCSHFKYUEzUE84TWc2MWsxUTc1VnNPK1laNFZl?=
 =?utf-8?B?eERISU5ZaWNhLzdCVm1DSGVDMEdPbnNObkFWRTZ3cVBVNHZQSUpCdlJwaENp?=
 =?utf-8?B?aDdHcTRzMWU1R0xiekZRbW5EU1lzdWtSWUNvRHphZGNZVXdaRjJDQWgvZGxn?=
 =?utf-8?B?RHB4VHRlMjU3N1FJTFhmMFdJTFZuRURUcnA3OEJucmhUdk10UXRtcVBIdjd0?=
 =?utf-8?B?c1RNVXl2YW9rQ1k2VHUzVm16QU11bkkvd0czQ2lmMEhpYTRBUUdaNEhNRmEy?=
 =?utf-8?B?WVBsNy9GOC85dDlpT01VcllyY21xY0VGRllyTEhKeHRKRlRLSXIydGhBNXVL?=
 =?utf-8?B?RTB2d1BEWmdZSHZxU0xVcUxQem5oZE5KNENGcDhRU2hCZUNWNGsvWDhGSzR6?=
 =?utf-8?B?VXJaNDRTNVdXRURNR2tnYlF2Um9XMG9ETHNhNTFibjNqa2lLV3hSeVBSMSty?=
 =?utf-8?B?T2Y0VG94dHk1K29sN3MyVmtLZGhKaDBuSXRETy9UNVgyYm9XcmdQLzJDR3BI?=
 =?utf-8?B?Ty9yYzhlSkU4MS8yeC9TWHlUeE44TFZCWWZ5blV0WCtYRTNzOGVvbW1MUytQ?=
 =?utf-8?B?UVBXVDJZc1FIZFZrQWFHbzdYM3NXOHFzZmZoL0ZRK2JQQWF6NXZnWFpUeXJB?=
 =?utf-8?B?R2J0cW9INllVeHdJVTFua29JZmhYYkxLWGI2THRDbDZIVXBKb0hoN2lJUnIy?=
 =?utf-8?B?bTc4NmdoQlI2Um9sR3VvdEM5b2NIUHVOampDOHBtYnRCcklsc0twZWV0TTRE?=
 =?utf-8?B?UThGTHFYQU03Z0d3MFB5cnhvdkNTRWU4ZUIxSkdNQjFhWHFGYzBkNHRnS1do?=
 =?utf-8?B?dzN0NjMrNWFmL1ZUOHd3UjJGOUVPNk96Um9LQzhWN1VxZnpvWG5oMGNvYUlS?=
 =?utf-8?B?bDhMYWdXalVUY2hKVk1oVEdlVWhHTTh0TXgwcXRWMDgvZnFMb2s1aEpZdVZS?=
 =?utf-8?B?MEpiMUozbTkvOUVTYXNpZ3VkL1pyNHNiYzhTQ29ya3NXOWd0d3Q3RnhnbDZJ?=
 =?utf-8?B?aVh3a1BybXJoTEdjZGJFYjJDWVllc2pXSGprdGZlTStEeFY4WU5tWmdHQ3Nq?=
 =?utf-8?B?c3F4UE1pOVpOQmVEWTVWUjNEODFYU0F1cUhvcFpidlRpeEV4NCtYWHRZTm9Z?=
 =?utf-8?B?L3ArbGUzc0VranR4L1JEL2p3aEZGdGRnV0YzUFNYMFJVR0tVY2txL2VRRHpj?=
 =?utf-8?B?QXBnd2xhSDNTVU9GV1RmZGhjUGZwRFNWSEY1QXluSWs1TUFTeGN4Um5iM1Ni?=
 =?utf-8?B?bFRtZFlrSlR2TVpRRUxQQUlqMklZdHZKK051NnM0OGJrZWljN1VnN2xjSWlL?=
 =?utf-8?B?NzIyL2pHSGx5cDhhMTBEbWlwL0N2SytMTW1DTmdIYnZLTTRoUVU4RExzdXBt?=
 =?utf-8?B?c1hSa1VsNFB5SzVsNDMrMFpnVHNLdytpb1lrcEY0dGllRlhKeUxJYkNnWVE4?=
 =?utf-8?B?UWhXWGYwdktiSVlWUzFqcWZMdzdZUUMwT2RtT2xRaThXMmtkcU1KcU1TSUxm?=
 =?utf-8?B?VHpyYjBHMzhHUjBNZHI2YjJBOGNNOHIxcldaNFdRUUIreVFEazVDaTVIZTd2?=
 =?utf-8?B?TjdxWmNSa0kyTlAreU1XMHFoZW5pWG9PazRWek5vZnBMS01oL3UyaWxRZGVs?=
 =?utf-8?B?U0lGMXBsOXEvZFFYT3NlVCtmTjNqYThaa211QXFiSTVuRlBoK2VoUUJlSFgz?=
 =?utf-8?B?Qjk4dFAzcWRHZXlxSGJkU2hFWkRoT1VpcmxYajZPMGI1RGEraEdSQlZqNmFK?=
 =?utf-8?B?U0l2RjNObVhsSDhNWXJyMDZZb3lJMis5dmJOTWVKSXJraDVGbUlheXk2Nmxa?=
 =?utf-8?B?a1VGcG9UeHJCUVRFSWxqcDViU1VldXY2elcwWDVNTG5qWmFIdUNpSW1ndUJS?=
 =?utf-8?B?UmpLeHFiRHkyZFlaVEt6ZVJHSjJyb2RzRHc0b09BbnQvNStnTVI1VTlhSHZ2?=
 =?utf-8?B?N0JndFE2N2d5aDMwYVBHby9wMmNRRzRaaTJ5RVdHMlYyR0lZZVA5bDhKZ3hy?=
 =?utf-8?B?aUVEQ25jRmYxTExqMEljVlhXRFA3bDBJbzJxQ0hWeWFzb0pOMDBSOHVNQ2o1?=
 =?utf-8?Q?ZdDhoKZoP1mIHF7OKwf8hSiQm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6257.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2610053-1f31-4a80-bf85-08dab7d46c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 04:33:40.8435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ao7bNh0/cScsPRrNHu4Y+6nqS+G5KCQglQttRs3q1MNYQ4fFTB4cMkJX4n2IhuW1qaf8DFdrvjmWcTJx02kXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6707
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gSSBhcHByZWNpYXRlIHdoYXQgeW91IGFyZSB0cnlpbmcgdG8gc3VnZ2VzdCwgYW5kIEkg
YW0gYWxsIGZvciB0cnlpbmcgdG8gcHV0IHRoaXMNCj4gcHJvbGlmZXJhdGlvbiBvZiBxdWlya3Mg
dW5kZXIgY29udHJvbCwgYnV0IHRoZSBhdXRvZGV0ZWN0aW9uIGJhc2VkIG9uIHJ1bGVzDQo+IHNl
ZW1zIG91dC1vZi1yZWFjaCBpZiB3ZSBkb24ndCBmaXJzdCBjbGVhbnVwIHRoZSBleGlzdGluZyBx
dWlya3MuDQo+IA0KPiBJZiAidm9sdGVlciIgYW5kICJicnlhIiBtZWFuIGRpZmZlcmVudCB0aGlu
Z3MgdG8gZGlmZmVyZW50IHBlb3BsZSwgYW5kIHJlZmVyZW5jZQ0KPiBhbmQgZGVyaXZhdGl2ZXMg
YXJlIG5vdCB3ZWxsIGlkZW50aWZpZWQsIHRoZSBvZGRzIG9mIHJlZ3Jlc3Npb25zIHNlZW0gdmVy
eSBoaWdoIHRvDQo+IG1lLg0KPiANCg0KVGhlIHJlYXNvbiB0aGF0IHdlIG5lZWQgc28gbWFueSBE
TUkgcXVpcmtzIGlzIHRoYXQgd2UgYXJlIG5vdCBhYmxlIHRvIGtub3cNCndoaWNoIFNTUCBwb3J0
IGlzIHVzZWQgYnkgaGVhZHBob25lIGFuZCBhbXBsaWZpZXIuIEhvd2V2ZXIsIGl0IHNlZW1zIHRv
IG1lDQp0aGF0IHBsYXRmb3JtIGFuZCBtYWNoaW5lIGRyaXZlciBkb2VzIG5vdCBjYXJlIGFib3V0
IHRoZSBEQUkgbmFtZS4NCg0KSSd2ZSB0ZXN0ZWQgdG8gcmVuYW1lIHRoZSBiYWNrZW5kIERBSXMg
YXMgc29tZXRoaW5nIGxpa2UgJ1NTUC1IUCcsICdTU1AtU1BLJywNCmFuZCAnU1NQLUJUJyBzbyB3
ZSBkb24ndCBuZWVkIHRvIGNyZWF0ZSBuZXcgYm9hcmQgaW5mbyBqdXN0IGJlY2F1c2UgdGhlIFNT
UA0KcG9ydCBpcyBkaWZmZXJlbnQuIEhvd2V2ZXIsIHdlIG5lZWQgdG8gbW9kaWZ5IHRvcG9sb2d5
IHNpbmNlIERBSSBuYW1lIGlzDQpjaGFuZ2VkLg0KDQpSZWdhcmRzLA0KQnJlbnQNCg0K
