Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35532648DA1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 09:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLJIqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 03:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLJIqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 03:46:40 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A368B24951
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 00:46:39 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2BA8kJkg021763;
        Sat, 10 Dec 2022 09:46:19 +0100
Date:   Sat, 10 Dec 2022 09:46:19 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] nolibc: fix fd_set type
Message-ID: <20221210084619.GA21743@1wt.eu>
References: <20221209141939.3634586-1-svens@linux.ibm.com>
 <20221209141939.3634586-2-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209141939.3634586-2-svens@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 03:19:35PM +0100, Sven Schnelle wrote:
> The kernel uses unsigned long for the fd_set bitmap,
> but nolibc use u32. This works fine on little endian
> machines, but fails on big endian. Convert to unsigned
> long to fix this.

Thank you for spotting and fixing this one! I had been using these for
a long time, including for pure user-land code to manipulate bits and
never thought about the risk of incompatibility when passing them as-is
to the kernel! It's fairly possible that I'm having non-working code for
64-bit BE machines at a few places!

> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

Acked-by: Willy Tarreau <w@1wt.eu>

Willy
