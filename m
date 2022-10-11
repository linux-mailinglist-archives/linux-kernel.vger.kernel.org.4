Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEB85FB40A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJKOCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKOCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:02:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AFB6FA14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qumU7debCS+DOddWrWVWavmH1w79UYhLhWyOjNv83+g=; b=jf/2rqKVoNpyd1A4Fem/70AwyL
        QBNF51RhZF93mzfHpCI6zCqNsWKeIV895ouyjGec+UXbujXWe2nGFDqhXwdkKoPWaN9kRnuf0dCuq
        5zJwK+6rvtgyn/IePaj40XLMqcmvwIkyw7QucDNLPnYJLzVE070AGlQGtT7fXe99gQmWLtIk4BAY3
        h0IOMIgU0fleq2tFwdKxyqPxQMJLF7fOsMbjppjJn0nikcf1GosBLMeHv+WV8EDhFtc/yYPDz5MVc
        Gyi3I4P2CsR2WKz1N//bFx/Ep8gJvJB4GXoQbiH6UmljvwoyVgA9php+S2tHGPvlmDKcO/QWgWDZT
        KTuncp7Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiFpN-002aTY-GS; Tue, 11 Oct 2022 14:01:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9226F300422;
        Tue, 11 Oct 2022 16:01:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AA3E2997FB9B; Tue, 11 Oct 2022 16:01:46 +0200 (CEST)
Date:   Tue, 11 Oct 2022 16:01:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tim.c.chen@intel.com,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
Subject: Re: [PATCH] x86/tsc: Extend the watchdog check exemption to 4S/8S
 machine
Message-ID: <Y0V3Snlqvz2+1UUQ@hirez.programming.kicks-ass.net>
References: <20221009051209.393377-1-feng.tang@intel.com>
 <Y0LGLGW7RSlklKyl@hirez.programming.kicks-ass.net>
 <Y0N0ENurfliW315D@feng-clx>
 <aff10f33-b379-6872-f180-b38f6a0a669a@intel.com>
 <Y0Ugs/udnBh0Hv3C@hirez.programming.kicks-ass.net>
 <aa5c745686127c5d1ff2496fcecc3ebf0839443c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa5c745686127c5d1ff2496fcecc3ebf0839443c.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 09:33:26PM +0800, Zhang Rui wrote:

> topology_max_packages() or variable logical_packages can tell the
> maximum packages.
> But this check_system_tsc_reliable() is done in early boot phase where
> we have boot cpu only. And the cpu topology is not built up at this
> stage.

Is there a problem with disabling the TSC watchdog later in boot --
after SMP bringup for example?

