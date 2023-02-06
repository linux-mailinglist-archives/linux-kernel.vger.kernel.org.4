Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2E668B4F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 05:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBFEou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 23:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBFEon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 23:44:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED16615543;
        Sun,  5 Feb 2023 20:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vnoxxnFupsctnz6PYmQvdvAVDmQ6Sog6ZUyHJ5kggYs=; b=c77iJQ/wF72o+8X2qH2VVeUYy/
        pMn9C95oNhdcjSzx3+dRwU3ungMEHHYItlf7JDThl7+h0LMGkQAyPZVrJrwZBwAbOu3MY8cnTUw15
        eWlKKCmMIdmZk3Z7hrX8gUFJ5DPQBQCwcBPPZd9Mzhk++k0pN5FFlxIUXAGiozfQgI0W/mr7+ujpB
        cdKQNUuyC4lQPyz4q8q4WZOqcO9hh7mvgpdg/Ks2+tbwXXXOOkmnA+YO1S1RXSksYjoVpCjG3KL9q
        PjNTY0XSxU2X2Da5KRjpSH+WIscWKX2E3L2K08mBeAmZ9q/qG80XJUpr2wBfKB+z92CSbvBS7vnB6
        4aseEvkg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOtMX-00GTNl-N0; Mon, 06 Feb 2023 04:44:17 +0000
Date:   Mon, 6 Feb 2023 04:44:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Converting dev->mutex into dev->spinlock ?
Message-ID: <Y+CFofRj7EYefqUR@casper.infradead.org>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

I've asked you before to stop cc'ing linux-mm on things which aren't
about memory management.  Now I'm asking you publically.
