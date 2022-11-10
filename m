Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD6F623B99
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiKJGFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKJGFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:05:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CB4DC5;
        Wed,  9 Nov 2022 22:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6AAbKG9CskNKQgfro5LqcDxTxQIzlTV8foxslfZJbyg=; b=0J5EKE2QufoxxWtDOOoBTH2Ev+
        UOH8D3xZDQl1C7+G/Y0H3P4MRBGl7yJT5e7IRrDhl30lnBVgLpRoi7HPiXXoE+PvX0d/3zXn8+tQh
        TWBEEdzvXJm+ORKGxd50mlP8f3XYZJvTiBVnyD5xJGUO1usiMA8hIh/Difpc+ygmG4zKedVbNinLa
        L6lnpe440Ul8K773/8DdXrMf6VfndZ4h041E2UN1kj/eIpgJQ+HZcVvYyulzyyCjlw0nSKQcgE+UW
        F9sXfOCCqM+8Pz7n9MGsl9Br6DrROxhw77CYva1R9HkZb+NKGIhXoPqAhDgtpYMjqoEZOuQNbMZ0T
        Q9l8NG3g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ot0gV-003Ktd-Ak; Thu, 10 Nov 2022 06:05:07 +0000
Date:   Wed, 9 Nov 2022 22:05:07 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Fix NULL vs IS_ERR checking for
 module_get_next_page
Message-ID: <Y2yUkxeBEF40olMD@bombadil.infradead.org>
References: <20221110025834.1624394-1-linmq006@gmail.com>
 <Y2x5a1YVbvmqrK9O@bombadil.infradead.org>
 <ffda7120-c2aa-d093-a2a5-f5d169c7651e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffda7120-c2aa-d093-a2a5-f5d169c7651e@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 12:18:50PM +0800, Miaoqian Lin wrote:
> Hi,
> 
> On 2022/11/10 12:09, Luis Chamberlain wrote:
> > On Thu, Nov 10, 2022 at 06:58:34AM +0400, Miaoqian Lin wrote:
> >> The module_get_next_page() function return error pointers on error
> >> instead of NULL.
> >> Use IS_ERR() to check the return value to fix this.
> >>
> >> Fixes: b1ae6dc41eaa ("module: add in-kernel support for decompressing")
> >> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> >> ---
> > Thanks queued up. How did you find out? Just code inspection? I see
> > chances are low of this triggering, but just curious how you found it.
> I found this by static analysis, specifically, I obtained functions that return error pointers and
> inspected whether their callers followed the correct specification.

Which one did you use?

  Luis
