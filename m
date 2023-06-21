Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A784B738EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjFUSlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFUSlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:41:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9821AC6;
        Wed, 21 Jun 2023 11:41:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33A966169A;
        Wed, 21 Jun 2023 18:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F183C433C0;
        Wed, 21 Jun 2023 18:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687372873;
        bh=/eu9LOf9IBDwc7TLl8h8hH75VKdFAoP/+wYaxVHBtPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIKxkJclYIC1H1i6c7VFzQeWJXyzaWkWHwsmj2zAIkjzJknPVjMIMl3fQUN4gK8OM
         7KvXLWwBXjiveHLKflQiShgC2xN2RkNl7q5TV2iSST16pfVzQOTQikvA0n24cCxgHM
         4piHuwDn/wqneKwNr85n6eGjxqUt0oHHRfmBOlL0=
Date:   Wed, 21 Jun 2023 20:41:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.15] tracing: Add
 tracing_reset_all_online_cpus_unlocked() function
Message-ID: <2023062102-catchable-obituary-934c@gregkh>
References: <20230620013052.1127047-1-zhengyejian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620013052.1127047-1-zhengyejian1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 09:30:52AM +0800, Zheng Yejian wrote:
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
> 
> [Refers to commit message of 417d5ea6e735e5d88ffb6c436cf2938f3f476dd1,
> this patch is pre-depended, and tracing_reset_all_online_cpus() should
> be called after trace_types_lock is held as its comment describes.]
> Fixes: 417d5ea6e735 ("tracing: Free buffers when a used dynamic event is removed")
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>

All now queued up, thanks.

greg k-h
