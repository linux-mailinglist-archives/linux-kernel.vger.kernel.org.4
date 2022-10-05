Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413485F51A6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJEJRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJEJRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:17:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F406CD1B;
        Wed,  5 Oct 2022 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664961436; x=1696497436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3BM9EAWnuuxS97/6SbC9s8q/3sROK6XsCZf8Mu+dnx4=;
  b=1r1R6812ZNXw3ATLeNPkuYO9If5WC44YA9U4yIDS5qHZ6kD+Mr+PTbn0
   jjNMsBbtbz1TzmH+QqaFtJs5Sceiu9mw9sgbTWcDvZ4q4BMWQ9Rp5yP5b
   6wCXrhgUVV4S5Y03GEtlPJcY9vw9KKVEFpXQ3AqwSfZJd2NY93St7uKmZ
   y0v6rRrMM64LhqZYqcfcDsWLnkWpj/aDcuAzJmwmJn+tdOmvZAilf5WBQ
   sG5MAWX5Nkpq1NAD0BXblwijsr8JjOeCd+wiTRaEuGPpiZU68FTIB+85m
   WBSJXvnSIZwo+CwYcuAyoCVlkyrs2FIhRqdNXIiiCROFfEm/dbmJN9WZY
   w==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="177114914"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Oct 2022 02:17:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 5 Oct 2022 02:17:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 5 Oct 2022 02:17:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxjHDKbw2tJEugvlbqMGwhLNAsJtKsggbgtSl5ytBSsTf7C8s4QHft+TtudZx9Yl1gPDgyZinkrBD0Z+vwovAj5UmUF8K0GD8HeKTPRoRRHwltEB3+KZ81vFd2aJSJwvyH+I41ATxGtRHW61q4/i66SbpdjFCxnHYdfgJM83bcKgCBlf8VrXTtHczeUivDzyZldTZZNz+NGClnt4sNY6yXdn+1SbwBcvBK6n0g14RfoBVxFOaDTvQf2bArcYFBgrYxTG/+e3ng8aQG8Toc+nRol+hwuuqZVLnebiw3/cZu+96yFrpxwqsjg/I5/X5u9FlHVeWH+2VgRANo+82w4wiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BM9EAWnuuxS97/6SbC9s8q/3sROK6XsCZf8Mu+dnx4=;
 b=LafR7xR5ByPLVekvvJhKFrwWy3jHgOTIsTeOTEZCNxLhSpjzedoWX8IugLGHUAb5cE9LUnbtAMR7UC7mBuU6Y6WmyMv/23G7DcM08RUCQh5gH6QZNGqEkkSjptTWvsasilOuGmcsDFns+ZmazOGUAxYCYW4QgQJdetRZjnwDy4f3ORT0HqsDlhST93fp1s+fkkg6XJ6XseY0TuPVXIIW3ZRb9MiIimpx85glrWr3hbTFh3L9j2PjiOWWOL8QwNKDiTT+0LNtMWEbKuhSxSxdv0ix85OFKpK+5JO2uumm38ZJD4VKj9RJIOwPPCXXuUfywroR1rZrEPhuod14PHCSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BM9EAWnuuxS97/6SbC9s8q/3sROK6XsCZf8Mu+dnx4=;
 b=W4tq57Q44+zax1RlE6m0r366U3hrhOfmYebJZI9vONVJYX6De0aZQwKUGDjfPoqGMR2Hn7GkFj3M0dn0pzuwm7yHWCvx+aSjcklZFeIjRvb2Hh+N3YUdvVcZOP0CgieBI3me4gjHRUmxz8/tyPHthmVJ7BSjUE8xs5gKHv8FN7M=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB6066.namprd11.prod.outlook.com (2603:10b6:8:62::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Wed, 5 Oct
 2022 09:17:09 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::68c0:270e:246d:618a]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::68c0:270e:246d:618a%3]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 09:17:09 +0000
