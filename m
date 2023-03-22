Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C46C4EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjCVPFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjCVPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:04:51 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2045.outbound.protection.outlook.com [40.107.9.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F59D2884C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeIbZgdkvbJi4bbt5to+cxLFLEx7lo4c4bMaupJaE0lcuDN/3WfoSSLgTbCUGH/IrC0p7JvE/NXS10AneFdLJKc616z6ydJnf7Ax8xPtjWA6dJ5DBc639Q9uxNvwBOVbmCwCX2ks3HzEt3eJFpv9fsNazfDOU8H3jDyKtUE+NCVFbGyji6tQvNVu/lPbQub/mYG4sInZA0rN1KwVLFNvlSqedacKQCBml4Tput6RhSlyrWhhY6HTEPKwoW7t4Vt7iasAMyBQtiQN8FDOFxfr1PA43if3KVqMScFKKmpNeXJzSrYQMho5JBfa/QIB0oQbCXEv8Szsld50GEwjGx44TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T80tnTrEF+/6tfivxS/xAnyjSbV/w9Pgp+ZVUdZcWMI=;
 b=l2FEUAbG8q1m5bNknE/cTX7LTGUr2MxKXjbafvJZD4pkSmPZxmBGpe9JKp1AUXoXaqKU0FMNQ2OJEY/gEwvlHIbIrnqHzaVBeo4mZYgTGLi5fe6sls1iGlvnyCCNHsXTT7sdqy94aZYBQvS2gymVG9au0pZnmubOhBhcfdya5IC2KiKEStXu/GURtxTacx3buamjU4IGF6Fuzk422wMaO1/CfPobjKW5Emys4x/xArOUQeSre26c5yINYTVxkhIIinbpNxwF+LqIn3sINBw00lRlGl3Py2j0z+R0YQUO+sVTab/mqVKi5KbqnqiuBl0gVoNpxq6T8zfTM+F2zfwMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T80tnTrEF+/6tfivxS/xAnyjSbV/w9Pgp+ZVUdZcWMI=;
 b=ZzwLRuHAV5jgAZnzS+1EG0aQfXWV9Nuk0n2PSknZofzGeRmtaOyfFux13II+DpnoW/8PjSwt9dBIlqRgou5rKGHaOjpWvvetmTUcOCOE41lKb8ty9aZwt6zQaX1WSmqEJW0hDSRPRuSjuuOfvxXrg5rj6RfV0QQb5VcHfjgR63YcRi4NeTkL3SWmq7Q9EyeNFGRNvhhZ5NvQksPQ17VTI6dGjWnsouSKFBk1xqmrxqHsWObE0s+ETArhSzBgC69rNNYh4jZZ6Hcwfsk66ZKreYtjUGMF8J70IWZsETN7Cuc6sJ9rfKUghN8gQIuUp5zsG7XNUOzBVd6aIZWzKYxnVw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2483.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 15:04:36 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 15:04:36 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 09/11] static_call: Make NULL static calls consistent
Thread-Topic: [PATCH v2 09/11] static_call: Make NULL static calls consistent
Thread-Index: AQHZXHLYirgJNs0HA0CxDUCHuPTkHa8G5lUA
Date:   Wed, 22 Mar 2023 15:04:36 +0000
Message-ID: <dadf372b-9dc2-0c71-2860-1db7c59068b4@csgroup.eu>
References: <cover.1679456900.git.jpoimboe@kernel.org>
 <7638861ae89606b1277ad4235654bba2b880f313.1679456900.git.jpoimboe@kernel.org>
