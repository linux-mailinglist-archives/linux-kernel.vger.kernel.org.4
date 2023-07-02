Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F23744DA5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 14:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjGBM4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 08:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGBM42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 08:56:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E291AC;
        Sun,  2 Jul 2023 05:56:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BEF760C0A;
        Sun,  2 Jul 2023 12:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2AEC433C8;
        Sun,  2 Jul 2023 12:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688302586;
        bh=XHDwIY32/UI6jEWW8yhBSlFHKqLPpjWnXVRkt304r/Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F/81Mqo74F7VtR90yFh3NH4OdJ8F3lFIFHOIMuYnmn5K/cb8HlBkOZHU1cxhLv7Y9
         mBRN8xZ9MlvnQ6Iw4qJjD9wnyiMhs3BlZNafqqatzy5hcOOgp/PV4a4wpEGF7Nl+uY
         inJ6T2znVH9nO81z52eB85sRc7oBvZz/2jx/WWivF2mDeBQwdIsnkbO8/RWWhQoh2R
         B7046AMmFmJdC22IcGHQw8WKTPY3dFgYJ4jlhGTKG9LvfJwElOryp/TLU3OyeFPMDo
         xS6JF/sJ6degYICCcBvXGhUstiW3SfZUvQ2qv/8n7PqV4kXq8nAPdrf6VkZmrCVbEw
         r8xAULUWUAz4A==
Date:   Sun, 2 Jul 2023 21:56:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tracing/probes: Fix to avoid double count of the
 string length on the array
Message-Id: <20230702215623.fbdfa8f3a01a3d2ab9a6fa58@kernel.org>
In-Reply-To: <20230701210840.5cb46a79@rorschach.local.home>
References: <8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain>
        <168804801788.2028538.4620519547242506783.stgit@mhiramat.roam.corp.google.com>
        <20230701210840.5cb46a79@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jul 2023 21:08:40 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 29 Jun 2023 23:13:37 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > If there is an array is specified with the ustring or symstr, the length of
> 
>  "If there is an array specified with ustring or .." or "If an array is specified with ustring"
> 
> I prefer the latter.
> 
> > the strings are accumlated on both of 'ret' and 'total', which means the
> > length is double counted.
> > Just set the length to the 'ret' value to aviud double count.
> 
> 					"avoid"
> 
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/all/8819b154-2ba1-43c3-98a2-cbde20892023@moroto.mountain/
> > Fixes: 88903c464321 ("tracing/probe: Add ustring type for user-space string")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_probe_tmpl.h |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> > index 00707630788d..4735c5cb76fa 100644
> > --- a/kernel/trace/trace_probe_tmpl.h
> > +++ b/kernel/trace/trace_probe_tmpl.h
> > @@ -156,11 +156,11 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
> >  			code++;
> >  			goto array;
> >  		case FETCH_OP_ST_USTRING:
> > -			ret += fetch_store_strlen_user(val + code->offset);
> > +			ret = fetch_store_strlen_user(val + code->offset);
> >  			code++;
> >  			goto array;
> >  		case FETCH_OP_ST_SYMSTR:
> > -			ret += fetch_store_symstrlen(val + code->offset);
> > +			ret = fetch_store_symstrlen(val + code->offset);
> 
> Other than the above,
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks! I'll resend it with fixes.

> 
> -- Steve
> 
> 
> >  			code++;
> >  			goto array;
> >  		default:
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
