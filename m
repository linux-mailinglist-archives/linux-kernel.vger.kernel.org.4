Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1490773D18B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjFYOpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFYOpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:45:19 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495EF13E;
        Sun, 25 Jun 2023 07:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktlZ2iCIORQ9HKd9WUMXr0yZ+11Hwmhiw0XtyZzcJanw3cJl//5xx/4ZV86Bc8mLu7s8/76PJRf3lz4IUlzGRM3DTV2xXQ0Yk9ruoaZHveJUD0wWUCHisq6DUNNEo3APUJv+xIuITCgtb6lEYQdkJD1I+hFYouCf6U86B4IAePPwLvsaN7QDFcRaU6bob8nglu1YPCPof0+XL47oGjlsfAGKO+v1RxohvTB6225dxsYQwlms2Hb9zMmRbIjqB7/g3Ri4Pz31lKpLFkwVJxttYz7tI+3cIabT9nQVPe1jiDOaVpCUUaPoSmOo2mYRJxKnNS1IOsfD3QODpmbNUZ3Ejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLfAPeFQeAJ3m/RPTMp2h0zHiacLma+VhXWtrvxXKb8=;
 b=Iizh5UW/TGB2niqMxJRWU8E4J/MsKsGcINlJ7ThVupTzCgs3T0lJMeaGEByuQUwbaHIfrJA2XtJOPU7WOVJMssGGx+kxl8rR1wWnfOKUzq7T03pbY/DAhumWSuO0MiBrHbpgGY5duKxHibaBgWMMHcpj97X1KrnoFQc3mZrRg3AAWxLcrZYLUfyg1NuvooUK5nDtU2fo6TANREGbpJq3zH7wW8b1RmWFVQWcAlCTd6BB/YaV6PFR0WxL7PwvYEykSW3pAgjUAArKKkHC1kC4bRAQ7Aockd6f/ua7Q/o7Gap2qRfvdhkZg3ABo3gOWtP0+5d9bVrxGEovP0W3BjBTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLfAPeFQeAJ3m/RPTMp2h0zHiacLma+VhXWtrvxXKb8=;
 b=FQCpw0/wKBFxOrGyOSQ3D0ZK/6wehazQ0rrpnxvfJE3jk0HhLN8jDL7aXF1GbwXL9f8iQk5GJszlNyYM4GLUH9pmUjY1PSMdQm0qrNR27MHapYQskqENXcVI0aJvzbt7XvYHjmqM/MDXjucZORcyGKLB8Pw4vPEZY8/9J6kkZlI=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TY1P286MB3392.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2ef::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Sun, 25 Jun 2023 14:45:13 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b429:5aa3:12f1:6b8]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b429:5aa3:12f1:6b8%4]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 14:45:13 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "andy@kernel.org" <andy@kernel.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] gpio: gpiolib-cdev: Fix potential &lr->wait.lock deadlock
 issue
Thread-Topic: [PATCH] gpio: gpiolib-cdev: Fix potential &lr->wait.lock
 deadlock issue
