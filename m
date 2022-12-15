Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0244264E19A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiLOTMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLOTLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:11:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D07323169;
        Thu, 15 Dec 2022 11:11:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 009B061EEB;
        Thu, 15 Dec 2022 19:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29543C433EF;
        Thu, 15 Dec 2022 19:11:48 +0000 (UTC)
Date:   Thu, 15 Dec 2022 14:11:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: Re: [RFC][PATCH] ACPI: tracing: Have ACPI debug go to tracing ring
 buffer
Message-ID: <20221215141146.6ceb7cf2@gandalf.local.home>
In-Reply-To: <Y5trUep9IvCv1Uwy@google.com>
References: <20221214233106.69b2c01b@gandalf.local.home>
        <Y5trUep9IvCv1Uwy@google.com>
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

On Thu, 15 Dec 2022 18:45:37 +0000
Joel Fernandes <joel@joelfernandes.org> wrote:

> Wouldn't it be better to also check trace_acpi_print_enabled() here in the
> else if() condition, along with IS_ENABLED()? That way if the CONFIG is
> enabled but the tracepoint is not enabled, at least the messages will go to
> dmesg instead of skipped.

I really don't want that. This was purposely done to be mutually exclusive.
The reason I added this in the first place, is because too much enabled
will render the system useless if printk() is used.

After boot up, if I had enabled all debug events and then I were to disable
the acpi tracepoint, it will likely render the system useless again if it
were to switch over to printk.

-- Steve
