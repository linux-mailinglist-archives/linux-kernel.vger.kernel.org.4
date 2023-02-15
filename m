Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9787469849E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBOTnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBOTna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:43:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3111F3252D;
        Wed, 15 Feb 2023 11:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676490209; x=1708026209;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NQVCXrW2fm9tTPCYl25kx63gJCTUkAjHZdPxz40uby4=;
  b=ibPwLyoPCPtw/wJLBXuCSjCe93FXqpNTr0IXlM661D00DMi71fnmzGe7
   NtEWlB8ZgUFoam5OQ0ikExH6m+HiwtZiaWv6KMgZov4P/tkSKoN+oNYyo
   OEllvfe6pRRtkIleFB3N0f2ZJlCrD6HVhQEKwbFwZbSTQ4Z+bZLMKJ8/C
   unCChPwvRD9zewY0G2R3wQWhkgg3CvzkQpoXQY/u5bA7we5cVGfED0LGh
   E1Mhqf+1W9/NnKl4XH3UlghcyYtODMGJly8g/n/8rVVTHBllzpkytj+3H
   tFJ4ZS4frqLxEZwOTUz54TLT5Wc/LP/P1BNP2K8TQj3wKxkQ63+k0Qcd/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="311891574"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="311891574"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 11:43:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="671844256"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="671844256"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 15 Feb 2023 11:42:57 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 11:42:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 11:42:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 15 Feb 2023 11:42:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 15 Feb 2023 11:42:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqgiIOCOt4YY5rn7No7qtVmZsifErQ2yVBcRd54N0tpyYueej9DTqZnwLv1reUvNgln9bVHsc679H3WFrxa2x19PfHAR/JoYAUdhUGDY+LotXPbsRocnqacgeg1VBX+Zkz6oG1Fbo3RMsqZa3IJBIhjKBtX2RJf1fLuTcLk9DyeuPvXgsRvSAxsF1MCYMAUKSMXsXHVuSkyvwsKClH0bKtiXjgDZ2Ptu3Bs4ehRPnzh7kTPBGYDeunI4rS3ijuA+w9MkVQa0rmDPxaaM+LyDD88K0BgRHl3WbmJ+DhVBBUkygTzKGSbvQheO/YsB/kp4ho/lg53ViYKEeBKJWcADXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQVCXrW2fm9tTPCYl25kx63gJCTUkAjHZdPxz40uby4=;
 b=GEaWQS7F0atzsOUrORx3h1I7cYDiXmnq7NUS56oYGUxGpjwOZadAymch9D93fbWhfPREvap2FqozE1wwIP4by+mq/uFSsc+JejQyThhgp3AX2NyJAVrCjgMCfZDQTpk4uK2vh+rkwGXVYcCSzymHGAL4nWXE+gtWNg12X5SjP0McPXdpe2So9iag1tSSx+cw+Vx3BFWzWc3HYmyE7lSQhZkQy2KKQk+MPonHLhD+jg6vRSQDpZ7Dj2jMiTjdeV4FN6Hze0IHG5v4gd/YypD9dnABlmmczfevFV5w26oeUL8RGdQog38ywICGsGABRiykJfh8QoInvZnYkCCNExU4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 19:42:53 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%8]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 19:42:53 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Subject: RE: [RFC PATCH 0/5] Retire IA64/Itanium support
Thread-Topic: [RFC PATCH 0/5] Retire IA64/Itanium support
Thread-Index: AQHZQSRuAFzkBACXkU2jmTTMeo7DNq7PywyAgACasACAAAKs4A==
Date:   Wed, 15 Feb 2023 19:42:53 +0000
Message-ID: <SJ1PR11MB6083F7F30FE9ED8F39FA1F85FCA39@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230215100008.2565237-1-ardb@kernel.org>
 <534469b750e1847e1645f9ae5ed19dcc80b82be6.camel@physik.fu-berlin.de>
 <CAHk-=wjEmZ19T4XpVb0_Hacm53xJG_w5ygcuorwC0xBoT-myUA@mail.gmail.com>
