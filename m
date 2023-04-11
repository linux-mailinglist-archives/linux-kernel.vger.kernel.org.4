Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864746DD304
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjDKGjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjDKGjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:39:22 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2070.outbound.protection.outlook.com [40.107.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85179124
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZOHcj6BUI6b8yrPn4DvtJN6QIUydiECEOSx3WZV9rmDYdlNxB0yxoAAt+A2OBn5V6pBU/yP0UmeBOGqFmj01JO9nFlEgVDCJmSUVAj8DX1YKY99F8H3AdkMnfE1fygzRsudZia5vsCM1sjVRNGPYIn/loxt4w46J7lZ13FxZQ2lyuHTvDGX/8bNMbITAk6c+6iM3ngdCgAmcm3ejjAZc1ZR220pTFlGA7LelPQFN+uXUl5VuN8rc4uTzFtL6v55xKaL5DIu6vTJob6EzLYtQOGo4A0eQRjH698XWtMYb1QopQRvFg7UbGsOVGrfsiSijBFHQiO4a0gwlEpCI9P2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GSvPARjyulbjdLN2Vc+RtDGzRdWDLHMun86vP2aRyE=;
 b=UfPZK6VzreAYIkwgrJxM1iaphJprzI0A/dfEfoK16iCtEBql/NPYzFhwBda+CcxNJvYikXQqqUvVItGYtcC49eKZT3StNTCA3moOf+arqu8+AqsYLr9MT1X4aCIDyIHwOQqltlar0gtiFI9lJJXBumYkUDpQAIxGKmQRYu+13j6b2BiBHux0kIJYlyE9q8bEBMtQS06Lx4+P9tZIkWJALl/Exo6LOok9sgLw66DAaSH52ZENGAAOGgYni28oThb0NbkrgPIks10+tXF8siBcZUC95+nmb0oJ0sThQ2bVt/czMx9A55fpJiRwd6JreB/871VobUMxa1i/f9DmLCp37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GSvPARjyulbjdLN2Vc+RtDGzRdWDLHMun86vP2aRyE=;
 b=SDlKxWsalJkHy45m7eKowk61pE5vJWot3JbaYtqWUJNk8PAtwFjgDriF3w/oKXwphg1MX3DYOJVQ+Ph97XsR8O5FzmNw0k3XLFystqrOKVdvV9Z4iQAMI3WiyMesLT+Sso2lAkfduiX8V210SANkYV62IXkjdWvvYjpafu/gHsZVX+ONBp8K9Wy2blJ8aBjU3wNPMbpv4bsdT457Obfw5kTtdLXS6lpY6oFT/DnFI/CQG7m7jOMh/XS/qBXzhRV1k2MM/bP7weOsy37AjPJxxjprkf1TeCL+cNWb8RJbJwu4+/h+PbHqTX8K6MkfC1SunDNsBrI4axM/hl4svGT/lw==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by PSAPR06MB4341.apcprd06.prod.outlook.com (2603:1096:301:8a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 06:39:16 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6%3]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 06:39:16 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Topic: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Index: AQHZbBZh3jvrK38aOUOklBMw4wCkQq8lpcyAgAACKwA=
Date:   Tue, 11 Apr 2023 06:39:16 +0000
Message-ID: <TY2PR06MB34242144FB4F944DD866567B859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <20230411022329-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230411022329-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|PSAPR06MB4341:EE_
x-ms-office365-filtering-correlation-id: adaf6f99-fe0a-476c-94cc-08db3a5778ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9vc7eCN/IfDBfyLjYclgN/HNk/YrKfPAZftZLtYr3nNt4u9xkxBpkc/tvhSDGEU1n20RRF4F6t/VyJQyjQl37JXcAgcUxqv6Th7IX0RVGR4fCSAnU038UJgle2SbDED0Jht3SwrnvycXWEkCNVJMpsFTZiLcI8ng0WDdr859r3WDmmdyxJXe8iD88BbS60lu6+BzY31s4y87rfiY1vUYNYkt8iz1nBWTVNk3stDiGucjjTtZZddWB3XaOl/6eB+JvYAuNQOxGOHBDKdeSXVtrwweuqBgjYoOCaxuoR0736SBMcQ8eXdyMcPZdwwQw9+ALOIqKopjRA2bfLrqWo6b5l5BrwT8iIpATH3T5fk7Vw5pCvxtEaeLrZPrkEknPCFbFSvYmuM9c9geOHpE5e8Hf6e5XwH2woZ9zGK1vELKZFMJNtDHN7U8VmqWXc9AA/CYnfUWB/VdPwY/x0g55UkVKPP44T5fabj50SxsvUmTFznE+J/YMKZo6F9g/ZQ7YwzDcxDtbf4ODvvT7nNlxxinjCauBISiOleWMmF81Xgd+XvOjyGx3aruDqYOi1BJmW1wz3XBQ2mSAdOfyHaU5eEEZBarYMHAI5GQtTcVUMrT0SpD2iITXny8ydIileGir7CR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39830400003)(396003)(451199021)(478600001)(7696005)(71200400001)(6506007)(316002)(54906003)(53546011)(26005)(9686003)(186003)(2906002)(44832011)(66556008)(76116006)(66946007)(4326008)(52536014)(64756008)(41300700001)(5660300002)(66446008)(66476007)(8676002)(8936002)(6916009)(38070700005)(38100700002)(122000001)(55016003)(33656002)(83380400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk9rYW1IL1NvQWNqMk1vZWR5cGlTcHhxcmFQTHpLa0kzWUZTZFdXaU1rRWZw?=
 =?utf-8?B?RmdaT3hGY1FBRDE1eG9icnY5OVBWeDJISWVxNTk2NlY1V3FhcUM2RUZLcUJB?=
 =?utf-8?B?dXhEdUk5cHF5OWFoZ3JBUGx4S2NXVi9ldDY2aHU0S0MwRVBkV3FRYlpERGl5?=
 =?utf-8?B?OTBId0ZwT3FKTmgrR3JndWFiS3BOOFNSRDFPVjhlNjhqZEMzMWMxL3Z2cEIr?=
 =?utf-8?B?V3JUMzBoUDd4ZllzTEQvdG5DTnVVZWd4SjNYOUxPaWRDYzZNYnM5V0VXWWY2?=
 =?utf-8?B?SUlJM0ZOSUF1M2JCT080bEJUU1MxUlZEVDF4NXFXb0dsc1FUSDJRL1liWDQv?=
 =?utf-8?B?ME9YWlk0WDZDYmdQNFFoR0dISmd1UURFS2JJZU1XV2tsMXFrQ3U0ZDI2Z0Nq?=
 =?utf-8?B?NG4rNU10RGlwOTZ6RWZ0czJDQ2p3WUtSMndVU1NQTmo5K0IxY3k1eEtOelpB?=
 =?utf-8?B?SXFEQ3cyR3F0NjU5eEJFWC9ObkVqMnJVdWx5ZEpWYkpQQW9oc0Z3OWZET05G?=
 =?utf-8?B?bEdVaHhhZkxnY0ZMN1owQnBKK1ZaWTJFeGxXZ0VHQkpUM2dSR3VDKytWaU5j?=
 =?utf-8?B?Tkl5MWdpTUFpTnhRVTE5U1VhTDJHYlhOQUI5dGRqQVlMdDlWNTlzOGwvVXRI?=
 =?utf-8?B?U2l6RFJmallCeXlweDV1WDduUVdBSC8xekU5aHZvSW1Bc2U3VWEwdjJpTm1q?=
 =?utf-8?B?dE0zQnVlQXZhZTN5SW9mSHB5MXNWWWFjMTdzVEJtUjhadkFaNkhVM2hnSTc1?=
 =?utf-8?B?THFGYWhqa1lodjhHR1JnTkhLT2FjcHhxTVVrbEdWTHZlZk1WaVBXazlIY29u?=
 =?utf-8?B?TDZqR2QzWk9YY3ZWaFZZSlVJWVRvc294cStyRnVZVWNQMTFTOFZPRlh5bUlR?=
 =?utf-8?B?UEpIUXVQMVdIcTFoYjZiUVBKbFdyTnBVUkc2T0RCZlpwMXRwNHhPK0RwTXdx?=
 =?utf-8?B?OXpQVCttaUltYlJnMnVqaWhJRFBBaEJHczFzUFQxV29nMzc1d01SdUlSV3B3?=
 =?utf-8?B?SGZvT3BYbm15UWFudWVHb3lrbTB1YmtwaHFFWU9sMHpJUUtNL2hWMlJ1TUhh?=
 =?utf-8?B?Z0R3aktSSnAwUGdXUFZjdUpjUTB1NGRxUzkzVjlwbEV5RHRVQW81QWQvdG1j?=
 =?utf-8?B?bW9ITnZ0RFYxT0JTOTg2Q1NmSUxaNlZrWjBpQUFKWGhjeENOUUVJdEFKN3NR?=
 =?utf-8?B?Wk80RmtNdVp3eVZvVjNmM1o5TWR5T3lkMFZncHdwQXFTNk1Deld4djB4UW1x?=
 =?utf-8?B?K0kzQTBocWVoS2k1V1dzOUpOckhzOW1TejRIc0xub25GSVd1b2FtWTRZejIy?=
 =?utf-8?B?ZzNDQUc1M3JlQWoxUHdDY0dtcUdDNjk3SDlXZVlhalVtbnBwR0hmdDd6QjZH?=
 =?utf-8?B?ZnVtVG02NWdLS1dVQWFFZXp6SWk5c0xRWXpCczFkcWl4TTkxaHFvN2ZYZ2ty?=
 =?utf-8?B?ZmtvcHdoOGhoUm1hY1FEbzJySUd6NHJPQWR4NmljQlptTko2b2hwL0swaGw1?=
 =?utf-8?B?MEJjVjVjUUtPekZXbTRqV01nWnllckxuS2hVYk5IUVI3QVhzUU9oU3FUSFU4?=
 =?utf-8?B?dFNZU2VFMnlPTXU3amNySGhXdjQ2ZlJoem40dzMweitMTTJOR1g5WlBwQWNq?=
 =?utf-8?B?RnVaWW9La2NqcHB2RS83cHFFUjFEV2VWdkRlWEZiOWJaWDIrU3d0S3JCYkNE?=
 =?utf-8?B?bFJLeFhpMDkrY240Yzl6Q3FTNVFybWtsVjFhakFVM0V2SE5ZbmRHanFMQm9Y?=
 =?utf-8?B?QVpyTGRUOFZZb09GbmpWdE5nRFJPOEdSTERxSTR3T3pFOTMxNUNvK3hwN2xj?=
 =?utf-8?B?Zng1NlNTWnVXVHhUU2pzN3h6L3VzQzNzK293cjR0d3pnZFFsRDZuTVdJMTR3?=
 =?utf-8?B?ZmpTTFBKM0xVRDdPRGNIbFdmZlRxYlZtazd6cU90bEpER0R0S0FEbHBVbmdK?=
 =?utf-8?B?SFB6QUhtUG84VnE3cms2SGpMZkJGZ1Rua2R6Q3I1cCs5YnFxeTlaRnhEeVlq?=
 =?utf-8?B?bllXTHhWd2h3TERybWQzdVhhMjlKMGM3cGE0RzMvWm9TR3BHdUo1b0xteTNr?=
 =?utf-8?B?TElOa3ZzWlBmQzR6a1R1cnJsckdmNWVxM1FwUGowNThXU1N0ZGNSNWVaTi95?=
 =?utf-8?Q?Kg4glzsJaiTqc0Qhnb1zLPLm+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adaf6f99-fe0a-476c-94cc-08db3a5778ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 06:39:16.8003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4a32YZYDyvKmXtLMAs+RE0nEsFigtKlOcxHmWtN3DbafUK/KRQqXRK4mD+WseZ9780PS2m2jqvsokzae0sbZmBBYo8ZojyLKA8WKSEUPwH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4341
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgbXN0Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1pY2hhZWwg
Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDExLCAy
MDIzIDI6MzAgUE0NCj4gVG86IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29t
Pg0KPiBDYzogamFzb3dhbmdAcmVkaGF0LmNvbTsgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gdmlydGlvX3BjaTogV2FpdCBmb3IgbGVnYWN5IGRldmljZSB0byBiZSBy
ZXNldA0KPiANCj4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMDk6Mzg6MzJBTSArMDgwMCwgQW5n
dXMgQ2hlbiB3cm90ZToNCj4gPiBXZSByZWFkIHRoZSBzdGF0dXMgb2YgZGV2aWNlIGFmdGVyIHJl
c2V0LA0KPiA+IEl0IGlzIG5vdCBndWFyYW50ZWVkIHRoYXQgdGhlIGRldmljZSBiZSByZXNldGVk
IHN1Y2Nlc3NmdWxseS4NCj4gDQo+IFNvcnJ5IG5vdCBndWFyYW50ZWVkIGJ5IHdoYXQ/IEkgYW0g
Z3Vlc3NpbmcgeW91IGhhdmUgYSBsZWdhY3kgZGV2aWNlDQo+IHRoYXQgZG9lcyBub3QgcmVzZXQg
ZnVsbHkgb24gd3JpdGUsIGFuZCB5b3UgbmVlZCB0byB3YWl0Pw0KIFdoZW4gdGhlIGNhcmQgbm90
IGZpbmlzaGVkIHJlc2V0LCB0aGUgcmVhZCBvbmx5IHJldHVybiB0aGUgbWlkZGxlIHN0YXRlIG9m
IGNhcmQuDQo+IA0KPiA+IFdlIGNhbiB1c2UgYSB3aGlsZSBsb29wIHRvIG1ha2Ugc3VyZSB0aGF0
LGxpa2UgdGhlIG1vZGVybiBkZXZpY2UgZGlkLg0KPiA+IFRoZSBzcGVjIGlzIG5vdCByZXF1ZXN0
IGl0ICxidXQgaXQgd29yay4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZ3VzIENoZW4gPGFu
Z3VzLmNoZW5AamFndWFybWljcm8uY29tPg0KPiANCj4gR2VuZXJhbGx5IEkgZG9uJ3QgbXVjaCBs
aWtlIHRvdWNoaW5nIGxlZ2FjeSwgbm8gdGVsbGluZyB3aGF0DQo+IHRoYXQgd2lsbCBkby4gQ2Fz
ZSBpbiBwb2ludCwgaXMgeW91ciBkZXZpY2UgYSBwdXJlDQo+IGxlZ2FjeSBkZXZpY2Ugb3IgYSB0
cmFuc2l0aW9uYWwgZGV2aWNlPw0KIFllcy4sd2UgaGF2ZSBhIHJlYWwgY2FyZCB3aGljaCBpcyB1
c2Ugdml0aW8gc3BlYy4NCiBUaGFuayB5b3UuDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgNCArKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9sZWdhY3kuYw0KPiA+IGluZGV4IDIyNTdmMWIzZDhhZS4uZjJkMjQxNTYzZTRmIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMNCj4gPiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jDQo+ID4gQEAgLTE0LDYgKzE0LDcgQEAN
Cj4gPiAgICogIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+ID4gICAqLw0K
PiA+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiA+ICAjaW5jbHVkZSAibGludXgv
dmlydGlvX3BjaV9sZWdhY3kuaCINCj4gPiAgI2luY2x1ZGUgInZpcnRpb19wY2lfY29tbW9uLmgi
DQo+ID4NCj4gPiBAQCAtOTcsNyArOTgsOCBAQCBzdGF0aWMgdm9pZCB2cF9yZXNldChzdHJ1Y3Qg
dmlydGlvX2RldmljZSAqdmRldikNCj4gPiAgCXZwX2xlZ2FjeV9zZXRfc3RhdHVzKCZ2cF9kZXYt
PmxkZXYsIDApOw0KPiA+ICAJLyogRmx1c2ggb3V0IHRoZSBzdGF0dXMgd3JpdGUsIGFuZCBmbHVz
aCBpbiBkZXZpY2Ugd3JpdGVzLA0KPiA+ICAJICogaW5jbHVkaW5nIE1TaS1YIGludGVycnVwdHMs
IGlmIGFueS4gKi8NCj4gPiAtCXZwX2xlZ2FjeV9nZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYpOw0K
PiA+ICsJd2hpbGUgKHZwX2xlZ2FjeV9nZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYpKQ0KPiA+ICsJ
CW1zbGVlcCgxKTsNCj4gDQo+IFRoZSBwcm9ibGVtIHdpdGggdGhpcyBpcyB0aGF0IGl0IHdpbGwg
YnJlYWsgc3VycHJpc2UNCj4gcmVtb3ZhbCBldmVuIHdvcnNlIHRoYW4gaXQncyBhbHJlYWR5IGJy
b2tlbi4NCj4gDQo+IA0KPiA+ICAJLyogRmx1c2ggcGVuZGluZyBWUS9jb25maWd1cmF0aW9uIGNh
bGxiYWNrcy4gKi8NCj4gPiAgCXZwX3N5bmNocm9uaXplX3ZlY3RvcnModmRldik7DQo+ID4gIH0N
Cj4gPiAtLQ0KPiA+IDIuMjUuMQ0KDQo=
