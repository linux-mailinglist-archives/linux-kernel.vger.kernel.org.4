Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C59689082
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjBCHSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjBCHSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:18:31 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8C5105
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 23:18:28 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hx15so12786126ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 23:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jg1o5S4wDItPpEBwTmMaDOJZkucoVf7whNEU2o61P+U=;
        b=ADUfBOJ6G+rc3VG5guCAVf9JterCByIbLi0D6G+dIajLMzb1Z7tipk6aoGeGnhqD5T
         AftoqfNsrtOHdHnLxMYm0/2Gz9fQU/YJAeYmw7l+3WkV59YF2sK5mB8fs7g+e5dkil52
         qEYviL896zQh7lVaBbxfbB5wc0tYw5djmpWpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jg1o5S4wDItPpEBwTmMaDOJZkucoVf7whNEU2o61P+U=;
        b=Ojm9AhKwhqb7dBYv7ZHd0yz6Z4Ez1SHODcZ/ArYnwylWw/0xyoM4YQm+9+UKKm2/2r
         TAwtnJVf3jY5mj1/lvTFw/EWBWswQZjeI6Mgi1ZMBERj/S7SqG+P1qhAB3JHePFxDgWp
         6LA/b43GBvaNwIwtqu6+F5HtI/U8ARMaFr6ck2rFoZU/BDWxn4Xj8tIOiFkyMVf+V8XM
         0Uxhs1qD6j0xaa2k+aJ/MY7l+yRPBrn3cBGqjSSwgvphYQy3x1wEagHOwoUiJ0mIbquU
         Zcn7WAmgX+B4LJ14z6Zdx3pLOUwSGdeUvvF4W+6XzwvwDoQZZJFpSue/behgdhK6URH7
         7sNw==
X-Gm-Message-State: AO0yUKWvPDPb2MBwae2XNTGgK4DRFn0azurjzMzotCdHE9Eqidnq8oyN
        V/UQwNVmjwSXWOZG8pTYN0SroObrqKSPaoi5OwE=
X-Google-Smtp-Source: AK7set9cs7RecCnW+SPHw9NZqf3dZHNqgoclJ+dCLqgMXQIQcl/i+44dQuZ/0FGBack3Z8gsqKNJEA==
X-Received: by 2002:a17:906:885:b0:86f:356e:ba43 with SMTP id n5-20020a170906088500b0086f356eba43mr8923330eje.18.1675408706757;
        Thu, 02 Feb 2023 23:18:26 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f17-20020a1709064dd100b0087276f66c6asm942812ejw.115.2023.02.02.23.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 23:18:26 -0800 (PST)
Message-ID: <f484c11b-a221-b096-7ae6-91de7490b8a0@rasmusvillemoes.dk>
Date:   Fri, 3 Feb 2023 08:18:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: memchr() vs. memscan()
Content-Language: en-US, da
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>
References: <Y9vX95GpI272VKn0@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Y9vX95GpI272VKn0@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 16.34, Andy Shevchenko wrote:
> Why do we have memchr() and memscan() implementations in lib/string.c?
> As far as I can see the one may be derived from the other easily.

Well, memchr() is the C standard thing, and the one arches are more
likely to (and do) provide custom implementations of. memscan() seems to
be to memchr() as strchrnul() is to strchr(), and judging by the number
of callers, I don't think any optimizations or a separate C
implementation is really worth it. So yes, by all means we can replace
its entire body by

  return memchr(addr, c, size) ?: addr + size;

That's possibly even a win for the arches that do provide their own
memchr(), but again, performance of this one doesn't matter at all. But
the tiny kernel folks might appreciate this.

Rasmus

