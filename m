Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0FF64E539
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 01:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLPAfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 19:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLPAfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 19:35:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC4D286F8;
        Thu, 15 Dec 2022 16:35:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E78261FA8;
        Fri, 16 Dec 2022 00:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B55C433D2;
        Fri, 16 Dec 2022 00:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671150949;
        bh=3P/yzo/78yuVkIxA3TfcHI6vGJtHPM+Dxswc0v8EUn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=01wpHiTJxjp7rQ5CrWUwPYaGr64i6BcLSk5rKQ0y4yWhAOJrFQnHmhTYRpTp4GZDC
         mUtZo/RdXbYsiT5hAgPHVjWnUrpvOgSq0Be4RC4lZB2LuEAQTrVRxbsp9FRufy3EgK
         SsVar2FbJ6c8xcFKF3hN85zw7+BRgpZkKUeIZptc=
Date:   Thu, 15 Dec 2022 16:35:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-Id: <20221215163548.7c321bb0fac2343a8ef7d202@linux-foundation.org>
In-Reply-To: <20221216112121.4bcb5c43@canb.auug.org.au>
References: <20221216112121.4bcb5c43@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2022 11:21:21 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the mm tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> In file included from fs/btrfs/tree-checker.c:20:
> include/linux/error-injection.h: In function 'get_injectable_error_type':
> include/linux/error-injection.h:22:17: error: 'EOPNOTSUPP' undeclared (first use in this function)
>    22 |         return -EOPNOTSUPP;
>       |                 ^~~~~~~~~~
> include/linux/error-injection.h:22:17: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>   fcb9954aa1dc ("error-injection: remove EI_ETYPE_NONE")
> 
> I have reverted that commit for today (and the following one).

Thanks.  I'll try the obvious:

--- a/include/linux/error-injection.h~error-injection-remove-ei_etype_none-fix
+++ a/include/linux/error-injection.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler.h>
 #include <asm-generic/error-injection.h>
+#include <linux/errno.h>
 
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 
_

