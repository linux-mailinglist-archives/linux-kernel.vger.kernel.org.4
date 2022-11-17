Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858A662DD14
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbiKQNqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239645AbiKQNqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:46:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D087C71F29;
        Thu, 17 Nov 2022 05:46:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A8CA61E38;
        Thu, 17 Nov 2022 13:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807B5C433C1;
        Thu, 17 Nov 2022 13:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668692790;
        bh=jwrKHq8lqrVCytRmbVBCOLUIrbyqXrDKHErC15q+x7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVYUWfNzSW5qOrsXH5425h8Res0qNWH6lXbS5xlr8vmHQ/PtWZthcWDOx6KgKe4HX
         0TzcYSLuZx/hrZ4H86Bl4s0rsh2/E9hRMAbWLp4SseTVjPOaBzH7aRvWyE5shozlJF
         akUK6fXyj5hRx2pgVQEzJ3SUI83XHwuyAP+y6lWN3+5/OUu7psy51T4DCq0dZ7TSS9
         JZfDjvqS8GcOzw5fb3hkbJRuXz62MNFJtvUBT4SdyXSaq9tHp53qou1Xh/x0jkWejO
         XJUMrfQvAQwUvLwmWj/PtiPpsIHJ+NCZPqfwgkYlHouNg7X5sLGioAmXbb3M2qdX3N
         LLUDmFcEFUFGQ==
Date:   Thu, 17 Nov 2022 13:46:26 +0000
From:   Lee Jones <lee@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3Y7MlwV0UFcA3w8@google.com>
References: <20221117120813.1257583-1-lee@kernel.org>
 <Y3YuL8rSE9pNfIZN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3YuL8rSE9pNfIZN@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022, Greg KH wrote:

> On Thu, Nov 17, 2022 at 12:08:13PM +0000, Lee Jones wrote:
> > +static inline bool f_hidg_is_open(struct f_hidg *hidg)
> > +{
> > +	return !!kref_read(&hidg->cdev.kobj.kref);
> > +}
> 
> Ick, sorry, no, that's not going to work and is not allowed at all.
> That's some major layering violations there, AND it can change after you
> get the value as well.

This cdev belongs solely to this driver.  Hence the *.*.* and not
*->*->*.  What is preventing us from reading our own data?  If we
cannot do this directly, can I create an API to do it 'officially'?

I do, however, appreciate that a little locking wouldn't go amiss.

If this solution is not acceptable either, then we're left up the
creak without a paddle.  The rules you've communicated are not
compatible with each other.

Rule 1: Only one item in a data structure can reference count.

Due to the embedded cdev struct, this rules out my first solution of
giving f_hidg its own kref so that it can conduct its own life-time
management.

A potential option to satisfy this rule would be to remove the cdev
attribute and create its data dynamically instead.  However, the
staticness of cdev is used to obtain f_hidg (with container_of()) in
the character device handling component, so it cannot be removed.

Rule 2: Reading the present refcount causes a laying violation

So we're essentially saying, if data is already being reference
counted, you have to use the present implementation instead of adding
additional counts, but there is no way to actually do that, which
kind of puts us at stalemate.

Since this is a genuine issue, doing anything is not really an option
either.  So where do we go from here?

-- 
Lee Jones [李琼斯]
