Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADD464A4B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiLLQSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiLLQSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:18:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79B13E28;
        Mon, 12 Dec 2022 08:18:14 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670861892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xj018pjLW2UkgQnmqILBUEjAhXT9K6CF9xEj+xIiOFE=;
        b=dKy70Zi3FiVNICZwR1ZmCUEpDQ3v/TY50J/4hvfbOePjz8inPzy3fENnG8eMjkELCHMY8U
        38zyt11Ffk1cmTWmB6ToWEZTugFnAY0I7ngiTNgllZaM+/f27zmb/uveKuqeVZZtLLbUow
        LstYVR6VpXbY5gzJ6o+xdFVwAJ7GacdIDVFJjzkpdqszoQeGW9ekwsbN1D4np6IJBnA+xT
        pjKnMILuN78kgX48D5Bulitb2TWj3LZFduti5L8HN3wQ0lBZZnak79HXBCp0UMxtM7ypeL
        Q7GZi2E0KgDgV3rqQzfI+t1XG7SPNTWwb6uP+Tgd3EH0S9TO5mmr8mO4QLsFOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670861892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xj018pjLW2UkgQnmqILBUEjAhXT9K6CF9xEj+xIiOFE=;
        b=wyzDgR0jttlml3luJKS9Im9oim6JOrsphSFktX57nGApgGMBCUL4+A9pqaB+oEGsO9mRnw
        m6hOMh+W+d1iIFBw==
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 19/19] irqdomain: Switch to per-domain locking
In-Reply-To: <Y5c6z3t+sV/kIMjF@hovoldconsulting.com>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
 <20221209140150.1453-20-johan+linaro@kernel.org> <87mt7sbtf9.ffs@tglx>
 <Y5c6z3t+sV/kIMjF@hovoldconsulting.com>
Date:   Mon, 12 Dec 2022 17:18:11 +0100
Message-ID: <878rjcbnp8.ffs@tglx>
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

On Mon, Dec 12 2022 at 15:29, Johan Hovold wrote:
> On Mon, Dec 12, 2022 at 03:14:34PM +0100, Thomas Gleixner wrote:
>> On Fri, Dec 09 2022 at 15:01, Johan Hovold wrote:
>> > The IRQ domain structures are currently protected by the global
>> > irq_domain_mutex. Switch to using more fine-grained per-domain locking,
>> > which may potentially speed up parallel probing somewhat.
>> >
>> > Note that the domain lock of the root domain (innermost domain) must be
>> > used for hierarchical domains. For non-hierarchical domain (as for root
>> > domains), the new root pointer is set to the domain itself so that
>> > domain->root->mutex can be used in shared code paths.
>> >
>> > Also note that hierarchical domains should be constructed using
>> > irq_domain_create_hierarchy() (or irq_domain_add_hierarchy()) to avoid
>> > poking at irqdomain internals.
>> 
>> While I agree in principle, this change really makes me nervous.
>> 
>> Any fail in setting up domain->root correctly, e.g. by not using
>> irq_domain_create_hierarchy(), cannot be detected and creates nasty to
>> debug race conditions.
>> 
>> So we need some debug mechanism which allows to validate that
>> domain->root is set up correctly when domain->parent != NULL.
>
> Lockdep will catch that due to the
>
> 	lockdep_assert_held(&domain->root->mutex);
>
> I added to irq_domain_set_mapping() and which is is called for each
> (inner) domain in a hierarchy when allocating an IRQ.

Hmm. Indeed that should do the trick.

Some comments would be appreciated as the rules around domain->root are
far from obvious.

Thanks,

        tglx
