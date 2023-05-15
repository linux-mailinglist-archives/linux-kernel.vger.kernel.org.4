Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD492702757
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjEOIgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbjEOIf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:35:58 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2072.outbound.protection.outlook.com [40.107.117.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73E212D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 01:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkV7AddwEfyBfa3KGToJl7KA9GtPRoehz7/HmJMk88YmMnlIUTBxq4Q2TlRxB0JJR5hlMRCRArZA8ezxdDgYQtkx4QIendtaRv0NP4+Lq8cCecZkaPBnGgl0nVnXKG6uDj26PbC8NVDXsxNd7T2aile3pKVdsVGhrUl2K2NOwONUVWQBIJ/OV82KxtxbYtwfFL6ZOa4o8OIu5WBKWKdtJnae0by39nYa0BzB54w+QVrlzZcj6h0T32C74x5e2ZrVEAVoKsfg0RtwE5LMqBdw13ykjyHO/AmS5OYkE3itdBNOkxcl+XQL+hhMdnJqQnF7hWwLjYpq7/5NeOyU0/1zVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFHktSZMlAooy00up1L0r0hZyewfGbGTSAubTpQpouo=;
 b=ZiWjgZ4RkfiQM2dlNT70yzlkemnhu5PFVQ5Fa9/7wZ41vm6Y5d6gUauCokXA4bFhlFUwUBTAGk8YoSs4IzTGNIj9FclmyFe+YFqcRTRbhPuIPcemF7i5FGiVLMN676x49atYMa6gvj4RtuGL0p3s7AfYvGojjp7X6bQyf8iNbNTn98CRO8LKzWW1RlWVThDSivG8cqoGow4/6ry+w/gGVvoccdwWsVhbnVBbwTiCY6tlrKMyGeZEmeOICEeRhq5JBPT96PrBz9Vnd2dAjFnZv6ewg7yi7RVFwIoZAFmgU1+bc8SzyEWDEq3k8e8dlEMpqhLXSe1OwzoxLLHl+UBYpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFHktSZMlAooy00up1L0r0hZyewfGbGTSAubTpQpouo=;
 b=ApOm1ZKZWeyYiE/EVQonUbfK9vi2Si0MvQ5MUazpr9PPt+Y0ZIQg0uXYb28KuiUFymzvLmewU+DTERKKBVNCBNZ+0QXnH6mm6X1HL2+v5EGw3PCXAbuwCsB3MkcKbviWsKF/IqnEjDqmjMRn4w0fhgRY4osrOuaSF01+85vNX39V/PdhGuYLhED3wDMV1fPQy0emocaU4FqGXHMrA95ASvn47saYNhKChoxgs9UAmUq24CuOmYPaUoY1NKxPuHF0+G5bNOowB0w2iGjJhNmwVBS8I4Wrjn3sVzZKEI4wRoZcdZhIOuTy7fg6GzoNyq75EytrLgh5QAwvNVBqgQWooQ==
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com (2603:1096:301:2b::5)
 by TYZPR06MB5323.apcprd06.prod.outlook.com (2603:1096:400:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 08:35:51 +0000
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::85b9:972b:85ce:4d8f]) by PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::85b9:972b:85ce:4d8f%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 08:35:50 +0000
From:   Liming Wu <liming.wu@jaguarmicro.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: RE: [PATCH] perf/arm-cmn: fix compilation issue
Thread-Topic: [PATCH] perf/arm-cmn: fix compilation issue
Thread-Index: AQHZhszCGVW+vZtNKkSJkd2MeAgHr69bAayAgAAAf8A=
Date:   Mon, 15 May 2023 08:35:50 +0000
Message-ID: <PSAPR06MB39429C77A11AA027B2E8EE67E1789@PSAPR06MB3942.apcprd06.prod.outlook.com>
References: <20230515012930.946-1-liming.wu@jaguarmicro.com>
 <ZGHt0OyK6ntqwqR6@FVFF77S0Q05N>
