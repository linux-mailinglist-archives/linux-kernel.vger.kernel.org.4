Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECFF64F89E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 11:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiLQKIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 05:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiLQKIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 05:08:10 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2054.outbound.protection.outlook.com [40.107.9.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F093919002;
        Sat, 17 Dec 2022 02:08:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih2EEAnk7LKS/WWCNqjN52S/JILZP55/qlDzyj1cYBloxZQz1C0zZH09A5ZbP7sLgwBbxVy5YljzU0B41SkdEoOhmluaGNSCYduogVTsmJSkkPFP/qVO7y2YYNr5IhYZKJY/IdjwNGBW6HGZ+A3HMbYUGs6spP+qYJwB380wLmGdu4JuCN8t/haHH0skimk0BXbgOnxY7L2rmRSJrVukHOAe0MH6SEN48klI5yU0HtQPH8wIF+c2yzwH+M2qgnE7TkQ+GxaUDNvQG1f+XnIyGKTqMm88oSXb0ED7GbRtxnx0m2Rm6PeEdKNZTBFECoie1IUvEtI6OCprdagM8CKvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GV9h13Jkm4roUFscBr6KPRBppR9FXBIYgx57DMH5oBs=;
 b=O3b6w3GOkU9moW6EkwosToFOrdM9c2PkOeRXnx9gP27RZkkWoQwyaQGL9NNzvyeiD2aHK0kJ1R7/0GUa6REG5gVnWscJ7rwzwNKMVdzDvFD+r090tmrcpQ49M0ZN7/4SPEr8tBj396khk5p6crOkg3tyICyldBj+1kw6KfwcH4BK8ykLbAZ477Y90ZhP+pR+oMbq7jI2u6iMtw+apLI2+UD+2Q9Hj6jCM9hVjyN+PfVm+dAGdQFLD3v9Z2kt/phhY0ENhYCRdXb/VI86JrT3Onr48Bts8TISf7RGpco2SrX4pTdRpdXyJy5rMoQGZwHnQXJuA0Nuu38D83Kl4N/3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV9h13Jkm4roUFscBr6KPRBppR9FXBIYgx57DMH5oBs=;
 b=5Z4eg6IbPRMAHFW6n+UFcAdjEQ7TeuuQPtCACDxGq2JFuRb91IkgRKci+OFvoqo29n1RA9aU5qYz+Yirpm6dZc0ra+2mYJYQPU+2P+ULicOGT5iTHk7rmxwJ5GjpnTX7H43kMiZpYQL1wSYhp18J/k8TL/I1GdVFLANvcurdeh12K3xgM/VxAJjYiTyYJ6QDhcKhvcEkpCbhfxYd9tNcdLksI3/n0fOzMVAUaGf7Rtg11W4u7SlsGq46ix+MDClyormvdnceip2lbe7jx9nwh1DzmNRx6rFRTnjrb9gUKvTXLYASZqfHxsEBVFAl3x2xWqc0g1DOFpGQ7Se6xZ0dDw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1598.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 10:08:06 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8e8b:856e:12eb:ff9d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8e8b:856e:12eb:ff9d%9]) with mapi id 15.20.5924.016; Sat, 17 Dec 2022
 10:08:06 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Allen Webb <allenwebb@google.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 2/5] modpost: Track module name for built-in modules
Thread-Topic: [PATCH v7 2/5] modpost: Track module name for built-in modules
Thread-Index: AQHZEZw7scdeeR4XykOSKvsY47HBN65x27EA
Date:   Sat, 17 Dec 2022 10:08:06 +0000
Message-ID: <2808606f-e1df-e022-d676-ca07f131d518@csgroup.eu>
References: <Y5IA2NYE5IaAzNby@kroah.com>
 <20221216221703.294683-1-allenwebb@google.com>
 <20221216221703.294683-3-allenwebb@google.com>
