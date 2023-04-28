Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029386F1209
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345428AbjD1G5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 02:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345422AbjD1G5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:57:05 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F5DCA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 23:57:03 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4edc7cc6f46so10221920e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 23:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1682665022; x=1685257022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1kJlvIqcTMDqaxW/AEohe0PhfCoogquhxNv0DiWrFl4=;
        b=hJrB/747zFXzcSCMIBOVwV3xa6T2YgbhBZZsKRIA/c4J5g6210WKxzAKVyb1IeYyfF
         umxdRhqdsw4ysLjMPiAvx5b08DYGj8cKn0FR9Os+zGbzDwEotIS3QI5JL52sQdjdHIm7
         HgklUG96wfRfvY0rLT96m2UDMaHmlcj0Zt5rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682665022; x=1685257022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kJlvIqcTMDqaxW/AEohe0PhfCoogquhxNv0DiWrFl4=;
        b=ZU4/SRWXbbinlv9e1wXRzfQWRgcUOzHiiNhnnxvrm/iXp1DEoik1Mvvs5RoHoVXfaC
         aDk8YZcLvKt6mHsqYWUlJPsGFt7Xs7Ce/9S2ySzDrejoif8FsKTo7P7LspaFQcJCsZdq
         27Y+z5icbs69d6yqgiW44YIZvFOJ/sKXst6XQxyXjZUN4PQFCz+9aX4KgHFiLPINpoO1
         Sr9DCz52eRPjAiRYknnxD/CUgR8rgnILiOqyo0yUaJ/vHVD6klkTiTqMSWDCOFTggPJC
         dyV1+pfTz4R67XgK+J+wa2uf1zjVDcrhjuFwtavtA/5yFIuu8DhdBPUrASyt7q9reaFB
         EI/A==
X-Gm-Message-State: AC+VfDwflHHnwtnL2h2F7Vce309VBj2+Y9q2OO1otX0NMcPEoIiJZpzw
        QF8a7r8mwg1eiGXDWWkt7V7z6g==
X-Google-Smtp-Source: ACHHUZ6g6AxxBbf7Sw+PzyY8NXopLVuAvHozwPPBKPyF1ze7pXoradtPdGYIMWg6QbQJ4i3geVRLcQ==
X-Received: by 2002:a2e:7c12:0:b0:2a8:db03:83f7 with SMTP id x18-20020a2e7c12000000b002a8db0383f7mr1145785ljc.32.1682665022157;
        Thu, 27 Apr 2023 23:57:02 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u19-20020a2e8553000000b0029839faa74fsm3214063ljj.134.2023.04.27.23.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 23:57:01 -0700 (PDT)
Message-ID: <c075b668-8194-6aea-484c-0223f164cb4d@rasmusvillemoes.dk>
Date:   Fri, 28 Apr 2023 08:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/2] vsprintf: Add %p[mM]U for uppercase MAC address
Content-Language: en-US, da
To:     =?UTF-8?Q?Konrad_Gr=c3=a4fe?= <k.graefe@gateware.de>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Felipe Balbi <balbi@ti.com>
Cc:     stable@vger.kernel.org
References: <2023042625-rendition-distort-fe06@gregkh>
 <20230427115120.241954-1-k.graefe@gateware.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230427115120.241954-1-k.graefe@gateware.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 13.51, Konrad Gräfe wrote:
> The CDC-ECM specification requires an USB gadget to send the host MAC
> address as uppercase hex string. This change adds the appropriate
> modifier.

Thinking more about it, I'm not sure this is appropriate, not for a
single user like this. vsprintf() should not and cannot satisfy all
possible string formatting requirements for the whole kernel. The %pX
extensions are convenient for use with printk() and friends where one
needs what in other languages would be "string interpolation" (because
then the caller doesn't need to deal with temporary stack buffers and
pass them as %s arguments), but for single items like this, snprintf()
is not necessarily the right tool for the job.

In this case, the caller can just as well call string_upper() on the
result, or not use sprintf() at all and do a tiny loop with
hex_byte_pack_upper().

Rasmus

