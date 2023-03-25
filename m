Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9BD6C8BB8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjCYG2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCYG2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:28:34 -0400
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Mar 2023 23:28:32 PDT
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D235D13D44
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:28:32 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.97,212,1669046400"; 
   d="scan'208,223";a="72235275"
Received: from hk-mbx02.mioffice.cn (HELO xiaomi.com) ([10.56.8.122])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 25 Mar 2023 14:25:20 +0800
Received: from BJ-MBX16.mioffice.cn (10.237.8.136) by HK-MBX02.mioffice.cn
 (10.56.8.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 25 Mar
 2023 14:25:20 +0800
Received: from BJ-MBX14.mioffice.cn (10.237.8.134) by BJ-MBX16.mioffice.cn
 (10.237.8.136) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 25 Mar
 2023 14:25:19 +0800
Received: from BJ-MBX14.mioffice.cn ([fe80::6818:35a6:e09:60fa]) by
 BJ-MBX14.mioffice.cn ([fe80::6818:35a6:e09:60fa%9]) with mapi id
 15.02.0986.041; Sat, 25 Mar 2023 14:25:19 +0800
From:   =?gb2312?B?1Ky9qMX0?= <yuanjianpeng@xiaomi.com>
To:     masahiroy <masahiroy@kernel.org>, nathan <nathan@kernel.org>,
        ndesaulniers <ndesaulniers@google.com>,
        nicolas <nicolas@fjasle.eu>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] kbuild: support external module out-of-tree build
