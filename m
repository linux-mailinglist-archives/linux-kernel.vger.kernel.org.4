Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA455ED966
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiI1Jq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiI1Jqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:46:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C497B0C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:46:48 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so1545520pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/yZhQPLRoOB6Baar4RdCbGBqXHnPQnUNWE0ihB3eDb0=;
        b=cmDu50QFMZzWZBo+w7l4ylCm6/O+6n/mk5ubUDLUuFpj0623cTqaTjW6weXqGeOr73
         ZPU+jVRvBBSlMmtTTf7iuJRmFMLKCE1is7cQwqZCth5yz/TlDYU5KeCixpfqIZDDCqPa
         Do718Uq/dYcuJWLAYoEOJklzKs7lbDpnI/aP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/yZhQPLRoOB6Baar4RdCbGBqXHnPQnUNWE0ihB3eDb0=;
        b=k26c8X2unTe4IUExCg50CAXOf3n5Qw1n39dD1S/TOT5C+U3q2XyON+POvsq1Pn7hoV
         XGRQKia4QLmx4J5rnDLCVs4HzfCsVGuwvA4UkRrqzyzTWB5mrmLUc4XKqYJ9d/3RqdjL
         54uDNAcUlQXYmzkAyO/Molby+MSrFOs3Qt8QNRPO8FehbtQc2/kFAAVfXiVPVmfFUzGZ
         PX1dOLJpOnJ36uQf8c2pIo21PvG21s44Uw1e+NYuxCuSAy96hvdEnJ2uxRD50nmNylz0
         Kr9UlFQA+EJYnv7tj/UAT+RteZh0xDOQoBgD5zbRmvkL7LtCCJdDKD4C85g+4I4JRadC
         sYVg==
X-Gm-Message-State: ACrzQf3HP/sGhemcUAZySksTibxyVRiAHjW97jHH5YvtN/uyAQGuFYx3
        SuxX4IlZptBzJOLqZ1zQDAr1LA==
X-Google-Smtp-Source: AMsMyM6nrZxa/mrrwduRLYUWIo9Pp2JgRWOt8f765hEPZ/W2vRtskcnuWI/qEa19tJyumaGYFAe8jA==
X-Received: by 2002:a17:902:d4ce:b0:177:fe49:19d2 with SMTP id o14-20020a170902d4ce00b00177fe4919d2mr31779922plg.4.1664358407636;
        Wed, 28 Sep 2022 02:46:47 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:d8e5:5ceb:cc0c:18ad])
        by smtp.gmail.com with ESMTPSA id lx7-20020a17090b4b0700b0020263b7177csm6784198pjb.3.2022.09.28.02.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:46:47 -0700 (PDT)
Date:   Wed, 28 Sep 2022 18:46:42 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 06/18] printk: Protect [un]register_console() with
 a mutex
Message-ID: <YzQYArVKyyxxidxn@google.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-7-john.ogness@linutronix.de>
 <YzMT27FVllY3u05k@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzMT27FVllY3u05k@alley>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/27 17:16), Petr Mladek wrote:
[..]
> > +static int console_unregister_locked(struct console *console);
> > +
> >  /*
> >   * The console driver calls this routine during kernel initialization
> >   * to register the console printing procedure with printk() and to
> > @@ -3107,13 +3148,14 @@ void register_console(struct console *newcon)
> >  	bool realcon_enabled = false;
> >  	int err;
> >  
> > -	for_each_console(con) {
> > +	console_list_lock();
> 
> Hmm, the new mutex is really nasty. It has very strange semantic.
> It makes the locking even more complicated.

[..]

I fully agree with everything you said. This lock nesting made me
scratch my head wondering was it previous CPU hotplug code that had
multiple nested locks or was it something else?

> Anyway, I would like to avoid adding console_mutex. From my POV,
> it is a hack that complicates the code. Taking console_lock()
> should be enough. Using rcu walk would be good enough.
> 
> Do I miss something, please?
> 
> Or is this part of some strategy to remove console_sem later, please?

So I can only explain what potential I saw in list lock: the idea
that third party that iterates over consoles lists does not stop
entire console output machinery, and, moreover, that third party
does not flush pending messages once it's done with the business
it had to do under console_sem. E.g. it can be a systemd or any
other user-space process doing something with /dev/tty, which can
suddenly stop all consoles output (console_lock()) and then also
has to flush pending kernel messages (console_unlock()). Was this
goal, however, fully achieved - no, a third party that wants to
->flags &= ~CON_ENABLED a particular console still stops the entire
console output (and flushes pending messages, unless handover-ed).

I like what you suggested with srcu.
