Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1506E9637
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjDTNrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjDTNro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:47:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E172526E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:47:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f1763ee8f8so4937045e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1681998462; x=1684590462;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUEr5pvi6aP9/pHr4WA22mUOJfxMrKdK+Iv0AA04kEA=;
        b=DdqDcsj+sbUOnaBbPZHotN2/BdTlnygE8Gqu+wskzZkuDyh+QUg7LcqoFCYwDCwdL0
         tVop6cvOF/Ak3KTbOpl9f7mapJdhYEKacyqeaAvURodMA945CDCcHUo4Vdu4bmDW0eg2
         nYAWuaaAx981rqobMT3k0b3tqBUUrF8vqBucs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681998462; x=1684590462;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUEr5pvi6aP9/pHr4WA22mUOJfxMrKdK+Iv0AA04kEA=;
        b=cTlNI+MbFX20P4NlNKiSLAP5J2SPqJkszNuf+9euWcK+7arXWy9mK35SOo2k3FjKDr
         nMDZLuuV9NTsz0lnylLGQxdCpC433SVoAbMNm3cWZGtUwdo3WznNcOJV+AHPiFaasOR9
         xhcYRWTnU/UqVwKVQeBpAMLVOLfSUq3oW97Biw6XPfboqKixJ8N11UWXvithrdp03gbD
         oNm49fqmIeScAOEoAr9JArGQ7hDwowlWwSATdr+xikX80Swb5I3XoKm0bhRiG63KdoVN
         C5DY2MZ6mTGt7p6y2NOcdoZNO49rua5H4XGlHFHHWZY9CtFmFhOCBFBMKJu0b+DlJgDJ
         I85g==
X-Gm-Message-State: AAQBX9e+XS2k7wdfFmOyA7RkBff1Vjf8VBwAcSC76Xjy9sEtGbu1/nC5
        remho9iJfxx7LAe4EZpSGBbHPw==
X-Google-Smtp-Source: AKy350ZA/GTeMuAqQ3TeooIeV4RJVcPIe9yDiKtGHoGQfE++gIlJvnlG9w7Ws5R2MVmSX4MLWLwyqg==
X-Received: by 2002:adf:f391:0:b0:2f6:ece3:76a with SMTP id m17-20020adff391000000b002f6ece3076amr1235914wro.8.1681998461708;
        Thu, 20 Apr 2023 06:47:41 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d5543000000b002fe254f6c33sm1984180wrw.92.2023.04.20.06.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 06:47:40 -0700 (PDT)
Date:   Thu, 20 Apr 2023 14:47:40 +0100
From:   Chris Down <chris@chrisdown.name>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v4 1/2] printk: Do not delay messages which aren't
 solicited by any console
Message-ID: <ZEFCfJLteNo91n-f@chrisdown.name>
References: <cover.1681994220.git.chris@chrisdown.name>
 <43d7f8d6e4b45a1a76fceef2d117bbc3954bc0bf.1681994221.git.chris@chrisdown.name>
 <87wn26vg3p.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87wn26vg3p.fsf@jogness.linutronix.de>
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

John Ogness writes:
>On 2023-04-20, Chris Down <chris@chrisdown.name> wrote:
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index fd0c9f913940..06f16a5f1516 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1289,15 +1289,13 @@ static int __init boot_delay_setup(char *str)
>>  }
>>  early_param("boot_delay", boot_delay_setup);
>>
>> -static void boot_delay_msec(int level)
>> +static void boot_delay_msec(void)
>>  {
>>  	unsigned long long k;
>>  	unsigned long timeout;
>>
>>  	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
>
>            ^----- you will need to remove this paren as well

That'll teach me to compile test without remembering it also needs 
CONFIG_BOOT_PRINTK_DELAY=y :-) Thanks.

>
>> -		|| suppress_message_printing(level)) {
>>  		return;
>> -	}
>
>John Ogness
