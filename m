Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7D1654CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiLWHSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWHSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:18:13 -0500
Received: from mail5.msi.com (mail5.msi.com [114.30.40.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667EC3055B;
        Thu, 22 Dec 2022 23:18:10 -0800 (PST)
Received: from mail9.msi.com (mail9.msi.com [220.130.147.43])
        by mail5.msi.com (Postfix) with ESMTPS id E7850540786;
        Fri, 23 Dec 2022 15:18:07 +0800 (CST)
Received: from mail9.msi.com (localhost [127.0.0.1])
        by postfix.imss91 (Postfix) with ESMTP id 5591DF80808;
        Fri, 23 Dec 2022 15:18:08 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 postfix.imss91 5591DF80808
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msi.com; s=20220711;
        t=1671779888; bh=oF8F3VqZ2eU9WjS/HIJOG4/gAjngipuR14YmTGJkYtY=;
        h=From:To:CC:Subject:Date:From;
        b=Xf/gYlP3xkUz/DyVz575w3s4piGKFQ3jX0Ad8yOW6rjrhXlQiANEKMOA5Zz/BUFnH
         xnbupcwD9DxL8Atq7yFY/FTDopXMOs3s+H35oYU06nByINFvbstRGU4wUu0V61GTkK
         oWwGdCf//G4KfkB8zq4G6CKb6wVEM6M5YRadysd1j8PaXeBYI3I1lznhc8YHodOKie
         pJc7yrhWKqVzz4LtzrFmdyj4lZ6/BtkTSALV5i0FX2VBmf93aUDx7C26lwTVjvleXh
         J79Qim9119r3jWmFAgMEO8X6lrmGgiFqi3XJicJxDGIfHgovHFEukvzCpxRWCnvXXE
         NiF4R7UkPj1BA==
Received: from EX2016A.msi.com.tw (unknown [172.16.0.54])
        by mail9.msi.com (Postfix) with ESMTPS id 4709DF807BF;
        Fri, 23 Dec 2022 15:18:08 +0800 (CST)
Received: from EX2016A.msi.com.tw (172.16.0.54) by EX2016A.msi.com.tw
 (172.16.0.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.16; Fri, 23 Dec
 2022 15:18:06 +0800
Received: from EX2016A.msi.com.tw ([fe80::111c:1b9e:5379:1011]) by
 EX2016A.msi.com.tw ([fe80::111c:1b9e:5379:1011%10]) with mapi id
 15.01.2507.016; Fri, 23 Dec 2022 15:18:06 +0800
From:   =?big5?B?am9ld3Uop2Sl8q62KQ==?= <joewu@msi.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "Benson Leung" <bleung@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Derek Huang <derekhuang@google.com>,
        "Dustin L . Howett" <dustin@howett.net>,
        "Furquan Shaikh" <furquan@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Tzung-Bi Shih" <tzungbi@kernel.org>,
        =?big5?B?am9ld3Uop2Sl8q62KQ==?= <joewu@msi.com>
Subject: [PATCH v2] cros_ec_keyb: Add 3 buttons for monitor function
Thread-Topic: [PATCH v2] cros_ec_keyb: Add 3 buttons for monitor function
Thread-Index: AdkWnlAIMkExDDtJRR2LmXs3Hf5qFA==
Date:   Fri, 23 Dec 2022 07:18:06 +0000
Message-ID: <e23628e2cb464d238eb1c33a9e1e516b@msi.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.252.125]
Content-Type: text/plain;
        charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-RCPT: <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>, <wangxiang@cdjrlc.com>, <swboyd@chromium.org>, <pmalani@chromium.org>, <linux-input@vger.kernel.org>, <dmitry.torokhov@gmail.com>, <chrome-platform@lists.linux.dev>, <bleung@chromium.org>, <gustavoars@kernel.org>, <groeck@chromium.org>, <dianders@chromium.org>, <dnojiri@chromium.org>, <derekhuang@google.com>, <dustin@howett.net>, <furquan@chromium.org>, <Jonathan.Cameron@huawei.com>, <lee.jones@linaro.org>, <tzungbi@kernel.org>
X-TM-AS-GCONF: 00
X-RCPT: <wangxiang@cdjrlc.com>, <bleung@chromium.org>, <dianders@chromium.org>, <dnojiri@chromium.org>, <furquan@chromium.org>, <groeck@chromium.org>, <pmalani@chromium.org>, <swboyd@chromium.org>, <dmitry.torokhov@gmail.com>, <derekhuang@google.com>, <dustin@howett.net>, <Jonathan.Cameron@huawei.com>, <gustavoars@kernel.org>, <tzungbi@kernel.org>, <lee.jones@linaro.org>, <gregkh@linuxfoundation.org>, <chrome-platform@lists.linux.dev>, <internal@maedb.msi.com>, <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIDMgZXh0cmEgYnV0dG9uczogJ2JyaWdodG5lc3MgdXAnLCAnYnJpZ2h0bmVzcyBkb3duJw0K
YW5kICdzY3JlZW4gbG9jaycgdG8gc3VwcG9ydCBtb25pdG9yIG1hbmlwdWxhdGluZyBmdW5jdGlv
bi4NCg0KU2lnbmVkLW9mZi1ieTogSm9lIFd1IDxqb2V3dUBtc2kuY29tPg0KLS0tDQp2MjoNCi0g
dXNlIHRhYnMNCi0gdXNlIHJlYWwgZW1haWwgdG8gc2VuZCBwYXRjaA0KLS0tDQogZHJpdmVycy9p
bnB1dC9rZXlib2FyZC9jcm9zX2VjX2tleWIuYyAgICAgICAgICB8IDE1ICsrKysrKysrKysrKysr
Kw0KIGluY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9jcm9zX2VjX2NvbW1hbmRzLmggfCAgMyAr
KysNCiAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW5wdXQva2V5Ym9hcmQvY3Jvc19lY19rZXliLmMgYi9kcml2ZXJzL2lucHV0L2tleWJv
YXJkL2Nyb3NfZWNfa2V5Yi5jDQppbmRleCA2ZjQzNTEyNWVjMDMuLmU3ZWNmY2E4MzhkZiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvY3Jvc19lY19rZXliLmMNCisrKyBiL2Ry
aXZlcnMvaW5wdXQva2V5Ym9hcmQvY3Jvc19lY19rZXliLmMNCkBAIC0xMDAsNiArMTAwLDIxIEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgY3Jvc19lY19ic19tYXAgY3Jvc19lY19rZXliX2JzW10gPSB7
DQogCQkuY29kZQkJPSBLRVlfVk9MVU1FRE9XTiwNCiAJCS5iaXQJCT0gRUNfTUtCUF9WT0xfRE9X
TiwNCiAJfSwNCisJew0KKwkJLmV2X3R5cGUgICAgICAgID0gRVZfS0VZLA0KKwkJLmNvZGUgICAg
ICAgICAgID0gS0VZX0JSSUdIVE5FU1NVUCwNCisJCS5iaXQgICAgICAgICAgICA9IEVDX01LQlBf
QlJJX1VQLA0KKwl9LA0KKwl7DQorCQkuZXZfdHlwZSAgICAgICAgPSBFVl9LRVksDQorCQkuY29k
ZSAgICAgICAgICAgPSBLRVlfQlJJR0hUTkVTU0RPV04sDQorCQkuYml0ICAgICAgICAgICAgPSBF
Q19NS0JQX0JSSV9ET1dOLA0KKwl9LA0KKwl7DQorCQkuZXZfdHlwZSAgICAgICAgPSBFVl9LRVks
DQorCQkuY29kZSAgICAgICAgICAgPSBLRVlfU0NSRUVOTE9DSywNCisJCS5iaXQgICAgICAgICAg
ICA9IEVDX01LQlBfU0NSRUVOX0xPQ0ssDQorCX0sDQogDQogCS8qIFN3aXRjaGVzICovDQogCXsN
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvY3Jvc19lY19jb21tYW5k
cy5oIGIvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2Nyb3NfZWNfY29tbWFuZHMuaA0KaW5k
ZXggNTc0NGEyZDc0NmFhLi5hMjA3M2VkNDM5NzIgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4
L3BsYXRmb3JtX2RhdGEvY3Jvc19lY19jb21tYW5kcy5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3Bs
YXRmb3JtX2RhdGEvY3Jvc19lY19jb21tYW5kcy5oDQpAQCAtMzQ3MSw2ICszNDcxLDkgQEAgc3Ry
dWN0IGVjX3Jlc3BvbnNlX2dldF9uZXh0X2V2ZW50X3YxIHsNCiAjZGVmaW5lIEVDX01LQlBfVk9M
X1VQCQkxDQogI2RlZmluZSBFQ19NS0JQX1ZPTF9ET1dOCTINCiAjZGVmaW5lIEVDX01LQlBfUkVD
T1ZFUlkJMw0KKyNkZWZpbmUgRUNfTUtCUF9CUklfVVAJCTQNCisjZGVmaW5lIEVDX01LQlBfQlJJ
X0RPV04JNQ0KKyNkZWZpbmUgRUNfTUtCUF9TQ1JFRU5fTE9DSwk2DQogDQogLyogU3dpdGNoZXMg
Ki8NCiAjZGVmaW5lIEVDX01LQlBfTElEX09QRU4JMA0KLS0gDQoyLjE3LjENCg0KDQoqKioqKkNP
TkZJREVOVElBTCBJTkZPUk1BVElPTioqKioqDQoNClRoaXMgZW1haWwgaXMgaW50ZW5kZWQgb25s
eSBmb3IgdGhlIHVzZSBvZiB0aGUgcGVyc29uIG9yIGVudGl0eSB0byB3aG9tIGl0IGlzDQphZGRy
ZXNzZWQgYW5kIGNvbnRhaW5zIGluZm9ybWF0aW9uIHRoYXQgbWF5IGJlIHN1YmplY3QgdG8gYW5k
L29yIG1heSBiZQ0KcmVzdHJpY3RlZCBmcm9tIGRpc2Nsb3N1cmUgYnkgY29udHJhY3Qgb3IgYXBw
bGljYWJsZSBsYXcuIElmIHlvdSBhcmUgbm90IHRoZSANCmludGVuZGVkIHJlY2lwaWVudCBvZiB0
aGlzIGVtYWlsLCBiZSBhZHZpc2VkIHRoYXQgYW55IGRpc2Nsb3N1cmUsIGNvcHksIA0KZGlzdHJp
YnV0aW9uIG9yIHVzZSBvZiB0aGUgY29udGVudHMgb2YgdGhpcyBtZXNzYWdlIGlzIHN0cmljdGx5
IHByb2hpYml0ZWQuIA0KSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvZiB0
aGlzIGVtYWlsLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgDQp0aGF0IHlvdSBoYXZlIHJlY2Vp
dmVkIHRoaXMgaW4gZXJyb3IgYnkgcmVwbHlpbmcgdG8gdGhpcyBtZXNzYWdlLiBUaGVuLCANCnBs
ZWFzZSBkZWxldGUgaXQgZnJvbSB5b3VyIHN5c3RlbS4gT3VyIFByaXZhY3kgUG9saWN5IGlzIGF2
YWlsYWJsZSBoZXJlIA0KaHR0cHM6Ly93d3cubXNpLmNvbS9wYWdlL3ByaXZhY3ktcG9saWN5LiBU
aGFuayB5b3Uu

