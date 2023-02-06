Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6807068C731
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjBFUAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBFUAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:00:11 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3391E2B606
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:00:02 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id e22so8165109ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOkKygWO4dfx/Wc4QpfphIFrTmEThHoWMJ1kNrj1PgU=;
        b=eF0LRchkacajklSZFjbRlJ4l3jdWdY5q+idJXMOsV05Rj8slA3HPoC+tN5iM7k4b+p
         NJDt8Ep4y9nNcnS5xYPM01qnWWGa/IxxitTsRNwLQXDCmkoabkDahC2zAnanJxNSj3U2
         4/f6qiTJGkH+OaLuZZ6XWqhHeIXMxRi3LuybI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOkKygWO4dfx/Wc4QpfphIFrTmEThHoWMJ1kNrj1PgU=;
        b=lELmOq1UcW10WMEfC0UYIwS52hePICOF6C1cmpIt4wpUddPTmcbIEHLNyT6lI3ptUF
         jL5gYgxwJy5lUMQJFXCpd2kJ345aD5UtjLpee+ADjjkAY2zwKhRXTm23VEoxm1WxQsdH
         PRZnlCo4DkM1A6+mbGU34NPowFlYzNg72RriZlzP6mueC92pEAb8QTomjV0i3Dmoc6Mi
         A2yDd+Wkkiydry9+3H3rE9P0L9NJCYMiMk0NTUdNugeSS5G4RVV5FOhndKSTdM3KiVGx
         Jps3hj1sLUF6xeB7l9xC0dBj8gdmeRpTvy6qHxeBUT6cD3VDxWtl/0ypbGo/AJSCPNMz
         6rMg==
X-Gm-Message-State: AO0yUKWyzj5ue8iDvEBrJqQMiV3aDpnCRdYTYZOXzFQfYjlL1dwyuDTK
        6/mKTmcA9pDtHVhUJMoVYDjLrv6C0XTO1RBsE1w=
X-Google-Smtp-Source: AK7set9RHV0QjygX+uikQ5kc0lj4dCK1CC8TmGOidQgts+9c1DKuD8W1Fj6d7POKXkKBHMxfqH+9UQ==
X-Received: by 2002:a17:906:757:b0:88f:7d3b:b90 with SMTP id z23-20020a170906075700b0088f7d3b0b90mr535923ejb.42.1675713600685;
        Mon, 06 Feb 2023 12:00:00 -0800 (PST)
Received: from [192.168.1.149] ([80.208.70.109])
        by smtp.gmail.com with ESMTPSA id m5-20020a1709062b8500b00872c0bccab2sm5858671ejg.35.2023.02.06.11.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 12:00:00 -0800 (PST)
Message-ID: <096fa00d-8625-172c-74ba-134ddb1395ef@rasmusvillemoes.dk>
Date:   Mon, 6 Feb 2023 20:59:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] [RESEND v4] printf: fix errname.c list
Content-Language: en-US, da
To:     Arnd Bergmann <arnd@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20230206194126.380350-1-arnd@kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230206194126.380350-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 20.40, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On most architectures, gcc -Wextra warns about the list of error
> numbers containing both EDEADLK and EDEADLOCK:
> 

[...]

> To ensure these are correct, add static_assert lines that verify
> all the remaining aliases are in fact identical to the canonical
> name.
> 
> Fixes: 57f5677e535b ("printf: add support for printing symbolic error names")
> Cc: Petr Mladek <pmladek@suse.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

You may also add Acked-by: me.

> Acked-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Link: https://lore.kernel.org/all/20210514213456.745039-1-arnd@kernel.org/
> Link: https://lore.kernel.org/all/20210927123409.1109737-1-arnd@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I sent this a few times, but it never made it in so far. The warning
> still shows up when enabling extra warnings, and this is an actual bug.

Petr, please pick this up.

Rasmus

