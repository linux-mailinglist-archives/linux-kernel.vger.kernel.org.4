Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C30B65BF99
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbjACMF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjACMFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:05:11 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2126.outbound.protection.outlook.com [40.107.113.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E53300;
        Tue,  3 Jan 2023 04:05:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAmZcxJsrAH6cIbfQCWgj8shqhgpZmXS1c1WqjjMmEvlP8IOcGqvTbvoPj9d8iB2to3Z9LJQmb0RWLzpuYOGXGMrFHjC3ZS8OnC1FTOZ/vYZGdvumsZitiBrrqmS/IdC9qjEYNdZdJ9wMOYdBvJ/0YJYOLrZkoVFTqy40XYlxaEj0KDOiZ5cW3emi+m/FZ9n/jflUiurbrzuMloNC0Oju38PqfzYpIOJ84FDkfRUl4f8uH9i/yf6v2yAoTzyiORe2umWNlu0rP6hgxrM45BtOzIZ9wOD85RXkUh114iYH/OL9o38KTppF9Wt9D6jbt2AwDErdXIw/f+Ab/nQrgw3ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzuXU/4GlWz785kvA1vY6LJIdrkmZlJyYlhiYRIuPsQ=;
 b=bDJ/UmSArqE88B1CB7uabrX3khzdGxIjFXVulw3eQAWQ3L/DRLKntexyvSQwjhtIvusUxinzppkunciUua5//Dp2VUGi3o6Ihhj+EQjYCZ0+4MHT4/vZ7tcLh4xGJ5+AlBvo3jW1MWAjCc7X9bUWGmhBa+AQWDyVb9DPzVHUG6UiTmVu73VkoXnwU8HUNvzEwJ0HtWLkLajGWFpqJiLZCMnQpJnXQcQJcDHm7xBU1Z9uz4QDPyiQPDxQ72rXuDArNjniQFxAmiW0BCMru/19rp4rLRH/kl89J90Q4/WwfNoWwCALav37U0F7hUqXSYc7o9lxqVMtdrFDJXrR2aW9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzuXU/4GlWz785kvA1vY6LJIdrkmZlJyYlhiYRIuPsQ=;
 b=KiOoXjXLIqeE7x98OECb+lGs6XFOiirs77jPnr96D0cjQMAal/8nyHstinOd3HG7wm7/eGk8Cefb5BePi7qFtHTkYvq0UtEqu0JayNuaBNMsRN5rzaKZfvsbIA5seLF9PGcN4nveBaAHYD3l92evHciT0lM12Z02HmAfHwRLfGU=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYWPR01MB9922.jpnprd01.prod.outlook.com (2603:1096:400:230::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 12:05:06 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 12:05:06 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
Thread-Topic: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
Thread-Index: AQHZFYCNlCsLkG/3E0Cexn6vTGGaoK6McgmAgAAOnPA=
Date:   Tue, 3 Jan 2023 12:05:06 +0000
Message-ID: <TYWPR01MB87758FB15ED12D396AE738DDC2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
 <20221221210917.458537-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdXDwEUzBpG+w_G6=CzKo=n92cdVw6v8JwOwf9o86HnOZQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXDwEUzBpG+w_G6=CzKo=n92cdVw6v8JwOwf9o86HnOZQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYWPR01MB9922:EE_
x-ms-office365-filtering-correlation-id: 06a0b2d6-8097-4514-ccb3-08daed82c0c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t1H4xvgRkaBZJ+IbRBnsKiCDUEdEp8gNTWLbqst8AobsfoRUBETuYHrPCjTATNNMpzZPNpU9Jrn9NBzLB5jubOgQSF11PNFTxw60Gn0J0pZFw5EycwGQAVF3YXP5pc1la8zhGz8BvY62R7bhV1LdSaztyHRrsTyH1WD7I7/l6EhsQ1MC0aN657/uZ8WHacRhO5JoEXv9VIgZwCQs/9SomMOhEv0aHbK/dWB/UfkMUtTPClrGDacr9Si6YXyXXfxDL479v4JtI9LEna5uwdHxvmMkQUAgq+3FmHxfIlv9MPVilC3/iEUOsdXopOkhF8KolpspPJpsmgKvMZG+Aw1zEbHD0sDniv8XmWsT0nLLD5bxFuyiTK0m9XE3Ohusi8HAh1VssgpqPnAA+8PISOaJygE+8iPmiL51MeYxWSvx3wZMxHqWJBSPey+0+1d9T9OFqAyjxztD9BRICfc4DngStRBbQvwislOTrstArKlxow5+kHzvlL7M3l7/Krhd2Sj++x+1pM82TJEWIersoV2CtxqN+hHF4v0yZydcjrstCkwCzFf9jfFcCopZCq7h8JZ4s4P5yfgbjCcCTA4H38tYY6r8DTC5xBzeU9+V4zLE+RQhXSxz99BcDOYWESGg3OnrD+UyfNDLrsNS6eLL6mVxNh98ceJchJm/LkqJIbKxl8/xCPn7NYnqmH7OyznXHV5LTwlNCK9fsGIgU2r8X5Ghia0PNA68wRfRC9pSD2sJMMk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(41300700001)(122000001)(38100700002)(52536014)(8936002)(76116006)(5660300002)(66946007)(66556008)(86362001)(66446008)(4326008)(8676002)(66476007)(64756008)(7416002)(7696005)(33656002)(38070700005)(6506007)(316002)(54906003)(53546011)(2906002)(6916009)(83380400001)(9686003)(71200400001)(26005)(55016003)(186003)(478600001)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2RKZm15RmF5RlJDYithb1hQR0w2dlp4MncvYmdCUUt4ZUcrN1VLN0cwZzJZ?=
 =?utf-8?B?QTRMYlZMYUJtbFcwSUlSV0ZSM3dISDgzNnQxWEVZcU1TcVRHampFdUVjdnhX?=
 =?utf-8?B?UGg1aTZBa1Q0Z3MwQXJ1dFRoK2lEV25vNFBmZWRFRDd3QUsya2dDNE9JNStm?=
 =?utf-8?B?bnhNSzZGRjYvZi9tOC9TNFZsc3NTeDA0YUhwb0RiNHBoT1BueUdxcTlhNHVj?=
 =?utf-8?B?RVprVksrSkhyNnRrblF4TE0yMjBhcVY5SFV2NlRJMmlMZFlDQ1ZySVFyOXhu?=
 =?utf-8?B?WU9zUmdldUxqWDFQWDZPWGR0L08rRWZUK2hKdWhQS1dVYWkzTFFMVHJSVFd1?=
 =?utf-8?B?TWZlUWNCYzBUb1FXTXB6R1RXOXhFbGcwaFJwQzF6TjdzQVVEWmg5TU56QW9q?=
 =?utf-8?B?TTZmY1VHMVN5dUhId2pkalJlTVUvd3p5dTNpNWNrQUNwNGxqb1lsVjh3aGhN?=
 =?utf-8?B?YWpiZTBvN3c4dFFHRThLTlBsZStwYzlGUDBjNmFySGM4NkZZa0U2R3BzZ2Zs?=
 =?utf-8?B?Q25FRU9aUlJnK1ZFejdaR3BSb1dyemZKZXJ6TDVqOXdmT2R0czBVQWNiTTNO?=
 =?utf-8?B?MXhtVEhvVFo4MWJoZTl1ak55c0NVcTNGZStQNzJ1dUhOOFdZS090NUc5ZWIz?=
 =?utf-8?B?M0Y3Ni9KSnNOdUN1bkZYQ2o2aXU0WVkzbUVpbTVKMTB2RjdCOGRuNXZmc1pY?=
 =?utf-8?B?dFVDUFlZN2dUNzBEYlhXU1Q5cjRSNE53ZkVydmYxUThCK3QxZlk2cUxPblVm?=
 =?utf-8?B?RTRhaTV5cUtibUplTHVlOXpLRnhnRjFTL0tUU1JBSWpKdzJJYThEenVRRHdG?=
 =?utf-8?B?cTNpOHJqeVR2V084VkVKdTNMWVV5NjFjdE5GVlpOR2o2eVBvTGFENGFDSmJ3?=
 =?utf-8?B?dmhOU2s3bzRYQWUxLy9GdUpmL1FIK0t0K1A1L05SRk9jclNsTUpIL1V1U3JQ?=
 =?utf-8?B?MlhXNEdnVEdwUy95Z0hzRndHOHQ1RkFqRXFIa280MnRsdDJqakc4Szk0MFhw?=
 =?utf-8?B?Y0twd0srenZFaXU2a2ErUnZEaEg5Yks5RTE3Tks3UHlEYjlsaUN0c04rVDlq?=
 =?utf-8?B?aGhUbXJGMUttOVdEL2ttYk9xV0R6dGpSRFc3R01tT25OYXFTYmRHZ0RrdVVX?=
 =?utf-8?B?bGo4bkpWaXBIc3JxR052TWZyaXBiNlQ0bTdGb05JUGlkakxSZjc2S1Q0SURK?=
 =?utf-8?B?QURxZUQreTRrSndyd2hhYmRXMGJoOHArR3EzODM1SGErWXIvaVNlaHRJOXIw?=
 =?utf-8?B?VEloVlZkNTRkdEF5MFR2SE1nbDFaWHc5MDBCdWdIOUp2YWUzdjAyRW5FS2VK?=
 =?utf-8?B?TXQxeC85akVjSjBPMXI1SUpQZ2ZWUDQrK014VnpodWtMd0k4MUx6SlVTZmI0?=
 =?utf-8?B?Z0hIeEZaam9DU3h6VElNN3ZKek1kcXpIUWw1QStJT0JDdUVzUHJUbDdEUDJK?=
 =?utf-8?B?Umw5aFZUREVSR1Q2NERoVi95c2dVd2JTWUZvUkVGV0dFeHlWMlY1N21SaTh4?=
 =?utf-8?B?Z21kMjQ0MGpvancvWXY1cEFHWnlCQjByOTZPai9GNXEycEdsYTd4UVEzaTIr?=
 =?utf-8?B?MFQ5MG5QbVNjYTRaVW9sLzNzMVY1d3NzUGFPWis5OXB5b1FmbENRMHJHWkpZ?=
 =?utf-8?B?OUc3V3FlWVJrNzN5VHZOREhlS1Mveit1RlFVbjVocUhuYUlXNDUzNEtULzBn?=
 =?utf-8?B?VE5ZV0Nidit2bXN5S1dIRGFnNTdDeGU1UlMxM2JlaFNQZnBYY2ZaNkFYTEVI?=
 =?utf-8?B?SWRDSWFzU3ZnTU9Yb0hmbmdOUTRjZnVjcVZjU2pRV00vUmZlRi9DT2RaY1N3?=
 =?utf-8?B?TkRWNHk2YTM0S0dTRDhOUUZ3ZFpzc2xZekVaQ25FRytXaHIya2lPMGJ6ai93?=
 =?utf-8?B?dkRvMUZpK0Vzd2cyMHZvdmM0N3F0bENxd0lhbXQ1SVdobE15MTFQd0JOcmwx?=
 =?utf-8?B?VEkvNXB1YXJMdjRvVHl5bGlVMDJ3QnIyNHdlTGdNaEp6OStlMUcvc1ZuYWJE?=
 =?utf-8?B?L205L3dwVFIrVUE2WkdIWHNEREpSUWdOam5UZ0kramVYWjJuOTEzWldUYlF2?=
 =?utf-8?B?eUJSM21mK2RTR0gxckh5VEkwWW9Rb3V2RlFtV3cvQnBSSXVJRFJ4Nm5uNndK?=
 =?utf-8?B?cGFQZ1BGend4QnBjMWsxTE5aM2pRZ3pqaFlvYWZtckdQdytnK0JsTUFrdEF4?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a0b2d6-8097-4514-ccb3-08daed82c0c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 12:05:06.1572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4rER3d0BEy6QX06BjjEVi5F9js1SRueFfN3YB3gmjhvgolUstMEf38nn40PrgP6aZaWguoAF6XsYxqBp40B0gHUHT+rSSfWR/IuC76LwSz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9922
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02
OGsub3JnPg0KPiBTZW50OiAwMyBKYW51YXJ5IDIwMjMgMDg6MzcNCj4gVG86IEZhYnJpemlvIENh
c3RybyA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPg0KPiBDYzogTGludXMgV2FsbGVp
aiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPjsgQmFydG9zeiBHb2xhc3pld3NraQ0KPiA8YnJn
bEBiZ2Rldi5wbD47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2Yg
S296bG93c2tpDQo+IDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBTZWJhc3Rp
YW4gUmVpY2hlbCA8c3JlQGtlcm5lbC5vcmc+Ow0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0
K3JlbmVzYXNAZ2xpZGVyLmJlPjsgTGVlIEpvbmVzIDxsZWVAa2VybmVsLm9yZz47DQo+IGxpbnV4
LWdwaW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgQ2hy
aXMgUGF0ZXJzb24NCj4gPENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbT47IEJpanUgRGFzIDxi
aWp1LmRhc0BicC5yZW5lc2FzLmNvbT47IGxpbnV4LQ0KPiByZW5lc2FzLXNvY0B2Z2VyLmtlcm5l
bC5vcmc7IExhdXJlbnQgUGluY2hhcnQNCj4gPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJk
LmNvbT47IEphY29wbyBNb25kaSA8amFjb3BvQGptb25kaS5vcmc+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMi80XSBtZmQ6IEFkZCBSWi9WMk0gUFdDIGNvcmUgZHJpdmVyDQo+IA0KPiBIaSBG
YWJyaXppbywNCj4gDQo+IE9uIFdlZCwgRGVjIDIxLCAyMDIyIGF0IDEwOjA5IFBNIEZhYnJpemlv
IENhc3Rybw0KPiA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBU
aGUgRXh0ZXJuYWwgUG93ZXIgU2VxdWVuY2UgQ29udHJvbGxlciAoUFdDKSBJUCAoZm91bmQgaW4g
dGhlDQo+ID4gUlovVjJNIFNvQykgaXMgYSBjb250cm9sbGVyIGZvciBleHRlcm5hbCBwb3dlciBz
dXBwbGllcyAocmVndWxhdG9ycw0KPiA+IGFuZCBwb3dlciBzd2l0Y2hlcyksIGFuZCBpdCBzdXBw
b3J0cyB0aGUgZm9sbG93aW5nIGZlYXR1cmVzOiBpdA0KPiA+IGdlbmVyYXRlcyBhIHBvd2VyIG9u
L29mZiBzZXF1ZW5jZSBmb3IgZXh0ZXJuYWwgcG93ZXIgc3VwcGxpZXMsDQo+ID4gaXQgZ2VuZXJh
dGVzIGFuIG9uL29mZiBzZXF1ZW5jZSBmb3IgdGhlIExQRERSNCBjb3JlIHBvd2VyIHN1cHBseQ0K
PiA+IChMUFZERCksIGl0IGNvbWVzIHdpdGggR2VuZXJhbC1QdXJwb3NlIE91dHB1dHMsIGFuZCBp
dCBwcm9jZXNzZXMNCj4gPiBrZXkgaW5wdXQgc2lnbmFscy4NCj4gDQo+IFRoYW5rcyBmb3IgeW91
ciBwYXRjaCENCj4gDQo+ID4gVGhlIFBXQyBpcyBiYXNpY2FsbHkgYSBNdWx0aS1GdW5jdGlvbiBE
ZXZpY2UgKE1GRCksIGl0cyBzb2Z0d2FyZQ0KPiA+IHN1cHBvcnQgY29tZXMgd2l0aCBhIGNvcmUg
ZHJpdmVyLCBhbmQgc3BlY2lhbGl6ZWQgZHJpdmVycyBmb3INCj4gPiBpdHMgc3BlY2lmaWMgZmVh
dHVyZXMuDQo+IA0KPiBJIGhhdmUgdG8gYWRtaXQgSSdtIG5vdCBzdWNoIGEgYmlnIGZhbiBvZiBN
RkQuICBJbiB0aGlzIGRyaXZlciwNCj4geW91IGFyZSBub3QgZXZlbiBzaGFyaW5nIHJlc291cmNl
cyBpbiB0aGUgTUZEIGNlbGxzLCBqdXN0IHRoZSBtYXBwZWQNCj4gcmVnaXN0ZXIgYmFzZS4gIFNv
IEkgdGhpbmsgeW91IGNhbiBlYXNpbHkgc2F2ZSArMTAwIExvQyBhbmQgcmVkdWNlDQo+IG1haW50
ZW5hbmNlIHN5bmNocm9uaXphdGlvbiBvdmVyaGVhZCBhY3Jvc3Mgc3Vic3lzdGVtcyBieSBqdXN0
IGhhdmluZw0KPiBhIHNpbmdsZSBub24tTUZEIGRyaXZlciBpbnN0ZWFkLg0KPiANCj4gRGlkIHlv
dSBwaWNrIE1GRCBiZWNhdXNlIHRoZSBQV0MgcG93ZXJvZmYgZmVhdHVyZSBkZXBlbmRzIG9uIGJv
YXJkDQo+IHdpcmluZywgYW5kIHRodXMgaXMgb3B0aW9uYWw/DQoNCkkgYW0gbm90IGEgYmlnIGZh
biBvZiBNRkQsIGVpdGhlci4NCkkgcGlja2VkIE1GRCBiZWNhdXNlIHdlIHdlcmUgbm90IDEwMCUg
c3VyZSBvZiB3aGF0IHRoZSBJUCBjb3VsZCBkbw0Kd2hlbiB3ZSBzdGFydGVkIHdvcmtpbmcgb24g
aXQuDQpJIGhhdmUgcmVjZWl2ZWQgbW9yZSBpbmZvcm1hdGlvbiByZWdhcmRpbmcgdGhlIElQIG5v
dyAod2hpY2ggSSBkb24ndA0KaGF2ZSB0aGUgbGliZXJ0eSB0byBkaXNjdXNzKSwgSSBhbSBzdGls
bCBub3QgMTAwJSBzdXJlIHRoYXQncyBhbGwNCm9mIGl0LCBidXQgYmFzaWNhbGx5IGl0cyBzdXBw
b3J0IG1heSByZXF1aXJlIGV4cGFuc2lvbiBsYXRlciBvbi4NCg0KSSBsaWtlZCB0aGUgc29sdXRp
b24gYmFzZWQgb24gc3lzY29uIGFuZCBzaW1wbGUtbWZkIGZvciBzZXZlcmFsIHJlYXNvbnMsDQpi
dXQgaGF2aW5nIGRyb3BwZWQgc3lzY29uIGFuZCBzaW1wbGUtbWZkIGR1ZSB0byBpc3N1ZXMgd2l0
aCB0aGUgZHQtYmluZGluZ3MNCkkgaGF2ZSBtb3ZlZCBvbiB3aXRoIGEgY29yZSBkcml2ZXIgdG8g
aW5zdGFudGlhdGUgdGhlIHJlcXVpcmVkIFNXIHN1cHBvcnQuDQpXZSBjb3VsZCBvZiBjb3Vyc2Ug
bW92ZSB0byBhIHVuaWZpZWQgZHJpdmVyIGlmIHRoYXQgbWFrZXMgbW9yZSBzZW5zZT8NCklmIHdl
IHdlcmUgdG8gbW92ZSB0byB1bmlmaWVkIGRyaXZlciwgdW5kZXIgd2hpY2ggZGlyZWN0b3J5IHdv
dWxkIHlvdQ0Kc3VnZ2VzdCB3ZSBwdXQgaXQ/DQoNCj4gDQo+IEFyZSB0aGVyZSBhbnkgb3RoZXIg
TUZEIGNlbGxzIHBsYW5uZWQgKGUuZy4gcmVndWxhdG9ycykgdG8gYmUgYWRkZWQNCj4gbGF0ZXI/
IFRoZSBwdWJsaWMgZGF0YXNoZWV0IGRvZXMgbm90IGxpc3QgdGhlIGFjdHVhbCByZWdpc3RlcnMg
b2YgdGhlDQo+IGJsb2NrLCBvbmx5IGEgaGlnaC1sZXZlbCBvdmVydmlldyB3aXRoIChyYXRoZXIg
ZGV0YWlsZWQpIGJlaGF2aW9yYWwNCj4gaW5mb3JtYXRpb24uDQoNCk5vIE1GRCBjZWxscyBhcmUg
cGxhbm5lZCBmb3Igbm93LCBidXQgSSBjYW4ndCBleGNsdWRlIHdlIHdvbid0DQpoYXZlIGFueSBp
biB0aGUgZnV0dXJlLg0KDQpUaGFua3MsDQpGYWINCg0KPiANCj4gVGhhbmtzIQ0KPiANCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9tZmQvcnp2Mm0tcHdjLmgNCj4gDQo+ID4g
K3N0cnVjdCByenYybV9wd2NfcHJpdiB7DQo+ID4gKyAgICAgICB2b2lkIF9faW9tZW0gKmJhc2U7
DQo+ID4gK307DQo+ID4gKw0KPiA+ICsjZW5kaWYgLyogX19MSU5VWF9SWlYyTV9QV0NfSF9fICov
DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9m
IExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4g
cGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNl
bGYgYSBoYWNrZXIuDQo+IEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkg
anVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlDQo+IHRoYXQuDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==
