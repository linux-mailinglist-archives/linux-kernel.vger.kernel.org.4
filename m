Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7077A62353D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiKIVAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiKIU7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:59:44 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9B34AF15
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1668027379; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:in-reply-to:
         references; bh=9KieeXyKN/pJkENmyvbFpQPwDh+hPiMv5FQ81nK4d3Y=;
        b=CpM4wkqhDvYZr8qOEmQicXjS2BxV2b6rWkxKt86AGXK7W/Ygg22REo3jQdbfP0YTTkA64p
        9oNsrnMzjZZ5GpB+DmOgNg9KL9n6ULq46wTliQkDXgFiTaILSi3x4UpKwC6hpv9YE8WJY1
        o5GQ8UwftyC9Ucfk86+dlpVQFE4GlSo=
Date:   Wed, 09 Nov 2022 20:56:08 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: Deprecating and removing SLOB
To:     vbabka@suse.cz
Cc:     42.hyeyoo@gmail.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, cl@linux.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, rientjes@google.com, rkovhaev@gmail.com,
        roman.gushchin@linux.dev, torvalds@linux-foundation.org,
        willy@infradead.org
Message-Id: <K5M3LR.3O50LSSSY5L3@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlastimil,

I was actually using SLOB until recently for a device flasher program 
(kernel + initramfs + dtb, booted over USB) for Ingenic SoCs. I picked 
SLOB just because it said "embedded systems" in menuconfig and some of 
my boards have as little as 32 MiB RAM.

It worked fine on some boards, but on others it had about a 25% chance 
of booting, and 75% chance of hanging at boot. I tried printk-debugging 
it, and was coming to the conclusion that it's memory corruption of 
some sort.

Then I switched to SLUB and all the problems are gone. Same with SLAB.

So while I can't say for sure that SLOB is broken (it might be 
triggering a bug somewhere else), I am highly suspicious that it is.

So yeah... axe it.

Cheers,
-Paul


