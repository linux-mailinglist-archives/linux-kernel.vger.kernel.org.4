Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7C7734881
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 23:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjFRVLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 17:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFRVLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:11:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B245A13D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 14:11:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687122689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GwQ6tdCRQC0L7zhpMOUJ1CJD2ZlCX4o0yfokVsjVIgE=;
        b=OaivsfqLUAqqeHyFHeYgiY0Lu+JRsonRk0u+lqXqhSMqBBBSpizfZhPONaopuWEMQ5YsGJ
        p5Tm5JdsE4TdY4LJkv0bCk84jq3mx8ntfTjdC4rqeZxhMrZFeFbMre32nUH3CJArXzSY7F
        /iCSgseXhY6zL0ZZ2VRHxGQXuQ46HxVG2UMDkaE5fbpJLAQfKsjXw4WcemKY0RbY6bvnoS
        ZeBetZdmHBdLeTpcNvBggMNH0lm7Xk0s4UVJsvz+x2yGmsTits6r0LFrWT27+MWCLsKOaK
        LbUDoYlnV5JdFuIMc2i3jbmCwssQGYt6UuUPI+PK6yjv7yaP5kPjkU8YxfXwMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687122689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GwQ6tdCRQC0L7zhpMOUJ1CJD2ZlCX4o0yfokVsjVIgE=;
        b=EKhU0/bXTUkbQDGn6jKNogB7ljcRUBLKnifnpvoueFtLMPt+j60WH6aQKJxU4XAU72LWOv
        ebkhYWcAu1Z6FpCQ==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH v3 3/5] x86/entry: Compile entry_SYSCALL32_ignore
 unconditionally
In-Reply-To: <20230616125730.1164989-4-nik.borisov@suse.com>
References: <20230616125730.1164989-1-nik.borisov@suse.com>
 <20230616125730.1164989-4-nik.borisov@suse.com>
Date:   Sun, 18 Jun 2023 23:11:28 +0200
Message-ID: <87pm5sqxvj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16 2023 at 15:57, Nikolay Borisov wrote:
> In upcomiing patches entry_SYSCALL32_ignore() could be used even if

comiing?

> CONFIG_IA32_EMULATION is selected but IA32 support is disabled either
> via CONFIG_IA32_EMULATION_DEFAULT_DISABLED or the runtime override.i

override.i ?

Aside of the lack of a spell checker, this sentence is not really
well structured and helpful.

You already introduced CONFIG_IA32_EMULATION_DEFAULT_DISABLED in the
first patch, which is questionable to start with because the config
switch is only fully functional when everything is in place.

So up to that point the command line option and the config switch can
create inconsistent state, no?

So the right thing to do is to introduce the global variable which
controls that first. As it is 'false' it won't do anything, but allows
you to build up the code. The last step adds the config option and the
command line parsing.

Then the changelog might read like this:

 "To limit the IA32 exposure on 64bit kernels while keeping the
  flexibility for the user to enable it when required, the compile time
  enable/disable via CONFIG_IA32_EMULATION is not good enough and will
  be complemented with a kernel command line option.

  Right now entry_SYSCALL32_ignore() is only compiled when
  CONFIG_IA32_EMULATION=n, but boot-time enable- / disablement obviously
  requires it to be unconditionally available.

  Remove the #ifndef CONFIG_IA32_EMULATION guard"

The point is that changelogs need to convey enough information on their
own that they make sense without having access to the full context of the
patch series.

Thanks,

        tglx
