Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7531B696E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjBNUC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjBNUC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:02:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B4F2D173
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:02:26 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676404944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4OI6HTwcucFgFb0spI1dEzzWuTO/rgWPGwSuouzzjPs=;
        b=UvyHHmZ1Z1kc0DU/eYEi1+3D2y2UJ/xhnajRkigq7fiLnN2+4Tf0Aq75Tkm0hq9eT6Xt/4
        EQB1ntbUtWbR7DAfkkQ14I/DrXPNAq5GST+wm97+pWK40g71ZcfQKLEFYANGP0y0uiuH8P
        Dl4MlIPhLMzTYYJOWlgJ4/OVPMcqTJtuscaTSPm4+KUz98fgWPrRxAHUGl6I/cuKvZhrpL
        xkVf88ZyfBkC4SUJq620bYCH3C5J6azSXbA5ux87K36LocwAGNAP5FTX3EB/6nIi1tKT5a
        reZXO52OS/SQTFTBPuBckwtIgS8tOt2wlXP+WlDMq0LTntEyiUXyki6LO3gq2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676404944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4OI6HTwcucFgFb0spI1dEzzWuTO/rgWPGwSuouzzjPs=;
        b=iX9j3g5GjWkTIOgU3xaODL3n9iAJZ5ayj1wEY+gkbTZCM2thmTmHLPUvoLk6ded5Qa1hf9
        b8oXlYWK3YzXUxBQ==
To:     kan.liang@linux.intel.com, jstultz@google.com,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC PATCH V2 4/9] perf/x86: Enable post-processing monotonic
 raw conversion
In-Reply-To: <20230213190754.1836051-5-kan.liang@linux.intel.com>
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-5-kan.liang@linux.intel.com>
Date:   Tue, 14 Feb 2023 21:02:23 +0100
Message-ID: <875yc4rp68.ffs@tglx>
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

Kan!

On Mon, Feb 13 2023 at 11:07, kan liang wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> +	} else if (perf_event_hw_time(event)) {
> +		struct ktime_conv mono;
> +
> +		userpg->cap_user_time_mono_raw = 1;
> +		ktime_get_fast_mono_raw_conv(&mono);

What guarantees that the clocksource used by the timekeeping core is
actually TSC? Nothing at all. You cannot make assumptions here.

Thanks,

        tglx
