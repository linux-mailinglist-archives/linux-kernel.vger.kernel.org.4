Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD56142BC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 02:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiKABLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 21:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKABLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:11:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430F05FAE;
        Mon, 31 Oct 2022 18:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3BFD61519;
        Tue,  1 Nov 2022 01:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB20C433D6;
        Tue,  1 Nov 2022 01:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667265101;
        bh=yIXvwJb3xY9eof4ryN8qSDpnHCfY7dClMt5JLJMnsMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCUPQMTAHaBlHnm85/lF5KV8VLJkYKxqIVPeLHopIx5yuGsESSH6UTzICmnpwmdOT
         jsQZkDvjvr1LVxhZ6G5Rv2rLav1iBfT2DMrmCq0bOvqF01P29hwaCgCFFXPFw+N8xo
         Ag/e4ernwnF5TU2nsD3gZH1RBFDdBch5ouR5a9Ya2GRtzkLgDEmNNqP9h75z5AWeYB
         NyJqxr1kb13AZ0aAzguNiyWBe98MKjWGvnPhHZFu1HMmCSK1ElQDCbs4YkQtd7z7dN
         v3POEJ9c2yrC1gKrZei4WA2Zh9PK2TlBb6OG4/VVvKRS1HsIZFlxUb68L6Udyg7YHJ
         hE3AgrdPB6sDw==
Date:   Tue, 1 Nov 2022 03:11:36 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [RFC][PATCH v2 05/31] timers: ACPI: Use del_timer_shutdown()
 before freeing timer
Message-ID: <Y2BySCZGezr4IwrQ@kernel.org>
References: <20221027150525.753064657@goodmis.org>
 <20221027150926.006142977@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027150926.006142977@goodmis.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:05:30AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Before a timer is freed, del_timer_shutdown() must be called.
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
> index 80ad530583c9..916b952b14d0 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1405,7 +1405,7 @@ static int ghes_remove(struct platform_device *ghes_dev)
>  	ghes->flags |= GHES_EXITING;
>  	switch (generic->notify.type) {
>  	case ACPI_HEST_NOTIFY_POLLED:
> -		del_timer_sync(&ghes->timer);
> +		del_timer_shutdown(&ghes->timer);
>  		break;
>  	case ACPI_HEST_NOTIFY_EXTERNAL:
>  		free_irq(ghes->irq, ghes);
> -- 
> 2.35.1


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
