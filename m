Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303086A736F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjCAS2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCAS2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:28:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4317A30DF;
        Wed,  1 Mar 2023 10:28:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAF7EB810F7;
        Wed,  1 Mar 2023 18:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82EBC433D2;
        Wed,  1 Mar 2023 18:28:42 +0000 (UTC)
Date:   Wed, 1 Mar 2023 13:28:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
Message-ID: <20230301132839.43b51b4e@gandalf.local.home>
In-Reply-To: <20230301131831.6c8d4ff5@gandalf.local.home>
References: <20230228175929.7534-1-ubizjak@gmail.com>
        <20230228175929.7534-4-ubizjak@gmail.com>
        <20230228164346.0691bb11@gandalf.local.home>
        <CAFULd4aGx=kGYYUz0BkFJz3abz97WOwDEgFHAOocT8SWT2oX-Q@mail.gmail.com>
        <20230301111850.768f8526@gandalf.local.home>
        <CAFULd4YePGAqxpq0kJMnNHkqqkL9HEnEz1ud9kNrae5wqpRVbA@mail.gmail.com>
        <20230301131831.6c8d4ff5@gandalf.local.home>
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

On Wed, 1 Mar 2023 13:18:31 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I am leaning to just taking this, and hope that it doesn't cause problems.
> And I would really love to change all the local_cmpxchg() to
> local_try_cmpxchg(). Hmm, I wonder how much of an effort that would be to
> implement those?

I see that you were the one that added the generic support for
try_cmpxchg64() and messed with all those generated files. Care to add one
for local_try_cmpxchg() ;-)

-- Steve
