Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1E46CD537
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjC2IvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjC2IvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:51:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769A32733
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tu8D8sNJ5RV0W3AuFiycIVvG6n0AuLvN4txSs88tZ2E=; b=JiL4y62ZsZ1uxjqtNN9l2NqWSl
        wxFK6o6H4pWzhxVAQSDIXQNVDR9pMKbYaap0flqtbJgYCElstOCLDlAbI/ZULqUin+B0mfNOdsmnC
        3toxNj3QkKeaWcpC6vNXDFdV2DWS2t6hEYTOD17aFe59/LrKoSStR1TqhbRQT+nxq86CY12GTC4oc
        duwoqyzBovddWn3KGZNYoRP2n2e76Up0t6hdkgKqJ9KJC07xYnxz7QWmkrWeFD50dq/1WxRcP93+g
        rYg2MU4TGWl4Ls13rt7Sz0OwILovO1FM6FZZtNF9EpmsgPnckV7RHBqy617mSrUTTWwwJK/eE8sej
        MEhM3vrA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phRVg-006oAq-35;
        Wed, 29 Mar 2023 08:50:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 88D12300237;
        Wed, 29 Mar 2023 10:50:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 348AA262EE29D; Wed, 29 Mar 2023 10:50:23 +0200 (CEST)
Date:   Wed, 29 Mar 2023 10:50:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Yang, WenYou" <WenYou.Yang@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Quan, Evan" <Evan.Quan@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>, bp@alien8.de,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Liang, Richard qi" <Richardqi.Liang@amd.com>,
        "Li, Ying" <YING.LI@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT changes
Message-ID: <20230329085023.GO4253@hirez.programming.kicks-ass.net>
References: <20230329015149.870132-1-WenYou.Yang@amd.com>
 <20230329015149.870132-2-WenYou.Yang@amd.com>
 <20230329071014.GC7701@hirez.programming.kicks-ass.net>
 <BYAPR12MB352749E2864A87C3C32B7D0FFD899@BYAPR12MB3527.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR12MB352749E2864A87C3C32B7D0FFD899@BYAPR12MB3527.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 07:23:29AM +0000, Yang, WenYou wrote:
> [AMD Official Use Only - General]

^^^ that has no business being in a public email.

> Hi Peter,
> 
> Thank you for your review.
> 
> The purpose of the patch set is to improve the performance when playing game for some AMD APUs with SMT enabled/disabled.
> 
> When change the SMT state on the fly through " echo on/off > /sys/devices/system/cpu/smt/control", the kernel needs to send a message to notify PMFW to adjust a variable's value, which impacts the performance.

When top posting I normally ignore the email. When not wrapping email I
typically get cranky. You 'win' *3* 'I cannot use email' trophies in a
singly try. Surely AMD has a HOWTO somewhere you can read?

So what do you want to have happen when someone goes and manually
offlines all the SMT siblings using /sys/devices/system/cpu/cpu*/online
?

I'm thinking that wants the same PMFW (whatever the heck that is)
notification change done, right?

If the answer is "yes", then your patch does not meet the goals and is
inadequate.
