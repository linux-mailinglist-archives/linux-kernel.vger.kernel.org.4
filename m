Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9A974F32C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGKPRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKPRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:17:44 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39459E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:17:43 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55ae2075990so3098217a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689088663; x=1691680663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHVi0s1IuFWl/ehc9JahlJPqzNF4LF+SBFa5ECpZnHU=;
        b=QBZIohgfNhM2E78kevVsEE+1Qwv2hpSFridUR6C3jQu0iwC34OsaifbF//xI0Mdw3p
         rCTp69jk/NYhnXVQHxBKHRuCK8YLb44a3jET6ruicOdHHi++WmzXvZzTIP23ZlwpfYiL
         cUEfD/ZWGUqxoIV1h53jOKyT1kBRlEmw/cw4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689088663; x=1691680663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHVi0s1IuFWl/ehc9JahlJPqzNF4LF+SBFa5ECpZnHU=;
        b=DfFBQXYCROCA388kNEYv7viUQE6HO/4w3OB7GBJgz9c6kxTgZ+09rDGgNuXL7/0/jZ
         4EeYaQlaG4F9hc+QostSM3EyVp7d2KZBetB1IJInt7lBkQam3lvPiYGzpvu10hR2x0bM
         4WmhL7ijlczzXab7uDb9QScXyUwjhhyyarTIlB0EEDDtWB/UhfonwdRFQ5N+dUbkGz0J
         He8YCo12Wy8WmunK9eCvfcC8X6FYERYfT4TCcRmecaLoH+GQw0XenQpwVcLIC8tnRenJ
         YkgdIat+0nILFhZ8UTOSA4YI2AE3XzMpi/por+uCFUvQ+nVogog4qLzJFpjq3cOuT+lG
         uMIA==
X-Gm-Message-State: ABy/qLZ3W/bpWHEm/i6EONP8v0W76/Wgf8D4njhf4BW3DDmRjvuVkA20
        3pnsZLzn34z1qSAhz3tozhSib8K+EWlAxB9s4W+ZqQ==
X-Google-Smtp-Source: APBJJlHhYE6STEI4c21sZdMEoWx7KaAxx0Fj//AEgaZ6unUd0HExYb43K+nDJUSHCG6QMeLmsK8yig==
X-Received: by 2002:a17:90a:7e86:b0:262:ecd9:ed09 with SMTP id j6-20020a17090a7e8600b00262ecd9ed09mr12456604pjl.33.1689088663255;
        Tue, 11 Jul 2023 08:17:43 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id ji19-20020a170903325300b001b869410ed2sm2073335plb.72.2023.07.11.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:17:42 -0700 (PDT)
Date:   Wed, 12 Jul 2023 00:17:38 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 3/5] printk: Consolidate console deferred
 printing
Message-ID: <20230711151738.GD12154@google.com>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710134524.25232-4-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/10 15:51), John Ogness wrote:
> Printing to consoles can be deferred for several reasons:
> 
> - explicitly with printk_deferred()
> - printk() in NMI context
> - recursive printk() calls
> 
> The current implementation is not consistent. For printk_deferred(),
> irq work is scheduled twice. For NMI und recursive, panic CPU
> suppression and caller delays are not properly enforced.
> 
> Correct these inconsistencies by consolidating the deferred printing
> code so that vprintk_deferred() is the top-level function for
> deferred printing and vprintk_emit() will perform whichever irq_work
> queueing is appropriate.
> 
> Also add kerneldoc for wake_up_klogd() and defer_console_output() to
> clarify their differences and appropriate usage.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good to me

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
