Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9143D6267C5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiKLHsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiKLHsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:48:04 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3B8710C6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:48:02 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2AC7lxuu005221;
        Sat, 12 Nov 2022 08:47:59 +0100
Date:   Sat, 12 Nov 2022 08:47:59 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     A <amit234234234234@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Setting variable NULL after freeing it.
Message-ID: <20221112074759.GA5111@1wt.eu>
References: <CAOM0=dbwNs1XcnD0i+SrC1S-SNFEGXM5G8QrVCqAxaz=YkAEFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOM0=dbwNs1XcnD0i+SrC1S-SNFEGXM5G8QrVCqAxaz=YkAEFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 11:47:39AM +0530, A wrote:
> Hi,
> 
> I am writing a linux kernel driver for a new device.
> 
> Is it a good practice to set variable NULL after freeing it?
> 
> Something like this -
> 
> kfree(x);
> x = NULL;
> 
> Please let me know.

It depends. What's important is not to let a pointer exist to a freed
location, so if you're doing:

    kfree(card->pool);

then it's usually important to follow this by:

    card->pool = NULL;

so that no code stumbles upon that rotten pointer. Similarly if you're
freeing a variable in the middle of a function or inside an "if" block,
it's wise to reset the pointer so that it doesn't continue to exist
further in the function, and is visually easier to track for anyone
reviewing that code.

But a lot of kfree() calls exist in return paths and are only followed by
other kfree() and a return statement. In this case, it can be completely
useless to NULL a local variable that was just freed as the variable
stops existing when returning. For example, below nullifying the pointers
wouldn't bring anything:

   kfree(card->pool);
   kfree(card);
   return -EBUSY;

A good way to check common practices is to check with git grep how
current code already deals with this:

   $ git grep -wA3 kfree

You'll notice that all practices indeed exist.

Willy

PS: you could more easily get responses in the future by associating a
    real name with your address instead of just "A" which makes it look
    like a spam.

