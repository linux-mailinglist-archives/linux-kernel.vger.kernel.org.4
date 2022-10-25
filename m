Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EC060C0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiJYBPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiJYBPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:15:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2009852826
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:33:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ot12so8848931ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SwjrQKeWuL/UTLvlOb5w0Oe0RoidZXir5S4vG79BLUw=;
        b=YZugDW7tObAfGv7/nl7dpBqM1o0NuLh7r/vtflD7JeJ1NM5xmB+ff2CqU4zkDJSYNk
         6JMgIHIw0iVHvEW4jiJj00OGLmvSa6ZQurr+pmhK/mlshehc8TpxfKJ4Jr+zQgQE0wKm
         MICKDbypklPHTCv8GzN6dFChYHG/NDT3w22XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwjrQKeWuL/UTLvlOb5w0Oe0RoidZXir5S4vG79BLUw=;
        b=PVcHYGf3V+WCPW+t/XskM+9r9QXpczd/ENd679YjNv1SSybtoEEVOdOgZXKtf6EdGN
         ItWAvOW3/TFMVtrYv9pjqX9yru8EA6PYSZvTgipsrMAN7QtWuIbuFrnHqQtmrMBWugmG
         0VbfokC5lzgc2y8hl5yi3c9++mowbChFTLiDqaC39HYRuA/oJ8OMvR8ZgJ4LTl3yPJ+W
         hzM5TM/GCLe30xVCZKrY1wJBTYQTNdOctcNRlUcMJN38uAK0NQ1u5VeiN9Y0L0U5rtDH
         46Ed5hKKX+qGN0GW3OqkMYVZGuaiGCOwzNaxKFTIm/8HmIsPgEYF1hMSPdTqIQSHYOFX
         4Xwg==
X-Gm-Message-State: ACrzQf12TJH7OYYXDKf7EIdPtYYfZDIykNUQE3H57kzdIHacKMi7pAiF
        D0OMbCBE5T6+zYBuu1OO3FDysXhWhrV7D+4g
X-Google-Smtp-Source: AMsMyM4D7dHv0ey5wRkDHF/7g1SOUHdUuRI1ACQHKai52KgmDloFzP4Fj/n4/e0z4XW44IrpJ1tQsw==
X-Received: by 2002:a17:907:75d2:b0:7a0:72b8:236a with SMTP id jl18-20020a17090775d200b007a072b8236amr13031721ejc.47.1666658009417;
        Mon, 24 Oct 2022 17:33:29 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id gs18-20020a170906f19200b0073ddff7e432sm575836ejb.14.2022.10.24.17.33.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:33:28 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id bp11so17926719wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:33:28 -0700 (PDT)
X-Received: by 2002:a5d:51cb:0:b0:236:6a62:4bc8 with SMTP id
 n11-20020a5d51cb000000b002366a624bc8mr7153865wrv.583.1666658008254; Mon, 24
 Oct 2022 17:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-22-john.ogness@linutronix.de> <Y1K2JP6LIf8H2Ub5@alley>
In-Reply-To: <Y1K2JP6LIf8H2Ub5@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Oct 2022 17:33:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VfgdY9qabAzOxu4Rs5UjCRCHMMh=zidX3oq25_tuQD-w@mail.gmail.com>
Message-ID: <CAD=FV=VfgdY9qabAzOxu4Rs5UjCRCHMMh=zidX3oq25_tuQD-w@mail.gmail.com>
Subject: Re: [PATCH printk v2 21/38] serial: kgdboc: use srcu console list iterator
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 21, 2022 at 8:09 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Wed 2022-10-19 17:01:43, John Ogness wrote:
> > Use srcu console list iteration for safe console list traversal.
> >
> > Note that configure_kgdboc() still requires the console_lock in
> > order to ensure that no console is in its write() callback when
> > its direct() callback is called. Add comments to clarify this.
>
> s/direct()/device()/
>
> Do you know about such requirements or is it just
> a conservative approach, please?
>
> I ask because the comment in the code says "may assume".
>
>
> Anyway, this would deserve a comment why the SRCU list iteration is
> needed even when console_lock() is needed as well.
>
> The reason is that further patches are going to synchronize
> console_list manipulation with another lock and console_lock()
> will be used only to serialize accessing con->write() callbacks.

I had the same concern. I'll note that at the end of the series the
documentation for console_lock() still says:

 * Acquires a lock which guarantees that the caller has
 * exclusive access to the console system.

That seems to imply (at least to me) that if you're holding
console_lock() there's no need to hold the SRCU lock.

-Doug
