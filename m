Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D785FBDC3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJKWTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJKWTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:19:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E743A804B4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665526754; x=1697062754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WA5WD2MfkX++wFNoyUBKdFbY+4Qm0ZZa0Wjy3DXsGqI=;
  b=CyuC+74D9/JXyY+399/ad6gNLKPzA0B036FnaNJP+vRbchSbqxqrX+IR
   vEAyxrh1NU15efF8VS97csnVVf8rKnMvI6MQzD9gtC3pe9kkYbFzGPL2b
   rBoHbpuyUpUBrDcHM11HjmPVUzxSZbACeFtJU5ykGA6DkquVzAvI5RTFF
   3Rkvx3SSJSG+VpDHGxUFgmTkUCI+tQiZRWfYojMiq6CnQV++IDTCw5aKQ
   cxSf37xqTL80dtiNiGmDHhCuZJPYjb2RrwNAQ5aYULRN36ia2pmTUebap
   hWTolRWstCsFGqUs6LikTfxQN1eT5O92Qn1HZWbA0Bu7p18ItY+/woZZ0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="368806583"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="368806583"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 15:19:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="871678495"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="871678495"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 11 Oct 2022 15:19:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 15:19:13 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 15:19:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 15:19:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 15:19:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jg7cgZQ/3QzjQH0vMSvFA1yK7Ez+BdzyInJUl4pwV2wwfQLn4szmJO5Y/xKpkNEow16FUiSFNjw4dxUU8Dz18mTUysGuLFwHTNDGpsbqew+8GgmIj/OTvXITwCnuziyYCj8+fNeXcjLj9HPtAsvxunD8GmbKdUSBQmIuAgszwuMQAgpopBJWByLJatnXet+dYa40oEio17VrXVuUISQ3zXo+yuia3fb1AKCjL0zQhhfTv2uX1+71nRtgHuuDSonACI3WUkqDnbwDeE/dy1wro80pvh/V1M0NIWI80OFbWDS2LTECpSV3F6JLHDs0T11rS3p40P+xxGVfNBzlNf2hHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WA5WD2MfkX++wFNoyUBKdFbY+4Qm0ZZa0Wjy3DXsGqI=;
 b=h+TMlD6j7IoVKC8I11ECECau7VNJ58SLSvL2aCkyRuEf3YpJxnSnBFb2KJWsmpVuG7P+etsSgtR7ZBgzoQMhKG8QRdPzXpAegcXFEYtU/zuLX9uYFNXcgGXYSDffESBXFsJRc3BPAtD+iKP5JBIRecQPO1zG+zTVuep/gvUKP7z+4O7RudbvsELyAqmcBX5S5uJPl/LZFkdWTuKJZJD8pt7iDQLokr4YEhqLGgKdkAdOkYXx2l/5XTd6HPreyc2X6NbZ9ihQ7KR1pY+U8wl+OuwKY191MyWZGnFAPizfslbGw25Ph8QKUilY95ii/fjqla0x6pqDhZoJKOLsTarzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 11 Oct
 2022 22:19:12 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%5]) with mapi id 15.20.5612.022; Tue, 11 Oct 2022
 22:19:12 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Daniel Verkamp <dverkamp@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: RE: [PATCH] x86: also disable FSRM if ERMS is disabled
Thread-Topic: [PATCH] x86: also disable FSRM if ERMS is disabled
Thread-Index: AQHYzufCn81lK4uiX0SZXRx4bJPwP63s3TMAgABn1ICAAAdlgIAWBXKAgAXZaICAAF59YIAADP+AgAATsSCAAB+lgIAAFixA
Date:   Tue, 11 Oct 2022 22:19:12 +0000
Message-ID: <SJ1PR11MB60835F7CF6645527DDC63713FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20220923005827.1533380-1-dverkamp@chromium.org>
 <Yy2U2BW6Tx0imGpK@zn.tnic>
 <CABVzXAk9AXj2Ns7YAh7cCA38t2sGxOEYLv-EfLCoFHr-SUQ2Mw@mail.gmail.com>
 <Yy3yJfz213Lqo4KC@zn.tnic>
 <CABVzXAkO4pU+gpUcWOEWDw+W4id=1WEOgeP5+3tBG_LR6=oa=g@mail.gmail.com>
 <Y0VTS9qTF/GaMihP@zn.tnic>
 <SJ1PR11MB6083203F6D6EFF8E562A2593FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y0WtdarNtdIXCuhC@zn.tnic>
 <SJ1PR11MB608345C36F1D52B8185E46E1FC239@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y0XYhftUTqd2BDHn@zn.tnic>
