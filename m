Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30A5BD49F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiISSO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiISSO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:14:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A10C11A1B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663611294; x=1695147294;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BlSijaY8l/eBjyQsZmgMEt+9F2h1+Va6bh9m7AEE1uk=;
  b=MrOO/2qKZuLOxXjF0jnNuW7YbZJeVfMMlvp0uv7bum9B6QHvptUe2cEU
   VRmgKFmHjUiJflBrhXJ6MtBsVYJkCMNWJgKlU1xLMzmyL51acLG4W3INx
   ZtnsYEQupNJCzd0ekLFTq1SNb8QOUXi2iiWns5/+imGPTGVBOivbmIPuE
   08Gl4KesyE74+B13oGCFQwJya/CrJLfgl6VidmMNAEdLOy27ZcoaJAGmz
   AG/Q4IBnCYfdMfO1XN/+UemcCTpMhUF6PzCDyNHkEPN813IAAqLMBKE1k
   fy00dqaNi8+wJeTqp6g/rPhgKS3PCd4HZZgmUHyVM4hm4Yk6q+wgvk9Mv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363436735"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="363436735"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 11:14:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="722407217"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 19 Sep 2022 11:14:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 11:14:53 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 11:14:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 19 Sep 2022 11:14:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 19 Sep 2022 11:14:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPY9s79XnzJipiw2+FDy7UDrfMYTwnNfqBx9JYaxYlcDfTgWo/s6gF4e5VrZyL39kHGHB42G6R8Tf60wIBVKChoNEnHs2ehlNt3e+HRUL8AG6ofk9spCJpb2GbXgTQHYisqudNXGs5iy+97pWiC63FyaUo8RkgLKx7imWFaJ7jf2FWA0C9J1e7tfulkqmhQ8jS7pJ86CBPrdCTblqBCnBPmU6UWGzaYx2SW38bJrrE6YAxQQ+FBHxdjecfagPRyP0IVfFrk3Hi6yhT5SGtVnqZcSp/InM1u04bsv16d33Xz5Tz0iKaxvc9flBxc2alOBO6hj8CqrtlwXfnxEqkaaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlSijaY8l/eBjyQsZmgMEt+9F2h1+Va6bh9m7AEE1uk=;
 b=GBbSbweB1fwuImK4lrSjEgIl9WEktDoPRKeIgJWLrdpyriQEg0gvi7a6eio1h6QEz6+Y6cbh918JPk2ZIzk3FZyRgv9gu+EQVgmLL7q1Z3GVu/wQ7uynBrsyTBOomoYOcPnEC3hsYnXCXkj2SRlsManQgO+J3E0+djze8UrBgrG+vZC7goEPy4Wt3pDgntd2rBW37V7IF77hUyGJUVmDWnfImP522bMl+aE3aalcRxNoTfwqlmoAFikmg8yN0sdNFErWGf3OnDVtaa2iXhaLG/hDtYS8xBCzTSTtplZJQJehCDI3xLn6XXd3Abdmv+GA3UEkUEeXf0Mc6R2P/OONIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 18:14:48 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::9d5:53e5:d76:8d2]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::9d5:53e5:d76:8d2%12]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 18:14:48 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Liu, Yujie" <yujie.liu@intel.com>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH] x86/mm: Set NX bit when making pages present
