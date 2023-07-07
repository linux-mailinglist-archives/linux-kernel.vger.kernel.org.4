Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0484774A906
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjGGC3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGGC3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:29:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15981997
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 19:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688696980; x=1720232980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KHUlpTaqJqhX9x3ZquUCm6PdfvfDRCTgAdAaeFQVkwA=;
  b=QALOnxIBj/a96NYJGPkSZvhbxcpg6ZPK9xr5lWSpMi8YVCY9GyjxKXIC
   g5QDstRLvHIB9tfvnKk+BEjaYvpwXksb9Yk8EjUSLRDz9nHbJoaDLUv74
   P2klAJ5Hh1SCBvW9lcX75kUthR6QzcCCW6iUP1a4X+ir6VFy+569XDCgZ
   MwD5PYQ4q1N9n/PIBMK6DhiotyMNiHZJC2q8PSfeyORiUmgmyhGL0/E4d
   7HUydt3FmhWihAdaKPgcKUM5PPU5ZATysClMYQMR4T3OYv+lrZprOHGL4
   MEQA4aJFc2dvY07sh5GEqbPazEGIBnJalNNODb5JQPWqg6vHelTdex8sE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="344114025"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="344114025"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 19:29:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="669996207"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="669996207"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2023 19:29:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 19:29:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 19:29:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 19:29:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 19:29:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KppdhBwBZljKGQ1+/Be1eslmj7634yFas3f2qOKkDVYZF/XGQhLO+92vbSwnfaukWd9k68veJ2+zz21s7CLccIRHa4mqL5+zoZR+sOK8DM8lzTg4HVupW769ySSS8aiGloXqKLFrTl6jqgQFJjH3mWx/c9oLZhEfOgXow7owwvRqUKBi4Psb708PxZepgBQFvBHyN6O2Bh+5xFrJRWL/GjT72Dcq7CpzJV3zXFlT6/B+3fr+mYuVGN90vDnfFZuJIL+z9Sl9NDEV0pGS9LLT0cIP/t2Ky/JxvHIPZKlw8bgsH1bikG8CGgiYjtEAJBJmcT+6ceOp5oMOc9/2HO9jTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHUlpTaqJqhX9x3ZquUCm6PdfvfDRCTgAdAaeFQVkwA=;
 b=O+nNbehoRyp3h5Sd52JQFFWJ41vD1DZaLxioAa3W6tYy4dKA69gruivMC7JRzdC/xG76REYJWEBCnBrGmTbuvECgXqaeoLmEvHNpyfoXLk0sZKsTDccfYzrr6YhSYBjyfCcYYOYTNnlKWPdb4TI0uS/CQa+6q8HaaLyG37m0BD+YvLWyLXl0hAKBePxzSXNxyn0COIWNolCqfxlrQ2Ki5IIXdXbvLEZC5ormtEcuCJif93MEdJdnq3JgpCscOLM3fJRvTha9kj1PtHsb3vNQRMtwt1b8p9wVvnJf6MokYNQuFTG2F0Q6w7sq9t+pS5h83Bcj9M8zMX7nl0NxSW5b7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by CH0PR11MB5708.namprd11.prod.outlook.com (2603:10b6:610:111::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 02:29:37 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::c016:653d:c037:44fc%7]) with mapi id 15.20.6544.024; Fri, 7 Jul 2023
 02:29:37 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
Subject: RE: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
Thread-Topic: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
Thread-Index: AQHZr83AFvT4TTcrIkq3d3Abr5XF0q+s3VGAgACpBoA=
Date:   Fri, 7 Jul 2023 02:29:36 +0000
Message-ID: <SA1PR11MB6734D49FE3C2AD0C09FEC57EA82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230706052231.2183-1-xin3.li@intel.com>
 <80383055-7d9f-dea8-1883-91084d0d24a1@intel.com>
In-Reply-To: <80383055-7d9f-dea8-1883-91084d0d24a1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|CH0PR11MB5708:EE_
x-ms-office365-filtering-correlation-id: d797b637-40e8-4bb7-911f-08db7e920216
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gwSKQMryYu8+2vTVARF4brIZqLJFVMKcnC3k+VGXiqv87Glb/SpL99yR6IGtuLWjutv/1yuA1ITWHj8Y7KOqre+82BGU2lYSyCSVNXWwcOIFf+sEfGhX58yMnW6onRHHXTzjxlSSRpRg7fORzmM7pG6LvDKMPwfiOCpDgbg5RiDqNoy1HerAUiokO9WT4TBdAgwvHpbsB74e1mpzirysO2518/c9rD1S1gZOr82jvqvcYEre9p8/uNkHWz2b4KNQdQM1zNvBO0TCoMYhYHcKd/+aOr1EaHgdH23WnR+mmgVdg75DwslGUVcpa2RAMty05KSizit6GORu+bJknnVvkJMmc0ZeDda/0J6fW2hzvrToenSPcugIfLuzTZw0xdvI7RjF0DSWnGM0fc047gklCURysppE4xzOCc5fIz4DVCWN8RUBSxRjJ9rCo5LH1a9N/kSp7AuPLS6o0tLHHJlMfvlLKRHLJS0ZIsemVKqsVu2jRZvNzPK3m5Pl2Hqi3Z3twSiMwXPRm9RnfImRn1fisLCiMMUhhXkxprSzUx+zWOI0C63blzGIRewpWkNx93fekfy1mfntYhuMV0KK0s2cGa5ggi3dtQw7NYoWddxSSwE3Z3oZEh2ztwG1N8yZjuuv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199021)(76116006)(66946007)(66556008)(66446008)(64756008)(66476007)(4326008)(38100700002)(122000001)(86362001)(186003)(38070700005)(26005)(6506007)(82960400001)(83380400001)(33656002)(478600001)(9686003)(71200400001)(7696005)(55016003)(54906003)(110136005)(41300700001)(52536014)(5660300002)(8936002)(8676002)(2906002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTNWZjFPRlI3WmJVQy82MjdMUVZpTWZURG9tMWgxUGd5aldJRDlMU21aWlJ0?=
 =?utf-8?B?NXZxa0gvQ3pWZ0hGNUIwek81Yko2anNlMzdZMDZlYS9maVVqcVRWbDB6ZlQx?=
 =?utf-8?B?R0lJK1o2eFhXTkRVelN3SnUvVy9McWVWU0cvMzRrTXkrTXFwNy9zR1U4VWVF?=
 =?utf-8?B?aldobHUvL1hjdWd6K3ZPdDFvbk5sNFlUdDA5a0xFRkpGeW9NaTBoUzNyT0dJ?=
 =?utf-8?B?c25yODN1cGpKaS9BK3ppeUVWWldBYVdtWkVlMHBHV2dvdzdlLzI5NWc3VXpj?=
 =?utf-8?B?dkxublgzM0pQd2RLWndlSW40cHRlVEdLWDJiREtsQlpoZ2hYYXVLbDJUcEdu?=
 =?utf-8?B?WmRJOHhJWFdwTnFONWRQcXlqYUMwNUZmVXcwTEFJVTkvZGdkKzFmV2Q0SEJP?=
 =?utf-8?B?WklIWGtCNjUxbUZ6RzRhQUxCVmJ5MzhKUlJ4NXQzbVlYMlNRelE0RTVPTzJy?=
 =?utf-8?B?bmNwY05jaG5XQ1FpZjhHaUI4bjYvWkZqc1FkdWs2QnVUa1dUQzdkRnhhZ0pH?=
 =?utf-8?B?TEdwVFVDS2t3SjFGei9rNnorcnJxRjlibEVwcERtdzFjTDY1QTlNU3hjWFFm?=
 =?utf-8?B?SVZlNW9zMGNZaHBPbXZGY0NHMmJBeThueGhEc0Q2a0pBWjZBK3hDWVkxWG53?=
 =?utf-8?B?c3NwV0QzWGVPb3o4RWFoTGJzU25CYURJY2V0bG13dnJuTlZVRVdDb2s2UEpZ?=
 =?utf-8?B?cXVTZEtLMEpHQVVWNzQ4eGJRdWdVQ0NqektxMXZjajR5cHdRaEhrTTdxT0NR?=
 =?utf-8?B?Mm5CNFEySTlwZHJvbks4ZDJZcDk5clQ3WjNENHQzY1ZwMDVHcEYrb3U3YlNw?=
 =?utf-8?B?cUNrK05mRUgyUkJtY0p1cEpuSzF6d0REM3EzaGtMMjZzK2x6Z21ET1VkVmN6?=
 =?utf-8?B?dEpDRGZqM2dwSGZMcHY2L0Z4Tk9aK3lIazV5b0lLMmgyQVRmU0srV21tY1JC?=
 =?utf-8?B?NzFVS2dPV0VNQThwUHhmS0hCaXliMDFjVmtMQ1czWncwajE0Nmw3WDlxelZY?=
 =?utf-8?B?WGhCWW13SGM5S2lReHJVeGYxSllGajZtWm5QRlZjWU9uOVV5WTRtQlQxY1pi?=
 =?utf-8?B?NG05UnM5NjI2Tko1Z1cyVXNLb2VKcXhMMWRoUWNKMUJmQzVtRlVjK2h2cThF?=
 =?utf-8?B?aDJ5RXNzWThjWCtyN2VDR0paejlaVk4wam5xWWdMY1JkcFNCSlp5cmFkei84?=
 =?utf-8?B?alFma3o2UDVVZGg0SVFleHY5ZVVNOGpRdWR2YUJyWXdRM0U2bEZ2THBZUkJj?=
 =?utf-8?B?Ynd3c1cxWXBEVFAvWHljSGtob1VJL0lOa0tka0REM2ZRaU8rUkp4aENDakZ1?=
 =?utf-8?B?VGp4UEdLa1RwRTh5dE90eStnWVA5N3kzNU9yNERVeHkxU0swRmJydUJXUkhv?=
 =?utf-8?B?TW02NUxYb3B6NDJsdVViOC9OL293aUdyUWNXSlNvN2E2VmZoK2RldktnbkhB?=
 =?utf-8?B?Z0E3VjU0NENiZ3hWS0VxOSt6UG92dnptYkZnaFBwVlFaRGpiUFhXSkd4UTJm?=
 =?utf-8?B?blBiODF0MUIxMVdHZFJFM2VCZTJrUmxBOVJ3cnAwWXZPbGhYeENPWTRoYmhV?=
 =?utf-8?B?eG1CaEdPQXNDby9FR2pWK01BV05NNSt3aGNCdlV3dFJPM3haSG5HNjJ5Zyt2?=
 =?utf-8?B?S0w5c09jUC9QNXppc1lMVEV2TFVoemM2ZnZ6ZDlBcFhjbnR5ZXlONWk1ckV6?=
 =?utf-8?B?bmJQTUFSOTBublRCaTJMSHdOSFY1cjUyT0N4YlBGQ2NQYUpUdFloZkFhb0xX?=
 =?utf-8?B?UW5CZVgyM1FiaVpsLy96Q01qZytqSVBZQ1dhMEkvdGRwSmltS0tTbHhqQkYy?=
 =?utf-8?B?YVM4Szg3WWJ5Q3daaWxJZEcyUW5yR2I1V0cwSDhKRGlyQncvdFhtUkhWT3Bu?=
 =?utf-8?B?bGNhTGEweExMUFpxc2xHVXZkd2xmSC9naTRNY0JwMHlGYjFjQzJBaElTenJo?=
 =?utf-8?B?cllpZzhOZG56VGx1ZFBWL3JoMHFKT1AwWlpiMmttbUpkTjBpNkxaSU5hcEhD?=
 =?utf-8?B?alhORmNIQ1B2a0krVGVCcHI2TUUwZXphTmNMM0kyUnAvMjJDZEV5cE5rYUhQ?=
 =?utf-8?B?UjA5eWZrL0F4Y1dzZWZ6RWl2STJlZnJPMDlsRGNIY0dBZC94Vy82djJTOFBu?=
 =?utf-8?Q?V3TY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d797b637-40e8-4bb7-911f-08db7e920216
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 02:29:36.8226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IlGY3z0bytSQLkKSsUajOyHZi+ce18zembH5TUB14XCi6PuCKlIQKwkFsx/0/OBp/5ahSLLkb5Mz8uBnpjA88g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5708
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFdoZW4gYSBudWxsIHNlbGVjdG9yIGlzIHRvIGJlIGxvYWRlZCBpbnRvIGEgc2VnbWVudCBy
ZWdpc3RlciwNCj4gPiByZWxvYWRfc2VnbWVudHMoKSBzZXRzIGl0cyBEUEwgYml0cyB0byAzLiBM
YXRlciB3aGVuIGFuIElSRVQNCj4gPiBpbnN0cnVjdGlvbiBsb2FkcyBpdCwgaXQgemVyb3MgdGhl
IHNlZ21lbnQgcmVnaXN0ZXIuIFRoZSB0d28NCj4gPiBvcGVyYXRpb25zIG9mZnNldCBlYWNoIG90
aGVyIHRvIGFjdHVhbGx5IGVmZmVjdCBhIG5vcC4NCj4gPg0KPiA+IEZpeCBpdCBieSBub3QgbW9k
aWZ5aW5nIHRoZSBEUEwgYml0cyBmb3IgYSBudWxsIHNlbGVjdG9yLg0KPiANCj4gU28gaW4gdGhl
IGVuZCwgdGhpcyBpcyBhbiBvcHRpbWl6YXRpb24gYXR0ZW1wdD8gIElzIHRoZXJlIGFueSBvdGhl
ciBiZW5lZml0Pw0KDQpZb3UgYXNrZWQgYnV0IEkgdGhpbmsgeW91IGhhdmUgdGhlIGFuc3dlciDw
n5iJLCBidXQgd2FudCBtZSB0byBnaXZlIHRoZQ0KZGV0YWlscyBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2UsIHdoaWNoIHByb2JhYmx5IEkgc2hvdWxkIGhhdmUgZG9uZS4NCg0KVW5saWtlIElSRVQsIEVS
RVRVLCBpbnRyb2R1Y2VkIHdpdGggRlJFRCB0byByZXR1cm4gdG8gcmluZyAzIGZyb20gcmluZw0K
MCwgZG9lcyBub3QgbWFrZSBhbnkgb2YgRFMsIEVTLCBGUywgb3IgR1MgbnVsbCBpZiBpdCBpcyBm
b3VuZCB0byBoYXZlDQpEUEwgPCAzLiBJdCBpcyBleHBlY3RlZCB0aGF0IGEgRlJFRC1lbmFibGVk
IG9wZXJhdGluZyBzeXN0ZW0gd2lsbCByZXR1cm4NCnRvIHJpbmcgMyAoaW4gY29tcGF0aWJpbGl0
eSBtb2RlKSBvbmx5IHdoZW4gdGhvc2Ugbm9uLW51bGwgc2VsZWN0b3JzDQphbGwgaGF2ZSBEUEwg
PSAzLg0KDQpUaHVzIHdoZW4gRlJFRCBpcyBlbmFibGVkLCBiZWNhdXNlIHJlbG9hZF9zZWdtZW50
cygpIHNldHMgdGhlIERQTCBiaXRzDQpvZiBudWxsIHNlbGVjdG9yIHRvIDMsIHdlIGVuZCB1cCB3
aXRoIGhhdmluZyAzIGluIGEgc2VnbWVudCByZWdpc3Rlcg0KZXZlbiB3aGVuIGl0IGlzIGluaXRp
YWxseSBzZXQgdG8gMC4gQXMgYSByZXN1bHQsIHRoZSBzaWdyZXR1cm4gc2VsZnRlc3QNCmZhaWxz
IGFzIGl0IHNldHMgRFMgdG8gMCBhbmQgdGhlbiBjaGVja3MgaWYgaXQncyBzdGlsbCAwIGFmdGVy
IHNpZ3JldHVybi4NCg0KVGhhbmtzIQ0KICBYaW4NCg==
