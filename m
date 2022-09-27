Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0848F5ED0F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 01:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiI0XUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 19:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiI0XUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 19:20:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B783251;
        Tue, 27 Sep 2022 16:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664320835; x=1695856835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yNgtiA9qkioi4WIpz6EVa8ZV6RaaQZbx5uAqMopgkEA=;
  b=a1R7bQuJwKT9BQ5vX8lAnogtCC3ZwzvvpdKOTEsDXB9rwSowvbpOA1k+
   m3/4dh27q1Z/vL2UkyTHdyv/rTwmGvvFnkDVJLI5TEBojQANnxXUI0y/c
   lFV6k+Qgj8O/kIVy4mcTCwEJhGwYZ5Lqeit7umsDaxO8m63ZGKZg3KSdx
   5ICrwQuR+O+9iRl29zrTC1/VgevypqL4wXLNZRyGipAfA7CXAu7XMv7sN
   TfkXfqbx1cVH5lwML8SSMQjtHkV7qQBEhreFaBE4z0DNiV5ZuZK+IGdwA
   l7h6MPmcZEPzEFR1z44hwmA2D8vp6NJ5EsR3gW5yCl/6/tIvFeN2NdOMC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="363295029"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="363295029"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 16:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="599354853"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="599354853"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2022 16:20:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 16:20:33 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 16:20:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 27 Sep 2022 16:20:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 27 Sep 2022 16:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrO7ctbdSc1Sg3yii5GvPwnI0P6fgEFPiBBdBMlhTaAz8rnZK/aM07H5OJQpqDrtCEFmGRyqXhr0uJuColRoLAPSO+mRSU4kNUuSDZ8RbicyrSwzqGmQMOi5LMUUyh77MSbB2wOwScQfL8fDxJZeNS89p2M8sE0Y5mODvexbbTn4HNI+S+wKZNg9AppHcBVlodU+rFCu94zKYyjET2K3aVeHqXbqBQIEwGD5v5ZqTVQemLlV1r3TIOghg7UobmzDoxLroI7N4a358GhSRGO82b0nCz9OJOWO1BykjOqDAnPSGLonKOcD6LZwJOURjS3+Vgu+VYkIlzK3g1JA+Ve1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNgtiA9qkioi4WIpz6EVa8ZV6RaaQZbx5uAqMopgkEA=;
 b=UCFUZBSxg2SHh8zOcrJRk77KzmSUftKKZ36U7TJ1EckwD1jI1NUgfYil+NGIJcG2YOw1/KqPEtPQE+N07fgfdtAk7F4O+deaWE8ZBUPlDhK7yf+KkhngF+90MWG522vKe7d2vra68S6/xtVrhuB8IbFp9iw4fQNctA7zTnMvHXwCZTBX/4IHVF93VbAq2INC20MwCDoLlUsiEiHUd9RP5Ue50BttKdgZHgQLo2msQYNdpwTCerVPdBw5Ds3IUCJincC99ujXlK00rhFgxmab6dUYXyXryHUEXbCM9pBXQbppcqmHF3xGGHBzhGtPU3NZ85lGwLuYhTvAemXcWg+pzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CO1PR11MB5059.namprd11.prod.outlook.com (2603:10b6:303:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 23:20:22 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::d145:9195:77f:8911]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::d145:9195:77f:8911%7]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 23:20:22 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "sandipan.das@amd.com" <sandipan.das@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: RE: [PATCH v5 2/2] x86/resctrl: Remove arch_has_empty_bitmaps
Thread-Topic: [PATCH v5 2/2] x86/resctrl: Remove arch_has_empty_bitmaps
Thread-Index: AQHY0q4TNSOdbwBlQU+Gy/s7V/kRKK3z6e7w
Date:   Tue, 27 Sep 2022 23:20:22 +0000
Message-ID: <IA1PR11MB6097582875AF02B7820A41E29B559@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <166430959655.372014.14294247239089851375.stgit@bmoger-ubuntu>
 <166430979654.372014.615622285687642644.stgit@bmoger-ubuntu>
