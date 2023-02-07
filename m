Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412E568D43A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjBGKap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjBGKab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:30:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B3B23336
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:30:15 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675765813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lW+FfCZJwOfpEVYDYp/rEBhg3dEji20/2qZUO9LVLD0=;
        b=Q/oEOV0os83P//fjLGUyGpnuqI1JKp/Tj8tgyhaJkL3gQK57k4UGbds3P7zZ+fFuaukBhX
        jKtSDQDMr16Ax1EzmqrQwQKfSaYuCvcm7qcHlB4FEObwpYx3j3QOgZsw1+kRFBixnaO466
        Neb6J4xSTW9nzqBaXMMhRRnE56Spbs5lo0/FuPbBMINrlDDMw815n/H1y2F6Y54CSSnVK0
        mo5nFho4X+0vGRnYP/TOox8Ea4wPh54anveRlC5rn7ZmVWP94EUYxz9Avcjt3gSJrvfLPE
        gB6pHb+nqiZZQelJHoP825/SY9QViFOTje7Rj9siwX5POUveHrT53VUxBGIV0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675765813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lW+FfCZJwOfpEVYDYp/rEBhg3dEji20/2qZUO9LVLD0=;
        b=Zy9qG3YU53A48Rgfu5GVO1lr3QXqsZqpkWcs4Yc3cijAbJ4T8Odr2RkIt+f2QRLby6fBfP
        cUBHD5yQaOu3zfCQ==
To:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 5/5] genirq: Use the maple tree for IRQ descriptors
 management
In-Reply-To: <9a682773-df56-f36c-f582-e8eeef55d7f8@suse.cz>
References: <202302011308.f53123d2-oliver.sang@intel.com>
 <87o7qdzfay.ffs@tglx> <9a682773-df56-f36c-f582-e8eeef55d7f8@suse.cz>
Date:   Tue, 07 Feb 2023 11:30:13 +0100
Message-ID: <875ycdwyx6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06 2023 at 15:24, Vlastimil Babka wrote:
> On 2/1/23 14:27, Thomas Gleixner wrote:
>> Subject: mm, slub: Take slab lock with irqsave()
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Date: Wed, 01 Feb 2023 14:14:00 +0100
>> 
>> <Add blurb>
>
> Will you add the blurb, and the SLAB part, or should I? And once done should
> I put it in slab tree for 6.3 or want to make it part of the series so it's
> not blocked?

Ooops. I missed that part. Let me add slab and blurb and send it as a
proper patch. Just take it into the slab tree. The maple tree conversion
has still some issues, so I don't expect it to be 6.3 material.

Thanks,

        tglx
