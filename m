Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C59274B2E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjGGOPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjGGOPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:15:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A921999;
        Fri,  7 Jul 2023 07:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18FAE619BF;
        Fri,  7 Jul 2023 14:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1773C433C7;
        Fri,  7 Jul 2023 14:15:02 +0000 (UTC)
Date:   Fri, 7 Jul 2023 10:14:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] Revert "tracing: Add "(fault)" name injection to
 kernel probes"
Message-ID: <20230707101420.49b1fd54@gandalf.local.home>
In-Reply-To: <168873727209.2687993.6806850187024303094.stgit@mhiramat.roam.corp.google.com>
References: <168873724526.2687993.15242662075324919195.stgit@mhiramat.roam.corp.google.com>
        <168873727209.2687993.6806850187024303094.stgit@mhiramat.roam.corp.google.com>
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

On Fri,  7 Jul 2023 22:41:12 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
> index c4e1d4c03a85..6deae2ce34f8 100644
> --- a/kernel/trace/trace_probe_kernel.h
> +++ b/kernel/trace/trace_probe_kernel.h
> @@ -2,8 +2,6 @@
>  #ifndef __TRACE_PROBE_KERNEL_H_
>  #define __TRACE_PROBE_KERNEL_H_
>  
> -#define FAULT_STRING "(fault)"
> -

Instead of deleting this, why not use it in both places? After applying
your patch, we have:

 $ git grep '(fault)' kernel/trace
kernel/trace/trace_events_synth.c:                      strcpy(str_field, "(fault)");
kernel/trace/trace_probe.c:             trace_seq_puts(s, "(fault)");

We could make that consistent with:

kernel/trace/trace_events_synth.c:                      strcpy(str_field, FAULT_STRING);
kernel/trace/trace_probe.c:             trace_seq_puts(s, FAULT_STRING);

-- Steve

