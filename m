Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8850E6F181C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345934AbjD1MhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345607AbjD1Mg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:36:59 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2101.outbound.protection.outlook.com [40.107.127.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1608D421E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHOSFlHXjqi6DNU1iLd7PM8ksqG9QTYDj++Fj5Y5wssbSA8rfqIKXKI0TUmRrqtw+u4u31N/wCAr+/gOchIKdZxPP3WVnMGb+dcfeWUTaR3EMzzwLLkFwgsKReiX+CDwuv+OqdYNaP4wDExKtoNn9dJEkB7o5dVJHoqzAl9QJgjgmnygraO2HqnxvG5faPcUZF2RwtTXx6JVXanW86zBBx8iwKXHazvfbKNjvHdlhYnKg/kig/2iSkkvVg1jFtT3dwVAbqtCk0ZlycSirN9hYbvwNBKBxgPnMuEe1h3B4vwvbSujWwYCv6EdK6ohQdqJUYGniwg+1G0U4/GAvRM70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUpucNQDx/DWsjU5cdmReUwij+bCtGr2PfLQXbsn1S4=;
 b=IrTL5czn8gcIh/SDJ6izgaPxtZ7w1ZnVWZe7+ffvT6wO0/WIllz5W7+HxqkKEzF+CLGgMiZlnV6sY6DJqSfSa2xo2kUB0IO55aLRLVvd0IwH3ivrAmSJRsGBgbjQGHi4O1udw8EJ491UyGtD2YQiGMIudWVsIBcnEax998F9IVUpHF1kRGyi9ZSL130wFrPncNjVJrU7XgjqWME5kK6hpZ5vi0MFSTmEjo2x3U2UGBWH53WkIPyHVsIC92DQg196QVqnVreFgcchJHVHq7UIy2tYLM2hqbJT1/D1rhEjuQ03cuQHoALkUFIsqChbYgdyHpowpZ//lPcI8rY6mZHl3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUpucNQDx/DWsjU5cdmReUwij+bCtGr2PfLQXbsn1S4=;
 b=Cdn7oB7RejKbrqoJ/Tz6TYHZ8h01zh3X6OEAvbd57OIN87jY9jguYRyltPqaxxBruytZu3nV26epFUzWYWrJeshUEM91oTX8nhvJe8BzC9ok8Nvz7+slqp7NCKh3OAQt4/zKLqkHQN7WgtlRRi55mlO3eskd4Tg2f1AeVcj9uBk=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR2P281MB1749.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 12:36:51 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4218:fb63:61ae:c42a]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4218:fb63:61ae:c42a%5]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 12:36:51 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] regmap: force update_bits() to write to HW when reg
 is volatile
Thread-Topic: [RFC PATCH] regmap: force update_bits() to write to HW when reg
 is volatile
Thread-Index: AQHZeZSE0uiJtVKdg06gKOc96vXyxq9Al/aAgAARFgA=
Date:   Fri, 28 Apr 2023 12:36:51 +0000
Message-ID: <f7cf3e43-c7bc-67ac-e9ea-e7a79bcd8a88@fi.rohmeurope.com>
References: <ZEtdJtlbmDCvZuAc@fedora>
 <14d81f72-ab34-4405-b826-b52636d2be18@sirena.org.uk>
