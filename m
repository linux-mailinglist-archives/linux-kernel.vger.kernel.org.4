Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFA674E9B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjGKJCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjGKJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:02:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36171724
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:01:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbd33a57ddso55925445e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689066117; x=1691658117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hvH8IFA66UBhNAUcAjxTeC2EGoXW4NGa//k1MlXqT0=;
        b=SOqfnFBVQJFtudwrqaybdzD8Mh3tVRj8j4I33Ik48exr9ztGtl7Ql8Vf3L1JBN8Xlo
         N1SsrphZPDaJOE8g5GotGZ2hXkvb1aPqkqjXgHiQJinX8PdPsMXEdpgZh5yUtG7Sm04L
         TljJr/dZ1Th9AtCh60FMdN539bAnlZwyedkMsAvsEQkczEkan0Wu2uV6DOUCIEzszRNn
         ZaIYE8eK9xWFCtJX0bnZlFdiPYcWAui92FOULCwgvzWnbpHqvw2WTxIg3g4c9L7S678y
         G04QpVcMgfSF+FxhtzJTYdCTu+HlukxVOFudwm9ILyZKzZe7DZBqzMOGtTySJCYqEuJ7
         s5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066117; x=1691658117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hvH8IFA66UBhNAUcAjxTeC2EGoXW4NGa//k1MlXqT0=;
        b=CZbcic3CuQKfiK3TFwUqYU732wag9SgzNohio2KtBppkUdywjiBd0VmNP+kGiSimZ9
         WwHhCISMHV8nesv6ySf/9UQ06u5GDQGsuExjSAcj7BE2KbtO0RJMUnHUbMVLon2NAiBf
         QXBBV2ZCQNlWxQ3461f01bRDKgLLx292/f8++1qQzRrDLDtyuXS9voLkwmUCEg9sH1Ll
         y7H/FYPMffNHc5ur98JoV/UMqijIff22N07itLg+T9JsYw2siiC+0F7saKDPTtLJPAr/
         YdX4Y56SaF3KapGTF9PYl4wfMpHVyHpSS4boyXj88b0h0rYsNIAwb3XjLSC1AH+lmsy0
         Ba9Q==
X-Gm-Message-State: ABy/qLZ+pIG6bRrfT+tSFkVNosjzxsyKuh+/rrai0/F6j4UVGIuQLnRK
        QWiFQtnrc42hzkXTfLF9jENxoQ==
X-Google-Smtp-Source: APBJJlFQTm6HbSpXbJ386CGPmzFm581e/edg7ZOLI8tH/qSSi3hWytLKK1DBX8XjruF1n4yopcIUDQ==
X-Received: by 2002:a05:600c:28c:b0:3fb:dff2:9f14 with SMTP id 12-20020a05600c028c00b003fbdff29f14mr13932119wmk.4.1689066117394;
        Tue, 11 Jul 2023 02:01:57 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b003fbca942499sm12323236wmj.14.2023.07.11.02.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:01:56 -0700 (PDT)
Date:   Tue, 11 Jul 2023 10:01:55 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@atomlin.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v2 1/5] kdb: do not assume write() callback
 available
Message-ID: <20230711090155.GB26224@aspen.lan>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-2-john.ogness@linutronix.de>
 <20230711082339.GA26224@aspen.lan>
 <87lefmq0yk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lefmq0yk.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:04:11AM +0206, John Ogness wrote:
> On 2023-07-11, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > For v1 I shared an ack rather than queuing the patch. Although reading
> > the thread back it is possible that was based on a misunderstanding
> > (https://lore.kernel.org/lkml/20230309113020.GA78621@aspen.lan/ ).
> >
> > Anyhow, it looks like you have designed the new series to be picked
> > individually?
>
> I understood that Petr will carry the patch. Yes, this series only
> includes the non-atomic/non-threaded cleanups so that it will be easier
> for Petr to send the full series off to linux-next.

No worries, that's fine for me and from my point-of-view its still:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> For this patch there is nothing left to do. I should have removed the
> kdb people/lists from the mailing. Sorry about that.

To be honest I'd rather be in the loop than out (and with that title my
mail filters would jump in it anyway).


Daniel.
