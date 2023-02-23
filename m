Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CD46A03F1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjBWIiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBWIiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:38:03 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2053.outbound.protection.outlook.com [40.107.12.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564DD61B4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:38:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hltx2FtLXcrLs2RsKVQH848929hXtshhev/02cMVM5Dzl4nw0nFiXbGK/HZ8y+XVyf25TzcQBlzlFruUeqRvAjcGj9zhkFNRADw0apfhVeiWtsQUZyaH+ulSur4XPNKtf6+QPhw92g5o3lftnIA0IbGt9MpBP37FSWp5wou17AkDld7Q2uCe/eS9L8TwAK6hseiDFo4jIEHiBP3Aa2u6RHIuX1/zZAciES7yg/aK7wZ6D2F66A0W2y689ERnlOs/7ZSMUmhaGoMtCIYCscIWvxHm/DR49spW+7HNtUsIDTSNCP29V/8p7VGUJ1wTBD/ZFoA24qJepipGV5JdZaVXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdZ8nkg489VoXKNgChgIS5opyUhUMfhqLkChP4Jv1ng=;
 b=NaOh/fQjVimFgtZndq5UtFhGtik6qS5eM2VoPLgW98LpQNucEDF59dYjghdA1QfSENw5qQjfZwhP5xER7r9Ze0mNN/xOoKVMTBYAJ251i6jr9iTRK+OGgkMiiCdfPVnOr/8ND1ODzhxCDVAJIdDUdT/tnNBlyLzmMWYvIY90/XzfqdPpcbn/P4uZjoO5a4xCEksieSXA8BI9aCP2Mg8OuMiWHJmbj5jgdLlFJRoJ9H4w1Q31GuNDT73jKz9nB55qsvfvYPWXGk+ZAvA+azWmb1ym2w8BDEn0WrC8Y9y9Cy3EFxQ3G3TfIbpYvkEwcy6lJTXL76Niz7ein7zlsXe+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdZ8nkg489VoXKNgChgIS5opyUhUMfhqLkChP4Jv1ng=;
 b=oGKtbInCcOs2PU600/qYkOA2vW6PPYf7Q/eEryYY/yaoqFJPlRBXCFCD0H0mVKV22nQCa4sUHVLJiEI4icHiOXtfsCRNXotG3RayhghcbphawBfYgspD4nBnjlCimKMi7aJHfMllZkgkRS7p/daHE/Lcqd+jzQLBdDBJUbqIFU/2+yEVnJ6I2Oc4+MkzL1C9uUYkN02TB37TXs96iQ6i6Pl1I4GSxgLJOPdL0/9UtBPbeSCJvdCcSXawXGV9mhkuVk5thOWZgjpHbkivBSzJ3L4ecydM+/AxOfcI4alQIqPpq/3LloxQNmSdak93WRs9nic/AggXFVkFtedeu9+tCA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2200.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:17::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 08:37:58 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%5]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 08:37:58 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
CC:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v4 00/17] powerpc/85xx: p2020: Create one unified machine
 description
Thread-Topic: [PATCH v4 00/17] powerpc/85xx: p2020: Create one unified machine
 description
Thread-Index: AQHZRswDxfEVhmDC4EiMolm+JWi+Dq7bR6kAgADvAIA=
Date:   Thu, 23 Feb 2023 08:37:58 +0000
Message-ID: <ad8e4adc-2efb-d93e-1221-3a829b454edf@csgroup.eu>
References: <cover.1677076552.git.christophe.leroy@csgroup.eu>
 <20230222182232.uiiwy5pd5n5xc5kl@pali>
