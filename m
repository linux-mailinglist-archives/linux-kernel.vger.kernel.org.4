Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E833722D9E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFER0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjFER0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:26:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C418F;
        Mon,  5 Jun 2023 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685985997; x=1717521997;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4reCEN7ecbEgIpt1IrZ8CYICCTF5ZzczkLGmKh2F4L4=;
  b=UxMZeIRTCdMD6gO2NhBF+C44tCT3MBsONrKLepAlXQ2U2Lmg7wRCs9zv
   i71+DFRDI3774U0ZQ2x1twLVGT5tt3ILK35A05Luya+gpvVL0BnfU+HK8
   pmwGNtvpz1Uzyf1sW2uvOVdgWxA7k32vPzTsjfbrpN16i9tnUG/wuzIO7
   n8l4MfeiCnwgueVLFUarsRwu84pJM1rnTNbC86w0+21cwYOdkVJC6tgaq
   NcJQ4ZS48cZ8vk15EgSvTXFe6Za2OkfVpZ4lbtWv1Ukfncdrl2Ds2KJWx
   FAYnwBZlbM1iEavb7/cC4KsInpTb653xm8cR7tOMV800w3+htMyG8/Wx+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="384735954"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="384735954"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 10:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="778641448"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="778641448"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jun 2023 10:26:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 10:26:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 10:26:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 10:26:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 10:26:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcBLAJPmS43A/kd5bF0TXWT5NO3hH4eq7ckJ0axCU4xf02NcN0DiGI1AObY8U+S6pprOWfKgo45CL+k5bB4n22cpkiTZPOW82YNEuGCSTZeVrE2ie2FMy3vvGupIVggd/vcrALGGoiEQb9BHOiY1lupEEyrEmOJjSWflpAolXudha96AzMTA8VS/cqah55IJgEI1qfaqgskdD/LkS+P7tjFRbHq8lZN5QKyvl4hWUWH4OaByX/b9F7J3Hq1j7tK8l2JnWpEIPFJm3WEG9Qj9ATQJ+QA6slGMWuqWnSL1ZSIjcZyGR7sVFgxeWF69r0i6LGtqXbdOIhHesoGazT+RvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4reCEN7ecbEgIpt1IrZ8CYICCTF5ZzczkLGmKh2F4L4=;
 b=T23WKEVCq/Na2wjRCpTiuIPid3wo36yW7ZQ0NZ1OSyB6VBtTWucNxA6/qTRRcHHaTBTH96eILOYXXqjBaL4vxxSikXGZ7vBlaTFtmmxUWGtrhM79F+PRyt27PHVaEUj8q7EAMK94OHrEh4M/UnVRPAtTy7m7T0kyTczypFeKCV258/xmM3Ds9Uy1sg1NP1GC7z1+BgPohaqcmcudMcQnZRHPB98P8jPw8QJJbSq3b6QI9zQCIPgyeio9YzAwiHTWWB7a942G0A9P7Kp61xSlr3PeAJLvkyo1Cv+l4t/ye6ZCL9IKcbTAlGB1MW148keH0pYZ2PYwW1VhE+qdx4UHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4669.namprd11.prod.outlook.com (2603:10b6:806:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 17:26:35 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8e5a:470a:d7dd:a012]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8e5a:470a:d7dd:a012%6]) with mapi id 15.20.6455.027; Mon, 5 Jun 2023
 17:26:35 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Borislav Petkov <bp@alien8.de>
CC:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Jia He <justin.he@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] apei/ghes: correctly return NULL for
 ghes_get_devices()
Thread-Topic: [PATCH v2] apei/ghes: correctly return NULL for
 ghes_get_devices()
Thread-Index: AQHZio6JO3kuIV8ZKUOLpNekPi8JNa98jFaAgAADttA=
Date:   Mon, 5 Jun 2023 17:26:34 +0000
Message-ID: <SJ1PR11MB6083D48DECD2C43B5F1ED4EBFC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230519201249.31147-1-leoyang.li@nxp.com>
 <CAJZ5v0i1nspPuHuUoLsWOz7MLnnB8bv=cXYbFcv0a=okBxBg3w@mail.gmail.com>
