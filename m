Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28A06A8DB1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCBX54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjCBX5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:57:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E174D5A6C5;
        Thu,  2 Mar 2023 15:57:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB44BB815A6;
        Thu,  2 Mar 2023 23:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496E6C4339B;
        Thu,  2 Mar 2023 23:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677801446;
        bh=2UQajFZuHMQZg7glfMnBZv/6XVgSS0fmxTbSFM7fisE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ffm747FrdZriBeFlLJxbi+nejihcH45HCVK1lXfajtKNVlahA7BLzWdYqm598i60Q
         azx3YIFcSKiiQN5xwQZx7wwgZagEOWJCr/AiID4PNIvAAlJ0I5hsxnujEfNKXfCkPk
         r+mMbrIQkd04itB6pSJj3muAh2uX+Yp2FJVcTBsMh2T72+Sr3hdFx86HpAqUncFLot
         NFqMZVaSgQyFud1wk5esRGLwpFgDwC6JlEx3VLpuW7r1D7ZTe0XbdhOqnRQkOqCoAD
         1hLPjw+H9QVFJH8imAT4DQaIUBXicRm0//WrnbVQ73zsiPIlw22IyASLpa7dS798nE
         hYBkWqVpTXUxA==
Date:   Fri, 3 Mar 2023 08:57:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ring_buffer: Change some static functions to void
Message-Id: <20230303085723.53182d1576737f93dc46fc92@kernel.org>
In-Reply-To: <20230301113416.7526d858@gandalf.local.home>
References: <20230228175929.7534-1-ubizjak@gmail.com>
        <20230228175929.7534-2-ubizjak@gmail.com>
        <20230301075519.dbf770fed0476e2b6ecdad37@kernel.org>
        <CAFULd4b0zQSzesH3mrbtThH17VnoPzVhg2R6cDpDZTMsPeDWpQ@mail.gmail.com>
        <20230301113416.7526d858@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023 11:34:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 1 Mar 2023 09:46:50 +0100
> Uros Bizjak <ubizjak@gmail.com> wrote:
> 
> > On Tue, Feb 28, 2023 at 11:55 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > On Tue, 28 Feb 2023 18:59:27 +0100
> > > Uros Bizjak <ubizjak@gmail.com> wrote:
> > >  
> > > > The results of some static functions are not used. Change the
> > > > type of these function to void and remove unnecessary returns.
> > > >
> > > > No functional change intended.  
> > >
> > > NAK, instead of dropping the errors, please handle it on the caller side.  
> > 
> > I was under the impression that the intention of these two functions
> > is to warn if there is any corruption in data pages detected. Please
> > note that the patch has no effect on code size, as the compiler is
> > smart enough to drop unused return values by itself. So, the change is
> > mostly cosmetic as I was just bothered by unused returns. I'm not
> > versed enough in the code to introduce additional error handling, so
> > considering its minimal impact, the patch can just be dropped.
> > 
> 
> I'm not against the change.
> 
> Masami,
> 
> I don't think we need to check the return values, as when these checks
> fail, it triggers RB_WARN_ON() which disables the ring buffer involved, and
> that should stop further progress of other calls to the affected ring
> buffer.

Ah, so the RB_WARN_ON() has a side effect which stops all further operations.
OK, I got it.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