Thread-Index: AQHZp3MKCKremSKpfUKxLQfpASRqlQ==
Date:   Sun, 25 Jun 2023 14:45:12 +0000
Message-ID: <TYCP286MB1188B6A0379F7928C63288DF8A21A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB1188:EE_|TY1P286MB3392:EE_
x-ms-office365-filtering-correlation-id: bf081694-7031-4843-6e1a-08db758ac851
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ZUjEelxDbFQBUCXCaq3/DKKzQa75kKa9LcH+/rxO4gxNyCxxmtLtNv9UoAHe46xERi0TvWDdWxSZWdCiFSv8q9vT/b73nweln3DLlxZI93RCym0tZHsEv9CeOxRcUjTfvs8341sCOxYLNUGw8NsxU/qoaPsvghkiNpd5NGAKkQODaPvEEah6FeN6BAyLfG64d8rqpouqvlePW3d9NXu2NcYD3pRb0Ecu12vd4Qf8V1B7/MzAQ0RdHaecu6jdmSvRvEFO73xd9Jyr7qUuN+VEPdppeO0XoGl+WQKUX+zf9xxESdkBwapoMfKiABjqPHPor3nPaH5/PhfCwbepPOuEKJG1L4fLYGO9/v17EUc50XxOSfjP8czyC/0RdahzUV+U+TVFSCXceK9Z/LnZWoTuto1jKdTlHc3FKqdBngMR1/o9oEGM4bJkTB1JafVOKnfzxskP1kxc2zK4LvfMYLo+NqF4hwSY6XmVhHKmauUKyYbKZxnVO4gBOFHfUebXbpNFjCutJwpx+976QWqKKv07D8jlLNWmgHr0NU0IpJOW3QTDC7Jh9FBt0PqCC54D1LRsrHzJIl+CaUMLkCp0p4pTVu5DuKVp4ZHipbcudP53tnjkFedbQWBXF/YTTdRvPkM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(2906002)(26005)(186003)(71200400001)(786003)(38100700002)(122000001)(9686003)(6506007)(52536014)(5660300002)(83380400001)(41300700001)(8936002)(66446008)(66476007)(76116006)(64756008)(66556008)(66946007)(91956017)(8676002)(33656002)(55016003)(38070700005)(54906003)(7696005)(86362001)(4326008)(316002)(110136005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aSt3WjZkNXpMMGxGRzZRZDRjVW5XT1FjaUFOOXRkTmFXSXRtSExlcENLbTlm?=
 =?gb2312?B?d3BsN2VEc0JjWTZ0SytwajRHUXJLY2xDaExMa2NBRmljTnlJQkswNmIxRXk3?=
 =?gb2312?B?SGJseVQxRnY1akU5UUE0aXF3bTBDZFA0SEUwVXEycnhrMkNMOWVkQzY3eEc2?=
 =?gb2312?B?NlZ5LytYa1FhZmFVeEE5MnhYTFYvT1U0dEZXcUNha1JlR1F1Z1d1S29leWdx?=
 =?gb2312?B?d0F4SWg0N3BYZCtzT1lsYkpWaUs3Uk5tT0xSbDNxVy9ONTNvc3VvL3Fuc2hF?=
 =?gb2312?B?UFd1UU9vVXprSExnMzc5dUt0NllhZ04yaG1rbTFQck83cGtrNEttblZYTUMx?=
 =?gb2312?B?Nyt6UTVwS1JwRWgzc05jelVieVZxUkVDWTU3YWhvM1JLclkweGtwcWRRMENK?=
 =?gb2312?B?RUpjZDRPM25IVkUxTEpHUFpHYkNvTDRrbkYyd1VwVDdXbks3YVU5YmxpaXc2?=
 =?gb2312?B?MDRyYjBIRXRBZ0piUWZaSkYwZkVYWjlIa2RZUU9Gc0pqaVlpQWNSUW5BNTM4?=
 =?gb2312?B?aUFSQXh3TWZXQUhRZmw0M3dQYlE0Zm5wTjNoL3NLWmZaY2pjVzMzdWF4RXJp?=
 =?gb2312?B?bFNJWE1QTXpwUE4xVTdqRlhtTWxPNWxiSStuSzlMQkdJL3ptbmJGTk94cTIr?=
 =?gb2312?B?RDN1c2h3RmIrM3NnZDVoWWdSWHdPdWo0aW5EeHVLNHIrK0lZRW1rWjZSU2dt?=
 =?gb2312?B?cVV1SkVIR0xpdmxESlpmcUExODJzK1BDaldCNmo0RW4vQUxWbSs0VmZOMVlu?=
 =?gb2312?B?aWdEdlBRMEZmMnRaTGcrZTZtSHJ3cFM4emk3VDJ4N0JvYS9kV2pSM1VWa0sy?=
 =?gb2312?B?cGlzLy91VHpaWjIxOTlqVTVOQXNac3Iyc2hNaDd2S0t1Qjk2eld3VjVlNzNS?=
 =?gb2312?B?RHBzQWdpMUloU0s3aGdTcklTRDN1QWlCbUw0SnJJNDdDNGs4ODR3Z2hMSzcr?=
 =?gb2312?B?bXF6YXVNa2xPc3A0RVJzZHIxbzFJTitiekNYQjhBWFk3Vko0bjlIQVVXR2hW?=
 =?gb2312?B?WkpWb090TmVIL3haK3lveHhmQmhBVzJWMFQyeGVqdTRDVnFSakY2bitMaHAx?=
 =?gb2312?B?N2xwbXd3QlNyYUZRUFl0RWY3UzRQRVJJdmxoTnN2SlUvNGNuck9rdmhkRndz?=
 =?gb2312?B?TmI1WENkcTEwWm9YY1VuUnFJWjNjVUtSakJBWFJuMzhOYm4vMWFmZS9DazRK?=
 =?gb2312?B?c3BMdGNwbjVlbit4dUhCRm1NSHhvMElLNWUvTmhNOGZWNHZ6aVd4QVZOMkxC?=
 =?gb2312?B?cVZrMytjWFNPajVFYmdTZjJFZ1ZxOS92ay9ISzNMS2pXZm15Wk5vWlcwOVVM?=
 =?gb2312?B?QVcxUDVBV1c3SG1KM2Z2UGN3V0NGeWNIM0RCMjY1Qit1dENCMEp3dDN5dlVu?=
 =?gb2312?B?bmZpOExjZ21ZV1Jnd1JmUGpnNmlkaWFFTThKcElNNFgydm1rZ0doL3dVdThu?=
 =?gb2312?B?WG52M2VLbXVncEtJU1pKd1dsbHIycXo5cE5RMUFRYTl3c2hSVkJuM3VmQmpy?=
 =?gb2312?B?QUxSUDlUZURIVUtEQkhoTVdueDFtSnhhTWFaNG5XcVMwajlYaFA0M1kwb3Fq?=
 =?gb2312?B?RGtTZGYyQ04yRUE1K3R1aHFlMjlKRDg2ZHcwang0UlBUOTcrNDZYZ1E1OFFI?=
 =?gb2312?B?VHJ6VkFIRy9kOXoxVUMrcjdjMVZSTUJTcjZEbm9FemxmUmNhQWlNUWRjbjdy?=
 =?gb2312?B?K3kwL1VqSTNxME9jSmRvbTJHWFVNVTIwRTF2ek5jUStQdVFLeXdoSHRiUXNT?=
 =?gb2312?B?Q2VKMDhteVFNL1lLVEh1UG9wd2Z2aytxMmhPZ0E5cVo3RnZWMUNsN3J1cWE0?=
 =?gb2312?B?cVlMdW8wZmhXVXpqRGNBYk5jTGRUcUZ5WU1Demltc0thR1FoUlYveFRaUHJa?=
 =?gb2312?B?VjkwbDlUTTRPbUlXT1hGeCsvb2hBdk1lWTJOd0U4ODZQV3JSdzIvdjR3VWNu?=
 =?gb2312?B?aXVqOUVNWjA4T3EwV3QvNkoxcEJUdVpPRlVsejBTaXBnMGNEL0o4SVI5bW8r?=
 =?gb2312?B?ODBVaTlIRSsyTTBBYzdkQ0FhSnZ4K2xjTGJtL3pZNjBZN0N1Y3FkYzZrbEZn?=
 =?gb2312?B?OXJ2Q2hwSjI5emxqSmpOWGp2Q2V2RHA4LzVuWHFqMUZlSVdPbXpyMVRtUkQz?=
 =?gb2312?Q?nOqztp5Z+kvcdTGmIn/h/1fCf?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bf081694-7031-4843-6e1a-08db758ac851
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 14:45:12.9239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNnxSwYCarz9lZmhSrgf2sbvul8P0L9HLyLgMZ9Hr4HF7rGUEvES6g7SIDgCHRK+Ek7Xf+6N4SOwhwrnKKGuGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3392
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bGluZXJlcV9wdXRfZXZlbnQgaXMgY2FsbGVkIGZyb20gYm90aCBpbnRlcnJ1cHQgY29udGV4dCAo
ZS5nLiwKZWRnZV9pcnFfdGhyZWFkKSBhbmQgcHJvY2VzcyBjb250ZXh0IChwcm9jZXNzX2h3X3Rz
X3RocmVhZCkuClRoZXJlZm9yZSwgaW50ZXJydXB0IHNob3VsZCBiZSBkaXNhYmxlZCBiZWZvcmUg
YWNxdWlyaW5nIGxvY2sKJmxyLT53YWl0LmxvY2sgaW5zaWRlIGxpbmVyZXFfcHV0X2V2ZW50IHRv
IGF2b2lkIGRlYWRsb2NrIHdoZW4KdGhlIGxvY2sgaXMgaGVsZCBpbiBwcm9jZXNzIGNvbnRleHQg
YW5kIGVkZ2VfaXJxX3RocmVhZCBjb21lcy4KClNpbWlsYXJseSwgbGluZXJlcV9yZWFkX3VubG9j
a2VkIHJ1bm5pbmcgaW4gcHJvY2VzcyBjb250ZXh0CmFsc28gYWNxdWllcyB0aGUgc2FtZSBsb2Nr
LiBJdCBhbHNvIG5lZWQgdG8gZGlzYWJsZSBpbnRlcnJ1cHQKb3RoZXJ3aXNlIGRlYWRsb2NrIGNv
dWxkIGhhcHBlbiBpZiB0aGUgaXJxIGVkZ2VfaXJxX3RocmVhZApjb21lcyB0byBleGVjdXRpb24g
d2hpbGUgdGhlIGxvY2sgaXMgaGVsZC4KCkZpeCB0aGUgdHdvIHBvdGVudGlhbCBkZWFkbG9jayBp
c3N1ZXMgYnkgc3Bpbl9sb2NrX2lycXNhdmUuCgpTaWduZWQtb2ZmLWJ5OiBDaGVuZ2ZlbmcgWWUg
PGN5ZWFhQGNvbm5lY3QudXN0LmhrPgotLS0KIGRyaXZlcnMvZ3Bpby9ncGlvbGliLWNkZXYuYyB8
IDE2ICsrKysrKysrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDcg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncGlvL2dwaW9saWItY2Rldi5jIGIv
ZHJpdmVycy9ncGlvL2dwaW9saWItY2Rldi5jCmluZGV4IDBhMzM5NzFjOTY0Yy4uNzE0NjMxZmRl
OWE4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi1jZGV2LmMKKysrIGIvZHJpdmVy
cy9ncGlvL2dwaW9saWItY2Rldi5jCkBAIC02MTQsMTQgKzYxNCwxNSBAQCBzdGF0aWMgdm9pZCBs
aW5lcmVxX3B1dF9ldmVudChzdHJ1Y3QgbGluZXJlcSAqbHIsCiAJCQkgICAgICBzdHJ1Y3QgZ3Bp
b192Ml9saW5lX2V2ZW50ICpsZSkKIHsKIAlib29sIG92ZXJmbG93ID0gZmFsc2U7CisJdW5zaWdu
ZWQgbG9uZyBmbGFnczsKIAotCXNwaW5fbG9jaygmbHItPndhaXQubG9jayk7CisJc3Bpbl9sb2Nr
X2lycXNhdmUoJmxyLT53YWl0LmxvY2ssIGZsYWdzKTsKIAlpZiAoa2ZpZm9faXNfZnVsbCgmbHIt
PmV2ZW50cykpIHsKIAkJb3ZlcmZsb3cgPSB0cnVlOwogCQlrZmlmb19za2lwKCZsci0+ZXZlbnRz
KTsKIAl9CiAJa2ZpZm9faW4oJmxyLT5ldmVudHMsIGxlLCAxKTsKLQlzcGluX3VubG9jaygmbHIt
PndhaXQubG9jayk7CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbHItPndhaXQubG9jaywgZmxh
Z3MpOwogCWlmICghb3ZlcmZsb3cpCiAJCXdha2VfdXBfcG9sbCgmbHItPndhaXQsIEVQT0xMSU4p
OwogCWVsc2UKQEAgLTE1MDUsNiArMTUwNiw3IEBAIHN0YXRpYyBzc2l6ZV90IGxpbmVyZXFfcmVh
ZF91bmxvY2tlZChzdHJ1Y3QgZmlsZSAqZmlsZSwgY2hhciBfX3VzZXIgKmJ1ZiwKIAlzdHJ1Y3Qg
bGluZXJlcSAqbHIgPSBmaWxlLT5wcml2YXRlX2RhdGE7CiAJc3RydWN0IGdwaW9fdjJfbGluZV9l
dmVudCBsZTsKIAlzc2l6ZV90IGJ5dGVzX3JlYWQgPSAwOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7
CiAJaW50IHJldDsKIAogCWlmICghbHItPmdkZXYtPmNoaXApCkBAIC0xNTE0LDI4ICsxNTE2LDI4
IEBAIHN0YXRpYyBzc2l6ZV90IGxpbmVyZXFfcmVhZF91bmxvY2tlZChzdHJ1Y3QgZmlsZSAqZmls
ZSwgY2hhciBfX3VzZXIgKmJ1ZiwKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAlkbyB7Ci0JCXNwaW5f
bG9jaygmbHItPndhaXQubG9jayk7CisJCXNwaW5fbG9ja19pcnFzYXZlKCZsci0+d2FpdC5sb2Nr
LCBmbGFncyk7CiAJCWlmIChrZmlmb19pc19lbXB0eSgmbHItPmV2ZW50cykpIHsKIAkJCWlmIChi
eXRlc19yZWFkKSB7Ci0JCQkJc3Bpbl91bmxvY2soJmxyLT53YWl0LmxvY2spOworCQkJCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmxyLT53YWl0LmxvY2ssIGZsYWdzKTsKIAkJCQlyZXR1cm4gYnl0
ZXNfcmVhZDsKIAkJCX0KIAogCQkJaWYgKGZpbGUtPmZfZmxhZ3MgJiBPX05PTkJMT0NLKSB7Ci0J
CQkJc3Bpbl91bmxvY2soJmxyLT53YWl0LmxvY2spOworCQkJCXNwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJmxyLT53YWl0LmxvY2ssIGZsYWdzKTsKIAkJCQlyZXR1cm4gLUVBR0FJTjsKIAkJCX0KIAog
CQkJcmV0ID0gd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlX2xvY2tlZChsci0+d2FpdCwKIAkJCQkJ
IWtmaWZvX2lzX2VtcHR5KCZsci0+ZXZlbnRzKSk7CiAJCQlpZiAocmV0KSB7Ci0JCQkJc3Bpbl91
bmxvY2soJmxyLT53YWl0LmxvY2spOworCQkJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmxyLT53
YWl0LmxvY2ssIGZsYWdzKTsKIAkJCQlyZXR1cm4gcmV0OwogCQkJfQogCQl9CiAKIAkJcmV0ID0g
a2ZpZm9fb3V0KCZsci0+ZXZlbnRzLCAmbGUsIDEpOwotCQlzcGluX3VubG9jaygmbHItPndhaXQu
bG9jayk7CisJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmxyLT53YWl0LmxvY2ssIGZsYWdzKTsK
IAkJaWYgKHJldCAhPSAxKSB7CiAJCQkvKgogCQkJICogVGhpcyBzaG91bGQgbmV2ZXIgaGFwcGVu
IC0gd2Ugd2VyZSBob2xkaW5nIHRoZQotLSAKMi4xNy4x
