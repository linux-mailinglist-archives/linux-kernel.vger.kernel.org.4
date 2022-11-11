Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70F662591C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiKKLJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiKKLJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:09:38 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E7C657FF;
        Fri, 11 Nov 2022 03:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668164974; x=1699700974;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p/zurJMnZZhvw88ghiKNnYgJVhqyzRZtEjngZH7Kdhs=;
  b=i6/WEdtgXs4HvsexjFleufk08Z+BWAFSA1hCew2tQ2nAfjC4t1p2ZLqg
   FaqGJ0n2XJk56KtGO7F73UAVmnSlnwnJnwUjh6OlGdr7dKKNmjB0Z4fgR
   sbhMCZwJRYBgrSFwp55XSjQ3VupYH0Y1MIU+Fsue8OAi1Oiqjzgwd5STJ
   v3qkyjmhEyhjV9X/pFvWEsmgWvipOrl3d36w6xrDc/jl2WzGFoujw9ZfP
   JBnC5XVqL8ADEQSFeKDbevkr+Q4KDK37pr5v2IOh4eq5F13x7nC4carQk
   2bvO++zuvnh4zorOPEwRCOR7c1kBb50xx8pOoK+npMfugdl374Q1tLDGs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="291299032"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="291299032"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 03:09:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="701182631"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="701182631"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 11 Nov 2022 03:09:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 03:09:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 03:09:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 11 Nov 2022 03:09:33 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 11 Nov 2022 03:09:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FM8aiez1+KLf9VNt+ZPp18mc6N+JXwBoS3nIL+6OYaVsflRKGXeuQjiuvTF0NngAYaZS0DNefi9IihGJpq19I71I2s3V6MmjAal+jEGObuboNUs7KWetm05TMV5f6tJX3ZnKwc9xr4aj0kX/OL5QQlnZFFTuFqFXp2x8bAIJ6jtof3R5n83ui6sFVnHDccQyBaOb0r42YMaurOkdMH0wFOe8TZtoQtb/t7nM7ySdcnKOoOsU6nVjjB64vKeZwSUQZyJR0NOchJtlpi61mKep+8XSPzZZEIe8fWBfvh/sOJ0qNh0rUAESkv8kGNq5ljTJT5jdbwuFAAfAJfYzLcsEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/zurJMnZZhvw88ghiKNnYgJVhqyzRZtEjngZH7Kdhs=;
 b=eZaU503ZcPxWNtV+lzm+EFYggR2yhf2o7LMjNzsH4xX9W4k9kCPw7y1WmANtD9ZGW+71/C4nepgrCHt4r6nMARLC9K2jJrcSCIBCNtY85uvCNWZkY9OMUsZq+Tg48CWF3F5z7GsrgAFyAVK754sguv2EUHrdIyrRyWAtLwOTne/ty5FPKie5tgeNmcZ/UlvduTsj6xt+vTmZKBQ9cyXkchdl5XnXErj3DN5b1M93xh0eSjTZy4BYgcF6FtyrnnT0LJmw9EtBmTbsJLX5+3vBkEpX9LHiQwCIsA0Hccz06612u6GLytbGd/pbN21z8BK8+hY7wZenMNay344g6z1zMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CH3PR11MB7392.namprd11.prod.outlook.com (2603:10b6:610:145::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 11:09:26 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 11:09:26 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] srcu: Make Tiny SRCU synchronize_srcu() more complete
Thread-Topic: [PATCH] srcu: Make Tiny SRCU synchronize_srcu() more complete
Thread-Index: AQHY9A09mNqLH5k52E6fFuY+qkqcT645YGcAgAAymIA=
Date:   Fri, 11 Nov 2022 11:09:26 +0000
Message-ID: <PH0PR11MB588011113CC9374242574317DA009@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221109073638.935473-1-qiang1.zhang@intel.com>
 <20221111080442.GU725751@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221111080442.GU725751@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CH3PR11MB7392:EE_
