Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6145F044E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiI3FwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI3Fv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:51:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2312E402FD;
        Thu, 29 Sep 2022 22:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664517115; x=1696053115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=psibXSKg8TI6/HVAhoBRS+KaLCfz5eP88zN1pz16360=;
  b=RWfVpNYOlUPGQQuI8Qh0F+WRKYATmykuewmrWCcfRxiXg1GBEFmA7I+1
   E0M9apjn4vJNs2NSPteMiepYzNBJDP33Y5Lb2Y519XjmdUQ36W3OYpEXe
   NCQZJLGhfaRtuTK0N3TsRNs8vAhdkKpTib9Lhu3DddAzLXXCyCeBLVvhK
   XKVKi4j5W4f+naBneav0KYpaAnJgfrR6erqEJzC6wof5smY60Gv7Zbt+N
   9WJPxuQCVq+O5dqbPXjM4BSGCFFqLZbCNKStqe6zbOtOoTA0bHJSObxbO
   uT0s466AlxRHZf3GRY5FwwJCM1JXvfZEKBZzj6niarsNRaMtduo07Dyn0
   g==;
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="182737982"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2022 22:51:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 29 Sep 2022 22:51:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 29 Sep 2022 22:51:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9kLnLNq+CHqw2hUp+B3EKjydsRWIP6BmU+FHAMFIBicACslaLmnlp8hvxsp425ZX5RBC3ccndCTIX+pu55eskXvFJow9wWxcIPq39e7Zi2e6DSqf0f+YhWuMdjUkfA6CI+WX8CZ0mcJWe08VmlU8gPov+FQK21cbDWO4R9UQ16BflvN8YtqdW1aB82tPeirrqk+8DhqMjDTPsmf3pdNPk8bMp+Ccb4/zasWx/SG/fTrnbk10oROZ3m8Sm2UXUFQSNKYKWRHCWQgYjp8wV2g9zT4drlnkWQxvmTdP9FcMtM+Jl417EvBC1CoHFpfl3VWXuveM+KU4SufZkYZUeycPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psibXSKg8TI6/HVAhoBRS+KaLCfz5eP88zN1pz16360=;
 b=Xk43tOPJuXwCLKEhCp1Fp0NGtPax2AF6zKweUexKegLs8/4lU6bGGoUvlwIFIJ1eotfCiItqXSMbycus1zMDgYynXvsCEYwPeeUW6MgbULJDnz4C9b7pJg7WwwhXh0muSZ2eSO6JtDNdWjxQiyho+5gcym6YOql/0qCv1fRoEj9Bf0nKYCnVuj0kKow0asFjILnoIvqhHHHUtf71qJOzPARgGsIBQ+T7rIW69TK8xA9lAH9C9vq233LkOFq3ciGM3V+wXseKGCnrDMAV4u86XcS19UbOq9ki1ityRSfcEV17xpH0a+01OxkCsOhH32LGGtsEApAEv3Ju6HC7u0DY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psibXSKg8TI6/HVAhoBRS+KaLCfz5eP88zN1pz16360=;
 b=cb1qn0uMo8Tk7/ZdmvZJrAJnehU6fCpOY8YiHQaiZ1fSFo3GilL197n8YSb9KkIRGfA224GRMssWxeoes+kHWHH52nU0L812S8lxD69OurI3e8tBsOEFy8e0CYqqKmARJYqx3UZjvqKMkCASGR+NMaBN/jdyBs3gNE0UI8ePJ6g=
Received: from PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5)
 by MW4PR11MB7030.namprd11.prod.outlook.com (2603:10b6:303:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18; Fri, 30 Sep
 2022 05:51:51 +0000
Received: from PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::3c5c:7050:7ea3:6ac]) by PH0PR11MB5096.namprd11.prod.outlook.com
 ([fe80::3c5c:7050:7ea3:6ac%7]) with mapi id 15.20.5676.017; Fri, 30 Sep 2022
 05:51:51 +0000
From:   <Tharunkumar.Pasumarthi@microchip.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH RFC SPI for-next 1/2] spi: microchip: pci1xxxx: Add driver
 for SPI controller of PCI1XXXX PCIe switch
