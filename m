Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C386368BC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbiKWS01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbiKWS0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:26:17 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7464668299;
        Wed, 23 Nov 2022 10:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669227976; x=1700763976;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BS0yb0pDGy5CnenSYnGgj8YOiOkC/s5LHURPESw5+oQ=;
  b=MjW1lNymtKs5R1DDN54xq8kh2bwxJAOExfLcGCl9/MhxydywRJnMZpvk
   o8RnLxxDq7wKx7gY6U7moqDZoCOL5Um9LMXnRMv2kgI2JObUK95uwmK1G
   j4uDJzAJAc5qU50NxJ77Amea2W9jwE1kmvQdjayfCeS+p4gQfjbu2NWFa
   fEZG9Blb1eeOaUIjA9akZa17m2Gd1c0wEvZfMbTz0xtspyzNEYMEXpv3V
   34yMRp8uUsxgYWS/LfrwXfnimBfZUO4rfSQ/IxpypSLiee/xQ12PHs5FJ
   9a0rKXVBm63DsXHWh+2sAROaL5yTMRvHSPukBbKnDCZ81OhWpbMXWxICY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="376276690"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="376276690"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 10:26:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="747901679"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="747901679"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 23 Nov 2022 10:26:15 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 10:26:15 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 10:26:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 23 Nov 2022 10:26:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 10:26:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF5kqO4ABKjlK8N4UpIMwvTJ5nFGsmVkmwR+kjidNhMi3iT7DVYreSuoPX2sQzSOEkbISz5FKX+iXOxwenwICbDKswMm616xaafbh3zO4cEITLtffWnFGmZ6YrwKn6uafXD+Q5hFuKIk28EabCxQYKtF2Q8AVW+GYKlixDpNFSnbnwmQJ6AEOmhhVxufnCLw8LglEp1a0xA8mo4k3j3MzJaU+nHQYe8A2i998JrRyhETFy9g9ULwBbN37i27Hd2JM4p5y7qbP6rRpUz0U4pWP0E1QZh9+5Kiq7gj2DedlaF7dq2pbMLIh01kINzPdFHQ+fyGawRMWgQ7s2OFIvJpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BS0yb0pDGy5CnenSYnGgj8YOiOkC/s5LHURPESw5+oQ=;
 b=Fm2oYTiMR8bVwPWlWnqvb8kihSSYOdInI3UhUM4LlCGaY3V+43prUERbbVN9KLOcEGSt5aaNhu//kNmdGi09nJx4p9smTZnYWs33Ph+QgAQvKSDc26qufCtWkDeM/GRsCQezurbpBfnLs4qyDo2ZNiZPofbpislMBoj/+7XPQp035bUEkYevs2oy3EWiE8IN65hMdPIzqt//fiO0MDxgMfU2IvREZVgPb7UORzGikkWM1mOWlz33N97PfFePuFbxrltwl2cGSphkc54OiIcAo3zHpm5oZiaRrUP0eRbcsqh5Ht+wY6+bXnLIfyYhr4+QKLPuL7p26Kdb+TlZBdDp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MN2PR11MB4616.namprd11.prod.outlook.com (2603:10b6:208:26f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 23 Nov
 2022 18:26:09 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%7]) with mapi id 15.20.5813.018; Wed, 23 Nov 2022
 18:26:08 +0000
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
Subject: RE: [PATCH v8 04/13] x86/resctrl: Include new features in command
 line options
Thread-Topic: [PATCH v8 04/13] x86/resctrl: Include new features in command
 line options
