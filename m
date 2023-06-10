Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EBC72AF5F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 00:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjFJWIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 18:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFJWIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 18:08:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F9E3A87
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 15:08:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 401D761655
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 22:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9C1C433D2;
        Sat, 10 Jun 2023 22:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686434890;
        bh=MCsFvVy435UaO9a2k6Ch4D0TT3bNe+I9J5W8nx6Qeb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kxN1UvBnTCZQG40Rtk8MCWrbWMEX/vfsaNnkp7tb4aTwwvgq/moKjS4R3oQ4+v0u9
         L+46ZjVNWlrmWdkhMRJRzFFutZkW6pETOoy9rHjRDxoUBkdxzkcLOwG7bRrC3iSlpN
         dR2fI0Wa6dWu/Wd2hWBsZMwfvGWemLvsZwZTfRTE=
Date:   Sat, 10 Jun 2023 15:08:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "open list:VMALLOC" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: Re: [PATCH] mm/vmalloc: Replace the ternary conditional operator
 with min()
Message-Id: <20230610150809.babdc5a7919258f066c8637e@linux-foundation.org>
In-Reply-To: <ba45584f-41a2-4d06-8443-e7e64375b07f@lucifer.local>
References: <20230609061309.42453-1-luhongfei@vivo.com>
        <832d7c69-ffd5-4764-8ffe-3a02bef0efb0@lucifer.local>
        <3fc87d60-4e81-4f49-95f0-0503ad5cdf35@lucifer.local>
        <f53f28de489f4c209776e404323ef5a1@AcuMS.aculab.com>
        <ba45584f-41a2-4d06-8443-e7e64375b07f@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2023 22:06:35 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:

> > > OK, as per the pedantic test bot, you'll need to change this to:-
> > >
> > > num = min_t(size_t, remains, PAGE_SIZE);

PAGE_SIZE is a nuisance.  It _usually_ creates the need for a
cast:

hp2:/usr/src/linux-6.4-rc4> grep -r "min(.*PAGE_SIZE" . | wc -l 
117
hp2:/usr/src/linux-6.4-rc4> grep -r "min_t(.*PAGE_SIZE" . | wc -l 
279

Perhaps it should always have been size_t.  

I suppose we could do

#define PAGE_SIZE_T (size_t)PAGE_SIZE

And use that where needed.  Mainly because I like the name ;)
