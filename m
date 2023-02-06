Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FE668B523
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 06:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBFFRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 00:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBFFRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 00:17:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503D7EB68;
        Sun,  5 Feb 2023 21:17:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB89860C77;
        Mon,  6 Feb 2023 05:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF63C433D2;
        Mon,  6 Feb 2023 05:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675660627;
        bh=IOaVM/sUdZ4EOC4ES3KNjUSwD0PavkGrsos3VJBn+uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggd0HV9GyaNAjGCVVShKOLR6wV2owadaL1D+vgTGWu5ebIby/+Z+bP0svkY6aqQhD
         OQQP2kvQUvnQg8y/R2dTqeyuY0zlLcoUgLq94SBTrNL6nxCDJwcWu3u+Xt2wELzE8a
         vRxfELVHJCjLKSLwLBjnauPdJuCoaiiD/B6Uo2Mw=
Date:   Mon, 6 Feb 2023 06:17:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Converting dev->mutex into dev->spinlock ?
Message-ID: <Y+CNT5qpjrVMdvrY@kroah.com>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y95h7Vop9t5Li0HD@kroah.com>
 <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
 <Y957GSFVAQz8v3Xo@rowland.harvard.edu>
 <cf56ebc3-187a-6ee4-26bc-2d180272b5cf@I-love.SAKURA.ne.jp>
 <Y96HiYcreb8jZIHi@rowland.harvard.edu>
 <917e1e3b-094f-e594-c1a2-8b97fb5195fd@I-love.SAKURA.ne.jp>
 <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
 <c7fb01a9-3e12-77ed-5c4c-db7deb64dc73@I-love.SAKURA.ne.jp>
 <20230206025629.1786-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206025629.1786-1-hdanton@sina.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 10:56:29AM +0800, Hillf Danton wrote:
> On Sun, 5 Feb 2023 11:46:06 -0500 Alan Stern <stern@rowland.harvard.edu>
> > 
> > And by the way, by disabling lockdep validation I am declaraing that 
> > enabling it would cause an overwhelming number of false positives, 
> 
> Could you share 5 false positives you see upstream to help understand how
> it is useless?

Please see this other email in this thread:
	https://lore.kernel.org/r/Y98FLlr7jkiFlV0k@rowland.harvard.edu
