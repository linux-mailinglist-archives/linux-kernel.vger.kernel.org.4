Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FDC6888F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjBBVZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBBVZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:25:36 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1149F6EADA;
        Thu,  2 Feb 2023 13:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675373135; x=1706909135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NyzEbHAFF9k1tqmhY1ieMKLuSJA6AuXxrJZm/2cB8HQ=;
  b=XetHnPzjUGbdy1xPPgPFDd092wMmF0Fg/wbYSifLBvMnhoHELlwKTs7F
   7GBLfJeUgEVhPBQSs5MZWw/rqTdBqah19VZtN+TQvKGlOdw94nEVBMaG2
   iTrspwN0Fb24Orgp8x9+rAQ40AqTDEhXFMPAGcaD98yLTJ6o9RwIorb4W
   YuH9tTOUabp7tLnFbvTvnIkYDsB77afq0KgZBEZLAKqHgClXJhJxXkaoi
   YwdKn4iBxFZQe4wEIQapFFbH4rQfPy8LY2ICFEhkJasDOiwXAtRt/OiYA
   QbMy3GOMRkEkr4N6+NsCRU6NIqE1v9YEd9Z83nToPmuTIfAAl5iXqNu2C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="355914862"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="355914862"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 13:25:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="734079703"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="734079703"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2023 13:25:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 13:25:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 13:25:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 13:25:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 13:25:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PI8wKFjKrkXBGSs2qBbfXJIqYbVz1FpR/ZZcDJ3vNTMTXrP3XW4pmimvokCFIAoRLvsooyZAH2tAwwjaRBDpRkG6DnVj5KV1DLmkjZm3ZTwGcrhALhLOAhsIZCOsIrFF2yeSbRe8s6grr9h7P8vcGK3oCdTg86BKJh0kL8id9EnPb8XOyxhrghY0SZHRYHxWheWRjeHI7mlIsum7fWmqCc8M/Y9+nb1/GwlfRM2DnsOENhMAU/lxh/UIERS1T/kcyNZNpIFF5nLzothues8I7B9sIlfeQvHjj1iFiRNdeiqCfZ+PHdK+I6dSXRG0Y5HITypBngFmTuEaBqyRMf19tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyzEbHAFF9k1tqmhY1ieMKLuSJA6AuXxrJZm/2cB8HQ=;
 b=ZBjK52uS9MdxCx7HnjF6qf8tDBFe08I0CHnxZDVlgzvONJPsM8gYgsEF8ixzH9eCA2SwH5sTGvhgPxWuwq/EfBnPK22YwRKmndH5NsSNkx1DvsjlZb7nENYMLknTdoQ3TjOwugk8LVFhqDNhbi8iOU24dtWCr2eTOwlLAsAc5OoS/s8MEnyLosMzpeFMJWByBK//wcrf4DEFrQKfBWG2BUoMrIrRxgiiHLZtrBw+/1TbmcXp/V8/8YF8IaH7UlqKkrPW5U2Wl2tcDblcdoWQLXqXqwo8BcUIFPOLQ10nbDTT839g/X7wmtx0OX0ow64c6eIxJbv+Hv8+Hs/BczGEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA1PR11MB6805.namprd11.prod.outlook.com (2603:10b6:806:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 21:25:31 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%5]) with mapi id 15.20.6043.038; Thu, 2 Feb 2023
 21:25:31 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcutorture: Create nocb tasks only for
 CONFIG_RCU_NOCB_CPU=y kernels
Thread-Topic: [PATCH v2] rcutorture: Create nocb tasks only for
 CONFIG_RCU_NOCB_CPU=y kernels
Thread-Index: AQHZNtOvEEHhGCrEsUyuR7d5liKV4a67xByAgABlZZA=
Date:   Thu, 2 Feb 2023 21:25:30 +0000
Message-ID: <PH0PR11MB5880DF541BB1D75E0DFC02FEDAD69@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230202070245.3311951-1-qiang1.zhang@intel.com>
 <7959A7ED-A47F-4472-9278-8582F1CCC6A9@joelfernandes.org>
