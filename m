Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C614622F0C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiKIP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiKIP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:27:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3181EEE5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:27:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ED10F22A0E;
        Wed,  9 Nov 2022 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668007664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V1+Ulj90x4+D/oPVdeVQI6aglYv6ToQZfDYujvKSNLQ=;
        b=uD+6JYMINwOV2Vm5q0jNPmVCJfHu73njXxbn3VTkihNixa9TCw4tv5hVaIxKroOZTEf08c
        hBJ5Dyi0OlaIjplZmjXckAWIBC8mzfoYe/USosGmfTzAhf94VRgyj7Ozn81iLrtSdlPbnd
        gRmV+f8jN/L+0CPr84wtM+80KHmDm6I=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A987C2C141;
        Wed,  9 Nov 2022 15:27:44 +0000 (UTC)
Date:   Wed, 9 Nov 2022 16:27:44 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v3 15/40] kdb: use srcu console list iterator
Message-ID: <Y2vG8KZXBiw2TDLl@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-16-john.ogness@linutronix.de>
 <20221109085325.wiub564iqnewvczb@ash.lan>
 <87wn848okk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn848okk.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-11-09 10:33:55, John Ogness wrote:
> Hi Daniel,
> 
> On 2022-11-09, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> >> +	/*
> >> +	 * The console_srcu_read_lock() only provides safe console list
> >> +	 * traversal. The use of the ->write() callback relies on all other
> >> +	 * CPUs being stopped at the moment and console drivers being able to
> >> +	 * handle reentrance when @oops_in_progress is set. (Note that there
> >> +	 * is no guarantee for either criteria.)
> >> +	 */
> >
> > The debugger entry protocol does ensure that other CPUs are either
> > stopped or unresponsive. In the case where the other CPU is unresponsive
> > (e.g. timed out after being asked to stop) then there is a "real" printk()
> > issued prior to any of the above interference with the console system to
> > the developer driving the debugger gets as much clue as we can offer them
> > about what is going on (typically this is emitted from regular interrupt
> > context).
> >
> > Given this comment is part of the debugger code then for the
> > oops_in_progress hack it might be more helpful to describe what
> > the developer in front the debugger needs to do to have the most
> > reliable debug session possible.
> >
> >   There is no guarantee that every console drivers can handle reentrance
> >   in this way; the developer deploying the debugger is responsible for
> >   ensuring that the console drivers they have selected handle reentrance
> >   appropriately.
> 
> Thanks for the explanation. I will change the comment to:
> 
> 	/*
> 	 * The console_srcu_read_lock() only provides safe console list
> 	 * traversal. The use of the ->write() callback relies on all other
> 	 * CPUs being stopped at the moment and console drivers being able to
> 	 * handle reentrance when @oops_in_progress is set.
> 	 *
> 	 * There is no guarantee that every console driver can handle
> 	 * reentrance in this way; the developer deploying the debugger
> 	 * is responsible for ensuring that the console drivers they
> 	 * have selected handle reentrance appropriately.
> 	 */

Looks good to me.

After merging this with the 10th patch that adds the data_race() annotated
check of CON_ENABLED flag:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
