Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293AF5B968A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIOIor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIOIon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:44:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18951901B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FD8EB81EA9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5D5C433D6;
        Thu, 15 Sep 2022 08:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663231480;
        bh=R6Rl/OlvLJIZv5HR2mE5eYVhd7/iw8En0Km8/MsF17c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qnKtqTjuYbMLQID9jKK84B6m8uVE2TN6PNBwzUVIx/kR1jahm5gUUh2EBhloDoxPg
         3w6/bXToHADlvNNZzDDub8QY18UIOTI1cZmeNnJRim2bdGw8aDn9Jq4W7QVjN9B8m5
         p+3kQ/9dYTX+hnpkSOPxWcRmqObedFhnDktiklrU=
Date:   Thu, 15 Sep 2022 10:45:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     forest@alittletooquiet.net, philipp.g.hortmann@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vt6655: replace spin_lock_irqsave with spin_lock
Message-ID: <YyLmEpJBG7fPZ8iN@kroah.com>
References: <20220914080016.67951-1-namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914080016.67951-1-namcaov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 10:00:17AM +0200, Nam Cao wrote:
> In vt6655 driver, there is a single interrupt handler: vnt_interrupt(),
> and it does not take the spinlock. The interrupt handler only schedules
> a workqueue, and the spinlock is taken in this workqueue. Thus, there is
> no need to use spin_lock_irqsave, as the spinlock is never taken by an
> interrupt. Replace spin_lock_irqsave (and spin_unlock_irqsave) with
> spin_lock (and spin_unlock).

What is the speed difference before and after this change?  And how are
interrupts properly handled anymore in this driver if you took away the
lock that was being accessed in the irq?

thanks,

greg k-h
