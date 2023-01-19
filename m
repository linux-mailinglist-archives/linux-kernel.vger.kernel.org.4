Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EA06745CC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjASWUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjASWU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:20:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A4030DA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:03:16 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674165794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uel7La7hyJ+SpLk/s5wn/i75eVtrZzw/es9LS+wzOCU=;
        b=b7evZP3GLAocWGw1udw+K67SZFP5JBXoJbAvOampRJ0NeFOLN7sBUGzS/kFZjp2iJvhnll
        M1An8WRx2ABTxeDrZEjJHYeRC7Banh15m6V2o3PzWpUjK6+K1YrJj4+kfYnoYA532dZwCB
        x6lk3waZ+jMTploPsOoXQlM1vNXz/uDet0Goi845pkivHeeb9eT3ATK3jLOl75/PLnPIsX
        7Pn+sksCflqh90PoVAtIiiOUbdW6GQ640tYA11iQs7X0bkfjQIVYEk1mTSrz+XPYDF/uhw
        E27/T1Ck+dxvjT3kemZexvyocGXvxJ5UMD4maryUgODAyWDUnP48oKuX3eW9vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674165794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uel7La7hyJ+SpLk/s5wn/i75eVtrZzw/es9LS+wzOCU=;
        b=1jDTElfFXCkfva+yh+0rY2cYzWXD+B0dYzxVy4CfK0yrf1MMNu6AgiK88LLIUwD7rkBBxx
        hnyfBeJMTIywHyCw==
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH v1 Part2 2/5] x86/microcode/intel: Add minimum required
 revision to microcode header
In-Reply-To: <20230113172920.113612-3-ashok.raj@intel.com>
References: <20230113172920.113612-1-ashok.raj@intel.com>
 <20230113172920.113612-3-ashok.raj@intel.com>
Date:   Thu, 19 Jan 2023 23:03:14 +0100
Message-ID: <873586i3ml.ffs@tglx>
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

On Fri, Jan 13 2023 at 09:29, Ashok Raj wrote:
> In general users don't have the necessary information to determine
> whether a late loading of a new microcode version has removed any feature
> (MSR, CPUID etc) between what is currently loaded and this new microcode.

s/this new microcode/a newer microcode revision/

> To address this issue, Intel has added a "minimum required version" field
> to a previously reserved field in the file header. Microcode updates

s/file header/microcode header/ perhaps?

> should only be applied if the current microcode version is equal
> to, or greater than this minimum required version.
>
> Thomas made some suggestions[1] on how meta-data in the microcode file
> could provide Linux with information to decide if the new microcode is
> suitable candidate for late loading. But even the "simpler" option#1
> requires a lot of metadata and corresponding kernel code to parse it.
>
> The proposal here is an even simpler option.

IIRC this was also suggested by this Thomas dude, right?

> Simply "OS visible features" such as CPUID and MSRs are the only two
> examples. The microcode must not change these OS visible features
> because they cause problems after late loading. When microcode changes
> features, microcode will change the min_rev to prevent such microcodes
> from being late loaded.
>
> Pseudo code for late loading is as follows:
>
> if header.min_required_id == 0
>         This is old format microcode, block late loading
> else if current_ucode_version < header.min_required_id
>         Current version is too old, block late loading of this microcode.
> else
>         OK to proceed with late loading.
>
> Any microcode that modifies the interface to an OS-visible feature
> will set the min_version to itself. This will enforce this microcode is
> not suitable for late loading unless the currently loaded revision is
> greater or equal to the new microcode affecting the change.

Up to this paragraph the changelog made sense.

If the currently loaded revision is the same as the to be loaded
revision, then there is nothing to do.

If the currently loaded revision is greater than the to be loaded
revision then it is not loaded as the kernel does not support
downgrading in the first place.

Even if it would support downgrading then this would be outright wrong
for this case:

Rev:        10
Min-Rev:    10

Rev:        20
Min-Rev:    20

If Rev 20 is loaded, then you absolutely cannot load Rev 10 because that
would have the reverse side effects due to which Rev 20 prevents late
loading.

See?

Thanks,

        tglx
