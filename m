Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2241F6F4617
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjEBO0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjEBO0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:26:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B67F11A
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 07:26:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94f7a0818aeso641854266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1683037598; x=1685629598;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j1ewehjUVKxwdQ1uOyRkskEEr3torUz9oO2uPxn8nQ=;
        b=hh7AYUw/qN69/cT9VetMpD1xSmezq4gBoUcYUxkgz9HuZMY5m72mcTYIANWQP67ytP
         nujbVwu61Iv/8sXEFg1m21I/C+rKqZU69KQU84m0+MfBfs4x8G1EWti1ZH+vcbqTE32T
         l3GG7Bc6tZYLenbzGA3abbJ9SJN/kFeNvBTT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683037598; x=1685629598;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j1ewehjUVKxwdQ1uOyRkskEEr3torUz9oO2uPxn8nQ=;
        b=ItH1MeVQLVAi1J1fC7sY+BuBUFiMVvo3wD/kLLeSUa8pASaSNRAYtcfMFWuHQkdHES
         ZJJ0YChhWfuLY3VguayXzLz9GyC+JIxvFv0Ss15WPdxBZfV/ruAuCDnye48w4nie4/P5
         lr7Ihx8zjD8cY5SqvyMZ9BAOew34W5CZA8CXDdCEA6hcqugNRLCwERwWA6MYGkbk53ez
         jGrN9PqPLV4zDL5rRLnks2QCqj+yr7mN4cZ0epONd3IKXZl61AdjhiM2Y6UM2F9gcIqb
         nOdeoyEgKIBn5/PwoCrWnRTDedQ6TIN8lqUWq6jcJ7oYE9l/cjMi1HhqIbjS1LcITCGp
         OmrA==
X-Gm-Message-State: AC+VfDy9B+YuLsziRBl7vPu9pGztrnn56Z+Bo2r8hBSTeIuuyW78F9rg
        sQwBze+r6EvC1RA0Yllm0XPhzQ==
X-Google-Smtp-Source: ACHHUZ5P/sal6eaqoI9j127346uYz5Ak3tHbx1uRIe5CsOSG+r96H5nZMY/Aag770i5IMKUZ7EffFQ==
X-Received: by 2002:a17:907:9694:b0:961:272d:bdb8 with SMTP id hd20-20020a170907969400b00961272dbdb8mr98860ejc.73.1683037598569;
        Tue, 02 May 2023 07:26:38 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:6408])
        by smtp.gmail.com with ESMTPSA id qm10-20020a170907674a00b0094f282fc29asm15992682ejc.207.2023.05.02.07.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 07:26:38 -0700 (PDT)
Date:   Tue, 2 May 2023 15:26:37 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v5 2/2] printk: console: Support console-specific
 loglevels
Message-ID: <ZFEdnY27pZlBvlih@chrisdown.name>
References: <cover.1682427812.git.chris@chrisdown.name>
 <4d3846bf2543de20aa071b2a12de924eea3e9574.1682427812.git.chris@chrisdown.name>
 <ZEp9dXwHCYNPidjC@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZEp9dXwHCYNPidjC@alley>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the detailed feedback! All comments not explicitly replied to are 
acked and will be updated in v6.

Petr Mladek writes:
>> @@ -2293,7 +2429,14 @@ asmlinkage int vprintk_emit(int facility, int level,
>>  		in_sched = true;
>>  	}
>>
>> -	printk_delay(level);
>> +	cookie = console_srcu_read_lock();
>> +	for_each_console_srcu(con) {
>> +		if (!suppress_message_printing(level, con)) {
>> +			printk_delay();
>
>This would repeat the delay for each registered and non-supressed console.
>But it should be called only once when there is at least one
>non-suppressed console.
>
>> +			break;
>> +		}
>> +	}
>> +	console_srcu_read_unlock(cookie);

Doesn't the `break' below avoid that already? Maybe I'm missing something?

[...]

>> +static int printk_sysctl_deprecated(struct ctl_table *table, int write,
>> +				    void *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	int res = proc_dointvec(table, write, buffer, lenp, ppos);
>> +
>> +	if (write)
>> +		pr_warn_once(
>> +			"printk: The kernel.printk sysctl is deprecated. Consider using kernel.console_loglevel or kernel.default_message_loglevel instead.\n");
>
>Nit: Please, put it on the same line as pr_warn_once("printk: The kernel....
>     The small shift left did not help much ;-)

I think this is done by clang-format with kernel default config, since my 
preference is single line as well. Maybe worth discussing changing the config?

>How does this sounds, please?

Sounds great! Thank you again for the very detailed feedback :-)
