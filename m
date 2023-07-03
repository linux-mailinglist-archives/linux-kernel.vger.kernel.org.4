Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B274610D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjGCRAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGCRAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:00:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD06E5C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:00:31 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb41682472so7074258e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 10:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688403629; x=1690995629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6cDhx7Op83mZwaIfROLPt5ivMM8kluY7g0YkB9UuxEo=;
        b=OW1/MH6/wSXX9aK+6JyvqoRySuta6+ExwMAG0bMiEOrenO/+n6ftbHC0/YXU+6c0o2
         P04fOxLupZ8RSYin9RLiOoczB9W091rCkKKtIPexe2gC42Cu4MNJIKYYlPp+Px3Pb16c
         t4xUWzWu4DlRRLhoh6n9+fskL8bu+9iidZmig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688403629; x=1690995629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cDhx7Op83mZwaIfROLPt5ivMM8kluY7g0YkB9UuxEo=;
        b=k2cga+n7IjKpeXHdLEYLh+LslIbbIKxrR1jBdvu6FE7QTUA96jtKWu2P0YGa9yQpay
         Kc2eJwYs6JCri41Po9cvbm4jDk/EpzmS6SfRRU8FrA8OuWt+5Le1nBkOONL379yg3LNX
         xbKc/xqJbRnRSgkOwuNaWFWRq8wLDlWOWAI5RZ6uRJOmBwDeEpMlr8C+SIADf9EK+pJY
         XcdOcYEVc5n619vTttyrjFt7m7pa47RXkrqftt83YDvOnhiwsBun9yiaV9BZaADa6RU7
         6LGmF8vRtbTrQDeSLH+VcEUew899AwrZEHKbdWi6hJUFKM78QkaLSHiSlGGx/PHapeSb
         sdaw==
X-Gm-Message-State: ABy/qLaeeiA6VVCr5DSB1UzS1+vQT3FAkC/K/XbepbdG2NMdRwWx7DFY
        Lcjj8k3SFOTpHW8PDnVorLXBt/GD6VXOcubeD8YaTYr+
X-Google-Smtp-Source: APBJJlFDO2oVpoFhYPd9jiMbvf/oWWYeGj5ZaxIa6ywYHsm9UhlD0XacdNJTfZbSR4xIKKwwjh3AtQ==
X-Received: by 2002:a05:6512:3c90:b0:4f8:58d3:b7ab with SMTP id h16-20020a0565123c9000b004f858d3b7abmr10478164lfv.4.1688403629066;
        Mon, 03 Jul 2023 10:00:29 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id x5-20020ac25dc5000000b004f875356ab8sm3215865lfq.153.2023.07.03.10.00.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 10:00:28 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4fb41682472so7074105e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 10:00:28 -0700 (PDT)
X-Received: by 2002:a19:6914:0:b0:4f8:5713:7dd5 with SMTP id
 e20-20020a196914000000b004f857137dd5mr7627264lfc.10.1688403627849; Mon, 03
 Jul 2023 10:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230703114318.1576ea24@rorschach.local.home>
In-Reply-To: <20230703114318.1576ea24@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jul 2023 10:00:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4J3XjdakYiK6yC-QuBuCDn1g4XGNkuaAzByUM4KCCog@mail.gmail.com>
Message-ID: <CAHk-=wg4J3XjdakYiK6yC-QuBuCDn1g4XGNkuaAzByUM4KCCog@mail.gmail.com>
Subject: Re: Buggy rwsem locking code in fs/smb/client/file.c
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ajay Kaher <akaher@vmware.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023 at 08:43, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> And hides the bug by wrapping the down_write() with:
>
> +void
> +cifs_down_write(struct rw_semaphore *sem)
> +{
> +       while (!down_write_trylock(sem))
> +               msleep(10);
> +}

That is indeed disgusting.

It may *work* - because as the commit message says, it means that
writers are now never queued up and thus never block recursive
readers.

And in the process it now becomes absolutely horribly unfair to
writers, who will easily get starved by readers.

This is absolutely not acceptable in any sane situation. Are writers
*so* rare and special that starving them is ok?

Because starvation can be just as deadly as a deadlock. You're just
hiding the problem from lockdep and yourself.

This is very much a "head in the sand" solution.

            Linus
