Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880B372C266
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbjFLLFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbjFLLEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:04:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793DB93F8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:53:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51491b87565so7328721a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686567190; x=1689159190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8SLBrnwbHCvnK+EhlE8eJ/+pq9MyO6Q+aOHOn+73hw8=;
        b=I4Jo53AtXKUAWujuX6TPrsPzylsWLanXZel9thkXkSIXOVui0kQwzZh7YdgZmor2Jt
         tf80rFrTpAgnDS6xkg4Y4x6JU6myT/iURXuMuHmCcitBuH5EU/XswWhVMDm6BPH7P2nw
         YALTxnobGGv+uPJIXW5C/Hq8IwS3T/UAFliuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686567190; x=1689159190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SLBrnwbHCvnK+EhlE8eJ/+pq9MyO6Q+aOHOn+73hw8=;
        b=QlUQQYY43xy5uRDhwl4a6RLYG1pWyrJqss/c/B/yG5NoVJ7nE06QOp1+64s+5G2HqL
         CDvD+/EUYsW9ZtFAt56VQ35OCFVnUgrTd9VlVQuCbwxQfgu8EptWZtl/tHjb2ZaEStil
         Wp3pYh0BR7Iyc0K/bFbvTel7haUHi8gXrIpHj6/HugLP3TbhxiIiBLZ66XcZhG8FXv0q
         qhQnn95nCgcmI/s9Jg+3LYr75fcqWm7dT07b8uzxs+wHLzIYOO5J42Zpx++fkgHs5L5q
         UjAmVyFO9/99ebAZbmVx3Jb9J0gZXUlHRXp/bvxsNEB9ubEkC3MkfQv8TtoodU6N0ZLy
         7/BQ==
X-Gm-Message-State: AC+VfDwrNcQ/hW6SekPcEj/MgY5QRUjKroH8G692X4vpbye3fAp/Lg6v
        PDFkXP81GSLOeagHpgIgfsV7RA==
X-Google-Smtp-Source: ACHHUZ7U3uNm5on+y8jIMuDZ1cfGc9aiIN8XESopyRzBAdqMM/RLAE//onmpwNxNuERJC8T8wQeJ7A==
X-Received: by 2002:aa7:d40e:0:b0:510:8ee2:2b05 with SMTP id z14-20020aa7d40e000000b005108ee22b05mr5081219edq.38.1686567189783;
        Mon, 12 Jun 2023 03:53:09 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g20-20020aa7c854000000b005169cd0edffsm4876752edt.35.2023.06.12.03.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 03:53:09 -0700 (PDT)
Message-ID: <96b45245-bdd8-119d-e7a9-44eb36be0f97@rasmusvillemoes.dk>
Date:   Mon, 12 Jun 2023 12:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/4] vsscanf(): Integer overflow is a conversion
 failure
Content-Language: en-US, da
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230610204044.3653-1-demi@invisiblethingslab.com>
 <20230610204044.3653-3-demi@invisiblethingslab.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230610204044.3653-3-demi@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2023 22.40, Demi Marie Obenour wrote:
> sscanf() and friends currently ignore integer overflow, but this is a
> bad idea.  It is much better to detect integer overflow errors and
> consider this a conversion failure.

Perhaps. And maybe I even agree. But not like this:

>  	while (*fmt) {
>  		/* skip any white space in format */
> @@ -3464,6 +3474,9 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
>  			break;
>  		++fmt;
>  
> +		allow_overflow = *fmt == '!';
> +		fmt += (int)allow_overflow;
> +

You can't do that. Or, at least, you won't be able to actually use %!d
anywhere, because the compiler will yell at you:

lib/vsprintf.c: In function ‘foobar’:
lib/vsprintf.c:3727:26: error: unknown conversion type character ‘!’ in
format [-Werror=format=]
 3727 |  ret = sscanf("12345", "%!d", &val);
      |                          ^

So NAK.

Also, when you make significant changes to the sscanf implementation,
I'd expect the diffstat for the patch series to contain lib/test_scanf.c.

Rasmus
