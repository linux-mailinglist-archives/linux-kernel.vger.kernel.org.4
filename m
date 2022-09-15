Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8835B9EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIOPZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIOPZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:25:27 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B403F33431
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:25:25 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c24so17616309pgg.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=M+4dSp/NyWH6hV7kqgm6uE66wW1DICbY/2tIyHY19E8=;
        b=Ovid8VfwMNGOYz6N1r1dZJJMkvJ0X6Bhyc+U142KKVH3voDv8+Qm2VHut3BgbXGZB1
         52O1STlvMr+Ka20/0qGlvNPNAW9y8f73yINR9lTeMrXJpimLJMh6ZTr/uxEKezNuRXUr
         ulgRgOazPU6dKVBmonQpH9BUUiDterKqWBncg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=M+4dSp/NyWH6hV7kqgm6uE66wW1DICbY/2tIyHY19E8=;
        b=zo1N0Hr+cx//7J04GUjXQ/pRduzWM8eW2mcBX1dO6A5Kr9ggvSk5opLGt4rLUhkfDu
         JlFJjW/62rG+0nL4aNZufSnUC5/TfY5KgNAOwyS0SZKhFc6MJC/f0BAnBCoj5pF13xz1
         +KVkVgFM/PY6RI7SiqZXN7gkLWx8mGdyXBekz6xe3jcM7OMGrsK1TKCHKDyWd52qa+jZ
         rsS8hxX+Sfo9frVzx+WXmr+32XilEAhqdrYxDgVBwbaYzzZi8XN6Pt45tV+w/uD8Ne/o
         X1wULdC5ShoHWWXOWfClElkIZ8u41weE09zmJsfw3yui7b86dk3grpOMLpHiCbQOjvIV
         5irA==
X-Gm-Message-State: ACrzQf1cl7Sra2FBkzG8rN7nZAkRDtn/h6qohsvqCjpbJB91ELGt7EWE
        46OcNbQz03N1ROrMWXMAh1PCcA==
X-Google-Smtp-Source: AMsMyM4hLM83yeJJ1NXBXCQkUnbxF65ZDcgalP0+9AAhGBUxKwD1Er0oxGOSLkn+SBVmRSvCkUvtjw==
X-Received: by 2002:a63:e516:0:b0:434:9462:69cd with SMTP id r22-20020a63e516000000b00434946269cdmr295685pgh.503.1663255525251;
        Thu, 15 Sep 2022 08:25:25 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:91d2:9e21:2c2b:323f])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090322c900b0016ee3d7220esm13300920plg.24.2022.09.15.08.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 08:25:24 -0700 (PDT)
Date:   Fri, 16 Sep 2022 00:25:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        John Kacur <jkacur@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: printk meeting at LPC 2022
Message-ID: <YyND3oI4M/G4qndr@google.com>
References: <20220910221947.171557773@linutronix.de>
 <87h71cr1gb.fsf@jogness.linutronix.de>
 <YyMF6YkGdv/EepJf@google.com>
 <20220915070938.7930c1df@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915070938.7930c1df@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/15 07:09), Steven Rostedt wrote:
> > > We now have a room/timeslot [0] where Thomas and I will be presenting
> > > and discussing this new approach [1] for bringing kthread and atomic
> > > console printing to the kernel.
> > > 
> > > Wednesday, 14 Sep. @ 3:00pm-4:30pm in room "Meeting 9"  
> > 
> > Was this recorded? I glanced through LPC/kernel summit schedules and didn't
> > find it anywhere.
> 
> Yes it was, but it will take a bit to extract it from BBB and upload it to YouTube.

Thanks Steven!
