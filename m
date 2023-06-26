Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6A673DC61
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjFZKkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjFZKkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:40:04 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2118.outbound.protection.outlook.com [40.107.114.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB4EE71;
        Mon, 26 Jun 2023 03:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aN6OjpdUq+FEJeTZip72qZpjZevNJR3Wn66ht8AOl+RQWXepIqd645G6zJvzLHvEFnKFmynca5kG1ViQavigUTExoSlRsPfWkAzSyAob39xUISsoQe+yk6Q+QBnE6CXI1P/HugNPFZeHZ47dv+vK+1kcb9Eukm1bLNhef+YBgIVWrKIFEk7sy1D4sm64e1aN+P4FM6LXWCOAkCofYXqAVM6RTOYhWH0smLHeH/wV83vH7vbG2NpKrh48yBdFQPfyVEB9Gy7o3pRasa0lvgO4pg4PZljkfvOrBzDvhvnDnB4/N84KDoGdsw3sIy2yZ25YSkQ9K00z8B5Y+pECeE5jSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6j7rOPN5CMI8cbyRrOChwwaYx6B0vg2J4bGj7BtG1o=;
 b=RX/Qbp60PrOf/WPByzGGMxfZhxXoFtXXNGTyXPVpLUAvcbxuqSGQ+5b5SLiFL5hwrUfbYzTnvXADW3egbEPCHko7gCE3/tlN+VCpwf/JYLyXkM3UMLTa2R7xViYGR2kKXKZSQMiV9lh/08GODZmz+ITLQjSrT9oqHC/t5OX7rsKFxn3r1JLeiyYbWH8YfnK3Bh0CZlJS/CZ0ktrzSP/aeCkVsi90zBPx5gSyOySLGMhc6y8M1F/yiYp8jo57QSKcsHhBZnAS3dc5tO3ptELSvlGEhQ3lTJjYdIBD+GHsmH77oYjEQO1uu9e+h7NX3mNOcVkuWnHF0I4hHGfwmd/ZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6j7rOPN5CMI8cbyRrOChwwaYx6B0vg2J4bGj7BtG1o=;
 b=AVWZGXFn1LEqj6ILBIeEfU8EPefWrLlPJ8AOFxNUA+BMdDNCGusk5DY11AG0DtXPgPBMTPws2udgoh0lxEljwyZWVO1wiQs8qm/mB5rxPEQyMz+GN6E+tFdVx6kZtSI30xOGZl7mf4TC4yvByLVj6D0ocZtaO0l7RxBEYo0Yv1o=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYCP286MB1730.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:187::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Mon, 26 Jun 2023 10:40:01 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b429:5aa3:12f1:6b8]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b429:5aa3:12f1:6b8%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 10:40:01 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "andy@kernel.org" <andy@kernel.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] gpiolib: cdev: Fix &le->wait.lock deadlock issue