Thread-Topic: [PATCH RFC SPI for-next 1/2] spi: microchip: pci1xxxx: Add
 driver for SPI controller of PCI1XXXX PCIe switch
Thread-Index: AQHY0uyAGN1yRfpf+UG4ZwTBhjMwxq30tJcAgALHeYA=
Date:   Fri, 30 Sep 2022 05:51:51 +0000
Message-ID: <5febd5014483d49b445a16853a2ead3e973265e0.camel@microchip.com>
References: <20220928034336.2939265-1-tharunkumar.pasumarthi@microchip.com>
         <20220928034336.2939265-2-tharunkumar.pasumarthi@microchip.com>
         <YzQvgmE9Hubx9mxN@sirena.org.uk>
In-Reply-To: <YzQvgmE9Hubx9mxN@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5096:EE_|MW4PR11MB7030:EE_
x-ms-office365-filtering-correlation-id: e74d7d99-2234-4421-ce88-08daa2a7df22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sSVL8/oZc14kn4KwCN3OrsSd760vS7dMzwYXZoYB78Bs33+ad3GNs6AHrcEeqCVQpne3PC4TJ4820qSR39yoKfjqXbMF0/6dDcGXuBvP3JcwVdvwJjAhjkkmYMHa+TNev73jZXfj8TdictSZYZrBnJCDNhHedzxNrzLJaCxyEWHoX7CmDMSDiutd/qsqgehlSVTmbizveqcyBpdXVRHb+GMwzwDh4l00Eyco+PamWlyqk7NQJVH0/LJsbyZm5xc3/FaIFu7M6jFBHKnwuNN59h03eEShYDJoR+JooIyWoMb6Sbw8JBXdKoh/HdHvqesI0Dxhanqc2ReW3yHhwMQFQTirP5cxCEPerZmlBuinwdova7kf/6fcDK+q0RqCNaoh1jdVJs1HlHm4m++d8k1u6IDi4/mFCgzjev8lP1Td7esLj3n4CXBKA9zPe2vHcvQQxdhnMufxpepmrQV22YO0Yj1uKFxP3lbbHolr+idA+3BElDjwdLLYANDrhpjxCvhrj8Ur9W0ssnfpFmcd69bW+IGlUa6q4k5Gsel7Qt924pg/BZwgLlu03XhTpOr3J84mh7TCRS9hwzOA5/Jgmnzc/8ZIdQKPeBlVzEXMvV0Fpw8vXKqD/CtUGS/rcphSNbYCfNR4wUIqSi8NBozn1niPpELG+cLBy7jFFX9uWyjvjQAsxjY6/qGR0mT2qT/k/N48iDMPOmlL9ASS2y5rRJwK+nAhl8OwteVI4wqk+2EhxoAdzMDYSnpDeXu7YXblyviRF6Rh8XxrB6zw98mK+URT8WawYDsjf3t3KOFcDrS65KA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(66556008)(66446008)(71200400001)(76116006)(4326008)(5660300002)(6916009)(8936002)(41300700001)(8676002)(91956017)(66476007)(6486002)(83380400001)(66946007)(54906003)(64756008)(186003)(478600001)(316002)(6506007)(107886003)(26005)(36756003)(2616005)(2906002)(6512007)(86362001)(38100700002)(38070700005)(122000001)(4744005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0hOdE02VFJGVFV4cHZ1MkdYMzNSNmI1ZjY0NzMyRmd6QlNEZEJSMWhwOXc0?=
 =?utf-8?B?bWxRUWl5NDErdXk2M0M2dUJ2VDAzR0NGdEdsWVpPY3Avd250dkh0U1NSNmFj?=
 =?utf-8?B?R2h5aTcyYUpsRUJVMVpHMTlyZTVuRExDNHBsaGtpOE4wTlJ1T1ZYR0l2S1Zy?=
 =?utf-8?B?c3B0WHUzQWNUTlpXaU1raklib0FUS1JKQVRqTkxEbVF5ZnpVQ05tbU0xdHJ1?=
 =?utf-8?B?OUVBcmZZZ0s3K0I0bWkxWWFxZW1Pd1EvMWs3UlNBdEVPZ3BOSVVKUXhmcURI?=
 =?utf-8?B?MEErZ0d4MllVK1RPd2xiamJxUSsyRk1lbExtVXNzalgwM2RxUE43OGtxcFFn?=
 =?utf-8?B?MGc4bVliYXlCT2dNaHZVeWJzTnJVYU41RW1Fd05Lc3dPcVlsNnNBMW96UXlD?=
 =?utf-8?B?cmh0bXBmV3NWTkM4ZnE1dkQ1ZzJDczJldlFaeW1wdjNsaHRVSE5HSVhTM205?=
 =?utf-8?B?SnZrYnFiU2J4SjZSV0o3ak1VekZZTEZkU09CV1puMFh6bmt5T3JIQ05CWExo?=
 =?utf-8?B?aHFvMzIzTDF6czJFMVJCZmhja2FxWkFUNmR3dkUzWkdJY0dlemQ3TXlZSUxI?=
 =?utf-8?B?c0VrcjlKSGJhMU5IR0RnNVVtUUEwbVhnMVJIUEJmQnY1SFFRb0lTUGRjRXQ3?=
 =?utf-8?B?QU5FMTJXY09iNXl3ZldqQWx2WlRjck9JOFZPQ3pIT3BWakh1NU1qTmU1SGNa?=
 =?utf-8?B?Z01XZnFNRTFjb0RvZ0lSQkNwQzN3NE9rSkRnUStiaWhqZk1kUkZaSlEzU2gy?=
 =?utf-8?B?MmZybEZaQURXK3J6Q0w3bW1qYmlmc0xsQVNJWE1iMnB3a285OVhhQkI1MFNJ?=
 =?utf-8?B?dUJmdXpkSTA2M29CYkhoandZVFpVcVQ1aHdORG0xeUZ1U0xQeVR1d2dueU1i?=
 =?utf-8?B?aThTSWxPbUd2VzlvT3JVT0kwd1ROb2IrODhkenAyMitFZnlQL1Z1eE9YNEVu?=
 =?utf-8?B?Q1Zua2pVaTlJLytza3BwamxDbHBrbjJQQ2VBMDNGbTFQZi9OOVdpRE1zR29H?=
 =?utf-8?B?bCsycU1tWVozZ3JYWi83Z053eE9HRG1kTFFQOGlTSXhmb29YVk9KaXIwUVFs?=
 =?utf-8?B?a24zbGYrR0NpYndHaGhIRWtHaTJNTUtyMnpEcGFyR3J4MzV1aTNCUnAxam1X?=
 =?utf-8?B?QjBPNGRCaEc5RC9wWVNaVkZlb0wzR09qWU1HRmhOUTVqZmpzaUNJNHkwb1pW?=
 =?utf-8?B?cW9KYit5YnhiYmpiRGpKeUZlTFBJcTV1MjMxbkt6bG15SUdiaUpvWWdpT0tD?=
 =?utf-8?B?c21oL2R1MU5CMnRlZUxMMW5rb1BIWDBzbGVQVGdvbjlpOTBaaFFsdk5PUWFO?=
 =?utf-8?B?aFBzLzk2b1QxQ0pGQlVaZzZXdWJtcllFSUlFaFNlU0YyOXlxV01JNFd1eUNo?=
 =?utf-8?B?NC9FdG41MmZ1NHgvTFJlaTZTU1pvc3ZzMXk4eWF3KzZRWU5CVklIeS83Ym0x?=
 =?utf-8?B?bHlxenJrRms0ZFVZTmM5OSsvK25XR2thNWY2bGxWTzVaYndZYzJHVmVPcEMw?=
 =?utf-8?B?dmo3M0xVL3g3R1lFOWtodkFudWR0SGdFMndGSHEyc2hadlpkOUsyeFJyRVIz?=
 =?utf-8?B?aHQvanhpVysrMWtMNURXVmxiYTUxSFpZVFVsL2dOaXRtYkg4dDVCT2pVeHdL?=
 =?utf-8?B?Vmx0TmpJRGkrOWViaEhvdlVNOTFXTnZhdkVkMVc5Z1RzRy9rZnY1Q3RDcGpn?=
 =?utf-8?B?VExrRXdLQjBvU0p5WGJVL3BKUWJxTVdVN1NOdzhvSDRSUGUwcXZkeXdDaHU4?=
 =?utf-8?B?TkhuK2FaQ25GU2lBKzhnSTBiZDJxZC8yS1JHOWxNY0pUem15ZDMvbUhGcWZp?=
 =?utf-8?B?VWtmQjUvQjRnaW9DTUZMNCtQWFNRUVUrbXBlS3ViR0p3WEZNS1BTaC9kS21I?=
 =?utf-8?B?SDRCSS9vcDh4R1pERTI4UDJlVHdURWJvelgyV1ZpT0k5UGlvNEZZRVhCdHRs?=
 =?utf-8?B?RVluVzUrelhPenJ6OHRyMTVrMm92UlNMdE8wanAyUnhsR0ROaHM1UlFLQXZr?=
 =?utf-8?B?T0Zmc0N2RGpWNlZ5ZjJNMitFQXE1TVFaQTBzYjVsZUJWcEdwMjlWNzNESVZV?=
 =?utf-8?B?dGxOOGM0TGpDZE9zZldoYUphOUE4VklFVzN0U0xiWkRrQlV6dGVzWS9RbWNz?=
 =?utf-8?B?cU8xemhOa2FhZnFTdXBJSzV1VEc4cTMrRUpkaDlGRTZxeHNjSCswUjdsVEcv?=
 =?utf-8?Q?V1VjFuiQZ+eBAwQ90SLka33wC9Zev/zqi4rot7ye1WPb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE9B662B585CCE4B842BE45E93E2C97F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5096.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74d7d99-2234-4421-ce88-08daa2a7df22
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 05:51:51.2872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlSYi9l5LyjHZV0x7k9NpH12Q3eX5y4x4lDAPHxvPaUshzv9E5WQWP4vaqpdTsGCkxmg5MexBZSGX57/Ky7+/h85wbAnTrpm3CwTFu2Kc6mC+iTtl2xNy3vhTnqMilsi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7030
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA5LTI4IGF0IDEyOjI2ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFBsZWFzZSBtYWtlIHRo
ZSBhYm92ZSBhIHNpbmdsZSBDKysgc3R5bGUgY29tbWVudCBibG9jayBzbyB0aGluZ3MgbG9vayBt
b3JlwqANCj4gaW50ZW50aW9uYWwuDQoNCk9rYXkuDQoNCj4gVGhpcyBkb2VzIG5vdGhpbmcgaWYg
dGhlIGNoaXAgc2VsZWN0IGlzIHRvIGJlIGRpc2FibGVkLCB0aGF0J3MgY2xlYXJseSBub3QNCj4g
Z29pbmcgdG8gd29yay4gDQoNCk9rYXkuIEkgd2lsbCBoYW5kbGUgZGlzYWJsZSBjYXNlIG9mIGNo
aXAgc2VsZWN0Lg0KDQo+IFRoZSBkcml2ZXIgc2hvdWxkIHNldCBTUElfQ09OVFJPTExFUl9UWCBz
aW5jZSBpdCBuZWVkcyB0byB0cmFuc21pdCBkYXRhIGlub3Jlcg0KPiB0byByZWNlaXZlDQoNCk9r
YXkuDQoNCj4gUGxlYXNlIHdyaXRlIG5vcm1hbCBjb25kaXRpb25hbCBzdGF0ZW1lbnRzIHRvIGlt
cHJvdmUgbGVnaWJpbGl0eS4NCg0KT2theS4NCg0KPiBBcmUgeW91IHN1cmUgdGhlIGRldmljZSBp
cyBmdWxseSBzZXQgdXAgYW5kIHJlYWR5IGZvciBpbnRlcnJ1cHRzIGF0IHRoaXPCoA0KPiBwb2lu
dCwgYW5kIHRoYXQgdGhlIGZyZWVpbmcgb2YgdGhlIGRyaXZlciB3aWxsIHdvcmsgZmluZSB3aXRo
IGRldm0/DQoNCk9rYXksIEkgd2lsbCBtb3ZlIGluaXRfY29tcGxldGlvbiBhbmQgaW50ZXJydXB0
IG1hc2sgbWFuYWdlbWVudCBiZWZvcmUNCmRldm1fcmVxdWVzdF9pcnEgQVBJLiANCg0KDQpUaGFu
a3MsDQpUaGFydW4gS3VtYXIgUA0K
