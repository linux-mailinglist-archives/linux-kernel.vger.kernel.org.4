Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFA8679381
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjAXIwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjAXIwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:52:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6754ED9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:52:02 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674550320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WktmOENrBMjK9MHeK4G6fXaIDxwZbIs2XRWbI/JOqLY=;
        b=UurXom3sQmKhoNlbjpBZg2qKpD7mKmzT/i1iBGp9Tw/BqAueZedHLHAk2MYhzqv/7H6YwW
        GHIu70egjxNEDsixcP7BCH857HqJZ8Nq35hu7fqlQ/5K4T2qO/tIG1dij7u5MfP3TmU4+T
        c4bXRoGRnMsZk5dV5h34PwmCF136eU39BiGTbvXlJbwUlV72VZGsdoL0Di9gMVkgxcw0Xm
        XXhDYh2MXRB81eYheidM6bSyb72VScTOJbrb0kVHo/lMA/UqyWLr6BqEFqkQqmqBjnazS8
        UfVVsFZWbF+Ypq+a1yiv/F7ofl3uwtuI7hiRVLIwiVGbKUbbRAJ35t+E8T7OvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674550320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WktmOENrBMjK9MHeK4G6fXaIDxwZbIs2XRWbI/JOqLY=;
        b=3Q7NqKtotTg37kbV+hB7i5Ei8PqxBXTPoMwsOmkqgTTpTUpaRSMeB6g4gOlMcuoP5SjWDc
        MdES5rFqPV14NVDw==
To:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH 1/3] timekeeping: NMI safe converter from a given time
 to monotonic
In-Reply-To: <20230123182728.825519-2-kan.liang@linux.intel.com>
References: <20230123182728.825519-1-kan.liang@linux.intel.com>
 <20230123182728.825519-2-kan.liang@linux.intel.com>
Date:   Tue, 24 Jan 2023 09:51:59 +0100
Message-ID: <87sfg0gvrk.ffs@tglx>
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

On Mon, Jan 23 2023 at 10:27, kan liang wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
>
> It's useful to provide a NMI safe function to convert a given time to
> monotonic. For example, the perf_event subsystem wants to convert a TSC
> of a PEBS record to a monotonic clock in a NMI handler.

Why? That's a postprocessing problem, really.

Thanks,

        tglx