Thread-Topic: [PATCH] kbuild: support external module out-of-tree build
Thread-Index: AQHZXuHovkJw/vrxJEqawHIlFohm/A==
Date:   Sat, 25 Mar 2023 06:25:19 +0000
Message-ID: <e58cba84c90c40108ac678500f33655e@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbSAyMDVhZjQ1NTgyYWQwY2IxMjkzODM5YTk1ZWUwMWQzODNmMWNmYmYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogWXVhbiBKaWFucGVuZyA8eXVhbmppYW5wZW5nQHhpYW9taS5j
b20+DQpEYXRlOiBTYXQsIDI1IE1hciAyMDIzIDEwOjI0OjM4ICswODAwDQpTdWJqZWN0OiBbUEFU
Q0hdIGtidWlsZDogc3VwcG9ydCBleHRlcm5hbCBtb2R1bGUgb3V0LW9mLXRyZWUgYnVpbGQNCg0K
QSBuZXcgbW9kdWxlIGJ1aWxkIHZhcmlhYmxlIEtCVUlMRF9FWFRNT0RfU1JDIGlzIGFkZGVkIHdo
aWNoDQpzcGVjaWZ5aW5nIHRoZSBleHRlcm5hbCBtb2R1bGUgc291cmNlIHBhdGguDQoNCkJ1aWxk
IGxpa2UgdGhpczoNCm1ha2UgLUMgJEtESVIgTT08b3V0cHV0IGRpcj4gS0JVSUxEX0VYVE1PRF9T
UkM9PG1vZHVsZSBzb3VyY2UgZGlyPg0KDQpTaWduZWQtb2ZmLWJ5OiBZdWFuIEppYW5wZW5nIDx5
dWFuamlhbnBlbmdAeGlhb21pLmNvbT4NCi0tLQ0KIHNjcmlwdHMvTWFrZWZpbGUuYnVpbGQgICB8
IDIgKy0NCiBzY3JpcHRzL01ha2VmaWxlLmNsZWFuICAgfCAyICstDQogc2NyaXB0cy9NYWtlZmls
ZS5tb2Rwb3N0IHwgMiArLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvc2NyaXB0cy9NYWtlZmlsZS5idWlsZCBiL3Njcmlw
dHMvTWFrZWZpbGUuYnVpbGQNCmluZGV4IDc2MzIzMjAxMjMyYS4uOTcxYTIxNjFkNTAyIDEwMDY0
NA0KLS0tIGEvc2NyaXB0cy9NYWtlZmlsZS5idWlsZA0KKysrIGIvc2NyaXB0cy9NYWtlZmlsZS5i
dWlsZA0KQEAgLTMsNyArMyw3IEBADQogIyBCdWlsZGluZw0KICMgPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cg0KLXNyYyA6PSAkKG9iaikNCitzcmMgOj0gJChpZiAkKEtCVUlMRF9FWFRNT0RfU1JDKSwkKEtC
VUlMRF9FWFRNT0RfU1JDKSQocGF0c3Vic3QgJChLQlVJTERfRVhUTU9EKSUsJSwkKG9iaikpLCQo
b2JqKSkNCg0KIFBIT05ZIDo9ICQob2JqKS8NCiAkKG9iaikvOg0KZGlmZiAtLWdpdCBhL3Njcmlw
dHMvTWFrZWZpbGUuY2xlYW4gYi9zY3JpcHRzL01ha2VmaWxlLmNsZWFuDQppbmRleCAzNjQ5OTAw
Njk2ZGQuLjUyMzJhMGI2ZTEzOSAxMDA2NDQNCi0tLSBhL3NjcmlwdHMvTWFrZWZpbGUuY2xlYW4N
CisrKyBiL3NjcmlwdHMvTWFrZWZpbGUuY2xlYW4NCkBAIC0zLDcgKzMsNyBAQA0KICMgQ2xlYW5p
bmcgdXANCiAjID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoNCi1zcmMgOj0gJChvYmopDQorc3JjIDo9ICQo
aWYgJChLQlVJTERfRVhUTU9EX1NSQyksJChLQlVJTERfRVhUTU9EX1NSQykkKHBhdHN1YnN0ICQo
S0JVSUxEX0VYVE1PRCklLCUsJChvYmopKSwkKG9iaikpDQoNCiBQSE9OWSA6PSBfX2NsZWFuDQog
X19jbGVhbjoNCmRpZmYgLS1naXQgYS9zY3JpcHRzL01ha2VmaWxlLm1vZHBvc3QgYi9zY3JpcHRz
L01ha2VmaWxlLm1vZHBvc3QNCmluZGV4IDA5ODBjNThkOGFmYy4uM2YwYjIzMTU3YzY4IDEwMDY0
NA0KLS0tIGEvc2NyaXB0cy9NYWtlZmlsZS5tb2Rwb3N0DQorKysgYi9zY3JpcHRzL01ha2VmaWxl
Lm1vZHBvc3QNCkBAIC0xMDMsNyArMTAzLDcgQEAgZWxzZQ0KDQogIyBzZXQgc3JjICsgb2JqIC0g
dGhleSBtYXkgYmUgdXNlZCBpbiB0aGUgbW9kdWxlcydzIE1ha2VmaWxlDQogb2JqIDo9ICQoS0JV
SUxEX0VYVE1PRCkNCi1zcmMgOj0gJChvYmopDQorc3JjIDo9ICQoaWYgJChLQlVJTERfRVhUTU9E
X1NSQyksJChLQlVJTERfRVhUTU9EX1NSQykkKHBhdHN1YnN0ICQoS0JVSUxEX0VYVE1PRCklLCUs
JChvYmopKSwkKG9iaikpDQoNCiAjIEluY2x1ZGUgdGhlIG1vZHVsZSdzIE1ha2VmaWxlIHRvIGZp
bmQgS0JVSUxEX0VYVFJBX1NZTUJPTFMNCiBpbmNsdWRlICQoa2J1aWxkLWZpbGUpDQotLQ0KMi4z
OC4xDQoNCiMvKioqKioqsb7Tyrz+vLDG5Li9vP66rNPQ0KHD17mry761xLGjw9zQxc+io6y99s/e
09q3osvNuPjJz8PmtdjWt9bQwdCz9rXEuPbIy7vyyLrX6aGjvfvWucjOus7G5Mv7yMvS1MjOus7Q
zsq9yrnTw6OosPzAqLWrsrvP3tPayKuyv7vysr+31rXY0LnCtqGiuLTWxqGiu/LJoreio6mxvtPK
vP7W0LXE0MXPoqGjyOe5+8T6tO3K1cHLsb7Tyrz+o6zH68T6waK8tLXnu7C78tPKvP7NqNaqt6K8
/sjLsqLJvrP9sb7Tyrz+o6EgVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWlu
IGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIFhJQU9NSSwgd2hpY2ggaXMgaW50ZW5kZWQg
b25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJv
dmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdh
eSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xv
c3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRo
YW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2
ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25l
IG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQhKioqKioqLyMNCg==
