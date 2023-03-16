Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CB96BD89A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCPTHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCPTHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:07:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471FB61A2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6BD4B81FF4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 19:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C55C433EF;
        Thu, 16 Mar 2023 19:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678993617;
        bh=+1iWOJJvKQaOCGDrM8KIl0MP3gyyo/hPqI3ia6zDois=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w8nAOY1bh/PtKxoDu08AFMDtM7jdSIXIt7o4IzszLAlZAu0+G8Rp6R7EG/Bn/oHUA
         TNzomEWjX0kFk+3uV5KyqddWpCp/BmGYhj9aWhsZVB0Gi663/U4zqmNSeXiS/j8ZN8
         /Mr+wPBV0rjnP9nRE/1JvmnwG5JrNrEDYU8hKRMY=
Date:   Thu, 16 Mar 2023 20:06:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] staging: axis-fifo: initialize timeouts in init only
Message-ID: <ZBNoz/mICC77n+0O@kroah.com>
References: <ZBNDJwFHE3vIFS3+@khadija-virtual-machine>
 <2552330.Lt9SDvczpP@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2552330.Lt9SDvczpP@suse>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 07:11:09PM +0100, Fabio M. De Francesco wrote:
> On giovedì 16 marzo 2023 17:26:15 CET Khadija Kamran wrote:
> > Initialize the module parameters, read_timeout and write_timeout once in
> > init().
> > 
> > Module parameters can only be set once and cannot be modified later, so we
> > don't need to evaluate them again when passing the parameters to
> > wait_event_interruptible_timeout().
> > 
> > Convert datatype of {read,write}_timeout from 'int' to 'long int' because
> > implicit conversion of 'long int' to 'int' in statement
> > '{read,write}_timeout = MAX_SCHEDULE_TIMEOUT' results in an overflow.
> > 
> > Change format specifier for {read,write}_timeout from %i to %li.
> 
> It's good that you added this line. I had missed it :-)
> 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> > 
> > Changes in v6:
> >  - Initialize module parameters in init instead of probe function.
> >  - Change the subject and description
> >  - Change format specifiers of module parameters to "%li"
> > 
> > Changes in v5:
> >  - Convert module parameters's datatype from int to long.
> 
> NIT: "parameters'", not "parameters's".
> 
> >  - Link to patch:
> >  https://lore.kernel.org/outreachy/ZBMR4s8xyHGqMm72@khadija-virtual-machine/
> > 
> > Changes in v4:
> >  - Initialize timeouts once as suggested by Greg; this automatically
> >    fixes the indentation problems.
> >  - Change the subject and description.
> >  - Link to patch:
> >  https://lore.kernel.org/outreachy/ZA4M3+ZeB1Rl2fbs@khadija-virtual-machine/
> > 
> > Changes in v3:
> >  - Correct grammatical mistakes
> >  - Do not change the second argument's indentation in split lines
> > 
> > Changes in v2:
> >  - Instead of matching alignment to open parenthesis, align second and
> >    the last argument.
> >  - Change the subject and use imperative language.
> >  - Link to patch:
> >  https://lore.kernel.org/outreachy/ZAxNYw2rFQkrdtKl@khadija-virtual-machine/
> > 
> > Link to first patch:
> >  https://lore.kernel.org/outreachy/ZAZSmPpB6fcozGa4@khadija-virtual-machine/
> > 
> > drivers/staging/axis-fifo/axis-fifo.c | 28 ++++++++++++++++-----------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/staging/axis-fifo/axis-fifo.c
> > b/drivers/staging/axis-fifo/axis-fifo.c index dfd2b357f484..0a85ea667a1b
> > 100644
> > --- a/drivers/staging/axis-fifo/axis-fifo.c
> > +++ b/drivers/staging/axis-fifo/axis-fifo.c
> > @@ -103,17 +103,17 @@
> >   *           globals
> >   * ----------------------------
> >   */
> > -static int read_timeout = 1000; /* ms to wait before read() times out */
> > -static int write_timeout = 1000; /* ms to wait before write() times out */
> > +static long read_timeout = 1000; /* ms to wait before read() times out */
> > +static long write_timeout = 1000; /* ms to wait before write() times out */
> > 
> >  /* ----------------------------
> >   * module command-line arguments
> >   * ----------------------------
> >   */
> > 
> > -module_param(read_timeout, int, 0444);
> > +module_param(read_timeout, long, 0444);
> >  MODULE_PARM_DESC(read_timeout, "ms to wait before blocking read() timing 
> out;
> > set to -1 for no timeout"); -module_param(write_timeout, int, 0444);
> > +module_param(write_timeout, long, 0444);
> >  MODULE_PARM_DESC(write_timeout, "ms to wait before blocking write() timing
> > out; set to -1 for no timeout");
> > 
> >  /* ----------------------------
> > @@ -384,9 +384,7 @@ static ssize_t axis_fifo_read(struct file *f, char 
> __user
> > *buf, mutex_lock(&fifo->read_lock);
> >  		ret = wait_event_interruptible_timeout(fifo->read_queue,
> >  			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> > -				 (read_timeout >= 0) ?
> > -				  msecs_to_jiffies(read_timeout) :
> > -				  MAX_SCHEDULE_TIMEOUT);
> > +			read_timeout);
> > 
> >  		if (ret <= 0) {
> >  			if (ret == 0) {
> > @@ -528,9 +526,7 @@ static ssize_t axis_fifo_write(struct file *f, const 
> char
> > __user *buf, ret = wait_event_interruptible_timeout(fifo->write_queue,
> >  			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
> > 
> >  				 >= words_to_write,
> 
> NIT: I don't really like this split of the second argument into two lines. 
> This line may look too long, but I don't think that it should be split. I 
> prefer to read 
> 
> "ioread32(fifo->base_addr + XLLF_TDFV_OFFSET) >= words_to_write,"
> 
> However, the final decision is up to Greg.

That's not the change that is happening here, so it can be done in a
follow-on patch if you so desire.

> If he takes the code as is, I have nothing against. 
> Don't send any other version unless required by Greg or other Mentors with 
> more experience than I have.
> 
> All the rest look good... well done!
> 
> Reviewed-by: Fabio M. De Francesco

This will not work, sorry, please respond with a correct tag (hint, you
forgot your email...)

thanks,

greg k-h
