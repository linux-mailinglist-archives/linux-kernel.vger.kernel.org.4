Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739A96C342B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCUO0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjCUO0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:26:36 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B02E4D42E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:26:02 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d14so4102955ion.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679408749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j92IPH/tXuCtZZM04rrZEMBKuL+XNp59wtlpqWm2eMc=;
        b=XYixwF/zo2JNDZ3vDZSrH7WX9PMUCvPLbXOVgWfdDNhGauVScBWFc0kotbee2pJwa8
         LOR0er0Wzs6qwjrdK31H9MqfMcQDszYtR8h7+JMX5SlIiAk5AtduCaQ0zMHP+hDv++T7
         MRljgjdbr+PxcqXNIuG44VrJ/roOhhuZ5oD92nftUt2Fvh6KJSS7A0hqqOqkOBRpP0c4
         rLBh6AAIn7yci+dUnVWVxe19SSbQM3jMwy223Pi8R157yuRXOBo1NrY1l919tbQoSRpp
         1EloxOxXGz5qRWVkUa8g6GCYmcaTzq+Hs24iB5ItasvC8EeLvysD7BYkUlcvnK6aoKdY
         9+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679408749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j92IPH/tXuCtZZM04rrZEMBKuL+XNp59wtlpqWm2eMc=;
        b=4C21kr7UQe+/Uewp/SG2B09Lcl+zT9AYQ4ZUeKhn8wNAAVqXiVV18u5c2d57EceZsF
         jV5qtjrPOYN3sNq+YP6qfyyqnqyDvBaTROpz/OgKKuo9+LOBbHhbnM2O2H79+m4vdXag
         b4NWCbxM39GavgaXyZVSvNjedZ8uGmPyA07n4SsKjmzC/AqKoVTcrmPbwwX8Q4laEB7O
         bJSbHogQOY7kXAtPB98zO/n88K0bc/s+lqilNzQJBfOhuD1oBr4mF8Si7HlepC/YGM5O
         1evtU/z4TnOgr/s8LRCNZpRwtC8NP5Bkq6qGsfGM1HdnroQX6Ed6ojq9X5DmBvSDArNz
         TIyg==
X-Gm-Message-State: AO0yUKW+MVtgSG4L1CCSAuYEurZuhczVky+RJJMb44ynIoWehXgNY6ef
        FXAlvdGyI/s7acyX7quFZ/fWcm3vleE=
X-Google-Smtp-Source: AK7set+QJ6ZbArvXrJdknp1ypG5wAeyQFaDQF8MEvVTKaXzBbdhdUQ02KeR73lXXATVNLOgfN9J7kg==
X-Received: by 2002:a5d:89d2:0:b0:757:ef37:933c with SMTP id a18-20020a5d89d2000000b00757ef37933cmr1773464iot.16.1679408749217;
        Tue, 21 Mar 2023 07:25:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d1-20020a5d9bc1000000b0074564031d75sm3828187ion.2.2023.03.21.07.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:25:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Mar 2023 07:25:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] LoongArch: Check unwind_error() in arch_stack_walk()
Message-ID: <f61ac027-0068-40f0-87bd-17f916141884@roeck-us.net>
References: <1679380154-20308-1-git-send-email-yangtiezhu@loongson.cn>
 <253a5dfcb7e41e44d15232e1891e7ea9d39dc953.camel@xry111.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <253a5dfcb7e41e44d15232e1891e7ea9d39dc953.camel@xry111.site>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:35:34PM +0800, Xi Ruoyao wrote:
> On Tue, 2023-03-21 at 14:29 +0800, Tiezhu Yang wrote:
> > We can see the following messages with CONFIG_PROVE_LOCKING=y on
> > LoongArch:
> > 
> >   BUG: MAX_STACK_TRACE_ENTRIES too low!
> >   turning off the locking correctness validator.
> > 
> > This is because stack_trace_save() returns a big value after call
> > arch_stack_walk(), here is the call trace:
> > 
> >   save_trace()
> >     stack_trace_save()
> >       arch_stack_walk()
> >         stack_trace_consume_entry()
> > 
> > arch_stack_walk() should return immediately if unwind_next_frame()
> > failed, no need to do the useless loops to increase the value of
> > c->len in stack_trace_consume_entry(), then we can fix the above
> > problem.
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Link: https://lore.kernel.org/all/8a44ad71-68d2-4926-892f-72bfc7a67e2a@roeck-us.net/
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> The fix makes sense, but I'm asking the same question again (sorry if
> it's noisy): should we Cc stable@vger.kernel.org and/or make a PR for
> 6.3?
> 
> To me a bug fixes should be backported into all stable branches affected
> by the bug, unless there is some serious difficulty.  As 6.3 release
> will work on launched 3A5000 boards out-of-box, people may want to stop
> staying on the leading edge and use a LTS/stable release series. We
> can't just say (or behave like) "we don't backport, please use latest
> mainline" IMO :).

It is a bug fix, isn't it ? It should be backported to v6.1+. Otherwise,
if your policy is to not backport bug fixes, I might as well stop testing
loongarch on all but the most recent kernel branch. Let me know if this is
what you want. If so, I think you should let all other regression testers
know that they should only test loongarch on mainline and possibly on
linux-next.

Thanks,
Guenter
