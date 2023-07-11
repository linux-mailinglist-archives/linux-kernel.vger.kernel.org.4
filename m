Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1E374EEE2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGKMai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjGKMad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:30:33 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0452FCE;
        Tue, 11 Jul 2023 05:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leDsZkFETNlRnFHOoC59Ya3Fze4wLGlJKtnmdEslCBUOzh4V25KcPHocIxSZwWgYxQzxCfNDZWdKw8UtvJLO+Y+QALlukWAs/CHqS2a0cfwZ1+RN6oIqQq0sUL2i4OmkYBO2M/9mYwQZ3Tc91U+AlgJCqr+/19lfQtoF88caydoFCoRYTHPyN8EWGXi5nDS49FwrQvG/VvMQnLX/bgJ6wsS+ddCnDxhP5Jw1Lquf84A2i6yeZiFI9ylO10OCt9UzICys68kqleprfLnb1oC9iL7NdLfiSswODUY74H2P7ndUjxUKLLQ4L+ApO2hK3KPCaVbw9pIpbip5nCzqm1GBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlanZGpM1TGB4pbrL0+fts14nNavmv1oPhD0qt28MIY=;
 b=RgzcOav+DzLyevNTLW32C7UeQWC9jE+jAqVgyYgxfg3mobjFrJZFOmXiDvxiNQkFDZdpffls3PGM9Rm5dpZpk9tJXgJUr5l65X4WG+QEVvD/WaJMk4CHkSFdjID3P6CIpgt0Nj9/+nSTBbBKGGecMXILtoKmm8fYWRHo1XDvwpRdhw26tVUQPabfSzonv+pMHj6ZtFcX/1It5TUoJjXNt4U0I5UWONMGnHUbQnI3DqqB+/S9P3h1dyCmKvAl/MJfG96BqqaLc/CAAA/7q6YoW4s+KbWRR8rrVSCBlHROlaNlpZJz2EnFVLZtilJ9pmY5L+BlKvD16Dgo4RNb+14Ghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlanZGpM1TGB4pbrL0+fts14nNavmv1oPhD0qt28MIY=;
 b=P8GBgJLGXdZhcfyRfCD0gCuN39RYRLYxm+CWdgz6gHG+FTdFty9An90hDyVEGpRB3DGnW7pQJD2DHltMn/bVrBm6p9PiRtn/Gy/EpfhmAsDR/Wxh/XFe1aM9TkXrZke1Wd8hFeJ7wKofiV7ZjKqOGdZ4kuYGoWBxsXifGECAorCsmCYXVU/dJrvzKuJVSZT75V6nv29g5BvfJjSOB87+cmd62+HxOPEnserqhzwBf1SjgHWxcTdYbISzz/6u/sOMrHUeMhkOJFUdw+iMdZ33+KKf2nZ7LPqaVlq2i3hCe9hMyaSZUt55fSdNSg9xNsVkm56RkDYobFgvzXAU3sBiXw==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 12:23:40 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ee7e:9411:ca2b:85e]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ee7e:9411:ca2b:85e%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 12:23:40 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH v2] gpio: mmio: fix calculation of bgpio_bits
Thread-Topic: [PATCH v2] gpio: mmio: fix calculation of bgpio_bits
Thread-Index: AQHZs3iSPUnbqpQMY0ak3lVgSDGvBK+0RNsAgAA3vNA=
Date:   Tue, 11 Jul 2023 12:23:40 +0000
Message-ID: <CH2PR12MB38958A4ABF8397A53D68F41AD731A@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230710215023.679-1-asmaa@nvidia.com>
 <CAHp75Ve87oHP4P-=xHZgHuWyJJnpuARH+qzXO_vJRhUeovXMWQ@mail.gmail.com>
