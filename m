Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F7F639D0A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiK0UzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiK0UzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:55:13 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2093.outbound.protection.outlook.com [40.107.113.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F9AB1F5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:55:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcwTUYl1z9DyR1UuvEsV9wNndlrX8V9ZhRR6XIQlrAeWIThJWwqO+czloa5yfSGG711XhvUl1LspwXcCTcsB0p2GSvUxq4TZeOfywbUbixBo20XIBtVutF3tcJHyUMskKuWf2pGvQYkKackfUURq5VTWMBX/ozb2mK3b8inJmrPBNFwlHGlzuC5rhhn/cDLgszmp4/jxRFDnx4ni16BqUj0oFA5zsuaPJUOfbnEacmBxmxO7HTwlifF2I617YFMdNl05qhIbn0otpqT33vUPY4ItaApl3uz7wZ/Rf3j6qpK+DpxkdRYByeTOZSJUZvu2IjCM0ticCjPq5FfdpWsamg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VksIFUoCaO/pkIJ+huSBjSQk2/XI/1ZlqMu+ENbrl4A=;
 b=KPya9SovsUdk2poC6mFj57noDJ9In1A6K/m3JRWO1u0BZhxWrxG58gVrlYKk3TPrEvr3JBHynC12RdSwkVDUbRQ/zX0ZRA50QjQwJiIOc9WBIlawLcBNkPTHFYjULBdLqLZQHpMviDS79/03VgmjjArvM5KvrIaBctDOvNh3+0EwMAd4oBo8O7WE9wEvOVXskIY4fWEBhDrhx1KQ0zF8XoCZDJbvpsuccVkONUTZ9lUMuHFwgnXpzVe1/T5lCDpDu2T/DZN3lmnsg4JLyrwla8G5WipB139soleS/JQBS953Zx53yZj5p+EvvhWsgKwyngUy+HEu5/rKA7Blu3VLag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VksIFUoCaO/pkIJ+huSBjSQk2/XI/1ZlqMu+ENbrl4A=;
 b=UGAdFl7WrvN/cDAXaZpvkly2URqD9/HLlO364FLJg5VAmbgFneuKBjL4hbgR4FRPwYXxJDU6EU/aK/ao9nhgpGBk9xfHNf3EV8hLlfzV5+21bSGmScWvK29yK1id5Ikr59Tv3B3Ux/Bj/eD/5OE/T7S5zmKKBiNFXKaVTtXoxn0=
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com (2603:1096:604:197::13)
 by TYWPR01MB9510.jpnprd01.prod.outlook.com (2603:1096:400:1a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Sun, 27 Nov
 2022 20:55:07 +0000
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::bc4f:a066:427c:1723]) by OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::bc4f:a066:427c:1723%4]) with mapi id 15.20.5857.021; Sun, 27 Nov 2022
 20:55:05 +0000
From:   DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] regulator: da9211: Use irq handler when ready
Thread-Topic: [PATCH v1 1/1] regulator: da9211: Use irq handler when ready
Thread-Index: AQHZACQ/3tBtaAyFtkmmtMu4IImXba5TPKDQ
Date:   Sun, 27 Nov 2022 20:55:04 +0000
Message-ID: <OS3PR01MB84605BFAAF6E33DDAE030E5BC2109@OS3PR01MB8460.jpnprd01.prod.outlook.com>
References: <20221124-da9211-v1-0-a54549aa6d3b@chromium.org>
 <20221124-da9211-v1-1-a54549aa6d3b@chromium.org>
