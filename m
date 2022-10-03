Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BD65F3390
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJCQ3P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Oct 2022 12:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJCQ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:29:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD523387A;
        Mon,  3 Oct 2022 09:29:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0A5FB81110;
        Mon,  3 Oct 2022 16:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00854C433C1;
        Mon,  3 Oct 2022 16:29:06 +0000 (UTC)
Date:   Mon, 3 Oct 2022 12:29:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ingo Molnar <mingo@redhat.com>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] watchdog: Add tracing events for the most usual
 watchdog events
Message-ID: <20221003122907.4fc39351@gandalf.local.home>
In-Reply-To: <20220930144935.3373366-1-u.kleine-koenig@pengutronix.de>
References: <20220930144935.3373366-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 16:49:35 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:


> --- /dev/null
> +++ b/include/trace/events/watchdog.h
> @@ -0,0 +1,92 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM watchdog
> +
> +#if !defined(_TRACE_WATCHDOG_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_WATCHDOG_H
> +
> +#include <linux/watchdog.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(watchdog_start,
> +
> +	TP_PROTO(struct watchdog_device *wdd, int err),
> +
> +	TP_ARGS(wdd, err),
> +
> +	TP_STRUCT__entry(
> +		__field(int, id)
> +		__field(int, err)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id = wdd->id;
> +		__entry->err = err;
> +	),
> +
> +	TP_printk("watchdog%d err=%d", __entry->id, __entry->err)
> +);
> +

[..]

> +
> +TRACE_EVENT(watchdog_ping,
> +
> +	TP_PROTO(struct watchdog_device *wdd, int err),
> +
> +	TP_ARGS(wdd, err),
> +
> +	TP_STRUCT__entry(
> +		__field(int, id)
> +		__field(int, err)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id = wdd->id;
> +		__entry->err = err;
> +	),
> +
> +	TP_printk("watchdog%d err=%d", __entry->id, __entry->err)
> +);
> +
> +TRACE_EVENT(watchdog_stop,
> +
> +	TP_PROTO(struct watchdog_device *wdd, int err),
> +
> +	TP_ARGS(wdd, err),
> +
> +	TP_STRUCT__entry(
> +		__field(int, id)
> +		__field(int, err)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id = wdd->id;
> +		__entry->err = err;
> +	),
> +
> +	TP_printk("watchdog%d err=%d", __entry->id, __entry->err)
> +);

These three events are identical. Please replace them with:

DECLARE_EVENT_CLASS(watchdog_template,

	TP_PROTO(struct watchdog_device *wdd, int err),

	TP_ARGS(wdd, err),

	TP_STRUCT__entry(
		__field(int, id)
		__field(int, err)
	),

	TP_fast_assign(
		__entry->id = wdd->id;
		__entry->err = err;
	),

	TP_printk("watchdog%d err=%d", __entry->id, __entry->err)
);

DEFINE_EVENT(watchdog_template, watchdog_start,
	TP_PROTO(struct watchdog_device *wdd, int err),
	TP_ARGS(wdd, err));

DEFINE_EVENT(watchdog_template, watchdog_ping,
	TP_PROTO(struct watchdog_device *wdd, int err),
	TP_ARGS(wdd, err));

DEFINE_EVENT(watchdog_template, watchdog_stop,
	TP_PROTO(struct watchdog_device *wdd, int err),
	TP_ARGS(wdd, err));


Each TRACE_EVENT() is defined as
  DECLARE_EVENT_CLASS(..)
  DEFINE_EVENT(..)

Where the DECLARE_EVENT_CLASS takes up most of the memory (5KB worth), and
each DEFINE_EVENT() takes up just around 500 bytes to implement.

Using multiple DEFINE_EVENTS() can save 10KB from the above.

-- Steve


> +
> +#endif /* !defined(_TRACE_WATCHDOG_H) || defined(TRACE_HEADER_MULTI_READ) */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868

