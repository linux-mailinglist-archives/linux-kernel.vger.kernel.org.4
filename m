Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054E36B2304
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCILa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCILa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:30:26 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91B0CDEF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:30:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id da10so5667326edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 03:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678361423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLSYBu7ENu/iqBo4/duVdnjboh/ioAkNKuem/I0F9jE=;
        b=dIJZiBccBfhqw/cVnHpviV8WzVM6jCZbvhYKLN/A8Az47IQMPEWSb0KIX02sPQpIuC
         PtOChknGVSmGautnIv9ljV+x8HTrK1j0OXHtHlSjREHgRM0W6zVbPSGLjLj2Wj9ewzw7
         9vlMO/xoM+OgvNCOv9h7Zg6shtnRUmMzB/5a24HtcJ3Gry4yEml8Oj9wEFrRXocVicrh
         mWVCcA1xy25S6i9dAs9UG8nEPuak3MJ9odcSZcNUWuKu0WJWUmha/kpKStK68SDEaHdy
         SMc/epDNd0ukjZPaC071iOqzsH+nS5gRfLXsh+BnQ5nCGm/790c9O93aw9ljl1p9V+5b
         L7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678361423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLSYBu7ENu/iqBo4/duVdnjboh/ioAkNKuem/I0F9jE=;
        b=kO4EVpK0nfAJVJdEbTXEYzcymlWILo9IX8rHPlPPwODjvJUiuqHn6x7ko/7bhDS7gT
         g5MwUlk55yIyrCAyHA8HW5T0FCyffZUsUQ/E1b9SJaLJf63uVIol1mhPhaZcX+KP4I+4
         CH4DTxW96jfyUj+urDLPkNPxOstLWJQC5vKxqMNJvw4dBY6fj9tfodWd+sTnDtCiPI9k
         Mn/kNxeKYIleg80hC2jTs/PQ4JD1/xCd8FX/CMTnOBQc2lUXbiS4J+cgWPPeXExgBVuT
         XPH5yvfMJ0zIqINNrKJT1rhITC1Vf37ixGgW+OgxgFZJaWzZeLWvIj4IBdLGcf53Qm2N
         /M3A==
X-Gm-Message-State: AO0yUKXpy7+vyxuLxnvC/ebYiNyT/hX/ING3IdUdDxxh4yxRNBIvBUNa
        3uGVduD/qe8ovSYipSFR5l4ibA==
X-Google-Smtp-Source: AK7set9FdwRWO7tWwWvc0AAD0ohk+wLhwlAGK/c8n+w7TnRlfcirm+4MobcRi7vokXL4IypyCINobQ==
X-Received: by 2002:aa7:ca54:0:b0:4ab:4569:4b9f with SMTP id j20-20020aa7ca54000000b004ab45694b9fmr20403988edt.0.1678361423229;
        Thu, 09 Mar 2023 03:30:23 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id i18-20020a50d752000000b004accf3a63cbsm9399632edj.68.2023.03.09.03.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 03:30:22 -0800 (PST)
Date:   Thu, 9 Mar 2023 11:30:20 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v1 01/18] kdb: do not assume write() callback
 available
Message-ID: <20230309113020.GA78621@aspen.lan>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-2-john.ogness@linutronix.de>
 <20230309105240.GA83039@aspen.lan>
 <ZAnCXxui+QiNNRb6@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAnCXxui+QiNNRb6@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 12:26:23PM +0100, Petr Mladek wrote:
> On Thu 2023-03-09 10:52:40, Daniel Thompson wrote:
> > On Thu, Mar 02, 2023 at 09:02:01PM +0106, John Ogness wrote:
> > > It is allowed for consoles to provide no write() callback. For
> > > example ttynull does this.
> > >
> > > Check if a write() callback is available before using it.
> > >
> > > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> >
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> >
> > Any thoughts on best way to land the series. All via one tree or can
> > we pick and mix?
>
> I would prefer to take everything via the printk tree because
> most changes are there. Otherwise, we might end up with non-necessary
> cross-tree merge conflicts. Also I would know when all pieces are
> there.
>
> That said, this seems to be the only change in
> kernel/debug/kdb/kdb_io.c and it is relatively independent.
> So, it should not be a big problem to take it separately.

Enthusiastically
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

That suits me fine: kgdb is pretty quiet at the moment so, whilst I
can't predict what patches will show up this cycle, this probably spares
me from having to put together a PR for a single patch!


Daniel.