Thread-Index: AQHY8IgqBVIIFzf6cEimjicvZGDWva5M8HkA
Date:   Wed, 23 Nov 2022 18:26:08 +0000
Message-ID: <IA1PR11MB60971490748735986747545B9B0C9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759202231.3281208.4695877999050945787.stgit@bmoger-ubuntu>
In-Reply-To: <166759202231.3281208.4695877999050945787.stgit@bmoger-ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|MN2PR11MB4616:EE_
x-ms-office365-filtering-correlation-id: 6d7dc406-dc54-4ee8-26b0-08dacd8030dc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fzL0qGVEw0Fclh67rGCmGcs/zerFX8DNs48jKX/xxPPvWWC2kqnnEQhLCbg40+vak3G/wYLcwpslbVoi8cn0tISLN+6cOSw4Py1j5EMmiddlKwmrQS2x3S77ejBL5qD4AypndF7z3Ee7sx6UReIokKFsW3HJ8ULNU/RY42APvoElgYOkWSRdSTijQ+JvpuYfrqNTJaS7dgO4+PQtsOpSn/F7XpWhHSi+B7HxsnwLEyidtWd5IIpEtqt+yDGCuBIc5OJH80zS5cPqejZ+hKzoYVxYRZbYCB5DzrABI+Zr14QhYR8rGTf6gai+0skiUPRUkCMIYnBt7YED4XFWTRjSwdFjK1ip6vDfRaAw/ejvJggffz247NhqAMdHVTUF9HF3LM1AQyuivF+98DcmoqnIGDG/g7GL3sDlXA68NALIisQA3n7VCSz71A3hwMiSgs4G9RURaCv+7VM8E30vFbPRKUmeOedevSG/BGG9k/0i06ZRdxtn9e06LucRCxLVVOWveVi+LRYdZT9uwXJKEw988XGvo4pMc3g8itCqQsM2Uv64e1lrPcWUxygSEiVY7Ngc2frL3YZhdjAyOst7z3UI4QfZPzYpdFrdjkI3QCKDS3fxWzcshjjE8eQTTeudplyaDSSpAo5fBxUUmH78SGAFKyL1M3BheQ3hiIDToJgZAVkzUQYKHEhwcEM6Yon+9dfSYMtO1arxxBSAxOHB8Ns69w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(4326008)(41300700001)(66476007)(64756008)(8676002)(66446008)(66556008)(83380400001)(186003)(76116006)(66946007)(478600001)(38070700005)(8936002)(26005)(5660300002)(2906002)(86362001)(7416002)(52536014)(9686003)(110136005)(71200400001)(33656002)(55016003)(316002)(54906003)(7696005)(6506007)(38100700002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bko1NW5NbXlPTGttSUg5Tzh3dUdXTnkxKzdET0tFdUszSS9kY2tab01DNFFL?=
 =?utf-8?B?OSs2TlljTWlGRWwvWGRqZ3hpZ2plNzN4M0VhSC85emlTeWgrdG5Xdi9CR0Vv?=
 =?utf-8?B?K1M5NzJqZXVUelNFUWRkd0NaU1huM1A0c09sakoxdzVYdkNRVGgrUmZWNzN3?=
 =?utf-8?B?REJybFhWQUVOdzRGZzFMNHloQytPbHJtVkRHRW9lYVpXdVZqZWJVRndWdW43?=
 =?utf-8?B?dTBhYTJ3Tkw0dzhKUG1OYTAvVG0rQzRnRTU3T2dmaTdNN1RlTHpzeEtkc3hj?=
 =?utf-8?B?QmF3bVpNSDY1TjAwZFhaQzBzZTZWNVcwaVNTK1pRZ0oxOTZZd25qQ1hYKzY3?=
 =?utf-8?B?b2pydStnQ2QxMkJ0amp2bkUrbFVFZEFaQUZJcEZvY1V4WkVTa1B2NmJVNXRh?=
 =?utf-8?B?blJaalBEc3hvNDNNRUwwUGd0aHZHZjFiQ1kyWFdLV3BoSnZCZ3BVWHI5UkNa?=
 =?utf-8?B?eFBmaWNpN3BKRVl3RWg0RHU5c1NYQ1MvMFZ0TVRrdnJKaGJ0TG40V0l4TXg3?=
 =?utf-8?B?Y2tUckFsSkR3NDlVSlpZWFlvVHdSMTRRYXlpa1NHOUdwV3NSRDhRN0dhRFQv?=
 =?utf-8?B?TUpJMytzNG1TMHhMSWplc29GN01hRVNRcVFvcWprUUZpWFErQzVxYWVVb3g1?=
 =?utf-8?B?anQ2Q2lWT0t3cysrNmtNMFdLc2Vxa0FZVnAzOGdJU005VWhqb3NJYW51Z0l6?=
 =?utf-8?B?Sy9GM3ZiYUVIVnc5VlNaMlFDRGl3N0d4UTB6ZXpiRXN3YjYyUSt6bFJTeW12?=
 =?utf-8?B?d0ozSk9TWG9xNzJ4VEtIU2NCU05mY0JhYXRyMDh2UEtMVFExc0F4S2hacStl?=
 =?utf-8?B?ZC9iUHRPdXpPQVlDanFUY01CWmJjQ2QzZmZXQTNuRmJQSkNYUVZPdUVyRllR?=
 =?utf-8?B?OUNoQ3B2bDJJbG90YmpHYXN6WWQrMlo3VDhzbVRaOWwvWUFWQmQzVEYrWTZh?=
 =?utf-8?B?MlJ0clRMZ0kyaE5GZnY2L21yRk81V1IzVGhvdUlaS09MNnRUeG5GZi9WMkxz?=
 =?utf-8?B?MldNYmFMTXVITE9jb2NkOGtvZmw0VVQ1QVJlTTZHSHpEUGNINmszZ0ZOMTQ2?=
 =?utf-8?B?amJmMWRvdUthckFaWnc1dDdqSEozQnJVeGYrbXB4VTJDRjF5Rm1zSitKTzc3?=
 =?utf-8?B?dWZNSkpiRXowRTdMWUNRc2g0Nld2Rks2NHpxSVdWL0NQRWJnYkxpTnJBNUZS?=
 =?utf-8?B?MzFMMUdGZnVoNkJDWkY1ZmZnM3MybXZrK0pTOWd3QWJZY1hpOURGeExFVHJG?=
 =?utf-8?B?OFBUbWFDaUdNZU5sQmF3NGRhbHpyL0ZzKzI2WFZvbWV2YjVvaWZETTU2M1BO?=
 =?utf-8?B?UzFZZTZ3MFpqNjdyYWNjM0t0TExIMmlZeEsrd0M3aGg1WmFGRVd5bWc4YkxK?=
 =?utf-8?B?V0hTWnRtMy92Z2pYQnJnRzdHaUxhOWszR2x3eGtUVE15YmZrUVRuYy9hRXBX?=
 =?utf-8?B?RmJOZ21zU1NrQk1DWnhIZkNNcXFkRWhDQXQzOXl2VVJzZUlFM1R3MzVRSkx3?=
 =?utf-8?B?VmN3MTEyYmI4ZTRTdW9tK2pvWS9BSURudi9RZVA4VGhkMHJqcXNPQlN2dzEx?=
 =?utf-8?B?ejBEbTRwL0VINFFmK2p0eDVqazRBbTVsWHZqbFlKNjN0QWV0Znc2dHdPeVpR?=
 =?utf-8?B?Z0VkdTlEQkgwWnJ3Z2tHeHVSWjJSK0xKTlVxa2gweVN0TGNsM21QWnRTd2Zv?=
 =?utf-8?B?STQvc1RZNk4wTUJhdWp5dStWRFVZWGtJZzJ5VUMyTjM0Y1BpeWR0V3FUbGNG?=
 =?utf-8?B?YkFWZ1JYSHFDQWNNdmFtcFZuenJ0TVdEMUpnd2dSTjhFaE5RRTR2dzlxMVBy?=
 =?utf-8?B?cGo3U1lNQno1N3VJVERnOGtmOUpFWFRYeGtrTnUvV3JYQU15Z28raDlZaG9C?=
 =?utf-8?B?SFkxZTRtU2NOZGhxSlVpQU9mK29rdExHZHMxaENMMFZNTUxXR0V1UE51VVhK?=
 =?utf-8?B?K0Nuc2dOTlUvL3p1eit1azhCQkxZZDRqM0c2NEpyVlpCVnVtZXgxa0JYdmkr?=
 =?utf-8?B?d041eE5FVWdPUFY4UExHWU1xUkU5WGl6VEFYc0FpVmx4Rm1UT0pUamhDdzRU?=
 =?utf-8?B?T0RpeHJTTXd3c1M2RGpCMmRpekhqWllUYVdrVm96WEZqeHVpbkcySDBmWHhC?=
 =?utf-8?Q?ScbR9R4UfclrVBi1L7k/iSFaN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7dc406-dc54-4ee8-26b0-08dacd8030dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 18:26:08.5276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qF6eN7sYiRf5EYTczFof9ETng+oZ8oESLFX8SGfHSUhDJs9czIrd5RyBC//z4S30xf+70OiSL8vO37hv3FboRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4616
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJhYnUsDQoNCj4gQWRkIHRoZSBjb21tYW5kIGxpbmUgb3B0aW9ucyB0byBkaXNhYmxlIHRo
ZSBuZXcgZmVhdHVyZXMuDQpzL2Rpc2FibGUvZGlzYWJsZSBvciBlbmFibGUvDQoNCj4gc21iYSA6
IFNsb3cgTWVtb3J5IEJhbmR3aWR0aCBBbGxvY2F0aW9uDQo+IGJtZWMgOiBCYW5kd2lkdGggTW9u
aXRvciBFdmVudCBDb25maWd1cmF0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmFidSBNb2dl
ciA8YmFidS5tb2dlckBhbWQuY29tPg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vYWRtaW4tZ3Vp
ZGUva2VybmVsLXBhcmFtZXRlcnMudHh0IHwgICAgMiArLQ0KPiAgYXJjaC94ODYva2VybmVsL2Nw
dS9yZXNjdHJsL2NvcmUuYyAgICAgICAgICAgICAgfCAgICA0ICsrKysNCj4gIDIgZmlsZXMgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4gYi9Eb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiBpbmRleCBhNDY1
ZDUyNDI3NzQuLmYzZjA4NzAxNDRmYiAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4gQEAgLTUxOTAsNyArNTE5MCw3IEBADQo+
ICAJcmR0PQkJW0hXLFg4NixSRFRdDQo+ICAJCQlUdXJuIG9uL29mZiBpbmRpdmlkdWFsIFJEVCBm
ZWF0dXJlcy4gTGlzdCBpczoNCj4gIAkJCWNtdCwgbWJtdG90YWwsIG1ibWxvY2FsLCBsM2NhdCwg
bDNjZHAsIGwyY2F0LCBsMmNkcCwNCj4gLQkJCW1iYS4NCj4gKwkJCW1iYSwgc21iYSwgYm1lYy4N
Cj4gIAkJCUUuZy4gdG8gdHVybiBvbiBjbXQgYW5kIHR1cm4gb2ZmIG1iYSB1c2U6DQo+ICAJCQkJ
cmR0PWNtdCwhbWJhDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNj
dHJsL2NvcmUuYw0KPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jb3JlLmMNCj4gaW5k
ZXggNGI5NzBlNzE5MmU4Li5lMzFjOThlMmZhZmMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tl
cm5lbC9jcHUvcmVzY3RybC9jb3JlLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNj
dHJsL2NvcmUuYw0KPiBAQCAtNjU5LDYgKzY1OSw4IEBAIGVudW0gew0KPiAgCVJEVF9GTEFHX0wy
X0NBVCwNCj4gIAlSRFRfRkxBR19MMl9DRFAsDQo+ICAJUkRUX0ZMQUdfTUJBLA0KPiArCVJEVF9G
TEFHX1NNQkEsDQo+ICsJUkRUX0ZMQUdfQk1FQywNCj4gIH07DQo+IA0KPiAgI2RlZmluZSBSRFRf
T1BUKGlkeCwgbiwgZikJXA0KPiBAQCAtNjgyLDYgKzY4NCw4IEBAIHN0YXRpYyBzdHJ1Y3QgcmR0
X29wdGlvbnMgcmR0X29wdGlvbnNbXSAgX19pbml0ZGF0YSA9IHsNCj4gIAlSRFRfT1BUKFJEVF9G
TEFHX0wyX0NBVCwgICAgImwyY2F0IiwJWDg2X0ZFQVRVUkVfQ0FUX0wyKSwNCj4gIAlSRFRfT1BU
KFJEVF9GTEFHX0wyX0NEUCwgICAgImwyY2RwIiwJWDg2X0ZFQVRVUkVfQ0RQX0wyKSwNCj4gIAlS
RFRfT1BUKFJEVF9GTEFHX01CQSwJICAgICJtYmEiLAlYODZfRkVBVFVSRV9NQkEpLA0KPiArCVJE
VF9PUFQoUkRUX0ZMQUdfU01CQSwJICAgICJzbWJhIiwJWDg2X0ZFQVRVUkVfU01CQSksDQo+ICsJ
UkRUX09QVChSRFRfRkxBR19CTUVDLAkgICAgImJtZWMiLAlYODZfRkVBVFVSRV9CTUVDKSwNCj4g
IH07DQo+ICAjZGVmaW5lIE5VTV9SRFRfT1BUSU9OUyBBUlJBWV9TSVpFKHJkdF9vcHRpb25zKQ0K
PiANCj4gDQpUaGFua3MuDQoNCi1GZW5naHVhDQo=
