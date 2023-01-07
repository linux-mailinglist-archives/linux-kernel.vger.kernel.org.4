Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E4F660D4A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjAGJgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjAGJgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:36:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A187CBDD
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 01:36:26 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bk16so3305583wrb.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 01:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDJKgyIyO2UXr7CrAfsDllc88gRt2ZKj/J0suyfMPL8=;
        b=TLDDT3lhbvwE5i2u0vta/FX9oB16gdBUm6xwRmq+nmnTpK6o6wAsILYF8LoQAou0Ub
         CFQsk42dpbxzGjRSh5k2rsYzHUOySPGo3y/o2T4oCPZOIsWcbB/yxYSxH8NNB9Zr9X9h
         JVTwXubfClY3AAJM4OnWB2F0WfxXhkitcV/bZmLVzfvA8PumCe5LU3M9U86H4sjOtsbO
         xUz9k4F+sGySkn7AmLWbBH8mlqA5Bm6M8TZMLsP2k0grtnL+OcjDyZ6mOdqroDNbsUZ4
         4BxknWr96sEySMlNFm9dJGD5uw7Mrnqg1ARw9hlicYTZGLLZuwUZdyTq/W5vTtx97Hle
         2dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDJKgyIyO2UXr7CrAfsDllc88gRt2ZKj/J0suyfMPL8=;
        b=UguMqa+JcegCbAljmZgHk4zuy15rNIsohn55KAYoBldv06ToI8l+8GUaiupCSPcuZo
         IELcHIDMgSFgBYDDLqeB8bIuXLXK5WA5DYmMLjVowRnPcDYs0ngCtHuu1FiLJ3aBaKnd
         /1VRyv8WVK18cE0cyLVubEsUF4qw3wsLUJWqqDBU/gUYiVl8khwKB2OUNYwj4kD8r0dp
         5dtj/Po/UKOOH/vtdQuchdauP9+plfrpyTEyJnzK7/qm9jiPTFlhtfQmlx4RnU54WNuV
         449Q4/Omgh1BqIT5d1tNXLYKbYG1Xlb9ZBpQhPJBERWZod7uWPfWhywvXw2eENzndQ2D
         P2Kw==
X-Gm-Message-State: AFqh2krJ0rf3noCjXl4mxHuVcx4SjD6GgdufYz5w8GZZ9SL7FhCJedeC
        g5KDqOLv7hfwbTfZ1Q7eePE/wEWKXmQ=
X-Google-Smtp-Source: AMrXdXvvr7ZP8eJVZD6VZJNWJ39LkbcpPn1YzGb+WeX08GXI0jhb7GIbh5bbtTn9CU5PtDphW6hAcA==
X-Received: by 2002:a5d:5304:0:b0:2a8:e91d:ad2f with SMTP id e4-20020a5d5304000000b002a8e91dad2fmr7796552wrv.35.1673084185143;
        Sat, 07 Jan 2023 01:36:25 -0800 (PST)
Received: from gmail.com (1F2EF507.nat.pool.telekom.hu. [31.46.245.7])
        by smtp.gmail.com with ESMTPSA id j14-20020adff00e000000b0024cb961b6aesm3335811wro.104.2023.01.07.01.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 01:36:24 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 7 Jan 2023 10:36:22 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 3/6] x86/microcode: Display revisions only when update
 is successful
Message-ID: <Y7k9DNz//vqBAvZK@gmail.com>
References: <20230103180212.333496-1-ashok.raj@intel.com>
 <20230103180212.333496-4-ashok.raj@intel.com>
 <Y7XMtWqSrs0uGkD7@zn.tnic>
 <Y7h5qD43kdPeEgQ7@a4bf019067fa.jf.intel.com>
 <Y7h8dpIQHnL93RdC@zn.tnic>
 <Y7iEjDrXLRlwoz0W@a4bf019067fa.jf.intel.com>
 <Y7iIZHa0fuJkHHjz@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7iIZHa0fuJkHHjz@zn.tnic>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Jan 06, 2023 at 12:29:00PM -0800, Ashok Raj wrote:
> > Yes, that makes sense, Do you think we can add a note that the loading
> > failed? since the old -> new, new is coming from new microcode rev.
> 
> It has failed when
> 
> old == new.
> 
> I.e.,
> 
> 	"microcode revision: 0x1a -> 0x1a"
> 
> when the current revision on the CPU is 0x1a.

So wouldn't it make sense to also display the fact that the microcode 
loading failed?

Seeing '0x1a -> 0x1a' one might naively assume from the wording alone that 
it got "reloaded" or somehow reset, or that there's some sub-revision 
update that isn't visible in the revision version - when in fact nothing 
happened, right?

The kernel usually tries to tell users unambigiously when some requested 
operation didn't succeed - not just hint at it somewhat 
passive-aggressively.

Thanks,

	Ingo