In-Reply-To: <166430979654.372014.615622285687642644.stgit@bmoger-ubuntu>
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
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|CO1PR11MB5059:EE_
x-ms-office365-filtering-correlation-id: eb02b70a-5b3c-43bf-eafe-08daa0ded9a5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JYa/yMzdeyZ27J5lRBkEppgSz3gkE50Z4dlHC/l9oqdHCNHgnHyjIcz8cfqCLBCgRP6lzDaK8PknSSMOZWlHeIOfJT6lGqAu0+SDZwZCbCVbkfnMUm0a1iSqi2XYeTUF6tjgpptiksp3DzkEk5fCEzY3GBeuB8JBUiEQeUiSgYBXHuRuF/SaL4uDPVuolRUdzdSNLV4+I7bo82DOxvRDutQ1ziX2cNmLCL8BxxhG2UuObEVp0Qlma6OV4wsCZ8FFNpslQfbWG/d7Q7rXG5j6UvB4/2OcgCY3AIYtm849nG67X9FsSm4c8eo1Fb666kpljnNmw2FafBvj75OEii6Bxyd9NsXaOwK6Qu8rk9PL84wJ0zW/4ffreMIQwcyULk9KzToYW/3xyBHKf7iwY+x7IVIVgVqS30w1QZ7EZBbuHlbJuQ7lrAYTz9oZ9c+5J8x+ZvisOFYw3Mh95u5df0zN6SxzL3pfYR9aVU5yvGxR4icDAo9yW/smlKSa7+xP3mX6OTW6Z9tlrCo2Y6VbotKXAL5Nkh/+Bhe8iBO/VPw36PtdDAVGjgJ9xvMp1mAsh/9CxwrpQv0O8MNvn16k1YdBvAdp2X5DXOxCB1iOhEJwoqhtSpShx9t+32PVn3ygyB+bZ4FXQTp9iEW4oyYuyevYZtYbKAVIwChgVjMrs+7w6EYQnceJcsNSfqxj5d3gOJwxErLIt+aso+/QK0mPBx6sSwi3hroYnTqbwTzOAW/qcfW1i61q5u+STZKPMTtPkXXZNJEHjq2EsW1S110A4LGRYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(110136005)(54906003)(316002)(66446008)(38070700005)(82960400001)(55016003)(7416002)(52536014)(8936002)(76116006)(33656002)(5660300002)(86362001)(66556008)(66476007)(64756008)(2906002)(4326008)(66946007)(8676002)(4744005)(41300700001)(26005)(9686003)(71200400001)(186003)(478600001)(7696005)(122000001)(38100700002)(83380400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVl1dEVRRGVZSEE4aUZQSDlNc0lLaXk1T2k4YzZ4N2RuQ0VNVitENUtESGI0?=
 =?utf-8?B?TGdhRS9Xd0tqZDlHUHJrMkRBK3JOQTgwQ0ZSZFNXMjc5bHBjbC9uektrOGxk?=
 =?utf-8?B?S25BeXBIMUMzS3ZXeWZQNUpkQzRTaGdkaFlzZUhSc0s2TkJYUDErL21JTlZR?=
 =?utf-8?B?M21nUStGd29WRGpNRllwdkYweUlieks4WW1uWFl5S3N1TUR2WHZUVjNXNFNO?=
 =?utf-8?B?dmxXVXJlN1g5aFZEK1hMUElCbEcybU1hSUp0aU5jS2kvSUl5NzRmRVhKM0FT?=
 =?utf-8?B?NkJkWG5xR3h1d2lDV1kyM25nazF0MVJuWk44UytxeDUzYlZzOXk4SGx1cCtO?=
 =?utf-8?B?WDJScUtkWUR2Q1loc3l3bm5ZNUc3c2lFRHJmREd2Zkc1RngvQmVVTlpzVjBl?=
 =?utf-8?B?aTJrbFMvS0dUZHg1VWE3WUYrck16SHYweHRBOEl0Wk5sd2xCM3o4UW8xOTFp?=
 =?utf-8?B?SWM0c1ZoUnltUkFsQ0g3TmhJZEZHa2xFTFFRb2NrMFFiakN5MHdTeWRxcUwy?=
 =?utf-8?B?ZFB3eVdpMklSQ0JkMVd4R1pCYmI1N09Cb3I3OUQyZXM2MjhqOU9NRnhqR0Zm?=
 =?utf-8?B?c251Z3FvSGNGSGgrV1o2ZjZSMzhxNVVXREt6UmYzVlJhUHdnZzIyUndsWGNr?=
 =?utf-8?B?TDl2MndnL0JCOWlGL3FDT3pocWdLK0lsWG1rSmxTd3ZIU05tS3FsRkpuN1A3?=
 =?utf-8?B?Yjc4RTh6VlhhWWdmb1JOZGlsOWcrZ3lkR1A5bVNXUFlrbkh1WGhicy95dVZq?=
 =?utf-8?B?MXpSQnRlalAvdWJ3SCtnOEZDZUsvUzBOMThza3lWV2xTcWFUMno5R2U1MjI1?=
 =?utf-8?B?aFFEblpWMlhReVcwUjR6M2ttZlRIbmcrd3lrWTNnSVpINkdvWjI0QTNZTGJO?=
 =?utf-8?B?bFAxRjVXUmlzRGFRSDVIb0x2aXhOT3RYaXlxckRrZ09wQXg5WjJlWWtpRG9R?=
 =?utf-8?B?dHIyTzZnVnlHWlB6QUFEK0hHZ21lRzc5WGw2U2hHM3dHZEgzSkM4ZEd1cEdM?=
 =?utf-8?B?VVZpcW5RZE00M29mRHZab2xmQ0dZTERCc2dERGI4aWtNWk0rbWFuVE8vYjNE?=
 =?utf-8?B?ZjhkZGRYUHBMb0Vwa2o5WWZLbWRyaFpoWllYay8yTmtRRllVNy9TN0h0TmZZ?=
 =?utf-8?B?c29nNVVMNmJQUlQ0YTVkeng1MUNIMGpZczFnMEE3ZHhyZUhVL1NJWGZkSFZw?=
 =?utf-8?B?YWZKd0Q4ZHZYaXRCeTRNT1pqajMwSU40YWNyc2ZOWFNNcmgzZDlXeDRiaS9E?=
 =?utf-8?B?cXV3bEl5T0JSSUZ1bW5IdEZzVnZNaTkydUk2OCtQZmQ5Yzd5YTY4S00wbDhF?=
 =?utf-8?B?WEROeDdRTXlhUTROUnByV09nMGYwU3hGMllmWm12bzNkTTM5cVdJdGZmZWpw?=
 =?utf-8?B?cVVyTTZ2eWRBWnljSGJFbTV1Y0FNalVEa0hTcUN5RnIxelRIYS8wWDFPSC9s?=
 =?utf-8?B?MldDUUlhUmhyMk5nN1RYL3lrTXNHQ3JKTWxGdTBDMExyNGQySERmOTlyQThr?=
 =?utf-8?B?dGlUeXF1QWhzMzJ6MWdzRVZ0c214OTE2a3RGN1JNdFIydXBIYWg0YmdnVVh1?=
 =?utf-8?B?N0RlcFVoNUtoVVNsWGwxM0tQejFUdFJ0djdUTXdCaDVTdUFaSWxpaHNaYWd5?=
 =?utf-8?B?TlNtRGNJdFlJKzZuR044MFMya1J0bEpXSlBwejlvaXQ4UXIzNWlsM0NJN2tS?=
 =?utf-8?B?d3RFSTVsdjNBWUtvRklaUW1Za0V5VTZaQUw2czh2ZEJyeW9JWXh0RGI0WmhW?=
 =?utf-8?B?c2xDcldiVXJGWkZHY2N2clZSRXdDNUlGYzFQN1BnV2QvKzJxWlQ5ZmluYmRs?=
 =?utf-8?B?dElheUU4UFRjclJ6SzZMT3Vsb2RHa3RWV1VWalhkYkVTKzVpVUhwMnBmcTFs?=
 =?utf-8?B?T1diOXlWaDcrVVJIa0ZjYmRIZXJJM2RmeTZ4ZjV6aDBRS0ZsM1NmdDJVYVNW?=
 =?utf-8?B?cUdIUXdaYWxGbzhMcTNDd2hpU2R3cytva0tjaUNHaGdTNmRIR2hRQk1DSFJz?=
 =?utf-8?B?QU9OMjZNakR0d1p0VlNuQVNyZkFsOGFJY25NMW9ZZHVqZXVINmcyaXhKS0F1?=
 =?utf-8?B?THZkaGNPOEdlMjcxNDRSVVVHU1lNSkFSaHRjaGNzSXBTRzR2TnI2azRrbEJv?=
 =?utf-8?Q?jjinyLNwnNbItaR4PWJ/53xh5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb02b70a-5b3c-43bf-eafe-08daa0ded9a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 23:20:22.0591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nISpzGVzsOE6CSu+bpK8bSNCWDOCGXQb1dKZnUVF/+QRGQfZPvD3ai/Q+unkJV/A5oHCbxdw5sDbOsECYS7yUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5059
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGUgZmllbGQgYXJjaF9oYXNfZW1wdHlfYml0bWFwcyBpcyBub3QgcmVxdWlyZWQgYW55bW9y
ZS4gVGhlIGZpZWxkDQo+IG1pbl9jYm1fYml0cyBpcyBlbm91Z2ggdG8gdmFsaWRhdGUgdGhlIENC
TSAoY2FwYWNpdHkgYml0IG1hc2spIGlmIHRoZQ0KPiBhcmNoaXRlY3R1cmUgY2FuIHN1cHBvcnQg
dGhlIHplcm8gQ0JNIG9yIG5vdC4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogUmVpbmV0dGUgQ2hhdHJl
IDxyZWluZXR0ZS5jaGF0cmVAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2Vy
IDxiYWJ1Lm1vZ2VyQGFtZC5jb20+DQo+IFJldmlld2VkLWJ5OiBSZWluZXR0ZSBDaGF0cmUgPHJl
aW5ldHRlLmNoYXRyZUBpbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBGZW5naHVhIFl1IDxmZW5n
aHVhLnl1QGludGVsLmNvbT4NCg==
