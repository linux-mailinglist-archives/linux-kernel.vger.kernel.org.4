Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3BD7439CF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjF3KqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjF3KqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:46:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B664F0;
        Fri, 30 Jun 2023 03:46:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D44A161718;
        Fri, 30 Jun 2023 10:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFF4C433C8;
        Fri, 30 Jun 2023 10:45:58 +0000 (UTC)
Date:   Fri, 30 Jun 2023 06:45:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc:     mhiramat@kernel.org, dan.carpenter@linaro.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/trace: Fix cleanup logic of enable_trace_eprobe
Message-ID: <20230630064554.3d1df048@rorschach.local.home>
In-Reply-To: <CAPpZLN50yfT7rZxfP6T2g3asE6b8YkAERJHt3UuJ2bh4FAjDCQ@mail.gmail.com>
References: <20230628121811.338655-1-tz.stoyanov@gmail.com>
        <20230628084428.7bb32d65@rorschach.local.home>
        <CAPpZLN6dCMzHyUhjSN3+9Um+-mS2TJiDPObUeO8NxyqpQS3k=g@mail.gmail.com>
        <20230630033330.20a503fa@rorschach.local.home>
        <CAPpZLN50yfT7rZxfP6T2g3asE6b8YkAERJHt3UuJ2bh4FAjDCQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 12:57:36 +0300
Tzvetomir Stoyanov <tz.stoyanov@gmail.com> wrote:

> > Does that make sense?  
> 
> Yes, it makes sense. But the original loop will break on the first
> failure.  If there is an error (ret is not 0) and at least one eprobe
> was enabled successfully (enabled is true),
> the warning should be emitted, only if that error is not ENOMEM:
>                                   WARN_ON_ONCE(ret != -ENOMEM);

Ah, I missed the logic for the "enabled" variable. Yeah, when that is
set it does the same as the cnt variable I mentioned. Thanks for
pointing that out. (I blame still being a bit jetlagged and lack of
sleep for not seeing that ;-)

Yeah, if "enabled" is set, then we can do the WARN_ON_ONCE().

I'll wait for your new patch.

Thanks Tzvetomir!

-- Steve