In-Reply-To: <20221216221703.294683-3-allenwebb@google.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB1598:EE_
x-ms-office365-filtering-correlation-id: b67fa018-bfd8-44c7-c96e-08dae01697bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NFWM71BMgBhO5EhD+O/ALzB6j4ogaxQ0xdXfO10pqevskvE5n5crRb2HY88s2G04Sv5qADEwoXk06+zzhGhGXxN21s+mMeKmYlWhzkuia/a0SSG+/8enDcjzg0whEJABPssUSu+xzFWmtZguOICqSgaTHzwrY+2TuWVoXx0DjaifugnQroh87hf7rm1LlOYPwC4rlGIk5KCGZGKnvgF4YewtZwSMPwnp4KdLFrGLGXzKBeJRXn9lOPGNlixXCMU6Uo52AVZHEr5t2wHYUkcLf/pH17be6a66IHABkg/ihZP+TzhDqQPveMiGB/7XWZ1bk4u2MnjPbADP1w8zLN1TtmB+Fdz7YNm7qEU8NAs5+T9izqCdypedcw+kX3XJ+WaTtqVz+vEN+vpvYgFA0GbikglAKhjIm/38+T1FEOHylHprvPql+fTFhBC+r7bPDrquFmQkrbNudosg/iEzIjgqwaY2sWp0Iedt9/23wwN4KJyzlUhGxpzoe0KCVHBc1pvN0y6ZQaHv6xs63s2T4WGwvFf56vX/Am0uYnOC9Z93e3w5djPGjMCKgHXSlZBF5JUXbbT7ubwicf6hw3KFvh6gWP8XORGj+H5g0rrv9o4EERdnwDt+VeE0QR6hsTQuWBUXwvQN44t5n30k6Z3kVARgER14CwpRyaVWQnP+VVepRjqTWRgn9nGjFFG9cSJ+wCF2Wx29PqCsDwQ/6SKvq/QBedNncewtosJBQjsSOLWrXjS3CHxbCGBIx0U3aeyMbeZKKpeG74xMv5aEcv0cE9vGcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(39850400004)(396003)(451199015)(71200400001)(6506007)(2906002)(478600001)(6486002)(31686004)(6512007)(26005)(186003)(316002)(36756003)(54906003)(110136005)(66946007)(66446008)(2616005)(76116006)(66556008)(66476007)(64756008)(4326008)(8676002)(91956017)(8936002)(41300700001)(5660300002)(122000001)(83380400001)(44832011)(38100700002)(86362001)(38070700005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHFBaXRnQU5qVVk2eXo0ZzEySE15S1ptZ0NYbU53NWkwSDZkWWJQVVpOSGlW?=
 =?utf-8?B?TXdmV1J4UWJHKzNhY1R0V0cxY0t5bUpDYjlPQzh4b3BJQUpSR01WMXo1OFRH?=
 =?utf-8?B?REZtVkNGd25IVkVqWHZVVlRLRVZwekxxZFpyZzVnT0U4elpWSkpadWN6ZHA2?=
 =?utf-8?B?azdydUN0VXBseThTbWQ5dXlNeUJMdUxqRUJLZjRGNHY0SUNtYWhZN1A4d09h?=
 =?utf-8?B?by9qUjJqYnUwanNMclRzWXpkNzhvcUxlWDFrcHFMczU4L2JaVk5weEJhMEJP?=
 =?utf-8?B?RFRNMTd5ZVQxTzBPcHhNWFJNK2dqZU5iNTk0ZkNWdGFIMHV5aDJ3KzhOcU52?=
 =?utf-8?B?YW12bEZIbElCdGZKOEM3Ris4WVI0N3ZrTVlTdHo1YnpIeEZPQS9GMUF2QTRk?=
 =?utf-8?B?M0h0bElmYkVyRWtxc2Jtb2dZVTA0QWpiV1I3WE5GWmpMZ203M0kzMVByTlMr?=
 =?utf-8?B?RVRjdmJERFQ1SmpldW05WUhHU1hvdWdieGJOS0xPV1ZvdmNJcFkrTVo0cStu?=
 =?utf-8?B?MHhxSmtWMnBrQjJQVEQzb09wNDE4VUhDUkFQV045akZ2QnAyNFU2MGROb3dF?=
 =?utf-8?B?QjdwU0RsLzNxSlJoTWhBQjVuMFpTdmFobitFKzM0RGg3MGpXYlhSNkFjcktC?=
 =?utf-8?B?WHo2cytVUXFuNWk2dk4xemdJdGVhN2FJR1duUW1LOEVjQU43N0RtMFAvbGtv?=
 =?utf-8?B?Nm1SUGhwWjFwN0M5VXdKZ3FnZWE0NGVvT1VlMDFDaHl0UXRHYWszdDc1Yy9t?=
 =?utf-8?B?TjM5eE12Y1FZSWs3WmgyR1l3NW12MmwvOFUyQUVMRDgySWhqdXlua0o2dTlk?=
 =?utf-8?B?NUx3K3NhdkYzbDNkWWI2ZGVsRXJHOE1RbHpNNHpsL2xvVXRYMVdiMEpvZ3BT?=
 =?utf-8?B?aUE3eXA1K3RmWndCSkN6Szh6VHJEbjZDc1JSb3hYVEpZNmpaTXBkS1VJcTlm?=
 =?utf-8?B?Vkh2Zzd5ZGZXUCtjdXpWYmgyQ1lxL1R4LzdQS0Ezd3duOU13K1QxMVpQZksx?=
 =?utf-8?B?Y3QvV0pGdmtqRGpKUHNtTm9GVStTWW0rdDhFUzBCdDlaNXE3eFdXTk1ncTRh?=
 =?utf-8?B?bFJCcEd6NmZMdjRoVzJNNGdQNlRpdDFuaDAyb1BlRDdqSnAxVTVGL2ZFZ2FI?=
 =?utf-8?B?Qzl1QTM1UTRMaWwyUnRtTDFERWYxSTZJVEx5akx3S0NWMnBNajE4dmtVaEdJ?=
 =?utf-8?B?cWRVNm83R2lCV2VhdXdFQVNlS3pjK05LUE1GVFlFc1RaTmNBL09sSSszaXBS?=
 =?utf-8?B?c1U2RmpwcE92OFpOMXhMdm05VlJSbWo5UEZDOVFYWnM3dTZTcm51R3RZdStj?=
 =?utf-8?B?b1VMZ3NCQ0xPNmdOZTFKU1VTMk8xQXRnYjdMdk4vT0FSc2grM1RXTzBqU1RU?=
 =?utf-8?B?SzJ5eStadXI2bzZPNXlHUWJTSnZSK1VWSEVmM1dGd0lnUk5yREtFdkNHSk4z?=
 =?utf-8?B?b2Fad1c1ZEkwaTZMVVo5b3NyRGV5UzBha1pjS2tMUmpsOFNRb2lVd0ZsNVRj?=
 =?utf-8?B?VEo0c2hhajZnNlFlbGhkQXQ4RGdwb29RMjVXcnZoVE90Sjg0di9ZK3RHVXA1?=
 =?utf-8?B?MVJaa1J1WnpnUGlsajRTblFjcjlrbHk2aU1wR01obnhJOG9MZ0MwWHQrRGg4?=
 =?utf-8?B?MjNvamU4OVdKT0gyb0tuY2JkSzFwMTJibVZqQzBOcURZenJPKzNHSmJEaXJM?=
 =?utf-8?B?c2tEMTVVVXVmMXFXUS91eldVWkJDUCtyU3g2WEw4ZHdmTVZJaW9YT2V6dkJo?=
 =?utf-8?B?ajgxeS91MzMvbFpaL0lnZjd6UHlpWUFSM09FeFJTVkpJL0VrLzBlRjBvOHpl?=
 =?utf-8?B?SHFqSG40SFRlSmc2bmNReTU4RDRGLzlpWTY1aFc0RjlDMGladDVkelZ0RjR4?=
 =?utf-8?B?RkZmcTBjWDhKTEFLQkpXMTFHT0MrRzltcmViOEJiME02Q0RReXNkWG1BWUpo?=
 =?utf-8?B?aWNBc3c3bkZzYi9PTmlyQ3hLYW5RR1UwTkJjRG9EeGtVV2dxRjZuSmozcWtm?=
 =?utf-8?B?Y2lkTFVhQlV6NlZIUjFGNmdUM2Yxa2FHcENjbmc3dytrZ05tSmk0c0tPdFRR?=
 =?utf-8?B?V3FONG40S3ZkbC8wWGtyY3ZoWHB4VFFqVmlDS3Q4ZG05Z2dnVmoyaytSSG5k?=
 =?utf-8?B?ZEtPNmNCd01tTkJZNWpRWkRkNk9HUTlySHoreWpJMDlBNzZtUnovcWFVZGN3?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A358918B232787418E4DDB9B4A0ACE8F@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b67fa018-bfd8-44c7-c96e-08dae01697bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2022 10:08:06.5760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYW1YER1CmoatBk2m+if46wmX+BOTEsh9oWCrL2gTJO5P/N7k7jAspOJ11z/vJN0stdztlzHkfGzLwaBG2shzj2RQDEZpkMlNRpkGxssaBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1598
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE2LzEyLzIwMjIgw6AgMjM6MTcsIEFsbGVuIFdlYmIgYSDDqWNyaXTCoDoNCj4gS2Vl
cCB0cmFjayBvZiB0aGUgbW9kdWxlIG5hbWUgd2hlbiBwcm9jZXNzaW5nIG1hdGNoIHRhYmxlIHN5
bWJvbHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGxlbiBXZWJiIDxhbGxlbndlYmJAZ29vZ2xl
LmNvbT4NCj4gLS0tDQo+ICAgc2NyaXB0cy9tb2QvZmlsZTJhbGlhcy5jIHwgMzcgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiAgIHNjcmlwdHMvbW9kL21vZHBvc3QuaCAg
ICB8ICAxICsNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9tb2QvZmlsZTJhbGlhcy5jIGIvc2Ny
aXB0cy9tb2QvZmlsZTJhbGlhcy5jDQo+IGluZGV4IDgwZDk3MzE0NGZkZWQuLjQ1OGU0MWFlMGY1
ZjEgMTAwNjQ0DQo+IC0tLSBhL3NjcmlwdHMvbW9kL2ZpbGUyYWxpYXMuYw0KPiArKysgYi9zY3Jp
cHRzL21vZC9maWxlMmFsaWFzLmMNCj4gQEAgLTI4LDYgKzI4LDcgQEAgdHlwZWRlZiBFbGY2NF9B
ZGRyCWtlcm5lbF91bG9uZ190Ow0KPiAgICNpbmNsdWRlIDxzdGRpbnQuaD4NCj4gICAjZW5kaWYN
Cj4gICANCj4gKyNpbmNsdWRlIDxhc3NlcnQuaD4NCj4gICAjaW5jbHVkZSA8Y3R5cGUuaD4NCj4g
ICAjaW5jbHVkZSA8c3RkYm9vbC5oPg0KPiAgIA0KPiBAQCAtMTU0MCw5ICsxNTQxLDkgQEAgdm9p
ZCBoYW5kbGVfbW9kZGV2dGFibGUoc3RydWN0IG1vZHVsZSAqbW9kLCBzdHJ1Y3QgZWxmX2luZm8g
KmluZm8sDQo+ICAgCQkJRWxmX1N5bSAqc3ltLCBjb25zdCBjaGFyICpzeW1uYW1lKQ0KPiAgIHsN
Cj4gICAJdm9pZCAqc3ltdmFsOw0KPiAtCWNoYXIgKnplcm9zID0gTlVMTDsNCj4gLQljb25zdCBj
aGFyICpuYW1lLCAqaWRlbnRpZmllcjsNCj4gLQl1bnNpZ25lZCBpbnQgbmFtZWxlbjsNCj4gKwlj
aGFyICp6ZXJvcyA9IE5VTEwsICptb2RuYW1lX3N0ciA9IE5VTEw7DQo+ICsJY29uc3QgY2hhciAq
bmFtZSwgKmlkZW50aWZpZXIsICptb2RuYW1lOw0KPiArCXVuc2lnbmVkIGludCBuYW1lbGVuLCBt
b2RuYW1lbGVuOw0KPiAgIA0KPiAgIAkvKiBXZSdyZSBsb29raW5nIGZvciBhIHNlY3Rpb24gcmVs
YXRpdmUgc3ltYm9sICovDQo+ICAgCWlmICghc3ltLT5zdF9zaG5keCB8fCBnZXRfc2VjaW5kZXgo
aW5mbywgc3ltKSA+PSBpbmZvLT5udW1fc2VjdGlvbnMpDQo+IEBAIC0xNTUyLDcgKzE1NTMsMTEg
QEAgdm9pZCBoYW5kbGVfbW9kZGV2dGFibGUoc3RydWN0IG1vZHVsZSAqbW9kLCBzdHJ1Y3QgZWxm
X2luZm8gKmluZm8sDQo+ICAgCWlmIChFTEZfU1RfVFlQRShzeW0tPnN0X2luZm8pICE9IFNUVF9P
QkpFQ1QpDQo+ICAgCQlyZXR1cm47DQo+ICAgDQo+IC0JLyogQWxsIG91ciBzeW1ib2xzIGFyZSBv
ZiBmb3JtIF9fbW9kXzxuYW1lPl9fPGlkZW50aWZpZXI+X2RldmljZV90YWJsZS4gKi8NCj4gKwkv
KiBBbGwgb3VyIHN5bWJvbHMgYXJlIGVpdGhlciBvZiBmb3JtDQo+ICsJICogICBfX21vZF88bmFt
ZT5fXzxpZGVudGlmaWVyPl9kZXZpY2VfdGFibGUNCj4gKwkgKiBvcg0KPiArCSAqICAgX19tb2Rf
PG5hbWU+X188aWRlbnRpZmllcj5fX2ttb2RfPGJ1aWx0aW4tbmFtZT5fZGV2aWNlX3RhYmxlDQo+
ICsJICovDQoNCkNvbW1lbnRzIHN0eWxlIGlzIHdyb25nLiBNdWx0aWxpbmUgY29tbWVudHMgb3V0
c2lkZSBuZXQvIHN0YXJ0IHdpdGggYW4gDQplbXB0eSAvKiBsaW5lLg0KDQo+ICAgCWlmIChzdHJu
Y21wKHN5bW5hbWUsICJfX21vZF8iLCBzdHJsZW4oIl9fbW9kXyIpKSkNCj4gICAJCXJldHVybjsN
Cj4gICAJbmFtZSA9IHN5bW5hbWUgKyBzdHJsZW4oIl9fbW9kXyIpOw0KPiBAQCAtMTU2NCw4ICsx
NTY5LDI5IEBAIHZvaWQgaGFuZGxlX21vZGRldnRhYmxlKHN0cnVjdCBtb2R1bGUgKm1vZCwgc3Ry
dWN0IGVsZl9pbmZvICppbmZvLA0KPiAgIAlpZGVudGlmaWVyID0gc3Ryc3RyKG5hbWUsICJfXyIp
Ow0KPiAgIAlpZiAoIWlkZW50aWZpZXIpDQo+ICAgCQlyZXR1cm47DQo+ICsJbW9kbmFtZWxlbiA9
IG5hbWVsZW47DQo+ICAgCW5hbWVsZW4gPSBpZGVudGlmaWVyIC0gbmFtZTsNCj4gICANCj4gKwkv
KiBJbiB0aGUgdm1saW51ei5vIGNhc2Ugd2Ugd2FudCB0byBoYW5kbGUgX19rbW9kXyBzbyBhbGlh
c2VzIGZyb20NCj4gKwkgKiBidWlsdGluIG1vZHVsZXMgYXJlIGF0dHJpYnV0ZWQgY29ycmVjdGx5
Lg0KPiArCSAqLw0KPiArCW1vZG5hbWUgPSBzdHJzdHIoaWRlbnRpZmllciArIDIsICJfX2ttb2Rf
Iik7DQo+ICsJaWYgKG1vZG5hbWUpIHsNCj4gKwkJbW9kbmFtZSArPSBzdHJsZW4oIl9fa21vZF8i
KTsNCj4gKwkJbW9kbmFtZWxlbiAtPSAobW9kbmFtZSAtIG5hbWUpICsgc3RybGVuKCJfZGV2aWNl
X3RhYmxlIik7DQo+ICsJCW1vZG5hbWVfc3RyID0gbWFsbG9jKG1vZG5hbWVsZW4gKyAxKTsNCj4g
KwkJLyogV2UgZG9uJ3Qgd2FudCB0byBjb250aW51ZSBpZiB0aGUgYWxsb2NhdGlvbiBmYWlscy4g
Ki8NCj4gKwkJYXNzZXJ0KG1vZG5hbWVfc3RyKTsNCj4gKwkJbWVtY3B5KG1vZG5hbWVfc3RyLCBt
b2RuYW1lLCBtb2RuYW1lbGVuKTsNCj4gKwkJbW9kbmFtZV9zdHJbbW9kbmFtZWxlbl0gPSAnXDAn
Ow0KPiArCX0NCj4gKw0KPiArCWlmIChtb2RuYW1lX3N0cikNCj4gKwkJbW9kbmFtZSA9IG1vZG5h
bWVfc3RyOw0KPiArCWVsc2UNCj4gKwkJbW9kbmFtZSA9IG1vZC0+bmFtZTsNCj4gKwltb2QtPmJ1
aWx0aW5fbmFtZSA9IG1vZG5hbWU7DQo+ICsNCj4gICAJLyogSGFuZGxlIGFsbC1OVUxMIHN5bWJv
bHMgYWxsb2NhdGVkIGludG8gLmJzcyAqLw0KPiAgIAlpZiAoaW5mby0+c2VjaGRyc1tnZXRfc2Vj
aW5kZXgoaW5mbywgc3ltKV0uc2hfdHlwZSAmIFNIVF9OT0JJVFMpIHsNCj4gICAJCXplcm9zID0g
Y2FsbG9jKDEsIHN5bS0+c3Rfc2l6ZSk7DQo+IEBAIC0xNTk3LDYgKzE2MjMsOSBAQCB2b2lkIGhh
bmRsZV9tb2RkZXZ0YWJsZShzdHJ1Y3QgbW9kdWxlICptb2QsIHN0cnVjdCBlbGZfaW5mbyAqaW5m
bywNCj4gICAJCX0NCj4gICAJfQ0KPiAgIAlmcmVlKHplcm9zKTsNCj4gKwltb2QtPmJ1aWx0aW5f
bmFtZSA9IE5VTEw7DQo+ICsJaWYgKG1vZG5hbWVfc3RyKQ0KPiArCQlmcmVlKG1vZG5hbWVfc3Ry
KTsNCj4gICB9DQo+ICAgDQo+ICAgLyogTm93IGFkZCBvdXQgYnVmZmVyZWQgaW5mb3JtYXRpb24g
dG8gdGhlIGdlbmVyYXRlZCBDIHNvdXJjZSAqLw0KPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9tb2Qv
bW9kcG9zdC5oIGIvc2NyaXB0cy9tb2QvbW9kcG9zdC5oDQo+IGluZGV4IDExNzhmNDBhNzNmM2Qu
LjM0ZmU1ZmMwYjAyY2IgMTAwNjQ0DQo+IC0tLSBhL3NjcmlwdHMvbW9kL21vZHBvc3QuaA0KPiAr
KysgYi9zY3JpcHRzL21vZC9tb2Rwb3N0LmgNCj4gQEAgLTEyOCw2ICsxMjgsNyBAQCBzdHJ1Y3Qg
bW9kdWxlIHsNCj4gICAJc3RydWN0IGxpc3RfaGVhZCBtaXNzaW5nX25hbWVzcGFjZXM7DQo+ICAg
CS8vIEFjdHVhbCBpbXBvcnRlZCBuYW1lc3BhY2VzDQo+ICAgCXN0cnVjdCBsaXN0X2hlYWQgaW1w
b3J0ZWRfbmFtZXNwYWNlczsNCj4gKwljb25zdCBjaGFyICpidWlsdGluX25hbWU7DQo+ICAgCWNo
YXIgbmFtZVtdOw0KPiAgIH07DQo+ICAgDQo=
