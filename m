Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BE674F46F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjGKQII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjGKQIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:08:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459DA12F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:08:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b89d47ffb6so29807415ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689091684; x=1691683684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SKXcA0SybtEcZr7Re110CanuIvW8wybz2wN0UXPhcI8=;
        b=k7nHBaEIeGw54IxxyXsoyojRuFJNHzvfk6Rp5splYUo1Bvs133pEU5Bgz3/Ky/fVyE
         uzqf7K1f/Sxr86nRsurg7naQubOcQq2S54OSposfsaUiBk6CyKADKwtwptuwiuo/RWbe
         gu9Fn7/r2/UwNNURgOy5MZbDE0GgX1+KmiXHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689091684; x=1691683684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKXcA0SybtEcZr7Re110CanuIvW8wybz2wN0UXPhcI8=;
        b=OYMWmlng+9Ei05Q8pLSjhrBBAkRjO3BO4dttEFkrWbP9U9tC38lRaoXt31xGcDbbnt
         n32FhikNAeaAWoUXNAHGQ+5ldqdveG670qoyAMdwDZ9r2stJ1mS2WdLwvtKUTaqR7xhb
         GYud5Bcxlu9kAu6lA4feNN6Ehq5QTeoy0l/96IkfcCOUhIpGL+7752N2EfJxXd8xyS5Z
         dmtdn9szXz8Gz6fSdGwiKtghXF6FvLf2KmGVDnUS85EEzG1343zuW6qrPWKOIwlDfY47
         EC9esqb43Qd48vWFODr4uZttDPQkxCZ5iWMSdxAOIrUGoHKZzBSGKD17l+qQ9s2JBaFo
         vl9A==
X-Gm-Message-State: ABy/qLZjp8WSf5R9/6rHDX0I/yq96FmMoebV8PoFj8nR/9C2E87U5kO3
        useMs/2m3CB3GCYlcA/ZpX1h+A==
X-Google-Smtp-Source: APBJJlHfVgcb+xdoXHrO+lJUgF0zuqamPyMz67eJIrJxcEUeMsc5+/yVSGhGMGiigi+kzkY7JmWa0A==
X-Received: by 2002:a17:903:18e:b0:1b3:7de7:f83f with SMTP id z14-20020a170903018e00b001b37de7f83fmr14992315plg.26.1689091683711;
        Tue, 11 Jul 2023 09:08:03 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001b9be2e2b3esm2073939plq.277.2023.07.11.09.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:08:03 -0700 (PDT)
Date:   Wed, 12 Jul 2023 01:07:58 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 2/5] printk: Add NMI safety to
 console_flush_on_panic() and console_unblank()
Message-ID: <20230711160758.GG12154@google.com>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-3-john.ogness@linutronix.de>
 <ZK14p-ocWuuHkSAQ@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK14p-ocWuuHkSAQ@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/11 17:43), Petr Mladek wrote:
> On Mon 2023-07-10 15:51:21, John Ogness wrote:
> > The printk path is NMI safe because it only adds content to the
> > buffer and then triggers the delayed output via irq_work. If the
> > console is flushed or unblanked on panic (from NMI context) then it
> > can deadlock in down_trylock_console_sem() because the semaphore is
> > not NMI safe.
> 
> <thinking loudly>
> 
> Just to be sure. The semaphore is not NMI safe because even the
> trylock takes an internal spin lock. Am I right, please?
> 
> Alternative solution would be to make down_trylock() NMI safe
> by using raw_spin_trylock_irqsave() for the internal lock.
> 
> But this actually would not solve the whole problem. If the NMI safe
> down_trylock() succeeded then up() would need to be called
> in NMI as well. And up() really needs to take the spin lock
> which might get blocked in the meantime.

I guess another problem with up() is that it also may call
try_to_wake_up(), that may attempt to acquire a bunch of other
spin_lock-s.
