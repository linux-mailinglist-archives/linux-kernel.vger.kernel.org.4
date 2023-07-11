Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C84974E27B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjGKAQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGKAQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:16:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D05DFB;
        Mon, 10 Jul 2023 17:16:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9607612A5;
        Tue, 11 Jul 2023 00:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1904C433C8;
        Tue, 11 Jul 2023 00:16:39 +0000 (UTC)
Date:   Mon, 10 Jul 2023 20:16:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] tracing/probes: Fix to record 0-length data_loc
 in fetch_store_string*() if fails
Message-ID: <20230710201637.03ef15ae@gandalf.local.home>
In-Reply-To: <20230711090515.3b86f4be7b530200865efd51@kernel.org>
References: <168878450334.2721251.3030778817503575503.stgit@mhiramat.roam.corp.google.com>
        <168878453829.2721251.15110493517953858343.stgit@mhiramat.roam.corp.google.com>
        <20230710181601.438b79a8@gandalf.local.home>
        <20230711090515.3b86f4be7b530200865efd51@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Tue, 11 Jul 2023 09:05:15 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > And this patch could have been:
> > 
> > static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base)
> > {
> > 	*(u32 *)dest = make_data_loc(ret, __dest - base);
> > }  
> 
> and introduce it. I also want to put the ternary operator into set_data_loc() too
> for simplicity.
> 
> static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base)
> {
> 	if (ret < 0)
> 		ret = 0;
> 	*(u32 *)dest = make_data_loc(ret, __dest - base);
> }
> 

Sounds good.

-- Steve