In-Reply-To: <CAJZ5v0i1nspPuHuUoLsWOz7MLnnB8bv=cXYbFcv0a=okBxBg3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4669:EE_
x-ms-office365-filtering-correlation-id: 6a7f98d5-3f54-4152-4e00-08db65ea0303
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IPUTNSo/5DWLyCPQgHsEHK+G5bgJulwhvhk/LxqpFq34hCXb8fMqhsfr+PL1jHwrja0R/JFxEUPhAdrtP/B8rPqXGx+Qv6Ty0XlWX9J3loJJ1s7BM1o5OpDYKbGrvnatvMrJH07hAi0gskxigg9oBnrJ16uj3Hv7WCscwa5JxfF7G+JSF3Y0rPg3Lltk0AUiAEzUbEqXfb2+lAd3ofDPxItOfAkKzuQYgwbTn9qKyMo6PQNObCR8PILCTof5zsq31TVINFHK0clnPXY2RjL5co7NX4kSrBPSjecKE/xWEJ71RwmfVoMGFBVGYwDqh9ixTrprRz9OFnql7+/Mptrn8wGWwed3w/LBB7PrwoT9zAAXDzlds6cSZucykRwpmas/etMRQM1+IiLFsEvZjdy02Ymk7vxOvpBpRvvgkgtEtGpudmVtw9uJIho+IkIFzao11eOD4t7WSQd+VrEwABCNohzHAplVBl7RX7BGnPil9vuWJPRdItlVDDjZChoOQIrWR24NR4wgopMp0bPznM8yO3uc6mKGfvNd8PP1JcFElE3zG8fPgurBr97KJQnWZcirpQHRo9TcDx2+O1v3E2G81c0o3ye7PX6tTKKcw4woAUHpOyV2I6hBgzDI6W4TULjC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(4744005)(41300700001)(316002)(110136005)(54906003)(122000001)(82960400001)(52536014)(5660300002)(2906002)(8676002)(66446008)(4326008)(66946007)(64756008)(66476007)(66556008)(76116006)(8936002)(478600001)(71200400001)(38070700005)(7696005)(86362001)(186003)(38100700002)(55016003)(9686003)(33656002)(26005)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHAwREVDWDlyMDRmQnBoVk1vcW4vSEt2Z2FkdThibk8xS1BRbjVPK3d1TWdZ?=
 =?utf-8?B?TUNMOGRBV2xlVUl3SVFrb3ZvR2VYcVg3bExLSEt3ZFo3cDhkeWNwVDNhOHE2?=
 =?utf-8?B?YXVQN1JHaVNtRlYwby9MeHpmdGNUZG5mdFZ2S1JrM3pKanl3V3Jua2lLY2gx?=
 =?utf-8?B?blRlS2M0U3BCc0E0bEF5UDZ6MmRhOU12SVVFUTdDTWhVQU9UeDFaL0VqZ2Jq?=
 =?utf-8?B?M2NQK0taMkY1cjROTWphbDNDWXc3QXAzM3FaNU9laDExdnBhMlM1ZTFaeDdw?=
 =?utf-8?B?akR1b1dpWHpMZ2p0NldPR3dHa3A5SUd6RGcwU2xnc0tpN241VUlzbmxjMExu?=
 =?utf-8?B?MERkSU5FdmlJUlh5Z2ZEUVQwV1M0aGxYTCtGbmFkOEgxOW1iNXBZZUwzajI4?=
 =?utf-8?B?VDZxSlZvWUhZcm5SSHNrVzNoODNpei9QbldIUUJLeGhhYWl5VlEwUkwwZGls?=
 =?utf-8?B?MUltL0dZK3k4VFFiWkljRGl6UFpXc3Q1RkZ4bXcrYWhZeVgrdTVvUnhva1hT?=
 =?utf-8?B?UnhhZUhrT0dvWXpueEVKVENXRi9tVEVXd24wZGpOR05RSUU2Y2dYdm4vNVBk?=
 =?utf-8?B?VUhKTWo3VDhNV2cvbVBQMnFLdFMzK1RLV2VoTEJWNmJBWWFnTTE1MmpPK0xW?=
 =?utf-8?B?VnZHQ1BZVmVZV3VGOWlkZjJVQVA5QmI1RWhYTDJRWWNOSjh1bUx1MlpTckF1?=
 =?utf-8?B?UTRlcU1DRVMvVzZ1dFc5UGNBKzBPTGFTSDh5cEJQNzV2WFZHL3dXNXVnS1BN?=
 =?utf-8?B?U05tS0VmTHgyREhXcHV6dlVjQU9vM1JuYjE4V3lXeXdpQTNjc1JhSVY5TU9w?=
 =?utf-8?B?cEhiV3p2TzBLYWZqbC9rMmJIV1hCSmREcmlhTHhveHFaV3pyc1d5RzdxbVB3?=
 =?utf-8?B?M3hQalhteGhRN1V6Vlp2eXJHd1VJaWxtYUhjU0NrWTU1K212N1J4cy9xWEND?=
 =?utf-8?B?Q3NZZzNJQ0ZzV1NqeGpzKzc1SXpFcExEQ3RPYms5MXAwZGhuRklOa3hHSzRt?=
 =?utf-8?B?aUlzTFcxM3ZReERqZzhidGt5WWhxTDB2eFcwL3YxWVRtblR2MlVHemVvRHQw?=
 =?utf-8?B?WUoxQzllcjVUT2Z6bzFCRU54dEpzVFZKTXNuWVAzdUdFd1hOUjdWaEpjYVhL?=
 =?utf-8?B?VTR1TlpTMU1UYlFpczlpTEFGWHdvWGU3SStxZ0RFMm9mVUEzVkEzb2xKYzc0?=
 =?utf-8?B?TmpRazFaNjlVTStja0FVOTBzN2JtNVA2T3hiNDBOQ2FoVndWMW0yeFpJNGsw?=
 =?utf-8?B?ZGk4REUxa283S0t3V29QZTNqeG1OY0VuNTJBM2VpbEhob0FKV0R5eHI0a0o5?=
 =?utf-8?B?Q0QrRlJhS2JQY0FZM1lkd1JDNmtFRjZkZG54dXZmZWY3MUtBTUxyZDVXYzZT?=
 =?utf-8?B?RCsxNmlYY0tiVVViU1ljM0hTNUpLYUxnaEtuNmV3S3cwUE5XMGtaMjE5dmIw?=
 =?utf-8?B?dlZ1NGtTeVJYalVTT3MzeU1BcS8reHlSSk1KOVBVblJJNDBiVHV5ZXBQR25K?=
 =?utf-8?B?NlkwdlV2T2RtbHBHd3IxZFNzNDY5aHNCOTY5ZUR4RU9vZHFLZnlxcGFPZ0VG?=
 =?utf-8?B?VlpVeitrTk1HRFFLL1JkOVJNNkptRUxyT2cxbkxrUURTeFR6QzdhYjVMUmlS?=
 =?utf-8?B?NS9vOG9LL2t6QmRFWnBTcnptaUJzcVhRU3UrTlZ0UmdRQkp5SVVEVmZNRHZE?=
 =?utf-8?B?cDhLcW1jTVBEajAreEw5Q1hZWHZxdVhoRFF5NHlZbUo0Y253TXNZZ3Qza2dO?=
 =?utf-8?B?dk9MS1Y1KytUcjU0VzRuWFlhVG9RSjlsNkdIMmtVMmMyOXQ4QTVJWGJwK0J4?=
 =?utf-8?B?QnI1aEUyeHE0dzY4S3Z1VEhEOU5mOFBDMys1QmFVYVpiYUJiWG5Nd1pOWlpz?=
 =?utf-8?B?Q2p4NnBoZnlIL3RmQ2FlMkdJTXZ2QWFsUkI3RE9ML1ppVHdLMWdPdmVCWnlQ?=
 =?utf-8?B?WVBOT1pHV0Zra09ZNndWekt6Q0JiM0VtaXJXamlKcHgrMTV5ZktZdG11RlB2?=
 =?utf-8?B?bWNGM00vRmpCWGtCbForNFhrbjV0NHhsamNDKzc1RHhsalF3WEZ2eFZpVzlo?=
 =?utf-8?B?K3VVV0U3bGdCdTVTMXUxK2sxRzg2RlJweG9tWHVBcGxRNjRRQjduNkJBNEhE?=
 =?utf-8?Q?/SPY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7f98d5-3f54-4152-4e00-08db65ea0303
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 17:26:35.0160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLerJ+gKf9oKTfWD+IRzIbFc5SqmJ6m2Cyg1mm3+wA8C0CX9wD74cxSR7jO2kbbcKprCWeq4As5jhAqkYPe0kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4669
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