From:   <Conor.Dooley@microchip.com>
To:     <conor@kernel.org>, <prabhakar.csengg@gmail.com>
CC:     <geert+renesas@glider.be>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <magnus.damm@gmail.com>, <heiko@sntech.de>, <guoren@kernel.org>,
        <philipp.tomsich@vrull.eu>, <nathan@kernel.org>,
        <atishp@rivosinc.com>, <apatel@ventanamicro.com>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [RFC PATCH v2 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
Thread-Topic: [RFC PATCH v2 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
Thread-Index: AQHY13gcXVGHZZYv1ku7x8IJ0u88J63+gogAgAD8BACAAAOogIAABUGA
Date:   Wed, 5 Oct 2022 09:17:09 +0000
Message-ID: <5254a42c-9233-6f9a-eff8-33324a184d20@microchip.com>
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YzxwoELNBctbhjJb@spud>
 <CA+V-a8tgvF16vduoQ+ZbzTpRJUmCnN-GPQs5G8AqMOXbnznwHA@mail.gmail.com>
 <F0B6C609-6C39-4080-8F07-7FEFFAFEA993@kernel.org>
In-Reply-To: <F0B6C609-6C39-4080-8F07-7FEFFAFEA993@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|DM4PR11MB6066:EE_
x-ms-office365-filtering-correlation-id: 893ea1b1-cade-4e71-79b8-08daa6b2614e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0STbRnqFl+Hh6ge2gMpezGEJOFBVlEfUp6+h60jbSpBGwTRDgNdNb1OW4qeerBvguBW+RZStA8jX5KM8eelC6yoZQ7mvpgx4mGQhJ0IcxKaqf33SoE8n5kvTq67N+q4uusECgYosrM1Hnjxm402oqx+VBIrT+B5kBhLBBTZD5iHp7x/2X10nrzq5DfN97DS73rYS6HnCU8INAvE0Q1Fxbc+6W2PhUEL53+bcrWPChtF3qM85zyNIRLo2UHkSudP2ePPTrF+UFfXZaLeOAnw6wuge6ca1RoIDXjq9iAXsk8uKcpR1wZBPWHVmY2TVbblV7bcWq4IX2q8RI5b9Rdf8O+NtB3wSt4Zn8ARy5sMGwXvJfKZj6ddBh7nFHyo0uu/a/Qo6vOYqxLoQ84qolP33o1Y1XzttzPOw48iCDqYhv56t8CUParKjArUeKw0zpFpl20CHLS/R3N9ZeocJWqAz9fkfJZQD2BrY6YhwEJz2D7dswZ0yazFlgM6drpYY8rX5Y4/0j5w7iSbAAQJch95qfp9ZnPr4wmxbdivIoiPtIHhcu9oM0HRVH6i2WH1hTMxuIB/axyDDs+1J8DFPRewGGIGTNFcgWkaYFPxTiDqneFKi3mZNhHbYP31xI6LsKHVVy+loeaocG1yxCKvobxC6Qdksw+Rwg6HE3TInLQOyLrEbVkm+XZPEQFVQSjWwH0EVEvbCtkvUxq+ienOYCamVJia6PJ9ND+4MwK+fB6xXv4kbtzSTHWJQYQbvVH2e3wRxxwjWRpkI+KVhNI2hh/tU/xd6Zh9/V/sNzCNPPzyzgXRhaGzS1GuJse6O24USFdNdrpa5wnCzpHrCtxcagzsBow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199015)(66946007)(41300700001)(6486002)(110136005)(478600001)(64756008)(66446008)(76116006)(8676002)(91956017)(4326008)(66476007)(66556008)(316002)(36756003)(122000001)(54906003)(38100700002)(6512007)(7416002)(4744005)(53546011)(5660300002)(6506007)(86362001)(26005)(8936002)(38070700005)(186003)(2906002)(2616005)(31696002)(31686004)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z01NYTVRMGExamtabVdCcjE1c055REtMYWR5VW1zTTVOOFVvN3BYYTRENnJL?=
 =?utf-8?B?VEZUQnpDY3p5Y3Y3bEJrNW56cUYwZzErbHEvNEZmOWQ4TzBWdUpnc2tPNXlQ?=
 =?utf-8?B?azhxdHhNVHFOSWpQeXVMRGFTM1NhakYrbWVuaDhycHRnendnb2RIazd1YVcr?=
 =?utf-8?B?TjJFVzY1dWlicHVvWXBLTGNKRWx5L2FMWkRKVGJvWHhhc2o3MTdrZXdRenc1?=
 =?utf-8?B?RURPenNnSXNSK1I1TGdsbnQ2WU91K3dSbGdJQkIvVURFLys1WEJLdG4wN0Jr?=
 =?utf-8?B?N3UyNHVCUmg0L0pueXRZMy9Bb3QwbHJ5U0E2M0JlWDA2MFNtSndEcllZMmdy?=
 =?utf-8?B?Zi8zWjhsSWRIaEp2ei8zMVlyUGJ4NUxMakh3NUh4VXIzMG9vWWZTY2xSVUdD?=
 =?utf-8?B?cjEvOU51d0ZhRTFZbEQ0UDBWbkNlbEJQSXFLWExpUEFjclRHakNxS3JhYllT?=
 =?utf-8?B?enp2UUVzWEs2aDIxSkEzTUtjQUF1YndrTVRWcG1UdjRMWndmRitBTjRCYW5L?=
 =?utf-8?B?Y3lFN0xucUZwbFF3RlN6TlRCVHlIaXNWV0U2Z1hqVDBQa2JrbXFSR25nNmxX?=
 =?utf-8?B?dTNyNUhhN3BmcmRqYjBlQ0tCWVpSUFNjTFpnUEliZkZBbFYvRlN5Wm9Ed0Nt?=
 =?utf-8?B?QmZtSHhnNVgwOHhubXBrNERscnRzbDE5VVFIVFA5cXhFQmpwSzhIUk9sTnhs?=
 =?utf-8?B?MGpwZE1tWHpvVnJ0QWN0RncwdkZ5WGNmNC84d1NaY0VUZ3o4Z1dQUVBiaVJr?=
 =?utf-8?B?NmZKK00vU1FXS1YvQ21sdFhTRG5FL3dMYWdJLzVRamh2bTBsN0JqUEMyRDJ0?=
 =?utf-8?B?NVBLNldLdmIyeXIvWEhRbDBSbzV5Q25XVDVSc0JqVXBWSW10NW5HYkRGZEV2?=
 =?utf-8?B?NTkxK1BWZW1vTEQ1VVdxYkQ5VGlXSzRZWDZiTjF2bHhaMjczcGxvKzBHNlI5?=
 =?utf-8?B?Y2RTTE9rZEdPWUh6VEVZcU9ESEU4MjU4Mm0rQ1QxaEhvaitMc3BlUHZoL1ZY?=
 =?utf-8?B?OThaRER5a3oxa3lvd2FVcHh4blF0VTVkeTdCWGVrelcrVDBjL05mM1c1Qmgz?=
 =?utf-8?B?VHJDK05HWnZRR2RWeldIMkVUTHJHaTIwNlRCQnN1WVludk82dmN2OXZHME5X?=
 =?utf-8?B?NkxiczcxSUt2VGc5bWdqWHNYNldONXMvWjFJampQejlvaUJ2VnBSdmJ6U2o0?=
 =?utf-8?B?MW9oSE5HRG1QZ0ZJbWc1TTZtcVVYTktlUmhVcXJsWFJRclZWSHRFVzVGTzl2?=
 =?utf-8?B?MWVRWXNFWmRFNmt0czZvL1RpR1hxS0hzbzJwdktnVFdNdEVyb093VG5DN2Jt?=
 =?utf-8?B?b1pvT2tIclF0ZDRhMS9teXNEL2lBYXRzaHNPUzRhUzBUeWlNOUFTRlBNZTBq?=
 =?utf-8?B?TDZzcElKbnErcnN0cEJqY2hNTHIxOG5wUUJVUXpFNXVoL2tCanpKU3JFRmhq?=
 =?utf-8?B?Qm14eFlzQzFHdThqblRmSmJNc21uSHBUY0J1cWdrdExWOVNWTkpmWjBNTW96?=
 =?utf-8?B?MWllVEZaQ0tpL0hTMnQrK2VGcTlaTFFZeHVteU1NcTliYVNPeWJ4d3hHcDdx?=
 =?utf-8?B?NEVudjIrZFRkLzg0eUlac2FEU1MvTlZrOVhMVURSc2pPUUhKblBQUWozSGFI?=
 =?utf-8?B?UVVLRmpGVVNpUmdXMTdmL0o0bWR3eVlSOWZ1Z1c2L243SVFZMmMxZEJTbkNo?=
 =?utf-8?B?emZtSEtmUUdrdDV6OXFESEwvT1lQL2pWYVA0MTI3TkxLWmtDcGVxS0lKK1Fs?=
 =?utf-8?B?QkdabldFSG4rRFN1Vnl3QzZ1djd1TVc5aVNLb0VyRGgzTWdvaHpwVVEveWN4?=
 =?utf-8?B?RERlWG5CWTVnd0ptZWlPeVZudmN6Sm92K09DaUY2bFBtRGtDTEN4VER2d2Nj?=
 =?utf-8?B?Q21EN0RpNkd2akZEYmdLYXpYdTE5YmI3SkExK2R1NDlseVlvMnk2ckFUUFVt?=
 =?utf-8?B?VThUY1BFZ0ZDaFc2NndzYjB3R01PNGlVTmhEWFFmQThnVm1kQitSZTYzWXY0?=
 =?utf-8?B?U3poNmsyb1NOS0pNVGdhY1JkRHpqRkR4bm1RYUNFTnI4a0hIeU44azhHVzM0?=
 =?utf-8?B?QXBMSzlSLytJU1RtWFQwbkRaNzFCR0ticjJwRUtZeHNLbzFPLzd4cXdNR1Ru?=
 =?utf-8?Q?QNc4jCcbtwnZK2brYrHx1cHkH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48B0E84B17BAAE41AFD85815E3D4AF46@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893ea1b1-cade-4e71-79b8-08daa6b2614e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 09:17:09.2643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQ99+UcEajjD5cVxqCA7INKfGaTY49Dl/jHVXSkuHhd2WBumwk3/Qd0r7mGPccV3yvHO6W11XcsI8jcVl/TCBcDdGVrRVPeoEHC3qtoffX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6066
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUvMTAvMjAyMiAwOTo1OCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDUgT2N0b2JlciAyMDIyIDA5OjQ0OjU2IElT
VCwgIkxhZCwgUHJhYmhha2FyIiA8cHJhYmhha2FyLmNzZW5nZ0BnbWFpbC5jb20+IHdyb3RlOg0K
Pj4gSGkgQ29ub3IsDQo+Pg0KPj4gVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KPj4NCj4+IE9u
IFR1ZSwgT2N0IDQsIDIwMjIgYXQgNjo0MyBQTSBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiANCj4+Pj4gK3N0YXRpYyB2b2lkIGNwdV9kY2FjaGVfd2JfcmFuZ2UodW5z
aWduZWQgbG9uZyBzdGFydCwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5z
aWduZWQgbG9uZyBlbmQsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBs
aW5lX3NpemUpDQo+Pj4+ICt7DQo+Pj4+ICsgICAgIGJvb2wgdWNjdGxfb2sgPSBmYWxzZTsNCj4+
Pj4gKyAgICAgdW5zaWduZWQgbG9uZyBwYTsNCj4+Pj4gKyAgICAgaW50IG1oYXJ0aWQgPSAwOw0K
Pj4+PiArI2lmZGVmIENPTkZJR19TTVANCj4+Pj4gKyAgICAgbWhhcnRpZCA9IHNtcF9wcm9jZXNz
b3JfaWQoKTsNCj4+Pj4gKyNlbmRpZg0KPj4+DQo+Pj4gV29uJ3QgdGhpcyBwcm9kdWNlIGNvbXBs
YWludHMgZnJvbSB5b3VyIGlmIHlvdSBjb21waWxlIHdpdGggQ09ORklHX1NNUA0KPj4+IHNldD8N
Cj4+Pg0KPj4gTm8gSSBkb250IHNlZSBhIGJ1aWxkIGlzc3VlIHdpdGggU01QIGVuYWJsZWQsIGRv
IHlvdSBzZWUgYW55IHJlYXNvbg0KPj4gd2h5IGl0IHNob3VsZCBmYWlsPw0KPiANCj4gTm90IGZh
aWwgYnV0IGNvbXBsYWluIGFib3V0IHRoZSB1bnVzZWQgdmFyaWFibGUuDQo+IA0KDQpOb3QgdW51
c2VkIHZhcmlhYmxlLCBzb3JyeSBidXQgdGhlIHVudXNlZCAwIHRoYXQgaXQgd2FzIGluaXRpYWxp
c2VkIHdpdGgqDQo=