In-Reply-To: <7959A7ED-A47F-4472-9278-8582F1CCC6A9@joelfernandes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA1PR11MB6805:EE_
x-ms-office365-filtering-correlation-id: 530f7253-14e5-48e1-584d-08db05640310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NvQnOpxpN5jZF6mCHiQ3UWNmLdoIwYthOTMG9DTpqzv09bM44+oGwqmblrYGTrA8KoLOwSgw7NnyAUV9IifhzKaBOU8jzR/wo7ko3cCsmUixHVgwO1F2q/1uUzIcyBqNpv+6tlqhmFn6kFsDwYjfOWX9wY8WGSoKukOO/83RpyM9PTq9U166V5JOEGVnvl8lMa6uvizuhOMHzOvdrDMGwehfuIThES2scxMnw42xuLQ35uVjF2LYlzn9SJxt5EUmBIgkGQ1EZlsgq12YYiCDMD9sYDwn83Ll2hCAjpFRlIgRIhjHGDZB3EWEW3a8fYEjiRgAeDqu6JxdW7xSW09uP9UDnkzY/p7rBcdEepPIe6+IjfCJedNVZsczrDZwNveF6SpIoQD3v4wuq2chV1KC8djyECjbQGAw3rVB5R8KXa15EktVZ0YRU14i45qDolMjHwWwnTDJp/fCo9dP1QbmnGptIiNUjXtTvsVfm6FBXamXWZ+vobVKawkJuBgQ2mk2zrbHNUy6My35w5M6hXiwKUbWzFtCLtwty88xgDcNRRxgw+/Vh5UT9CH7kobQhtz8aV+XRyedS4l4Uogzev9pYauZRTtBdgVGO2ezFE51YSaIvWEicM3KBUBs3l4keP3nm6bUKo5ps6WcZDJeAtvon6rl72KpZEIh7rlsL6HF9hnMo8Sq4be6dAiBkKNYnhQWVi66vm7qrIx89pcHiEtZxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199018)(83380400001)(26005)(71200400001)(7696005)(33656002)(55016003)(86362001)(82960400001)(38070700005)(38100700002)(186003)(9686003)(6506007)(478600001)(316002)(54906003)(53546011)(76116006)(41300700001)(66476007)(66946007)(52536014)(122000001)(5660300002)(66446008)(4326008)(8936002)(64756008)(2906002)(66556008)(8676002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2U4RVZpNnVLaWhxVXpYTUhJWGVmb0RIUHZPRWtXV3R3aVhwQi9aREJwVUt4?=
 =?utf-8?B?QnpuRFVBcVRyUmVweXBPSHZQakI4eituYnhxYTM1YUdQSW8xR0lUZ1pBQ1pX?=
 =?utf-8?B?ZGFqdU96MEdMc1FFOUVEMGRHT0FCMEZJL2tkakFraXlPdi9ERXpvN3NYVTUw?=
 =?utf-8?B?R1BYMEcvMVBKMm13RXdtbE9NRlh0TC80c0c1ZGRsOWRXUmc4ZGgyUDcwZnd4?=
 =?utf-8?B?OVlWNWR6UnBKQWR1ZkRkYTVIWGZGdHRWcVFMN3VWamlJUXlCZml3VCtVYU9G?=
 =?utf-8?B?dlIwZ0Q3cE9xQXdVLzE1dGRkS21ValpnRzFPcWgwdThjSkJFOXE4Q25OQytw?=
 =?utf-8?B?N2dqTGxQUW0xc0xqb2ZiZmFxbDN1dk1ybU01c1dkRE1SalVObVBKNGJyOFJT?=
 =?utf-8?B?ekJhdHRuRzN2bVpkK29haU1JVGpMbytDU01xNVlvV3d5dDc3SWRNN2Z0TzlY?=
 =?utf-8?B?Nyt3QlJGOEgzOE9CRzAwa291VDU4c1kxRGNBMnhsNUxYTzRlWk1HSWFqMWxt?=
 =?utf-8?B?TElScTFndVpTTHcyTEdxTXRZTjBpWE1hZEYrTVFsendRYXpPUzZTNDNRK3dY?=
 =?utf-8?B?SG5rMUVsa1hKU1diK0JNRGFycTU4SUJQeGVOK1hYRG1MLzJqWGkwMDdaR2pM?=
 =?utf-8?B?VGtySVN3aVRZUzB5d2w4ZlB4Nk1vL0dKaEUrRlNvOCs5VzJXTVU2dWZzVGNJ?=
 =?utf-8?B?S0VZY082VklkTFBITlVkNVd3OWJGU2FaL3gza2ZKR25XMmJ2VWpwZlNiYjlr?=
 =?utf-8?B?YUtmT3FESnVPK3Q0aVJlejFSZGt2OUpCTVl5ZXdySkJhUS9xRVlweWRSUEI1?=
 =?utf-8?B?K2IxOEZLK0MyNlVtVnhZamlmdzFPQUdFRm5xVzVRR2UwRGE0N0lIMy84b2VX?=
 =?utf-8?B?c2dLWDlUemhHZHYxbHZFdDEvRkVtR3ZURkpPUGZ5M2x5cUJSNlp4M3BmeDlT?=
 =?utf-8?B?VW1uTVczdkl1eU9KYTEzRlI1OGxGQXVOQ20xVi91dGdnZ1ZRWFppTVh3eVBm?=
 =?utf-8?B?K2lvOUxrVGRtNkg3Mm1jTk9LQjdNejNmZENiQWVwNHdjRXdtampSOTlid0s4?=
 =?utf-8?B?OVNoWXpYTllLdWdEdGo4aTFlWjU0RmFHRWdwUFJoenQrL05XZUo1cDBkQW5P?=
 =?utf-8?B?VDJ5REhTaDVtb0dWa0lldmg3dG9MeUR3TVljNDZTcEt0cXVqeFVSMDNpeHBy?=
 =?utf-8?B?Yk1yVHJ0bGJPWU1EdFF6TC9RWHFpQk1JcFVTWlo4L2pWSUpOMlBpUVhEaVpj?=
 =?utf-8?B?c0Y1QjNtUDRWOG9PZDFia29vQ2NSalkxYVJING1tVDVxM2p6TlZSb2JSOFRp?=
 =?utf-8?B?ZXEzOEpFQnJuVk9nb1BmdU1QOGlMNUx4SGttWitWZUcvamh3d3Q0T3F1ZmZC?=
 =?utf-8?B?WEVXWU9CSDV0dkg4d2N2MnZzNFZDdm4wSXEvcjliQW0wSTQ2aERjcWdrd2hD?=
 =?utf-8?B?dE1yZk1vd0pCNUM0d3BSMENqY3NPcGdCYytxaHNYdHkrT0UyQ0QvRm9sQSth?=
 =?utf-8?B?ZkFId0orQldudFIrMVRnNmpjbHdUTFUrK1B5WDAvVjJ5WmlYajBvU1ZFcVcz?=
 =?utf-8?B?bm8vM3c4aUUydk5tVmZEQmpBbUpPdHBSSG1HUE0vdnpzQ1pFV0lwQzNab09J?=
 =?utf-8?B?SSt6bk80NFZzTTZFWlQyQVphYkM5Nm1SdnVROHZ0V3dZTStIdWs0RFJacjkw?=
 =?utf-8?B?WklUOWpvS0xxUkdtZldTbVBxV254RkN4VVdPVHAzaXRCeDdvS3R5N29CMWFn?=
 =?utf-8?B?eGhwNHdlOEV4Y1o3TG51OGs2S3NEaFNadW9LWVN3eVZpSWtoZlJ1SHpBckl2?=
 =?utf-8?B?ZDFZbUx5UkRjWS90Zi9BRUZ5dnM1bzlDS2lsS0NOV0hFVTFWeFVIaTV2Wnhl?=
 =?utf-8?B?KzZlaVY3SkNSOHN6MzNkSGJYUlExd0x3WUM0WTYwR1NqbnpVTGtEZkprRjY1?=
 =?utf-8?B?N0srL2tkalhBelJobGFFSm9UTFJYcFBHei9QdnlmNTFFeTc2U3FELzREU1hB?=
 =?utf-8?B?V1lYZXdHVHR4QXpQdEhMUGMzcmliMTdWeEZwVXYrUUFoUVdVZHVVaUIrNU93?=
 =?utf-8?B?WHo4VlhmZkFsSjdwNzFCaFNvRHgvOHBrQzU5aDcrc1NnS0pqMG1GUHlDSXZq?=
 =?utf-8?Q?L05bEnIIBJWO0Li5V2ZQCDCjR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530f7253-14e5-48e1-584d-08db05640310
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 21:25:30.8859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ffwIeCX4QoM1swWrVtvH1btV/0jl3iO4XHvVzwbMbcWbs0YmpzPsZnMIZt2iiIhpVi/wwYSBci1r3Vd+dluBhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6805
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEZlYiAyLCAyMDIzLCBhdCAxOjU3IEFNLCBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRl
bC5jb20+IHdyb3RlOg0KPiANCj4g77u/V2hlbiBzZXR0aW5nIG5vY2JzX250aHJlYWRzIHRvIHN0
YXJ0IHJjdXRvcnR1cmUgdGVzdCB3aXRoIGEgbm9uLXplcm8gdmFsdWUsDQo+IHRoZSBub2NiIHRh
c2tzIHdpbGwgYmUgY3JlYXRlZCBhbmQgaW52b2tlIHJjdV9ub2NiX2NwdV9vZmZsb2FkL2Rlb2Zm
bG9hZCgpDQo+IHRvIHRvZ2dsZSBDUFUncyBjYWxsYmFjay1vZmZsb2FkIHN0YXRlLCBidXQgZm9y
IENPTkZJR19SQ1VfTk9DQl9DUFU9bg0KPiBrZXJuZWwsIHRoZSByY3Vfbm9jYl9jcHVfb2ZmbG9h
ZC9kZW9mZmxvYWQoKSBpcyBhIG5vLW9wIGFuZCB0aGlzIGlzIGFsc28NCj4gbWVhbmluZ2xlc3Mg
Zm9yIHRvcnR1cmVfdHlwZSBpcyBub24tcmN1Lg0KPiANCj4gVGhpcyBjb21taXQgdGhlcmVmb3Jl
IGFkZCBtZW1iZXIgY2FuX25vY2JzX3RvZ2dsZSB0byByY3VfdG9ydHVyZV9vcHMNCj4gc3RydWN0
dXJlIHRvIGF2b2lkIHVubmVjZXNzYXJ5IG5vY2IgdGFza3MgY3JlYXRpb24uDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+IC0tLQ0KPiBrZXJu
ZWwvcmN1L3JjdXRvcnR1cmUuYyB8IDEwICsrKysrKysrLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj5Tb3JyeSBpZiBJIGFtIG1pc3Npbmcg
c29tZXRoaW5nIGJ1dCB3aGF0IGlzIHRoZSBwb2ludCBvZiBhZGRpbmcgbW9yZSBsaW5lcyBvZiBj
b2RlIGFuZCBjb21wbGV4aXR5IHRvIGhhbmRsZSB0aGlzPyBEb2VzIGl0IGltcHJvdmUgdGhlIHRl
c3QgY292ZXJhZ2Ugb3IgcmVkdWNlIG92ZXJoZWFkPw0KPg0KPlRoaXMgaXMgdGVzdCBjb2RlLiBJ
IHNlZSBubyBwcm9ibGVtIHdpdGggY29zdCBvZiBhbiBleHRyYSB1bnVzZWQgdGFzayB3aXRoIHBv
c2l0aXZlIHRyYWRlIG9mZiBvZiBrZWVwaW5nIHRoZSBjb2RlIHNpbXBsZeKApg0KDQpGb3Igbm9j
YnNfbnRocmVhZHMgaXMgbm9uLXplcm8gYW5kIENPTkZJR19SQ1VfTk9DQl9DUFU9biBrZXJuZWxz
LCANCnRoZSByY3Vfbm9jYl9jcHVfb2ZmbG9hZC9kZW9mZmxvYWQoKSBpcyBhIG5vLW9wLCAgd2Ug
Y3JlYXRlIG5vY2JzX250aHJlYWRzIA0Ka3RocmVhZHMgYW5kIHBlcmZvcm0gbm9jYiB0b2dnbGUg
dGVzdHMgcGVyaW9kaWNhbGx5LCB3aGljaCBpcyBtZWFuaW5nbGVzcyBhbmQNCndpbGwgdGFrZSBl
eHRyYSBjcHUgdGltZS4NCg0KRm9yIG5vbi1yY3UgdGVzdHMsIGl0IHJlYWxseSBkb2Vzbid0IG1h
a2Ugc2Vuc2UgZm9yIHVzIHRvIHR1cm4gb24gbm9jYiB0b2dnbGUgdGVzdC4NCg0KRG9lcyB0aGlz
IG1ha2UgdGhlIHRlc3QgYSBsaXR0bGUgbW9yZSByaWdvcm91cz8NCg0KVGhhbmtzDQpacWlhbmcN
Cg0KPg0KPnRoYW5rcywNCj4NCj4gLSBKb2VsIA0KDQoNCj4gDQo+IGRpZmYgLS1naXQgYS9rZXJu
ZWwvcmN1L3JjdXRvcnR1cmUuYyBiL2tlcm5lbC9yY3UvcmN1dG9ydHVyZS5jDQo+IGluZGV4IDI5
N2RhMjhjZTkyZC4uY2VkMGE4ZTFkNzY1IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvcmN1L3JjdXRv
cnR1cmUuYw0KPiArKysgYi9rZXJuZWwvcmN1L3JjdXRvcnR1cmUuYw0KPiBAQCAtMzgzLDYgKzM4
Myw3IEBAIHN0cnVjdCByY3VfdG9ydHVyZV9vcHMgew0KPiAgICBsb25nIGNiZmxvb2RfbWF4Ow0K
PiAgICBpbnQgaXJxX2NhcGFibGU7DQo+ICAgIGludCBjYW5fYm9vc3Q7DQo+ICsgICAgaW50IGNh
bl9ub2Nic190b2dnbGU7DQo+ICAgIGludCBleHRlbmRhYmxlczsNCj4gICAgaW50IHNsb3dfZ3Bz
Ow0KPiAgICBpbnQgbm9fcGlfbG9jazsNCj4gQEAgLTU2OSw2ICs1NzAsNyBAQCBzdGF0aWMgc3Ry
dWN0IHJjdV90b3J0dXJlX29wcyByY3Vfb3BzID0gew0KPiAgICAuc3RhbGxfZHVyICAgICAgICA9
IHJjdV9qaWZmaWVzX3RpbGxfc3RhbGxfY2hlY2ssDQo+ICAgIC5pcnFfY2FwYWJsZSAgICAgICAg
PSAxLA0KPiAgICAuY2FuX2Jvb3N0ICAgICAgICA9IElTX0VOQUJMRUQoQ09ORklHX1JDVV9CT09T
VCksDQo+ICsgICAgLmNhbl9ub2Nic190b2dnbGUgICAgPSBJU19FTkFCTEVEKENPTkZJR19SQ1Vf
Tk9DQl9DUFUpLA0KPiAgICAuZXh0ZW5kYWJsZXMgICAgICAgID0gUkNVVE9SVFVSRV9NQVhfRVhU
RU5ELA0KPiAgICAubmFtZSAgICAgICAgICAgID0gInJjdSINCj4gfTsNCj4gQEAgLTIzNTYsNyAr
MjM1OCw3IEBAIHJjdV90b3J0dXJlX3ByaW50X21vZHVsZV9wYXJtcyhzdHJ1Y3QgcmN1X3RvcnR1
cmVfb3BzICpjdXJfb3BzLCBjb25zdCBjaGFyICp0YWcpDQo+ICAgICAgICAgIm5fYmFycmllcl9j
YnM9JWQgIg0KPiAgICAgICAgICJvbm9mZl9pbnRlcnZhbD0lZCBvbm9mZl9ob2xkb2ZmPSVkICIN
Cj4gICAgICAgICAicmVhZF9leGl0X2RlbGF5PSVkIHJlYWRfZXhpdF9idXJzdD0lZCAiDQo+IC0g
ICAgICAgICAibm9jYnNfbnRocmVhZHM9JWQgbm9jYnNfdG9nZ2xlPSVkICINCj4gKyAgICAgICAg
ICJub2Nic19udGhyZWFkcz0lZC8lZCBub2Nic190b2dnbGU9JWQgIg0KPiAgICAgICAgICJ0ZXN0
X25taXM9JWRcbiIsDQo+ICAgICAgICAgdG9ydHVyZV90eXBlLCB0YWcsIG5yZWFscmVhZGVycywg
bmZha2V3cml0ZXJzLA0KPiAgICAgICAgIHN0YXRfaW50ZXJ2YWwsIHZlcmJvc2UsIHRlc3Rfbm9f
aWRsZV9oeiwgc2h1ZmZsZV9pbnRlcnZhbCwNCj4gQEAgLTIzNjgsNyArMjM3MCw3IEBAIHJjdV90
b3J0dXJlX3ByaW50X21vZHVsZV9wYXJtcyhzdHJ1Y3QgcmN1X3RvcnR1cmVfb3BzICpjdXJfb3Bz
LCBjb25zdCBjaGFyICp0YWcpDQo+ICAgICAgICAgbl9iYXJyaWVyX2NicywNCj4gICAgICAgICBv
bm9mZl9pbnRlcnZhbCwgb25vZmZfaG9sZG9mZiwNCj4gICAgICAgICByZWFkX2V4aXRfZGVsYXks
IHJlYWRfZXhpdF9idXJzdCwNCj4gLSAgICAgICAgIG5vY2JzX250aHJlYWRzLCBub2Nic190b2dn
bGUsDQo+ICsgICAgICAgICBub2Nic19udGhyZWFkcywgY3VyX29wcy0+Y2FuX25vY2JzX3RvZ2ds
ZSwgbm9jYnNfdG9nZ2xlLA0KPiAgICAgICAgIHRlc3Rfbm1pcyk7DQo+IH0NCj4gDQo+IEBAIC0z
NzA4LDYgKzM3MTAsMTAgQEAgcmN1X3RvcnR1cmVfaW5pdCh2b2lkKQ0KPiAgICAgICAgcHJfYWxl
cnQoInJjdS10b3J0dXJlOiAtPmZxcyBOVUxMIGFuZCBub24temVybyBmcXNfZHVyYXRpb24sIGZx
cyBkaXNhYmxlZC5cbiIpOw0KPiAgICAgICAgZnFzX2R1cmF0aW9uID0gMDsNCj4gICAgfQ0KPiAr
ICAgIGlmICghY3VyX29wcy0+Y2FuX25vY2JzX3RvZ2dsZSAmJiBub2Nic19udGhyZWFkcyAhPSAw
KSB7DQo+ICsgICAgICAgIHByX2FsZXJ0KCJyY3UtdG9ydHVyZTogLT5jYW5fbm9jYnNfdG9nZ2xl
IGZhbHNlIGFuZCBub24temVybyBub2Nic19udGhyZWFkcywgbm9jYnNfdG9nZ2xlIGRpc2FibGVk
LlxuIik7DQo+ICsgICAgICAgIG5vY2JzX250aHJlYWRzID0gMDsNCj4gKyAgICB9DQo+ICAgIGlm
IChjdXJfb3BzLT5pbml0KQ0KPiAgICAgICAgY3VyX29wcy0+aW5pdCgpOw0KPiANCj4gLS0gDQo+
IDIuMjUuMQ0KPiANCg==