In-Reply-To: <14d81f72-ab34-4405-b826-b52636d2be18@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR2P281MB1749:EE_
x-ms-office365-filtering-correlation-id: 5a85a74a-fba8-4808-14f2-08db47e53db4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BRSU7WbDcNqmKJgbr9I1t+h//Wq4fakYAk+SkZPPI3CnQGNjRQEEluRudrMkqudBaSQJ4+1nriTJMzqSCALacmMmT7dU4mvAVU11wBasDr1Ne5zMVufRmrv69G+nVeJSC5YuUnTrewF85e+8t6cCMXYIVC+Z2dLYOBqOgz8dlNVVr5p8IqpnsTwFv5UIHkW7GAo0Tv2ASFnAiISh7oJBuqPax4nk5hBkR5Ehv+bzaSETZoH2WLDUXVLXIgaECfyAMVzxY5loRGt9En5r+W7U3dJBCN3RfqZ1uyoz66TnZ35Snv3PoE3R9rjDcbCdv1mvsQ3T7fkCSeJoww7xn3NRXL+TZA+sSprlh9RmmWFjE3kxg/eEjGLQ88rBE0C+1/WAnOLsZR16wJr6Qo15LUv6KYBqtGbsbFTIylLJZeLNL41jWlJi8VzKjSWWCPepXR56aOl57BZ230x3oYLCoGGpIz8ZejOpnZl06m5/eslQAofyDPs4tojRMaaqkrKbrVW6r6g3qNe3sHwaG3ri2f4OhSxsfpcqPtOGmWVDzfyIZMrrdoeO5VvAWKXm1BjGQfob+wDfZHBm12D2//cKnytfVUyYij/X6Y815zidoo9UCk396hdL+cBWatmWMlgN4AJCFCGksMw+pAtbfAuJPHottt3NyROHsYz1Dq5rLRJCNr7oMIr1Jl8fOcDyIRf+ZGPX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39840400004)(376002)(366004)(451199021)(53546011)(26005)(6506007)(6512007)(83380400001)(38100700002)(122000001)(41300700001)(71200400001)(6486002)(2616005)(31686004)(186003)(478600001)(54906003)(110136005)(91956017)(316002)(66556008)(76116006)(64756008)(66446008)(66946007)(66476007)(4326008)(5660300002)(31696002)(86362001)(2906002)(38070700005)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWNsMTMvYVFSQ3Z1UUhqMmRUa1UrR1VGSlg3SFptdTRncFFPZjl6NHhZVDB6?=
 =?utf-8?B?bDI5aXAxZHBxM3JYUFViYW1zRmdXR1piMEUzVVhMZldaV0RaekZJVjVrN3ZF?=
 =?utf-8?B?OXd6ZFZuUUxNUmlGK0MwQ1dIeTVnclBJWm1MTndYTkMrSzlOaG5ZT0dwWnMw?=
 =?utf-8?B?OE9JR3I4bytnRnQrRzNSMUZRc1dhZTRhdTYwckw4NkFiWWJ1QnR5UjRxVzB6?=
 =?utf-8?B?WUhDUC9rWVRCYkZvWXRHWDlYS0tmbTRkQlc3UDJCbkFJeTQram5oQWZXRlhL?=
 =?utf-8?B?Q0pPeTduM3g1RXdPWk4zaWY3ZXMvMkdsbHZrU29hNHZqY0tjdkMvWDRGZk9P?=
 =?utf-8?B?WVQ3OUZObElKR0tPdnVtZ3B3U1pDYVAxeXV0UTV0TmFCMEd1UTJGYnI1a3hp?=
 =?utf-8?B?K1RZaUJuYkVxSkxkVTBPU1ozbytPZThYdE9Mb2oxKzFacXlQL2RwclQxb01j?=
 =?utf-8?B?REUyaEYwYUxrK1ltamVnNEs4dFNlQnVYNXkwL0dmTVQzVWJZczlxVnpoNEs3?=
 =?utf-8?B?bldaREpFVUhlQmxGcTROanpkaTRKdyt2UXNzMHdtZHV3V3ZWSGk5OStPZmQ0?=
 =?utf-8?B?eStVYjFDM0FqZnNQblNzZjdXaU1LK2dKa1pldkJxTjB5cldKTlhUakZlRldZ?=
 =?utf-8?B?OFRhd2MwWTA1T2FhU0ZPUWJsYmtJZ2xJdFhSdi9XUU5xTGQ4aCt5S3BHZGs2?=
 =?utf-8?B?dVl6TDNGL2c2Z2JQdzMzNUd6Y3A4eHN0WnozSTdqdU82WHJqSlpjSXJraXlI?=
 =?utf-8?B?MWkzejFDZ25OTlVkczhKN0N4NkdXTHNYM3Q1ZkNtSzVMRWNQWnNiZEtLZWdB?=
 =?utf-8?B?SG01cVNhcmJUWFVBNnE0OFpPdXNUSi83ek5CdnV0MmptL0hNS3d4U0VYOUNL?=
 =?utf-8?B?bUt1SE5uZ1FCMXRXYzNJL2NMTzZQYTZNcTFVcXEwTmV1SzRGVUhSMm5pV2Yr?=
 =?utf-8?B?djhueDI0ckZaVGVDNC9yV0FwMmV5bS9ySGxKOGRkNFpoRFZvdkRrL2M1TTdD?=
 =?utf-8?B?b1VqdUo2bTkwRnF3dTZMNWgzeEN1dTFPWVZIbnIwSXJjRXlWRFEvMjZSREdB?=
 =?utf-8?B?WkdQS2FBOWtlOVFoRzF0Z1lmR2JnR0RFNkd6UlpmMURvRjZkY3ZWdXI3VXQ4?=
 =?utf-8?B?d2diYmo2MWYwems0ME5vYVRFUGg5UUd0Q0txcUM2YWlDQ09CNTVtektFZ205?=
 =?utf-8?B?eWpuMU5KbFdQRWhPODFXeFRWSFlLUmREd3JpdFR4dG1Td2JjWUdyREZwMGhY?=
 =?utf-8?B?N2I4MXBJUkNaZEZVRUpDUmVBcWpkTWVra2NEcTFJSWtqR28zSHFUYTIvNU5v?=
 =?utf-8?B?MTFNR1VSNzAyMjFiMkpWbUMzNkNKQkNjNEZQMDVWY3JSTU5hYlZaQzI4K2VT?=
 =?utf-8?B?WGozSUlqSmZWdGtBU3FGM2FXakVBaml5WnVoRnlJZ3drdldqYWFkOE40WC9p?=
 =?utf-8?B?Sm5Sd3Z4MHE2Z2trUHNXbkh6d1VNbnRyNWlGcnA2RDQvRzZaUFJaci9sN3BK?=
 =?utf-8?B?dWdVdG15Q3k3R2xYMlQ5V21HcTdxTDE2L0RzVGEvMWN1K2xDNUdIYXZqNlcw?=
 =?utf-8?B?eUlsY3Y2K1kxck9Qem1SZWl6R3ZnQ1I3aWl2UHgrVnN5RTFvYWhHVnpOVGo1?=
 =?utf-8?B?S25KTDZYTWlJYllpQVZScmtyWU8xZTEyYit5bjJKdXc3OGFBZ3M3MFAxektv?=
 =?utf-8?B?d0E4TFZVOXNIWHpYY0VURW5rdDBvWXhDSkNiWG45S3NaekpYcHhGai9XWmUx?=
 =?utf-8?B?NGJMNjc5bmVkNHdZRzVFUUxKM2h5eE5ISDI1L2MyaWVUUDJodlJXRmIyWXpk?=
 =?utf-8?B?TmtKSklKbE1hTW1QNjE2N3pFVzF5bnM4UThkL2FnZ3lHeGl2QndFVGVBTWYv?=
 =?utf-8?B?d09vTGJBeFh6R0VVa2JSdU9vSVFobExFVkVLMVJSSC9kck9rZDVBeHlmN1RG?=
 =?utf-8?B?NkVsMTk2QmU4ZXZ3d0pYU0lCbmtHNEVnZjZJaFNjVk5jMm1ha05BUkZ0N2lz?=
 =?utf-8?B?eENvam5yNjg5UmlnTHRubi9qMDhSOXdNZ044WTkvU29zSU5xNGRMQU84OU1H?=
 =?utf-8?B?eGtKTGVESDZPSnhPcHZ2TmxUM2p6QWNRN2RXNFZ2UVZ3MmFVK1AyRUxtTWh3?=
 =?utf-8?B?S3hScTBhNWhqbVphRU8wWEZuMWwxSnF1V2pFbjl2bTZ6T1hnbmQ4S3E0VGx4?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7439172927C88048B123E5CDC1659DAA@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a85a74a-fba8-4808-14f2-08db47e53db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 12:36:51.1269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: blc/UW+4nWnsIqibPyogl7iNc4C8WgGK/cwYxT9S1Pj19VeqqAOvhgBeWbd1Guhwp8pWcEQEK52FLQ68z1UF6moUxFImvriIWe46CkUTjC9pfiwAd2dGOH8GlZnvkcEW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1749
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yOC8yMyAxNDozNSwgTWFyayBCcm93biB3cm90ZToNCj4gT24gRnJpLCBBcHIgMjgsIDIw
MjMgYXQgMDg6NDQ6MDZBTSArMDMwMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPj4gSW4gbWFu
eSBjYXNlcyB0aGUgdm9sYXRpbGUgcmVnaXN0ZXJzIGFyZSBleHBlY3RlZCB0byBiZSB3cml0dGVu
IHRvDQo+PiByZWdhcmRsZXNzIG9mIHRoZSBleGlzdGluZyB2YWx1ZSAoYmVjYXVzZSwgdGhlIHZh
bHVlIG9mIGEgdm9sYXRpbGUNCj4+IHJlZ2lzdGVyIGNhbid0IGJlIHRydXN0ZWQgdG8gc3RheSB0
aGUgc2FtZSBkdXJpbmcgUk1XIGN5Y2xlKS4gSW4gZmFjdCwgaXQNCj4+IGlzIHF1ZXN0aW9uYWJs
ZSBpZiB0aGUgdm9sYXRpbGUgcmVnaXN0ZXJzIGFuZCByZWdtYXBfdXBkYXRlX2JpdHMoKQ0KPj4g
Y29uY2VwdHVhbGx5IG1ha2Ugc2Vuc2Ugd2l0aG91dCBkZXZpY2Ugc3BlY2lmaWMgbWFwLT5yZWdf
dXBkYXRlX2JpdHMuDQo+IA0KPiBJIHRoaW5rIHlvdSdyZSBsb29raW5nIGZvciByZWdtYXBfd3Jp
dGVfYml0cygpIGhlcmUuDQoNClllcy4gVGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dCB0byBt
ZS4gVGhpcyBpcyB0aGUgZnVuY3Rpb25hbGl0eSBJIA0Kc2VhcmNoZWQgZm9yLg0KDQpIb3dldmVy
LCBteSBxdWVzdGlvbiByZWFsbHkgd2FzIGlmIHRoZSByZWdtYXBfdXBkYXRlX2JpdHMoKSAoYW5k
IA0KcmVnbWFwX3NldF9iaXRzKCkgLyByZWdtYXBfY2xlYXJfYml0cygpKSBzaG91bGQgYXV0b21h
dGljYWxseSB3b3JrIGFzIA0KcmVnbWFwX3dyaXRlX2JpdHMoKSBmb3Igdm9sYXRpbGUgcmVnaXN0
ZXJzLiBJJ2xsIHRha2UgeW91ciBhbnN3ZXIgYXMgDQoibm8iIC0gYW5kIHRyeSB0byByZW1lbWJl
ciBqdXN0IHVzZSByZWdtYXBfd3JpdGVfYml0cygpIHdpdGggdm9sYXRpbGUgDQpyZWdpc3RlcnMg
d2hpY2ggbWF5IHJlcXVpcmUgZm9yY2luZyB3cml0aW5nIHRoZSB2YWx1ZSBldmVuIHdoZW4gaXQg
aXMgDQpub3QgY2hhbmdlZC4gVGhhbmtzIQ0KDQpZb3VycywNCgktLSBNYXR0aQ0KDQoNCi0tIA0K
TWF0dGkgVmFpdHRpbmVuDQpMaW51eCBrZXJuZWwgZGV2ZWxvcGVyIGF0IFJPSE0gU2VtaWNvbmR1
Y3RvcnMNCk91bHUgRmlubGFuZA0KDQp+fiBXaGVuIHRoaW5ncyBnbyB1dHRlcmx5IHdyb25nIHZp
bSB1c2VycyBjYW4gYWx3YXlzIHR5cGUgOmhlbHAhIH5+DQoNCg==
