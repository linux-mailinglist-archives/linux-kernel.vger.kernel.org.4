Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12B160F0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiJ0HAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiJ0HAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:00:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3AF33A3D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7ONSnDwssyimQ1wbQ0j4sfEGVf60dOnxOHN014BCHMQ=; b=O4mSys/wKo4nGb3F+n5xDszyQ8
        rxCBeIe961Hmo3EYRP9/19tSAffVrPZcC4NtmUt14YeiwT6E9Os/LO4e8omF5w3ulDCHXNvBvmQb8
        9vxRX62uh76C4uM6ULFuynoqhBLKVoxw+7hr3i/WWtgmY1B3Ml1MnxuhHQsZgaUv9UXUTM+28Ipjz
        z/de4cBxlDiMfjswXHCytDBfK/W2RBSkx1VpTV8sKSVPFHP+9d8haxTwWvcG0KX4wWGBgP08SZUHA
        JU5KEYSegsLuNwaqRN+YUzptbE7b8WuBxZHWExbM4leAnDAvW/YiRXab5JOo6muggyuR9yjWZSM2Q
        2K9wZiiA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onwri-006nFa-Nj; Thu, 27 Oct 2022 06:59:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66F1930010B;
        Thu, 27 Oct 2022 08:59:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4FE192C450364; Thu, 27 Oct 2022 08:59:45 +0200 (CEST)
Date:   Thu, 27 Oct 2022 08:59:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     rostedt@goodmis.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
Subject: Re: [PATCH 0/5] x86/ftrace: Cure boot time W+X mapping
Message-ID: <Y1osYVoLrpCabNrR@hirez.programming.kicks-ass.net>
References: <20221025200656.951281799@infradead.org>
 <CAHk-=wjBn=jThQ4drqgorDQFR3i2QUi9PeOG1tH2uWVkN8+6mQ@mail.gmail.com>
 <Y1jek64pXOsougmz@hirez.programming.kicks-ass.net>
 <CAHk-=wjaoB+9pJ1ouLbKuqgadqDxdhyCHi0rO-u-5bOi1qUv=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjaoB+9pJ1ouLbKuqgadqDxdhyCHi0rO-u-5bOi1qUv=w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 10:59:29AM -0700, Linus Torvalds wrote:

> Maybe you meant to do that, and this patch was just prep-work for the
> arch code being the second stage?

Yeah; also, since this is cross arch, we need a fallback. Anyway;
robots hated on me for missing a few includes. I'll go prod at this
more.
