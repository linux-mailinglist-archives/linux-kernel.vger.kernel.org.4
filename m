Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4C25BD748
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiISW2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiISW2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:28:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D71327DFC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:28:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a26so2001097ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lvfa1fxSxgmW0KEuyBwvbOHuEMnuMd5OR+3FaC/3Bbk=;
        b=bfhq1oofsMMKWEA7M8YVqUTfwCfJCsdb8h8pz8ujERmafWb1ZHeaLH3jJa2yHFh2Tj
         GnG7Ih3sqmg1jiyu89y/a2+3nel+yS9/aZ9wqtab5VbWXLCn8tiucdsRkfW9NwfGPDKW
         LDwfPGESwv4YWzfiYZ+BceFSekRkTdJ9RCgkYMk0lDPYLNeRLwtpcFyEsllVGzlrjDsU
         Qh09b9w5/KES3KmTzDZOWDQuJe7Bpaqrn4bHbYcbEd7vXCkUbL2OK6yDFwZhIApRk1Nd
         uxzskWJsPNcgQXNXa6oIEuK9LpK4agquXHGOI1BzRVR42Pd/UEDbrfHDRBmmfUQ+V7C3
         rqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lvfa1fxSxgmW0KEuyBwvbOHuEMnuMd5OR+3FaC/3Bbk=;
        b=csam/VcMl4YVcfAK55GD9zy+NOgNd36Enq1HL2+0sW7uAIrpjdd8C4b2LGlBYYBq16
         MdtqC7mFqZdPWLwBoND8KpPpRNxc8vherhEprSYW3n8nNV071T8HPX01RNymseRKWxHC
         9Tm22hUdUF/9q9nekMbPv38InbcNhWrnyjEBqCT1SISG1rWf+ynnZLmnW0B3Iz/6O66D
         GwIcsXn5jXEeutwGmIz8EiunHQS5zOmg3XqNfukaRIbO21RqjLwqss2X/xctl7qFSajZ
         Aik5UjTqI1rxYAxJ7SJ/MjGCWPl7RGymFY+Bc5XSmkCGzS8uWvEgBOhBlkzEicVx6sZD
         gZgw==
X-Gm-Message-State: ACrzQf2LIWW+qYOUvw7L6sKHSKEr2pIxSLX5yBDSm/VuXhWDRNP9wFJq
        rLzQy/cWOefD1ZlOmofiilBAR5WmF4vBwNfg8Js=
X-Google-Smtp-Source: AMsMyM6JRIsyPTRZU227DKpIR8af1+MBEv+L8gNn7R1fQKSeXQ6uzSAqP0t34Q1F0hoopCjQCj+RXnQ5Dr8zSuvc4UU=
X-Received: by 2002:a17:907:ea0:b0:779:6c9d:7355 with SMTP id
 ho32-20020a1709070ea000b007796c9d7355mr14165928ejc.542.1663626479539; Mon, 19
 Sep 2022 15:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220917015852.3833820-1-floridsleeves@gmail.com> <YycYDn82QQZYfpsl@google.com>
In-Reply-To: <YycYDn82QQZYfpsl@google.com>
From:   Li Zhong <floridsleeves@gmail.com>
Date:   Mon, 19 Sep 2022 15:28:11 -0700
Message-ID: <CAMEuxRqpQeQoNsbzFf8ZZ6=SfiZ0LA64yfZ7yv3xjfUGK7vyyw@mail.gmail.com>
Subject: Re: [PATCH v1] kernel/printk: check return value of console_trylock()
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        ccross@android.com, anton@enomsg.org, keescook@chromium.org,
        john.ogness@linutronix.de, rostedt@goodmis.org, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 6:11 AM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/09/16 18:58), Li Zhong wrote:
> > Check the console_trylock() return value in case it fails.
> [..]
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index a1a81fd9889b..2c6a0484315b 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2937,7 +2937,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
> >        * context and we don't want to get preempted while flushing,
> >        * ensure may_schedule is cleared.
> >        */
> > -     console_trylock();
> > +     if (!console_trylock())
> > +             return;
>
> It supposed to be ignored and the comment above (in the code)
> explains why: this is panic flush, we want to proceed regardless.

Thanks for your explanation.
