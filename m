Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB256DA5F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjDFWo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjDFWo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:44:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A793F7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B42464B83
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 22:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AC2C433EF;
        Thu,  6 Apr 2023 22:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680821064;
        bh=hePkiz4mZ331h2P6XlWg7tPrOwSzlUT0/Se3rTSdPX4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VPxzw7lhaAGELngejI5UV7bUtG+uPGUP12mrFXj3nAf78kjSDURF8dkO7xNGaa96l
         RjxJQ2gR8p5GAH9vu0VFlrER3Otxu4RyLxzVHx+DO029EvH7boQ+j5DppkMsey1qgd
         e7BekUPzKJWacD7gUdKs93vjs/uknYY7Ls8hbsKc=
Date:   Thu, 6 Apr 2023 15:44:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Guenter Roeck <linux@roeck-us.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm-treewide-redefine-max_order-sanely-fix.txt
Message-Id: <20230406154423.20a991bbdd47630fc38d94e8@linux-foundation.org>
In-Reply-To: <ZC82N4sP5xE63kl4@kernel.org>
References: <9460377a-38aa-4f39-ad57-fb73725f92db@roeck-us.net>
        <20230406072529.vupqyrzqnhyozeyh@box.shutemov.name>
        <83e6bc46-dfc0-0e95-e69c-5b996af1e50b@roeck-us.net>
        <20230406151015.yndcm24fyxitvqyc@box.shutemov.name>
        <ZC82N4sP5xE63kl4@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023 00:14:31 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> > > Shouldn't that be
> > > 		else
> > > 			order = 0;
> > > ?
> > 
> > +Mike.
> > 
> > No. start == 0 is MAX_ORDER-aligned. We want to free the pages in the
> > largest chunks alignment allows.
> 
> Right. Before the changes to MAX_ORDER it was
> 
> 		order = min(MAX_ORDER - 1UL, __ffs(start));
> 
> which would evaluate to 10.
> 
> I'd just prefer the comment to include the explanation about why we choose
> MAX_ORDER for start == 0. Say
> 
> 	/*
> 	 * __ffs() behaviour is undefined for 0 and we want to free the
> 	 * pages in the largest chunks alignment allows, so set order to
> 	 * MAX_ORDER when start == 0
> 	 */

Meanwhile I'd like to fix "various boot failures (hang) on arm targets"
in -next, so I queued up Kirill's informal fix for now.

