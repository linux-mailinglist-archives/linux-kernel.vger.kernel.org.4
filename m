Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372AB6EFC91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbjDZVjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjDZVjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:39:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3439173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682545185; x=1714081185;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=52V+Y+P47HZnyBIoVAWZMEu78MH8PismSVFN345AIoo=;
  b=ecyKsXgGfIf0Hq5C594g6PbXGmbM3kiHnYH1ms2w4qLeZ/fZj6MIp3PC
   Sx8c03t5spE6Eir5q45PLC5AFsWZKgDo7kdmKyYWOo+JR8vJs8hXaOLxo
   vUF1QKmGTzR3/+amRAgCTS4vZfxeibHnuIoQd4TtBur0Lit2OLO7VPeVb
   pBuV9CrsCWQwXNIaxGCxMQt5DDN4QlIx3YJJI+1L/MW4MuYt0/ZMGto0W
   Q2H9d/9IuGr+639NzHFKbijxeM6AmLQrt2vpULHhx2m1fuDEJ1+1ZPsoe
   fNkpv+HxcuhLI4YVbbf4zg19dAQ7mqKBGFHFuRvAnWv44ccoG83vaZmxC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="331480048"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="331480048"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 14:39:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="688120116"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="688120116"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 26 Apr 2023 14:39:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 14:39:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 14:39:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 14:39:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 14:39:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwaMpVTdXHCHmmAoUdCQ6MycGZFkfECq3qXoMW6X6O/dVCRm8mNsfJb0jQ36GBOH/MCg1oPlmT84Oo2JLWT4HE5QDODldB+XlCH/IOu37b7zvnOWN/XqAyfZroIlOTc3UaUW6BWj3dHBxDdqVF5/5vH8vqZvXJAo8rv18vQIk3JXDSmGEPoJg39OJe6ak7KbsFfuim7EnFWV1SmAP5XYEz+ihxfbhBV/3qMLJDf73tV/nynzW1Ah+QaQyh8SH2gQ85FjjBpGMqULNaGJF7Y3fHiwg0D4KjFeNRGXGvbqA7DB2G/L/PSN9eHEGqkgQPrTRGEl6DgLDVESyPpf9Cr2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52V+Y+P47HZnyBIoVAWZMEu78MH8PismSVFN345AIoo=;
 b=X/2QKc6JOJ2yyIN3653py12AkElWoDBM+ADjpuCONld5KljNNU2Ce5chI5ZJ2/9wtQEDnJhjr7r6SMBmftHBc58LegZdZAw85MZsox5gnt1NcTDB9z8oD4s8VVmUSHz9EFidd4OBfRhBFvS7okIlCykFWbXjLnAsLlCDobzKvMQtV1Nm1Lh9768TP2hw2Z09uvu+kSEvNuQvu6ro48ynsngZnzNZpiROSt45PTGMNDGsOJG2DZzKhH2b2IOuRBkuc+AJKXx4IMc6kPigzAr99V3UGUJcnTQflzB310E4QWai0M0XCIPmAbd09qm62oqv2aF8gK5bQELG1uwiPwS+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5444.namprd11.prod.outlook.com (2603:10b6:610:d3::13)
 by SN7PR11MB6703.namprd11.prod.outlook.com (2603:10b6:806:268::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 21:39:39 +0000
Received: from CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::a3d1:bd7a:6d0b:3f29]) by CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::a3d1:bd7a:6d0b:3f29%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 21:39:39 +0000
From:   "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
To:     "Hajda, Andrzej" <andrzej.hajda@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Auld, Matthew" <matthew.auld@intel.com>
Subject: RE: [PATCH v7 0/2] drm/i915: Hugepage manager and test for MTL
Thread-Topic: [PATCH v7 0/2] drm/i915: Hugepage manager and test for MTL
Thread-Index: AQHZeFHU4hKj8xc/dkCVVRjZhAqYXa89tJzwgABpF4CAAABC8A==
Date:   Wed, 26 Apr 2023 21:39:39 +0000
Message-ID: <CH0PR11MB5444347394474788750B2FD5E5659@CH0PR11MB5444.namprd11.prod.outlook.com>
References: <20230425-hugepage-migrate-v7-0-fa6605a986c9@intel.com>
 <CH0PR11MB54443013C3378D4D5992033BE5659@CH0PR11MB5444.namprd11.prod.outlook.com>
 <f573abd1-669e-b376-b9da-db62f796887d@intel.com>
