Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B465F6CFACD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 07:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjC3FhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 01:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjC3FhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 01:37:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6244558D;
        Wed, 29 Mar 2023 22:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680154622; x=1711690622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lpuYsrGkgbBGBtQrbP5sCLf/w4rs/RKmi2M7qTfWXhY=;
  b=SdGRFZOm7uNoyuD2nA2NEQM94/LzKVeMxtbS+HROP70xO80P19jUR9S2
   2Q3aVcb+Bkm1HfySwMRr1jHPmiM2x5aYaBz95YPV60qLqB4Um7IgMBV6L
   Kjo0jG6wTe1poSjxn6aviUCymflf6P23tcGNcHn0gpbvKaNziXk3hBaaG
   H7CKArdK6o5JsR9RlSD6LWpyj5+UQ8pHJATKUKo8CTARBOrai639ljnUB
   4ZdyNnTQSkF3UFHmuErT5zY5S5kyNZMRn+3qJMhIA9joKQZaNp253De/c
   ifM5u4tI6nS7SLdJGaYGaTm/b9d3pPJ+SJm405uedfPBy3ZbB+N7jQGop
   w==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673938800"; 
   d="scan'208";a="218633958"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2023 22:37:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 22:37:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 22:37:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePQNUYRb9rwOztDLpikH1ZXOsvzq3CFZc8MBOPVJ2RcHZ0GUlnMIgHgORd9NRCicmeALM8SDvCGYNSic1WMLai5Vfw5xReGwT3o2+CWZTNMgnusMTQ7IZgLypuud8aJqJheY+bAJEoknDkDr1EJAv0gnaOsWOxukMJ1fNzyMVSOnqihB+VnMl8eObuieFGRvL1zQYOQUs+Fev4gzs823zMNvCKPw7Pi5DgaCB6Efs3JU25vb02XVPjXEMPWQtWzOxGD1MNFB/+64mNiNdXKDKG5ODy0QgCGZJEj30k28KwumOyITBJ8ltcEL9Vs9Ki0i6jzkr9hIU/EV+BwMrb4TVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpuYsrGkgbBGBtQrbP5sCLf/w4rs/RKmi2M7qTfWXhY=;
 b=Zcz0QV/GOLvJ6ChXro504e0usPpPCUuEkMuIMZLlsV4xHm54Vbw/kjp4UVZuC3DxDu0lQEj/8PWwajJoFJq5JIz3dNRYcTVrqqk/HsDF7jUZObaKloBS8S7fVqi52V6b+NPSMvw8GP/0dPtSLAQc5/sVoIcZFMD5VkmoPrNOF/3avHsB567yZx8iThG5fooXTueXrDNIYc6GQlV56mzyo+MJQl7UBkkmU4zXaYft/80fFefQZgZ7dIZTOjuArw6agFp1np2nmSiLdkevVHz7ery9Wik8eKM8yW63ft3tdAN+maZARwCGLI0JM3RRWFMVyET3KHiMzmJpHYK4IUVIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpuYsrGkgbBGBtQrbP5sCLf/w4rs/RKmi2M7qTfWXhY=;
 b=CYtKPAUwy1uCNxVTuOavHEcrP0KxTF+PNfU0SQQaz71RwB1ZLLq/4Yvca4KLZvPmR5PgckyAGhvRWO/+HMPFvNFP30H9ioSM1YjSzlpUuehC6UjOL81pLuZfPsXvmmhjt9AmRn+BAfftTykVTL4cQyDNPVJwZeddPzhFcOn6ZvE=