In-Reply-To: <Y0XYhftUTqd2BDHn@zn.tnic>
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
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB6565:EE_
x-ms-office365-filtering-correlation-id: d65fb9a6-7803-4ac9-47a3-08daabd69fef
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EtJNE1uAezc27XAbnFkmOqDkMxaVbdcue6Ic6mGv1VjryIhfZixWdI9dYhoY87rV8aVEFHkaHzuHNxIaYXRQQoHnWiJSeQgKs+WyUxo0IPZuduoVoErBAJpcpyxtJY8epN/w3RZiUlb868hh5RhM2puBb5k+JmWnv/Z8oe6XNZY3O+yMZkK/B2xjCyn+polxd837oo6cDTp5JfMXWSJZv8jWK3P14wNLwKLUlQf5lR6e3XJWONy3utimSsCDbTnCtF+lrkvixhMsemYlOaytZnYMRzbo6n4destMlXOOZ8SuA0qyfneGmUVTfFHguePCEvwlXN/yPMI43kj7hrzmoUFkpphMw/l4BhVfI/E96zvrbkNzUGH5aoxKE0RkR7li5zh6z0V/GbSQuPK0CjfM7Z83Y8qsfTyeAb7UOsESI6QoVfRr7zH6xtRf4KzAJLgtnvoc8kZHw0RT658iuDYBjum25rk76TI5yx16ZNkvirgPsRM3oUqX9PN0OJlkrNAFacVsEqYc6yT+ZXKgvZPx83h/hbMZkA5D844SZz/zslXcmDnSXaCWqebsp6VF3CAE/HSd8ucISHG4yAKFS7pWJ6pwqfltJU0Twb1j30bDcbzY0NpAn75n8Xr1+8qlQsOAl/e+sKOrQsNVrZodrQDXUtRhpZZ/okO8ruX/U2NFUvyocYA+PlbrZrHVv0E+s13DhQkSSxqSywT1AFT7kWMLWeKJSTyXy6n8teZHWTLvnyAgcHS5bpNq4Y1eSYYDrC59QZblLt+tRaDCAPEsKEYDnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199015)(9686003)(122000001)(33656002)(6506007)(7696005)(66946007)(316002)(66446008)(66476007)(54906003)(4326008)(8676002)(186003)(6916009)(64756008)(66556008)(76116006)(38070700005)(55016003)(86362001)(26005)(52536014)(478600001)(38100700002)(2906002)(4744005)(5660300002)(82960400001)(41300700001)(83380400001)(8936002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUptTjhqYzVxZjMyNDI2Nk1sSmFuNDl2clJodTdvTlJPeVRnbkdDOTRLUlNO?=
 =?utf-8?B?NFM3WjQ0TWJocEFoWllhV0FFTWE5Y2NhMTBNMHpVK0JpM21ZYVFaSXppNWY4?=
 =?utf-8?B?b0VrNmt2anhaeWY3ZllPYXcweDk2cnltdmFaRyt5YXp3dGFDeWk3eVAxQzJL?=
 =?utf-8?B?NE93bnR3alVnbTA2LzErTmZtSDZRUjZvMmVYdk1BMW5ULzdhV0lpRFAwZDV6?=
 =?utf-8?B?YXcrTVBxeXJBaFRXZFdET3FiSEZRUFpjbE5qcFdHdU5LMUxFcWVNMEhqTCtM?=
 =?utf-8?B?cTlhTE0renV3SVVYUXpmT3ZzMlFqbGZ5VUphNU96UFJHSThnTzh0REVmTWxI?=
 =?utf-8?B?SDB0NnhrRURwclZTYkNtUkFXS3dQbjFGLzRPajFTcytIdXZpdFY2Mmxydmxj?=
 =?utf-8?B?VzNFVVc2aExuYnVkTzY0OHRsWWh3cTAzd2NZSTRSREZQZU1SMGFmSWFGNit3?=
 =?utf-8?B?L1lGaTRwNThBd3JwL2x4QWxjbzZYdENvVFJROFhxdSttZlNOb3plREZsUFoz?=
 =?utf-8?B?RmJJRjhxK0NPL3JDUDBGT0VVcVUzQUdZcndQVDVHL0YxT2lvWkRoWjFEWDZM?=
 =?utf-8?B?SDhtcGFkbkVUeDhTMzhNZ3VMRnZ2Mnk2cDBFYk9jSEMyc1dQQkFPMW1oU1d1?=
 =?utf-8?B?dkoxVTFzemljc2R5S3hnd0VpdE51R3ZEendTTE4rQkJOQ2swK0hyQU05L0ZT?=
 =?utf-8?B?T0xkNGxZWFgvUG8yUStud1c1c3hCdk9pNVpYaE5mUmZWcVZwVEFUaTVTRkhp?=
 =?utf-8?B?R1pYc1E0R0JoMTA2TWppZGRVbTZ3UndoS3kzc2NQTDZYb0lya2hoOUNmVjR3?=
 =?utf-8?B?Y2NJZlBtNXdMRXNRTGloMVB2cmxoNFpoUThaYTB4SE4xaDhJZFRtbjJtb3NK?=
 =?utf-8?B?TG84U2hnWTd5UlZ6dHdudFJqQ2Z4NjhNa3JORCthRGt5a3hYcXJ3Y2pCTFo5?=
 =?utf-8?B?UEk2d2dtNEVqOEtJa3dISXd1dk1SU3haZVcwL1NYdTRvckd4U1h0N1d4c0Nt?=
 =?utf-8?B?TnNMZ1lXVUE2MWh0SlcxdTkxR3V4QlVqTHJTWDg3TlNaS2tEQWlMa0w2Ung1?=
 =?utf-8?B?SnZxc25ReG5PVDZSaXN5QXJocWFvTWdIcXkrbUI5N1hvVEdvcVVxcFVFRERX?=
 =?utf-8?B?aHZsODRaQ2hMTnZkL25wbSs4blhVbTVhS1lSM0ZBek9GYWxrb0dyZU1veVRw?=
 =?utf-8?B?RGsyTFowOFkxaVFySEdSVVBqNmxPSUc1V2VMVmQ2dlZWUVVHSzBQRTdieUYw?=
 =?utf-8?B?Yld5RWdkbW9RN0tIMkhSR3FJOGwrcXpwamN4NGxxaTV5WE1BbFFGbE5Xcm96?=
 =?utf-8?B?c20vanMvaEYvMjF1bnJRU05VaWRWTERrTkVSVjBHanpVTlh0N29uYmFDZ0NO?=
 =?utf-8?B?eFl6WnZBUXVJa1NVT0pmZjZhRGx2c3A0Z0FxdWVmTnNhNzFBeUZQcHl0VVdl?=
 =?utf-8?B?OGg0aCtCSFQ2blVkb3lGbTBVTUdOK0JiRC9qZVlMTFJGb1ZzRy9ya2s2K3RQ?=
 =?utf-8?B?dlUyamFUUytTbUpIWWZGMEhPckRRWld5b1FVUkJTMHBwQ2djNlZiZExydUl5?=
 =?utf-8?B?NUNUVy9KZkw3RVE1dGVUbGlmOUVXUmJEOFpQUklKM0I4cHB6SnloYzMwZ3RG?=
 =?utf-8?B?RXY2b1lLNmtnSlVIcDhuWW93REhLenl0OXY1cjlRUWlvbFFqY2psaHU0L0xz?=
 =?utf-8?B?Zi83MzJVQmxsckpnMEJTSUlva3lUMUg2NFc2ZVZONDNPb1J5dVR0VFBrc016?=
 =?utf-8?B?Ni80RTZ1aXBVWUNyaFdnczhoRnlSUmpUMDI4WXZBcHcwRUJFUm01ZFNkQWZX?=
 =?utf-8?B?dU1mOGRQYnY3OUtnbXJ1cmRIOHpzcGRxLzFDQk95akp2YkRIV1NtR3hOeS9K?=
 =?utf-8?B?bkgxNm5CUGN3RW96dFVjUFZxMlFIaVgyUTlHTDlBQXh6ZFhjKy8xeFo1czk1?=
 =?utf-8?B?U1dvUkxVRkk4c1RaMk82K1lyYTBjazl2L25jNCtrQmhWdWFRR1UzcWVIYkIw?=
 =?utf-8?B?VHdHNjhCblI1RDQvN3NRNC9Fa2JqZ0lIN1RWUkJNcTFlRFluQlpENHJtN2c2?=
 =?utf-8?B?WnM2Y1VyYUNLeDlaWUt3OGtYWWI5M0FhMFpXNzJxbEFRNUFENUkxbVdjUm1I?=
 =?utf-8?Q?1QUg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65fb9a6-7803-4ac9-47a3-08daabd69fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 22:19:12.0487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +z4G7+UMh6I4q4ECh8hrcNT08DIyHzCkBeijojcjwD01Z3hRPGMckG4QiplqsnJCm7U8rB//J6IrYA6CzoLdNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGF0IHdvbid0IGhlbHAgYmVjYXVzZSB1c2Vyc3BhY2Ugd2lsbCBzdGlsbCB1c2UgdGhlbSBz
aW5jZSB0aGUgQ1BVSUQNCj4gZmxhZ3MgcmVtYWluIHNldC4NCg0KRXZlbiBpZiB3cml0aW5nIHRo
ZSBNU1IgZGlkIGNsZWFyIHRoZSBDUFVJRCBiaXRzLCBpdCB3b3VsZG4ndCBoZWxwIHdpdGggYXBw
bGljYXRpb25zDQp0aGF0IHN0YXJ0ZWQgYmVmb3JlIHRoZSBrZXJuZWwgY2xlYXJlZCB0aGUgYml0
cyAoYXNzdW1pbmcgdGhpcyB3YXMgc29tZSBydW4tdGltZQ0KdXBkYXRlIHBhdGNoKS4NCg0KV29y
c3QgY2FzZSBzY2VuYXJpbyBpcyB0aGF0IHRoZSBhcHBsaWNhdGlvbnMgZG9uJ3QgcGljayB0aGUg
bW9zdCBlZmZpY2llbnQgbWVtY3B5KCkuDQoNCi1Ub255DQo=