In-Reply-To: <ZGHt0OyK6ntqwqR6@FVFF77S0Q05N>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB3942:EE_|TYZPR06MB5323:EE_
x-ms-office365-filtering-correlation-id: c8bff0c1-b860-49d8-3e58-08db551f63a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LUm7g5E4kYYGB/ct62scJzlHt6e35Nf8H+OiyQGduSxCe/24Buyz6SyxgKOtYgAZnnkpMNh0p01g/BVpBGfndUf5i8WpfmSaRj90eKeBTjaQLm1kd9i3XYASoB6EhF5lD3IKAvRKIDB/NkUh3ZeMUiims5IOnrrX5g1n8B2oeHjoJoPQRWxEdBynXoFT0DmOxpvau53rhuLMM3m4g3+uLd90Ey0LMTGjkh6B74WFP5aS8AIV/Keth9EotA741eUY8HsCgkkWCkvrp9iU8poSDnYUloBi/1Mvox1UkMiyvG98TppqIhYzt7UTpZBB0InvIIIi1152PA0Cdsfo/HMTLyKZbyroewK0YeCKPgU7l9yYyP4dnGveJXjrTdzhp10LC8JpBOw+BXLJrY6X5Aq5UH2I7B+992mM+IZYt5tY2Z0X3XfIWq8YbtaP/8KDg7LQPn0UbToQWdM/KHr/vvYkJ4Mq90jwnTNKHr7G5kjKv/JQnrXXEAK0rkAwthN9BERItXMHmtAEERpfURVzmMz3/2tqjQLz3F7E051pFCyzG6o9OMtzvPCcBLjuq7xMcYU0gtFPvjg67hbWdKl8qdbE7ZiANoo23qNoTWqXDfRD1VGdQB2uOoXLO1GsIKOj32w7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB3942.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39830400003)(396003)(366004)(376002)(451199021)(33656002)(71200400001)(86362001)(54906003)(316002)(66946007)(66476007)(4326008)(6916009)(64756008)(66446008)(76116006)(66556008)(7696005)(478600001)(2906002)(55016003)(8676002)(5660300002)(52536014)(8936002)(41300700001)(44832011)(38070700005)(38100700002)(122000001)(186003)(26005)(9686003)(6506007)(53546011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S002cG9hSTFjN0tiNGZ4VjQ3cjJ5cUE1OUxKSjlzT21nSXA3ekVNZk9DNllH?=
 =?utf-8?B?amVRYXdQaE1PdFVMTGc2K09YenBoOUdqTG9VZldTNkJXUEh5azVqNnlMbmxi?=
 =?utf-8?B?VTNrUGxsMWdQc3hjWXVnQzJxVlJic1ExR1pkZ0pDekdiVUNadW1XbG80NlBN?=
 =?utf-8?B?ampjWUZ1Um8rVm9uOTdzeUxDcXBnc1U2UXQzQVZEWXNLM3pwMHZwL21UUmhu?=
 =?utf-8?B?QU9CR25uQkpMaHJiOUlFSGpLYUF5Z2NNK2I2Q05XcElTMDRKcDVWaUNSc3ow?=
 =?utf-8?B?bXIvRmlBWmIyZTBsMTB4Z3hlWDYwQk9xVkE3UUk4RUgvV3NabjE3SWREMUky?=
 =?utf-8?B?Z0dxdVdXcFphbGN1YUNxV0hkaFFlbFJZU3BwYVlYV0hxVjUraUppcUNic2x6?=
 =?utf-8?B?UlFTL0ZrVUt0TGl3cmJlSllsdGRFUngvdTVHYzVPTVcwM1IvN1U1YUptdEx1?=
 =?utf-8?B?NnNVYXVQZ0kvTEQ5RE10REhDajFxUFdlZDVmSXhyOWFjWDF2K0pQWVVMTWdU?=
 =?utf-8?B?T2tzYTFlVkEzc21xK3B5MmhIbUhRQWtadk1rRXpqcDZ5SElvMUlQNEZZV1F4?=
 =?utf-8?B?cmVxRWY5SzJOaXE0bXM4WllzcFFVSXFldFJuYXRpYm1ocS9PbXJYRExUczRl?=
 =?utf-8?B?T1dLUHhleTc2bVMydk1PODJhTW1ObThYTTYvNEYvYmttVDB1NUpsQ0MvQk5G?=
 =?utf-8?B?UUFOL3F1L3ZZOUQzMm1oU2xNTjFqTk5odzhrL0RsMmpobHhPZVFYVjk4SGQr?=
 =?utf-8?B?cmFvTkVkeXp4QlBtTmphdW1MVEpkeDhwdS8zYlFCTFYvSVdqeHBQZUQwdGU5?=
 =?utf-8?B?eWZYRElhMFpPOEdwVk5SbEhIYWNhVDZOVFQrOTBYY1FUUVgyZkpOekZuVUNV?=
 =?utf-8?B?MTNPMTBHZ0xERS9lbDd0SHEwcWwyZ3o5bmRwVWw1SGZrZTV1TkRFdDIzbHVL?=
 =?utf-8?B?bEVNODlpWnNQRGNZejNucWViU0lXWEhMU1FQRG5xcGpVdG5YTGNGYlNuRHpr?=
 =?utf-8?B?WUNmeUM2TG5xZEQwMzg4dGtSSEJlamplTk5lYkdCb040MHBDQ3ZXc2s0Sk9Q?=
 =?utf-8?B?M0N3anhva0p4Zy81OExYNVVaUkN4RnFQWmhTN1VxQ1VabWNIUi9FQ1lSdnc2?=
 =?utf-8?B?L3FRWjhiNlFRVkRBUkdRNFVtU0gxNTVOaUZNbERpS0NaMis4UjVueWxXcm1q?=
 =?utf-8?B?aUladTg0UlhaazhqcWZ6VzNVekthaEVxOW16c2Zmekp3ZWlNUGVXVGMwMlNZ?=
 =?utf-8?B?clNDam15Q09MVmc3L2JLNjUrNDg2TitIVHBLMzJ2aGo2eXd5ZzNaRW5rSVZv?=
 =?utf-8?B?L2U4eGRHN2Z4U1gzdENqaktoR2FOdFhNdFhVY2pFTEg0d3BqdEV1ZHlmWHJN?=
 =?utf-8?B?UElaY2Z2cTk5dUVjZWdRTEc1emVENVFkeVRNTTNxRHFEV1RuMlA0cktJVi9W?=
 =?utf-8?B?VGUzZkNkd3hKSzdtZUJkQ0lGYjNuc0RtdWhyeDU1NUVLTlgzZnNIallEaXZW?=
 =?utf-8?B?Z09rTFdLQjNkR0s4UC9HeEp1aUFOMG9QN2ovYlJFNVp3VWhXVWZPRHZXYVZ3?=
 =?utf-8?B?UU0xOEFkQU11dU9Xd2hRc0x0TFN1VXRhc3NOWDF6M3E0aW40VGNJVDE0WStD?=
 =?utf-8?B?QU1YRC94OXJBNkUvVVFGWkhCdzdEbGh5VEp2aVhzYjRXOUtMU2NrdXpiUUdQ?=
 =?utf-8?B?dk1ZWCtPNnlsR3NXSEQvTzRqNWwxd3NVR2JIclI3VWpuaGhFR2I1b2czZTJ6?=
 =?utf-8?B?MVVCOC9lRUVzYXhDY1MwODN1a28rK2pObks4c0o2RGRzYUVWTnFURHdsWWVR?=
 =?utf-8?B?cTFkTHRGYmIwZXVNR1ZvNjJkeDdwUXhTZTlFOE1xc1Z3S0ZoMzlmbWVwdTBN?=
 =?utf-8?B?dUpMeXBkVDVkYVRLcDJzaVRTUzNDN01ZTXlXMVNyWFFTM0Z3NnE5cHB6b0U1?=
 =?utf-8?B?MzRLcWpCemZSbHRycE80ZXJKcXhDMmdrdkY4Tzl2RjRKeC9tc0s0cXJ3bUU4?=
 =?utf-8?B?aE41cHpZTVNNN0lGcEVoeXY4NXFaRytVbmthMG1YVG42MzY5S2xhR3ltM0E2?=
 =?utf-8?B?V1cxZEt2WEh4b0VNbUFocmRRTWRrUE5xaEtSYmo0akI3bVNFMlJMWnFweUdz?=
 =?utf-8?Q?F/TPgMgB2FtD7AQwrPUxE3ayu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB3942.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bff0c1-b860-49d8-3e58-08db551f63a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 08:35:50.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /W2QceU93rPOuSF+MA11H6vxnCB5Z4UUUanz6K+jpGHFbEZMo6QTAUotRkEsNUpIbJC+uO3BkI8vDp+/v+30Cl9zNZC0jJXy9ac9ETupgn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGUga2VybmVsIGJ1aWxkcyBhcyBnbnUxMSAoaS5lLiBDMTEgKyBHTlUgZXh0ZW5zaW9ucykg
c2luY2UgY29tbWl0Og0KPiANCj4gICBlOGMwNzA4MmE4MTBmYmI5ICgiS2J1aWxkOiBtb3ZlIHRv
IC1zdGQ9Z251MTEiKQ0KPiANCj4gLi4uIHNvIHRoYXQgd2FybmluZyBzaG91bGRuJ3QgYmUgaGFw
cGVubmluZy4NCj4gDQo+IEhvdyBhcmUgeW91IHRyaWdnZXJpbmcgdGhpcz8gSGF2ZSB5b3UgbW9k
aWZpZWQgS0JVSUxEX0NGTEFHUz8NCg0KVGhhbmtzIGZvciByZXBseS4NClRoaXMgZXJyb3Igb2Nj
dXJzIGZvciBJIGNvbXBpbGVkIHRoZSBhcm4tY21uIG1vZHVsZSBzZXBhcmF0ZWx5Lg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRs
YW5kQGFybS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDE1LCAyMDIzIDQ6MzEgUE0NCj4gVG86
IExpbWluZyBXdSA8bGltaW5nLnd1QGphZ3Vhcm1pY3JvLmNvbT4NCj4gQ2M6IHdpbGxAa2VybmVs
Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgcm9iaW4ubXVycGh5QGFybS5jb20NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gcGVyZi9hcm0tY21uOiBmaXggY29tcGlsYXRpb24gaXNzdWUNCj4gDQo+IE9uIE1v
biwgTWF5IDE1LCAyMDIzIGF0IDA5OjI5OjMwQU0gKzA4MDAsIGxpbWluZy53dUBqYWd1YXJtaWNy
by5jb20NCj4gd3JvdGU6DQo+ID4gRnJvbTogTGltaW5nIFd1IDxsaW1pbmcud3VAamFndWFybWlj
cm8uY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBpcyB1c2VkIHRvIGZpeCBmb2xsb3dpbmcgY29t
cGlsYXRpb24gaXNzdWUgd2l0aCBsZWdhY3kgZ2NjDQo+ID4gYW5kIGRlZmluZSB2YXJpYWJsZXMg
YXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgZnVuY3Rpb24NCj4gPg0KPiA+IGVycm9yOiDigJhmb3Li
gJkgbG9vcCBpbml0aWFsIGRlY2xhcmF0aW9ucyBhcmUgb25seSBhbGxvd2VkIGluIEM5OSBvciBD
MTEgbW9kZQ0KPiA+IDIwOTggfCAgICAgICAgICAgICAgICAgZm9yIChpbnQgcCA9IDA7IHAgPCBD
TU5fTUFYX1BPUlRTOyBwKyspDQo+IA0KPiBUaGUga2VybmVsIGJ1aWxkcyBhcyBnbnUxMSAoaS5l
LiBDMTEgKyBHTlUgZXh0ZW5zaW9ucykgc2luY2UgY29tbWl0Og0KPiANCj4gICBlOGMwNzA4MmE4
MTBmYmI5ICgiS2J1aWxkOiBtb3ZlIHRvIC1zdGQ9Z251MTEiKQ0KPiANCj4gLi4uIHNvIHRoYXQg
d2FybmluZyBzaG91bGRuJ3QgYmUgaGFwcGVubmluZy4NCj4gDQo+IEhvdyBhcmUgeW91IHRyaWdn
ZXJpbmcgdGhpcz8gSGF2ZSB5b3UgbW9kaWZpZWQgS0JVSUxEX0NGTEFHUz8NCj4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogTGltaW5nIFd1IDxsaW1pbmcud3VAamFndWFybWljcm8uY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL3BlcmYvYXJtLWNtbi5jIHwgMTMgKysrKysrKystLS0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGVyZi9hcm0tY21uLmMgYi9kcml2ZXJzL3BlcmYvYXJtLWNt
bi5jIGluZGV4DQo+ID4gNDdkMzU5ZjcyOTU3Li4yMjk5ZmNkZTViNGEgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9wZXJmL2FybS1jbW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGVyZi9hcm0tY21u
LmMNCj4gPiBAQCAtMjAwOSw4ICsyMDA5LDExIEBAIHN0YXRpYyBpbnQgYXJtX2Ntbl9kaXNjb3Zl
cihzdHJ1Y3QgYXJtX2NtbiAqY21uLA0KPiB1bnNpZ25lZCBpbnQgcmduX29mZnNldCkNCj4gPiAg
CXUxNiBjaGlsZF9jb3VudCwgY2hpbGRfcG9mZjsNCj4gPiAgCXUzMiB4cF9vZmZzZXRbQ01OX01B
WF9YUFNdOw0KPiA+ICAJdTY0IHJlZzsNCj4gPiAtCWludCBpLCBqOw0KPiA+ICsJaW50IGksIGos
IHA7DQo+ID4gIAlzaXplX3Qgc3o7DQo+ID4gKwl2b2lkIF9faW9tZW0gKnhwX3JlZ2lvbjsNCj4g
PiArCXN0cnVjdCBhcm1fY21uX25vZGUgKnhwOw0KPiA+ICsJdW5zaWduZWQgaW50IHhwX3BvcnRz
Ow0KPiA+DQo+ID4gIAlhcm1fY21uX2luaXRfbm9kZV9pbmZvKGNtbiwgcmduX29mZnNldCwgJmNm
Zyk7DQo+ID4gIAlpZiAoY2ZnLnR5cGUgIT0gQ01OX1RZUEVfQ0ZHKQ0KPiA+IEBAIC0yMDY3LDkg
KzIwNzAsOSBAQCBzdGF0aWMgaW50IGFybV9jbW5fZGlzY292ZXIoc3RydWN0IGFybV9jbW4gKmNt
biwNCj4gdW5zaWduZWQgaW50IHJnbl9vZmZzZXQpDQo+ID4gIAljbW4tPmRucyA9IGRuOw0KPiA+
ICAJY21uLT5kdG1zID0gZHRtOw0KPiA+ICAJZm9yIChpID0gMDsgaSA8IGNtbi0+bnVtX3hwczsg
aSsrKSB7DQo+ID4gLQkJdm9pZCBfX2lvbWVtICp4cF9yZWdpb24gPSBjbW4tPmJhc2UgKyB4cF9v
ZmZzZXRbaV07DQo+ID4gLQkJc3RydWN0IGFybV9jbW5fbm9kZSAqeHAgPSBkbisrOw0KPiA+IC0J
CXVuc2lnbmVkIGludCB4cF9wb3J0cyA9IDA7DQo+ID4gKwkJeHBfcmVnaW9uID0gY21uLT5iYXNl
ICsgeHBfb2Zmc2V0W2ldOw0KPiA+ICsJCXhwID0gZG4rKzsNCj4gPiArCQl4cF9wb3J0cyA9IDA7
DQo+IA0KPiBOb25lIG9mIHRoZXNlIGFyZSBmb3IgbG9vcCBpbml0aWFsIGRlY2xhcmF0aW9ucy4g
RXZlbiBpZiB3ZSB3YW50ZWQgdG8gYXZvaWQgdGhlDQo+IHdhcm5pbmcsIHRoZXJlJ3Mgbm8gbmVl
ZCBmb3IgdGhlc2UgdG8gY2hhbmdlLg0KPiANCj4gPg0KPiA+ICAJCWFybV9jbW5faW5pdF9ub2Rl
X2luZm8oY21uLCB4cF9vZmZzZXRbaV0sIHhwKTsNCj4gPiAgCQkvKg0KPiA+IEBAIC0yMDk1LDcg
KzIwOTgsNyBAQCBzdGF0aWMgaW50IGFybV9jbW5fZGlzY292ZXIoc3RydWN0IGFybV9jbW4gKmNt
biwNCj4gdW5zaWduZWQgaW50IHJnbl9vZmZzZXQpDQo+ID4gIAkJICogZnJvbSB0aGlzLCBzaW5j
ZSBpbiB0aGF0IGNhc2Ugd2Ugd2lsbCBzZWUgYXQgbGVhc3Qgb25lIFhQDQo+ID4gIAkJICogd2l0
aCBwb3J0IDIgY29ubmVjdGVkLCBmb3IgdGhlIEhOLUQuDQo+ID4gIAkJICovDQo+ID4gLQkJZm9y
IChpbnQgcCA9IDA7IHAgPCBDTU5fTUFYX1BPUlRTOyBwKyspDQo+ID4gKwkJZm9yIChwID0gMDsg
cCA8IENNTl9NQVhfUE9SVFM7IHArKykNCj4gDQo+IFRoaXMgc2hvdWxkbid0IGJlIG5lY2Vzc2Fy
eSBnaXZlbiB0aGUgamVybmVsIGJ1aWxkcyBhcyBnbnUxMS4NCj4gDQo+IFRoYW5rcywNCj4gTWFy
ay4NCj4gDQo+ID4gIAkJCWlmIChhcm1fY21uX2RldmljZV9jb25uZWN0X2luZm8oY21uLCB4cCwg
cCkpDQo+ID4gIAkJCQl4cF9wb3J0cyB8PSBCSVQocCk7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMjUu
MQ0KPiA+DQo=
