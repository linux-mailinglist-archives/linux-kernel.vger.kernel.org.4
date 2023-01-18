Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9B16723DB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjARQo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjARQnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:43:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8906B3754D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:43:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D9FA7CE1D3A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87B6C433D2;
        Wed, 18 Jan 2023 16:43:41 +0000 (UTC)
Date:   Wed, 18 Jan 2023 11:43:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] ktest.pl: Fix missing "end_monitor" when machine check
 fails
Message-ID: <20230118114340.704eca59@gandalf.local.home>
In-Reply-To: <20230118114301.6b4d09cf@gandalf.local.home>
References: <20230118114301.6b4d09cf@gandalf.local.home>
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

On Wed, 18 Jan 2023 11:43:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In the "reboot" command, it does a check of the machine to see if it is
> still alive with a simple "ssh echo" command. If it fails, it will assume
> that a normal "ssh reboot" is not possible and force a power cycle.
> 
> In this case, the "start_monitor" is executed, but the "end_monitor" is
> not, and this causes the screen not to be given back to the console. That
> is, after the test, a "reset" command needs to be performed, as "echo" is
> turned off.
> 
> Fixes: 6474ace999edd ("ktest.pl: Powercycle the box on reboot if no connection can be made")
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---

Masami, I believe this will fix your issue with the console after running
the test.

-- Steve
