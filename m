Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6687C634FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 06:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiKWFjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 00:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiKWFjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:39:44 -0500
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0909F1D99;
        Tue, 22 Nov 2022 21:39:42 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id bj12so40289696ejb.13;
        Tue, 22 Nov 2022 21:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATGjR+WR/rvjQsAzn1FSqZfn3gb1osfEIFie0PtsarM=;
        b=U+8Uv8gJ2qDZiQSCGRoHCx2H9bz/TkLscQkC3beEsPxseWgnqpjJkBelaJPcc8ndTM
         cDYLXe/rspwQiuLsxIfHDdCajKt2T5W859u+atxFYqxFUqFpV6qcR45CdD5m3b4agHrE
         uFxPEx/NRefirR4IBFGu2HtcN27Yv8e5FQE/aFu/m/8KG1jX/+iIfa8d7hARPsEv/ySu
         s3/dNnAuMT4F4J8vhuVV5dMf0EAikZeTHvITCGFtf6cO2ZVdvG6eFluWfPPW5hZxKBWK
         X5Nox9XDvuVk4a0Xaei1WEQYPbwo1ZtSe/pEQMt7nXAFI5ZUecd3OfvVXMKkEraJ6clh
         sAlg==
X-Gm-Message-State: ANoB5pkuwD8MEwOHadJ50Sl38CfPW0Yw1GESp1S4LIpBxUgPuy4HsVrW
        dC5IpOxFWr8G65r/4dvGitYkgBaycrLqhQ==
X-Google-Smtp-Source: AA0mqf5kI5TnLrfB3RLx5Y2CCjO7P5arxBYeHo5nRSrp0aEhmhgLF2EVkPwsltj7axC/FdZx713hFQ==
X-Received: by 2002:a17:906:4d16:b0:78b:15dc:2355 with SMTP id r22-20020a1709064d1600b0078b15dc2355mr7706255eju.306.1669181981309;
        Tue, 22 Nov 2022 21:39:41 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id bc3-20020a056402204300b00463597d2c25sm7219679edb.74.2022.11.22.21.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 21:39:40 -0800 (PST)
Message-ID: <b5888b92-ed6c-98c7-0d38-982a31e10e4f@kernel.org>
Date:   Wed, 23 Nov 2022 06:39:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 09/14] serial: liteuart: fix rx loop variable types
Content-Language: en-US
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org, ilpo.jarvinen@linux.intel.com
References: <20221118145512.509950-1-gsomlo@gmail.com>
 <20221118145512.509950-10-gsomlo@gmail.com>
 <44bf21b6-cbe4-4d73-0883-a9bcbd7d5971@kernel.org>
 <1b5a963c-2a5b-54fe-784e-fcc4d06c347e@kernel.org>
 <Y3uDZV8b+3GfQyUY@errol.ini.cmu.edu>
 <2f242291-99b6-a50f-cd52-e7dfd8c88c8f@kernel.org>
 <Y305gZnFSaUBtCRa@errol.ini.cmu.edu>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <Y305gZnFSaUBtCRa@errol.ini.cmu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 11. 22, 22:05, Gabriel L. Somlo wrote:
> So, looking at what uart_insert_char() does, I could simply do this
> instead:
> 
>   	while(!litex_read8(membase + OFF_RXEMPTY) {
>   		...
> 		/* LiteUART does not provide overrun bits */
>   		if (!(uart_handle_sysrq_char(port, ch) ||
>   		     tty_insert_flip_char(&port->state->port, ch, TTY_NORMAL)))
>   			++port->icount.buf_overrun;
>   
> That is, `tty_insert_flip_char() is the portion of `uart_insert_char()`
> that actually gets executed if status is 1 and overrun is 0...
> 
> I'm not quite confident about whether this is an improvement in legibility
> and/or code quality,

It's not :). Keep the uart_ helper.

-- 
js
suse labs

