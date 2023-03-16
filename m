Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2396BD895
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCPTGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCPTGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:06:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA53BE4C45;
        Thu, 16 Mar 2023 12:05:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E2DCCCE1E5A;
        Thu, 16 Mar 2023 19:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7403C433EF;
        Thu, 16 Mar 2023 19:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678993541;
        bh=wjh2dd6lKSLs2YgB0hRb+ax32RoOsNp6xz0wdCimzaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R9l5hz/gTNcxXqnCo6cPF6w/aZoYgiqhtcmpNn8dz9mf369mLTWQI9s4M9uqonUHU
         LrpWgMf4y2LLoa7dNVdtYcPyjLJlzu2YBoyPrE/AEvT/MsUHHY9//ua77KOVp8mMUQ
         3nPOUnKcthpfB4ZJM1LMI9yC4UAR+ilpkfnjedqM=
Date:   Thu, 16 Mar 2023 20:05:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Valery Zabrovsky <valthebrewer@yandex.ru>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
        Felipe Balbi <balbi@ti.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] usb: gadget: net2280: fix NULL pointer dereference
Message-ID: <ZBNogj/To3j5OiQK@kroah.com>
References: <20230316155356.13391-1-valthebrewer@yandex.ru>
 <ZBNBlwc9lt+pLFkd@kroah.com>
 <2be27aee-1a2d-4c5c-bb62-018e1340d2ad@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2be27aee-1a2d-4c5c-bb62-018e1340d2ad@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 02:22:35PM -0400, Alan Stern wrote:
> On Thu, Mar 16, 2023 at 05:19:35PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Mar 16, 2023 at 06:53:55PM +0300, Valery Zabrovsky wrote:
> > > In net2280_free_request():
> > > If _ep is NULL, then ep is NULL and is dereferenced
> > > while trying to produce an error message.
> > 
> > How can that ever happen?  How did you test and hit this?
> > 
> > > The patch replaces dev_err() with pr_err() which works fine.
> > 
> > That's not a good idea for driver code to use, sorry.
> > 
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > As I have said before, your testing framework needs a lot more work.
> > 
> > good luck!
> 
> In situations like this, it might be better to remove the check 
> entirely.  If a driver does pass a NULL pointer, it will lead to an 
> invalid pointer dereference which will certainly cause an oops and might 
> very well crash the system.  That would be a lot more noticeable than an 
> error message hidden in a kernel log!
> 
> Greg, is there any general policy about the need for sanity checks such 
> as this one?  Like, don't put them in whenever a failure would lead 
> to an immediate fault which would be easy to track down?

That's the policy, no need to check if a caller is abusing the code and
will find out instantly.  Otherwise we end up checking on every
function, and that way lies madness.

thanks,

greg k-h
