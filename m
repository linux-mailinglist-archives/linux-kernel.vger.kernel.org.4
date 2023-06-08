Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80233727646
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjFHEoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjFHEoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:44:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ECF26BF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686199454; x=1717735454;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uJG3eTt0JuHv7zXtogVQuSguc7eZkGvYbWxX+0ig0h4=;
  b=k6gClHed6MPGpvLHXfbOcBcPNX8HJ72S4Jl/VtGPNn35d2yatQqXWJLX
   uQQkX5MdvdcTbjaJ4nkxSqgOK4ulA/C4bh5B7QtStX5Wn65n6xFOZvXgt
   IienFCrH+v99alS5E0CzCK4EdXBEquqxKsaoiZsBHX5PvnzKE2ckJj5ss
   xXPzta7DV2m0GxRe74lkkLUdTZSa8IastAgHBOKafKNt4HgZaoo649b4z
   X8mwfw5vnhVvpZgceJsxnhwGtK6UifbX4OvVXsnOjeuOx+Ni9nZhr6cRt
   meDr3PEBJ+/rJOgqTU+lQ3yXEtR3Rs4OfdXieRfQyPH7lTUdFoLL4BQ1l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="359670846"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="359670846"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 21:41:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956574120"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956574120"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jun 2023 21:41:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 21:41:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 21:41:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 21:41:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 21:41:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POubXyW5xcn3Nfo3sNBSNOpCsOqGXI6LbvSnnhDaJi6gmsRNxFTNeECQeVOaJKUpPj4CbCnwyD/9+akws920DZIQTyNfD+prTclJE1TicCEV1Up9nVj44lJODBeIO0QGj4wwqHOXvyND/bQkvMXZtzNUQGmm7eYTj+E++loK00W/6Riq3TYDxqcN1SF1LnTaaXjTSfUqGN0zQeF4JgQ3IvLZD00yJozo/1azeOm9JXgx1zu14g4aJdwPeGd3T5cvhHRY4T3lK00ZzTtEvEspjP1Cy5vPe22GHgV3SvS8Shya7RZPUrGlbak2CMpeSSCJ9zWvZB2+MeGhUqkoFScByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJG3eTt0JuHv7zXtogVQuSguc7eZkGvYbWxX+0ig0h4=;
 b=Rkg2k/kWPf3w82yUcmyPmSRvUF75JTZXjJ74RkiYrZ3pOibjVTsR6KRJKNw9tWtEATBBAtRNnoDBjIT36532sLVSG2p0VzkNU1NnkW7YFwAtyMIEUF8aHhifLq6GcLRxwh35O+YJueHIMEGfVP2YjbodGa4XLfTSRhucxQXaPNKH88nTAXfLeVU2xWk6mb8zDpbqtgIY0DDJ0Fo8VUsuXKKMyRdd/Jx2o4Jy9dvuY8hykPabeh5zHYjpZg5sbo4Je72M0kJP01wnBX79rE8vHaARQA1XnWmJSCta9p4m1KBnly7SJqCBp/apbMJH+IxfZ4RUfKcKp89E7eYwV3myZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN7PR11MB6703.namprd11.prod.outlook.com (2603:10b6:806:268::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 04:41:38 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 04:41:38 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Wilk, Konrad" <konrad.wilk@oracle.com>
Subject: Re: [PATCH] x86/kexec: Add a comment to relocate_kernel() for better
 readability
Thread-Topic: [PATCH] x86/kexec: Add a comment to relocate_kernel() for better
 readability
Thread-Index: AQHZmSxwVbvprrp+B0KPOXpdXFKc9a9/MaKAgAEjB4A=
Date:   Thu, 8 Jun 2023 04:41:37 +0000
Message-ID: <538335b164bf8b84b8a55c5654ed15d849479388.camel@intel.com>
References: <20230607103910.407779-1-kai.huang@intel.com>
         <20230607111957.sppocwpkhfb2e2vf@box.shutemov.name>
In-Reply-To: <20230607111957.sppocwpkhfb2e2vf@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 (3.48.2-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SN7PR11MB6703:EE_
x-ms-office365-filtering-correlation-id: ad5be917-7303-4d88-614e-08db67daa54b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wT7avMwBjFr1StU1QzRTk+wHhYzOZdR97S9BQnk23q8OjdNVdiIRTbjzlH7bHC08xM/9x8oMzNY3wpWg6nSfD53Jo5jc560k630Q1FsE4s93ov4GGo+7IyDWnLyxlFx2y4sZw0Xld9ubH+XUmuLFqHL4HG1QL17of0jzwxIb5Kl2AeI8oqvopVSjcREsvQP6Ji3VPKlr+jtMty++q1lgwP/I2r8IkdLUPHvRJjh3NRCDiehYEUo8LA0xU0pIjU/xrPl0S39xaMJ8VEkPH8eYmYMbmJTTznZtYWNLaKqVE8bae/Hip5LebZg6h0woGffVAttFFcWKiCDmOnVU2X0uPpzMJDDmcFs4zA+pSuEX+n/X+IfO905FeQaiToqZPo3FmB2DrSpXlwcBGXzLOFLxRvIrUECsa2KeWN8z074USQnIzvO18DTs4VlKiria4JSwq1/2+sIncngf4OGNmQODQlb6nuhIvOGZlDT25y4mnhx2tlq4G+Qk6Vqig9joMKhj1svEh51uqt//ybHT+mSwUsywyWL7JoH2ESo02ayEYFW8PxOZZEOHvXACx6glHbC5wIM1aVqLR55dj0GKVWZ3r2+Z1IgmTZ+QB29G0O+P8pUjYVPwCAPiFE0eSqaR5PUE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(76116006)(2616005)(26005)(66446008)(6506007)(6512007)(6916009)(316002)(64756008)(4326008)(66556008)(91956017)(122000001)(66476007)(66946007)(6486002)(186003)(478600001)(71200400001)(36756003)(54906003)(38070700005)(2906002)(5660300002)(8676002)(8936002)(82960400001)(86362001)(41300700001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUpsVUZveVIzYlNhMkV1SjRCejJkQnZCckt3MG93aFpNeVVTTVdLUG5ldUJa?=
 =?utf-8?B?Y080bDNwRGNWUGEyNnFZNzdod2VvbFo4dVpHWWhmZ1M0Z3NuQy9iV0RYTTZu?=
 =?utf-8?B?OCsvK0dybXhMMmRjM0lxbzAzTGk0TzlQY0crczFpQ2IvZW5uSHRmVEhQSzlo?=
 =?utf-8?B?RU01YUs5K0N2ZzE0ZjJPZFlWU0NNT1FybmxxWnJrdUFHZjUyWXh6SVdBajU2?=
 =?utf-8?B?UjJDcVVlWXp6dWZzUmZNSGY3TXhBN3N5SEpIU0xwMThvYnlJbnpBYk93ajdR?=
 =?utf-8?B?L09rZjlTbU1jZ1J5VTJJT3RsVjMyaEk1UDk4TzltbFhZNEw2cUhHVUpsRGxa?=
 =?utf-8?B?Z3VadllxM1FUR3g1N010cUExSzVFSnhZWHhPck9qdWhBUGpOdVVBOGpPWDI1?=
 =?utf-8?B?R21wc3dLa0NxYURCYThtNENKQ1ZVZ1ROdnRBUXNtK3hhbk45Q1g5V1I0QUZ6?=
 =?utf-8?B?L2p4K1ZNM3RvL2hTNmt6NXdiRm51SlVjRGdEeFRsbStkamwwWEwrck4vWTZE?=
 =?utf-8?B?ZTFCTERlSFlWU25aVVNxaURBcDcrS3VnL3dPSDlRQ3hFWmc1cjViVTJsYXdz?=
 =?utf-8?B?am8zbXFLNWt5YmRlaHgxUTBnblFhYnpPNXlIRmhqdGFhcEZSOSs4RFNHVUw1?=
 =?utf-8?B?Y1NiL3VHS2FNaVNDS3BnWFN4K3FwTU0xY3dJV0Nvd1NMMVZNQWx1MEVkVnk4?=
 =?utf-8?B?UWYyUnYyRzI2T01lNDE3VU1maVQyYlU2Y21CZTc0ek1SRnJDN0xwaTBqYTFL?=
 =?utf-8?B?ck5wYXlBK2JkeGF2enYwcmFvQTNLNEw2R2pGeUwzSmhFMHJtaStjRHFhelF2?=
 =?utf-8?B?VkVhZHBGdUdaVFpCVHRkbHdKajBRa3BpUkdUUEVOMFpSeW5XTjNWUDQyNERa?=
 =?utf-8?B?dCtSOGNsK3R6RUNqMnhPVHB1d1NabnQzaVAySFliTXN2MkxrcXFNRDdxb1c0?=
 =?utf-8?B?MVNEdGcyc3JoQ3cwbWRoQUNobDRBaDJnQ3NFcWRiS2NqbVJjZFBPK0c4L0o0?=
 =?utf-8?B?MC9tbW85S2YvK2k3MTd3aEZCdjREYVpGMk4rTFhkMUdNVk9uOUZSNkJMQnh6?=
 =?utf-8?B?Y2xlRExQT2hORjJjUFVLdUpUZ0FiZ3FENGNSTzBzMmlobEpvQlhjbGYvZmsw?=
 =?utf-8?B?OVdGZ2VZNGxGMEdqa2VpOUc4WGcvWTdSeGtYd0NQNFJSZno5UkwyV1M1MGZT?=
 =?utf-8?B?ck9JdCtUeHd1NlZtMGVIUmIrT0p4SjJWUjl6SlNjM0k3VzExZDB6NEIvY3A2?=
 =?utf-8?B?N1R1TFpiajJkNHdRS1liVzFybVRiSGdIM1dWbTZhUkZsRmREN3R6MTRTQW1L?=
 =?utf-8?B?WnBoT1ZIalN0cHlwaHBvQk4vajNvU0xkTDkycUY3SWlZSi9GcERPb3JtRFNm?=
 =?utf-8?B?ZTRXY1R5NFgreXpWV25HSFFadjI0MENzSnZnMk54akZsSGxlMHNjRmw1YjJW?=
 =?utf-8?B?VFJ4R0hBUklyNlJuOEljMDRyY3VhbFlGV1RnalZqMGVENS8wVzRKUHpNSlZt?=
 =?utf-8?B?OGY0eUhEWGg0NEpHME9ibnN3ZHhrODBxRGtXb0JSVDNWeXdyenZVdmRLbzB1?=
 =?utf-8?B?SnpYcHpsV1NFZ0g5aHZxQXJveGg1VG4vcnhZcGZZRzVqNGU3YlhsaEhJSkVL?=
 =?utf-8?B?VHRlZEFJRTgrMjgvY3FVbWttK0ZveXhCbUIrMzB3MHNZM2g0VFhnWUJYSkNK?=
 =?utf-8?B?T2F1SWNQOHlaSnNIaFJkZ0Rmcnl0QS8rUEFWeFRSTWN1RWMvbmRBd0dpZWp4?=
 =?utf-8?B?czlPQkdJTDJOMlA0eVk1NVpLQkR2dy9hcXRzK01GYzVhc2xnU0dDZlg5MDNS?=
 =?utf-8?B?MmtMR1E1NTh3c3pCRzFyRTVhc0tQZTBlcHN1U0tMaDRPYVhSd0srckVPZTgy?=
 =?utf-8?B?VkNMNDhiOEJ0dElkMjZ4c2hsbUNMZTZqa2NYNGc1UUFYU29lY3JqQkkxYklH?=
 =?utf-8?B?cnBhd1ZWMTZ0cVN3aHU5Q1FIdEViZ2ZzMXlva3h0eDF0dkJEUi9WR29zQTFz?=
 =?utf-8?B?Y2hMZGFGR3BNYVdYRllaS0FQWXRBSEZzU0MzMEx1cVRGdHMwV1c2MEg0MVVT?=
 =?utf-8?B?c200L2JDSjdmQkJuUEdkM1FkMFRKbU1ySng0N1NpWHJBeHJmNmdtZkZMVm5n?=
 =?utf-8?B?Z1pSdlJSTlJnUmZFaW5iOEZLOUw1YTZaSGNSNklDRTViOEh3OWM2VHlFaEhH?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5D69D6439F42840A6D435FDD003CCA0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5be917-7303-4d88-614e-08db67daa54b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 04:41:37.6288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YGmA19bWbyhBY5dsElQ3G91P4K2M61NSYXPj8oPnD0VePzJNXyL5+A81NAZCUUyzXY+MsB37U6/g2tUW7INPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6703
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTA3IGF0IDE0OjE5ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBXZWQsIEp1biAwNywgMjAyMyBhdCAxMDozOToxMFBNICsx
MjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gVGhlIHJlYXNvbiB0byBzYXZlICVyY3ggdG8gJXIx
MSBiZWZvcmUgY2FsbGluZyBzd2FwX3BhZ2VzIGlzbid0IHRoYXQNCj4gPiBvYnZpb3VzIHcvbyBs
b29raW5nIGludG8gdGhlIHN3YXBfcGFnZXMgaXRzZWxmLiAgQWRkIGEgY29tbWVudCB0bw0KPiA+
IGltcHJvdmUgdGhlIHJlYWRhYmlsaXR5Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEthaSBI
dWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC94ODYva2VybmVs
L3JlbG9jYXRlX2tlcm5lbF82NC5TIHwgNCArKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3JlbG9j
YXRlX2tlcm5lbF82NC5TIGIvYXJjaC94ODYva2VybmVsL3JlbG9jYXRlX2tlcm5lbF82NC5TDQo+
ID4gaW5kZXggNTZjYWIxYmIyNWY1Li45N2RlYWUzYzVlNmMgMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC94ODYva2VybmVsL3JlbG9jYXRlX2tlcm5lbF82NC5TDQo+ID4gKysrIGIvYXJjaC94ODYva2Vy
bmVsL3JlbG9jYXRlX2tlcm5lbF82NC5TDQo+ID4gQEAgLTE2OSw2ICsxNjksMTAgQEAgU1lNX0NP
REVfU1RBUlRfTE9DQUxfTk9BTElHTihpZGVudGl0eV9tYXBwZWQpDQo+ID4gIAl3YmludmQNCj4g
PiAgMToNCj4gPiAgDQo+ID4gKwkvKg0KPiA+ICsJICogU2F2ZSB0aGUgcHJlc2VydmVfY29udGV4
dCB0byAlcjExIGFzDQo+ID4gKwkgKiBzd2FwX3BhZ2VzIGNsb2JiZXJzICVyY3guDQo+ID4gKwkg
Ki8NCj4gDQo+IExpbmUgc3BsaXQgaXMgbm90IG5lZWRlZC4gSXQgZml0cyBuaWNlbHkgdW5kZXIg
ODAtY2hhcmFjdGVycy4NCj4gDQo+ICsJLyogU2F2ZSB0aGUgcHJlc2VydmVfY29udGV4dCB0byAl
cjExIGFzIHN3YXBfcGFnZXMgY2xvYmJlcnMgJXJjeC4gKi8NCj4gDQo+IE90aGVyd2lzZSwgTEdU
TS4NCg0KU3VyZS4gIFdpbGwgZG8uDQoNCldpdGggYWJvdmUgY2hhbmdlLCBtYXkgSSBhZGQgeW91
ciBBY2tlZC1ieSA/IDopDQoNCj4gDQo+ID4gIAltb3ZxCSVyY3gsICVyMTENCj4gPiAgCWNhbGwJ
c3dhcF9wYWdlcw0KPiA+ICANCj4gPiANCj4gPiBiYXNlLWNvbW1pdDogNDA5YmYyODk1ZDcxYmI2
OGJjNWI4NTg5MDM2ZTVlZDFjYTMwYmFkYQ0KPiA+IC0tIA0KPiA+IDIuNDAuMQ0KPiA+IA0KPiAN
Cg0K
