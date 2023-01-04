Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BEC65D0D3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjADKmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjADKm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:42:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0689C25C0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:42:28 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A5CD649FF;
        Wed,  4 Jan 2023 10:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672828947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/dBVqZBcbjnBNOV8glZVtRw1y1RGWVCN0azqDA4+ic=;
        b=L9CZZOieVqSEWF1iDImcANXQedk3RdVPHODWwqouaBHsqlCoLyIz2E8LFr7b/Lwv8sPz41
        MFF22HF6PAKYbauzfLdIgMIILS4/PnPYrUMohbqgQOCPC8ExtTMUTlak7LcFEP/4X+UMjh
        b6bQotqoCPDK58MbzJDfwSzdLhJBIAY=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 812402C141;
        Wed,  4 Jan 2023 10:42:27 +0000 (UTC)
Date:   Wed, 4 Jan 2023 11:42:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 5/6] printk: introduce
 console_get_next_message() and console_message
Message-ID: <Y7VYE+Z//jEVlFxi@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-6-john.ogness@linutronix.de>
 <87bknva1jg.fsf@jogness.linutronix.de>
 <Y7Q2B+p1gxJ1WCdj@alley>
 <87ilhnd5te.fsf@jogness.linutronix.de>
 <Y7RP5zuALa552AHY@alley>
 <871qoafve1.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qoafve1.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-01-04 11:32:30, John Ogness wrote:
> On 2023-01-03, Petr Mladek <pmladek@suse.com> wrote:
> >> The current atomic console proposal allocates 1x cbuf per-cpu and 4x
> >> meta-data per-cpu. Different contexts of a cpu will have different
> >> meta-data, but all the contexts of a cpu will share the same cbuf.
> >>
> >> If cbufs become embedded in cmsg, then we would allocate 1x cmsg
> >> per-cpu. But the atomic consoles would still need their own 4x per-cpu
> >> meta-data.
> >
> > Do we really need 4x the meta data?
> 
> Having per-context meta-data helps minimize data clobbering. For
> example, the message-formatting functions would not need to worry about
> @cmsg->len changing underneath them. This can be solved with a
> READ_ONCE() to a local variable and the function only using the local
> copy, but it will mean more copying of variables.

I see. I agree that a separate structure would avoid these problems.

> > The metadata describe the state of the buffer. Using the buffer in one
> > context invalidates the metadata in the other context.
> 
> Yes, but the message-formatting functions are the ones preparing that
> meta-data. They must then be able to handle an interrupting context
> changing that meta-data.
> 
> >> For v4 I will drop the console_buffers struct. I will use your
> >> suggestion.
> >
> > Please, do not do it just to make me happy. My intention
> > is to keep things simple. And keeping the two structures
> > synced needs an extra code.
> >
> > If you are sure that the separation will really be needed
> > in the future then feel free to keep the two structures.
> 
> Currently the message-formatting functions do not care about clobbering
> of the text buffers. They blindly just move things around using the
> meta-data as safety boundaries. This can lead to a formatted-buffer that
> contains garbage, but an interrupted context will not print that buffer
> in the end. The important thing is that the garbage was created safely.

Right.

> Avoiding a separate console_buffers structure may simplify the
> structures, but it requires robustifying the message-formatting
> functions to be tolerant for meta-data clobbering.
> 
> I am currently implementing such changes to see if it is feasible.

Please, do not spend too much time on this.

I think that the two structures make sense in the end. Just please
mention the metadata clobbering as the motivation in the commit
message.

Best Regards,
Petr
