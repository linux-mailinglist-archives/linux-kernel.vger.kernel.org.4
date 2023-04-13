Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65B36E0E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjDMN3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDMN3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:29:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF3A4683
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:28:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D2BED1F383;
        Thu, 13 Apr 2023 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681392519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJ+5SV+u+7p9Kyarz4Swyo5vf54KL6o/U/RSgcke/QI=;
        b=S95RId8D9Az/W89VwnDsgiokXFpBWWLIsysKHJ+ift9cxYeRzwRAP9iPucg/0hdpuVsXf7
        62XO97acs+1ETWokxU970cXK5yUgDGLrPXsIhgWFETM9KnT8eJF14dEgOLYl1m2FNx8suE
        sci9jYFE3EHu6GyHsQeNnRBFTWaUzVc=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A10312C15B;
        Thu, 13 Apr 2023 13:28:38 +0000 (UTC)
Date:   Thu, 13 Apr 2023 15:28:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: (k)thread: was: Re: [PATCH printk v1 11/18] printk: nobkl: Introduce
 printer threads
Message-ID: <ZDgDhrnBJ3vSbxy8@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-12-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:11, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add the infrastructure to create a printer thread per console along
> with the required thread function, which is takeover/handover aware.
> 

Nit:

Several variable and function name use "thread"

  + con.thread_pbufs
  + con.write_thread()
  + printk_threads_enabled

and many others use "kthread":

  + con.kthread
  + con.kthread_waiting
  + cons_kthread_wake()
  + cons_kthread_create()
  + cons_kthread_should_wakeup()

I do not see any pattern. It would be nice to choose just one variant
for the cons/printk API. I slightly prefer "kthread" but "thread"
would be fine as well.

When we are on the (k)thread naming stuff. We talk about it
historically as a printk (k)thread. But I often feels that it
rather should be a console (k)thread, especially when we have
one per console.

That said, both variants make sense. The thread is used for showing
messages from the printk ring buffer.

Best Regards,
Petr
