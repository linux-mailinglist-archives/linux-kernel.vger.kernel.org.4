Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03371660285
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjAFOuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjAFOuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:50:05 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391E880AEF;
        Fri,  6 Jan 2023 06:50:02 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C933F1EC050D;
        Fri,  6 Jan 2023 15:50:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673016600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pJXYOpevDeH94S9Y0/8hjDZhR1yAlOLk1AabVA0ifvI=;
        b=SvEJT9UNtkbWfP8Y8B3zja9SXWS0PDGwxOTN8z2sY7qwB2zdisTuyotKg8jaFMc0I0kUFr
        7yN1MOrMbBd1A0MCGGjFEBmPFYwnbJG9QL0aVaMfTapxvSeoI2LWdxGV9G6v6NhT4ksMrA
        VI+ELc8doeCSNwf7Ph+TGsWZ1kJYcdA=
Date:   Fri, 6 Jan 2023 15:49:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Message-ID: <Y7g1FCY4Y+hY26aC@zn.tnic>
References: <20230104145831.25498-1-rui.zhang@intel.com>
 <25d07838-3904-a086-4238-f56c9424b53a@intel.com>
 <ea9186869cca50a21efcc1a9cc4dbe5adcd1784b.camel@intel.com>
 <Y7aejeHDpLlwwYbr@zn.tnic>
 <4cc5cd868b20366fc9d4bf157656e0c295074282.camel@intel.com>
 <Y7f6RhF8FuK9R399@zn.tnic>
 <d6ae35f1e72d4bb8e02f44fe6d9369f1a5f21619.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6ae35f1e72d4bb8e02f44fe6d9369f1a5f21619.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:38:10PM +0000, Zhang, Rui wrote:
> And then set the feature flags based on this, and make the drivers test
> the feature flags.

That would be the purpose of synthetic flags.

> The goal of this is to do model list update in one place instead of 4
> or more different drivers when a new model comes.

Do you really have to update 4 different places each time?

As said before, you have to do the model matching *somewhere*. If you have to do
model matching in a lot of drivers - and it looks like you do - judging by

$ git grep X86_MATCH_INTEL_FAM6

output, then doing the matching once in cpu/intel.c and setting a synthetic flag
does make sense because all that matching code will disappear from all the
drivers but be concentrated in one place.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
