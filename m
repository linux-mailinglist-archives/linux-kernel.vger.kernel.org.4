Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20838734DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjFSI1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjFSI1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D77710E4;
        Mon, 19 Jun 2023 01:26:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2F26615C2;
        Mon, 19 Jun 2023 08:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3CAC433C8;
        Mon, 19 Jun 2023 08:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687163218;
        bh=jPDfUrPJFx3VNBCs3Fpr5ysGOFFZmq//beORD/0x07g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgI/9E35VmXupbNJtu1EVDXsz+Fhn/CmEPvwyUcWWwM7XOvhrvkml+l4G26N8EC/p
         5esP34IjEzGpFVBPQGuRy4cMZsPZH3KNHWFp8JnVPv4JwGSC5VEnoeBqU6OAy9d2XC
         E4cSiJvZdrcEkNKjELPiYYahsJAPMhAYEroQM9pU=
Date:   Mon, 19 Jun 2023 10:26:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.10] tracing: Add
 tracing_reset_all_online_cpus_unlocked() function
Message-ID: <2023061913-dosage-repacking-678e@gregkh>
References: <20230615204931.3250659-1-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615204931.3250659-1-zhengyejian1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 04:49:31AM +0800, Zheng Yejian wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> commit e18eb8783ec4949adebc7d7b0fdb65f65bfeefd9 upstream.
> 
> Currently the tracing_reset_all_online_cpus() requires the
> trace_types_lock held. But only one caller of this function actually has
> that lock held before calling it, and the other just takes the lock so
> that it can call it. More users of this function is needed where the lock
> is not held.
> 
> Add a tracing_reset_all_online_cpus_unlocked() function for the one use
> case that calls it without being held, and also add a lockdep_assert to
> make sure it is held when called.
> 
> Then have tracing_reset_all_online_cpus() take the lock internally, such
> that callers do not need to worry about taking it.
> 
> Link: https://lkml.kernel.org/r/20221123192741.658273220@goodmis.org
> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zheng Yejian <zhengyejian1@huawei.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> [this patch is pre-depended by be111ebd8868d4b7c041cb3c6102e1ae27d6dc1d
> due to tracing_reset_all_online_cpus() should be called after taking lock]
> Fixes: be111ebd8868 ("tracing: Free buffers when a used dynamic event is removed")
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---


What about for 5.15.y?  You can't apply a fix to just an older tree as
you will then have a regression when you update.

I'll drop this one from my queue, please resend a backport for all
relevent stable releases.

thanks,

greg k-h
