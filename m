Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5686D1207
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjC3WSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjC3WSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:18:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11128B47F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:18:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C2A5621BB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8D3C433EF;
        Thu, 30 Mar 2023 22:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680214727;
        bh=J6+yEMlbNsjNChezrO163A6g35jo86cAh2v0lik6h6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iZ/wQMpkWb4s0aY/X31v5rqUAUvTqDBmTw7ZekRAv+F0th/P+6EEZFRNNobe8SWcz
         FCDN+oQE7zdIdgp01NP3R8bu4Lv77fXpSJk/3f5a6o7XFVcIfmWd3taWcjGrdK4ZCP
         HVund6J9Uejk+L/1aBCT00wUt8jhxQEvurav9wUk=
Date:   Thu, 30 Mar 2023 15:18:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Gow <davidgow@google.com>
Subject: Re: [PATCH 0/4] log2: make is_power_of_2() more generic
Message-Id: <20230330151846.fdbc8edbfbaa6eaddb056dc7@linux-foundation.org>
In-Reply-To: <549987e4967d45159573901d330c96a0@AcuMS.aculab.com>
References: <20230330104243.2120761-1-jani.nikula@intel.com>
        <20230330125041.83b0f39fa3a4ec1a42dfd95f@linux-foundation.org>
        <549987e4967d45159573901d330c96a0@AcuMS.aculab.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 21:53:03 +0000 David Laight <David.Laight@ACULAB.COM> wrote:

> > But wouldn't all these issues be addressed by simply doing
> > 
> > #define is_power_of_2(n) (n != 0 && ((n & (n - 1)) == 0))
> > 
> > ?
> > 
> > (With suitable tweaks to avoid evaluating `n' more than once)
> 
> I think you need to use the 'horrid tricks' from min() to get
> a constant expression from constant inputs.

This

--- a/include/linux/log2.h~a
+++ a/include/linux/log2.h
@@ -41,11 +41,11 @@ int __ilog2_u64(u64 n)
  * *not* considered a power of two.
  * Return: true if @n is a power of 2, otherwise false.
  */
-static inline __attribute__((const))
-bool is_power_of_2(unsigned long n)
-{
-	return (n != 0 && ((n & (n - 1)) == 0));
-}
+#define is_power_of_2(_n)				\
+	({						\
+		typeof(_n) n = (_n);			\
+		n != 0 && ((n & (n - 1)) == 0);		\
+	})
 
 /**
  * __roundup_pow_of_two() - round up to nearest power of two
_

worked for me in a simple test.

--- a/fs/open.c~b
+++ a/fs/open.c
@@ -1564,3 +1564,10 @@ int stream_open(struct inode *inode, str
 }
 
 EXPORT_SYMBOL(stream_open);
+
+#include <linux/log2.h>
+
+int foo(void)
+{
+	return is_power_of_2(43);
+}
_


foo:
# fs/open.c:1573: }
	xorl	%eax, %eax	#
	ret	


Is there some more tricky situation where it breaks?