In-Reply-To: <20221124-da9211-v1-1-a54549aa6d3b@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8460:EE_|TYWPR01MB9510:EE_
x-ms-office365-filtering-correlation-id: b35027bb-7175-4fb7-b666-08dad0b9a906
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a7ZGp9aQinS689+0Ss4gpLj4+onDFK8z4vpJvEUSgmW4Xqe6bZwzWGoBT3YbTXVL0ummsYrzWoK2oXERpyh5AC+vJ3Vgl6KD/n+St7yFk7k4jWajMQd++bKL0kNRwqSbOvG+P4e3pdVAXqDNtSeRvifEsifhGy3GbCjI/fDJC+P7HJUI7dHocXoveOE1BHX+w9Vbteug3qbi2671vFAF7lhPTFgFEsDlEdWkoQqvQf/WvLPvzslEGtu4TwV4PgieO2SQ0ecTBc+1QCCF3QW8ZEKIdFpw223mMl81QPLBceiXK3CMZJbAtWetVSCGbS/59nEYIX6Vv9gTIxs7LEegl6uN7S2/ZOA7Wt3mX96lW3oT8yqYQUCB5i41pjsp85L9ie07mqRpL6fGC3d5a3nzbDwWRYkUvo772MghzEUst581mT/lmO/pUUPXs0qwwo/hvsvXKMomhsw3ozvTRpugtPx7bVhkl9O7jTeathIi3OQ5YV1njhitJFxw9Z+0/+pImFHxivJK11exhCHsCnR53vnS3bkk8CvFuUgFUVYeXCwUmcFGPgKuZpKZ+8OSrsmJ34XDcenGPVGfeT2C03fHtR/u9/boC7a95BN92tbQyufJLXmBrQkBAVoTHWG49pBzMTaMPmBfM/wXyaPCbi6mZ8d07AjZCqOelHoP8/1AhUYlpv9ufRKK17+FkzoxsNzK3uPlXryqNfPgbK8O+as9owrfGGvShxGBdrWLXQPbEHE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8460.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(41300700001)(186003)(66946007)(76116006)(8936002)(26005)(66476007)(53546011)(64756008)(8676002)(9686003)(55236004)(4326008)(66556008)(71200400001)(478600001)(7696005)(966005)(33656002)(55016003)(6506007)(38070700005)(86362001)(66446008)(2906002)(52536014)(110136005)(316002)(38100700002)(5660300002)(4744005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm5vZmk2c1JaSGlveVJZMTZ4RDlIalkxMklqWldGNExLeHpzV3YyQmM2Y1FE?=
 =?utf-8?B?L3JxSDd3UTN2R1ZEWmpGeWJQa2Q3SkFobUt6Rnk0MUxWSXc2aUo5UzhuSks3?=
 =?utf-8?B?TEZDVkE0Tk8wVnJJVVFJbkMvbkgvZGY4QmFCMzh4UVRER3QwcGNIenBsRGli?=
 =?utf-8?B?NFBXalJPa1BHcEVoNVhmVnRscmlVRGhVcUxnYW1sQ2cxUDBlRkZaZmlyT28y?=
 =?utf-8?B?RDNYSWtmZnJ6QVRxbXJMMy9jUE1tbFVvR2s5NjFieE9lNWYyVDUzVGhyZUpm?=
 =?utf-8?B?U0V0QnduWnFheW0yQ1hmQXhGckFjejRrTEdpekYvMG5DaVNFT1gzanV6Uzlu?=
 =?utf-8?B?MUoxSnlKMy9BaXV4UDFJVXQrTTZJeWZiOGw2SlRIdUM1eHQwUGMrdU5vL2lu?=
 =?utf-8?B?dGRHeldacmM5T0NDVXVyRzdzNlEvT2RoMlFTSGo3dlo1VTRLWXYwdFFJdXhx?=
 =?utf-8?B?MmhwQ3dUWldHVkIzem4reWlPTnNvajBrQnFvSk1wUEgwcXpzNjZjMFM1ZmFI?=
 =?utf-8?B?MGNFQjJJcWdJbnRJay92RVQyNmg4azNkYWI5VVplaldZRXFNZ2JEM2Q4WVBh?=
 =?utf-8?B?Mlhxc0tFRUtMcWgxUDkxMVdhZ0F6aE1uSkVnblA2ZG9USllGSU9QeHNDOVFX?=
 =?utf-8?B?RldtSklCaXBzQjhLWmlzaWprMnFlSEVGNHJNUFdkeUh1TFUxUTN6OG0vMjdL?=
 =?utf-8?B?RlErem5MTk5BUXNXc3lpTTROWXJTMENiYVNCaVAyblRhNmoyZmNCeVMraTNa?=
 =?utf-8?B?alQ3UURvWXB1elR5eFE1c1IzNGlRdG1YTDJBYTlkenJkOTFqRXFKckJ3aEFt?=
 =?utf-8?B?S3JoOUY3RjB1c0R2bC9kTUFwWk9sMnNOMHp4dzVaUFRDVU1xTzdYRXUwNDdC?=
 =?utf-8?B?OGlmM1lyVzRZWmc5Syt3elRJbDB6cTJ3R0l4WnlGWDYxUDl1Wlh4REJ0dDIr?=
 =?utf-8?B?TG9FWUVQRUwrbzh4bW9oVEVJVkQ4MC8zdDRrcXUrNTVTOGh0TkhMKzRCc1Za?=
 =?utf-8?B?dGRwMlJuQnBPK2M2N2hUQ2Y4c09oYktOYjRMcnYrVmNmMkl1aHlSQ1JuS293?=
 =?utf-8?B?YU10aUZIYTRZamRubGtOVDVaVFc2SkJQdUlvbFdVaHByMkF3Ti9WcTVMV3Ey?=
 =?utf-8?B?V0F6NWVReG9iMHBZakZNZnZYT2JjNHdINlVZS3d5NWx1cFo3Tm1xWmsyakxq?=
 =?utf-8?B?eUdWZUlIaml6Wm1TV0RmODY5cVAwMm5CV1lTVTl6OXNTdzlVaERJaVFaUHlK?=
 =?utf-8?B?eU1Gb091clZzYk9RbldXVmZVYjFTOWtsNlJuS0s4Skg0aUxYemNHandsNGdN?=
 =?utf-8?B?dWlzYk9aOThYckF5Vis0UEdocnpTOE1WM25uR2VUS0w0dGRySG9nbFVFUWtj?=
 =?utf-8?B?OUt2N1k4cjdnclBLSzJlT1FYdGhrRG93dmphWi8ybXBkVDdIaWhVZVV6ZTJL?=
 =?utf-8?B?Q1dCMlNEd0NnYUJTbjlJa1E2WFhIUjZKUnk3NUxoeTVhVGhZUnk1QTRKTHp2?=
 =?utf-8?B?Y2tPUVVlUzNweXdYcGVXbklIS3FiSWc4M3BCcTJmTzZaZFdiS2Q1aWdPTUpD?=
 =?utf-8?B?MUdoSkh1bllXcHpFQ29kYnJjMVhhQ0JUdlBTV21WUnFCQjk0OUI4Z21QSlUw?=
 =?utf-8?B?RkVRWFJic3Z0M3pSU2F3SEtSNEtaYTlNcW9oME5PclV1bGdMMXlqejRGSUZT?=
 =?utf-8?B?WjBjWEZMMFdVZWJ6UlpjTWNSMHU4SjQwQ0FjRnJkMWRnT1pvWVJ6YmsxZXZE?=
 =?utf-8?B?Tks2M3N6ekhZR3AzYVZuTU9zOVJnZkdxdzhMcGR6dzc1U0taSjhsTERydFRN?=
 =?utf-8?B?b1JKY2dPQnAyNTA5c2hFcXoxbFlaQk9qMTFWWmVROUdGV2xFRVo5RjlXeEhU?=
 =?utf-8?B?ckR3SXl1ZkJPcEplTHpqeGhqSjk0UTl1MlZRcmVna3hOcS8xYnlOTWZiVjZu?=
 =?utf-8?B?M2RsYXBmZHpZNzd5SVduTnMwbUxNQ3BQSFdLWG5IdWJSU2pYZ2FqUGFYcWtH?=
 =?utf-8?B?RHFxNHltZkRCaE5VUFQ0YVhBWThhRWNkazRQbEQyUjVBUlREMFlhOUk5MUo4?=
 =?utf-8?B?bFRPZnVuSklvS1pqb2NLSzZQSEErZW1UQWFEaENRTHlDMWJuNEVscFdIVmZy?=
 =?utf-8?B?bjFXMlhTZ2c2SEZYNE9wcmRwd2EzNHpEVUJmWVNFb0Frclp3NlpDWTZHbVVZ?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8460.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35027bb-7175-4fb7-b666-08dad0b9a906
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2022 20:55:04.9507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNVcq67KBODRpj1xnBXyUHF5PEKSEpdB2X6MNct0oGFLT1IBEj441oZttruEdP2vGyeQOtTHMo6f+SddtfTpaIRjpmGfYLdpc1lDeez/pR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9510
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQgTm92ZW1iZXIgMjAyMiAxNjo0NiwgUmljYXJkbyBSaWJhbGRhIHdyb3RlOg0KPklmIHRo
ZSBzeXN0ZW0gZG9lcyBub3QgY29tZSBmcm9tIHJlc2V0IChsaWtlIHdoZW4gaXQgaXMga2V4ZWMo
KSksIHRoZSByZWd1bGF0b3IgbWlnaHQgaGF2ZSBhbiBJUlEgd2FpdGluZyBmb3IgdXMuDQo+DQo+
SWYgd2UgZW5hYmxlIHRoZSBJUlEgaGFuZGxlciBiZWZvcmUgaXRzIHN0cnVjdHVyZXMgYXJlIHJl
YWR5LCB3ZSBjcmFzaC4NCg0KQSBnb29kIGNhdGNoLCB0aGFuayB5b3UgOi0pDQoNCi4uLg0KPisJ
cmV0ID0gZGE5MjExX3JlZ3VsYXRvcl9pbml0KGNoaXApOw0KLi4uDQo+IAljaGlwLT5jaGlwX2ly
cSA9IGkyYy0+aXJxOw0KDQpPbiB0aGUgb3RoZXIgaGFuZC4uLiB3aXRoIHRoZSBpbml0IGNhbGwg
bWFkZSBiZWZvcmUgY2hpcF9pcnEgaXMgYXNzaWduZWQsIHRoZSBJUlFzIHdvbid0IGJlIHVubWFz
a2VkOg0KCWh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJp
dmVycy9yZWd1bGF0b3IvZGE5MjExLXJlZ3VsYXRvci5jI0w0MzANCg0KTmFja2VkLWJ5OiBBZGFt
IFdhcmQgPERMRy1BZGFtLldhcmQub3BlbnNvdXJjZUBkbS5yZW5lc2FzLmNvbT4NCg0KUmVnYXJk
cywNCkFkYW0NCg0K
