Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAC16A7152
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjCAQgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCAQgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:36:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878364AFF7;
        Wed,  1 Mar 2023 08:35:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC26DB80E95;
        Wed,  1 Mar 2023 16:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4153C433D2;
        Wed,  1 Mar 2023 16:34:18 +0000 (UTC)
Date:   Wed, 1 Mar 2023 11:34:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ring_buffer: Change some static functions to void
Message-ID: <20230301113416.7526d858@gandalf.local.home>
In-Reply-To: <CAFULd4b0zQSzesH3mrbtThH17VnoPzVhg2R6cDpDZTMsPeDWpQ@mail.gmail.com>
References: <20230228175929.7534-1-ubizjak@gmail.com>
        <20230228175929.7534-2-ubizjak@gmail.com>
        <20230301075519.dbf770fed0476e2b6ecdad37@kernel.org>
        <CAFULd4b0zQSzesH3mrbtThH17VnoPzVhg2R6cDpDZTMsPeDWpQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2023 09:46:50 +0100
Uros Bizjak <ubizjak@gmail.com> wrote:

> On Tue, Feb 28, 2023 at 11:55 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Tue, 28 Feb 2023 18:59:27 +0100
> > Uros Bizjak <ubizjak@gmail.com> wrote:
> >  
> > > The results of some static functions are not used. Change the
> > > type of these function to void and remove unnecessary returns.
> > >
> > > No functional change intended.  
> >
> > NAK, instead of dropping the errors, please handle it on the caller side.  
> 
> I was under the impression that the intention of these two functions
> is to warn if there is any corruption in data pages detected. Please
> note that the patch has no effect on code size, as the compiler is
> smart enough to drop unused return values by itself. So, the change is
> mostly cosmetic as I was just bothered by unused returns. I'm not
> versed enough in the code to introduce additional error handling, so
> considering its minimal impact, the patch can just be dropped.
> 

I'm not against the change.

Masami,

I don't think we need to check the return values, as when these checks
fail, it triggers RB_WARN_ON() which disables the ring buffer involved, and
that should stop further progress of other calls to the affected ring
buffer.

-- Steve

