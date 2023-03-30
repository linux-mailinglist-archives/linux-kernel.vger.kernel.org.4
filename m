Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B806D04F4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjC3Miy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjC3MiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:38:22 -0400
X-Greylist: delayed 68073 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Mar 2023 05:38:21 PDT
Received: from forward206c.mail.yandex.net (forward206c.mail.yandex.net [178.154.239.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9078672BA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:38:21 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:610a:0:640:be20:0])
        by forward206c.mail.yandex.net (Yandex) with ESMTP id 21AB3600FF;
        Thu, 30 Mar 2023 15:38:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GcI7wM1Dba60-KLRgsifT;
        Thu, 30 Mar 2023 15:38:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1680179897;
        bh=AUfUxWMmLzsWr9J8KyIIOEW5XdM2YJZTIzMN2LQK6rM=;
        h=Cc:Subject:To:Message-ID:Date:From;
        b=pti/RoUJV3jh0s2ptDQf5/Lh3HH0bI+tBPsgcTB/fxAS2LpLSyFQ4PHDc0Mab0R5d
         hWbTYXJAuKgr+9p8vtW5uU1tDV1F+lPaa5YB3n5aw2uhtLSw84QUF+lcwvvoINQuEu
         SNxLpbVwJQi5NdQcVZdSS5KmiHk1BcP5bzRhdZpw=
Authentication-Results: mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Content-Type: multipart/mixed; boundary="------------J3j8IHe1JzGMO5Jt5X1dfnsH"
Message-ID: <aee53ac3-6d25-5009-7416-3f7c5fe1f989@yandex.ru>
Date:   Thu, 30 Mar 2023 17:38:15 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   stsp <stsp2@yandex.ru>
Subject: MREMAP_DONTUNMAP corrupts initial mapping
Cc:     linux-mm@kvack.org
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------J3j8IHe1JzGMO5Jt5X1dfnsH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Attached is a small test-case that
demonstrates the problem.
The problem happens if you change
some data in a file-backed private
mapping and then use mremap on
it with MREMAP_DONTUNMAP flag.
The result is:
- destination copy is valid
- source copy restored from the original file

So the 2 copies do not match.

--------------J3j8IHe1JzGMO5Jt5X1dfnsH
Content-Type: text/x-csrc; charset=UTF-8; name="mretst.c"
Content-Disposition: attachment; filename="mretst.c"
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPGFz
c2VydC5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVk
ZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgoKI2lmbmRlZiBQQUdFX1NJWkUKI2Rl
ZmluZSBQQUdFX1NJWkUgNDA5NgojZW5kaWYKCmludCBtYWluKHZvaWQpCnsKICAgIGNvbnN0
IGNoYXIgKmZpbGUgPSAibXJldHN0LmMiOwogICAgY2hhciAqYWRkciwgKmFkZHIyOwogICAg
aW50IGZkOwogICAgY2hhciBjOwoKICAgIGZkID0gb3BlbiAoZmlsZSwgT19SRE9OTFkpOwog
ICAgaWYgKGZkID09IC0xKQogICAgICAgIHJldHVybiBFWElUX0ZBSUxVUkU7CiAgICBhZGRy
ID0gbW1hcCAoTlVMTCwgUEFHRV9TSVpFLCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLCBNQVBf
UFJJVkFURSwgZmQsIDApOwogICAgY2xvc2UoZmQpOwogICAgaWYgKGFkZHIgPT0gTUFQX0ZB
SUxFRCkKICAgICAgICByZXR1cm4gRVhJVF9GQUlMVVJFOwogICAgYyA9IGFkZHJbMF07CiAg
ICBhc3NlcnQoYWRkclswXSk7CiAgICBhZGRyWzBdID0gMDsKICAgIGFzc2VydCghYWRkclsw
XSk7CiAgICBhZGRyMiA9IG1yZW1hcCAoYWRkciwgUEFHRV9TSVpFLCBQQUdFX1NJWkUsCiAg
ICAgICAgICAgICAgICAgICAgTVJFTUFQX01BWU1PVkUgfCBNUkVNQVBfRE9OVFVOTUFQKTsK
ICAgIGFzc2VydCghYWRkcjJbMF0pOwogICAgaWYgKGFkZHJbMF0gPT0gYykKICAgICAgICBw
cmludGYoIlRlc3QgRkFJTEVEXG4iKTsKICAgIGVsc2UKICAgICAgICBwcmludGYoIlRlc3Qg
UEFTU0VEXG4iKTsKICAgIHJldHVybiAwOwp9Cg==

--------------J3j8IHe1JzGMO5Jt5X1dfnsH--
