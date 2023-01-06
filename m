Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D990365FF0E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjAFKjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjAFKjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:39:07 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6306C2A3;
        Fri,  6 Jan 2023 02:39:04 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AEB551EC06F0;
        Fri,  6 Jan 2023 11:39:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673001542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=n7VR15LegHBF69sDhJmN6JzG4w0jk+p6p7NGe25P8bg=;
        b=Nstk1XoxKFQcdBAOahpt8ZGGZaWBLRmZhEQ1CHfT6dMmUZhWocat06kvxWapC9TvWZDBQQ
        BLJ+IoNiQUT5SjwZmNCunen945AW8BneEeHtmco1kcqqVc7/TWez1PmuJ5ONtile6jy/GD
        UxFtR1xDgwu805SAb17/rZ0gqwZNfhE=
Date:   Fri, 6 Jan 2023 11:39:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Message-ID: <Y7f6RhF8FuK9R399@zn.tnic>
References: <20230104145831.25498-1-rui.zhang@intel.com>
 <25d07838-3904-a086-4238-f56c9424b53a@intel.com>
 <ea9186869cca50a21efcc1a9cc4dbe5adcd1784b.camel@intel.com>
 <Y7aejeHDpLlwwYbr@zn.tnic>
 <4cc5cd868b20366fc9d4bf157656e0c295074282.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4cc5cd868b20366fc9d4bf157656e0c295074282.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 06:05:41AM +0000, Zhang, Rui wrote:
> But I still have a question.
> Take RAPL feature for example, the feature is not architectural,
> although 80% of the platforms may follow the same behavior, but there
> are still cases that behave differently. And so far, there are 8
> different behaviors based on different models.
> 
> In this case, can we have several different flags for the RAPL feature
> and make the RAPL driver probe on different RAPL flags? Or else, a
> model list is still needed.

Well, you asked about detecting CPUs supporting RAPL.

Now you're asking about different RAPL "subfunctionality" or whatever.

You could do the synthetic flag for feature detection because apparently giving
it a CPUID flag is soo expensive (/sarcastic eyeroll) and then you can pick
apart subfeatures in the RAPL code and do flags there, away from the x86 arch
code because no one should see that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
