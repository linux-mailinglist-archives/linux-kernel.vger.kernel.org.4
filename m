Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03628674597
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjASWM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjASWLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:11:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B93CA57AC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:48:32 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674164910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VsSF7KWIbHynqYrF26mD07CtF4vjiv4FfxR14nRaxz4=;
        b=zFG177w86kGq1oQNDqcU1jN1HxoC3tlcpBxcpDiKQJcx4LLrnBcjXqSCfS09S9oC9K8qYl
        hQIhvv9hxH6ZyyST6OKceUgeffGQmeYyc5bqBgEPzdooUNSvSxj5j7XXo66IKNUNPPZ3RR
        haWtyfyffSO6mvkzinmtrV60YdUOY/5Fxkoi4aGjxSxiFTXgAzB+fkBmkzO4ABkNkA3EfP
        yEPWGcmIVyQJGsETuthNC1ffHDTCXic+/IsBFu50X6PMyRPz31YuBpl9b8km/6QQNv3TBZ
        3dVc/K6vSKaqC5cnjjlMVBKiqna5aGEO+lfbz/DEaeJ+HysMWFo4ZAoSk8VFMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674164910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VsSF7KWIbHynqYrF26mD07CtF4vjiv4FfxR14nRaxz4=;
        b=v96ZlMumHcq9QNUOU38faR0IqywOVckBTw4bXRH6nT2Gz+/A4gZcn6wlhfmimBddsI7y+I
        tYZVW3+1zatVKtDQ==
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
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
Subject: Re: [PATCH v1 Part2 1/5] x86/microcode: Move late load warning to
 the same function that taints kernel
In-Reply-To: <20230113172920.113612-2-ashok.raj@intel.com>
References: <20230113172920.113612-1-ashok.raj@intel.com>
 <20230113172920.113612-2-ashok.raj@intel.com>
Date:   Thu, 19 Jan 2023 22:48:30 +0100
Message-ID: <875yd2i4b5.ffs@tglx>
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
> Currently the warning about late loading and tainting are issued from two
> different functions.
>
> Later patches will re-enable microcode late-loading.
>
> Having both messages in the same function helps issuing warnings only
> when required.
>
> Move the warning from microcode_reload_late() -> reload_store() where the
> kernel tainting also happens.
>
> No functional change.

I had to read this more than once to make sense of it. Let me try a
translation:

  Late microcode loading issues a warning and taints the
  kernel. Tainting the kernel and emitting the warning happens in two
  different functions.

  The upcoming support for safe late loading under certain conditions
  needs to prevent both the warning and the tainting when the safe
  conditions are met. That would require to hand the result of the safe
  condition check into the function which emits the warning.

  To avoid this awkward construct, move the warning into reload_store()
  next to the taint() invocation as that is also the function which will
  later contain the safe condition check.

  No functional change.

Did my decoder get that right?

Thanks,

        tglx
