Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43656FDB27
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbjEJJzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbjEJJy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:54:57 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D26659D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 02:54:55 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3767A3F4D8
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683712493;
        bh=BJjlqCchOr90XV+R3svQiAsGeT9XzzKbGjpyD2zoyFc=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=JHW6RbT8wyO9AyICmokp61qma3cgSO9umMnEXV979h14EDJxHg3/zSZGME8mJg715
         0PQJ5wSuyg6XfXa19NR8QAnhdMXyp3/X/MQMQr2MyQ2sYrkIg4F6yr/75kBS4qMQj4
         4JVr6dAv4imeUNP1+SXQYiKysDQMFyvQxEOyVfSvgN7e7tmecDb+idFyTc5L4io7JC
         H0HYn4x1Vgo/lfEzHIHtqoDg6u9gAjP8+ze40TLCtyZC/rpijG1Ou9gPw3gkyUYwwh
         BSlUM9hTN5/N2TAJB3nMrmZ8zJYYJuA5BnPRCS9md1wHskiEmNPZivUH26VlHoPLCk
         loC3TN12fDEGQ==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-50bffc723c5so6643083a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 02:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683712492; x=1686304492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJjlqCchOr90XV+R3svQiAsGeT9XzzKbGjpyD2zoyFc=;
        b=IMs2wRskWqlQbXGhpgNHZLvympqOrcFC7+nnZt6sTJui51BL6Hr3jfLcUpKznb5jdy
         QNntgwYKa1ruRCgdKeIg/NdVokHyrQcssGEQZqgDXckvBk+qyT2CTrb+4yUWUmwIR4Wx
         pIszptobb3Ipq6VgUVgy7WlHMbLby2s8Dx3gbSAw9lJSQRP7T0WZhe3VbZRo4eufDkfS
         rGyE8cpJI0ZLmzNt00DlPmpxsZgd1VcynG6/F/fAIpy3IyZbgXghNPSY59dQzaCoWkiT
         mIESAEXrZhRHb4gDkYAEmqEUMk8SW9UnYjmWXLL6TdY3Jh+FXrvD9ELjSGmVu0Fehe0J
         qBxA==
X-Gm-Message-State: AC+VfDxPb6PmMXtPfH9IiWzEVPJmghqdZGK/hCsHewFrl799cHwaGBq8
        TsndzU3aDIYeXDU1i0FP7ogYsQN0dHL+AdFKP1VSg3EH1ocF2vLW5RH8W4/1V+Y3zyNVVS3Ipya
        hqGNcszaWd4BhbjLLM5EjZe+alkjLs5Qkr3E2V858Vw==
X-Received: by 2002:aa7:c7da:0:b0:50b:5211:446f with SMTP id o26-20020aa7c7da000000b0050b5211446fmr12079080eds.6.1683712492448;
        Wed, 10 May 2023 02:54:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7GQB/rM1QJ7LE5/OGTXBSHHyF39/goNARW0LlJbqBeKAPskBIKo5vw5B66r6VL5CnOY8Gr2g==
X-Received: by 2002:aa7:c7da:0:b0:50b:5211:446f with SMTP id o26-20020aa7c7da000000b0050b5211446fmr12079060eds.6.1683712492125;
        Wed, 10 May 2023 02:54:52 -0700 (PDT)
Received: from localhost (host-82-55-56-52.retail.telecomitalia.it. [82.55.56.52])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7cfd0000000b0050bd245d39esm1744797edy.6.2023.05.10.02.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 02:54:51 -0700 (PDT)
Date:   Wed, 10 May 2023 11:54:51 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] timers/nohz: introduce nohz_full_aggressive
Message-ID: <ZFtp67nW5op5q/0x@righiandr-XPS-13-7390>
References: <20230507090700.18470-1-andrea.righi@canonical.com>
 <20230507100852.54a354ca@rorschach.local.home>
 <ZFe1IY+TdzSC0RLZ@righiandr-XPS-13-7390>
 <2161b8c0-b08c-7bf7-4c99-3bb89ca44ad8@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2161b8c0-b08c-7bf7-4c99-3bb89ca44ad8@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:03:07AM +0200, Anna-Maria Behnsen wrote:
> On Sun, 7 May 2023, Andrea Righi wrote:
> 
> > On Sun, May 07, 2023 at 10:08:52AM -0400, Steven Rostedt wrote:
> > > 
> > > [ Added Anna-Maria who is doing some timer work as well ]
> > > 
> > > On Sun,  7 May 2023 11:07:00 +0200
> > > Andrea Righi <andrea.righi@canonical.com> wrote:
> > > 
> > > Now, I think what is really happening here is that you are somewhat
> > > simulating the results that Anna-Maria has indirectly. That is, you
> > > just prevent an idle CPU from waking up to handle interrupts when not
> > > needed.
> > > 
> > > Anna-Maria,
> > > 
> > > Do you have some patches that Andrea could test with?
> > > 
> > > Thanks,
> > > 
> > > -- Steve
> > 
> > Thanks for looking at this (and I'm happy to help Anna-Maria with any
> > test).
> 
> I posted v6 of the queue - but forgot to add you to cc list. Here is the
> current version:
> 
>   https://lore.kernel.org/lkml/20230510072817.116056-1-anna-maria@linutronix.de/
> 
> I have to mention, that there is still the issue with the fair scheduler
> which wakes up the CPU where the process_timeout() timer was enqueued,
> because it assumes that context is still cache hot.
> 
> Thanks,
> 
> 	Anna-Maria

OK, will take a look, thanks!

-Andrea
