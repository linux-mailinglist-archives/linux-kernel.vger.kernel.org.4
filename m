Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6589D611733
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJ1QPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiJ1QON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:14:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E421F9A0B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666973491; x=1698509491;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G7TzxHDkkC0/p9kcWSKvreY7tENyolQQranNaotCgPE=;
  b=crZh3p6JldfYO/Fssi278mPxLSfgDcDpq5G61nmAdEpXOqNtkjpXZZXH
   y1Ht9mHmx4R11kX87/VVg9lTlMjb06jLuEfNLMc1bUphE272BQ9mI2dKx
   O30lwtrIYmE13dSIMiNAoaBjQhPXf55emQCRl0dvDkCZQH6HNDJFUGku/
   QDtUDFe7x98XLxxm/AUJwy1Om61ES9kmnISI15U3xo5hdBx2pd3Mllg9v
   9xLnwJRvWDVo20PqlDZ1/XgyKFwz4kGTvtlZ3jYl9u/EX7er3c8xr9h3F
   QP8oIqvhADPQ8jZ5s/V816D9l6gQLf915djaENr0pJpIVUvMCukq8UshV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="335170964"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="335170964"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 09:09:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="610789995"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="610789995"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 28 Oct 2022 09:09:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 09:09:16 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 09:09:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 28 Oct 2022 09:09:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 28 Oct 2022 09:09:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsTyudCgYqPk/4gR0dSL+4OpuT5MJRpfgrpY54gQQFUXqVoGhJxy4RLf/dlWPvuaec1DmY/Ty5ieNUCw3mvECPSY66EGVKCGprD0JMiRPONe6+oN3hJPkyW4noGqKbNuNH1u8B9VPbOxae9dLjsd+VhYbMwO8szmdCBOhh9pg36aZX8vFPt5SOq5klDKJ/tnGGmHeJ4H1oTQK+a77NC389fm8qp09YOzL/JupP3/BzbeajeJsDlmS2BRL+FbPK37y9Hk/bfHNgSvloFDtOtouLfq8iIm1/t3ELn4q7oeNfD+RYlOBSjzkSbjrAxHeBR0HsCvRYH1zh1W8B6UkD4qbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7TzxHDkkC0/p9kcWSKvreY7tENyolQQranNaotCgPE=;
 b=EjdWwGrF2FEzGSbed/Gr606/Hu7TdMC6bfTE4K6Ugwb13HJy0qxN/HPVTwHp32ICRRTBIBy5m1Y5eMQq+DD2WuDNQKgJwK7hquMgawHwo8t/KR88VX13AKPet7BW479Qbk82s5jsEKT6F+Lcrfju5mABZF/FvGzOqtv4Rfs63EUCwcBosBBqZScCTSLqxRRt5Za1EXlqsgb7GYIOtnLZ0fCCJLPOPtRD81gvdPuw1CbMFmr1Tx0uvaPU+a1qIrAnensKv1ksaO5Y65SKVb49Wh+Hn2OPJwcSsasRnpHoY1GioDNCab9WTjQRR0yntV5jfLDhVNBlYOx4crimDgASZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM8PR11MB5607.namprd11.prod.outlook.com (2603:10b6:8:28::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 16:09:08 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::51de:f739:3681:b16f]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::51de:f739:3681:b16f%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 16:09:08 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Alexander Potapenko <glider@google.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH v3 1/2] mm, hwpoison: Try to recover from copy-on write
 faults
Thread-Topic: [PATCH v3 1/2] mm, hwpoison: Try to recover from copy-on write
 faults
Thread-Index: AQHY5Yfrj79SVZklFESlsFuABIc4ja4jGjiAgADoTMA=
Date:   Fri, 28 Oct 2022 16:09:08 +0000
Message-ID: <SJ1PR11MB6083F63D86CDF7810F5ACDA3FC329@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221019170835.155381-1-tony.luck@intel.com>
 <20221021200120.175753-1-tony.luck@intel.com>
 <20221021200120.175753-2-tony.luck@intel.com>
 <a60484bf-2107-8bc4-acdc-5f582f9637af@huawei.com>
