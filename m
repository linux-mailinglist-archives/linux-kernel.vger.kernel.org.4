Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F1C6DB904
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 07:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjDHFI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 01:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDHFI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 01:08:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5617CA07
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 22:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E5A7619AC
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 05:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431C4C433EF;
        Sat,  8 Apr 2023 05:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680930504;
        bh=hMEeQgX30xw65Z5q9Hxes4XMGuwknIAjnyQ9W3+zVWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U2PGqOaQbO1XUtwDYVoSbhKHtUOTWSjRf4A2QByeA7z5/tGRzCszUGk9rxoDykIsM
         nNS85pMy+Jg46RcOQ8DtaDTYvLHCTctUwRKA06vh74/yRMTTefd57ywExWzNQm0Qnf
         YeUXZ2N1qyXyAtZ1Ls1coVWe807ir7hyP1p9DL6PzpuGwNRfq0e48PcAIwcSDaRIgx
         ysqM5r4OEfjSw81tR76t8BAohub0lY6pIC6agqwwAmWUVXNmwKgD5JK6CGrQSCXmlz
         rIoSygwyZ+Ala4HGHlu0keV4Xx9mA2asTK80xUFg1rXIJF3PWGqD4QGqd0KYo56Epa
         gWUg3C167/PHg==
Date:   Fri, 7 Apr 2023 22:08:22 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     peterz@infradead.org, keescook@chromium.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86: make __get_wchan() use arch_stack_walk()
Message-ID: <20230408050822.ezdbhc6j7zuvutrm@treble>
References: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
 <20230330081552.54178-3-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230330081552.54178-3-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 04:15:52PM +0800, Qi Zheng wrote:
> Make __get_wchan() use arch_stack_walk() directly to
> avoid open-coding of unwind logic.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Can we just have a shared version of __get_wchan() for all
CONFIG_ARCH_STACKWALK arches?

-- 
Josh
