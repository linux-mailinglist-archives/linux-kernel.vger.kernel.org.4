Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8BC6145F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiKAIsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKAIsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:48:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C57186F6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zXeGwp8ffm4fwtJKkuEFRw81OnMm8Zqcq3z8cr7odGw=; b=P1bFpQlLYaQecQtsoqX+D6PWBL
        WMPNEuxeDmJ5FT2QVOkfOuw2ZRXtMijRPV23I+B4H11S/1kzKpeDcNCJeFS3ODtmMweRL+HEs748u
        EMuW+F0Do5l6WweYGDATlKpdI0qK4jq8+8q7g7Y/QjVYL57QWX8HvmtqewICpydh9wREbIum521YP
        6k4976yEpsDnKgIINrLXO/S6epfh/QCW9BNB7vOPc5yT2mVm2WS0M+ZPcXwsAHN6tOAdQIsCYL7pL
        s4SQtvTwP92qHRxsFI8slreOCWDwciP5wzfpKV5wlArNnxG//sFWTj9KDyxU1UpaPSOFa8Z4SyW45
        EPV3qoFw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opmwM-004SVP-SV; Tue, 01 Nov 2022 08:48:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E24A3300282;
        Tue,  1 Nov 2022 09:48:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1A2C2010F55F; Tue,  1 Nov 2022 09:48:03 +0100 (CET)
Date:   Tue, 1 Nov 2022 09:48:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        puwen@hygon.cn, TonyWWang-oc@zhaoxin.com, Jason@zx2c4.com,
        hca@linux.ibm.com, mika.westerberg@linux.intel.com,
        mario.limonciello@amd.com, tony.luck@intel.com,
        andrew.cooper3@citrix.com, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, jithu.joseph@intel.com,
        chenyi.qiang@intel.com, rafael.j.wysocki@intel.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: replacing the open-coded shift with BIT(x)
Message-ID: <Y2DdQwVfU2jFjMRX@hirez.programming.kicks-ass.net>
References: <20221101060945.722565-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101060945.722565-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 02:09:45PM +0800, Gaosheng Cui wrote:
> Replace the open-coded shift with BIT(x) for x86_power to make the
> code a bit more self-documenting, and we will get a UBSAN issue in
> arch/x86/kernel/cpu/proc.c, fix it.
> 
> The UBSAN warning calltrace like below:
> 
> UBSAN: shift-out-of-bounds in arch/x86/kernel/cpu/proc.c:138:25
> left shift of 1 by 31 places cannot be represented in type 'int'

Same as to the other case; UBSAN is broken garbage, stop quoting it.
