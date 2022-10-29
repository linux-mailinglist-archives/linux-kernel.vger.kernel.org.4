Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160206123FD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJ2Oop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ2Oom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:44:42 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB53F013;
        Sat, 29 Oct 2022 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1667054669;
        bh=9uirLhC6fEHAb5EmSdX2Ej0uPpqczcrpqvwDwfiKNP0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h8wRHdDbc55D4E8wR/cemSUD6Rgpucjg18olRdeBAk4B6Iis6w0zHn+g/4MVf1Ray
         UDWBQjBzh0N+4vJs7ZEhoGydLthDn2lNu0jfcn5v/OeLxm2LNAhHvXiXO+l7Ls4aKG
         smuWOzbQzJCQGvsD0B3XDJf8THeRS1gkuWdBEj+Z+mu3j0bSfY5IZzITsutidcMIA+
         SY9DoCS24uQy4WCMVTYPaqB2UXtZDDjYzWRNHxbBG5UkBegd2hcKuhkYC1fCHvI+wU
         m6cpOpEbJl4lCXtKChTQmwedvvDc23KU+EjSRIyjP8Ll5U18BtjaJoMYG1UezASaqH
         rODX6bTQ9vDTw==
Received: from [10.1.0.216] (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4N02Hd2gN0z11kK;
        Sat, 29 Oct 2022 10:44:29 -0400 (EDT)
Message-ID: <7cad3dde-b1c5-935d-23bc-61e98c3a7b07@efficios.com>
Date:   Sat, 29 Oct 2022 10:44:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH 1/2] tracing/user_events: Use remote writes for event
 enablement
Content-Language: en-US
To:     Beau Belgrave <beaub@linux.microsoft.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <20221027224011.2075-2-beaub@linux.microsoft.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221027224011.2075-2-beaub@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-27 18:40, Beau Belgrave wrote:

[...]
> diff --git a/include/linux/user_events.h b/include/linux/user_events.h
> index 592a3fbed98e..4c3bd16395a9 100644
> --- a/include/linux/user_events.h
> +++ b/include/linux/user_events.h
> @@ -33,12 +33,16 @@ struct user_reg {
>   	/* Input: Size of the user_reg structure being used */
>   	__u32 size;
>   
> +	/* Input: Flags/common settings */
> +	__u32 enable_bit : 5, /* Bit in enable address to use (0-31) */
> +	      __reserved : 27;

I'm always worried about using C/C++ bitfields in uapi, because some 
compilers (e.g. MS Windows Compiler) have different implementation of 
the bitfields. See

gcc(1)

-Wnopacked-bitfield-compat
-mms-bitfields / -mno-ms-bitfields

Thanks,

Mathieu

> +
> +	/* Input: Address to update when enabled */
> +	__u64 enable_addr;
> +
>   	/* Input: Pointer to string with event name, description and flags */
>   	__u64 name_args;
>   
> -	/* Output: Bitwise index of the event within the status page */
> -	__u32 status_bit;
> -
>   	/* Output: Index of the event to use when writing data */
>   	__u32 write_index;
>   } __attribute__((__packed__));
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

