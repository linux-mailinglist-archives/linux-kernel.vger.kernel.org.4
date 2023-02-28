Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E15D6A607E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjB1UkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjB1UkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:40:06 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFE834F4F;
        Tue, 28 Feb 2023 12:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677616798; x=1709152798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m5CjE0fx63jlpfjjvAjYgncR5C24Ji8Inu83bixkfh8=;
  b=MWDnvg9QA/QjUEeRU1mpwPG4NUrBADkVcTcECYx7Hh3naWVE4McJDF0Y
   g3n8j4/dMRhbN9gVb9cRDYC35jBieBwN2dQUy7UgU+XbL77kwFP++qRrC
   BUIwHQ5U+Mz/fHJCtlaR4nEpt6HNuHEhm+xbnCfgmBNSoogMDAq/E3ajN
   dBCf+QJDtSqgPE9PECgGG1oASxrO3396QQTIBgMM7akVMJR60ecUp2CQu
   G2jGsRF9437nJLtWeAA4m0sZbJhtUKbqu5do0EtxOFfIHPZooez06Gzy0
   PgU0fnr2jpAeKhgT293GezmZTfeYJmGFVgi8DQEfOa5iMjjRecXNenAOq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336539176"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="336539176"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 12:39:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="919931044"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="919931044"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 28 Feb 2023 12:39:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 12:39:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 12:39:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 28 Feb 2023 12:39:33 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 12:39:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daktL9tJA2hjs8/CKR6Zgdguui1kOqe4OlBkwseWJSWiKY9lyTcytyYOqV07jPJ5K9MMNfhT6fgzM0Qq6xD/QleDhGeKAI48VXfxtR3LB+9i5pxNfSWlNLP/rvKu5Bu/E7zqjHl5GbgMnJVW5bL/sQ98sgyfCj0JDfy/7hOHbztaMMUVJk17heQpK7Va7YMuf5T0hnCXpg/o6UoIiSuUoIs80KxI67EkUaj+cXip16VzAe8ioLh54ukdLzav5v/xXnv2qxmT7Vs0G5r/YpGZlpsOppT44D8ryBdESiuCZouAXjTE4Vxwv23IGL8tQ6kJvOZ6gLbTyK3yBtfNTX9QeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5CjE0fx63jlpfjjvAjYgncR5C24Ji8Inu83bixkfh8=;
 b=UENyKtBsnq8g3uiP5pSssV/QxcfjasWH70Cg/NAWJ6PcH/ugEc60QSyp/IvTLkdOAGKn1pJjxiZ33p4ChnPfZkhgd2Aj4IMeRI1fgUZ9qlE8KTuXs56x1NRMMdh0bj44LvagnFEWCCqRuHepFKNDb/XmIYD0/0rdc5v9nqL2U/IEBhokf4weBA95kuENurZjeBb+2cqLFhi1Qofi4sbQinfsQzzb+t/bcSfF9hNMaD8pTpxWRh0wv6DkHTGbeD49TPNY7DB6RxnZizA13DFrv9FCT9wxLidWQMcoDfrqw8Kex9Y1FiayhJPx51iymBQFDRGCiHrLiWvoaVUAn3kmOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4624.namprd11.prod.outlook.com (2603:10b6:806:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 20:39:31 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6134.026; Tue, 28 Feb 2023
 20:39:31 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "babu.moger@amd.com" <babu.moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is enabled
 and initialize.
Thread-Topic: [PATCH 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Thread-Index: AQHZMbXnUEoONz5h40uCChzoDDCRa67k3i6AgAAnEFA=
Date:   Tue, 28 Feb 2023 20:39:31 +0000
Message-ID: <SJ1PR11MB60837729155ACDEB1C093DCFFCAC9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-8-tony.luck@intel.com>
 <85d7e70a-b9c8-6551-b1ac-229b51ee18d7@amd.com>
In-Reply-To: <85d7e70a-b9c8-6551-b1ac-229b51ee18d7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4624:EE_
x-ms-office365-filtering-correlation-id: cc57ed73-cb2c-4e45-cdd0-08db19cbe518
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FEj5aNXVZsYOLxDgDfwiMmfuv+YdNtrnqu4m5dhI9STQwT33RQXuUH9CEoEojJlZKNMC2DajKjAbdYPZf9dR6pIvMSxRS4gHiBT8iqDQUFFERF92jxZNeWEf4qb+i0NJPuP52x40SxHA/oMSmf5lgeWXJ7ygl9abKYuqd0z2d6x4baSZ+aq6FSPycrsOUKrxb8AFsH5V/9GYypohfhalaELaDoEuJwaV8n6B1qMm9hqXUA6ECwgaLIQxDpeWxWDCtqxBn7mZPWCPuiKm/42BVFq5y8sw/glORfHCvjakIRjLXumtp5mdjrZjh12y1POECEDTdwe80oflbc79nmTJ8Ij6Mu4k+iM3SMnkoriU4XP6ARmVdS5ybwZW9RMqVHsVG0h9J3mS5S0wKTSObxxclCgeXivahJhfGMKDBQB5QzFPzqdTxszV9a3dKV50cTcfu9lYT5qoV49CBJ0+kLJ/TMD7/eJ1ezGsHMvzOGkAhUU89ECORGC9lMyTmR+Job4khIaULNFvnBMPdhM96yncUfentfpaWyfaiHBmGNlsoP872Fs1dU/0t404crTW6d/aFvihA/6jr6zWK/6npYqjchJFdFeJaiF7rvUQiuXf5AFLdj+r9GZSB1UFk7Txmj+UyWTkLvLsTwMpQZkCZzT5lBD9fLO7vd9wHPaia1WS4iXznNd02bwHLvvkvGn941twFK7LIvch/aY1fsh9m33VNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199018)(64756008)(76116006)(66946007)(38070700005)(26005)(66556008)(6506007)(66446008)(66476007)(2906002)(316002)(54906003)(9686003)(186003)(478600001)(86362001)(33656002)(7696005)(55016003)(110136005)(71200400001)(83380400001)(5660300002)(52536014)(41300700001)(7416002)(122000001)(8936002)(4744005)(8676002)(4326008)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXQ2YmQybWxLVzMzZkJBUXJrcm5WcHcraVdrM3VmWDZGeUdJRlBHK2g4Tk5U?=
 =?utf-8?B?bk1HSkdEQksxRUltVzJyVGxOWXoxeVRBOE1EcnFub3Rtd09lTDNBeVdpZ1J1?=
 =?utf-8?B?QWZ3VklXVHZBM201OUxYekVlSSs0YlQ4NVVQdXVqYVd2Q0JZRXQrTTBQdU5E?=
 =?utf-8?B?UXhOYWlNUEw2ZmVNTlcxVGxjTHpoUEgzd0QrWFNaWGNtVXg1dUxMc014T0lr?=
 =?utf-8?B?c3JJK1cxMW0zbU1WN1JWMnRSRUNINXQ3czN3Ty9MeGVVaHdudUJTaGFDMWR5?=
 =?utf-8?B?RHR0WWtVUEVIYjk2b3BxNUZlMTJ5UXBMdGdEbkQ4TTJLd3JaY1BzbGhQamNr?=
 =?utf-8?B?U3VGUTY3U1VqN3JKbERFRHpPcGZHQWlUNmhmRGVKMGxOU01FdWlQVDNnYzBv?=
 =?utf-8?B?UXdrRVB3bmpmL3IwSHQzbVk0YTNUUVNCWmV4bCtDaWpTSGdneEMvS3Jic0ZY?=
 =?utf-8?B?MkR4WWJrSUtJdG11UE9yZUVKUThRelkzM1ZKQXZjVUdHRnBIVWd0MmMwVHQ4?=
 =?utf-8?B?UmozVTUvaVN0dGRmMlIwV3B0dnVJazBpYmFUZnQrZGZtckU3d1laUERsWnFh?=
 =?utf-8?B?bFpnQzBscHlQMWpDYWRtMWU4aFkrWkpNRnRNTVBXMThING1jRElXMEsvbkhI?=
 =?utf-8?B?V3BaTms3Ym5xVmZIOVVrck02MG5EbXMyZmErbU5RVC94Q2lacytIWnR5Nm1z?=
 =?utf-8?B?ZVFQajhLUkF5QnBTNkozMnZNaXBncnhKdUx2NlJjZHhhZ0V1VXp2VGVhL1FE?=
 =?utf-8?B?N3hGWm9QbjU4Um50Mjc4NHhwSkVRMS9tSGNKYkNDcXZVdHN1SGNBMGFpNUZZ?=
 =?utf-8?B?UGp0cG9JR1VNRUdUaUdtbHRISlFYM3JUZ2hIc1M4cFl6S2JQL2pnbjhLMGJl?=
 =?utf-8?B?cyszaDVhakpDMnRoVkdQZ0ZjeHJzQUZFN2pKNU5IMW1iSlVRbC8rKzErZk1Z?=
 =?utf-8?B?bWlYMUFma2xpN2Y4cy92QTUrMlJwNytUNXpIQUJnejRnbWtnWFFFSXoxdFZw?=
 =?utf-8?B?djVEWHhCRXorL1pPWVY3VTRPZGNtcW0yV3o1SUtxa1p4ZUNZV0VqMVVnWGoz?=
 =?utf-8?B?dVdMUzlwSy8xYlYvMWhEa3B5dWlzU2VVUnFiRUViN3JxUktiNDJQclZxVnZB?=
 =?utf-8?B?bTRzN0cyOSs2emZMeXYrbUZYMDlDRGQrVEtiK3ZqQ2xZeVczRGoySE5GUFQy?=
 =?utf-8?B?QUNjRVgyNE8xNTdFamNhK3ErMVBMVVRVMTVEdk9VS1QzU2VHK1l2M3dORHZW?=
 =?utf-8?B?Y3FLZWJ4R3NMZitRUzliT0tDTmlNeXpqcndoZDZtS21GandXL2hvTitmS0Rl?=
 =?utf-8?B?WW9JbXVjWk5rTXhiaG9aZFZyV1pvUDVGWTd5S2duSDhtMVI1TXNlSkJsQWV5?=
 =?utf-8?B?K1JRbkwya08xVEc2VHQ4a08vNEhxTXhHNzZXY1hOYnJRZ1ByaFlwMUk1N0I1?=
 =?utf-8?B?b1ZVZ29PUGxzTGxZSS9FWml0NW9MK2phVkI4bU9WRGZKd1I1cU1HbjRsWFR0?=
 =?utf-8?B?bnp0NS9NR3hYczR2cEFHUmZuMU42eUlKSHZrczJrb25RQ1hsQ1REYmg1N3VL?=
 =?utf-8?B?bVIxQmFQMjFNOUp5eCs2S2ZHanZ3cTJhRy9jYmUyT0ZGYVZlQTJjSTlQVVRa?=
 =?utf-8?B?YkNlbVBNZmtyZnQrRStoZ2pVVVNuYWdOaU9NdG5KMHF1TnkybmY5OUVhLy9Q?=
 =?utf-8?B?Sk1jUGVxNmllTVhWTmxvZmZsaXA1bjM2SE83R25GYlZCSXNibmFpOCtRZi85?=
 =?utf-8?B?L1RDS05SYmpYcHRGdlVqYVkyU1RQUUpyOEVvNEdLQ3owaVdRaElvTE5ydzFh?=
 =?utf-8?B?UE1KK1VjSm1LUStaZHY4QW8xWE5qYUZla25oMkVpMEJrRko3NTRjaitOZzcr?=
 =?utf-8?B?MHpOVWMwY293SkJuS1VJeWx1UjBhRnVCNVBDaVVwS2dIVWxlUDBHTWZSWGpr?=
 =?utf-8?B?Y0RFUEk0TjVNY2dQeWpFc2xyQmhWS3FnWllyZjY0bUo1S2NEK1MvTW1RUldy?=
 =?utf-8?B?eTVreWFQelFLclhpbVE3bEZGTkVibmFWdzdpRlloemRuUnpndXp0RzlsMGNH?=
 =?utf-8?B?K05vYzNwVmJMSGFlOEpRampoTS81cEpnbGFZcFJLYndhTmdIQk1PWGU2ZGJj?=
 =?utf-8?Q?y9dI1XqgfJ1V8HUkDyss7yye5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc57ed73-cb2c-4e45-cdd0-08db19cbe518
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 20:39:31.5564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2kjac9BA+aXt6yYeFaOQFu3FeKFl4l7QI0Dqlf/Qh2hC/QMcXOBQw8OFjR5LWrlvhPgXzh0DQBMbU4m8DjtCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4624
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QmFidSB3cm90ZToNCj4gSSBhbSB0aGlua2luZyBsb3VkIGhlcmUuIEhhdmUgeW91IHRob3VnaHQg
b2YgYWRkcmVzc2luZyB0aGlzIHByb2JsZW0/DQo+IFdoZW4gYSBuZXcgbW9uaXRvciBncm91cCBp
cyBjcmVhdGVkLCBuZXcgUk1JRCBpcyBhc3NpZ25lZC4gVGhpcyBpcyBkb25lIGJ5IGFsbG9jX3Jt
aWQuIEl0IGRvZXMgbm90IGtub3cgYWJvdXQgdGhlIHJtaWRfb2Zmc2V0IGRldGFpbHMuIFRoaXMg
d2lsbCBhbGxvY2F0ZSB0aGUgb25lIG9mIHRoZSBmcmVlIFJNSURzLg0KPiBXaGVuIENQVXMgYXJl
IGFzc2lnbmVkIHRvIHRoZSBncm91cCwgdGhlbiBwZXIgY3B1wqAgcHFyX3N0YXRlIGlzIHVwZGF0
ZWQuIEF0IHRoYXQgcG9pbnQsIHRoaXMgUk1JRCBiZWNvbWVzIGRlZmF1bHRfcm1pZCBmb3IgdGhh
dCBjcHUuDQoNCkdvb2QgcG9pbnQuIFRoaXMgaXMgYSBnYXAuIEkgaGF2ZW4ndCBoYW5kbGVkIGFz
c2lnbmluZyBDUFVzIHRvIHJlc2N0cmwgZ3JvdXBzIHdoZW4gU05DIGlzIGVuYWJsZWQuDQoNCkkn
bSBub3Qgc3VyZSB0aGlzIGhhcyBhIHNvbHV0aW9uIDotKA0KDQotVG9ueQ0KDQo=
