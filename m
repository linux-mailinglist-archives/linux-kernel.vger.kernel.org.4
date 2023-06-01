Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E8D7199AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjFAK1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjFAK0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:26:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BD0189
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:25:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3AA8615D7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23A5C433EF;
        Thu,  1 Jun 2023 10:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685615136;
        bh=2NFcB3OlY57envdQiYDDNTdYtxgQPhcvUDX+QUQL2V8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UO/XeYqNjEo8aC6nxwWUCHsLPXCbooa4XvycKNsE6MxUNDC5mkoJq56Oh9BJiRNhq
         wliMe46oQkMabL9TvLDlBtdO3XIRNUxgchIKs4E51t51z9o+7iTXt6dyup22agm0g4
         uqthr9UNTODwfSeeM/Eeit9GZqevhVIFixNQ1IDMjkglvYlyYv/aZ0i+z4L6LHTV+q
         hkUWKK9yzIvf7lEGCfSw8Gcv/08HHXvpLMskAGt0wRY6aTvglmDGFhazMkCbUvuo8r
         ZTc9UsgRzGD1IgijUN8+JYRbFi5zrHwbnsBOYxBjTAYbmqfnmxwvv7GHJL9cCu/UtI
         JMoE3jmnl4kFA==
Date:   Thu, 1 Jun 2023 12:25:33 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 09/20] posix-timers: Split release_posix_timers()
Message-ID: <ZHhyHc0VSqS6dX+g@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.301432503@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.301432503@linutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:09PM +0200, Thomas Gleixner wrote:
> release_posix_timers() is called for cleaning up both hashed and unhashed
> timers. The cases are differentiated by an argument and the usage is
> hideous.
> 
> Seperate the actual free path out and use it for unhashed timers. Provide a
> function for hashed timers.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
