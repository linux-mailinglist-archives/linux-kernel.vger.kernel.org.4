Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A65E9D63
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiIZJVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiIZJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:21:11 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D152242AC1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:18:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 9so6033629pfz.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MPn6a20lGPjczB73AXADasqkPzFa5QqvxnfB30lgZnI=;
        b=nXTHZo4VhcwYUndpnviY+WdPnUQHhydHnFwHNGsRUgPdFHA3f9I+VL/twlx0ysTtc4
         1XA/3HdmejoO1gfByTU/ohK2Z/L9zIf61aVtVnjuQQ+ac1p8p3uE73f8JFlH04aNsyY8
         MuoyfmaLRRK4SRqblHLfrnbC27P+QlWmfDBEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MPn6a20lGPjczB73AXADasqkPzFa5QqvxnfB30lgZnI=;
        b=a/IGNPgG4PTybwgfC38no6X5lmbYbZlDKDvDaXg4qWEWQzSHOgAoOCJCRX9xwj6ogn
         EZfa5lyWL7ueca2gAbG0H9vqL+bRnnWs2imFYK0q2Q5DGk3hMYfRfxpubQufA6VGOD79
         p/45Aarrj9RCTN5oxfI82HezIDfNObRS+nbSl5mQE4p+v8pYicnxyBhm+gE/YVcs0tCY
         WyZdBJxneXKDzFzVFrEKicb9CnJ1q6fLK1caJkKMIbeu0bY7GNELi+X2z3borUa9leCn
         Rk91c5tTlVkD2Up0Ss1GIlE6+JLM9AhbSUIP54rtKdsOobCFzXt8kO0+oqp211BfQgNF
         DtHg==
X-Gm-Message-State: ACrzQf0OHMFNavXbzEtSTVJ+CuvEbuXk8y8bCzktRbad2M3ipSIIFIVu
        gDX0lCBQu3suyVDYLljzpCoTDg==
X-Google-Smtp-Source: AMsMyM6FSbgFItaI3cf+torU0kBg8x6gcHN0zvvUShnmw6Xu2zce5g4Rc5RylioMGCdZ76bOEeX5QQ==
X-Received: by 2002:aa7:888d:0:b0:538:328b:2ffb with SMTP id z13-20020aa7888d000000b00538328b2ffbmr22809720pfe.82.1664183918481;
        Mon, 26 Sep 2022 02:18:38 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:2a7d:69c:905d:1926])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902684b00b0016ee3d7220esm10853134pln.24.2022.09.26.02.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 02:18:37 -0700 (PDT)
Date:   Mon, 26 Sep 2022 18:18:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 18/18] printk: Handle dropped message smarter
Message-ID: <YzFuaUq352geBXcE@google.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-19-john.ogness@linutronix.de>
 <YzEoYPSC5Qf2aL92@google.com>
 <87leq6d0zn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leq6d0zn.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/26 10:00), John Ogness wrote:
> > Oh, hmm. This does not look to me as a simplification. Quite
> > the opposite, moving cons_text_buf::text pointer to point to
> > cons_text_buf::text - strlen("... dropped messages...") looks
> > somewhat fragile.
> 
> It relies on @ext_text and @text being packed together, which yes, may
> be fragile.

Right, and this assumption can be broken by both internal and external
sources: new gcc/clang plugins, config options, etc.

> As an alternative we could memcpy the message text (@text)
> to the end of the dropped message text. There would be enough room.
> 
> Generally speaking, the dropped text will be less text to copy. But
> since dropped messages are rare anyway, it might be worth copying more
> data so that the code is not fragile. It would also allow us to remove
> the __no_randomize_layout in "struct cons_text_buf".

Agreed.

> If the end of cons_print_dropped was changed to:
> 
>         memcpy(txtbuf->ext_text + len, txtbuf->text, desc->len);
>         desc->len += len;
>         desc->outbuf = txtbuf->ext_text;
> 
> Would that be OK for you?

Yes, this looks solid (nothing should be able to break it and cause
mem corruptions).
