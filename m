Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2CE624691
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiKJQGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiKJQGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:06:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F4E3F071
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sh+Eq5Dk15P6ndaVpkL3ckTA6jJzcBON6KZfnjteXnU=; b=nOz95vtQlvdRV9Wyk0yMubFZo9
        /ecJMZpJvGYHxyEsaydC1Mz7einS7Hc65UzuSRGjiue6CsglJ9V/oUr3TO0m/X0xOhYDdcNJUP6r7
        8lLEJ44cGZ+g9TstpOa2887BrPUpc1OOGDEemN20sjoD30ikaEvs3Hgq09BfadXfGyZxemQzm3YJj
        lgdNA0WeHR7FEk04chP0xiNyqE343Gl0KA2Q/Z/ALVvAme2E4uvcKYmyfkGZmClV4UylqDJx2FcJa
        Xd1TvnXau51f4VWrdf3f+g8/GjN/ZmYQpLDHFvyCvYcOxlaQ3U96XvMWi+VizxGT4GLOW7nskO+Mo
        O+tK7Jmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otA4g-00CCCM-Sr; Thu, 10 Nov 2022 16:06:42 +0000
Date:   Thu, 10 Nov 2022 16:06:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rongtao@cestc.cn, wuchi.zero@gmail.com
Subject: Re: [PATCH] lib/radix-tree: Fix uninitialized variable compilation
 warning
Message-ID: <Y20hkocEEoSNcSvZ@casper.infradead.org>
References: <20221109162348.3dbde3a7942c303af012276c@linux-foundation.org>
 <tencent_B7D657EF5135C40D0303A1C3AC90CB0B9507@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B7D657EF5135C40D0303A1C3AC90CB0B9507@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 01:00:42PM +0800, Rong Tao wrote:
>  	radix_tree_load_root(root, &node, &maxindex);
> -	if (index > maxindex)
> +	if (index > maxindex || !node)
>  		return NULL;

No, stop it, you don't know what you're doing.
