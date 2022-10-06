Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34525F6F9E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiJFUq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiJFUql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:46:41 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90053.outbound.protection.outlook.com [40.107.9.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12D5C1D87
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 13:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dviEKhLM7B6NmjBO141dbrzpNT3tlAUPP9pumna1KHPDPM8ZFtHru8EBm3VW7TrIf/PJuM+iP6jNv60Q4OtjNc+6hfYPxJ7EHQyegmj3tV7AMfYlL9LOxkuYPZDqGte6ayq0/fHB6oIUeEIz/T6gxRW03Iv8tN9yJ6s0d7Nhayxu9EyNvLrJMFvpLrbRoRnHrg2n+30a+waFdb1VA1qb9Ha28IkomBLN58JVI3xgtSpAJBzxbRCX9XOifCl3SsxiFBfIUDZomBfx6oANglhPoqimY0yX4Jmy90/lQFqpgjJUZcu6O9OkMKmsx3dwi/Uu6/USmVsA/3WKGPGDU4X7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSoNKPRsJPwU2FxfFHPozwo9cNR/ObQWtecSE+8YTRM=;
 b=H63OmiNqPSeN7WyRWwkSdrXRYaD/LZUEwjr+v+TZwVxT5yWTvKNIv1WiKmneJuPbg3RMoPwn6CGAg4xU5ni7wy5gAB7R7XQzMk9cy8U0Cmkyoq2iqprlF6/+GDYQIK/q+1eoMRI+xlA1OsEBwhAh/NryF/RxUVYPyEDZ/+UgHhggrG3bjoNAw2jRnyX5SbGWYzxWAZolH+gaWtx2HXUW1AHK78RW7D6UxsfvpxXZfeORXQ6nYjX1ETOIcu7LzEo3d1wf+yqeLCBUyTExoZuocAPFCGL+in//rLZyXapqoKABCPsFAl/Rprae7YIdfrxvR7GhkhX5v57DI7AswXWZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSoNKPRsJPwU2FxfFHPozwo9cNR/ObQWtecSE+8YTRM=;
 b=fE11pPoEYg7bDj5JO24ycKM63sIfmM2gPhuq2NwGdcQH28Nd89pxczvN3aTuqqVpzXiLzFiuGzxeDx2oJNAY8RyuEtxb79TpPGuDroIj7GRD+rLdsADlXBJLG/j9CflYA3w/Do1qFyQw2QWH+8sHz2PLijwakVAw0Ai7aJfCdwab2XRk12ACPATx15eTFgMyCKqgmGQNj58jB4p91ohpDsVm5a4fHhBUBehMyOwWFMk0lr3jc8qcUOJSrG1FSkGm+OblVouf+8yvv2lPh6RSGxzi0VLlMJ0hmZCQP+cmL04oPU/34nj7m4zb+GtvVxug4BMRxIcyDFQJH4rlMnESyA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2174.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 20:46:36 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af%5]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 20:46:36 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 06/19] powerpc/cputable: Split cpu_specs[] out of
 cputable.h
Thread-Topic: [PATCH v2 06/19] powerpc/cputable: Split cpu_specs[] out of
 cputable.h
Thread-Index: AQHYzEmUD3cr8g6eC0mQ2D3+G2LPY63oBUOAgBnrnIA=
Date:   Thu, 6 Oct 2022 20:46:36 +0000
Message-ID: <f75c2d9d-423f-f8c4-5bcd-cdea6c33e206@csgroup.eu>
References: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu>
 <a44b865e0318286155273b10cdf524ab697928c1.1663606875.git.christophe.leroy@csgroup.eu>
 <CN13QQX0NEA2.M6SABG46NYYN@bobo>
