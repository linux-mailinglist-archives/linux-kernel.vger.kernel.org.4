Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF82637BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKXOxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKXOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:52:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D8A114BAA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:52:04 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AE26F21AB1;
        Thu, 24 Nov 2022 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669301522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5UMI1DIKDAnzqSTbIOKqYqHKnG+LlUGJsP8L+VyKueg=;
        b=evlXEjHn6DGAUhPl+wGh1wQ1HXAPLcp0KiplfR5aC22HF+TF0zjZ03RjNwETt2vxSt7QEJ
        hbn9H+3mF5dgdFCzFaMe6mM170v0VGqYb+VI6eTBFvfpxYXRxtuHDKgG9T0JF2hh2rfak9
        Ls9nfrldlkobBa/hz2qcvBxxGB+Dun4=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 88E392C141;
        Thu, 24 Nov 2022 14:52:02 +0000 (UTC)
Date:   Thu, 24 Nov 2022 15:52:01 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 4/7] printk: Add struct console_buffers
Message-ID: <Y3+FEe7szf67kGKc@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123231400.614679-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-11-24 00:19:57, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Create a data structure to replace the open coded separate buffers for
> regular, extended, and dropped message formatting.
> 
> A separate @ext_text buffer is needed because info_print_ext_header()
> and msg_print_ext_body() are not able to add the needed extra
> information in-place.
> 
> @ext_text can be used for dropped text because they are never used at
> the same time.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

If we agree to use the static buffers in struct console, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Otherwise, it should get moved into some internal header.

Best Regards,
Petr