In-Reply-To: <CAHp75Ve87oHP4P-=xHZgHuWyJJnpuARH+qzXO_vJRhUeovXMWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|MN2PR12MB4520:EE_
x-ms-office365-filtering-correlation-id: 25934114-8838-41e2-d95d-08db8209a8d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E71DsIm4ZM7RNaSH+iWW/geOrzquFN1q7V71Ok0bEoUi8aZaYGLbWS/KL1OtSc9Xri+cmNC/o21pm4Fb4BqxVu9IvwzPL27QO4A5pfR/nWHV5ox7UotCvIYYCAlRZJ6z0FFn2asrIuAimzWMeSGMUFDSiwKq7jVyCUq/JjYpp89Sn8yzhMEHIvmfxU4W3oQsyZOouEuT9A/WWwexR0MjONF3mtOXi9ooxfv7ztyGBusXncSGEH1BHAiUAfI+n6zv4Dk3vUJ7qpcczj56CBjg+P1R+C/HqLEl3oqoLnI9vxZWQDdc++yOZ3vSPPzzX9+Q3+OXHJdHa3D+nMklJ1c6UubU0Y4GcK2W0Rm9zlviooMPW6wbhTUWYAOSBCXkWc5zHaGxvEsqDH29eLZNEVMHMuSwVAPpQ78eUPlRiiHyrE6kywFzPWQcWv92fDfimHnicfZrXhCRqdf9xT3oZBn++FX7HB7owJZWdCwy5+4y7Enqx9LEoILx/cWA/j/UIgVoFE6v5kf3mtkRo2885nICieOqxkmUqjtZLFmRS5oPFoiJ0K3eYyO1i/S5Qx5yDkp3yo3WiNGZAto6fDnkChBpqaYxlhUJDt2PIWLdgM1qYOuTOWfA6GOcsfygjCvpv+5u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(122000001)(71200400001)(7696005)(38100700002)(6506007)(107886003)(26005)(9686003)(55016003)(83380400001)(186003)(33656002)(316002)(2906002)(4326008)(66556008)(41300700001)(38070700005)(76116006)(6916009)(64756008)(66946007)(66476007)(86362001)(66446008)(5660300002)(54906003)(52536014)(8676002)(8936002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUxTYlNXMVRFZjBkTGw0Nk8vQmlGem8wbDgxaEw5azUxTXFqMGR4TktjSUF3?=
 =?utf-8?B?TmdlaElncFUwVW1qQ0ppMVdnTDdMOG1STDYvUzlJRWU4S2JYeHJHamROVklZ?=
 =?utf-8?B?cXhLZ0MySzJlWnI3ZXhMR1ZyOTVwWDJDVnIwaTVEZ29Sb2llY3hrMDA1Q0xN?=
 =?utf-8?B?YkFhQ3ZJQzFrdFR2V0ZuTDFLYmlpdWZoTlZlOVdCUVlBQ0EwNjNRcmZrT2RD?=
 =?utf-8?B?WGVocU5BUjE1M2ZEK0w2YVhFemFJM0RPQ2xGdWk0a3RIdDdKTURDVUtic2pv?=
 =?utf-8?B?eE9RazQya2Yya3FYdnhWTFBTc0JJTzYyL0lKV2dWNUI3NTlUY2FKQURTZTF2?=
 =?utf-8?B?YXpldGZlOVQreFNWeVR1QU9YZFI1cTRqa1lhM0VEUzBEa3h5SStZOWdrVzlZ?=
 =?utf-8?B?YXZmZVZCaEJab3BaNHRNTlcvNlprdTFlWHRaWWJtME8yTVdDdUJ1TFllWU9z?=
 =?utf-8?B?YmsraGtFRW9TWGxQRllrNXo1SEJwUC92b1piUmdQQzFrUCtRWW80Tk1ZR2p0?=
 =?utf-8?B?elZySHFBV1pTbGRsZTRTRll6WXhDZ2kzUkRIUGZHK1FKUEpXazJmVVZSUjJV?=
 =?utf-8?B?UThSajI0ZDUvelJsaldIYnhONFBTY2EwOCtjNHB0NzlSeXp1T3NUS2xLM3di?=
 =?utf-8?B?Wk54OFN2SGZrbWxDTTVSbHd6OUM2YWRtbENEdVRrcnFRd205aHNCalVnSy9t?=
 =?utf-8?B?SEY1SHliTnVra21mcDJZK1R2c2RyYko5T2w1MnYzVHE0ZXUxR3NJUXcvck1T?=
 =?utf-8?B?V09kSTJSTEZoUGVWT3ErOFBWZ0R1OEFLai9nSUJsMjVxSG9CcDZzRnRWVzZZ?=
 =?utf-8?B?c3NUcWxEVFZZYWl5QklUQTVJd1Z0THNsRDNlWWpaTmgvcDRZTFlBM3kvV3Nz?=
 =?utf-8?B?NFNURWsxa0NwS0VBdDVPUm9iZWpaL0QrZVg5S1FKWmxIWUFPK00rUjN2Wjds?=
 =?utf-8?B?OWx4OVpwYk40SWk5SEhWTUpnbzVUbWk3WkhCTzA1bDk4UDJlTnQ5cm9DekMz?=
 =?utf-8?B?M2xHSkI1bEsySEhHQW5mREgzOGdTS1FUL1kwOE1ZY0Z2cnZIdFNzNE9rUnVO?=
 =?utf-8?B?aG5yc2d2ZDFySGF4VTNPTjlTRkFUSTRVZ1JuMm5PVE9yWllaUHhtd0xVSnFn?=
 =?utf-8?B?cWhWSnFQVzB2VXhpNlltdFFzZnJvY09sYnJSRGVsaWdMQjhQRDU0OGFpN1Zq?=
 =?utf-8?B?QlVmU28rdW1na0NZRzQ5NURvTDI0RWVhMit6VG1yOHZvZHNrWHgvK0V1dTdD?=
 =?utf-8?B?VVl1Y0VWQ2MwKzBEaHRVTlNlNWlHclIyOGwrSktqU3VxT2ZiR3VRSFkwT2Jl?=
 =?utf-8?B?SXRkSTl3S3JPK3BOWWtWeDA2ZitVR2plcTRnbmo1U2Q1WHh2RVd4SVY2ak5S?=
 =?utf-8?B?ekM3bFIxU0xhOWoxZXFMSjRxWHFNN3h2bU5ycG9OR1BHM1VaT3cvSlJoeVN0?=
 =?utf-8?B?R2FTbzdaR2xrQXlsT2thNDRoY0VlM2VHL1hIckpkK1d6SEZCUVVjM1Fad2lR?=
 =?utf-8?B?VlNIZ1dtN0FKYmdTRkNzdUVJNE5kMkdjYzJuQjh0K0RFcUJ1TGlLZ2t1blQ0?=
 =?utf-8?B?dUlBQ2hmMzhac1BLcGpycFYzRXFBOWtqUy9FaTF5MkhRWlBGelU0M0grUUht?=
 =?utf-8?B?UXJmMlZ1Rjl2b0ZFLzVxTXdjbkc2dEQ4bS9aTWZXb0Z4eG1oeGVyVWtqdVFN?=
 =?utf-8?B?T0VtbzVYdlZFaTNuVlN4WmNaNSttZk5kZGpHbHI3N29LdmRhSnMwM1NEUVFw?=
 =?utf-8?B?c09TaXRuYzFnSDlMenRINUx5QjY5Sm5FRXpQVGt6V2RycWJhM3RTWEwzUkNa?=
 =?utf-8?B?UVBLcTdWQ0wzY3NJakJYRzFxbWVLa2h3WStBR1NYVVNqSDhMY000MUJBOSt5?=
 =?utf-8?B?ZEtkcmVhcGQ3STRKTkFTQ2lvRnprckZaWjUrWWRJQ2NOc0tuN09qMVRQaE5B?=
 =?utf-8?B?MEtEQXFjWGUzYU1DQ1FBZ0NWS0xJcXdwd04xbWpNNTVYS00vOGgwOVFpQjU1?=
 =?utf-8?B?VU5USlRSbTUyTHF3dml3ZG1PQ3FlRzZOaGMxUmphM094VnNSUW5laldpTVpE?=
 =?utf-8?B?Q013UDRqakFVNW9seE8xTVdSL0UrNllKWDFKb1NGVTFCcE1wMGI2SEVETERa?=
 =?utf-8?Q?eMPs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25934114-8838-41e2-d95d-08db8209a8d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 12:23:40.1091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvakGrhi2EFYRNATT+4LqFYt3jjVyaxCAjYloauygnjrRp7COLiyBUolaNIZHUgKBdYaTsaR3Mxq+tcXsloLPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IElmIHRoZSAibmdwaW9zIiBwcm9wZXJ0eSBpcyBzcGVjaWZpZWQsIGJncGlvX2JpdHMgaXMg
Y2FsY3VsYXRlZCBhcyB0aGUNCj4gPiByb3VuZCB1cCB2YWx1ZSBvZiBuZ3Bpby4gQXQgdGhlIG1v
bWVudCwgdGhlIG9ubHkgcmVxdWlyZW1lbnQgc3BlY2lmaWVkDQo+ID4gaXMgdGhhdCB0aGUgcm91
bmQgdXAgdmFsdWUgbXVzdCBiZSBhIG11bHRpcGxlIG9mIDggYnV0IGl0IHNob3VsZCBhbHNvDQo+
ID4gYmUgYSBwb3dlciBvZiAyIGJlY2F1c2Ugd2UgcHJvdmlkZSBhY2Nlc3NvcnMgYmFzZWQgb24g
dGhlIGJhbmsgc2l6ZSBpbg0KPiA+IGJncGlvX3NldHVwX2FjY2Vzc29ycygpLg0KPiANCj4gSXMg
dGhpcyBhIGZpeHVwIGZvciB0aGUgb3RoZXIgcGF0Y2g/IElmIHNvLCB0aGVuIHdoeSBkaWQgeW91
IHNwbGl0IHRoZW0gYWdhaW4/DQo+IA0KQXBvbG9naWVzLCBJIG1pZ2h0IGhhdmUgbWlzdW5kZXJz
dG9vZCB5b3VyIHByZXZpb3VzIGNvbW1lbnQuIEkgdGhvdWdodCB5b3UgYXNrZWQgbWUgdG8gc3Bs
aXQgaXQgYWdhaW4gc28gdGhhdCBpdCBpcyBhIHJlYmFzZWQgY29udGludWF0aW9uIG9mIHRoZSBh
cHByb3ZlZCBvbGQgcGF0Y2hlcy4NClRvIGF2b2lkIGFueSBmdXJ0aGVyIG1pc3VuZGVyc3RhbmRp
bmdzIG9uIG15IHBhcnQgLCBjb3VsZCB5b3UgcGxlYXNlIGNvbmZpcm0gdGhlIGZvbGxvd2luZzoN
CjEpIEkgd2lsbCBjcmVhdGUgb25lIHBhdGNoIGNvbWJpbmluZyBib3RoDQoyKSBUaGUgdGFnIGZv
ciB0aGlzIG9uZSBwYXRjaCB3aWxsIGJlICJbUEFUQ0ggdjJdIGdwaW86IG1taW86IGhhbmRsZSAi
bmdwaW9zIiBwcm9wZXJseSBpbiBiZ3Bpb19pbml0KCkiDQpBbmQgUmV2aWV3ZWQtQnkgQW5keSBh
bmQgTGludXMuDQozKSBJIHdpbGwgYWRkIGluIHRoZSBjb21taXQgbWVzc2FnZSAsIGEgY2hhbmdl
bG9nIHNlY3Rpb24gYXMgc2hvd24gYmVsb3c6DQpTaWduZWQtb2ZmLWJ5OiBBc21hYSBNbmViaGkg
PGFzbWFhQG52aWRpYS5jb20+DQotLS0NClYxLT52MjoNCi0gcmViYXNlICsgY29tYmluYXRpb24g
b2YgdGhlIDIgcGF0Y2hlcy4NCg==