Thread-Topic: [PATCH v2 2/2] gpiolib: cdev: Fix &le->wait.lock deadlock issue
Thread-Index: AQHZqBRmxizNLtHXWE+SgIMBvkENRg==
Date:   Mon, 26 Jun 2023 10:40:01 +0000
Message-ID: <TYCP286MB1188DCADAAC7318EEC06293E8A26A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB1188:EE_|TYCP286MB1730:EE_
x-ms-office365-filtering-correlation-id: e15352f2-67b3-486f-5c16-08db7631b1b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dr9nw/jS0l6RiyHxud7Bffx7yCwciiBEBTcC6WoPgDDu7jrKqVcIWUw187PK45W19AwUTgtgfTPXbAEzM09znlg9J+vr+IGddrTQSvxe7D0EUshxwdqSkDItj1FqJo3hFLeUALwEdsSp7zvyyg39KS+7ALxkdub759YA7pxl/LBFnbyARQnKodo+IBKa/lI/AL4ZnJrPvlKbbcHA7VaHotpaolLnGQVgJf/DeVE/F9uLtqqZLJX4g9N+TX6qXiz9So3bfW6urUslnEkMRpAJam5zey5TtMZV3gi3TG61ag4A5g0l4p7lbZgalHoIYe75/5oVTlACii39erFWo/N1ip6s1xiD2SkcUA62Q9qeTb5ufrfq1GFY4S1W5XCydhYfx8nd43ygaYl57NQcSVMHptVz7uvIJtBLgFWVWt01KlQadnshhU3bULsVdouGPQAQilgbuNNcpbPb5+ifMQirepMGXuBdagdvv50zbOUiZe6EpSPNg+MNjLZ6Ftz7hZqsp3CmZrFcEax7QqZmHtHbuascYvAtF6U735Ya7DpJREoD8rCOa1meSHtQ3TiV7qEVcsAEWwU8wvr5tBSyMYQGEVn9V6jVGvx1XF8Iiayc7yEmexDYSBegkMpwT/DI2oMz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(8676002)(8936002)(66446008)(76116006)(55016003)(66476007)(66556008)(66946007)(41300700001)(786003)(316002)(64756008)(4326008)(6506007)(26005)(9686003)(186003)(478600001)(54906003)(110136005)(7696005)(71200400001)(91956017)(2906002)(52536014)(5660300002)(38070700005)(122000001)(38100700002)(33656002)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YnB6MGswQktKUXNiR2E1ZE1SVElycllTeDJRYy9lWEtpTzhWaEZnbms1aUpy?=
 =?gb2312?B?MkhOMEYzaC8xeFA0eWgzTDZvNTVXQjl6VXlWaUdoTlBQTko5UU42S1I1OTdL?=
 =?gb2312?B?VWo5VEFlSGdaN1dxbjhEZFFQc1JiUlh1RUxrU1BuZ1B5dW1QVURIVFQ1Nmgy?=
 =?gb2312?B?Tjl4Z3VFU2RoSWtLNmNVTnV2aUszdVM0K1NRT0dSZFl4R2dWczdiQUpIYnp0?=
 =?gb2312?B?a0hZMmN3OTFranl5SWR4OUtVa1kzTzB6amdFOU5ITVpyaWIyblVmTnovalEv?=
 =?gb2312?B?Y2lzZEFmdElRQm0zRWh0OFM0NlVqbGs3ZmRxdi9panFhaWFSdTFWZkZHazYw?=
 =?gb2312?B?OUtqdm9nUU8xdzBpa1lhYW9JeGFFR1BEUzVidlVYSGtRMldZYmRkSlFud1No?=
 =?gb2312?B?WUdXWkU5VmtwRTRXWU95S3hVdCtTWVhZbWlITVpvUHhPcHF3bXRGQXJJMFR1?=
 =?gb2312?B?bDQ2SjdZZlpwU3FpbG5iZU1XNC9WK2lkaUZod3ozVlZkdjB2UmxPRVR5aEov?=
 =?gb2312?B?VkNPNjNrMitxbVl3N3ZlKzA2Z0VxejB6dmlFK214bzFGT1k0Q292M3hJREVt?=
 =?gb2312?B?VWRmUHAyTkZDLzJzQ25tK2pNczVkSTIyRzFNMlJQU3lJamN3cTh1RDFSeWtz?=
 =?gb2312?B?Mnc4UVpXWG12SjhsSWNSNXBJTyt4anE5TDVIYUlrQkEyYUhDTjVzamFuUmR1?=
 =?gb2312?B?S2NRaW5DSC9LeW5hOG50MFk4SlVkQTk2KzhpUThGb244N2phWHhHU2g3ejky?=
 =?gb2312?B?R0NaV3JGcG0vU2RYMGVjbDZNMkI1ZkNjNGhNdGdMdWl3Yy9VUmVhQmdCeDAz?=
 =?gb2312?B?YTZ5Mm5iYkZacGM4cEppNmVJWWFpTGovOEdmTWIzaFV4aytuUndtaklUWWtS?=
 =?gb2312?B?ancySU5ZTW8weStMOXJDNGpybkhOZ1VmaUdGUGNCVTdlMENrRlBLRUUxR2FC?=
 =?gb2312?B?dFRDSlR0RzZjdFJucWFya2ptYVBrUzBLc1RFWEl3UXBjanBFb3podHZaNjVv?=
 =?gb2312?B?RkdlaUlSb25ubTBWdU5TMGFETzR2ZWNRcnhmdmxMVEE5RFA1YTZqbjRrQ25x?=
 =?gb2312?B?Z2hSNTJ2UWMrQ3N5RVFlRFpsb2owUHVxYll0dURzZzNKV2dzYnRoTE1qV0lx?=
 =?gb2312?B?UUk4bUh2UVR4TEtWL1BZazlYL2czWWw1VFpJSGZRc1ZpU2ptajBXcm1PTnlz?=
 =?gb2312?B?ZEFiNDkvZjd5OVNNb25hMUVEU2hIcWRiRXg1R25oQi9vL1VQeHk3SmtCQVd2?=
 =?gb2312?B?V3RMN1hrZ0NJZDM3ZlFBK3FINUtqbmkvc1dsSDRJR1JZTGxGUjFtYjJuRDdq?=
 =?gb2312?B?TGViUkpMdHdiWUErYUIyYk1mNUdtcko1OFUxY3dVOHduNnlXYWo0WVZxNDdh?=
 =?gb2312?B?aDR4NU4weGNmSEtJR0xCY3hTUUU5U1FybXk0Y0puMHA4ZmMyR1VEOHkzeDhR?=
 =?gb2312?B?RGl6RXNmN2pmdHRmTlNraFcrWE9Ld0tsQ3dTakV5akRpNE56RXJrd1FDWkFU?=
 =?gb2312?B?SVRjcHlLZ244Nm1mKzFvOFY2dk9DMmhlOEd0WVFJM1dJQ2lrb0o4a2N1V2dK?=
 =?gb2312?B?NDZ2TjNxMndxK284bVZ5ZW1BbC9PVTZRVzBTa2NZREVNbHR3Q052NjMrWG1C?=
 =?gb2312?B?UlBJWlFLcTcvT0FJbHVvOVduYWZaajdyZ2lkcG5EVUdXVHlKRUNPdkg3NEhj?=
 =?gb2312?B?UHRuUTBjRVJ2NFpkcUFSSmJWK3JZZE95Syt1UFdIbHJicGY2SFQ1TitVbXhH?=
 =?gb2312?B?SzFnWWVKbTVtWjdXem41Z1lBYlh0UXlvUFNwV2l6NkJnMkxlNGJuNGs5bXI2?=
 =?gb2312?B?Y2licDB3dFd6c1hHa1c0cFl4WGtsV0JPbU1NbUY2bDhGMzlEcXNpcXNHOTlj?=
 =?gb2312?B?MnFhYkE4bkl6eFJuakJKdVJ3bUlHVEFtT3NDb2h6dHhHdCtLdXlGQ2ZiZzhO?=
 =?gb2312?B?QUNvbTVibEdqS28xTHRSNjVicWJZd0FLeXgxd0JadTdIaHdEbVV4Qnl2YU04?=
 =?gb2312?B?MjhpdlJsZmhHUHpBWndsRHY2QytmTUZHRmhpcTh1enQwTVh0WjJ0d212WFhs?=
 =?gb2312?B?SUZGR1MyNnVack5DQlhuV0RZRU52R21pTitnSXIwd1dlWUU5aFZQZzFDeDQw?=
 =?gb2312?Q?IeZrX7PngLHhQnaWMji9XVQWh?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e15352f2-67b3-486f-5c16-08db7631b1b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 10:40:01.0071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZgpypUOGzXVJihksNLP3l3pSMBAVaUKPLWcErNliMryHZzEQyf9Ao8TADPJQLC2j5IRaguRbwGiLZqFmURECw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1730
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHNvZnRpcnEgbGluZWV2ZW50X2lycV90aHJlYWQoKSBjb3VsZCBkZWFkbG9jayBvbiAmbGUt
PndhaXQubG9jawppZiBpdCBwcmVlbXB0cyBsaW5lZXZlbnRfcmVhZF91bmxvY2tlZCgpIHdoaWNo
IGFjcXVpcmVzIHRoZSBzYW1lCmxvY2sgYnV0IG5vdCBkaXNhYmxlIGlycS4KCkZpeCB0aGUgcG90
ZW50aWFsIGRlYWRsb2NrIGJ5IHNwaW5fbG9ja19pcnEoKS4KCkZpeGVzOiBkZWE5YzgwZWU2NzIg
KCJncGlvbGliOiByZXdvcmsgdGhlIGxvY2tpbmcgbWVjaGFuaXNtIGZvciBsaW5lZXZlbnQga2Zp
Zm8iKQpTaWduZWQtb2ZmLWJ5OiBDaGVuZ2ZlbmcgWWUgPGN5ZWFhQGNvbm5lY3QudXN0LmhrPgot
LS0KIGRyaXZlcnMvZ3Bpby9ncGlvbGliLWNkZXYuYyB8IDEyICsrKysrKy0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwaW8vZ3Bpb2xpYi1jZGV2LmMgYi9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi1jZGV2LmMK
aW5kZXggZjc2OGQ0NmJkZWE3Li5hMmMxMDhmMTcyZjIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3Bp
by9ncGlvbGliLWNkZXYuYworKysgYi9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi1jZGV2LmMKQEAgLTE4
NTgsMjggKzE4NTgsMjggQEAgc3RhdGljIHNzaXplX3QgbGluZWV2ZW50X3JlYWRfdW5sb2NrZWQo
c3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICpidWYsCiAJCXJldHVybiAtRUlOVkFMOwog
CiAJZG8gewotCQlzcGluX2xvY2soJmxlLT53YWl0LmxvY2spOworCQlzcGluX2xvY2tfaXJxKCZs
ZS0+d2FpdC5sb2NrKTsKIAkJaWYgKGtmaWZvX2lzX2VtcHR5KCZsZS0+ZXZlbnRzKSkgewogCQkJ
aWYgKGJ5dGVzX3JlYWQpIHsKLQkJCQlzcGluX3VubG9jaygmbGUtPndhaXQubG9jayk7CisJCQkJ
c3Bpbl91bmxvY2tfaXJxKCZsZS0+d2FpdC5sb2NrKTsKIAkJCQlyZXR1cm4gYnl0ZXNfcmVhZDsK
IAkJCX0KIAogCQkJaWYgKGZpbGUtPmZfZmxhZ3MgJiBPX05PTkJMT0NLKSB7Ci0JCQkJc3Bpbl91
bmxvY2soJmxlLT53YWl0LmxvY2spOworCQkJCXNwaW5fdW5sb2NrX2lycSgmbGUtPndhaXQubG9j
ayk7CiAJCQkJcmV0dXJuIC1FQUdBSU47CiAJCQl9CiAKLQkJCXJldCA9IHdhaXRfZXZlbnRfaW50
ZXJydXB0aWJsZV9sb2NrZWQobGUtPndhaXQsCisJCQlyZXQgPSB3YWl0X2V2ZW50X2ludGVycnVw
dGlibGVfbG9ja2VkX2lycShsZS0+d2FpdCwKIAkJCQkJIWtmaWZvX2lzX2VtcHR5KCZsZS0+ZXZl
bnRzKSk7CiAJCQlpZiAocmV0KSB7Ci0JCQkJc3Bpbl91bmxvY2soJmxlLT53YWl0LmxvY2spOwor
CQkJCXNwaW5fdW5sb2NrX2lycSgmbGUtPndhaXQubG9jayk7CiAJCQkJcmV0dXJuIHJldDsKIAkJ
CX0KIAkJfQogCiAJCXJldCA9IGtmaWZvX291dCgmbGUtPmV2ZW50cywgJmdlLCAxKTsKLQkJc3Bp
bl91bmxvY2soJmxlLT53YWl0LmxvY2spOworCQlzcGluX3VubG9ja19pcnEoJmxlLT53YWl0Lmxv
Y2spOwogCQlpZiAocmV0ICE9IDEpIHsKIAkJCS8qCiAJCQkgKiBUaGlzIHNob3VsZCBuZXZlciBo
YXBwZW4gLSB3ZSB3ZXJlIGhvbGRpbmcgdGhlIGxvY2sKLS0gCjIuMTcuMQ==