In-Reply-To: <CAHk-=wjEmZ19T4XpVb0_Hacm53xJG_w5ygcuorwC0xBoT-myUA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB6051:EE_
x-ms-office365-filtering-correlation-id: ba861cac-f1a4-493b-11ea-08db0f8cd459
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +/NDvhc1HUfSYHs/JEJjejZVs+4Iljex6+lHrl2Pq/hGrvIS1sxKgYTsx2Rf8Zotvh4skluSqT1VZ3PGsOYYjOaY/HrLsDOLWZCT8lPagueO/+aFItlkXyfFSsjyV+0EaBeb2xr8I4cSpa6DydgR3Ub57B9yBZRGK5chK0VVNLLQ621YeE+wrmgY8qneQOg1uw13vlvTYBPcy1q2cA2aSuIRt8vM7RvrXv+WeYTe5GRZUFrOeG2m/DlnF8wCx6UR9Nfos3mIyZTNdiE9bkk7D+aY0qk+Mn1AgS0sCKFoNy4/2a2yAfXOZ/W2r9xvqMgLdR7kufsDMkYKTgYjoWglUxKvjmFGBmFUvZ/fjFTT8BmNmMuX0GGQAhOu8YNZTdxrCJCz+6KI+aEyCXWcVpzuiZCVwj3yo85c35ebMT1E3AeOmym+ZNbjzSiuvsrrvXddU8aNlflYmeSj1/ZhLLcKKSWn3lr7fw6kCkITDs68tNQPl0N/+NiBjssMhfehNmPNs0LskGy/Wc5bU3VkwUWK5VZro8gOg0BK5M012KJzbu896aHrc3tJF6Zq3N1MMh6ZrueKNzIUZSgOxHnD6oO8ZZvpWld+nSinAQcZLUWsAeIpGDUDnWsU0WwKBBzPL2G/g2X+ym7Pm71c6KShL0Rw2e6/XC6CXtEs55YRRALVd7/2Wvc1VhOTJjMWJVANg1anM8jOFoCyxBM5BbPDoETtfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199018)(76116006)(66946007)(66556008)(66476007)(4326008)(8676002)(7696005)(478600001)(110136005)(316002)(71200400001)(33656002)(54906003)(122000001)(55016003)(2906002)(86362001)(66446008)(5660300002)(7416002)(4744005)(8936002)(52536014)(64756008)(38100700002)(82960400001)(26005)(186003)(9686003)(6506007)(38070700005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEFvZ1ZsMlRPMzF1TnJvNVdFN3Y1YWZCeXpHK25MRi9HdmR5RlBWRVJSVWpo?=
 =?utf-8?B?ZGtBdGhsaVpZUWFWTUNMUXVtakRsUmZFc2lmdUdUUzkrUUwweUszaHNRbWtx?=
 =?utf-8?B?QnZIZjRtVGt6WHMwcnU1ajdEV3R2M1BjTXI0Skl0K2xnTE9NcVNPcEQwSlVp?=
 =?utf-8?B?NGFoVUxPdGpOdlFsLy9XU3liZXlGK2lDUS9xVy9IUDZtdENnTytqTUtCbCt0?=
 =?utf-8?B?Y3IxS0FFYWJUSUU2czBuUEJqaTA3bGRldTJHWmN6b0hCNmFwbzRXU1RmSC96?=
 =?utf-8?B?ckUrQU5rTStrYzdUTDEvZlp3dXdOZUpHZXdjNEpHUTBkbDNSRTI4dUczSnd6?=
 =?utf-8?B?aWRaZ3FRaHpTRGF4bjlDVFJlaEpZNzJpdnVUa2VhY0JqM0dUTE11Uk5ldFM5?=
 =?utf-8?B?bUdieVd3dzg0Qlg4TVhCcnB6S2ZNUVZRUFJlNHljM2RGcWd1NTcwcWZTQ0Vr?=
 =?utf-8?B?RTFub01GSHY4aFVmVXoxS2cxZHNFQTh3U3lFS3YrNE92RXpKTmZhU0xobHB3?=
 =?utf-8?B?S2JVcTExbGNIbXZWejJjVjdReUltWlExQUdWTWgwcVVXSmJ6c3V2TDlDM0tm?=
 =?utf-8?B?Q3hWMEJybmw5VG5kYW5Wd2NzQklVRHJ4MG9KbFdiK0lLZHEvWTBiTmRZbWk1?=
 =?utf-8?B?UWNyc21EcjFOUHdvcjh1MU5CeUtTajc0VFZlQXM2RVJGczdWMG4xM3VnR3lN?=
 =?utf-8?B?enJFUkN2TGpSNE5GY0hoQmpUazRKNFZwcmM3TW91SGd4M21IUUhjR1MxTTN0?=
 =?utf-8?B?elYvV2g5M2pTdlNmYThGd1BPOEo2MDdmLzVGZWtvRmdWSVAwU2ZmV1Q4Q2tR?=
 =?utf-8?B?bE5tSkZReTFpTm5uOU9iV2VmOGlJOHZRbUF4VExvWFBGYjVPci9pQzNGNjlh?=
 =?utf-8?B?dGFjZVNtSXpjNC9ER2xSQk9EUXRWdWhkZjZhazJZakkzZi9RSkNkbGVnY283?=
 =?utf-8?B?M2M2bTdzOHRTTzNQM1Btd2dCbW1CUy9xV1ZlYXAzWFVXUVVnQ3ZPWkZMUGtn?=
 =?utf-8?B?eFcyQnF2Y29taEhkQ0hQbHZKdVlWSVQyL2NjVnA4UG1nRU1weXIvclhOV1Mx?=
 =?utf-8?B?WHVySWhhUUNHeDdTMTAyWVJsVGkvd3JiTTlKSk9aQWFHRmtiRU9RQkpab01K?=
 =?utf-8?B?ZlZwSVowaHMyWnNEdDBxcFhyZVBvRzFndXJLMWZPbnpIYy8xQ0lXcDhLQVJQ?=
 =?utf-8?B?TysxWWNUK1JBaWVXOVpoZ2xVVTkvV1JZa05vUUdUSE1PUXFudUhlN3lPRlJ6?=
 =?utf-8?B?UHZhMlRRMkNZdTdQc01HUmZzNmx0MHhSRzloTGhkK0Z5REE2ZXlmZE9UNmQ5?=
 =?utf-8?B?V2VLNmMvLzg0Q3h5SDE4TFlmbXZydFltWFFNd214cm9nNTRmazdJVVdOTGZv?=
 =?utf-8?B?QUZQSGZZSTNSQjVTbnFjRTVpbWVJc0VGME42a2EvbHl6UGRKQTJlWkRZWjZI?=
 =?utf-8?B?ZGtBd2duMURRYy9LU3FBbmdZd0ZYT1c1bkRrRTVibExSa3dXejRmWVlxcE9M?=
 =?utf-8?B?dXE4OVJheXJXRmtNbzJpN3hyTWgwSVFodWo2RDdyei94Nmp4SnVlQmJkMEIw?=
 =?utf-8?B?OFhVZXR4aTFURmhiZC9jajFUUWpqRkl4US9SY0FWL3MvSWxYc1pzOUZyR2g1?=
 =?utf-8?B?VjZiOXpsbkZLQjM2ZVBYcWhPb2wxOU9ycDJIRzRyelJxMEREUmhsZHZVTWpm?=
 =?utf-8?B?RmxpdFowczh0eHBBVkZOY2RpWVVBZDRLTE43S0JOZmNHZDV2T2pjQXhUL0pM?=
 =?utf-8?B?cUkySFpnR21tc0wzZFg2ZHNMa3RLMC8zaUtTWG1uOXlheVVMWVYzUElGZVUw?=
 =?utf-8?B?OFlkMHloQUZnbHBPVlY4UGliV251eXF2dGl0eUZKVHBrOC8weWF1d0VGZEx0?=
 =?utf-8?B?RyszbGpzWWxPOFRhdlRyY1pyRGQ5dUcxa2tQaXJDSzJBMVNkS1AxY0M2dzY1?=
 =?utf-8?B?RkVhTDFYV1lOOFd4S1ZBU00rNmNMVkl0K3pQalpaejR4ekJjaVRrSk1Bd3RS?=
 =?utf-8?B?YkNRRGZ6SDdFNlh5b3AzWnpkZFZBYm91TFRSYXYrUE1JTkdxVkpkc0w3c0VP?=
 =?utf-8?B?aXl4TVVBNWZoeFFMdi8rRzJyUUVGQi9UVDNBQ1hvYVorejBsOGt4OW1TVVJD?=
 =?utf-8?Q?drFGKrH4iVyrA52PWdwGiZbIA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba861cac-f1a4-493b-11ea-08db0f8cd459
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 19:42:53.5189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYQSe9kmfw0h5YKTQEO9kURvzGQczcOiHnx+GEZgpk1SdnaOZL45evbPq6hOwKRfMDqVJ8UlnLrMDWs1w2Qrqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJJ20gbm90IGEgZmFuIG9mIGlhNjQgYXMgYW4gYXJjaGl0ZWN0dXJlLCBidXQgaXQncyBhIGJp
dCBzYWQgdG8gcmVtb3ZlDQo+IGl0IGVudGlyZWx5LiBJdCdzIG5vdCBsaWtlIGl0J3MgYmVlbiBh
IGh1Z2UgbWFpbnRlbmFuY2UgYnVyZGVuIGluDQo+IGdlbmVyYWwuDQoNCk1heWJlIHlvdSBkb24n
dCBzZWUgb3RoZXJzIHBhaW4/ICBJIGFkZGVkIEFsIFZpcm8gLi4uIHBlcmhhcHMNCmhlJ2xsIHJl
cGxheSBzb21lIG9mIGhpcyB0aG91Z2h0cyBmcm9tIHRyeWluZyB0byBtYWtlIHNpZ25hbHMNCmFu
ZCBvdGhlciBzdHVmZiB3b3JrIGNvcnJlY3RseSBvbiBpYTY0Lg0KDQotVG9ueQ0K
