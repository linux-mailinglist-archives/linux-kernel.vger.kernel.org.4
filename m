Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECD168D3D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjBGKNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjBGKNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:13:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D335559C;
        Tue,  7 Feb 2023 02:13:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675764812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xsf5OETgCKjk40J0yknbXtP96Hh6qh8QKkpexhR1k8A=;
        b=m7ANvGi/vjTssFeL4uc6AZkAOpGgl/Hql4zbY4bngNbHqEvtD3TApLsND9RLozcqPrG+fc
        v71avlT0lAxbkw06bz9jq9FQdLPoceENi5Edci57mJ9t4CXnu74ZEnkEH7GFr8a6nE3OJL
        6KRzvjbkrsqJpJff8HR8/abDd6YgihAYdGeH+G6xVeRT62Z6j+zvx72+cA0YJf2L4CyHFI
        QoQzotalmeosi/oc6jFIdqWbi1fMfRIErX1uLH0KKvAruC1jeamFBthb6uywf2hsqkZH35
        MDf3EldIk4pUVEpc+D8DuayubUL5AKjtSFev+yMmKmUkbrnGjChY1vUw3GioYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675764812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xsf5OETgCKjk40J0yknbXtP96Hh6qh8QKkpexhR1k8A=;
        b=tacUXL7t75CCj7vF3QssP5us5ynhZLqjyffVqpqdvKpy0SG4xDs4mRY+OTQXnlGweCG9y1
        y0bIXSWyjKHH7xDg==
To:     Song Liu <songliubraving@meta.com>
Cc:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Kernel Team <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v9] module: replace module_layout with module_memory
In-Reply-To: <09C6F0A2-5AE5-4D8D-87DE-BFEC2C642A49@fb.com>
References: <20230203214500.745276-1-song@kernel.org> <87cz6mxyb7.ffs@tglx>
 <09C6F0A2-5AE5-4D8D-87DE-BFEC2C642A49@fb.com>
Date:   Tue, 07 Feb 2023 11:13:32 +0100
Message-ID: <87edr1wzoz.ffs@tglx>
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

On Mon, Feb 06 2023 at 23:27, Song Liu wrote:
>> On Feb 6, 2023, at 1:45 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> +static void free_mod_mem(struct module *mod)
>>> +{
>>> + /* free the memory in the right order to avoid use-after-free */
>> 
>> How do we end up with a UAF when the ordering is different?
>
> IIUC, we need remove MOD_DATA at last, which hosts "mod".

Oh. Please add a comment to that effect.

Thanks,

        tglx