x-ms-office365-filtering-correlation-id: e6251bc2-29fa-4b49-f94a-08dac3d5322a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PzQu9iydefp/D6k8Oa8PXP4BFcGOWEehGva1K38rSGS3/UAhkVL2UY67jVzxWH/+qhXoD+NLKbN98paEz6JzF6C26nKF/RQkIl/ISDbSJDmT9h8MdXmARiBkoFJSHLgYcy+NI752WIp0Ceev2MfqwulOXqat96IyfiMychWoUJy/AK8/eKQ5fDhgiUfuF5OsL+trDupvD1x5nTIYVWyZoEnylCp/VHjZKLR5Pe1Jjwr3IWI1m16UY2Tw5ogr2YEt5vTvMKT77GLg8ToARvqTZ78KF1jQ3FcBrZ239AvPllaJiJZkMYYYiTf88YeffFlSBfc5eOctHB8VcVF0j6Qxd1KCZBKzHs2N4Po+xB0rc3YOnSwgS7POWRTRqP4TqHkZ2WYIuxw2MNP/uPMLAZjqIa5mVVTrisTqgk9vi4ILFx4JpVMMCVkLLawYRoOZe+dgh7OZmQ3xA1PyqYd+TM/LHe6CR+81Us0Fmw7X985BqOBSX7DRdkFozBynBvX8GyoButqeMzG2Em5Rthj4GQlGINkkvnxsMV2P2EYlcepo72mdqjK6Hni0YixBs9HHQft+krqXQ/zuwVCXkjbu28Z2493An3BqAnXR8WYhvcoIzCE19I+r0I/bLYw4f9VWxWCUcjzSaFjLGvXvacJd1JsniYgX11T7zms+3vJCtOymoLmh2/NwKfkZqetnZoQfDsVGmFdc69cr+IjnrndFJAM70urC2HQoluDbRmsQZk9w4NxFHb4Twf3eXD0Cwo3Ku/Cy6rIbBkV0/2sHUVp8lAC1Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(9686003)(2906002)(186003)(86362001)(122000001)(71200400001)(478600001)(38100700002)(6506007)(33656002)(82960400001)(38070700005)(55016003)(83380400001)(26005)(7696005)(66556008)(316002)(66446008)(66476007)(66946007)(64756008)(4326008)(8676002)(41300700001)(6916009)(54906003)(76116006)(8936002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmxLTGphaHcxbTZkVzFvNmRrdUVKTDhYU2xDemRwSGJJZERHZzFSYmg0VjVZ?=
 =?utf-8?B?YTlkNWNqK1BTbjJ2dkhIWHNHUU00cHFobWNLbGFhMmpvYTJhekdsTURHQk85?=
 =?utf-8?B?eDNlbCt4aitVWkRhc1oyeFdJV0R2SSs4bHQ1ZkFGak9Rb0hvcjVyM2pGRHFh?=
 =?utf-8?B?MjV3VVYzQkFNejlRRVZmSjRKcVZkUjBXbkZyV1lhVmdPV25ucmRnQlVtN3ZP?=
 =?utf-8?B?RXA1dVNMV3lLSWJsR0huMGpmaEt5UzZNdnpDdVQwSzhjRS9RVk9zd3pkNzRO?=
 =?utf-8?B?TkYxSUJqZk1oakNFSVN2a3hMSDFCeFNyaTVhYkFmQ2dmaUw3cGtlTWFmL1gv?=
 =?utf-8?B?OGFKZGVheUhFVm5ycWFUWk5HQ1FhNXhOMTR3UHI3OG5FY2dXazJZMlhKUFVS?=
 =?utf-8?B?WG90Mk9Mem9Rc01LME42OUxJa29wMFJmQTlvM29nR0tVZUJkT05lMmNIZS82?=
 =?utf-8?B?WXN5eHRzYUV4eTlZczdCMTR6bnhuRUVKZXpOUUtJeDViVFZXRTg4SjNySm9K?=
 =?utf-8?B?cnVydnZWUTJabGNUMHUvSUdVZUNKNW45TnluRllEYmt3emdJRi9oREljbWVz?=
 =?utf-8?B?NStjUmZsNjVYTHRteTlvdklOT2oxOFcycTlsdHVnUWZCbEliRDU4Z29lWHcv?=
 =?utf-8?B?Uzc0R25ucTY3Y0xtUFd0OE5yQ1JrSEg2S2twdXFtSm12WUZWVGwvdnd5eEV1?=
 =?utf-8?B?akVnWXpVdnJQVjdoeVFVZ3B0VkZqaUZCekY3b2VqQ3BtMmJ2eDZBc2FKYVdI?=
 =?utf-8?B?OUlQdFdVb293cFZleU5CNW0vdlFYdjJxbW9BemRxNHVidXlTMkRienMwK2Iz?=
 =?utf-8?B?NHpKUEJzU3JTa1VYdUhMRXhqZVBjVmZSVVR5VjdoNWtLdGxVWUlpY1ROR0Ju?=
 =?utf-8?B?RFRqelZFdFh1V0FCbXlNVUwzWXFsL1VscUlHWTZ5K0lXc2pBaGltbW4xeE96?=
 =?utf-8?B?YmZvaWNneCtlWVI4azB1NUVQNVZqeFo0OFlGKzJCRUFkVmwzNUdsdFJmR3Jy?=
 =?utf-8?B?dVRjQjhKVXIxeXhmYkEwSyt2OHc3dDBjcmNtYyt2WWNhbXBKR2QyeWdUajVm?=
 =?utf-8?B?aEdRdUVMV0hIUTBUTGV5dUpXSll3SzFWd3FvSlBQWGxzT3VVanJMRk1RdVdo?=
 =?utf-8?B?SXZPV3BjVDBDVHdvSGlhSSs5N29BMkNqU0lVSmFhVkFCbUp3Ynl3WVF0N3pW?=
 =?utf-8?B?M2gvRmZTZzFpOGUxcWhrd2RmcW9aNnJpNFNWYjMwdW5OZjVsbXpwWVVoRDFx?=
 =?utf-8?B?Q0RyS3pueXBOUDlKRk1NdzBVaFprM1hFdHB4MnpmcUl2ZzNkSXdqYy96N1lC?=
 =?utf-8?B?bEp0SFdWbU10ZEtRdG9HZldqVEs2SkNnakdXbXRrRXZPSDQya2JISDRrVG9y?=
 =?utf-8?B?MDd3TW1ZZ0NaK21OUGxpeFFZZ0w3NlJ1SEN1VGQ2MXQzYjNGSitGOXh5MVN6?=
 =?utf-8?B?VHN3ZlNsWHREejNMUDY2KzAzMGY1UjNHaFlwM2E1eG1CWHFGN0hYM3ROQnht?=
 =?utf-8?B?dWZaaWhyRmx5T0RteVZuKzBUbmEvdTZqMVZtajArejlrZjhTbzM0TmZQMWJC?=
 =?utf-8?B?M1lKRW52YVpVL1crejNmNzRUZkdRdW1ESUhxdFEyZHFoRTUrblVyNGJQNjJI?=
 =?utf-8?B?UHcwVDRqaEY0NFIxeVkzMThWNUZ2Q2ovYWFHYldiS0RhY3FqaFlCMDE0V21C?=
 =?utf-8?B?U0ppY0s0N1A2R0ltVGtlS1hTL2lnRlFVQ1k4UVJrNnBpdzhFQzg1bTdjZkU2?=
 =?utf-8?B?aVhSamQ0VWt0SmFGM1N0RzZlWWlRQW9BanNpQ01TRnlCbGhVWGZmQlljcjhN?=
 =?utf-8?B?ZEIva093NmNLWHhLRFRBbHVDQnBkSGJFaFNNR1RsNU1MV3JlUjlTVk1sMVBt?=
 =?utf-8?B?NnpBWGJqazdjMEcyQXMyQmtubmJyODJjSnVpcS9BRW9KRGdmbE5nRm5aWkpF?=
 =?utf-8?B?RWZWTlNDZnBrNHcveDNqYmRyVmNNOFFFREs3bys0bm5SYnlXTjRKbG1lRDlN?=
 =?utf-8?B?VTJvRzNsZ3I2Vm4vVEJtb1NmMi8wZEt4TUFXS011Sy93OGRQSTBMRmJDZUU0?=
 =?utf-8?B?cTIwaVNVMTk2YVhQTVVwQ3ZNWlovMkxhWFkxc1NSaHpVVFFKTS96OW1uREtZ?=
 =?utf-8?Q?FYUJAYIGZZSX5InJkFRyli5VJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6251bc2-29fa-4b49-f94a-08dac3d5322a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 11:09:26.3005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hh+++U6Qm/1y+UnIcoEQeVKlEh7o0WBT+Pl1zj+Fmn3TLO2miwVM7gexrpX7bzp0pg+8TXLFSXvvVXe1dGoMrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7392
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBOb3YgMDksIDIwMjIgYXQgMDM6MzY6MzhQTSArMDgwMCwgWnFpYW5nIHdyb3RlOg0K
PiBUaGlzIGNvbW1pdCBhZGQgbG9ja2RlcCBkZXRlY3Rpb24gZm9yIGlsbGVnYWwgdXNlIHN5bmNo
cm9uaXplX3NyY3UoKQ0KPiBpbiBzYW1lLXR5cGUgU1JDVSAob3IgaW4gUkNVKSByZWFkLXNpZGUg
Y3JpdGljYWwgc2VjdGlvbiBhbmQgc3VwcG9ydA0KPiBlYXJseSBib290IG9wZXJhdGlvbnMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+DQo+
UXVldWVkIGFuZCBwdXNoZWQgd2l0aCB0aGUgdXN1YWwgd29yZHNtaXRoaW5nIChwbGVhc2UgY2hl
Y2spLCB0aGFuayB5b3UhDQoNClRoYW5rcyBmb3IgIHdvcmRzbWl0aGluZywgIEkgaGF2ZSBzZWVu
IHRoZSBuZXcgY29tbWl0IG1lc3NhZ2Ug8J+Yii4NCg0KPg0KPgkJCQkJCQlUaGFueCwgUGF1bA0K
Pg0KPiAtLS0NCj4gIGtlcm5lbC9yY3Uvc3JjdXRpbnkuYyB8IDEwICsrKysrKysrKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVs
L3JjdS9zcmN1dGlueS5jIGIva2VybmVsL3JjdS9zcmN1dGlueS5jDQo+IGluZGV4IDMzYWRhZmRh
ZDI2MS4uYjEyZmIwY2VjNDRkIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvcmN1L3NyY3V0aW55LmMN
Cj4gKysrIGIva2VybmVsL3JjdS9zcmN1dGlueS5jDQo+IEBAIC0xOTcsNiArMTk3LDE2IEBAIHZv
aWQgc3luY2hyb25pemVfc3JjdShzdHJ1Y3Qgc3JjdV9zdHJ1Y3QgKnNzcCkNCj4gIHsNCj4gIAlz
dHJ1Y3QgcmN1X3N5bmNocm9uaXplIHJzOw0KPiAgDQo+ICsJUkNVX0xPQ0tERVBfV0FSTihsb2Nr
ZGVwX2lzX2hlbGQoc3NwKSB8fA0KPiArCQkJbG9ja19pc19oZWxkKCZyY3VfYmhfbG9ja19tYXAp
IHx8DQo+ICsJCQlsb2NrX2lzX2hlbGQoJnJjdV9sb2NrX21hcCkgfHwNCj4gKwkJCWxvY2tfaXNf
aGVsZCgmcmN1X3NjaGVkX2xvY2tfbWFwKSwNCj4gKwkJCSJJbGxlZ2FsIHN5bmNocm9uaXplX3Ny
Y3UoKSBpbiBzYW1lLXR5cGUgU1JDVSAob3IgaW4gUkNVKSByZWFkLXNpZGUgY3JpdGljYWwgc2Vj
dGlvbiIpOw0KPiArDQo+ICsJaWYgKHJjdV9zY2hlZHVsZXJfYWN0aXZlID09IFJDVV9TQ0hFRFVM
RVJfSU5BQ1RJVkUpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCW1pZ2h0X3NsZWVwKCk7DQo+ICAJ
aW5pdF9yY3VfaGVhZF9vbl9zdGFjaygmcnMuaGVhZCk7DQo+ICAJaW5pdF9jb21wbGV0aW9uKCZy
cy5jb21wbGV0aW9uKTsNCj4gIAljYWxsX3NyY3Uoc3NwLCAmcnMuaGVhZCwgd2FrZW1lX2FmdGVy
X3JjdSk7DQo+IC0tIA0KPiAyLjI1LjENCj4gDQo=
