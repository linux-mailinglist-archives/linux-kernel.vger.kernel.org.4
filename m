Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E39062692D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 12:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiKLLeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 06:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiKLLeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:34:15 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B04CE23E8F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:34:12 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2ACBYABf005559;
        Sat, 12 Nov 2022 12:34:10 +0100
Date:   Sat, 12 Nov 2022 12:34:10 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     A <amit234234234234@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Setting variable NULL after freeing it.
Message-ID: <20221112113410.GA5553@1wt.eu>
References: <CAOM0=dbwNs1XcnD0i+SrC1S-SNFEGXM5G8QrVCqAxaz=YkAEFg@mail.gmail.com>
 <20221112074759.GA5111@1wt.eu>
 <CAOM0=daopCt=LthGStL2zHYxgQ6iphLLfKZjxcPS07yCvyq42Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOM0=daopCt=LthGStL2zHYxgQ6iphLLfKZjxcPS07yCvyq42Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 04:18:37PM +0530, A wrote:
> >
> > It depends. What's important is not to let a pointer exist to a freed
> > location, so if you're doing:
> >
> >     kfree(card->pool);
> >
> > then it's usually important to follow this by:
> >
> >     card->pool = NULL;
> >
> 
> I checked in kernel but at many places this is not being done. I can
> change all that code. But, will the patch be accepted?
> 
> So, if someone is doing -
> 
> kfree(x)
> ._some_code_
> ._some_code_
> ._some_code_
> 
> Then I can change it to -
> 
> kfree(x)
> x = NULL;
> ._some_code_
> ._some_code_
> ._some_code_
> 
> But, will the patch be accepted for this change?

I don't think so, for the reasons I explained previously,
unless you spot real bugs there during your reviews, of
course. Better focus on your own driver for now in my
opinion.

Willy
