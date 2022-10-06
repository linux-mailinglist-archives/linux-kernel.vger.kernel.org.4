Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F4B5F6F39
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiJFUds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiJFUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:33:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E087BB06D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 13:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09EFA61AD1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 20:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E44C433C1;
        Thu,  6 Oct 2022 20:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1665088412;
        bh=dZZ9imJ1cDp8lJ48SMN+iYyF9XUEQ3s5LkCT1Jrg6Kc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yuNoVAdxTDyNOu7Ww1D1JTc/yiTXv0IPOEi7FNbJZYvpD61D/mH59aUQYwIuY6FE2
         NXLa6q+kcyhkcH/GZh6ZxaS7KDkrHhcBzfEv4UgirfWyPBNU1bdjT1zlqvNw+c8eN2
         /u1insyoLGQ+qyrq7O/iN3teAa72t1uTi0Ap5yYE=
Date:   Thu, 6 Oct 2022 13:33:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     ira.weiny@intel.com
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] highmem: Fix kmap_to_page() for kmap_local_page()
 addresses
Message-Id: <20221006133331.dabd345508f7d62a887dfb4d@linux-foundation.org>
In-Reply-To: <20221006040555.1502679-1-ira.weiny@intel.com>
References: <20221006040555.1502679-1-ira.weiny@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Oct 2022 21:05:55 -0700 ira.weiny@intel.com wrote:

> kmap_to_page() is used to get the page for a virtual address which may
> be kmap'ed.  Unfortunately, kmap_local_page() stores mappings in a
> thread local array separate from kmap().  These mappings were not
> checked by the call.
> 
> Check the kmap_local_page() mappings and return the page if found.
> 
> Because it is intended to remove kmap_to_page() add a warn on once to
> the kmap checks to flag potential issues early.

What were the user-visible runtime effects of this?

Are we able to identify a Fixes:?

Thanks.