In-Reply-To: <7638861ae89606b1277ad4235654bba2b880f313.1679456900.git.jpoimboe@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2483:EE_
x-ms-office365-filtering-correlation-id: c93c8c19-eaea-4b95-d47a-08db2ae6c0c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3vyzrDHD0ZTtCbQB26R5/iEJF6CPDC65sh+zskrTR9yDUyAIbc/FPKN4FCo3Gxwty06WyW6/DOvPAf+Dhy6yIVcXeZk9koRSpI2rm3Kr42bdwhlrfcDiPGeNJJC0R6wvAYrQy4y7DyVMelNU2Ocy80tyndJs43uJYmDDJjDchEEdt/ySU2c4jmdSStkj+OXkQc9f+OzVrCTidfYZVLoFhPMOu8ART5xszbfe56BSoQFs8eSu5G06GraU05cI1EUTo+tEoNdGjlMJQ0AB8Zs8SVQwjnbEnNZ+qzm039yhcQLwJftmMBXw+5aVpQxGtfoDfLbH5XmoMr9Qs43vFAbiOVSWx2OM8mXxPrhYFk/vKxTG8jXnFRr//Yq87M0hSHWXdCWpsGnGm+CccOuoXkaeoZPAlb1CVWBfq5biQtjsNN+QtlFU6VBJzztUjQfPfR2ZixO9uvonYH7GeDStKb4YElur02CNSQuxRA6jf2R0PqdW6RAuRcroNUCHfO2I5LHGxrWo87dOYgVjw7/RjG50V887Fcxd4I6gRwIpigXDgHfNheeBE2Kyh+PPOm0zXrOFXNRP8Yuk3jn+dccic3C7rsZTLKUp4E8sOCHhkiuP70KJ9qMHFCRdvjkv1rasFnPsZl8S7kuEkzEBKZqIEXdZLKCofzXMT6mgQP3z8CEZmvwCgyjADUmd/vGwoe4S6yNQIhqLkVFvWuVqSsw0SF8yG+TCEl1on7BABLEWvLZlceHM+yqaMLKEPur929hscDgLDx9z7/UhsVUtOWQArJqyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199018)(6512007)(38070700005)(6486002)(64756008)(110136005)(71200400001)(54906003)(2616005)(66574015)(36756003)(2906002)(66476007)(91956017)(186003)(8936002)(44832011)(66556008)(83380400001)(316002)(76116006)(26005)(5660300002)(478600001)(7416002)(8676002)(66446008)(66946007)(4326008)(41300700001)(6506007)(31696002)(38100700002)(122000001)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2xwVHZnSnI3dnNjNjBITU1PRXJYbURFMXZyb0l1SnR3cjRjUUtvRjltYnoy?=
 =?utf-8?B?Smp1TkpPb1UrZFFQbTkxUHpwQVJERTYxU1hYUC9Qa0hwb1BBWTE2WmhpMnNZ?=
 =?utf-8?B?V20xaU9Ka3g5dlc0TmJEWjBRczZwR2J2RVExakttVGFIVWFZakM3TWsvQi9F?=
 =?utf-8?B?Z2MwRTVwWUZTOENJSlFZVG1RWm84aTJuZXZDeU4rQlhZcTV0UU9QM1BHZ0xE?=
 =?utf-8?B?RkU4WFFVQ3FYY2xITmJRTVpoQlorMU1kQ2ZCdUVodFVJbDkxdHpDMUJkM2hk?=
 =?utf-8?B?S1BLbUF2QWpINE15SGhMYWIvc0pTb0tjS2F3K0RqWXI2VmVLZEhydnpGaFJU?=
 =?utf-8?B?bmtncXhnbzdvMHR2dndENnJJajVGWDRxYStLOWhiT3YrS2xmL3NsQUxCSjdR?=
 =?utf-8?B?c1E5TnVOcnU3WE0vMmU5em5mRWJ5WnVqd3h4RkRFTG1WcEpQaEp3N1ptRHY4?=
 =?utf-8?B?MkpPY0JnYitSdzBTeFFTem1xMGd6Z2xmT1Vab2dSRXZuQUtQdG9GU1JKMlhm?=
 =?utf-8?B?ZDBOQUZmT0srTnRUaHE0RGpyM09GODRPdDV0TGlPa2hpS3ZDckcrVXdHcldo?=
 =?utf-8?B?anZyVm9tbHNSbWZZYXFndCsrQ0lBM0JSQ2FLNlFxdGN6MjljVVVuWFlQbzlp?=
 =?utf-8?B?OVlUZFppbThtbDZadW9RazNaWkdIQnp5N3BzNWlMZExmZ3J3dTl5cUpsMmJT?=
 =?utf-8?B?ZUxOQlViVzg5azJRQmtCVlhQSmNWSTcvYW96WThSZkRZZm8walJUNE03Z0hN?=
 =?utf-8?B?OWFKL0wyREtoSzlhTzhlSVVXL0dkOUdxa1hWS1RJY2RSWTVuaEpZWDNxWkR5?=
 =?utf-8?B?d2EybmIyckRqOVB3NkJoU2JWM2JUYk9VbzB0UG9HRjZPYStacEE1VG5UdXY1?=
 =?utf-8?B?dFYvUStHSW14Qk5SNDVnemw2azZuRExSd2VPd2I1Yy9pdzlWa1c2emZ4N0Vw?=
 =?utf-8?B?N1NLeEZUZGN1ZXRieUczSHh3UmNDZ0dOVEtJYlZVNWUvMlNrWWltLzh5S3BG?=
 =?utf-8?B?OHF0eGFXRjR5d1ZBQjZUM0N0bVlXODBBWkQ0NU9RcWFnUkhpeWRPTHh2ZUJU?=
 =?utf-8?B?b0p1VHVUdzQ2RW9LM3dQbE5UOFlrdk9hK04zY2VYeHRobmtRRDhCVGdVNEt6?=
 =?utf-8?B?Yk0zMGd5cVB5N09mWkM5NXQreEw2MUM1RGczenN2TzZoUHNFZ2VuT2tEYy9v?=
 =?utf-8?B?cFdSVlUxaDY4VkpBL09pcjFLVXBCbW95N2FkNnB2T25aUUxCVEl3TjFEOCsy?=
 =?utf-8?B?N0NGRDN2WFVkVHJVY0Iyb0pTZXRzWXVsUkVDUmMvZWlYNHZMaFlFdEIvZktG?=
 =?utf-8?B?QjNzSnlJYm9xR2RXaWp1ZDRnY0Z3S0FrN0F3MFNXSFlGayt4N1VBV3E2QkhL?=
 =?utf-8?B?NWd2NE5aM0FSdTl1bVdTUnpjazE1dmw4NFVSVVhSd1BMaS9NSUJWWklSOUJa?=
 =?utf-8?B?NkE5L09PaGtKcmVOa0ZSL3E5bEVoSlphTGJzNSswMTFpcnFIZENJcVF2MFVJ?=
 =?utf-8?B?dVIwWlZla2VyaTJlVWRTbEN1Y0sxVjhJdWdkN2Y3SGxidXZlTzBGTmdnK25l?=
 =?utf-8?B?WDFITVc0Zk04YTRVbndIbkxXblVNZFN5OWxuYmZSWHRienJNQ2JpNW1RNHZC?=
 =?utf-8?B?Q3ZKY2p1ZWlpQllQenpuT1JCbFozNTRXaXF5SWFEY2hoYmgyaDVNM1ovVFVV?=
 =?utf-8?B?MGJsemtTRDBIV1ZUVW5xUjZEcy9EVUdCWUx5RnE5MDl1VWdtMncrdGgzaVN4?=
 =?utf-8?B?czZxaUJwMWNLa214V3hHM3dJQnVsM3VwUkN2am9HNkc1V0RKK0N2SlVocDJY?=
 =?utf-8?B?S1JPMHAraVNicXM2U0txL3hrQUMrM2FtbmJOY1UxaVZSQmY3bWRFNm1mbXNB?=
 =?utf-8?B?T1NaT21Lc3YzaVlQakdCWGM3eWtNNzFKU2Znc25UZEF5RFJNem50WURwNndX?=
 =?utf-8?B?SUEzdjlKRVpOOHltbElVZTRJK0IzSkU3Q0tLSW82M0tIN3R6NlNnNXVPMW1I?=
 =?utf-8?B?V25kUEFyUGl1ZHpyS2sxWk1LM2ZpOWI4K2Z6SU9ZaHpTak51TTNERTRrcUZM?=
 =?utf-8?B?M04rbkxQc2xGL01Odi9tU0RPbUVMWlhGYmxidGU3T3VJaFM5U3gwNmtDOG5o?=
 =?utf-8?Q?X+tJOBfCE5HsBaornbvFUY8rz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D3D74F00F7A804C92E9DFBE51BE0925@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c93c8c19-eaea-4b95-d47a-08db2ae6c0c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 15:04:36.7870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RSpQVC0hsh4ntQSJYPCB89VmpAXtwUGzIXoOC+EzcvU43T/Rp8KjrOc+91CQdLsJGOGoeGIumDzBhueWiAUfgIvB+kygNy0Y2XQZ4sCkUZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2483
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIyLzAzLzIwMjMgw6AgMDU6MDAsIEpvc2ggUG9pbWJvZXVmIGEgw6ljcml0wqA6DQo+
IE5VTEwgc3RhdGljIGNhbGxzIGhhdmUgaW5jb25zaXN0ZW50IGJlaGF2aW9yLiAgV2l0aCBIQVZF
X1NUQVRJQ19DQUxMPXkNCj4gdGhleSdyZSBhIE5PUCwgYnV0IHdpdGggSEFWRV9TVEFUSUNfQ0FM
TD1uIHRoZXkgZ28gYm9vbS4NCj4gDQo+IFRoYXQncyBndWFyYW50ZWVkIHRvIGNhdXNlIHN1YnRs
ZSBidWdzLiAgTWFrZSB0aGUgYmVoYXZpb3IgY29uc2lzdGVudCBieQ0KPiBtYWtpbmcgTlVMTCBz
dGF0aWMgY2FsbHMgYSBOT1Agd2l0aCBIQVZFX1NUQVRJQ19DQUxMPW4uDQo+IA0KPiBUaGlzIGlz
IHByb2JhYmx5IGVhc2llciB0aGFuIGRvaW5nIHRoZSByZXZlcnNlIChtYWtpbmcgTlVMTCBzdGF0
aWMgY2FsbHMNCj4gcGFuaWMgd2l0aCBIQVZFX1NUQVRJQ19DQUxMPXkpLiAgQW5kIGl0IHNlZW1z
IHRvIG1hdGNoIHRoZSBjdXJyZW50IHVzZQ0KPiBjYXNlcyBiZXR0ZXI6IHRoZXJlIGFyZSBzZXZl
cmFsIGNhbGwgc2l0ZXMgd2hpY2ggcmVseSBvbiB0aGUgTk9QDQo+IGJlaGF2aW9yLCB3aGVyZWFz
IG5vIGNhbGwgc2l0ZXMgcmVseSBvbiB0aGUgY3Jhc2hpbmcgYmVoYXZpb3IuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gLS0tDQoN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9zdGF0aWNfY2FsbC5jIGIvYXJjaC94ODYv
a2VybmVsL3N0YXRpY19jYWxsLmMNCj4gaW5kZXggYjcwNjcwYTk4NTk3Li4yN2MwOTVjN2ZjOTYg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9zdGF0aWNfY2FsbC5jDQo+ICsrKyBiL2Fy
Y2gveDg2L2tlcm5lbC9zdGF0aWNfY2FsbC5jDQo+IEBAIC04OSw3ICs4OSw3IEBAIHN0YXRpYyB2
b2lkIF9fcmVmIF9fc3RhdGljX2NhbGxfdHJhbnNmb3JtKHZvaWQgKmluc24sIGVudW0gaW5zbl90
eXBlIHR5cGUsDQo+ICAgDQo+ICAgCWNhc2UgSkNDOg0KPiAgIAkJaWYgKCFmdW5jKSB7DQo+IC0J
CQlmdW5jID0gX19zdGF0aWNfY2FsbF9yZXR1cm47DQo+ICsJCQlmdW5jID0gX19zdGF0aWNfY2Fs
bF9yZXR1cm47IC8vRklYTUUgdXNlIF9fc3RhdGljX2NhbGxfbm9wKCk/DQo+ICAgCQkJaWYgKGNw
dV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfUkVUSFVOSykpDQo+ICAgCQkJCWZ1bmMgPSB4
ODZfcmV0dXJuX3RodW5rOw0KPiAgIAkJfQ0KPiBAQCAtMTM5LDMzICsxMzksMzUgQEAgc3RhdGlj
IHZvaWQgX19zdGF0aWNfY2FsbF92YWxpZGF0ZSh1OCAqaW5zbiwgYm9vbCB0YWlsLCBib29sIHRy
YW1wKQ0KPiAgIAlCVUcoKTsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgaW5saW5lIGVudW0gaW5z
bl90eXBlIF9fc2NfaW5zbihib29sIG51bGwsIGJvb2wgdGFpbCkNCj4gK3N0YXRpYyBpbmxpbmUg
ZW51bSBpbnNuX3R5cGUgX19zY19pbnNuKGJvb2wgbm9wLCBib29sIHRhaWwpDQo+ICAgew0KPiAg
IAkvKg0KPiAgIAkgKiBFbmNvZGUgdGhlIGZvbGxvd2luZyB0YWJsZSB3aXRob3V0IGJyYW5jaGVz
Og0KPiAgIAkgKg0KPiAtCSAqCXRhaWwJbnVsbAlpbnNuDQo+ICsJICoJdGFpbAlub3AJaW5zbg0K
PiAgIAkgKgktLS0tLSstLS0tLS0tKy0tLS0tLQ0KPiAgIAkgKgkgIDAgIHwgICAwICAgfCAgQ0FM
TA0KPiAgIAkgKgkgIDAgIHwgICAxICAgfCAgTk9QDQo+ICAgCSAqCSAgMSAgfCAgIDAgICB8ICBK
TVANCj4gICAJICoJICAxICB8ICAgMSAgIHwgIFJFVA0KPiAgIAkgKi8NCj4gLQlyZXR1cm4gMip0
YWlsICsgbnVsbDsNCj4gKwlyZXR1cm4gMip0YWlsICsgbm9wOw0KPiAgIH0NCj4gICANCj4gICB2
b2lkIGFyY2hfc3RhdGljX2NhbGxfdHJhbnNmb3JtKHZvaWQgKnNpdGUsIHZvaWQgKnRyYW1wLCB2
b2lkICpmdW5jLCBib29sIHRhaWwpDQo+ICAgew0KPiArCWJvb2wgbm9wID0gKGZ1bmMgPT0gX19z
dGF0aWNfY2FsbF9ub3ApOw0KPiArDQoNCldvdWxkIGJlIGNsZWFyZXIgdG8gY2FsbCBpdCAnaXNf
bm9wJywgd291bGRuJ3QgaXQgPw0KDQo+ICAgCW11dGV4X2xvY2soJnRleHRfbXV0ZXgpOw0KPiAg
IA0KPiAgIAlpZiAodHJhbXApIHsNCj4gICAJCV9fc3RhdGljX2NhbGxfdmFsaWRhdGUodHJhbXAs
IHRydWUsIHRydWUpOw0KPiAtCQlfX3N0YXRpY19jYWxsX3RyYW5zZm9ybSh0cmFtcCwgX19zY19p
bnNuKCFmdW5jLCB0cnVlKSwgZnVuYywgZmFsc2UpOw0KPiArCQlfX3N0YXRpY19jYWxsX3RyYW5z
Zm9ybSh0cmFtcCwgX19zY19pbnNuKG5vcCwgdHJ1ZSksIGZ1bmMsIGZhbHNlKTsNCj4gICAJfQ0K
PiAgIA0KPiAgIAlpZiAoSVNfRU5BQkxFRChDT05GSUdfSEFWRV9TVEFUSUNfQ0FMTF9JTkxJTkUp
ICYmIHNpdGUpIHsNCj4gICAJCV9fc3RhdGljX2NhbGxfdmFsaWRhdGUoc2l0ZSwgdGFpbCwgZmFs
c2UpOw0KPiAtCQlfX3N0YXRpY19jYWxsX3RyYW5zZm9ybShzaXRlLCBfX3NjX2luc24oIWZ1bmMs
IHRhaWwpLCBmdW5jLCBmYWxzZSk7DQo+ICsJCV9fc3RhdGljX2NhbGxfdHJhbnNmb3JtKHNpdGUs
IF9fc2NfaW5zbihub3AsIHRhaWwpLCBmdW5jLCBmYWxzZSk7DQo+ICAgCX0NCj4gICANCj4gICAJ
bXV0ZXhfdW5sb2NrKCZ0ZXh0X211dGV4KTsNCg0KQ2hyaXN0b3BoZQ0K
