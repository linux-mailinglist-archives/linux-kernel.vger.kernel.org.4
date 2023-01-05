Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9E165E5B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjAEGyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjAEGyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:54:37 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10C748CCB;
        Wed,  4 Jan 2023 22:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672901676; x=1704437676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0LycktiQBaVRRYJYQyDiZofebNP4CLESs8tTHlUdufY=;
  b=mMGLaIrZ+Es6iev2YyWtCVzH85kBmXjWiPA5mSNAWQgO6KPURkICA77I
   k105AJovGDEOSEdBlLALBnt1Y1SIaLuLIfZeXWQtI6apkxXQXxJze2l/z
   79tkhg4gRAKMOAsU7sbxOsvPwIQeqLrC6HtXVXfj5QuD3pbmJaf3JA2Ov
   1CBQHnoxItaQ/8jS7FZcO4SXKN2vlLJOHr56vmBgO2gwTjHSri4XBRkKm
   sllDO7d0GUTDejE+dhS9/JJ9LfxW+eDVOFW69f8xkpgZdcREArospXXxR
   zzmjZEnsEYU3ocxNlwfz2aR3OsW71kUOzk+h0zbJJlr1nYL2m2sC9RSkl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="408382932"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="408382932"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 22:54:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="687786486"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="687786486"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 04 Jan 2023 22:54:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 22:54:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 22:54:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 22:54:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 22:54:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3GsIX8AGjtRiZjUnQHc5yRFDbzgewwuEWAzqshabaormpfHaYrG4vaTDxTEMts7fjSdqwvpb1HwrCoNUFwTw2XkTusCtGCvtn2yOG1+apbfMKRC3/sMSTcDLiAEI7leZ4sxnTaAA3quh7TmOZjXgPOMpMfa6dXhYkxMaingIcW/ONnRa9Nxv5o3V8jtEjNP7YoqnvnmDu2c64uvmaBbrQu9mb3uQ60fxpHBgy2H6KlN4AhclLoY9WUXw0dCc7MdSUgsyfKnTZtVb15IN5IYjS4MQPKy/xFH4b1pbXJp6wq2vhSc3w9ryP1NTnHRaHVa8Uph3ykL7WVD50Efc0KTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LycktiQBaVRRYJYQyDiZofebNP4CLESs8tTHlUdufY=;
 b=RB046tNhP/gqVYC/WJ8fV06SKM+1xN9SXSIflOhwgwcUonGx2vAm2x37zCvGQBaTxsMrk+Fml+qddNT/E7fwG8nUaj3iavvoy4PqDZ+YW/jpLJec3zfbs1Zyv35vvd3Irfl2pv2RH5Xe5QrkHvQEuIofeo7cKhKOdFa2tx+HcKqxkzubsE1GfOHP+JXjAtVazO9hz9ZrMTjXM7MbxiV90OGrlM1pkfyklt5NgBVKV9nuEc53uCmc3ZhSKSUxohr3hnfpK8uzFjtO+eaddQPWyEVBW/ctntf6pYGZGia14iG+HlGXWH61OfCd1pNbtNp+QQTku9JfRqELSlPvIIiA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH8PR11MB6563.namprd11.prod.outlook.com (2603:10b6:510:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 06:54:31 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 06:54:31 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Thread-Topic: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Thread-Index: AQHZIF1bxwQ7XEIB0EO18Lgdi7O9X66PZGKA
Date:   Thu, 5 Jan 2023 06:54:31 +0000
Message-ID: <ea9186869cca50a21efcc1a9cc4dbe5adcd1784b.camel@intel.com>
References: <20230104145831.25498-1-rui.zhang@intel.com>
         <25d07838-3904-a086-4238-f56c9424b53a@intel.com>
In-Reply-To: <25d07838-3904-a086-4238-f56c9424b53a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH8PR11MB6563:EE_
x-ms-office365-filtering-correlation-id: 87214101-ae82-4873-0d94-08daeee9b27e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RKmrKoJeDtazOP1BBerAY3n5K3vb1Dxnc7EaFngAvBsU3b6Qf2z75qSThfokur4pIoGOqAgbwXbHWwJMnwumEIYqf+mZO7KgrcfgiTCi2WF2tt49vf9pOvj07MsIQynZ1GjgvyvzCQSwBnaW0Eh/rwHH/EmW8ucfr8dtJvJB0YQlsN9LXyBWq+5+DANxxQM8U5qA1kd4ayoCtL5oDjhkYmqCvoejuZehhRo7H4BwUfn4E75J/t6aBB85gniGjSrCtR1ZXSj2wtu5owA2PFiNCY8eHRvzPauFV64hHMRomaKlU3favcBRusRw3jJ/CBpa6TL9QdCGqxat9sMzKBF3MuM/KoVNTlPMMiRlyMIw37dTgShfzAtMJSILQrTtH+z416or0BB6IJ1V+6KvLYdmcwl5uvusohAGCT9kCKrb+rRaqx3w0BB7Ix+GELfF95Mvqxi+Voo8ixOK2p7/AWwxL3nQg5cqVy4yg0YRbjLRIGvtbWscfIPZH02hOnhfJLod7bkDHQsmCLdjEY09wzj6swvgE/dE7lh9bO6pXQsjvOGWdeCIOGL2mtfd1oLYoA26+9hPWrFiU8NpOOWWPNg73OVxUH7+j4Dq5X6LlzP+wykvZgXBvlf7IC1HfDamvPZSJIie2WWm66g/dluGmJaYri1oJgz8bYSvL07P1MTgEj+ThMGMQbIIUajpD1EHuHPhtQ6tlNXDG7CRZpU2hN1nJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199015)(8936002)(5660300002)(2906002)(41300700001)(7416002)(86362001)(38070700005)(38100700002)(122000001)(36756003)(82960400001)(54906003)(186003)(71200400001)(26005)(110136005)(6636002)(66556008)(6512007)(316002)(478600001)(8676002)(6506007)(53546011)(6486002)(91956017)(64756008)(66446008)(66476007)(2616005)(4326008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEErUmFEMWZieGIyWDJJNk9NYnQxa0JCWkdIMm1xYzlKTDYxZjFWdTFIVzI2?=
 =?utf-8?B?eU5DcVJhUGFqbWNnaWcwTlV6K2drSWd4ZnVMU243bmlHT2FPWnQrS3VMWm9v?=
 =?utf-8?B?MHlJN01Lbm85UHJ0amY4bDlMVmlHK3hxZUN3WU4rVWNpeVVGQ2lGbW8zQkt5?=
 =?utf-8?B?c2kvb0RMbjB1K3plNWJVMlltYm8yWGs1TVV5TFR2c3ZXVGlocXBvSldsRHNi?=
 =?utf-8?B?RGhCTzBaOTZxVUhaL0ovZlo5V2VQaEZSakhuV2YrM3BzNlltaGxldis4czhD?=
 =?utf-8?B?UDN1bXFTUHRrcktqN0hCUkpBUThSUTFuZmJXQXJ6OGRLY3lGeVlZNGs5TklZ?=
 =?utf-8?B?QmRncHVMOUhTQjQ2cC9hZjVNMFdraEdhM1BNc1YwQlBvM1lUb1l5K1NjRXNY?=
 =?utf-8?B?QnlaNWdsb3gvS3AyQ1JIOFNvZUpmVW1iaDBlZjZScTlDbHdrc2FkVTJHWm1K?=
 =?utf-8?B?VVR5ZGVlV0tka0ZrTlZYejczKzNEOGJyTGxDTnRJV3lNN0dLY0xOeVZ1ZGpQ?=
 =?utf-8?B?Z0dob3U4aW9XWmdTVHp4Sk1sRXpZeUhzRjFWanlteWpNS1lPWjYzUjNKcERp?=
 =?utf-8?B?ZXJtWFZsM0hUM0VoUnQ2ZGxoRE4vcGtpcGYydURVNnIyK0xObGdJaWdBNDNK?=
 =?utf-8?B?ZWRMWGw2dFpYU1JEdnZQRGxrTnc2N0w5R1NaSG11MTNSNHlkekUwSTdXM3BV?=
 =?utf-8?B?a1BKK1lqbml0YXNJZ3Vkb2txZFNmYUx6M2FFQzE2M2RuQjJNUXV4M0daenk4?=
 =?utf-8?B?bnJRYW1UZXdYVTg5ZGgzVzBRb1F5d3U0TkQrRG1mOTd2aU1raEdzUmF6Sk5B?=
 =?utf-8?B?ZjducEJWbmdISGgwbTFHWWFkaEkrVnhnSGNYNE85WDlvMWRhZ1ZrdXNCYXBv?=
 =?utf-8?B?elg2SytQMm5sYlRoZ3h6ZGVaYUd3ajQwclhkWStZVGhza0R4TGlYTUVxYVpH?=
 =?utf-8?B?czJRYUlOWWlZOUlhcmZveDY4U0VUODhweWt1M0lEcVJuMmRJbFlUbmIzQ1FX?=
 =?utf-8?B?YVR4ZTdXaXU5RGpzb0wyNzlKbmdCRzY3MlRZZjRLZXFwS2hRSnNaMEF0SzNP?=
 =?utf-8?B?UUwyN2pxM0FQTEJTbVFWdXUvMmxleStYUU5QQXZtbFhDenZhUGE4WkoyNjJM?=
 =?utf-8?B?Y1p6dXVGcXh4UGxhMldiUWJhVkNmdm1hWDc3bnBHV2lPZk0zT2JuRDBxc1pp?=
 =?utf-8?B?amNFOXJ1b1Nod0hrT3VVd09qYlpraytrRXNDUnNJNEl2SCszUjczUGlwUTky?=
 =?utf-8?B?N3ViemFwdU1SOG9HY2Rmb1R3dnlRUFR2Q2pPUVJwZnBQbVlneU4xbTFCV2Ju?=
 =?utf-8?B?WDlZNFNtOHFRajZJejdOSzNWaFd4Ti91NjlyOXAyM1ZuSlVEMFo0L0tQM1FO?=
 =?utf-8?B?c0g1b1VkMXIrVi9xbU1sSEtxTDRGS09teVBIbHZkYjBNenNoNStUS0Vha0J1?=
 =?utf-8?B?R01lVC9XcXFKd1lKdXFvU3RMRnRyL3ZUWUo5aWc1YmltdWVNTFcyc0ZzWGpT?=
 =?utf-8?B?Q0l5ZlNMY1o4N2xmMUUxZHFCMDlDLzYxOUFZcUpKVFg3MkFBR01BV2xaZTEv?=
 =?utf-8?B?a2pQQ2g2b09qOFYvUDlqTThGbDFxOUZUem91NlFKT2s4UCtPdXhuaitlMWZo?=
 =?utf-8?B?elZGQ1p3NTN0UGpHd3dHY3M4VkxQUEs2MkpUOXdGNE5wVHRWNEZYQmx2RVlv?=
 =?utf-8?B?MFFoaVl5aW1paURRZUdGTFlvQXZGNzlqWmhZcVV2cnp4V2ZzUU0wR1FZcm9C?=
 =?utf-8?B?RWNENXZidGFYN2pubWhOMWw0Q0VaQ1NYVE1wR3g1YjhmTy9zV1VnOEUxVjZu?=
 =?utf-8?B?YVFVeERCenhhWTVJRzU1NWYzaFkxVWg3UTlDQ0Z6aTFKTHdqMEphWm1uM2dT?=
 =?utf-8?B?MEdhSUdvQUxDV0RxK084UG1JZTlLYUpXaUlJbFFheUhkcE90OXRDR3dRc2N4?=
 =?utf-8?B?b2FmaUptaVQ3N0JMbFdIdUJXSGY2d0hPeG9UbEpSMGtpZXNSNjhsZUNlMFZY?=
 =?utf-8?B?blVXNWhjbDc1MHZ4Q0NvVldyWXhwNVZxNVRrS2h2YlJLTkRPZ3F5aWd1Nlk0?=
 =?utf-8?B?d0Qwb01EN2dPQlZOdGlEVlpLL3dLcmN5dGFseW44aUNteVZxQzczcW00bERp?=
 =?utf-8?B?YmhoQ3lUMEZDbDZ4djl5SFVKOGlseUgvRTFBSXB3YVh0enJRejNudkxtVnhp?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8B2553F27E32444824D09E05614AEB3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87214101-ae82-4873-0d94-08daeee9b27e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 06:54:31.5273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PIS1xMiDkAZXMqqF2RYKlZlArHhpuwjeWYgv/PelgYfzlhnbDhEMinA9G7W2NHNxcpiNPcknxlrTQSINsD0KTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6563
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTA0IGF0IDA4OjU1IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMS80LzIzIDA2OjU4LCBaaGFuZyBSdWkgd3JvdGU6DQo+ID4gQEAgLTgwNyw2ICs4MDcsOCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQNCj4gPiByYXBsX21vZGVsX21hdGNoW10g
X19pbml0Y29uc3QgPSB7DQo+ID4gIAlYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChSQVBUT1JM
QUtFLAkJJm1vZGVsX3NrbCkNCj4gPiAsDQo+ID4gIAlYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RF
TChSQVBUT1JMQUtFX1AsCSZtb2RlbF9za2wpLA0KPiA+ICAJWDg2X01BVENIX0lOVEVMX0ZBTTZf
TU9ERUwoUkFQVE9STEFLRV9TLAkmbW9kZWxfc2tsKSwNCj4gPiArCVg4Nl9NQVRDSF9JTlRFTF9G
QU02X01PREVMKE1FVEVPUkxBS0UsCQkmbW9kZWxfc2tsKQ0KPiA+ICwNCj4gPiArCVg4Nl9NQVRD
SF9JTlRFTF9GQU02X01PREVMKE1FVEVPUkxBS0VfTCwJJm1vZGVsX3NrbCksDQo+ID4gIAl7fSwN
Cj4gPiAgfTsNCj4gDQo+IEFueSBjaGFuY2UgdGhpcyB3aWxsIGV2ZXIgZ2V0IGFyY2hpdGVjdHVy
YWwgZW51bWVyYXRpb24/DQoNCldlIHdpbGwgZ2V0IHJpZCBvZiB0aGUgbm9uLWFyY2hpdGVjaHR1
cmFsIE1TUiBpbnRlcmZhY2Ugb24gZnV0dXJlDQpzZXJ2ZXIgcGxhdGZvcm1zLiBCdXQgZm9yIGNs
aWVudCwgd2Ugc3RpbGwgaGF2ZSB0byBsaXZlIHdpdGggaXQgc28gZmFyLg0KDQo+ICAgT3IsIGFy
ZSB3ZQ0KPiBkb29tZWQgdG8gZ3JvdyB0aGlzIG1vZGVsIGxpc3QgdW50aWwgdGhlIGVuZCBvZiB0
aW1lPw0KDQpJIHRob3VnaHQgb2YgdGhpcyBiZWZvcmUgYW5kIGdvdCBzb21lIGlkZWFzIHJlbGF0
ZWQuDQpTYXksIGluc3RlYWQgb2YgbWFpbnRhaW5pbmcgdGhlIG1vZGVsIGxpc3QgaW4gYSBzZXJp
ZXMgb2YgZHJpdmVycywgY2FuDQp3ZSBoYXZlIHNvbWV0aGluZyBzaW1pbGFyIHRvICJjcHVfZmVh
dHVyZSIgaW5zdGVhZD8gVGhlIGZlYXR1cmUgZmxhZ3MNCmNhbiBiZSBzZXQgaW4gYSBjZW50cmFs
IHBsYWNlLCB3aGVuIGFkZGluZyB0aGUgbmV3IENQVSBJRC4gVGhlbiBhbGwNCnRoZXNlIGRyaXZl
cnMgY2FuIGp1c3QgcHJvYmUgYmFzZWQgb24gdGhlIGZlYXR1cmUgZmxhZy4NClRoZXJlIGFyZSBh
IGxpc3Qgb2YgZHJpdmVycyB0aGF0IGNvdWxkIGJlbmVmaXQgZnJvbSB0aGlzLCBzYXksDQppbnRl
bF9yYXBsLCBSQVBMIFBNVSwgdHVyYm9zdGF0LCB0aGVybWFsIHRjYyBjb29saW5nLCBQTUMsIGV0
Yy4NCmN1cnJlbnRseSwgYWxsIHRoZXNlIGRyaXZlcnMgaGF2ZSB0aGVpciBvd24gbW9kZWwgbGlz
dHMuDQoNCnRoYW5rcywNCnJ1aQ0KDQo=