In-Reply-To: <20230222182232.uiiwy5pd5n5xc5kl@pali>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2200:EE_
x-ms-office365-filtering-correlation-id: 682eca9c-9319-42d7-8520-08db1579443f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0NArgViwVJ1N3nNUqoEcNiaK7MrTWHMLRAkBooDmbrqEqRrWUj8BJqKIvZmH5hw+dtdaZxL5+PXJedqOraVe2r6dzr3KBZCeYG/8aH859/9jeWENrToDwjkw41Za5IrtdJpbyB49u/B2sfycPQUGZesaZLfTsuOCZ8/T7n7OwCvM1Kjc4xBDP+diCxOtFEi8+4DADn7MDr7ytK5JiAyyls9MaOtOrAHg7A4eBKHUJYELM7qCm7NixqFs7Wh/EJbsimSBDjt88QEf5Xwo2ax6nrkJ/6HhmB7NNJBeNJFdAop+H89ceC7HE/O8Q9iBvUUAROHDYy4Pr2WJlvlQgZLcmKATNKzaWPq394j4MGDG6sU5WyJUVHJKgKOgtxZ4oXTf/raJazZaTxub4BBdgMEGDJhuWR1K9EAJQk3L/QJlvpWPQjFOkhcDVo38ZLjlWMWHowX9+S2f8Rvdks3fjIN7D8d5jw63rEcV0UGL2MThFHlMiUKxoQ45vxoxj3S5Fv9rnSOx/7wUxCoudn1njFe3DYkvchB9gvS+Q+pPfpMeGrz192bJ0HKPXXfJyqe10GqinE7UfiNHf2wiQvgeORWSOv7hOOmZ3D7h+GDFHIIrvk/s8qY0jpL4nrPRw5J/ZBnJp4z0UT14sbuip3Fc60H0HVqTyRY8DmNm9RmyDLz2WCP0P8Ms3LijNmhKyHSIfT4VzUM8aZhbX4G3jO1fPhXe6Ihz95LihSthtyYLOrJLRFYE7wMwo6H/I/0S6XiIht6Qj1frdVaRPVJdL4VbvgbaoQLo8S00YnM6g64KNvOS02K+Mtjznwn5JYz3YifU6zQm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(396003)(39850400004)(346002)(136003)(451199018)(71200400001)(26005)(186003)(31686004)(2616005)(966005)(6486002)(6512007)(6506007)(54906003)(478600001)(316002)(83380400001)(5660300002)(8676002)(38070700005)(64756008)(4326008)(6916009)(66446008)(8936002)(41300700001)(91956017)(66556008)(66476007)(66946007)(76116006)(44832011)(36756003)(38100700002)(122000001)(86362001)(31696002)(2906002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2pBRzJjcEcwOG1OcXU0a0x4ODdCcVJDR3cySFF0aUNkeDJzZy9ZbmVQalRN?=
 =?utf-8?B?bVRXOU9hNEVwRjVsK0drRmNLQWxpOGNQVVR5cCtkYms3Wm52b0habmVtczVr?=
 =?utf-8?B?NTNlY0dsdVRZVnNlOUpZK01SckN6bkRqditXSnp2b3R4cXNlb3U2S1QzQmRQ?=
 =?utf-8?B?L0lMbDBMUzVnRmk4bGdzRGxvdWtnRE1kMVh3c0R5Z29NRTM0ZG51a2k3Und6?=
 =?utf-8?B?WTlEZXAzWE5KN3VkZHZwTHMxcE5UTTE3MmhYNFhRRERDOCs4eGU2Y0IrdUNy?=
 =?utf-8?B?UG9PVnR6dGh2aUJYc3J2dTlQbDJDRTRRM0FEaFdJUVh5V3NpeDV6dUNIdzh6?=
 =?utf-8?B?TzRUM3hCTndKVXY3YkgwY1E1WFNLQzNRSzB3Z2xLeTJMOVgzdmJmdWhab2FZ?=
 =?utf-8?B?MUFwZVpRWHZnVWFUMm5QMUtMWnBCYmdkdW0yMmlyOHhOUEtWTUd6ak9DU1RK?=
 =?utf-8?B?V0RwTDZrTVYrNTVTbW9SSms2K3FPVU5OMXd5dmdoVHJrMEx3U21RSGsvY0U1?=
 =?utf-8?B?c3BEc3c2YjBCQS9PN1M1RHpYK2N3NjBBQlF4MFhFY2tPNnNFY29WY1FUajlz?=
 =?utf-8?B?ZU5iT09TVjFNdXhLOWprZlR0QlZ6UkVybEJaVjR6Unp4Yi9YcHJWSnFiZkZx?=
 =?utf-8?B?KzlueUxZNlVFa3dGR2NwTEZtUTJKbE9YdURBNXVsRGNXN25seE50YURvR0lS?=
 =?utf-8?B?dnZ6WGM0WlJIWGJnb3Q4Z0M3OU9qb3Bmbk8wRXU4dzZ0WG1TSjQrQURNdTlZ?=
 =?utf-8?B?VVZSTU5tZHlBcytqOTdPZWR0S1VIbldoQzNySWd5SlRrM2RhOFFtallBbE0v?=
 =?utf-8?B?WXJWdXZUd3JscTV6dEIwZU9CRmFHMnN2ZThRRzV1RjBESWlLQ1BYMU4vSHlJ?=
 =?utf-8?B?SnJqK1hlckxPbHlKOGc4NVl3K0ozSlYvckxtMDRhcVlVUXRibnRkSHNJcGJE?=
 =?utf-8?B?NEN1WnQvUmxqUVhyZmNnZmZxTjVJcHVncUJSUE5wckRadzZhai9vbkY4N0JQ?=
 =?utf-8?B?VzNObjgxUUVUVCtMcS9PMWxwbVg1emZMSFZTZk81eUlUeENzKzhDSlVzajU0?=
 =?utf-8?B?bUZOWGU5MmxBQVA2eUUyd0UzUFJOV2VNTEw2NDJSZitBdDZaVms4T3IvSlh5?=
 =?utf-8?B?YzhkMysyM2NXR3BZQzBEMzllSWk2QzAyZkpNek5MOTdzbU4wTnBKaVVqQ1Zm?=
 =?utf-8?B?UCttN2s2clJuTVErVVRWd0VOR1p4bHR4TlhSdytJUWtIMytSMHEzdFJIeGgz?=
 =?utf-8?B?MlhvYVFyalJQcmp0TlFzU3VmVGl3OWhNV2hKQ1FvWjlBemF5bWNveUdORVlw?=
 =?utf-8?B?RkZXdVRMMVMraDAvMUgvSlhzVkt6emhURXhQTitYeEtaVUZKcVEvUzRTTXFw?=
 =?utf-8?B?NStsSlJBWnhxRmVSUjVYaDgvOXd1ZXpTSmhTM05yR3dzdFl1OFprcEp0Wno5?=
 =?utf-8?B?V0VFcHVSeTNBYVJob2U0K2YwRGRSQjRqZnVOY003Nm9qamxFa3hnSUJUdGVU?=
 =?utf-8?B?cThXVElkNDRiOGV0UnlGUkoxcjJmRkw0czBHRW1MSFU0dHFQc04rd1RpY0ps?=
 =?utf-8?B?QjBJQjR6UGhPbEhtTTA3QnU3aUw5ZjhDT0YvL083dzI0WmFOUmpQL2duMVR4?=
 =?utf-8?B?YVpJN0N4U3hmVE43emkzbTdBVjFWM0hKcmU0eDlQQVZqMXZERnBSc3ZQanZU?=
 =?utf-8?B?L2NvV1VscmY3M0ZnVDF2Rkdhc3VHdElvc0dWOTA3OFA1cTFlTTVmUG1xYkhB?=
 =?utf-8?B?czRHMHhxZEVlK052V21KeGhVOXBGZFZCcHdhRFltTmM5d0FSYUpFTEpYZUhi?=
 =?utf-8?B?Slp2RWJCOTNhK1lMTWlaeFpsTjJLMDhwQW5PZkFrMEhJOFZpMWQ2LzFnSWVw?=
 =?utf-8?B?TEhZamxWZmE0eVJ5RVA3V1hxSngvdkIxMWhGWWdCditZcnNHK1FkSk5XTVAr?=
 =?utf-8?B?Smd6dXZYT0xRZnc4cHNlMmJrdXBLMWtkaDV4ZE1rR3N1QVQrTElaV256c2x5?=
 =?utf-8?B?Z3A0cjhDWFczOU9qYXcwdUVvdXpxdE1qWlQwai9Ec2pydDFidjE2V1ZTQUlu?=
 =?utf-8?B?QjIzTXJreThMV1VvRXAwQjlOZ0dpSzNjY29sbW45c0tobmhjdWtoM0VrckZO?=
 =?utf-8?B?YkVkVlFkRlFYRkxhNmV6R0ZUL3BEODJycG4xais0S25ZL2xaN2xpWmRiVERI?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4159C01C9F79774FBB99F3B6AC4A5002@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 682eca9c-9319-42d7-8520-08db1579443f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 08:37:58.2828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EyZGwZrj/XGckW523Au7R41MwsHJqRePlRsEGcA+vlFL+eQSpgRtgDXwFkym+KE72J2il7A+6SipN4pntPuYqaehYgSKS/yNprdQwkwnGX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2200
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIyLzAyLzIwMjMgw6AgMTk6MjIsIFBhbGkgUm9ow6FyIGEgw6ljcml0wqA6DQo+IE9u
IFdlZG5lc2RheSAyMiBGZWJydWFyeSAyMDIzIDE1OjQyOjQ3IENocmlzdG9waGUgTGVyb3kgd3Jv
dGU6DQo+PiBUaGlzIHBhdGNoIHNlcmllcyB1bmlmaWVzIGFsbCBQMjAyMCBib2FyZHMgYW5kIG1h
Y2hpbmUgZGVzY3JpcHRpb25zIGludG8NCj4+IG9uZSBnZW5lcmljIHVuaWZpZWQgUDIwMjAgbWFj
aGluZSBkZXNjcmlwdGlvbi4gV2l0aCB0aGlzIGdlbmVyaWMgbWFjaGluZQ0KPj4gZGVzY3JpcHRp
b24sIGtlcm5lbCBjYW4gYm9vdCBvbiBhbnkgUDIwMjAtYmFzZWQgYm9hcmQgd2l0aCBjb3JyZWN0
IERUUw0KPj4gZmlsZS4NCj4+DQo+PiBUZXN0ZWQgb24gQ1ouTklDIFR1cnJpcyAxLjEgYm9hcmQg
d2l0aCBoYXMgRnJlZXNjYWxlIFAyMDIwIHByb2Nlc3Nvci4NCj4+IEtlcm5lbCBkdXJpbmcgYm9v
dGluZyBjb3JyZWN0bHkgZGV0ZWN0cyBQMjAyMCBhbmQgcHJpbnRzOg0KPj4gWyAgICAwLjAwMDAw
MF0gVXNpbmcgRnJlZXNjYWxlIFAyMDIwIG1hY2hpbmUgZGVzY3JpcHRpb24NCj4+DQo+PiBDaGFu
Z2VzIGluIHY0Og0KPj4gKiBBZGRlZCBzZXZlcmFsIHByZXBhcmF0b3J5IGNsZWFudXAgcGF0Y2hz
DQo+PiAqIE1pbmltaXNlZCBjaHVybiBieSBub3QgZHVwbGljYXRpbmcgaGVscGVycyBhdCB0aGUg
Zmlyc3QgcGxhY2UNCj4+ICogU3BsaXQgbWFpbiBwYXRjaCBpbiB0d28NCj4+ICogRHJvcHBlZCBw
YXRjaHMgMSBhbmQgMg0KPj4gKiBVbnRlc3RlZCBiZXlvbmQgYmFzaWMgYnVpbGQgdGVzdA0KPiAN
Cj4gQ2hhbmdlcyBsb29rcyBnb29kLiBJJ20gaGFwcHkgd2l0aCB0aGVtLiBZb3UgY2FuIGFkZCBt
eToNCj4gDQo+IFJldmlld2VkLWJ5OiBQYWxpIFJvaMOhciA8cGFsaUBrZXJuZWwub3JnPg0KDQpU
aGFua3MuDQoNCkhvd2V2ZXIgdGhpcyBzZXJpZXMgZG9lc24ndCBoYXZlIHRoZSBzaGFwZSBmb3Ig
Z2V0dGluZyBtZXJnZWQgeWV0LCBJJ3ZlIA0KYmVlbiB2ZXJ5IHF1aWNrIHdpdGggdGhlIGFkZGl0
aW9uYWwgcGF0Y2hlcyBkZXNjcmlwdGlvbnMgYW5kIEkgaGF2ZSBub3QgDQpyZXZpc2l0ZWQgdGhl
IGRlc2NyaXB0aW9ucyBvZiBwcmUtZXhpc3RpbmcgcGF0Y2hlcy4NCg0KSSB3YXMgZXhwZWN0aW5n
IHlvdSB0byB0YWtlIG92ZXIuIEJ5IHRoZSB3YXkgdGhlcmUncyBubyBodXJyeSBJIGd1ZXNzLCAN
CndlIGFyZSBhbHJlYWR5IGluIHRoZSBtaWRkbGUgb2YgdGhlIG1lcmdlIHdpbmRvdywgTWljaGFl
bCB1c3VhbGx5IA0KZG9lc24ndCB0YWtlIGFueSBtb3JlIG5vbi1maXhlcyBwYXRjaGVzIG9uY2Ug
dGhlIG1lcmdlIHdpbmRvdyBpcyBvcGVuLCANCnNvIHRoYXQgc2VyaWVzIHdpbGwgZ28gaW4gNi40
DQoNCkNocmlzdG9waGUNCg0KPiANCj4+IENoYW5nZXMgaW4gdjM6DQo+PiAqIFVzZSAnaWYgKElT
X0VOQUJMRUQoQ09ORklHX1BQQ19JODI1OSkpJyBpbnN0ZWFkIG9mICcjaWZkZWYgQ09ORklHX1BQ
Q19JODI1OScNCj4+ICogU2ltcGxpZnkgcDIwMjBfcHJvYmUoKQ0KPj4gKiBQYXRjaGVzIGdlbmVy
YXRlZCBieSAtTSBhbmQgLUMgZ2l0IG9wdGlvbnMNCj4+DQo+PiBMaW5rIHRvIHYyOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eHBwYy1kZXYvMjAyMjEyMjQyMTE0MjUuMTQ5ODMtMS1wYWxp
QGtlcm5lbC5vcmcvDQo+Pg0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+ICogQWRkZWQgcGF0Y2ggInAy
MDIwOiBNb3ZlIGk4MjU5IGNvZGUgaW50byBvd24gZnVuY3Rpb24iIChzZXBhcmF0ZWQgZnJvbSB0
aGUgbmV4dCBvbmUpDQo+PiAqIFJlbmFtZWQgQ09ORklHX1AyMDIwIHRvIENPTkZJR19QUENfUDIw
MjANCj4+ICogRml4ZWQgZGVzY3JpcHRpb25zDQo+Pg0KPj4gTGluayB0byB2MTogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXhwcGMtZGV2LzIwMjIwODE5MTkxNTU3LjI4MTE2LTEtcGFsaUBr
ZXJuZWwub3JnLw0KPj4NCj4+IENocmlzdG9waGUgTGVyb3kgKDkpOg0KPj4gICAgcG93ZXJwYy9m
c2xfdWxpMTU3NTogTWlzYyBjbGVhbnVwDQo+PiAgICBwb3dlcnBjLzg1eHg6IFJlbmFtZSBzZXR1
cF9hcmNoIGFuZCBwaWNfaW5pdCBvbiBwMTAyMw0KPj4gICAgcG93ZXJwYy84NXh4OiBSZW1vdmUg
REJHKCkgbWFjcm8NCj4+ICAgIHBvd2VycGMvODV4eDogUmVtb3ZlICNpZmRlZnMgQ09ORklHX1BD
SSBpbiBtcGM4NXh4X2RzDQo+PiAgICBwb3dlcnBjLzg1eHg6IG1wYzg1eHhfe2RzL3JkYn0gY29t
cGFjdCB0aGUgY2FsbCB0byBtcGljX2FsbG9jKCkNCj4+ICAgIHBvd2VycGMvODV4eDogbXBjODV4
eF97ZHMvcmRifSByZXBsYWNlIEJVR19PTigpIGJ5IFdBUk5fT04oKQ0KPj4gICAgcG93ZXJwYy84
NXh4OiBtcGM4NXh4X3tkcy9yZGJ9IHJlcGxhY2UgcHJpbmsgYnkgcHJfeHh4IG1hY3JvDQo+PiAg
ICBwb3dlcnBjLzg1eHg6IFJlbW92ZSAjaWZkZWZzIENPTkZJR19QUENfSTgyNTkgaW4gbXBjODV4
eF9kcw0KPj4gICAgcG93ZXJwYy84NXh4OiBSZW1vdmUgI2lmZGVmIENPTkZJR19RVUlDQ19FTkdJ
TkUgaW4gbXBjODV4eF9yZGINCj4+DQo+PiBQYWxpIFJvaMOhciAoOCk6DQo+PiAgICBwb3dlcnBj
Lzg1eHg6IHAyMDIwOiBNb3ZlIGFsbCBQMjAyMCBEUyBtYWNoaW5lIGRlc2NyaXB0aW9ucyB0byBw
MjAyMC5jDQo+PiAgICBwb3dlcnBjLzg1eHg6IHAyMDIwOiBNb3ZlIGFsbCBQMjAyMCBSREIgbWFj
aGluZSBkZXNjcmlwdGlvbnMgdG8NCj4+ICAgICAgcDIwMjAuYw0KPj4gICAgcG93ZXJwYy84NXh4
OiBwMjAyMDogTW92ZSBpODI1OSBjb2RlIGludG8gb3duIGZ1bmN0aW9uDQo+PiAgICBwb3dlcnBj
Lzg1eHg6IG1wYzg1eHhfZHM6IE1vdmUgUENJIGNvZGUgaW50byBvd24gZmlsZQ0KPj4gICAgcG93
ZXJwYy84NXh4OiBwMjAyMDogVW5pZnkgLnNldHVwX2FyY2ggYW5kIC5pbml0X0lSUSBjYWxsYmFj
a3MNCj4+ICAgIHBvd2VycGMvODV4eDogcDIwMjA6IERlZmluZSBqdXN0IG9uZSBtYWNoaW5lIGRl
c2NyaXB0aW9uDQo+PiAgICBwb3dlcnBjLzg1eHg6IHAyMDIwOiBFbmFibGUgYm9hcmRzIGJ5IG5l
dyBjb25maWcgb3B0aW9uDQo+PiAgICAgIENPTkZJR19QUENfUDIwMjANCj4+ICAgIHBvd2VycGM6
IGR0czogdHVycmlzMXguZHRzOiBSZW1vdmUgImZzbCxQMjAyMFJEQi1QQyIgY29tcGF0aWJsZSBz
dHJpbmcNCj4+DQo+PiAgIGFyY2gvcG93ZXJwYy9ib290L2R0cy90dXJyaXMxeC5kdHMgICAgICAg
ICB8ICAgMiArLQ0KPj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcHBjLXBjaS5oICAgICAg
ICAgfCAgIDIgKw0KPj4gICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvS2NvbmZpZyAgICAg
ICAgfCAgMjIgKysrLQ0KPj4gICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvTWFrZWZpbGUg
ICAgICAgfCAgIDUgKy0NCj4+ICAgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L21wYzg1eHgu
aCAgICAgIHwgIDEyICsrDQo+PiAgIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9tcGM4NXh4
XzgyNTkuYyB8ICA3OCArKysrKysrKysrKysNCj4+ICAgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84
NXh4L21wYzg1eHhfZHMuYyAgIHwgMTMzICsrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICBhcmNo
L3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvbXBjODV4eF9tZHMuYyAgfCAgIDcgLS0NCj4+ICAgYXJj
aC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L21wYzg1eHhfcmRiLmMgIHwgIDc5ICsrLS0tLS0tLS0t
LQ0KPj4gICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvbXBjODV4eF91bGkuYyAgfCAgNjQg
KysrKysrKysrKw0KPj4gICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvcDEwMjNfcmRiLmMg
ICAgfCAgIDggKy0NCj4+ICAgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L3AyMDIwLmMgICAg
ICAgIHwgIDk1ICsrKysrKysrKysrKysrKw0KPj4gICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL2Zz
bF91bGkxNTc1LmMgICAgICAgfCAgIDYgKy0NCj4+ICAgMTMgZmlsZXMgY2hhbmdlZCwgMzAxIGlu
c2VydGlvbnMoKyksIDIxMiBkZWxldGlvbnMoLSkNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFy
Y2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9tcGM4NXh4XzgyNTkuYw0KPj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L21wYzg1eHhfdWxpLmMNCj4+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9wMjAyMC5jDQo+
Pg0KPj4gLS0gDQo+PiAyLjM5LjENCj4+DQo=
