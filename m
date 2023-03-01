Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149826A70DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCAQ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCAQ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:28:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E31619C;
        Wed,  1 Mar 2023 08:28:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E4C1B810B6;
        Wed,  1 Mar 2023 16:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E555C4339C;
        Wed,  1 Mar 2023 16:28:09 +0000 (UTC)
Date:   Wed, 1 Mar 2023 11:28:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 3/3] ring_buffer: Use try_cmpxchg instead of cmpxchg
Message-ID: <20230301112808.73d1e316@gandalf.local.home>
In-Reply-To: <20230301111850.768f8526@gandalf.local.home>
References: <20230228175929.7534-1-ubizjak@gmail.com>
        <20230228175929.7534-4-ubizjak@gmail.com>
        <20230228164346.0691bb11@gandalf.local.home>
        <CAFULd4aGx=kGYYUz0BkFJz3abz97WOwDEgFHAOocT8SWT2oX-Q@mail.gmail.com>
        <20230301111850.768f8526@gandalf.local.home>
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

On Wed, 1 Mar 2023 11:18:50 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> But with gcc 12.2.0 I don't really see the benefit. And I'm worried that
> the side effect of modifying the old variable could cause a bug in the
> future, if it is used after the try_cmpxchg(). At least for the second case.

Actually, I like Joel's recommendation of adding a cmpxchg_succeeded()
function, that does the try_cmpxchg() without needing to save the old
variable. That's my main concern, as it does have that side effect that
could be missed when updating the code.

That would be the best of both worlds ;-)

-- Steve