Received: from MN0PR11MB6232.namprd11.prod.outlook.com (2603:10b6:208:3c3::7)
 by DM4PR11MB5437.namprd11.prod.outlook.com (2603:10b6:5:398::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 05:37:00 +0000
Received: from MN0PR11MB6232.namprd11.prod.outlook.com
 ([fe80::5939:1be9:fdb0:d5c]) by MN0PR11MB6232.namprd11.prod.outlook.com
 ([fe80::5939:1be9:fdb0:d5c%6]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 05:37:00 +0000
From:   <VaibhaavRam.TL@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <arnd@arndb.de>,
        <Tharunkumar.Pasumarthi@microchip.com>
Subject: Re: [PATCH v8 char-misc-next 5/5] misc: microchip: pci1xxxx: Add
 documentation for sysfs bin attributes
Thread-Topic: [PATCH v8 char-misc-next 5/5] misc: microchip: pci1xxxx: Add
 documentation for sysfs bin attributes
Thread-Index: AQHZYYNnaDTu/bzl90iSK5hISFywcq8RiEkAgAFIEQA=
Date:   Thu, 30 Mar 2023 05:37:00 +0000
Message-ID: <225b45e405801d3756588580d9f325c58c769fc6.camel@microchip.com>
References: <20230328144008.4113-1-vaibhaavram.tl@microchip.com>
         <20230328144008.4113-6-vaibhaavram.tl@microchip.com>
         <ZCQM2hymNEneoSTa@kroah.com>
In-Reply-To: <ZCQM2hymNEneoSTa@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6232:EE_|DM4PR11MB5437:EE_
x-ms-office365-filtering-correlation-id: 96317051-bff9-400d-9322-08db30e0c8b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0KX9gQmwMHsZD9R4W9LTmvyR8uZTozRilZm/n2Xcy4RKmxlVUsSQMTVnIfZ1Og//yXt305l94Ymu5KbelYzmTDWNM2AWQgBQ+j3pMiI+ARCD6Lu/0ZCAuw2C1MVWcnNa86CiQYiIiFtaA63/MrCjWUQY8UgwLpnCezTDVH3BnCjhe4lWMQ4T0+12+7LSu9OVXADZ6dLTihP5uXkdNqemOAO0XhkZlo28LvhbIhh8tyenJB7iqfoq0LzulV8+ohnFVyx4aTk358mhOgGnTeEPKP7I3phDrT8WlaxdewmJt7Sf1O+sqear0JmcwLoX0AzdCHA+Q5pMkVNOJkQeOrWx8eL+uxUm3GLiD+y28xyvQ1jC3eeIrJMAhOaxjoF/V7Gw7vW00rGht1EssMAMKbyje7FVXkmCeaLa4QfR7LsX2ta5P8jyxmOdYh90Y2Qt+GlTzIkiXyzDM9yOdygIRp7JY+FnDQ1kbUz8HCSxgUwhAZMO/yOQ4w7h8/Y/VvK4S22No/BOJn4o73y/Rv8iYiP9HbbQtd+9L2rakquvEjFdELqLO/30RKjHvv3C85+0oD6djUtDNzrA1tbaU5tG1WKLr3FqI8X4bNyTHWsVfAnogUqD4J9TOOmu01OJD723LhKAmkxBiXt4qzDDDv2oKYsVDkpDsFnfE7wABcXiIwDAteUdm8hYYl2aRk4b7am3+V6QalHNeYR1nfSneXJnOo8twA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6232.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(8936002)(26005)(54906003)(5660300002)(83380400001)(2616005)(66446008)(64756008)(186003)(122000001)(66476007)(86362001)(38100700002)(66556008)(6916009)(8676002)(4326008)(76116006)(41300700001)(66946007)(36756003)(6486002)(316002)(107886003)(6506007)(91956017)(478600001)(38070700005)(6512007)(71200400001)(2906002)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFkrUWtNY2NUK2Vtdm4vdVBRc0E2a3c3Tk5pYXVmOEQzZGJqRDQvQ21mSDhW?=
 =?utf-8?B?SGc5d2FMeFlTUkxsQXJHTVBobHlkSXFETlpkWmhMUnI2WHRUWHFrYjMvdnhr?=
 =?utf-8?B?Z0xOU2xOajk1dGt1eGFaVk82bkFBdVNuNUhybGFJRWsyUVVYSVFnb1pMMXBa?=
 =?utf-8?B?UnZxTytIN2ZzdVoxYUV4bm8rYXdkVnpSQUM3UGhOZTJleW5rOTMrNWRZWkY4?=
 =?utf-8?B?eThMZ3FsOEg2WXRKMVo4aFlVcVg5eFpLWGFzVWpQZWkwaitkY1RLbVNwNVhH?=
 =?utf-8?B?TzgrTGxKMlBoRnViaXlsV3Z2bE5iYWZ4TzFTRTRmVG4zbGhJWGJzVERoQk1K?=
 =?utf-8?B?ai9lUENFZ2d1NWlsanhUV0V6a0I1MmdOckgrazBhT2x1dGp4WU9mNFUyMmRh?=
 =?utf-8?B?a0NvM2o5b0FLdndvdmpCYm8rTHB4YmpBOEM0TXlCakhPdEd6VVpLcFlaN2xu?=
 =?utf-8?B?ZWd0eUpJaDdzaG0yNjFaREVsc0hZbTI0am96aUxxbmw1OUpHR3RCVGdMN2or?=
 =?utf-8?B?M1pCYVl6U3cvZEVZSGowVUw5QnIxcUtEK3BKcndRRkxma0xqdU42cTZ2cUcv?=
 =?utf-8?B?VUVxSzRiaXJkc3Z0WHFWQ2x6Um1Nd243ZUxmYWl1T2txaU4zMURnalJ5TGh3?=
 =?utf-8?B?b1V3L3c1bUtSS055dVh1cWZ2RmtZVEo3YTJnbnBuNGFYRk1KTjdENENvRHdK?=
 =?utf-8?B?TUMxTVlxRDI1RFhwa1Q5eU5JNi9XUE5xMjQrRXpqVjlRWHJ3SGh3TXlZOERT?=
 =?utf-8?B?VU1paktUNlNyVjJTaDlOOVkzUjMrRFNpM010S243WGZWTGc0K0hDMU16akg0?=
 =?utf-8?B?cDI3OVU2UXNQSGxpV3BKNFFaRXlaWDhxTEc2K2ZZL29CeW11Q0MraXIxZ3NR?=
 =?utf-8?B?V0ZmNFhKZTRKRzRnNEZNVWUxRFJuY0hFQmV4bHZ5c1NndzVGd2I1NEo2UW0v?=
 =?utf-8?B?dTR3V0Z2TXVUTXVVS2NndnlzR3FlcDllbStQUGI0dWhBOWFadWpheDRsNGpC?=
 =?utf-8?B?Z0c3NUdhRkttQi9sSytBOEEybVpaNm1SbnV4d2dhVUlxeERLS05qeG92ZGIw?=
 =?utf-8?B?VkVQVHRueHJwTjdJbmhqdGJBY0IrWDRtWkFFeHBxTnFoeENZOUVnOUpPcWxT?=
 =?utf-8?B?NTRsK2NiQmZuMTNoMmcrR3hBblhGVmhnZzVLOUx3eWhRWVV3K0FaWVc2eGpq?=
 =?utf-8?B?RFAydkV3SkUrVFN1UnlRMXN3eVhiVTRNRTFqV05Lc0lwVFQ5VXg3U3F6QW5w?=
 =?utf-8?B?bUlkakhSSnJZazRYOUNOY2kzMjU5bXN1MTVGT0FvWU1FUUdCYlZtS3hsTmxu?=
 =?utf-8?B?dDVSL2FoVGdpN250Z0dPZVlCZXdxQmFrOEFrNWNLR0w2OVR1WGhuUm9uN0ZE?=
 =?utf-8?B?M0hmSEtkOFprbXhFeWFadkovMjBEM09PeGI0QzFRRGUrRVJnYkVSSFA4UFNB?=
 =?utf-8?B?VEpIU0p4RzFtZTNkZ3lCTVpWTStlWnVVbk1aOXFKbXNuODVOMldHQUNFN1R6?=
 =?utf-8?B?ZCtFY0hIMktMKy9NKzhPM2JQWCtqM1VmREUwcHNER1dDNC9DWVhrQXVTNTFp?=
 =?utf-8?B?RHdicTFjSEtkSHNickMyM3FtN3NhZ0s2L1QyNUEwMlFXdmhxQTFPcFlRUlJV?=
 =?utf-8?B?SHFZYmY1cy9Laklna3ljK3FtdWtmZGQyQmtEUDFxVEx2M0I3ZUE3UmJwR3Fi?=
 =?utf-8?B?Y2tuQWtqdlJndFA4WmREYnp0TTdNK3FJemVKSGhJWTVkOUw0ci9EK2RkS00x?=
 =?utf-8?B?Q0hCZHphM1E3MlRQeSt2Tzk3ZjFxdmpWQXZ4dHhtYlNLLzRWdmt0ZlNHYmRV?=
 =?utf-8?B?djBveFB2WFMvbEZrNENIMEZFOXVZSmJxNlNrcENFblkxTU5yWWRNTERacTdN?=
 =?utf-8?B?V2YxWElEV1BrSUxERjdlYWZHVXExb3NmVmV4TFN5TUZjUXZLWWdUVmNmR2hx?=
 =?utf-8?B?RVJrSlBaVkJ4Y1VKMktOUHpQRGh4SkR0UXNBeHhsZkFQQ2ZvbUh0dWdYZ2Uw?=
 =?utf-8?B?eG53V0pvTm9jQmZMU1VldUdnN2VqOVdOcFhNSmczc0k2WHRiR3JjNmRia1Za?=
 =?utf-8?B?Tm5jV0pKWnNZRGZTNjA4elJqVVJpWjRvQXZXbHlRRzhFVzd4RUdsOTBKaDVv?=
 =?utf-8?B?VkR5c2doOHgvOUo1SDJwSW5HblJYMENtYW5sTnZrQkR0MkRWL3M5dlo2Mlpn?=
 =?utf-8?Q?6egQPZAig2s3jvQ44S8IFnk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8798CB954AEB7C4581D100E368FCF570@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6232.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96317051-bff9-400d-9322-08db30e0c8b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 05:37:00.0504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Z8kO+cAMvjDUEdhaTLdXSonDSOytvkT0RcKZTDWSO4L6IeTgksrPSUeSqdubXXibmt0wuntFcz+Knkghu14DAEwQuLYygpxVKmGT+cKue8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5437
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTI5IGF0IDEyOjAzICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgTWFyIDI4LCAy
MDIzIGF0IDA4OjEwOjA4UE0gKzA1MzAsIFZhaWJoYWF2IFJhbSBULkwgd3JvdGU6DQo+ID4gRnJv
bTogS3VtYXJhdmVsIFRoaWFnYXJhamFuIDxrdW1hcmF2ZWwudGhpYWdhcmFqYW5AbWljcm9jaGlw
LmNvbT4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIGNvbnRhaW5zIERvY3VtZW50YXRpb24gZm9yIE1p
Y3JvY2hpcCBQQ0kxWFhYWCBPVFAvRUVQUk9NDQo+ID4gc3lzZnMNCj4gPiBiaW4gYXR0cmlidXRl
cy4NCj4gPiANCj4gPiBDby1kZXZlbG9wZWQtYnk6IFRoYXJ1biBLdW1hciBQDQo+ID4gPHRoYXJ1
bmt1bWFyLnBhc3VtYXJ0aGlAbWljcm9jaGlwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaGFy
dW4gS3VtYXIgUA0KPiA+IDx0aGFydW5rdW1hci5wYXN1bWFydGhpQG1pY3JvY2hpcC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogS3VtYXJhdmVsIFRoaWFnYXJhamFuDQo+ID4gPGt1bWFyYXZlbC50
aGlhZ2FyYWphbkBtaWNyb2NoaXAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZhaWJoYWF2IFJh
bSBULkwgPHZhaWJoYWF2cmFtLnRsQG1pY3JvY2hpcC5jb20+DQo+ID4gLS0tDQo+ID4gwqBEb2N1
bWVudGF0aW9uL0FCSS9zdGFibGUvc3lzZnMtZGV2aWNlcy1tY2hwLXBjaTF4eHh4IHwgMTENCj4g
PiArKysrKysrKysrKw0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4g
PiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL0FCSS9zdGFibGUvc3lzZnMtZGV2
aWNlcy1tY2hwLQ0KPiA+IHBjaTF4eHh4DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vQUJJL3N0YWJsZS9zeXNmcy1kZXZpY2VzLW1jaHAtcGNpMXh4eHgNCj4gPiBiL0RvY3Vt
ZW50YXRpb24vQUJJL3N0YWJsZS9zeXNmcy1kZXZpY2VzLW1jaHAtcGNpMXh4eHgNCj4gPiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMDkxM2M3YjAxOTkwDQo+
ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vQUJJL3N0YWJsZS9zeXNm
cy1kZXZpY2VzLW1jaHAtcGNpMXh4eHgNCj4gPiBAQCAtMCwwICsxLDExIEBADQo+ID4gK1doYXQ6
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+ID4gL3N5cy9kZXZpY2VzL3BjaVhYWFg6
WFgvWFhYWDpYWDpYWC5YLy4uL21jaHBfcGNpMXh4eHhfZ3AuZ3Bfb3RwX2UycA0KPiA+IC5uL3Bj
aTF4eHh4X2VlcHJvbQ0KPiA+ICtEYXRlOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBN
YXJjaCAyNywgMjAyMw0KPiA+ICtLZXJuZWxWZXJzaW9uOsKgwqDCoMKgwqDCoCA2LjMNCj4gPiAr
Q29udGFjdDrCoMKgwqDCoCBWYWliaGFhdiBSYW0gVC5MIDx2YWliaGFhdnJhbS50bEBtaWNyb2No
aXAuY29tPg0KPiA+ICtEZXNjcmlwdGlvbjogVGhpcyBiaW4gZmlsZSBpcyB1c2VkIGZvciB3cml0
aW5nIGludG8gYW5kIHJlYWRpbmcNCj4gPiBmcm9tIE1pY3JvY2hpcCBQQ0kxWFhYWCBFRVBST00N
Cj4gDQo+ICJiaW4iP8KgIFVzZXJzcGFjZSBkb2Vzbid0IGtub3cgd2hhdCB0aGF0IG1lYW5zLg0K
Q2FuIEkgcmVwbGFjZSB3aXRoICJmaWxlcyI/DQo+IA0KPiBCdXQgYWdhaW4sIHdoeSBjYW4ndCB5
b3UgdXNlIHRoZSBlZXByb20gYXBpIGluc3RlYWQ/DQpUaGlzIGlzIGV4cGxhaW5lZCBpbiBvdGhl
ciByZXBsaWVzIC0gdGhpcyBlZXByb20vb3RwIGlzIG5vdCBhY2Nlc3NpYmxlDQp0aHJvdWdoIGFu
eSBpMmMvU1BJIGJ1cyBhdmFpbGFibGUgdG8ga2VybmVsLg0KDQoNClRoYW5rIFlvdS4NCg0KUmVn
YXJkcywNClZhaWJoYWF2IFJhbQ0K
