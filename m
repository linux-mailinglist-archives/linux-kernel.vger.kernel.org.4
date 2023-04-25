Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D0D6ED9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 03:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjDYBlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 21:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYBlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 21:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C88AF04;
        Mon, 24 Apr 2023 18:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C9E962074;
        Tue, 25 Apr 2023 01:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26C3C433EF;
        Tue, 25 Apr 2023 01:41:20 +0000 (UTC)
Date:   Mon, 24 Apr 2023 21:41:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tracing/user_events: Prevent same address and bit
 per process
Message-ID: <20230424214118.06b7ee07@rorschach.local.home>
In-Reply-To: <20230411211709.15018-4-beaub@linux.microsoft.com>
References: <20230411211709.15018-1-beaub@linux.microsoft.com>
        <20230411211709.15018-4-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 14:17:09 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> +static bool user_event_enabler_exists(struct user_event_mm *mm,
> +				      unsigned long uaddr, unsigned char bit)
> +{
> +	struct user_event_enabler *enabler;
> +	struct user_event_enabler *next;
> +
> +	list_for_each_entry_safe(enabler, next, &mm->enablers, link)
> +		if (enabler->addr == uaddr &&
> +		    (enabler->values & ENABLE_VAL_BIT_MASK) == bit)
> +			return true;
> +

Please add brackets around complex calls like the above. The no bracket
rule is not if you can get away without using it, but if there's only a
single line.

	list_for_each_entry_safe(enabler, next, &mm->enablers, link) {
		if (enabler->addr == uaddr &&
		    (enabler->values & ENABLE_VAL_BIT_MASK) == bit)
			return true;
	}

-- Steve



> +	return false;
> +}
> +