In-Reply-To: <CN13QQX0NEA2.M6SABG46NYYN@bobo>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB2174:EE_
x-ms-office365-filtering-correlation-id: cbd2a1d1-ae63-45bb-4630-08daa7dbdc4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ah5VAy41ORwlC+fBRwHmtIGLUF1TtJIwqDOGnypJsnO2yuwAct7sD/ZRNv4l5Kp+jyF/ZtdO6Qu3pqrZwhB3NycauT5tq84Cxt5EyAU7vvgN3cVlZzesbaQ8RZsCvWPxtMT+9c6BlUb/3OVrxqf3B8GqL3wTjNdgI2xVZpcgbmhXwTR4c9UGkk54FWbi8ntkS7wsiXUlNIQptVQb2//Mr5laWbW3ZiHYCOh9xWmFCV+oOjQFxRsjeOR+eNDIwS22iTWZVl980hetzJcGwss7sQF/HZhkAF4QrCgJxEr54iKPtFcHukMRv/wsDkyzgGhvO+IQzVwalRxtpamx69Tp1818GkKwJCATciaovDF7B+WHUM96vslcQT/FSyPlAdvxqtB8n2geKkDW4X8JHRi2i7hMcOFRHv7cq0sSDgNeSiNtSTLoni5OJZmRiqY5+IIIC3HZSf4c50CmfJk6qnyyK1QOG9AASzhIfkgMqIwd6E29QRxl35xiyNDp1V9i6peD4x5AhcK/bDVaxX/BI3CEc6dCkT/TdY9QWCjLJhw6ZO1Znidhh4nLuGMn711XvfRQZawZxQ1DM24O+5331KsAUqN4ckzirAJrjjbb79LQI2zVuYrmCGeaDcjYvWP6SSTTMEzCgHbwU8/+4txZX6KWs5ein5HJd84yGg7+p2IhhHJa6erc1qmQixldVf98QMhBuch4gPqErnKhuWOpf+cSH22zjCf7hCIcwHFzKUg52EIEYmgLcaAl1NQfG8RY+bz8aHONY6jBDdZjYlXVB66UkwOii2PeNQPC63WsiFZ62yHvSxCByDG4q9rmptDr9Y/D6uLZlxnWMe/vUlOe86QZfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199015)(110136005)(86362001)(54906003)(8936002)(38100700002)(91956017)(76116006)(38070700005)(122000001)(2616005)(36756003)(4326008)(478600001)(64756008)(66476007)(66446008)(66556008)(6506007)(41300700001)(6512007)(6486002)(31696002)(66946007)(26005)(5660300002)(31686004)(44832011)(4744005)(71200400001)(8676002)(2906002)(186003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXRVT1pMZDFIOTRNN1l1aEkrY0w2RE90NlpGN1k2TWtZMkRGV2QzODVSYnY2?=
 =?utf-8?B?R0pxa2FQVnQ4QVZ6Z1l2bUxXMlhmNzB4RUg1a3kxNFpYbFJ4eTNpL2FEMU81?=
 =?utf-8?B?bnR6TWhpU1VxYWtHdUttUE5EVUJkTFBlU0RWRGo4dzg3YjlFT1l1YkMvVlJJ?=
 =?utf-8?B?UmF0RS9HOG91UFJCNzdNT3RMQXdHWVJ3QWtVdFdjWE03UVRVVlpBbml6SFp5?=
 =?utf-8?B?ckx6d0dlbW94K29OaFQ5KzI0N3h4ZnBFK3ljRDRIOXY5M0p3aU9aSDRNRXpq?=
 =?utf-8?B?R1VBalZnQTJLclBMZlpVQ1RKWlVoeFNzbUJvaGg2ZjNwbmpuQUczYnJEaVJO?=
 =?utf-8?B?S2dRYllQbDcyaFZoSGh6ZFd5ZjVUQTMwRWxDNWpQS0ZELzY0NEM1VjAwcExo?=
 =?utf-8?B?U1oyRzFmcUhxSi9qSVRFTnppa2gvMjFmVmN5ajNHR3J4RGN6WWcyenpaa0g1?=
 =?utf-8?B?ejdFbzBycmFVYktLY3JBWkdsMlRubERKMHIrTkx0NDk5bHFMQ2huMU5ZeDlN?=
 =?utf-8?B?VkpyK1NMaXdpS08xUk5ibW04Z0RDNjdIQ3VyeXo1enY1aHR3R1VzMzducS9x?=
 =?utf-8?B?ZzQ3NjBFRUZNVkUzWSsxWkhhK0dlSWVyRmp1aVpzT0VFQjc3RURqTGxXWFY4?=
 =?utf-8?B?RDRDRE04Z0EzbGJPUm9idTFWdmhMZUwybXlJNmYycVlTczJGN3BPaWY3bG9S?=
 =?utf-8?B?elF1cUd6NmxYbFJybllaUEFNUUQ5UWtleENydlNLSWhiNXp0b0hRdFhERE1o?=
 =?utf-8?B?amgvKzVFNXNRMlRKT09xaitnSzdrWk1FZWNrS1YrcTg3ekthaXoxVUFpZWlm?=
 =?utf-8?B?K0x4b3dNVjlUVmI1dnBSdjdHZGRQUVJDM2J1NHU1WGQ4R0lja1JmOGp2VSto?=
 =?utf-8?B?c3U1VEZNNmNLZk4xMmt5Mm1ObjV5NklISWFCQ3ZPWThiQ1FRQ3hqTkYzaWFR?=
 =?utf-8?B?M3RBZ213YWZ0U2dLNlVGQTdXei9wN3JROWt6M2dINU4yZHdGVkZwUkxnUCtD?=
 =?utf-8?B?YWFXQklRVGcweWY3SXhjOG9URS9OV1VPZkliUzQ0a29QcFFNOHZEMDRGQ0J6?=
 =?utf-8?B?TkYrTGorc01pcGllT0x4SUhkUW1FUC8xL3MrRmdKYTduQUkxWGFWaGxncm1w?=
 =?utf-8?B?WHNDUUNIQ1FZcWJ0blN2a3hyY1hXbklUWkswQTRXc055eU9qZVEzZTB5Nmll?=
 =?utf-8?B?SytvUFB4ZEtkTFArbFBpR1V1NGZPWkNGWE0vK0wwM1I4WWZxck1DT0JBMVky?=
 =?utf-8?B?RUxPSzZGTGhBajRUMTlSZmlZMFl5TUsrZ0N5Rm9SbGo5anZZUUZSbU1CbzEr?=
 =?utf-8?B?b0lFdjlNN0lXZVZiL3I4a1Z4dWd2bXIxaXJnVUtpTjJYZi9RMzBzNjBjZjE3?=
 =?utf-8?B?RG5MVzNvT0FYWE9WRXIvbW1HVXNWc1RrUlhNcFBMVzNIMjBqS2oveVgrZ3FE?=
 =?utf-8?B?R0swbTZJWmY5ZHl4dzBCWFFRdjJ4OFVMK0xkM0RMUGdXYXUyOGdKb1dDVXRZ?=
 =?utf-8?B?aGgvTzdqOFJRY3B0cEFTYzBkbGRRdHFpRWtGMUo5NzUyTDU5SU5EbnY0MzNM?=
 =?utf-8?B?clVvK3VMUkk3SzZnMzNUVVp0bnZvZGFWaXVpRTBVdXVnUkxpRWdLNjAyU0pp?=
 =?utf-8?B?QWh3UVc1Y3JWbnBJZlhQaTBJMVNjUllBREtQQ3hzMlRlMTlTWDB4ZWJNRDNE?=
 =?utf-8?B?b1ZNNloycTMvYXRwZGlqcmppdUpwMmpIcU1FK2t1NGdCRmpkRHZpUlNDbmI2?=
 =?utf-8?B?NXdTZkJBU0VNWHFVb3cvNEc0ZEhFUmthdnZKUVRweWRqWE53Y0ZUYXFpclFI?=
 =?utf-8?B?cTRwVVRERUpQbk1PMTQ2aU1ydmZacENMRTNQSERMY0ZqcE5GbzZTSlZ3amIv?=
 =?utf-8?B?bG0raHJjQk5LWm1vNnlkbllSN3BkMXN5YXl3UFZYRXlPc2FMcFB3S0s5Rjhh?=
 =?utf-8?B?Q2RmNG12YlZsbDhRQ1dqNFFLbWF0L29xeGdxU2NSYnhBTGpmWXd0YnpTblht?=
 =?utf-8?B?M1pUVjFub1dRMGhJcW14U3ljbkNTenMwNzNMaVNZNEVMVFZhVTFwYzdlN0VX?=
 =?utf-8?B?MnIra0Z3NitrQmthSjcyZE9ETThkT1BXUUk4b0JiWmhnWnAyc0hnczJlL0s2?=
 =?utf-8?B?S3g4SXFiOFNaMmZDMlBNZE1pRSticG9qemZLaTZONUpTMG5iOEpoU2E2MC85?=
 =?utf-8?Q?eDyPHajBaJIy4UogOjKrPMk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4598B7961D6DF498B0302FDA5A2A95C@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd2a1d1-ae63-45bb-4630-08daa7dbdc4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 20:46:36.1006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QJ1i0UBRKCh45q2LxS+8JtFFZPWX2+mdYfq5Fcn6txUakmEQZGGQFdy8BeIBy/lJez5tgfXkbid2HFc/p2Ufd7r/2Gj3dnLeI8tvhsI/PQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2174
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIwLzA5LzIwMjIgw6AgMTA6NTYsIE5pY2hvbGFzIFBpZ2dpbiBhIMOpY3JpdMKgOg0K
PiBPbiBUdWUgU2VwIDIwLCAyMDIyIGF0IDM6MDEgQU0gQUVTVCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToNCj4gDQo+IFRoaXMgc2VyaWVzIGlzIGEgbmljZSBjbGVhbnVwLiBObyBjb21tZW50cyB5
ZXQgYnV0IGtlcm5lbC8gaXMgZ2V0dGluZw0KPiBwcmV0dHkgY3Jvd2RlZC4gU2hvdWxkIHdlIG1h
a2Ugc29tZSBzdWJkaXJlY3RvcmllcyBmb3Igc3ViYXJjaCB0aGluZ3MNCj4gbGlrZSBtbSBoYXM/
DQo+IA0KPiBDYW4gZG8gdGhhdCBhZnRlciB5b3VyIHNlcmllcy4gUHJvYmFibHkgcmVxdWlyZXMg
YW5vdGhlciBtZXJnZSB3aW5kb3cNCj4gdG8gZG8gaXQuDQo+IA0KDQpCeSB0aGUgd2F5LCBJJ20g
d29uZGVyaW5nIGhvdyB3ZSBkZWNpZGUgd2hldGhlciBzb21lIGNvZGUgZ29lcyBpbiANCmFyY2gv
cG93ZXJwYy9rZXJuZWwvIG9yIGluIGFyY2gvcG93ZXJwYy9saWIvDQoNCkNocmlzdG9zcGhl
