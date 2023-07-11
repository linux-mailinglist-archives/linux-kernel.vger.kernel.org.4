Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B7B74E3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjGKB6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGKB6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3660D94;
        Mon, 10 Jul 2023 18:58:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C788F612A3;
        Tue, 11 Jul 2023 01:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2ADC433C8;
        Tue, 11 Jul 2023 01:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689040691;
        bh=5NFSp/Ms8MiLdis39kMTeTKdirOZ67rP66yVZppz8bY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oopqct5uK2y1SEE/uat6lKmyr5e+bCqvqQO1VmUsaGnoEm5oYfe8+xJgiMeHNn1eQ
         nB7PjcEtqeGxySR9AgM0ZoBF7gjJhCKTxmEfbVLxh92SWGi3RZ6pPqO/izAGuJ5KCr
         A4qJ0YD+1nEIl5j30PdEafC8q8BbvBe/kQzXj+X/MQLWGIr6q8xS0bubDDFjTyh/+X
         vRB7u4G/31EJtu24CysP+t/LGSRd6jR/0awyl512zkk7lJxUHE8GXB4ks8lW99dmuB
         nZdQDVCIUGQtoRcQZQPl8V/ABmB5V7zf20IrmU7E/GQAIYC7Pf0s0yLFsWSqyjcA+S
         s3tDfj4u+/X7Q==
Date:   Mon, 10 Jul 2023 18:58:09 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v1 1/1] f2fs: Use return value of strreplace()
Message-ID: <ZKy3MQ4zRlvLwE1D@google.com>
References: <20230628150243.17771-1-andriy.shevchenko@linux.intel.com>
 <20230710184353.09640aee@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710184353.09640aee@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10, Steven Rostedt wrote:
> On Wed, 28 Jun 2023 18:02:43 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Since strreplace() returns the pointer to the string itself,
> > we may use it directly in the code.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  include/trace/events/f2fs.h | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> > index 793f82cc1515..f5994515290c 100644
> > --- a/include/trace/events/f2fs.h
> > +++ b/include/trace/events/f2fs.h
> > @@ -2234,13 +2234,11 @@ DECLARE_EVENT_CLASS(f2fs__rw_start,
> >  		 * because this screws up the tooling that parses
> >  		 * the traces.
> >  		 */
> > -		__assign_str(pathbuf, pathname);
> > -		(void)strreplace(__get_str(pathbuf), ' ', '_');
> > +		__assign_str(pathbuf, strreplace(pathname, ' ', '_'));
> 
> But this modifies the pathname that is passed into the trace event, which
> is something that a trace point should never do! In fact, the char
> *pathname, really should be a const char * (for which this would fail to
> build).
> 
> Note, I went to look for these events and I can not find where they are
> used. Should these events just be deleted?

Hmm, this was a part of upstream effort to replace the previous android_fs
tracepoints like:
https://android-review.git.corp.google.com/c/platform/system/extras/+/2223339

> 
> -- Steve
> 
> 
> >  		__entry->offset = offset;
> >  		__entry->bytes = bytes;
> >  		__entry->i_size = i_size_read(inode);
> > -		__assign_str(cmdline, command);
> > -		(void)strreplace(__get_str(cmdline), ' ', '_');
> > +		__assign_str(cmdline, strreplace(command, ' ', '_'));
> >  		__entry->pid = pid;
> >  		__entry->ino = inode->i_ino;
> >  	),