In-Reply-To: <a60484bf-2107-8bc4-acdc-5f582f9637af@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM8PR11MB5607:EE_
x-ms-office365-filtering-correlation-id: c084df3f-41c7-4f53-df03-08dab8febe9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L9b04eEevKWdHEgrLkYANNWcTrL9pipQMr/ueB7JtnUjJYghimHRkn4c3LbcrVN7etQD4xHOcheee4xHFM1IGvhiZrRUOuSIMNH9tGsjCNCGACPibuQ7vMzE/sJVkA0YUEMhXbvHssbnnxSvFeHnfM4rYVwIYj66k+qU7pKu7wviGvgiCp6u6cAgWWhs2nJM2AzsRC8eUpDfqhEnscInMSFGmQCJNisj72WHtGy4+17dqIni91PjHb3KPMdyw1FpTnub/QhKttvYg6FJczjnfgwzw3HDFt9z1Zfnh5yYH48IE+CLOmql58DcQZ5PXj4k/ieQYIj9VK+Da4MJCG3bXxDzHXGzBskQoRv99IGMYmSjSou8Nog5CAFT5jSHwwtRfTuLPAFuozOqhDm50ZWWU5ZrD4bHhaFpJN5smm0QAjLMkSXW5zCVzdH6UcZxdjJJG9OIpmKAREfHbjMwaB2d4NieoqtudhDoSvrHD3t7tani7+HAqZteuJz0Dtv2eHQHVwNwZWmCFefkkRq3RPT0j9vKpTAsxOefcWcCqUKAodDHT2MDvQ6oSkrBDWMbQBCWcosvcZJvVC5LzDUB4L9xcKrtbAxCSwQ35vp/F4PXNx/rgvs77LXHYPMptW6ZeVgQl9vW3FzlDVBJGt5/Dl3YMW/025oUrdsOK/6tM5Y0cFSVgC1u1YpNx0yGmc9ra8qUztjMTRkIclF+8/SAkDPtDhyISF8j8gy9yro5X6CYWBXQNyikix2/H7rtSNltXuEIT9QDexZNWsIZ35c7Jyu8Dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199015)(7416002)(4744005)(5660300002)(8676002)(54906003)(2906002)(64756008)(122000001)(9686003)(7696005)(6506007)(41300700001)(52536014)(8936002)(55016003)(66446008)(38100700002)(66476007)(71200400001)(316002)(66556008)(66946007)(38070700005)(33656002)(186003)(76116006)(26005)(4326008)(82960400001)(478600001)(110136005)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUVQOU42UW9GTkpCMnhENjlQT0R6SzUzMzJ4NUJ1TU9tRjE1OVlVYnY0NVVs?=
 =?utf-8?B?c2E3OE5BQ0VZT1NDMi8zekEyZFdHQjhqR3dGNGhjYi8rb0pjbDZINDZUMFQr?=
 =?utf-8?B?dGlCcE4veHdLU2VQeGowQmNvdkthdFI3cUcvNlJ6UDllYmV1TWF6ZGFKL0h4?=
 =?utf-8?B?dzV1bmN4VlVuYTdEUlVYT09abG9NVllJdkJTNWxDK3pFdk43NlFNZUVzUFlV?=
 =?utf-8?B?Tmt0TFpqUms5N25Fd29mbW1vYW1MMzRpOGcxOXgveFhKam9iT2x1aFVaQVdm?=
 =?utf-8?B?WHdQWUh2ZFJJeHFuMjgrZENEWHVkZXNSR0I3eEJhMFJoOHFpekdndlo0VXkz?=
 =?utf-8?B?aUlKcFJHaVZlOE1waXlpek5mVnRCVkg4VkFUVXhBREtQVTVKUE5hd2tHdVNp?=
 =?utf-8?B?MFUzOFFoU3QvVktqM0pjNlpTWUExUVJYWmpvM052UzZabWRqazBZWEczZlda?=
 =?utf-8?B?UE84Z0RKN2puK1FaQmNlRzVIaHhMb3hrN2VmejJHUlZPVGJiQjlPeTJNNHpu?=
 =?utf-8?B?cG4xQXhjMnQxSHgxU3FtWTJmQ09EZVp5V3RCSitCWVI5SEZnVHRocjFTelYw?=
 =?utf-8?B?UEt3WExSYmYxU3NoRFhFbE9aRGVuZWNLb0ZKQWFjOG1QWld5cGw1WC92T3gy?=
 =?utf-8?B?TGxLb0lLRTVmcmJzUnNrUVJrOXo5U0RTL2NXbHdhajBVSk9hL0pFOGlaRE1y?=
 =?utf-8?B?aEh6WE93d242UXpmdlJoUkxwVnFoWStwNHA1YnMrMFdHMW5TVlRpV1pvMmhl?=
 =?utf-8?B?dk9yWEx0aG5OZDB5Zk9JNnVaYWFjeUhVR2huZ2RPdTZrZ2JWNFRCOEp2N0h1?=
 =?utf-8?B?bUtaVTlNMDRaOWJZWkhBeWovSGx4S0F4MC9BdE5QUUFiMUJJazZvakFpSElZ?=
 =?utf-8?B?NG9jR3JsVGovS2tBeVorclcxaUs2VXdXbGxyT01TcDVqbEtNdG1iMGdmaVd0?=
 =?utf-8?B?TUhDWEhzL0hlbCtDeUo0VFlTRWZTSkQzNU54QnBOUDV4cU00SU9IbFNEaHk2?=
 =?utf-8?B?ZmtnWTd5ZVdjL2Jzblk1ajh1eDhCc0l3aERIejZ0cllPdjZMaC8xME5HNUd0?=
 =?utf-8?B?ZE05eTRaK2xZc2Y1L2pMZGxxTitubEpUVDFkVVVZam0xK1Q3S284MWwrNFVz?=
 =?utf-8?B?aDJLNnRNWXNnN2l0aFhuVUtUd2d5a0VKMVZJWTlyMW9lWVh2UW0ybUJZWlFJ?=
 =?utf-8?B?dXovbk5yYW9PZU9Cd0FBSmQzOXhBVW1sMlBDOVVFLytlalpHcnpkdDBzWTBE?=
 =?utf-8?B?U0JsWDY4WGhKVURxN2J5dTVCeElJU1hDalJGaCttVktsN2cweFlFOXRhSGVR?=
 =?utf-8?B?Mk9FKzFnc1ErWUVwYnBmaXFBOU04ZTBEMUN3NStDcERXRmxaSUZrQXFmMDd5?=
 =?utf-8?B?di9FNlFUc0JwSng5ZmJtK0NuK3ozUFEvaTZqWmZ0bWM2Y2IzQ3hIYU5hU25p?=
 =?utf-8?B?SUdKbXBlMmg3ZXZqQm9ScGlDV3o5S0diU2dIYzFUMys1STZMdzlUSkpKbC9v?=
 =?utf-8?B?bTNOempmYnhQSGtBNVUrZzgvY3JNQ1VWT2VnQWlUR3ZPOEtqL0lyTSttWE5I?=
 =?utf-8?B?NG9Nb1pvZ2QxVjBJRmh0WGJiUDQzM3hXUjZrNjZaVW5WeDlYVmZXQmdIQVdO?=
 =?utf-8?B?RjBGckZqN1Q4cGJhWkYrT0RrNlFMeXo3UmlDakpLeTlDcFJRdzV5VUJSdytF?=
 =?utf-8?B?VlJ5WWRpN3B3aTFCM0gzcUFTS1BYM05vUXRtSzFpKzh5MWQxKzlEbEp0ajhF?=
 =?utf-8?B?dEsvODF2WFAreU0xYTB1VG1mbC9VL2VFV2JXbHQrRUo4OEFKc25YaHpZRDJP?=
 =?utf-8?B?bkxxblAzYW40WGZYODNEdTl2WkwvajlpUzJva0dUMlRTRVR5anVjcU9vRnk3?=
 =?utf-8?B?WG5tRXFwOTU3VjhtQVBBek5GZ1NSeGc1UzBDbW1yd2wva0tzMmdpSkhtUGFy?=
 =?utf-8?B?cXZjSlhPSkRqV3FqMXM1Umt3cUpRSmxVUmhYU2F5dHd0dm5IUU9mbS9VRmF1?=
 =?utf-8?B?dFlFYzBVT1M2Q1VxdEZCSHFzcmFPbGp2R2tGRmxJaHBSL1VQQUJVZEJraEMz?=
 =?utf-8?B?TDMreGxlQlVsTFJlS0pFNUVSVVNyNDROY29idGtwUllLY1ZpZU9XbUJINmZl?=
 =?utf-8?Q?+vEDao+WZQmxtDPbR+bJD6geH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c084df3f-41c7-4f53-df03-08dab8febe9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 16:09:08.5058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qeaoSYRXEtEEM2eAcwVtcEN3qt+klyS9x8SN0w5CRXI37liU8HmMZzUJEl0PoCLaG3G7FgWSRS3Oyvk1d3M0eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5607
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gKwl2ZnJvbSA9IGttYXBfbG9jYWxfcGFnZShmcm9tKTsNCj4+ICsJdnRvID0ga21hcF9sb2Nh
bF9wYWdlKHRvKTsNCj4+ICsJcmV0ID0gY29weV9tY190b19rZXJuZWwodnRvLCB2ZnJvbSwgUEFH
RV9TSVpFKTsNCj4NCj4gSW4gY29weV91c2VyX2hpZ2hwYWdlKCksIGttc2FuX3VucG9pc29uX21l
bW9yeShwYWdlX2FkZHJlc3ModG8pLCBQQUdFX1NJWkUpIGlzIGRvbmUgYWZ0ZXIgdGhlIGNvcHkg
d2hlbg0KPiBfX0hBVkVfQVJDSF9DT1BZX1VTRVJfSElHSFBBR0UgaXNuJ3QgZGVmaW5lZC4gRG8g
d2UgbmVlZCB0byBkbyBzb21ldGhpbmcgc2ltaWxhciBoZXJlPyBCdXQgSSdtIG5vdCBmYW1pbGlh
cg0KPiB3aXRoIGttc2FuLCBzbyBJIGNhbiBlYXN5IGJlIHdyb25nLg0KDQpJdCBsb29rcyBsaWtl
IHRoYXQga21zYW5fdW5wb2lzb25fbWVtb3J5KCkgY2FsbCB3YXMgYWRkZWQgcmVjZW50bHksIGFm
dGVyIEkgY29waWVkDQpjb3B5X3VzZXJfaGlnaHBhZ2UoKSB0byBjcmVhdGUgY29weV9tY191c2Vy
X2hpZ2hwYWdlKCkuIEknbSBub3QgZmFtaWxpYXIgd2l0aA0Ka21zYW4gZWl0aGVyLiBBZGRpbmcg
QWxleGFuZGVyIHRvIHRoaXMgdGhyZWFkIHNpbmNlIHRoZXkgYWRkZWQgdGhhdCBjb2RlLg0KDQo+
IEFueXdheSwgdGhpcyBwYXRjaCBsb29rcyBnb29kIHRvIG1lLiBUaGFua3MuDQo+DQo+IFJldmll
d2VkLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCg0KVGhhbmtzIGZvciB0
aGUgcmV2aWV3Lg0KDQotVG9ueQ0K
