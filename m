Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3E260323B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiJRSWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJRSWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:22:17 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4CC537E3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:22:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f193so14066014pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5O2nfoZUUI17sIrVLXrq+nTxYKq2avmQeiwJCCxIYyU=;
        b=LUhQ3yNwDgxQcOn5l24dnb5EBX0+mCLGHCyjKy/AQsnzDKNuGryAEwNnkJAhGipEjx
         2fpGoeYFJDYlnC3mOa/6VDHhVlND6FW+As9bYrQlw6tfVxXaEgZYeAP2apWVoWFrvcz0
         QWvt5Sn44j1QlYT07YnoOt0g9YSfmwfddw+b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5O2nfoZUUI17sIrVLXrq+nTxYKq2avmQeiwJCCxIYyU=;
        b=fnNMW766mp07QpMMZYK/rlIxD7dut03VkDanxwcv8H2dedrYLFmLrzLgbUjPfuZLzP
         MeBnviYd+fd+3PrE3U/FwJTpdudHPibqaIqPs12W4pbO8SuTG/RCliaZroy292Rsxjbh
         EezlAipzOc24tFDa62r89eYuR6LrYYCu6yzH6GwZwkPa8SqLtdPZc/N1dzbGZIQFLVKN
         eo/dA/00J12Gk7fZ28Pa0/megjeBJaa4LrBXo2XyoensX/9p8ipBL4sqG36UQ00e9Eda
         5CrGiumMBEFO7yXUzzVQAgAaxPX5R7Y4FrvZYmNlOiLIfhLUg0SN1tq/FqiCU0KIsvCt
         m2DA==
X-Gm-Message-State: ACrzQf022K8SSsR3OoMsZYHMN1rT7nzzhy3M2d0leOf7NHVYZOeVG2T0
        A956acnah/2++anaXi+r0ZvpCw==
X-Google-Smtp-Source: AMsMyM4QDoYsnVXHQht40Vum0Q2XNce7Yi5modZHM//U86H3LYXhH7spGU1A+vK4V3BXsRZlTGTaiQ==
X-Received: by 2002:a63:1308:0:b0:440:5517:c99d with SMTP id i8-20020a631308000000b004405517c99dmr3726386pgl.550.1666117336092;
        Tue, 18 Oct 2022 11:22:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a29-20020aa795bd000000b0056234327070sm9906383pfk.95.2022.10.18.11.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:22:15 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:22:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] ftrace,kcfi: Separate ftrace_stub() and
 ftrace_stub_graph()
Message-ID: <202210181121.FEF66CA202@keescook>
References: <Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net>
 <Y06ntk9uY5re23WX@hirez.programming.kicks-ass.net>
 <A41EBE43-40FE-482A-A795-B4A4F63C345C@linux.dev>
 <Y06/kaxqvcl/QZqj@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y06/kaxqvcl/QZqj@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 05:00:33PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 18, 2022 at 07:28:29AM -0700, Kees Cook wrote:
> 
> > Thanks for solving this! Just for future archeology, can you include
> > the splat (I assume you hit a CFI splat) in the commit log, and/or how
> > you triggered the problem? I usually find it helpful in trying to fix
> > similar issues later, etc.
> 
> Unfortunately I didn't save it; it was a while ago (I sorta lost track
> of this fix for a while since it was stuffed in my fineibt queue).
> 
> But Mark ran it today to confirm on arm64 and there it looks like
> (harvested from IRC):
> 
>   [    3.153082] CFI failure at ftrace_return_to_handler+0xac/0x16c (target: ftrace_stub+0x0/0x14; expected type: 0x0a5d5347)
> 
> I think simply enabling the ftrace boot time tests is enough to trigger
> this.

Ah-ha, perfect. Thanks! (If it's not yet in tip, can you update the
commit log?)

-- 
Kees Cook
