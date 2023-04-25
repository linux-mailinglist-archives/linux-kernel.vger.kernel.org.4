Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C856EE729
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjDYR4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjDYR4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:56:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1391CC2E;
        Tue, 25 Apr 2023 10:56:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8498F62831;
        Tue, 25 Apr 2023 17:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191CDC433EF;
        Tue, 25 Apr 2023 17:56:17 +0000 (UTC)
Date:   Tue, 25 Apr 2023 13:56:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] tracing/user_events: Ensure bit is cleared on
 unregister
Message-ID: <20230425135615.5801d0cf@gandalf.local.home>
In-Reply-To: <20230425170654.GA74@W11-BEAU-MD.localdomain>
References: <20230411211709.15018-1-beaub@linux.microsoft.com>
        <20230411211709.15018-3-beaub@linux.microsoft.com>
        <20230424213957.55c503c1@rorschach.local.home>
        <20230425170654.GA74@W11-BEAU-MD.localdomain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 10:06:54 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> That's a good point, user_event_mm_fault() is a wrapper around
> fixup_user_fault(). We retry if it works, so I guess if the user could
> somehow cause a fail on the write and succeed to page in repeatedly, it
> could keep the loop going for that time period. I cannot think of a way
> to achieve this forever, but that doesn't mean it couldn't happen.
> 
> I can certainly add an upper bound of retries (maybe 3 or so?) if you
> think it would be possible for this to occur. I think we need retries of
> some amount to handle spurious faults.

Even 10 is fine. With a comment saying, "This really shouldn't loop more
than a couple of times, but we want to make sure some mischievous user
doesn't take advantage of this looping".

-- Steve
