Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A83C69D677
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 23:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBTWwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 17:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBTWwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 17:52:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1683C21A07
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 14:52:08 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676933527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cI3Kv3A9m2enWKMCEqkUYT59GuEdnRsmPYrIhm3l6EE=;
        b=SXAYTbnip+e6FZgQCFl8mj+cDT/47HaVqeS0evRLMvR8O8kEYx6Kt2WWdhXFQtj1vrsDcP
        14v4KWAidRQAl+9Ey5mF6ZVLsBZWYoCDMV4TaNP25liPTvHcA5dsxnYlAQY/tJcDX/xuFD
        UdaURcgIJH3ZdjtP13jFEs7T8shLydz4iAwV6tdZL/rVz+u+EtnTnyBM0lU+aCxbuBVtsW
        KuZL3Q0UTeutvHbd60h8lCYsIF0sUvlr6pFfVBfMx7ied3Sv1rbBHulOZqmsTnQisDACVh
        wCTmFXyihQsfGKHegt7rrDTEhxtGGfQCQR0c1VLiBEJiRj/rdKAaoWjLIaY+/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676933527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cI3Kv3A9m2enWKMCEqkUYT59GuEdnRsmPYrIhm3l6EE=;
        b=9q17SwFN4y2O8Ed6sxivlxJksmuAm9cMfZaaHII21+AJZL1FkpGGKohniDufxpdxSPMqru
        zcbonlkDdnjU3vBg==
To:     Peter Zijlstra <peterz@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "Brown, Len" <len.brown@intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
In-Reply-To: <Y/PEnzRCZXA94cuw@hirez.programming.kicks-ass.net>
References: <20230220032856.661884-1-rui.zhang@intel.com>
 <Y/NUni00nDuURT1H@hirez.programming.kicks-ass.net>
 <fe5059317c4f3cabeb86c388d547504b9b6ea581.camel@intel.com>
 <Y/PEnzRCZXA94cuw@hirez.programming.kicks-ass.net>
Date:   Mon, 20 Feb 2023 23:52:06 +0100
Message-ID: <87bkloosq1.ffs@tglx>
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

On Mon, Feb 20 2023 at 20:06, Peter Zijlstra wrote:
> On Mon, Feb 20, 2023 at 02:33:09PM +0000, Zhang, Rui wrote:
> APIC-ID is of no use vs hybrid though, and MADT doesn't include any
> either, so that's all still buggered.
>
> Luckily it looks like MADT is fairly extensible, ideally we add an field
> to entry-type-0 to help with the hybrid mess.

I don't think that's the right way. This should use PPTT because that's
a proper hierarchy model. Extending MADT is just another duct tape
solution.

And it actually does not matter which way we go because none of the
existing systems have any of that.

Thanks,

        tglx
