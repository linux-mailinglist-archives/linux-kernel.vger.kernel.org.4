Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110DE61F7E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiKGPrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiKGPrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:47:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDB0766F;
        Mon,  7 Nov 2022 07:47:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B6F660F81;
        Mon,  7 Nov 2022 15:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D352C433D6;
        Mon,  7 Nov 2022 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667836025;
        bh=CxZk0fJX+dweo2MpQp+Q7j2QOSUYeMB1iNXzqdXLUEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrjTrQOpb4+i5kA1Qn7aJPZaNG1H22iVX7ZIhZi7dbWgJO9UQUh7gFuDKNNSizPD1
         ytosTcepgiC6JAlLNW6H/v2LyYzE8MUUHrMOd8FKHM7XhQmIUHm6qHBQAqKNDwwqTR
         ITtYJcWonxeuj4A2Z4V65B3VCzDy5rmjd8OjBFbrXgOWXnghcbNu6y1f6ewj47dZYV
         ww7zI8o26lA4kmokbE7Bld1oYo3g4FzCpkLcUAZWNUWDoftxIqJpQX3VSIsrpihK29
         vXkSeMLT1EVOUrpzxLxRzUZ2IWjTNhxrDAUn7FZObEtICAKXYPH7oUj5LMmxhFQkH6
         WNmJ05urfVoaQ==
Date:   Mon, 7 Nov 2022 17:47:01 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [RFC][PATCH v3 05/33] timers: ACPI: Use timer_shutdown_sync()
 before freeing timer
Message-ID: <Y2kodWh2DetbFLax@kernel.org>
References: <20221104054053.431922658@goodmis.org>
 <20221104054912.802343429@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104054912.802343429@goodmis.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 01:40:58AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Before a timer is freed, timer_shutdown_sync() must be called.
> 
> Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Shuai Xue <xueshuai@linux.alibaba.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  drivers/acpi/apei/ghes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 9952f3a792ba..9a0e41c21cf9 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1405,7 +1405,7 @@ static int ghes_remove(struct platform_device *ghes_dev)
>  	ghes->flags |= GHES_EXITING;
>  	switch (generic->notify.type) {
>  	case ACPI_HEST_NOTIFY_POLLED:
> -		del_timer_sync(&ghes->timer);
> +		timer_shutdown_sync(&ghes->timer);
>  		break;
>  	case ACPI_HEST_NOTIFY_EXTERNAL:
>  		free_irq(ghes->irq, ghes);
> -- 
> 2.35.1


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
