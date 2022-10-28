Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81648611E24
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJ1X3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJ1X3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:29:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD63FD37;
        Fri, 28 Oct 2022 16:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAF4962AF5;
        Fri, 28 Oct 2022 23:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDC3C433C1;
        Fri, 28 Oct 2022 23:29:34 +0000 (UTC)
Date:   Fri, 28 Oct 2022 19:29:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-usb@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [RFC][PATCH v2 20/31] timers: usb: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221028192950.1348c620@gandalf.local.home>
In-Reply-To: <6107f2b1-fcd2-918b-328d-401cc22710be@roeck-us.net>
References: <20221027150525.753064657@goodmis.org>
        <20221027150928.983388020@goodmis.org>
        <4e61935b-b06b-1f2d-6c2b-79bdfd569cd6@roeck-us.net>
        <20221028140129.040d9acc@gandalf.local.home>
        <20221028141007.05f5c490@gandalf.local.home>
        <20221028195959.GA1073367@roeck-us.net>
        <20221028164024.2ab39cc1@gandalf.local.home>
        <6107f2b1-fcd2-918b-328d-401cc22710be@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 16:25:32 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 10/28/22 13:40, Steven Rostedt wrote:
> > On Fri, 28 Oct 2022 12:59:59 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:  
> >>
> >> I'll test again with the following changes on top of your published
> >> patch series. I hope this is the current status, but I may have lost
> >> something.
> >>
> >> Looking into it ... deactivate_timer() doesn't do anything
> >> and seems wrong. Did I miss something ?  
> > 
> > You mean debug_deactivate_timer() or debug_deactivate?
> >   
> 
> This:
> 
> +static void deactivate_timer(struct work_struct *work, bool is_dwork)
> +{
> +       struct delayed_work *dwork;
> +
> +       if (!is_dwork)
> +               return;
> +
> +       dwork = to_delayed_work(work);
> +}

Oh, that was part of my trying to figure out WTF delayed work was doing
with its timers. You can delete it's existence.

Thanks (and I'll go remove it from my tree).

-- Steve

