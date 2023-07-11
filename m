Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F5E74F486
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGKQKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjGKQKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:10:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53121710;
        Tue, 11 Jul 2023 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689091815; x=1720627815;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yNcDMMmfaAaHS/8TKTfHpQhkqlQcSazTUmVhQjAjLzE=;
  b=lzomjNwSKkFCKBwwfQUJ5+3ZBrz+yQpdVbbfZ0izjlH02ESXH7dVNe+b
   Qhmdrg7vTqPfSQs8b+OG3K658zRXxOtgUSlTWJUP2w6uaLSynfkhwtoSz
   BiBmvDlAU3RjFEa5EYtWUOL5xIllycIXmv139bEhl5EJ6S6dF/i8ehCgg
   MYk6rtJX5kndMVvISHcm0D75vJAUIvnlJc88Mdl2qSu/nzTqHvjG54c/v
   fQI/kmBTKXgdv7xkb87sG+NFNro/HBtrLYU4KtUi1C4AXmiQk6NxeF24D
   Cg9UHn8Lq6y/sXN5igZiYHs5dG7NyqShE5b4HS2ySGTIHD07uKfxPA+73
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="428357942"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="428357942"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 09:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="791255710"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="791255710"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jul 2023 09:06:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 09:06:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 09:06:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 09:06:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 09:06:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAfZSmSD985K+pGEV6dOsHJwxB+dZJw+CM+JWR75RoobV68WvMAHqLFNFQba/S1Gt23/Qa/Wi44iY5rcQgcwVYOBZxVk6Q3FXc1BslE8njkQRFXD1To5l8C7BfrLygbIdnA6TqAKCybD14OmhJlfcar5kaGX6uFTHw7CoFYKRWxzkr1AGBQaWYjk+ERhVLbegFpZnFq1SUDmf0fXIS0s8IiycHQmdF9u4FTmiTkAbkFkY4+UkqyvCY+JYDvs9AqBgOM2LAAPVwqSjED3rDVwkZtp7DIaoL0x46ixUjZ4A9AsoUpAsuedh6CmG4Kd061pd3CJ6I6zNiWMoGi+HXiZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNcDMMmfaAaHS/8TKTfHpQhkqlQcSazTUmVhQjAjLzE=;
 b=SjsDeEOGM7N1jCwQKIK9EsKrxyaX5764IwUBhCoZQYAjD8K7WokdSmmkNWhy5TcJOo95m09c2FNaWZ4tJzvEAGr8jAvDqtZ9X8TviSulavHGiyuDS3fEHbD3LwAfjAVHwh72thMItw4SH7s0THSXT6qQ6PDMBpb13c6zv2730IRAukwbPSN1s2mAWKhrDZI9CUDWdLL7gkuwAMtHIPAiNOjxtxEkgli+8uzhomUaxVXhpQUrbh5Mxn8zgfyK6Z9jIq5UrldJj4/+4/FQL+ECFT2FS2XC0jaF2XT7WpJr4OIiSeynajri3z8pxv2dwi0/FvqUGMQtLmshLdKJmndy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by MN2PR11MB4565.namprd11.prod.outlook.com (2603:10b6:208:26a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 16:06:50 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::f070:fc63:a1af:225c]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::f070:fc63:a1af:225c%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 16:06:50 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v3 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Topic: [PATCH v3 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Index: AQHZsJ+GtBl6cczhyEuBaINvpRsr96+ur5wAgAYSHmA=
Date:   Tue, 11 Jul 2023 16:06:50 +0000
Message-ID: <MWHPR11MB0048D02003AC21B36F297EF6A931A@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230707065318.18681-1-utkarsh.h.patel@intel.com>
 <20230707065318.18681-2-utkarsh.h.patel@intel.com>
 <CACeCKae0Vq2g9jq+69RodmJyDo7+tUEunp3JXS7vw1y7YVhzhw@mail.gmail.com>
In-Reply-To: <CACeCKae0Vq2g9jq+69RodmJyDo7+tUEunp3JXS7vw1y7YVhzhw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|MN2PR11MB4565:EE_
x-ms-office365-filtering-correlation-id: f208a1ef-2349-4093-f31c-08db8228d5ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X6ok+3I+M7CFA0WmX9fSVAs2mEu0YbInWD5KAp2gunsz5rPpkDWvE8jv77A0pTg3KlM/qkWyWTDvBxoDnpRFh2HYsXkK2fQ7GrHz8H8yfVmcpvsipYtHb+oZSX79cvbWPgVGJueWxZ5RJP1v6X22k1TArBrwrEu6OL0NamJ5tH0iCmC6fW1psWrppXXlNirqonUG2tQ+Lr638slFN16DfIWIaVPXUHqv6F8ayXbeDAwnyO0/DPQGmmc8si2746xAM6j4ntDjxoIH6sGJ4ibk3ysQj9CbHFIoaD4/QYJHmO3EK8Y63QRhFvaWN0sP6L2SVKOwGNJYsp4NUji0mVr6J9LzEFULGoOAa8jZ/9z1qM68nWeieDIgFrB91dxnCCvC3bgvabe73wzLmBhrSBViySJsRge863tjCB7IZlO3z9i3x6CLxuEI4kPqtNF1bstNgwEuHskDowAAAsMm9KUAwSHfTKix7sxKEOAWWnDuIE+mR22FI5jejvFZQR7nTPT3IKtvmySF/lpH2eL1YQwbdgotjOrdGYtZtcUc9FWxWDhych/dFB/ILBFlAifuTwBcLLCESLWz9RENrQrNryav9FJBwlOHcf7rW4ksl+IAUY9CKS/s9zzF4WR0i7HVcfzo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(66899021)(478600001)(7696005)(71200400001)(76116006)(54906003)(33656002)(86362001)(38070700005)(55016003)(2906002)(66946007)(186003)(6506007)(26005)(9686003)(64756008)(6916009)(122000001)(38100700002)(82960400001)(8676002)(316002)(5660300002)(4326008)(66476007)(41300700001)(66556008)(8936002)(66446008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHM4eFFPVG9uWHNXWmlmanJCbXRUQkYwRmNQUVhXbGl5MEg5SGVUakJWUVRL?=
 =?utf-8?B?QkVlYU0wM2JLR2JLbjMvYllISnNjUHJETCs5NjZPZDQ4RmovdUxKUXRkMW9K?=
 =?utf-8?B?cTZuWHAxR3NTeUxIUjVyU2NLbGUwQWVUcUM4cVJlcG5VYWlZbWVsb3BQMWpz?=
 =?utf-8?B?amMyOW0ybGlsME53bnp0aXd3dWdUMXZkV2wvMk13RjN3VGY4dFBjbnFHeWNC?=
 =?utf-8?B?STdOMTN2MzhGRnVtRUhJaThyNnltTG9YRFJyRmZNaU9jM0dqNURDVDc1c2Nr?=
 =?utf-8?B?K3B4aVhudTlmTFRobUZ4QmxMUE14SmZKSzFpZS92TW5HWitrbGxmTXhIOC9a?=
 =?utf-8?B?SlhyZUgzbGxPUjM4a3Btbk9lR3V2MzNhTUw2NVR4LzNZbXBsQW5FVC8xVmlU?=
 =?utf-8?B?Y1hIU04yNUNKZ3dHYUkzMzc3aWR5K1FySTlIQUlRM1ozSW5SMlQrRTJQWkVa?=
 =?utf-8?B?L0FOYzNJMnVrZHhlTnllYjR0MGV6S1MwQzY0UkxNblprNXZ3L0ZIL0hvTVpt?=
 =?utf-8?B?UmVVWWU2Y1krZnk4MWZsMFQ2ME5vMzBxT0J5LzZzbnBaSnRTMHdGUTd6QlN3?=
 =?utf-8?B?SmZic0RxNEFMSlc5bnVJRVp5czVwaTZ0Z3VCaHBuWGNIS1B5QTJvSmV5UTQr?=
 =?utf-8?B?UDI0dG80cE1DUXcvVDZKckJ4N1k1OUthYkNvQk93eS9lRjBhYXJLQ0Vrd1dw?=
 =?utf-8?B?TVpLZ1ZZMnAwM0xrTkpUQ3R2Z0ZwRE05NUVCaytMejdPTGpGRTZMZTE4enlz?=
 =?utf-8?B?WFJucGdzdjJOeVdsaGZtM1c2WnlIdVBGZXgzc0srN1pGMEFCVGxxL1UzbVM3?=
 =?utf-8?B?T0cwWkRJSk5pQWt3ZnRkM2NjZG41R1BtQ2VUSTJLQmxZKy95VlM0VVh3dGxJ?=
 =?utf-8?B?VVFJOHZuMDU1eWFmVkR1NllYUzBTTkE2a0trTXlKRkVoWnFCd1pBNG8zRDU5?=
 =?utf-8?B?ZTVZL01kQ2pINmoveTJjWkpadWFOenVSbUhEMk4rWG9RaHkvQ0xsUkM1R0pZ?=
 =?utf-8?B?WmRpOWw3L2NEK0pKcmErT2xsd1EyMEZ1OGtYN0RBYVBSUmNpWitiM3ZiTXFr?=
 =?utf-8?B?anE2Q2NZbW9aUzcxOGRzdktvQy9sUlBVTWQvUHhpZHRXZ0EwcEluNi9nbFRu?=
 =?utf-8?B?dVRZU0pBUUxHY3pIcmwvNTZmTFJmQVpUc3gxK1RGSE5odkNRWHd6N3RpVW9W?=
 =?utf-8?B?NUpnYUZ2K2o1MFphNUdvRHJ2Uk12QkMzWnNINEp4K0R5QTBQK081ZmNmZWZs?=
 =?utf-8?B?bVhOUEozclMxRUtEUS9sYkR2Q3lWVEltd1FESFhyRGVNQVlEbHRuUWxzWGts?=
 =?utf-8?B?VlJhL0ZLOTlFQ3VXWlV6YmxhNk1MS25PVGU3cGlXL2tWei8zVWozMWJqdkhE?=
 =?utf-8?B?djllTHFiUzEvL3pFTmRQSzhpVi9vajNhdVRVWVgwL3RFZ0Erc1dFNlZBdTJa?=
 =?utf-8?B?L0NkNG5IWUwwb09NVFF3REF2V1ZPbXJkaURWbTdOVzEwYWxIOE1iQ2FoRjFW?=
 =?utf-8?B?dDRsdENkWWh3a2FGOFZJUCtacTRTcG45QmU2YlU3d05GaUJQS1cxMGUvUjJM?=
 =?utf-8?B?RGpxdFYwK1dFRnpVL2ZjMWhmYjk4Qnd1c05YVGZUUi9MRm42bnczOFk4RWkw?=
 =?utf-8?B?cnpEYzNkS1JGTGdsVmJmQXVJVzNYcmlIMko1K29OMVNod3VmbytYUXUrZWor?=
 =?utf-8?B?cFdzT1FtQmFCWXo3a0xmTXM2cWREamgrcjhSZUdiNklWQzJLVVVDampmNEpw?=
 =?utf-8?B?alRUbFFqNGNoU1p2REZHblJlbjk5NXZDbnJTRTd3SWpJZ1ZyMStyY2hjeFVG?=
 =?utf-8?B?Yk5UQ0tIQzJWak5IYjFVU1lHT01wWWxYWklBeVg0Q1JMQitmWGxqMU5Qa0No?=
 =?utf-8?B?eHdlQ2hTcmkyNTRJZ2NEOHlsOHB3SE1pM0cwM0RvSXAxWWVyQ1B3bUpRYXBW?=
 =?utf-8?B?S2w2M0hZQU8vd3ljVm12Slh0YVhOVnRROE5kQUVKWDNpU2FDakpoTkZEenhN?=
 =?utf-8?B?SjhvUUVXM2kxUFl6YVpoTTU5aE1xTHNwWUQyVE1oTDU5Y0JoaU54UE5TZHRL?=
 =?utf-8?B?U2RNanI2cXcxZ0w0Rm9wOUV6MklMRzZ4a0FBNVVTSm1YeEZubDVlZzUraHNi?=
 =?utf-8?Q?JQeaTSRV2rv6wMmxMO3s9y74V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f208a1ef-2349-4093-f31c-08db8228d5ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 16:06:50.2384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tl9X7CuWE2fO0KCWU/I+jDesCkEsZ98WEJGri+snnHcM68lbzzeRlVdOc+y45muVVJkS/xZa1d6SNpPxGtDb63V20o9EKQg/RlsxC4F40XY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4565
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhc2hhbnQsDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4gDQoNCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wbGF0Zm9ybS9jaHJvbWUvY3Jvc19lY190eXBlYy5jDQo+ID4gYi9kcml2
ZXJzL3BsYXRmb3JtL2Nocm9tZS9jcm9zX2VjX3R5cGVjLmMNCj4gPiBpbmRleCAyNWY5NzY3YzI4
ZTguLjBlYTA4NWZlYzU1YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL2Nocm9t
ZS9jcm9zX2VjX3R5cGVjLmMNCj4gPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL2Nocm9tZS9jcm9z
X2VjX3R5cGVjLmMNCj4gPiBAQCAtNDA2LDYgKzQwNiwyMCBAQCBzdGF0aWMgaW50IGNyb3NfdHlw
ZWNfdXNiX3NhZmVfc3RhdGUoc3RydWN0DQo+IGNyb3NfdHlwZWNfcG9ydCAqcG9ydCkNCj4gPiAg
ICAgICAgIHJldHVybiByZXQ7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IGNyb3NfdHlw
ZWNfZ2V0X2NhYmxlX3ZkbyhzdHJ1Y3QgY3Jvc190eXBlY19wb3J0ICpwb3J0LCB1MTYNCj4gPiAr
c3ZpZCkNCj4gUmV0dXJuIHR5cGUgc2hvdWxkIGJlIHUzMi4NCj4gQWxzbywgc2luY2UgeW91J3Jl
IG5vdCB1c2luZyBjb21tb24gcmV0dXJuIHBhdHRlcm5zICgtdmUgcmV0dXJuIHZhbHVlKSwNCj4g
cGxlYXNlIGFkZCBhIGtlcm5lbCBkb2MgY29tbWVudCBzcGVjaWZ5aW5nIHdoYXQgdGhlIHJldHVy
biB2YWx1ZSBob2xkcyAoIjANCj4gaWYgVkRPIGlzIG5vdCBmb3VuZCIgZXRjLikNCg0KQWNrLg0K
DQo+IA0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkID0gJnBvcnQt
PnBsdWdfbW9kZV9saXN0Ow0KPiA+ICsgICAgICAgc3RydWN0IGNyb3NfdHlwZWNfYWx0bW9kZV9u
b2RlICpub2RlOw0KPiA+ICsgICAgICAgaW50IHJldCA9IDA7DQo+ID4gKw0KPiA+ICsgICAgICAg
bGlzdF9mb3JfZWFjaF9lbnRyeShub2RlLCBoZWFkLCBsaXN0KSB7DQo+ID4gKyAgICAgICAgICAg
ICAgIGlmIChub2RlLT5hbW9kZS0+c3ZpZCA9PSBzdmlkKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiBub2RlLT5hbW9kZS0+dmRvOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4g
PiArICAgICAgIHJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIFNw
b29mIHRoZSBWRE9zIHRoYXQgd2VyZSBsaWtlbHkgY29tbXVuaWNhdGVkIGJ5IHRoZSBwYXJ0bmVy
IGZvciBUQlQNCj4gYWx0DQo+ID4gICAqIG1vZGUuDQo+ID4gQEAgLTQxNiw2ICs0MzAsNyBAQCBz
dGF0aWMgaW50IGNyb3NfdHlwZWNfZW5hYmxlX3RidChzdHJ1Y3QNCj4gPiBjcm9zX3R5cGVjX2Rh
dGEgKnR5cGVjLCAgew0KPiA+ICAgICAgICAgc3RydWN0IGNyb3NfdHlwZWNfcG9ydCAqcG9ydCA9
IHR5cGVjLT5wb3J0c1twb3J0X251bV07DQo+ID4gICAgICAgICBzdHJ1Y3QgdHlwZWNfdGh1bmRl
cmJvbHRfZGF0YSBkYXRhOw0KPiA+ICsgICAgICAgdTMyIGNhYmxlX3ZkbzsNCj4gSWYgd2UncmUg
dXNpbmcgdGhpcyBpbiBvbmx5IDEgcGxhY2UsIHdlIGNhbiBqdXN0IGlubGluZSBpdCBjb21wbGV0
ZWx5Og0KPiAgICAgICAgICAgZGF0YS5jYWJsZV9tb2RlIHw9IGNyb3NfdHlwZWNfZ2V0X2NhYmxl
X3Zkbyhwb3J0LA0KPiBVU0JfVFlQRUNfVEJUX1NJRCk7DQo+IA0KDQpBY2suDQoNCj4gPiAgICAg
ICAgIGludCByZXQ7DQo+ID4NCj4gPiAgICAgICAgIGlmICh0eXBlYy0+cGRfY3RybF92ZXIgPCAy
KSB7DQo+ID4gQEAgLTQzMiw2ICs0NDcsMTAgQEAgc3RhdGljIGludCBjcm9zX3R5cGVjX2VuYWJs
ZV90YnQoc3RydWN0DQo+ID4gY3Jvc190eXBlY19kYXRhICp0eXBlYywNCj4gPg0KPiA+ICAgICAg
ICAgLyogQ2FibGUgRGlzY292ZXIgTW9kZSBWRE8gKi8NCj4gPiAgICAgICAgIGRhdGEuY2FibGVf
bW9kZSA9IFRCVF9NT0RFOw0KPiA+ICsNCj4gPiArICAgICAgIGNhYmxlX3ZkbyA9IGNyb3NfdHlw
ZWNfZ2V0X2NhYmxlX3Zkbyhwb3J0LCBVU0JfVFlQRUNfVEJUX1NJRCk7DQo+ID4gKyAgICAgICBk
YXRhLmNhYmxlX21vZGUgfD0gY2FibGVfdmRvOw0KPiA+ICsNCj4gPiAgICAgICAgIGRhdGEuY2Fi
bGVfbW9kZSB8PSBUQlRfU0VUX0NBQkxFX1NQRUVEKHBkX2N0cmwtPmNhYmxlX3NwZWVkKTsNCj4g
Pg0KPiA+ICAgICAgICAgaWYgKHBkX2N0cmwtPmNvbnRyb2xfZmxhZ3MgJiBVU0JfUERfQ1RSTF9P
UFRJQ0FMX0NBQkxFKSBAQA0KPiA+IC01MTMsMTcgKzUzMiwyMiBAQCBzdGF0aWMgaW50IGNyb3Nf
dHlwZWNfZW5hYmxlX3VzYjQoc3RydWN0DQo+ID4gY3Jvc190eXBlY19kYXRhICp0eXBlYywgIHsN
Cj4gPiAgICAgICAgIHN0cnVjdCBjcm9zX3R5cGVjX3BvcnQgKnBvcnQgPSB0eXBlYy0+cG9ydHNb
cG9ydF9udW1dOw0KPiA+ICAgICAgICAgc3RydWN0IGVudGVyX3VzYl9kYXRhIGRhdGE7DQo+ID4g
KyAgICAgICB1MzIgY2FibGVfdmRvOw0KPiA+DQo+ID4gICAgICAgICBkYXRhLmV1ZG8gPSBFVURP
X1VTQl9NT0RFX1VTQjQgPDwgRVVET19VU0JfTU9ERV9TSElGVDsNCj4gPg0KPiA+ICsgICAgICAg
Y2FibGVfdmRvID0gY3Jvc190eXBlY19nZXRfY2FibGVfdmRvKHBvcnQsIFVTQl9UWVBFQ19UQlRf
U0lEKTsNCj4gDQo+IFNhbWUgZGVhbCBoZXJlLCBpZiB3ZSdyZSBvbmx5IHVzaW5nIHRoaXMgdmFy
aWFibGUgaW4gb25lIHBsYWNlLCBqdXN0IGlubGluZSB0aGUNCj4gY2FsbCBpbnNpZGUgdGhlIGVs
c2UgaWYoKSBzdGF0ZW1lbnQuDQo+IA0KDQpBY2suIA0KDQoNClNpbmNlcmVseSwNClV0a2Fyc2gg
UGF0ZWwuIA0K
