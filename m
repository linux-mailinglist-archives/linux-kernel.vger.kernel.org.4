Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932536CFFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjC3J3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjC3J3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:29:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8EB6A56;
        Thu, 30 Mar 2023 02:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680168547; x=1711704547;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ktGP+X28KLFg19EgOz6YMIZNX+5DIradhPmvTcz+7ic=;
  b=Naa8GoY4nGTY/jfgIe7h3fPj1zE5LYZ3ZjwFPoBdzI43OIWF9Nkxje/N
   EwCyktZuOl9rUnYehE2eu4Q1vbAB6VLTh8fHsBRiQmwwD4Lj8aUkeuO65
   kHAobl0ZNddQ9W/p/bGmozckfzW9uck18WTQEfDleHC00C4Ls9Qd8rYMW
   Ku/HlmqVVaIo0ISIpxPJYASn+skIiyAqb9Lx7wi789YSsLHNM4VnB4+L7
   xas8Z2o+o7LB+7VVh3Tqm+IkhHEYGUAIWB+eFMSZUH0zGm7+bWY+pHu03
   pi47htllqxhVrvzJh5rWOYexBzqEmavsTx5GqsXn4FQCEBQtpHfQ+s3Uz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427395219"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="427395219"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 02:29:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="858835265"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="858835265"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2023 02:29:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 02:29:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 02:29:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 02:29:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 02:29:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPoJ2GaXWzmJ9Phru+Xu7wlLNvm8hbAtlst714uDZgpm72FkRbM3nOEao0nNkgWPPs7d95wI5KRBs3kYprW1doTjj4+4hFhCRFbV0F6jL+ATyz3Ilh5TfPol6RK/9aMkt85bFU2oEjsLxOMtOqMkaQ+Yq5nNSUUR+mAXcn1K8lrjR72FNeUWgdZfTUHj9cg1X3idKkKIVASkIFRC7lJ2aF0LDgtiCppl8sXvtLHvJT8sXPF2s50p0WsN2QpGkSgqd6HFEBSWO+A8ZL9KLRZ2qcYB8SFHTJM5D3Kzh34F2thcUoOHhSlPRDIEEe4tEnkS1I6tDoauZ0ZHFkXbGFQAvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktGP+X28KLFg19EgOz6YMIZNX+5DIradhPmvTcz+7ic=;
 b=GnkjQvZz63h6usHzr0v90jf1j8fBgdlKnCpIZvI3gvfb2Lkhq+WmT7SWuclLG1SL6Xds1cSjNYISOTm3XI/getH4nsG/qZC6KTlifDxJvHMIDXbhtRrL07PYk20urEZjG2C0XyjtJOG7Okn/Z8yQ11iOj7q7acTH9nRtw6+/Ti1DD0+UWOwSZpjBN1qmKbBE4A/DRdl/frg73ms4TTSVu1QDO9x1e0Xda4X0IJC369RL/dfsGu4PIu95uoiEO90sx1to7PfsPCNT3WRIeOx2NMCYxt3FdKm7FhGANoYEq7yKompdBXj+2H10BFd7Y0ecmvzLm8y3n0NrSz2CFJW4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by SN7PR11MB6728.namprd11.prod.outlook.com (2603:10b6:806:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 09:29:02 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 09:29:01 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "Brown, Len" <len.brown@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eric.devolder@oracle.com" <eric.devolder@oracle.com>
Subject: Re: [PATCH] x86/ACPI/boot: Use FADT version to check support for
 online capable
Thread-Topic: [PATCH] x86/ACPI/boot: Use FADT version to check support for
 online capable
Thread-Index: AQHZYmZqwCMAvwKNHEqwiN/tJdsjC68Sg+yAgAB+F4CAAA1NgA==
Date:   Thu, 30 Mar 2023 09:29:01 +0000
Message-ID: <03ff7ae227378f5cb422c35dbbbb02075164a9bc.camel@intel.com>
References: <20230329174536.6931-1-mario.limonciello@amd.com>
         <27c83d42e9cd95a1bfc34fa278315224a63cc062.camel@intel.com>
         <20230330084123.GBZCVLM8Wz8fBsKr7z@fat_crate.local>
In-Reply-To: <20230330084123.GBZCVLM8Wz8fBsKr7z@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|SN7PR11MB6728:EE_
x-ms-office365-filtering-correlation-id: 101d76a6-0d21-49ac-a808-08db31013293
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VnUKUZLf1eDW5wHZFWhLqhhTvlw40uJ1RLu/KwKRAzEsuiUrH5zgdg1g4oDNYpYhGtnTMLAOQYvoapYw3gFtbbwQszJbVs6PZR2ZF+xJ+gDpKDdFXnK1caK17Z7AT40ZnlCI58mhENuxnzQsxjQB+qA0QLt17cqBjfN0DlBPw/5bYrC7arPEC37HRCbQvvToZ4pK0KLDaEjH9PYM4KYXDjFzxBjWAwPpZEmJqbnFhy3dqauwTZ1RDiuVkM79bPprZOA2Nf6ePzoYARMtnnGlQFggDp0sN8F34YNGu73uRP/YNZImPkElAGnmaZGsMoTnpFYKg0BB6Dun+6ypYXvebh7nTOuKwLGKzfmDMo8LGf8pEP4aTvyU5OXu6GF9qkxOyxNK1071pHDkZ23EcpwEwX2QE2yVIM90jPX8f9bhOawRCw1o1dpafZ25sptyMz9r795si3Extc0eQQK9qCuxBY7g6kO/MM0Z27bUM8PXQOpb9Y5kAj6dJChjDIA50+b8BumLVYrvvabxGYdcYy9+WWjvraE6lwbXkd8Coa1ljtWEWAfe4MK2uPRw1ZirEyHtO044R1KdNJOE/QdrKAem5vCm9RqrLPgXEkgIfd58+2iVW0/pX5aLe4PiMG6o+yEIQJud2ne88pmkMUoErUxsOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(316002)(91956017)(186003)(54906003)(36756003)(2616005)(38100700002)(122000001)(6486002)(38070700005)(82960400001)(478600001)(26005)(966005)(6512007)(71200400001)(6506007)(7416002)(5660300002)(4744005)(2906002)(66556008)(41300700001)(66946007)(76116006)(6916009)(8676002)(66476007)(66446008)(4326008)(64756008)(8936002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDAwa01HM3lwQWFtM3dYdHFyVXozU1VJL3ZObUhHRWxBcFRENDdjUDZETnlH?=
 =?utf-8?B?ZGJMVFNITFZpZk03WFZTRHUxN1o4Vk9vcnAyb1piQXZ6eUlaYU9NcWFkS1E4?=
 =?utf-8?B?L3pmc0JVc3FkejBNYlIvaHVZQThHcDU1ZldHRVNJWUZFMUk3MkhsbUhpMjZa?=
 =?utf-8?B?UmsxNURGNy9BeW42cVcrdGIwK1VscHJ1MWp4NFJmN0J5cnd0eHpOM2kxcjZU?=
 =?utf-8?B?RG9GVmplOWVZZEg1dWdyTnZ6dXJhN1NEdlhVU05mUDhBUGNSdGJpdDZseURx?=
 =?utf-8?B?ZFZ3UEFacUNueldjVWFCUWFBZUxtbVJwaUtqakx6ZktaYjl1NE5PYnZVTUEx?=
 =?utf-8?B?N2J1UFhZZUNRYzJWYmxGNjNkeDhaeE9obHV1TWQ4V0k2NnZQRllLcTVlZkIy?=
 =?utf-8?B?YTBEMHVheUVPZmF5OVJmQ3k1WU9OUEZNSGk5OEFQdkFQc1ZrYzNsd0lZWU5j?=
 =?utf-8?B?S0dEUU9PY3J6Y3RHaENkdng4UUZOV2ZSQmJ1TDROa003Myt3cjFweEFVMXJL?=
 =?utf-8?B?QjVnM0cveGFtU1dZcElCRG5EVmhZU1FyUm9wMkFQRjhON1B4am5FT1d2OXM4?=
 =?utf-8?B?Vk9vOGZhY0lVc2Vva2Vxa3plWnYzZmMyYVVxdkJ3NjkxOFpOUEwrNFlhYnMv?=
 =?utf-8?B?akprQVdJM3Y2T3k5eGFuemdxbktEelRpSWZBNVptNXpQRUtuS1QrVGJMc3l6?=
 =?utf-8?B?QVNTanNJUVpIWHhhWnREb2plZjFxSHg2dHBoMit2aGN1M3ZsRCtHWlJIcndV?=
 =?utf-8?B?YlIyTGN5VHNpc2RPWjU3TEM5aEg5T21nVFkwaUVLSFVwSFlnWkZRTGJXamlQ?=
 =?utf-8?B?WVFmNHY1cklTRmNjbDMzcmRLMmkxeEYwTTFIVmp6aGQzb2lUUk5XcVkxTlVp?=
 =?utf-8?B?SGZGdEF4QTFKcGJHb0M1ejZLRVpteWM0TTZFaFFXODY2cXozbyt3VTZMZFBK?=
 =?utf-8?B?WGJXWThXTzluSEk1WHhsZGlJSzczTlpzczBhMSt0ZzlpNHk2THBMTEp3TS9v?=
 =?utf-8?B?aVFBcmV5ZmNGakFaQ2J4VEhlY3BEQW9KanRCNGlWQ1lJamx1bGt6aFpNMElW?=
 =?utf-8?B?STJIVUZWYWJxai9EWEs0K0Uyd3hIS1FuMENWNklhSkFLQ25QZ3k5Vk96dGQx?=
 =?utf-8?B?dkFGazJ6bHVZcmhTaFRUTm04b3VzWGtXQVdYaHdWaXhIQ0RyL0hmWHRRWG9w?=
 =?utf-8?B?Y2xoVStuakdrREY0R2NEOStlREJlbVMwSG04SUt2c1BDcW5EbnY4bTNvNktQ?=
 =?utf-8?B?eEpmZ2FFdS9kWFJyeTZjN2UvS3RRb05zUU9md2czTG5zalRWWmhWZDJjcU5v?=
 =?utf-8?B?ajlQRDBCcVZRY1VyTjhlNlVQbkY4aTRIaWlpT1UxV2FaRHFkTmVycFFPN3Zu?=
 =?utf-8?B?SC8vQVEvYnAyNitxQytyQzA5SGhvLzJsM25vaTdXSFZiR2ZZMVpVdlpMQ0wv?=
 =?utf-8?B?ajlqamxxZm9BYVNsYWNLNTlidWc0V1FzTVVyZVl5ZWx4d0tMYzRaVnlZNyts?=
 =?utf-8?B?UTBIc1pJZWhYUlVIb1ZpeGxMYmcxbnAwdEtLazY1YU9kZXZURU1xejY0MDlJ?=
 =?utf-8?B?cDVhYWJvSWlacVExWFNSdU1wZHlJaVBubUQ1UVdlSHNMN1I3U0VCY3RielRt?=
 =?utf-8?B?MExuWHdRZXlUdWtjMkUrWHRHbnhRRTlORC8zLzNERXZlN2F5VjRoQldaUUZX?=
 =?utf-8?B?WkRkT0ZkdXhzSVJ2S25aRC9YY0JISXZKajlyenFTZWhWOEJSR0ZHL3d6VHlM?=
 =?utf-8?B?OGhyNnFrREp1T1UzVlVlNkcxaXREMmR5OUNmUEJCb0lTNFZPVncxOHliSkpt?=
 =?utf-8?B?OU1ReStSUTF0T0sxdWxKb21EUnpUVkZ3RjdxTnpQRnJTaTVVem01SnhCbVpX?=
 =?utf-8?B?N3pPZUNta0o0RUw1REgzMldLUVhRR2tDckRJdTlwWFNnRmVGa1FpTlI2YnZm?=
 =?utf-8?B?Qmt1SnZoQzdnM1JoakE5S1BZWEhSbHN6NFN4Wm1zQm10U0drRWxzdkgxV01T?=
 =?utf-8?B?aTBEVlZxTysxejRkelVYSXdpZVlOdmpBbm13bmQwSkJxK1dERjI3NnBTVVE0?=
 =?utf-8?B?N0x0TXd3V3QwRVhBMmxYZTRuSERJa3FSd3JSOElLaEE1YkNxUDRWaThDeVFx?=
 =?utf-8?B?YTNTQXZmQjRtb0lwa2RUcWU2YlFHejlpTjBsZGQ1bnF4ZFg0V05xVDJwaUFD?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A92D2408E7F4CB46BB76215D1D141EF4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101d76a6-0d21-49ac-a808-08db31013293
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 09:29:01.6010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4F4NYuJ43uy0YyY1lusaICI4wdQkzTi2weCKbwj2PSIHXXtU/lHZEMs4YIg8gREcJE900PtimpEmbHKLumFtWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6728
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTMwIGF0IDEwOjQxICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgTWFyIDMwLCAyMDIzIGF0IDAxOjEwOjA3QU0gKzAwMDAsIFpoYW5nLCBSdWkg
d3JvdGU6DQo+ID4gSW4gaHR0cHM6Ly91ZWZpLm9yZy9zaXRlcy9kZWZhdWx0L2ZpbGVzL3Jlc291
cmNlcy9BQ1BJXzZfMi5wZGYsDQo+ID4gTUFEVCByZXZpc2lvbiBpcyA0Lg0KPiA+IA0KPiA+IElu
IA0KPiA+IGh0dHBzOi8vdWVmaS5vcmcvc2l0ZXMvZGVmYXVsdC9maWxlcy9yZXNvdXJjZXMvQUNQ
SSUyMDZfMl9BX1NlcHQyOS5wZGYsDQo+ID4gTUFEVCByZXZpc2lvbiBpcyA0NS4NCj4gDQo+IFRo
aXMgaXMgYSBoYWNrIHRvIGZpeCBzb21lIEFDUEkgZXJyYXR1bSBvciB3aGF0ZXZlci4NCj4gDQo+
ID4gSW4gDQo+ID4gaHR0cHM6Ly91ZWZpLm9yZy9zaXRlcy9kZWZhdWx0L2ZpbGVzL3Jlc291cmNl
cy9BQ1BJXzZfMl9CX2ZpbmFsX0phbjMwLnBkZg0KPiA+IE1BRFQgcmV2aXNpb24gaXMgNS4NCj4g
PiANCj4gPiBTbyB5b3UgcHJvYmFibHkgbWVhbiA2LjJhIGhhcyBNQURUIHJldmlzaW9uICI0NSIg
aGVyZT8NCj4gDQo+IE5vLCBmb3JnZXQgTUFEVC4NCj4gDQo+IFRoZSB0aGluZyBzaG91bGQgY2hl
Y2sgd2hldGhlciB0aGUgQUNQSSByZXZpc2lvbiBpcyA2LjMuIEFuZCB0aGlzIGlzDQo+IHdoYXQg
aXQgZG9lcyBiZWxvdy4NCg0KWWVzLCBJIGFncmVlLg0KQXMgdGhlIG9yaWdpbmFsIGNoYW5nZWxv
ZyBtZW50aW9uZWQgdGhhdCAiQUNQSSBzcGVjIDYuMmIgaGFzIE1BRFQNCnJldmlzaW9uIDQ1Iiwg
SSB3YXMganVzdCBjaGVja2luZyBpZiB0aGF0IHN0YXRlbWVudCBpcyBhY2N1cmF0ZSBvciBub3Qu
DQoNCnRoYW5rcywNCnJ1aQ0KDQo=