PiA+IFNpbmNlIDMxNWJhZGE2OTBlMCAoIkVEQUM6IENoZWNrIGZvciBHSEVTIHByZWZlcmVuY2Ug
aW4gdGhlDQo+ID4gY2hpcHNldC1zcGVjaWZpYyBFREFDIGRyaXZlcnMiKSwgdmVuZG9yIHNwZWNp
ZmljIEVEQUMgZHJpdmVyIHdpbGwgbm90DQo+ID4gcHJvYmUgY29ycmVjdGx5IHdoZW4gQ09ORklH
X0FDUElfQVBFSV9HSEVTIGlzIGVuYWJsZWQgYnV0IG5vIEdIRVMgZGV2aWNlDQo+ID4gaXMgcHJl
c2VudC4gIE1ha2UgZ2hlc19nZXRfZGV2aWNlcygpIHJldHVybiBOVUxMIHdoZW4gdGhlIEdIRVMg
ZGV2aWNlDQo+ID4gbGlzdCBpcyBlbXB0eSB0byBmaXggdGhlIHByb2JsZW0uDQo+ID4NCj4gPiBG
aXhlczogOTA1N2EzZjdhYzM2ICgiRURBQy9naGVzOiBQcmVwYXJlIHRvIG1ha2UgZ2hlc19lZGFj
IGEgcHJvcGVyIG1vZHVsZSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTGkgWWFuZyA8bGVveWFuZy5s
aUBueHAuY29tPg0KPiA+IENjOiBKaWEgSGUgPGp1c3Rpbi5oZUBhcm0uY29tPg0KPg0KPiBCb3Jp
cywgVG9ueSwgYW55IGNvbW1lbnRzPw0KDQpBbGwgb2YgdGhlIGNhbGxlcnMgYXJlIGV4cGVjdGlu
ZyBOVUxMIGZvciBhIGZhaWx1cmUsIG5vdCBhbiBlbXB0eSBsaXN0LiBTbyB0aGlzIGxvb2tzIE9L
IHRvIG1lLg0KDQpSZXZpZXdlZC1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0K
DQotVG9ueQ0K
