Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248EA5B993C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiIOLBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiIOLBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:01:08 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9469875C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:01:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so22002711pjm.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=iICjEN+A8kBol5PgEatcRbO30m2IBFRwWu1Tkq5B7ZA=;
        b=dvpB9Vth3a+jEVh0cliDbcsM2qbvuxq5l7XPK+w4Tub7nhdoeZRqykz0bDKLx3jlJY
         tvPwVDEDWJYLUX4zAcNH2j6XUEhKx6JtOS9er43MU8oWRp83sRKdbwVuvTn8Ish1VQRr
         n0/KGMPBd6YAwqRD/bTMQ28WeIsGS03N4MJGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=iICjEN+A8kBol5PgEatcRbO30m2IBFRwWu1Tkq5B7ZA=;
        b=nf2S9X4IHkuycU1tD8Wx3EWiRS7Rt0T7tBvKo1TsP1glboByxi37Bt21q/XFnL2sSa
         +jpIn7uDI3UqFJOiWNYjxSZX4ocnew0iZI7+9b56iq6TBwJPQ+SVQsSne+xuZpaM6HUz
         6Mb/HJPMg+u7Qa2Y8ck0TOad9MFqWlXacbHzj+YKdXJZp6Uo34JaHgakjaQ+TPkupcDS
         jzj3fle/MEmCK0hP5kFJWcG7IypN4DDGpug95YJGJE1Ho/KP9dezWZbpO6VqCHKLtjaZ
         jkPiaKg6mIE+d6nxMSnp6LOhGcq2+gEnywzOZzW3QbVyXDHatOveb+DGM6F27gw6tGJ/
         3IaQ==
X-Gm-Message-State: ACrzQf0c0cLYoxt85gl8QT0InbIDVwuaN9PuaiGrByJU95PtgjKQ9kQV
        TnjQV4TwsmV3NUCGKDAYRClsAg==
X-Google-Smtp-Source: AMsMyM5PCU7HXmaUWLPe6NfiWW6aVcPUIPahnYioiElCsxIg1xVPvYqr9HhqbqlIKOMIoqZaL91tAw==
X-Received: by 2002:a17:902:e84c:b0:178:2a08:501c with SMTP id t12-20020a170902e84c00b001782a08501cmr3760240plg.110.1663239664230;
        Thu, 15 Sep 2022 04:01:04 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:91d2:9e21:2c2b:323f])
        by smtp.gmail.com with ESMTPSA id w73-20020a62824c000000b0053e940d360csm12025356pfd.58.2022.09.15.04.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 04:01:03 -0700 (PDT)
Date:   Thu, 15 Sep 2022 20:00:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <YyMF6YkGdv/EepJf@google.com>
References: <20220910221947.171557773@linutronix.de>
 <87h71cr1gb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h71cr1gb.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (22/09/12 18:46), John Ogness wrote:
> Hi,
> 
> We now have a room/timeslot [0] where Thomas and I will be presenting
> and discussing this new approach [1] for bringing kthread and atomic
> console printing to the kernel.
> 
> Wednesday, 14 Sep. @ 3:00pm-4:30pm in room "Meeting 9"

Was this recorded? I glanced through LPC/kernel summit schedules and didn't
find it anywhere.
