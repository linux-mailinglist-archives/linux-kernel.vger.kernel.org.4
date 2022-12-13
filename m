Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE81164AEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 05:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiLMEXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 23:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiLMEXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 23:23:06 -0500
X-Greylist: delayed 267 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Dec 2022 20:23:03 PST
Received: from forward502o.mail.yandex.net (forward502o.mail.yandex.net [37.140.190.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529291740B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 20:23:00 -0800 (PST)
Received: from vla1-27b4fc0f1fa3.qloud-c.yandex.net (vla1-27b4fc0f1fa3.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:4201:0:640:27b4:fc0f])
        by forward502o.mail.yandex.net (Yandex) with ESMTP id 0D2D025D443D;
        Tue, 13 Dec 2022 07:22:58 +0300 (MSK)
Received: by vla1-27b4fc0f1fa3.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id tMVDeNaYXCg1-tjJcnLt3;
        Tue, 13 Dec 2022 07:22:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1670905378;
        bh=UvnO6f8dyhL/ELqY09veHu8BFHmio9ASdejuQvol6do=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=XYssop3PfYQ2OJNMhyyA9tjp6P/WPsFR9uoskY4dPWgfUFlSc1mnsvS/yAFdfRzkc
         NlLTP+8i+c+FxgtITt1sTjFbabzfc0bx9qXofDss/arIpX1Yy5cyio0DphSxrAV7p+
         Dgrhsr4cPA75wVa330zdV2UQPBbLQRocXIvBEKcU=
Authentication-Results: vla1-27b4fc0f1fa3.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <2eb31555-f915-366c-6fa3-29f8522be149@yandex.ru>
Date:   Tue, 13 Dec 2022 09:22:54 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: strange behavior with sigreturn() to 32bit
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <85ca9ae1-d319-ee77-4a71-bc9c7874f2cb@yandex.ru>
 <b2896f0c-5e0d-43c9-8ead-487bf1572168@app.fastmail.com>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <b2896f0c-5e0d-43c9-8ead-487bf1572168@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


13.12.2022 02:59, Andy Lutomirski пишет:
> I generally distrust gdb when mixed modes are involved -- it's fundamentally intensely buggy.  Now maybe you're not hitting the bugs I know of, but still...
>
> Anyway, the behavior I expect (not that I've tested this, but based on my memory of how this is all supposed to work) is that an attempt to return to user mode will fail with #GP because the full value of RIP is compared to the segment limit, which is 2^32-1.  And #GP is 0xd, so your non-gdb outputs look broadly correct...
Yes, that may explain the problem.
So where is this check? And should it
be fixed to apply the mask to RIP?
Or should I always clear high parts
by hands? If so - only for RIP?
