Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ABA611E17
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJ1XZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJ1XZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:25:39 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46C71F811F;
        Fri, 28 Oct 2022 16:25:37 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id z30so4449277qkz.13;
        Fri, 28 Oct 2022 16:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=L6ZOWLOEX11BGF0X2VSYkzcJRButopYPzUykJug/GR0=;
        b=N9VJvCIgWo10v8ZBugLuq279vVIA8JBBxQrU15xejDChn3YT17qE30TZWhUo/YLmLT
         IjsEK6UgwLVFlKRmhn7OT5pYDfcSMVX/57+5hEHRwSEfnycvcMmfujdlP4jr7z6z4NSK
         rLvaR0vjjJDO7EcLXQ0oq45LMdRyLcwgEAnQma8SEOs1QsXu1dsURUQUwyyenlhY3pVI
         gcYGn+dAoDtnhAoLVNXCG/XaFl3XzGpWU2y7j+qhTG8mB41LumvwFrAI9dWgMlqEMUml
         E6yQkfX0yRPQb4UmDqy0wu4nsS0rz2doLxwfWLQwid/Ye60NBRuWGMJ08Hj+1E8U/EE2
         sdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6ZOWLOEX11BGF0X2VSYkzcJRButopYPzUykJug/GR0=;
        b=Etikr5SAHdgG/k9AOnAn6F0D7RtfvjI9J6+bKvcAg7/cFvHCVK6QQ8gtxrmCmDW3Ky
         0wAby9ENup24P2HrgRmq8zas0Xo5xeR0fx6L6LtLOULWyUfFoXVC5XqawGiFvyrGmOQi
         PYBe4GRhf4YUfO1XiWEsv7IwOMwSuLZ0ToPF3jLe5E+UTSnEI6yL1CGJz0v51prs3nSZ
         s6maOLwfbnpIeHgf3tkmdthX1+GC6HcncFRNMC8q37fAvjkFBHor8Fbq0mnm+dROyFxA
         CtU8lBgKK/nqCIc5/5Qr8V6rD8hGpwKUpydLiLOB5g7/gP8cXzwSjMKtN2tALWOGBZSM
         px6g==
X-Gm-Message-State: ACrzQf36iClfcJHPD7SF18ky2QiSjKJ9C5dY9lVkKNxaCYnDCPeOwcdd
        3n+O3MISsH5NyUqhCiJYp5Y=
X-Google-Smtp-Source: AMsMyM741lPzgEevypdlsE8vYF92OeEjEqksnIX9l3xyzgSpKwqtYRhmgo7muFLOBWWECDCym9XV8g==
X-Received: by 2002:a37:42d2:0:b0:6ef:241:f7ad with SMTP id p201-20020a3742d2000000b006ef0241f7admr1375784qka.38.1666999536874;
        Fri, 28 Oct 2022 16:25:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bm11-20020a05620a198b00b006e42a8e9f9bsm3731489qkb.121.2022.10.28.16.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 16:25:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6107f2b1-fcd2-918b-328d-401cc22710be@roeck-us.net>
Date:   Fri, 28 Oct 2022 16:25:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC][PATCH v2 20/31] timers: usb: Use del_timer_shutdown()
 before freeing timer
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-usb@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <jstultz@google.com>
References: <20221027150525.753064657@goodmis.org>
 <20221027150928.983388020@goodmis.org>
 <4e61935b-b06b-1f2d-6c2b-79bdfd569cd6@roeck-us.net>
 <20221028140129.040d9acc@gandalf.local.home>
 <20221028141007.05f5c490@gandalf.local.home>
 <20221028195959.GA1073367@roeck-us.net>
 <20221028164024.2ab39cc1@gandalf.local.home>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221028164024.2ab39cc1@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 13:40, Steven Rostedt wrote:
> On Fri, 28 Oct 2022 12:59:59 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> I'll test again with the following changes on top of your published
>> patch series. I hope this is the current status, but I may have lost
>> something.
>>
>> Looking into it ... deactivate_timer() doesn't do anything
>> and seems wrong. Did I miss something ?
> 
> You mean debug_deactivate_timer() or debug_deactivate?
> 

This:

+static void deactivate_timer(struct work_struct *work, bool is_dwork)
+{
+       struct delayed_work *dwork;
+
+       if (!is_dwork)
+               return;
+
+       dwork = to_delayed_work(work);
+}

Guenter

