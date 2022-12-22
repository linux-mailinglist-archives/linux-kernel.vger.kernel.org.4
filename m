Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A41653C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiLVGqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiLVGqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:46:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529BFE9F;
        Wed, 21 Dec 2022 22:46:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2D2E6198C;
        Thu, 22 Dec 2022 06:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE36C433EF;
        Thu, 22 Dec 2022 06:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671691594;
        bh=r+TpYUu1H/6E+XARhFn5KV+cckPTe7hXDUGCZhWSdRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V10UhZ//K95coireqWbC3aUHFG1mVQ4j0yW4D8fDuXTH689cms1MA3Y3DkDpVQmqf
         YAFeAyTVVHzZMAxhws0G5bIlGTsFipr6oB1pUojpILcmQxXV7rAEiT9KnermvtAKEb
         zeJk0M9NnUBlyfmBQXA3Blivreb8eLoc2I1YPwM0=
Date:   Thu, 22 Dec 2022 07:46:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jimmy Hu <hhhuuu@google.com>
Cc:     mathias.nyman@intel.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: xhci: Check endpoint is valid before
 dereferencing it
Message-ID: <Y6P9R36yrOnDpyVz@kroah.com>
References: <20221222024630.1812735-1-hhhuuu@google.com>
 <Y6PxuFPfKM0sttAr@kroah.com>
 <CAJh=zjKv-h0LT68rzDTTi=AA-8jBv+ke5DKW9M0v6Y9Qte-rfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJh=zjKv-h0LT68rzDTTi=AA-8jBv+ke5DKW9M0v6Y9Qte-rfQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Dec 22, 2022 at 02:39:16PM +0800, Jimmy Hu wrote:
> The xhci_kill_endpoint_urbs() function was added in commit 50e8725e7c42 -
> 2014-03-04 xhci: Refactor command watchdog and fix split string. [Sarah
> Sharp <sarah.a.sharp@linux.intel.com>]
> And then, it is called by xhci_hc_died() function added in d9f11ba9f107 -
> 2017-04-08 xhci: Rework how we handle unresponsive or hoptlug removed hosts
> [Mathias Nyman <mathias.nyman@linux.intel.com>]

Ok, so which one do you think should be used?

> Sorry. I don't know if it should also be cc: stable kernels. I use scripts/
> get_maintainer.pl to get the list.
> =========
> $ scripts/get_maintainer.pl
> 0001-usb-xhci-Check-endpoint-is-valid-before-dereferencin.patch
> Mathias Nyman <mathias.nyman@intel.com> (supporter:USB XHCI DRIVER)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
> linux-usb@vger.kernel.org (open list:USB XHCI DRIVER)
> linux-kernel@vger.kernel.org (open list)
> =========

that tool has nothing to do with copying for stable kernels as the perl
script does not know if this is a bugfix or not, right?  Please read
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

thanks,

greg k-h
