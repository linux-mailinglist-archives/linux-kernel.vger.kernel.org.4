Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE28E73DD2D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjFZLT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjFZLTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:19:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D2FFD;
        Mon, 26 Jun 2023 04:19:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-313e1c27476so1529306f8f.1;
        Mon, 26 Jun 2023 04:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687778390; x=1690370390;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TIiFZpg7B3DpChMaXA9ungeQqsAbX36FJdgE1LxMDCo=;
        b=TyWyPj0Yh6h0y/Z7aNgxjPYn00/aWd8E+aLfbj718Xv8HDZn6hrqE1LhqIM536MAEn
         hg1tjD9UQfCKKMifnzT86Jjnm+P/XXm8BMFQYGJfliaK6Yli6BNfiLdrw/MWfENKKbn/
         pUTlnn6NL/iBTVfLhqmGnO9vzbazGbVlHFwZLbDWAGgOb9Z2axfYi3cOgqtOP4m7bChc
         kaIt293aTKCXwxV7cSSiMYSMRZYQW2EdloXCfVDjswODVno0m1mWtQvOUyMvyhK2yhh8
         u8vBzPKEO6kEhk1KVX2hxu37CziDY0S9oiC06GvRb+/E0FIX6KB/TkWqR/ZDEqoaedgf
         JQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687778390; x=1690370390;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIiFZpg7B3DpChMaXA9ungeQqsAbX36FJdgE1LxMDCo=;
        b=DsYD4D5oieKsmwe7ZpnuXs0ObtzXSz9H8eJMdpgJFUR9aAFP1VkGQ0TdD6Z9Aak+7F
         KYFc8ks7IIUwrQO06pUWqeAIDI3FjX8e1Ssqagksu6t4VQRpwZ3qo2/dh5NqwlYicjRv
         Fnkup0/xsAePFRyT2V1AVQ5Z/me5mSJPl2q+yORbEd+H9d43k1vcBIUno4+OyI3+Zx8h
         zz8hCC8oVVLXjshnpmR2q/yMQH6z4iVE/d62IX0NIfHazBye4vLj5Inq60+0MW9NfBUX
         hnTU5H97pHrWU4p6ZFUiv2MaRl6V30Xj19jR706hFcrJUUGm7Cidd3uUWKxQSZ/7DOGR
         HG2A==
X-Gm-Message-State: AC+VfDysV429n6KWibKnB7BFEHZiMjI2wtpGExUYXLCyQHeLKeumTss6
        FC8o4VRtz/P0WZvFkQg0vfCXq6UkbUc=
X-Google-Smtp-Source: ACHHUZ4vDoRpL0OZEam7+xPw+z9QVrtan5OPJ5NbSUBY0KnLQr635Q7NdnC8Ac4B1z1eojnnG1oaLA==
X-Received: by 2002:a05:6000:12c8:b0:311:2888:9f95 with SMTP id l8-20020a05600012c800b0031128889f95mr25062999wrx.23.1687778390325;
        Mon, 26 Jun 2023 04:19:50 -0700 (PDT)
Received: from ?IPv6:2001:a61:35be:1401:2331:c532:1717:d48c? ([2001:a61:35be:1401:2331:c532:1717:d48c])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d6986000000b003047dc162f7sm7105043wru.67.2023.06.26.04.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 04:19:49 -0700 (PDT)
Message-ID: <9167ba56f8afafa81efb2d5acd84cab0843505e4.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7192: Use sysfs_emit_at
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Alisa Roman <alisa.roman@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Jun 2023 13:19:49 +0200
In-Reply-To: <20230620163135.93780-1-alisa.roman@analog.com>
References: <20230620163135.93780-1-alisa.roman@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTIwIGF0IDE5OjMxICswMzAwLCBBbGlzYSBSb21hbiB3cm90ZToKPiBS
ZXBsYWNlIHNjbnByaW50ZiB3aXRoIHN5c2ZzX2VtaXRfYXQgd2hpY2ggaXMgdGhlIHByZWZlcnJl
ZCBhbHRlcm5hdGl2ZS4KPiAKPiBBbHNvIG1ha2Ugc3VyZSBlYWNoIGZyYWN0aW9uYWwgZGlnaXQg
aXMgaW4gaXRzIHBsYWNlIGJ5IHBhZGRpbmcgd2l0aAo+IHplcm9zIHVwIHRvIDMgZGlnaXRzOiAi
Li4uJTAzZC4uLiIuCj4gCj4gU2lnbmVkLW9mZi1ieTogQWxpc2EgUm9tYW4gPGFsaXNhLnJvbWFu
QGFuYWxvZy5jb20+Cj4gLS0tCgpSZXZpZXdlZC1ieTogTnVubyBTYSA8bnVuby5zYUBhbmFsb2cu
Y29tPgoKPiDCoGRyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYyB8IDUgKystLS0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYwo+IGlu
ZGV4IGUyM2Q5YTdkY2M5ZS4uYzk4MGJjODcxNDEyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaWlv
L2FkYy9hZDcxOTIuYwo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYwo+IEBAIC01NjEs
OSArNTYxLDggQEAgc3RhdGljIHNzaXplX3QgYWQ3MTkyX3Nob3dfZmlsdGVyX2F2YWlsKHN0cnVj
dCBkZXZpY2UgKmRldiwKPiDCoMKgwqDCoMKgwqDCoMKgYWQ3MTkyX2dldF9hdmFpbGFibGVfZmls
dGVyX2ZyZXEoc3QsIGZyZXFfYXZhaWwpOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGZvciAoaSA9
IDA7IGkgPCBBUlJBWV9TSVpFKGZyZXFfYXZhaWwpOyBpKyspCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGxlbiArPSBzY25wcmludGYoYnVmICsgbGVuLCBQQUdFX1NJWkUgLSBsZW4s
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICIlZC4lZCAiLCBmcmVxX2F2YWlsW2ldIC8gMTAwMCwKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnJlcV9h
dmFpbFtpXSAlIDEwMDApOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsZW4gKz0g
c3lzZnNfZW1pdF9hdChidWYsIGxlbiwgIiVkLiUwM2QgIiwgZnJlcV9hdmFpbFtpXSAvIDEwMDAs
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZnJlcV9hdmFpbFtpXSAlIDEwMDApOwo+IMKgCj4gwqDCoMKgwqDC
oMKgwqDCoGJ1ZltsZW4gLSAxXSA9ICdcbic7Cj4gwqAKCg==

