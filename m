Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E87272338E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjFEXK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjFEXKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:10:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2891BE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 16:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3489A6227E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5715BC433EF;
        Mon,  5 Jun 2023 23:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686006653;
        bh=lsPQl14SOHzCyq2ZcU8cv+2X6UzjCIK7sMnCYAcTMRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RzA2RZhaWfYhWC0ZlKJmz7T7oZMWQYPd8yOHDzwVgUI3+VBtWPZmdu1vNCoMS/Cgb
         8FGSydi/jWKMpZ9tRtR9J+RGkpsbLIEjirzGds7UXKGomcM2H+UcoIISbzWG4IA+g1
         rPLXCgnPihI7iIEhOCF7lRQd0UHrT/VvHlChyamA=
Date:   Mon, 5 Jun 2023 16:10:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, chenhuacai@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] kthread: Unify kernel_thread() and
 user_mode_thread()
Message-Id: <20230605161052.033ebe4cecc0a9c879d43f56@linux-foundation.org>
In-Reply-To: <20230603015302.1768127-1-chenhuacai@loongson.cn>
References: <20230603015302.1768127-1-chenhuacai@loongson.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  3 Jun 2023 09:53:02 +0800 Huacai Chen <chenhuacai@loongson.cn> wrote:

> Commit 343f4c49f2438d8 ("kthread: Don't allocate kthread_struct for init
> and umh") introduces a new function user_mode_thread() for init and umh.
> 
> init and umh are different from typical kernel threads since the don't
> need a "kthread" struct and they will finally become user processes by
> calling kernel_execve(), but on the other hand, they are also different
> from typical user mode threads (they have no "mm" structs at creation
> time, which is traditionally used to distinguish a user thread and a
> kernel thread).
> 
> So I think it is reasonable to treat init and umh as "special kernel
> threads". Then let's unify the kernel_thread() and user_mode_thread()
> to kernel_thread() again, and add a new 'user' parameter for init and
> umh.
> 
> This also makes code simpler. 

Seems fair enough.

If we're attached to the naming then we could do

static inline pid_t user_mode_thread(int (*fn)(void *), void *arg,
				     unsigned long flags)
{
	return __kernel_thread(fn, arg, flags, 0);
}

static inline pid_t kernel_thread(int (*fn)(void *), void *arg,
				     unsigned long flags)
{
	return __kernel_thread(fn, arg, flags, 1);
}

(and pass the 4th arg straight into .kthread to avoid the !user thing)


But the naming isn't very good anyway.  Should have been
usermode_thread/kernel_thread or user_thread/kernel_thread.


