Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E346D0A54
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjC3PtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjC3PtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:49:11 -0400
X-Greylist: delayed 3815 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Mar 2023 08:48:54 PDT
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95497659A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:48:54 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1a9b:0:640:bcd2:0])
        by forward203b.mail.yandex.net (Yandex) with ESMTP id AF26E60101;
        Thu, 30 Mar 2023 18:48:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id lmLwxq2WmOs0-EQIwYDFi;
        Thu, 30 Mar 2023 18:48:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1680191330;
        bh=npEdvAPW7rVQ0bRqAErQnWpWuM7jGwNk6R0jm81oUd4=;
        h=Subject:Cc:To:Message-ID:Date:From;
        b=n/WVi4w5n4BDLAg8ZoqR8eGtUZ/pUCgOg7GTEtaZToCdNo7Z8mFwvmO5f0lrj1Byu
         YvmMwBS/HZsVL/5MzKvLZGz2KsA0eUlW+0+9DgVyZ3vSGeJj96WSrhCy9swBJB4Qjo
         IQnM+DSxSoW5TNakOhpHfeZv64eH5Ly/JADIjjw8=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Content-Type: multipart/mixed; boundary="------------l85DkQMEZf392AV7IPgjfB9l"
Message-ID: <18c36a78-4082-fab6-c7c9-69a249516803@yandex.ru>
Date:   Thu, 30 Mar 2023 20:48:46 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org,
        =?UTF-8?Q?Jakub_Mat=c4=9bna?= <matenajakub@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
From:   stsp <stsp2@yandex.ru>
Subject: MREMAP_FIXED unmaps dest on error
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------l85DkQMEZf392AV7IPgjfB9l
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

The attached test-case demonstrates a
bug in mremap(). If MREMAP_FIXED is used
over an existing mapping and mremap() fails,
destination area gets unmapped.
AFAIK the failed syscall should have no
observable effects.

There is also another bug demonstrated by
the same test-case. Namely, it does 2 subsequent
mprotect()s on the same page, changing the
protection and restoring it back. But VMAs
are not merged, so the subsequent mremap()
fails (and exhibits a bug by unmapping dest).

--------------l85DkQMEZf392AV7IPgjfB9l
Content-Type: text/x-csrc; charset=UTF-8; name="mrtst2.c"
Content-Disposition: attachment; filename="mrtst2.c"
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPGFz
c2VydC5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVk
ZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNp
bmNsdWRlIDxzaWduYWwuaD4KCiNpZm5kZWYgUEFHRV9TSVpFCiNkZWZpbmUgUEFHRV9TSVpF
IDQwOTYKI2VuZGlmCgpzdGF0aWMgdm9pZCBteV9zZWd2KGludCBzaWcpCnsKICAgIHByaW50
ZiAoIlRlc3QgRkFJTEVEXG4iKTsKICAgIF9leGl0IChFWElUX0ZBSUxVUkUpOwp9CgppbnQg
bWFpbih2b2lkKQp7CiAgICBjb25zdCBjaGFyICpmaWxlID0gIm1ydHN0Mi5jIjsKICAgIGNo
YXIgKmFkZHIsICphZGRyMiwgKmFkZHIzOwogICAgaW50IGZkOwoKICAgIGZkID0gb3BlbiAo
ZmlsZSwgT19SRE9OTFkpOwogICAgaWYgKGZkID09IC0xKQogICAgICAgIHJldHVybiBFWElU
X0ZBSUxVUkU7CiAgICBhZGRyID0gbW1hcCAoTlVMTCwgUEFHRV9TSVpFICogMiwgUFJPVF9S
RUFELCBNQVBfUFJJVkFURSwgZmQsIDApOwogICAgY2xvc2UoZmQpOwogICAgaWYgKGFkZHIg
PT0gTUFQX0ZBSUxFRCkgewogICAgICAgIHBlcnJvcigibW1hcCgpIik7CiAgICAgICAgcmV0
dXJuIEVYSVRfRkFJTFVSRTsKICAgIH0KICAgIGFkZHIyID0gbW1hcCAoTlVMTCwgUEFHRV9T
SVpFICogMiwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwKICAgICAgICAgICAgICAgICAgTUFQ
X0FOT05ZTU9VUyB8IE1BUF9QUklWQVRFLCAtMSwgMCk7CiAgICBpZiAoYWRkcjIgPT0gTUFQ
X0ZBSUxFRCkgewogICAgICAgIHBlcnJvcigibW1hcCgpIik7CiAgICAgICAgcmV0dXJuIEVY
SVRfRkFJTFVSRTsKICAgIH0KICAgIC8qIHNwbGl0IFZNQSB0byBmYWlsIG1yZW1hcCgpICov
CiAgICBtcHJvdGVjdCAoYWRkciwgUEFHRV9TSVpFLCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRF
KTsKICAgIC8qIFZNQXMgd29uJ3QgYmUgbWVyZ2VkLCBidWcgKi8KICAgIG1wcm90ZWN0IChh
ZGRyLCBQQUdFX1NJWkUsIFBST1RfUkVBRCk7CiAgICAvKiBtYWtlIHN1cmUgZGVzdCBpcyBo
ZXJlIGFuZCB3cml0YWJsZSAqLwogICAgYWRkcjJbMF0gPSAzOwogICAgLyogZXhwb3NlIHRo
ZSBidWcgKi8KICAgIGFkZHIzID0gbXJlbWFwIChhZGRyLCBQQUdFX1NJWkUgKiAyLCBQQUdF
X1NJWkUgKiAyLAogICAgICAgICAgICAgICAgICAgIE1SRU1BUF9NQVlNT1ZFIHwgTVJFTUFQ
X0ZJWEVEIHwgTVJFTUFQX0RPTlRVTk1BUCwKICAgICAgICAgICAgICAgICAgICBhZGRyMik7
CiAgICBpZiAoYWRkcjMgPT0gYWRkcjIpIHsKICAgICAgICBwcmludGYgKCJFdmVuIFZNQXMg
bWVyZ2VkPyBFeGNlbGxlbnQhXG4iKTsKICAgICAgICByZXR1cm4gMDsKICAgIH0KICAgIGFz
c2VydCAoYWRkcjMgPT0gTUFQX0ZBSUxFRCk7CiAgICBzaWduYWwgKFNJR1NFR1YsIG15X3Nl
Z3YpOwogICAgLyogc2VlIGlmIGRlc3QgYWRkcmVzcyB1bm1hcHBlZCAqLwogICAgYWRkcjJb
MF0gPSA1OwogICAgYXNzZXJ0IChhZGRyMlswXSA9PSA1KTsKICAgIHByaW50ZiAoIlRlc3Qg
UEFTU0VEXG4iKTsKICAgIHJldHVybiAwOwp9Cg==

--------------l85DkQMEZf392AV7IPgjfB9l--