In-Reply-To: <f573abd1-669e-b376-b9da-db62f796887d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5444:EE_|SN7PR11MB6703:EE_
x-ms-office365-filtering-correlation-id: e0a26e69-a3a2-4091-6b34-08db469ebcdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aT7NI4BRvtYmub9qkD6bgLFifgaoodqOqJLkYixFPe0AVUAaaddIPrOCO114J2ciC9CRt6U1LnlE/+g+1Bh2Ai2U5YlUIdwf9Te4occfFJLRRZOZ8maBi0uQ3m7IygxkcfhcP8ob+xDGM2BCLK8gtGjIG9h82ZorBV1KSzyk+/pAHFuurgI9m+2w9FwYRpVUExvgyG3knWJZVuU4E/B/UzdBHUJXUHuk2MBi6x79BCeqzliEAdVTml2vQnNaXO+gyGWt0FNEIS9VSsATj56IjPD5jLkAwu2q/FUZrHxUobJJ565DEtWV2+9K7UG+/lp2K9YB3gRQ6u+47X/zi3F6BI/f6WIUh0PsF5E2ZY3MhNMMCGBjJbV+2KiFyEQrQd6O86fJHvh8qBTOBWwVr38oA4ju2jhNR6MyTFBA6sK4H1Y2SWa8uMpSkqxo/uEDg+xttBg+dD2W/k7Dwmd7W1jZ2rDUTM36vfR6mmRZ7sP4b/f4x/4S/oPSp5J169/nrVDY/74bSVqbKdCE/SewBBzTcWBG4RD0f+1VKeOkkPx38KeTinNTmb84qf4RFPArM+cfl8wa12lLJrjyX0lJVvWetzRgnICmvl1pPCF2MCzuAyggwu2PZvsfcM4lGCISH0+i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199021)(6506007)(26005)(53546011)(186003)(478600001)(110136005)(33656002)(5660300002)(71200400001)(8936002)(52536014)(8676002)(7696005)(2906002)(38070700005)(41300700001)(82960400001)(86362001)(6636002)(316002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(38100700002)(9686003)(122000001)(55016003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUYxTXZmOW1FdXl2Mkpsb2hCbXphblBUdXkvSkFPWmo2Y2Y0WjJIVTlibm56?=
 =?utf-8?B?UWk1K0hXYzQwdnJtclRNNStMN29YMVpXL3F3QVh2bExYSnFoZzR0czZxU01U?=
 =?utf-8?B?M25XakNxeVd4cnF6VWhKZUoyVVhPRzh3bi9vZ2ZScmJkUndSY01UZEFnVWR3?=
 =?utf-8?B?V2xtTzEwUVVaazVGTXlWVEhTNmFjZktDeEt4R2hWVVo4S0lqM245ZkRjTG1X?=
 =?utf-8?B?YkloMisrV2NDVjFCeG9ERXVCVFJhdFRnRFh3TXVYcFhYTjVHc3pobGdzZ2E4?=
 =?utf-8?B?K0NIdWlOSEVSbGRCZXJZb3VtUGY2OVlsVzlvZ3lTZTRIZGJCUm9BeDVyTnpt?=
 =?utf-8?B?dHBRRklhcjVNWHJ6TUhSWk52YVV3aGlId29pUzJKS2hCZkNGb3g5dlRkR1Nk?=
 =?utf-8?B?TC91aU0wdmhWQmJ1TmpWUnpMdUhnMWlJbE8wUXhuT0k4OGRPaWtOazdPSG5t?=
 =?utf-8?B?NWNJdy85aGJwR3RoYm5FVHJIbm9BbUJuUStMVHVPMld5d3QxekxkTzJRSEJD?=
 =?utf-8?B?aFdLTVkvTk9OTEFFdkRPQk51Kyt6anZ3TCs0Y2JYWDhkVFdHbHhPREE2VW9X?=
 =?utf-8?B?dnhZL3VkVFZuQmhjNjZPWW9EMUJVTFZPYk1xcnE5MU16SkVEUTRJS2M5bkdL?=
 =?utf-8?B?N1NNYnJ6OHlqZjVkU3RHVHJjTTRJT3U0TENWRGtaZEFpN3pnYWg1amRJalcy?=
 =?utf-8?B?VkkyNmx6Vnpvd1lqYktZaDlKWmlCOUxib004MGU4NGw4cUVUTWRqcjJWVi9X?=
 =?utf-8?B?cjljMFd0RDc0eEJvUnJURXNNWHRUZmVnUDZHUW1UQTBnL0w4aFZGaCs2eUFE?=
 =?utf-8?B?REVJdkZ2L0FyVVJxdUNuTmppbUliUXVrNFJEV0R0WnQwZWtUUUZidFZhOXhn?=
 =?utf-8?B?OVkxZjlJYVdZcGMrK3VvbE5LQ3diczhoY0hqd0VzdUdPdklESy85OGgwYWxM?=
 =?utf-8?B?WDlIek04MGxueVpHNTNrSDJLQ0k5VURYM1NkMXFrQnNHT2szeDlCNHFBRWk3?=
 =?utf-8?B?dnIyOVNENjErMVMyRDI3eTZkTi9kU2J3ZDNGN2dsMmFOYjBKWmhaekhnWUQw?=
 =?utf-8?B?SHNTSUV6RkFDdm5BUFl0UmNOTXF1ZVdwb1FVbjRhU2RKRklCVHk0bjYvNlRG?=
 =?utf-8?B?MzdlcUlYVEpZd3BrY0JMYWgyMlJIaE5WemZNM0tRQ2MrcksrUkZoN1pvbFRT?=
 =?utf-8?B?Q2ZyekdCZ3ExbkhiR1VHMVJ0NTZ6Y3ZESTNZVEhUbWlCN0lyYWZxUTgxVi85?=
 =?utf-8?B?SVl5cCtWbTVwcDZwbXM5SDh1SXRmMFM3YVUveTVDTXJFSndvSlNHdmVuSy9T?=
 =?utf-8?B?MXdiNTkza0d6UUVNSUFNTkVMS3I1T2dveVpHcWFaOEJsL3VHODdSa0FaL1g1?=
 =?utf-8?B?aW9SVXRERk83Ny9mK3VubjV5S25Rek9meXplbG9LS3ZKU1Yrc0N5Nk5zQUQ4?=
 =?utf-8?B?UHI1eStCbnpwOEt0dzk4REhyNWJJU2t2eC94UVFIOStRRERyWnY1czQvdXcy?=
 =?utf-8?B?VmV4Sk94K3Mrd2JrLzFCUlplc2NTZ3dMUXlTWWtwVXM1U245bEZJNHRGYnhK?=
 =?utf-8?B?b0trd3YwQ1FGMVlMK0VMb1V4dTR4UHpTeTd3ZnhaM3g1b25xTFgreld6bXhh?=
 =?utf-8?B?OUJmSW1Ecjh1WGk5QitIRU5PZ3pGNzlxL0grUVozS0RDSE52aHRCbGNwdzdy?=
 =?utf-8?B?SzZ2cmhCVXVWbzRlV3U2OUVDYjRiZCtwcUZKREtuNEVRSjlsVTFWenVXYW5V?=
 =?utf-8?B?bXVZM2pVdUs3dytUOGRvRnpmT2laZE1YM3o2Q1dQV25oTzhLUnhuOG1nQVNN?=
 =?utf-8?B?Y0JBRlp1K3EzS09JWDNNa3BrdmQzaVF1VHljQ1hXaGZxZXNJem5wVHlOLy9u?=
 =?utf-8?B?YnV0dnRQRjFIQXk2OWh0Qy8rM1B3SUhZaUNDcnNKUGJSdjJsSTlaS2N2TG5P?=
 =?utf-8?B?VnBQd3hUQ2dOSzlEbHVRcVphTWs1MFFJT084U0NoNnJ5N1RnRmhqVGQzbjV4?=
 =?utf-8?B?N3h0LzZGRmdLUHJZR3Bmb1l4VldUeDlFaFIxYjlTakxjOEJyRFk5bTRPWWty?=
 =?utf-8?B?bzREOUNmMlh4aUJzTE5QbUlpbGdYQjRLT3BSWDhWMGx4K0pROEM3a1JyeURl?=
 =?utf-8?Q?Qw5htCxTgyJGHtXa8bOrFAsaE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a26e69-a3a2-4091-6b34-08db469ebcdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 21:39:39.0459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYe5GXQSOY5mKVH4bXTTVlzCjEIY5S0FQ93B9t7+7hN3hGMoaTsXDuTT3XzLn1ZDd8I88TthBhA7sYCIo7EmLZmh1EiaEnV7hs/HEfh/lzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6703
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEhhamRhLCBBbmRyemVqIDxhbmRyemVq
LmhhamRhQGludGVsLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEFwcmlsIDI2LCAyMDIzIDI6Mzcg
UE0NClRvOiBDYXZpdHQsIEpvbmF0aGFuIDxqb25hdGhhbi5jYXZpdHRAaW50ZWwuY29tPjsgaW50
ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgQXVsZCwgTWF0dGhldyA8bWF0dGhldy5hdWxkQGludGVsLmNvbT4NClN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjcgMC8yXSBkcm0vaTkxNTogSHVnZXBhZ2UgbWFuYWdlciBhbmQgdGVzdCBmb3IgTVRM
DQo+DQo+T24gMjYuMDQuMjAyMyAxNzozMSwgQ2F2aXR0LCBKb25hdGhhbiB3cm90ZToNCj4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBIYWpkYSwgQW5kcnplaiA8YW5kcnpl
ai5oYWpkYUBpbnRlbC5jb20+DQo+PiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDI2LCAyMDIzIDg6
MTQgQU0NCj4+IFRvOiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBDYXZpdHQsIEpvbmF0aGFuIDxqb25hdGhhbi5jYXZpdHRAaW50
ZWwuY29tPjsgSGFqZGEsIEFuZHJ6ZWogPGFuZHJ6ZWouaGFqZGFAaW50ZWwuY29tPjsgQXVsZCwg
TWF0dGhldyA8bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4+IFN1YmplY3Q6IFtQQVRDSCB2NyAw
LzJdIGRybS9pOTE1OiBIdWdlcGFnZSBtYW5hZ2VyIGFuZCB0ZXN0IGZvciBNVEwNCj4+PiBUaGlz
IHBhdGNoc2V0IHBhdGNoZXMgc2VudCBieSBKb25hdGhhbiBhbmQgQW5kaSwgd2l0aA0KPj4+IGFk
ZHJlc3NlZCBDSSBmYWlsdXJlczoNCj4+PiAxLiBGaXhlZCBjaGVja2luZyBhbGlnbm1lbnQgb2Yg
NjRLIHBhZ2VzIG9uIGJvdGggUHJlLUdlbjEyIGFuZCBHZW4xMi4NCj4+PiAyLiBGaXhlZCBzdGFy
dCBhbGlnbm1lbnQgb2YgMk0gcGFnZXMuDQo+Pj4NCj4+PiBSZWdhcmRzDQo+Pj4gQW5kcnplag0K
Pj4+DQo+Pj4gSm9uYXRoYW4gQ2F2aXR0ICgyKToNCj4+PiAgIGRybS9pOTE1OiBNaWdyYXRlIHBs
YXRmb3JtLWRlcGVuZGVudCBtb2NrIGh1Z2VwYWdlIHNlbGZ0ZXN0cyB0byBsaXZlDQo+Pj4gICBk
cm0vaTkxNTogVXNlIGNvcnJlY3QgaHVnZSBwYWdlIG1hbmFnZXIgZm9yIE1UTA0KPj4+DQo+Pj4g
Li4uL2dwdS9kcm0vaTkxNS9nZW0vc2VsZnRlc3RzL2h1Z2VfcGFnZXMuYyAgIHwgODggKysrKysr
KysrKysrKysrLS0tLQ0KPj4+IGRyaXZlcnMvZ3B1L2RybS9pOTE1L2d0L2dlbjhfcHBndHQuYyAg
ICAgICAgICB8ICAzICstDQo+Pj4gMiBmaWxlcyBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCAy
MCBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IENjOiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+Pj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4+PiBDYzogSm9uYXRo
YW4gQ2F2aXR0IDxqb25hdGhhbi5jYXZpdHRAaW50ZWwuY29tPg0KPj4+IENjOiBBbmRyemVqIEhh
amRhIDxhbmRyemVqLmhhamRhQGludGVsLmNvbT4NCj4+PiBDYzogTWF0dGhldyBBdWxkIDxtYXR0
aGV3LmF1bGRAaW50ZWwuY29tPg0KPj4+IC0tIA0KPj4+IDIuMzkuMg0KPj4+DQo+Pj4gLS0tDQo+
Pj4gSm9uYXRoYW4gQ2F2aXR0ICgyKToNCj4+PiAgICAgICBkcm0vaTkxNTogTWlncmF0ZSBwbGF0
Zm9ybS1kZXBlbmRlbnQgbW9jayBodWdlcGFnZSBzZWxmdGVzdHMgdG8gbGl2ZQ0KPj4+ICAgICAg
IGRybS9pOTE1OiBVc2UgY29ycmVjdCBodWdlIHBhZ2UgbWFuYWdlciBmb3IgTVRMDQo+Pj4NCj4+
PiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vc2VsZnRlc3RzL2h1Z2VfcGFnZXMuYyB8IDEwNSAr
KysrKysrKysrKysrKysrKystLS0tLS0NCj4+PiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9ndC9nZW44
X3BwZ3R0LmMgICAgICAgICAgICB8ICAgMyArLQ0KPj4+IDIgZmlsZXMgY2hhbmdlZCwgODIgaW5z
ZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pDQo+Pj4gLS0tDQo+Pj4gYmFzZS1jb21taXQ6IDRk
MDA2NmExYzA3NjNkNTBiNmZiMDE3ZTI3ZDEyYjA4MWNlMjFiNTcNCj4+PiBjaGFuZ2UtaWQ6IDIw
MjMwNDI1LWh1Z2VwYWdlLW1pZ3JhdGUtMTg2OWFhZjMxYTZkDQo+Pj4NCj4+PiBCZXN0IHJlZ2Fy
ZHMsDQo+Pj4gLS0gDQo+Pj4gQW5kcnplaiBIYWpkYSA8YW5kcnplai5oYWpkYUBpbnRlbC5jb20+
DQo+Pg0KPj4gSnVzdCByZXZpZXdlZCB0aGUgY2hhbmdlcyBwcm9wZXIuICBJdCdzIGJlZW4gYSB3
aGlsZSwgc28gSSBkb24ndCByZW1lbWJlciBldmVyeXRoaW5nDQo+PiBhYm91dCB0aGUgcHJpb3Ig
dmVyc2lvbiwgYnV0IEkgdGhpbmsgSSByZWNvZ25pemVkIHdoYXQgd2FzIGNoYW5nZWQ6DQo+Pg0K
Pj4gLSBJIHdhc24ndCBhd2FyZSBhIDIxIGJpdCBhbGlnbm1lbnQgd2FzIHJlcXVpcmVkIGZvciAy
TSBwYWdlIHNpemVzLiAgSSdtIGdsYWQgeW91IGNhdWdodCB0aGF0Lg0KPj4gLSBUaGUgZXh0cmEg
ZGVidWdnaW5nL2Vycm9yIGluZm9ybWF0aW9uIHdpbGwgYmUgaGVscGZ1bCBpbiB0aGUgY2FzZSBv
ZiBhIGZhaWx1cmUuDQo+PiAtIEdyYWJiaW5nIHRoZSBwZXItY29udGV4dCBWTSBpbnN0ZWFkIG9m
IHRoZSBwcGd0dCB2bSBzb3VuZHMgZ29vZCB0byBtZS4NCj4+DQo+PiBFdmVyeXRoaW5nIGhlcmUg
bG9va3MgYW1lbmFibGUuDQo+PiBBY2tlZC1ieTogSm9uYXRoYW4gQ2F2aXR0IDxqb25hdGhhbi5j
YXZpdHRAaW50ZWwuY29tPg0KPj4gVGhvdWdoLCBnaXZlbiBJJ20gYWxzbyBvbmUgb2YgdGhlIHNp
Z25lZC1vZmYtYnlzLCBJIGRvbid0IGtub3cgaWYgbWUgYWNraW5nIGl0IGlzIGV4YWN0bHkgYWJv
dmUtYm9hcmQuDQo+PiAtSm9uYXRoYW4gQ2F2aXR0DQo+DQo+VGhhbmtzIGZvciBsb29raW5nIGF0
IGl0LiBDSSBzcG90dGVkIGFub3RoZXIgaXNzdWU6IDJNIHBhZ2VzIGFyZSANCj5wcmVmZXJyZWQg
b3ZlciBvbGQtNjRLLCBpZiBmb3JtZXIgYXJlIGF2YWlsYWJsZS4NCj5GaXhlZCB2ZXJzaW9uIHNl
bnQuDQo+UmVnYXJkaW5nIHRhZ3MsIEkndmUga2VwdCB5b3VyIGF1dGhvcnNoaXAsIHMtby1iLCBh
bmQgYWRkZWQgbXkgDQo+Q28tZGV2ZWxvcGVkLCBpZiBpdCBpcyBPSyB0byB5b3UgSSB3aWxsIGtl
ZXAgaXQgdGhpcyB3YXkuDQo+SWYgeW91IHByZWZlciBvdGhlcndpc2UgbGV0IG1lIGtub3cuDQoN
ClRoYXQgaXMgZW50aXJlbHkgYWNjZXB0YWJsZSEgIFRoYW5rIHlvdSBmb3IgeW91ciB0aW1lLg0K
LUpvbmF0aGFuIENhdml0dA0KDQo+DQo+UmVnYXJkcw0KPkFuZHJ6ZWoNCj4NCj4+DQo+DQo+DQo=
