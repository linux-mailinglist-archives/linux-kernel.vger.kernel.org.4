Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCCA63717A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 05:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiKXEZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 23:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKXEZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 23:25:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E766C9ABD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 20:25:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFDBAB826C9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DC5C433C1;
        Thu, 24 Nov 2022 04:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669263938;
        bh=vOnl+PAW/vecWK18KoII+NqVjfMzySB3kHa1v947VSI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f12NgdMoqauyCN2r9JRF0Ir96lgqOqdfJ7CMAfTzO+fTRgdOTXCfPeN32qIu+0POw
         bWUOzS5b0oHKt1lrqcF84EKQbrYA8bClwjGgAFpZVTTGzgKlXO8pXTU1Of9zYc5+Io
         WARqe5d/TFWiuX7HqxX2DfYExit7SNCneSzGJJhI=
Date:   Wed, 23 Nov 2022 20:25:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: Add check for KMEM_CACHE
Message-Id: <20221123202537.3378bf960c01f9773f6a4675@linux-foundation.org>
In-Reply-To: <20221124040226.17953-1-jiasheng@iscas.ac.cn>
References: <20221124040226.17953-1-jiasheng@iscas.ac.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
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

On Thu, 24 Nov 2022 12:02:26 +0800 Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:

> As KMEM_CACHE may return NULL pointer, it should
> be better to check the return value in order to
> avoid NULL pointer dereference in kmem_cache_zalloc.
> 
> ...
>
> @@ -2426,15 +2426,17 @@ void __init vmalloc_init(void)

Linux assumes that allocation attempts from __init code will succeed.

Because if they fail so early in the boot process, the system is so
utterly messed up that we may as well just go oops.

