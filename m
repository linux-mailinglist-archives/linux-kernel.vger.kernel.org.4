Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C845F4C39
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJDWvt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Oct 2022 18:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJDWvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:51:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA546F251;
        Tue,  4 Oct 2022 15:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5893614CD;
        Tue,  4 Oct 2022 22:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B011C433D6;
        Tue,  4 Oct 2022 22:51:43 +0000 (UTC)
Date:   Tue, 4 Oct 2022 18:51:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel@pengutronix.de,
        Ingo Molnar <mingo@redhat.com>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: Add tracing events for the most usual
 watchdog events
Message-ID: <20221004185146.5d4419ba@gandalf.local.home>
In-Reply-To: <20221004091950.3419662-1-u.kleine-koenig@pengutronix.de>
References: <20221004091950.3419662-1-u.kleine-koenig@pengutronix.de>
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

On Tue,  4 Oct 2022 11:19:49 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> +DEFINE_EVENT(watchdog_template, watchdog_start,
> +	TP_PROTO(struct watchdog_device *wdd, int err),
> +	TP_ARGS(wdd, err));
> +
> +TRACE_EVENT(watchdog_set_timeout,
> +
> +	TP_PROTO(struct watchdog_device *wdd, unsigned int timeout, int err),
> +
> +	TP_ARGS(wdd, timeout, err),
> +
> +	TP_STRUCT__entry(
> +		__field(int, id)
> +		__field(unsigned int, timeout)
> +		__field(int, err)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id = wdd->id;
> +		__entry->timeout = timeout;
> +		__entry->err = err;
> +	),
> +
> +	TP_printk("watchdog%d timeout=%u err=%d", __entry->id, __entry->timeout, __entry->err)
> +);

Nit, but I would probably put the above TRACE_EVENT() below the two
DEFINE_EVENT()s below. That way we have all the DEFINE_EVENT()s for a
specific DECLARE_EVENT_CLASS() together. Otherwise people may get confused.

-- Steve



> +
> +DEFINE_EVENT(watchdog_template, watchdog_ping,
> +	TP_PROTO(struct watchdog_device *wdd, int err),
> +	TP_ARGS(wdd, err));
> +
> +DEFINE_EVENT(watchdog_template, watchdog_stop,
> +	TP_PROTO(struct watchdog_device *wdd, int err),
> +	TP_ARGS(wdd, err));
> +
> +#endif /* !defined(_TRACE_WATCHDOG_H) || defined(TRACE_HEADER_MULTI_READ) */
> +
