Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A664064A3CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiLLO4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiLLO4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:56:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56DA337
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 06:56:37 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670856996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=axrL0CHYZBv6OV84rxaZQdEI1yP5vjjvKefzt9etH+o=;
        b=IL0dpYsaYtMRMinXPsrWS7QGyLn1i6soNXluG+o6tnbsNgkXMTYeRikn+NSzheApF/3wGT
        4iHfWGPTb8fL33JVmBVPq4MTcADBtOxU3EF/EIxJFWUagRePSJFlV+0juTB8C0rWwxTcuS
        hGzn3ST+oQsTd3eC+TqpltrS03aI2yuIi3hEv/lBDq+zRmfdMT/04hXNLWGbJLwQUCqRUv
        YD4vFGNZ8GzMkPoOGgXEV7tLuz4Nnuf/0bqLkflCnA0zaT8/yCjU+NcBtKh7/ZoEdWk+C9
        CewoL6fT8Oez+ZKq//uiLzdnRQN9Do8plY4WqGv8vOQ4dxogBQNTBREsAFxWbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670856996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=axrL0CHYZBv6OV84rxaZQdEI1yP5vjjvKefzt9etH+o=;
        b=zMnztmX2KE96vS8QLpTX7kjNdhvbO7m39wNSr34+xFsi79HbrvO45KXVs6atz4mh3lI68L
        e16IPro0lgvIbhAg==
To:     John Stoffel <john@quad.stoffel.home>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] irq/core for v6.2-rc1
In-Reply-To: <Y5c1ie+VE3QS5Xhz@quad.stoffel.home>
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de>
 <167083908037.564878.14292182209678650008.tglx@xen13.tec.linutronix.de>
 <Y5c1ie+VE3QS5Xhz@quad.stoffel.home>
Date:   Mon, 12 Dec 2022 15:56:36 +0100
Message-ID: <87h6y0brh7.ffs@tglx>
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

On Mon, Dec 12 2022 at 09:07, John Stoffel wrote:
>> 
>>    IMS (Interrupt Message Store] is a new specification which allows device
>>    manufactures to provide implementation defined storage for MSI messages
>>    contrary to the uniform and specification defined storage mechanisms for
>
> This sentence reads strangley to me, I'm not quite clear on what
> "uniform and specification" really means here.  Just a minor nit since
> I spent three or four re-reads trying to understand this otherwise
> really nicely written history!

Yeah, it reads a bit strange. What I wanted to say is:

   IMS has an implementation defined message store while PCI/MSI[-X] has
   a specified message store which is uniform accross all devices. That
   uniformity allowed us to get away with "global" PCI/MSI domains.

>>    The initial PCI/MSI[-X] support obviously plugged into this model which
>>    resulted in some basic shared infrastructure in the PCI core code for
>>    setting up MSI descriptors, which are a pure software construct for holding
>>    data relevant for a particular MSI interrupt, but the actual association to
>>    Linux interrupts was completely architecture specific. This model is still
>>    supported today to keep museum architectures and notorious stranglers
>
> I think you mean "stragglers" not "stranglers.  Though I'm sure you
> wanted to strangle things at points!

Indeed.

Thanks,

        tglx