Thread-Topic: [PATCH] x86/mm: Set NX bit when making pages present
Thread-Index: AQHYzE96DigDrCDYB0GpZW+jbYKfI63nDseA
Date:   Mon, 19 Sep 2022 18:14:48 +0000
Message-ID: <14fea0e6809b42393388d20f5b62509108a87a71.camel@intel.com>
References: <20220909152721.1685334-1-dave.hansen@linux.intel.com>
In-Reply-To: <20220909152721.1685334-1-dave.hansen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BN0PR11MB5709:EE_
x-ms-office365-filtering-correlation-id: c75f3f00-4b30-4236-11fd-08da9a6ad6a7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fH2h7K8GYEmCBAN4RT6mYXux9gH7Gvg2E6+7eQd97IzVw1iKwGqMWRLhGXKhxmTBlTSlw94poh30G9oF91O25ImwgepfUXgWzExVmpovTG11oTfyvKiB34MVCYEinaup6eCojCYqpObePzQEwtlgILsZdUBvH1yeMYdD61903HchvBYIZv7Pecv5Hyiat3++JceOKvMABVt1qRuB6X1qLCxneuSKRmbZ0LSrUxR0llFe3a1u0D9/wErXxSe2RBrJmfSOivRhcI82R5tJsBR4ZP3fw5FtEYrxtqZJ56aa9mDtqcZO6AsonzMEX5LH2sfEtlA1S+UoTL9NM25HdaoUptT+lhw6igdqgmo9oyfuubt2Z58T0IkAZquoxk3mp8AcgEgTxtmn3IH0HhqFx3ZdKpAaMenyzlSMUVVvXALBHilk0Aos9uPLEthiAhHNvN8vGwo0podY0yjQDTo8g/v/b7TcKqIMjMIjHL/I6VAos7DVAm5yNaBPk3nQia3S4FzhT6rWq8EExxs/lkEOjwWt6qV4ECdM5ZxebEOjf3DX5fWiwJ2+g5iJe8GuMX+GL1sJo0c4DmoVnaJQ5ArQeDa0k4IPeIJxfzF905f1xyAKwJBRKPpLTCqF5I3F5fzYJp0uqIEBUiT5e6yarM+JpWitY6edJGVvp4rZdZ7wUlyB7ZsDawFxFeizoWQ4RIMMg97QCVALg9gmiYlaoao2IFyr/bnVpXVvJLPfYz3U2C3LCjCRg4vZw8Wnng7c6mz/b529d9+R4eL5/44e9/Wh/pvsndcAY1sEspgwPNdKqaFk3+g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(86362001)(6486002)(8676002)(6512007)(83380400001)(186003)(26005)(122000001)(38100700002)(2616005)(82960400001)(5660300002)(38070700005)(478600001)(316002)(54906003)(110136005)(71200400001)(76116006)(4744005)(41300700001)(4326008)(66476007)(66446008)(8936002)(64756008)(6506007)(2906002)(66946007)(91956017)(36756003)(66556008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGY3dzZldXJubkM1V2JpdnkxSmxqclh3SUs2KzFVdnVKRmFiOWFXU21OMkNU?=
 =?utf-8?B?T25Va0hSc3ZmVGFzaGVEZVdqV3JrajUvbzIyWE9zQmxkaXRzOG90WElHelF6?=
 =?utf-8?B?cEFkWHR3UGFSdm9oN1BnSU5BdURwbDNYMm5RNlVQdTlFQUxNMkk2NUVyQkhh?=
 =?utf-8?B?K0lZd3QxbldMRUpHQTdqY255dEQ0STVqbFUvY2dlUmk5VzdTL3FHVHI2SCsx?=
 =?utf-8?B?VjB6ODAwY1JoaG8wMCtuK3JrTzZBeHI2QmZSNm5UdUpYdEdnK1p3WFF0UTZG?=
 =?utf-8?B?aVVHSjB6SGVpOGg1ZWRCSnR3bVA5MndyY1ZoaTNrcVFBLzBUekU3Z2J0a3JS?=
 =?utf-8?B?ZjU3dzlHT0dPKzJQMno3cDZnUmdUNzZ1TUtSZjlpcXI0QkhNZDdoWC9tSGln?=
 =?utf-8?B?ZUhObnpYdUhLeW9Zdzg1bGY5MTNQajF6YU1RNGRzeU5KNC9nUDdYTndpYytv?=
 =?utf-8?B?NGZPbHpjRDVKN2R2K0VVMlAvTjFkRmU1Yk1wYkhqMHRZQW5QeHFpZ1BBblhX?=
 =?utf-8?B?WXpsNzZYK0xyT1RucnZRaGxZNm5jV1RBYjlYWFcvSUp6bDVuZk9yb0poMGV0?=
 =?utf-8?B?RURNLy9acm54d0M2SFFOWUxtSmMzeU1kbGFjU010MDJpeVZadS9QQ3ZYS0hu?=
 =?utf-8?B?ellZVVFxRm10Qmg4K0R4aldsbVI0bGVpL2pqKzhJY1Z4dEtiNVUrREpPVGR3?=
 =?utf-8?B?bTcwWHRuTGhmaEluL25OaU5yWVZiOE5IWE5NNnJUc1pJakVKWU9rMEhJM2Mr?=
 =?utf-8?B?SkJQTmFRY0RNNjlIbGxFSzhUNElJZ1IwTTJTWWpXdjg0eHNVT2RBZnNRSFAx?=
 =?utf-8?B?bjdyb1RXQWxtVTMyVjQ3QkRXVWUvcC9acklCUE40b0d6ZWFCZjhSWFdwWktx?=
 =?utf-8?B?bzRJV3RCaTl1bWVxNlJma1dCWG11NktXZE9RUnRNMUR6MDdZbnArVGxJaFBh?=
 =?utf-8?B?bE9WM1YxcG0rVXNtTHlxSmtLUEpQcGtXMUVEWHpreTY4Q0ZpU0lOcmUwakxU?=
 =?utf-8?B?MzV3QitvYW41KzQyZTh6Q1UwbWF0RXFtOGhGV1lEN1pqejBTKzJGZWwzRjNi?=
 =?utf-8?B?Umkrb1JxZ0V1S0F0ODZ5QkZ6bEdPTXQydmp4OUpOK1dEbElkT3lpVjF2Nk5D?=
 =?utf-8?B?WXpYTEtFZmtKNTh2eTBYNFI3K2I5ajBjcWVTaVpDanRIYlhVMkNPV1BJcEdn?=
 =?utf-8?B?SFVBMHIzNk5Fa3hiaXRWaDZSYzAyK2VYV1hESG5YZXN3elNFUHc4UGZvVEQr?=
 =?utf-8?B?RzNmLzRFNUtYZ0xRVDVvSEJ4SmFrakJUQ20rY3Q0cmU2bUdNM2hqN1I4MXNV?=
 =?utf-8?B?M1laOTJ3STNNczVZVVdQL0VzTmtycnlYQ0pqWHArMFE3ajhXd1JjeWNweXhF?=
 =?utf-8?B?Qzl0TTBtYm5xeEFPZW1kZGdBcWgzOVBacjZLaFJIanI3ZDM4b3FaWHkrdjQw?=
 =?utf-8?B?N1M4OFNUMk9JQ1c2K24vbTNFWTEwS2puNXFYVFRnU2FXQVZiaVJzdFExUm1B?=
 =?utf-8?B?MTRKRFE2OU4wc3ZOUFNiaUtubGN5OUFBc29YT2greE9YaVlkbXIxRWpPUWdt?=
 =?utf-8?B?WnF1V0VzWVJCZjJucHA3THpXUXFDL0M1Si94SUlETjRNajBwZnVOQm5YSGJD?=
 =?utf-8?B?dEJvcm1wSDR2UDN3MnZqQ3FraDlkcE5wUm9vYmRtV21qWDVpbStjdHVlUzFL?=
 =?utf-8?B?KzJVU2pnT0pJdFpPNiszOXBYY1FaaE11bHlXYnIwdHp4bFBVSVRtUjhybnRt?=
 =?utf-8?B?SE9JWWFmY1VxY1BqYytKc00zUDVMRlM2RWF3UnRhVHpWN201VGgyWE5MWktT?=
 =?utf-8?B?eHlRZE5TTmMyeGplUkJLdEtWMVhnTTRTaEttMkJQNVN6dmNrd0hBckRWSnc0?=
 =?utf-8?B?OGhveFI1WHVrOGlUcHo0a0F6ZUFLQ0NxOCtqVk9veUlhZ3MvNWlEVmFXaFRC?=
 =?utf-8?B?eWZjdk5tdC9nUVFqSlBUTXB5VEtXTjUyd0NHK1RKeXhjRGJrMXRFT2I3YXMx?=
 =?utf-8?B?WTl3VlhxUVFQY1FDS3ZDaEhoWmRtbC9ja1Z0NFFJQmZUdDNjZFR4MVdzS3B4?=
 =?utf-8?B?NHlPVyt6UWZIaitqS2dudzFXQWNaRndHeEloUkZBcHNITTVnNDgxeGpHSjdO?=
 =?utf-8?B?QitvSVRKT1BJM2N6dkhLR0ZBbGlXQzhXcnRlczRvTGF6OWw2b0xnU1V2eXoy?=
 =?utf-8?Q?PODwE0Axe1NltLMZlaMd3BA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B17A63088E72E468AD249E547FBC2BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75f3f00-4b30-4236-11fd-08da9a6ad6a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 18:14:48.4674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D1Odx1Qk0wZLeyToMW1+EIEmNGI+GsRwRUyIdi1Koui+N7EGGC8m2Ul9UoI76PpUxTLYJcEbl6Q6ZB4+ZKViPPp5bBirOzNPQ2Vkf1DZI1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5709
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTA5IGF0IDA4OjI3IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
MGRheSByYW4gYWNyb3NzIGEgY2FzZSB0cmlnZ2VyZWQgYnkgbW9kdWxlIHVubG9hZGluZywgYnV0
IHRoYXQgbG9va3MNCj4gdG8gYmUgYSBnZW5lcmljIHByb2JsZW0uICBJdCBwcmVzdW1hYmx5IGdv
ZXMgbGlrZSB0aGlzOg0KPiANCj4gICAgICAgICAxLiBMb2FkIG1vZHVsZSB3aXRoIGRpcmVjdCBt
YXAsIFA9MSxXPTEsTlg9MQ0KPiAgICAgICAgIDIuIE1hcCBtb2R1bGUgZXhlY3V0YWJsZSwgc2V0
IFA9MSxXPTAsTlg9MA0KPiAgICAgICAgIDMuIEZyZWUgbW9kdWxlLCBsYW5kIGluIHZmcmVlKCkt
PnZtX3JlbW92ZV9tYXBwaW5ncygpDQo+ICAgICAgICAgNC4gU2V0IFA9MCBkdXJpbmcgYWxpYXMg
cHJvY2Vzc2luZywgUD0wLFc9MCxOWD0wDQo+ICAgICAgICAgNS4gUmVzdG9yZSBrZXJuZWwgbWFw
cGluZyB2aWENCj4gc2V0X2RpcmVjdF9tYXBfZGVmYXVsdF9ub2ZsdXNoKCksDQo+ICAgICAgICAg
ICAgc2V0IFA9MSxXPTEsIHJlc3VsdGluZyBpbiBQPTEsVz0xLE5YPTANCg0KSSBkb24ndCB0aGlu
ayB0aGlzIGlzIHJpZ2h0LiBDUEEgc2tpcHMgTlggbW9kaWZpY2F0aW9uIG9uIHRoZSBhbGlhcywg
c28NCnRoZSBlYXJsaWVyIG1vZHVsZSBDUEEncyAoMS0yKSBzaG91bGRuJ3QgaGF2ZSB0b3VjaGVk
IE5YIHdoZXJlDQpzZXRfZGlyZWN0X21hcCgpIGlzIG9wZXJhdGluZy4gU28gTlggKnNob3VsZG4n
dCogaGF2ZSBiZWVuIGNsZWFyZWQgaW4NCnRoaXMgY2FzZS4NCg0KQ2xlYXJseSBzb21laG93IGl0
IGlzIHRob3VnaC4gVGhlIG9yaWdpbmFsIHJlcG9ydCBoYXMgdGhpcyBpbiB0aGUgbG9nOg0KTm90
aWNlOiBOWCAoRXhlY3V0ZSBEaXNhYmxlKSBwcm90ZWN0aW9uIGNhbm5vdCBiZSBlbmFibGVkOiBu
b24tUEFFDQprZXJuZWwhDQoNClNvIHByb2JhYmx5IHRoZSBXXlggY2hlY2tlciBuZWVkcyB0byBj
aGVjayB0aGlzIG5vbi1QQUUgY2FzZQ0KZGlmZmVyZW50bHkuDQoNCg==
