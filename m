Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D585FEA4B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJNIRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJNIR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:17:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB6ABE2E0;
        Fri, 14 Oct 2022 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gyrYPk7W++GB5shqV+fpdk/VJ12jVzw3GALf+XThe1U=; b=hAPdwBWYQTfh/zDuCtQi4ktBgx
        WJIkBecD762BUTGU1uDFzNxlAyLSWwOOsom//o3Fr6GhEhWax7yJ73ih2jmMvNE0W9oliouZvqmjH
        sUxKPnbYSPobMKUJy6QlNLifKQ8fVwKEv1LFx3OMtu0AfTv8hxRch0Ow2Fa6JRyMmDWOJpLYLXSRi
        JbArLofVuHxw5tYm8lKMNZC06KxqZlXlWL7q/0+sGv08ql2NeCmXNdgsR6UPPqAY1xzVyC5DEpDSV
        MpKgzqCdTzrEImm87FYTg5skvw/w2gG6h0/Y4a+OOHguh9fW/g2k0fKGOttsuXQbaho1qTmlYr0fN
        i+nPHncQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojFsN-003LxY-3N; Fri, 14 Oct 2022 08:17:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F393130010B;
        Fri, 14 Oct 2022 10:17:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDFC92BE5C2ED; Fri, 14 Oct 2022 10:17:01 +0200 (CEST)
Date:   Fri, 14 Oct 2022 10:17:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Subject: Re: [PATCH V3 0/8] x86/topology: Improve CPUID.1F handling
Message-ID: <Y0ka/UKSEb36BPxt@hirez.programming.kicks-ass.net>
References: <20220922133800.12918-1-rui.zhang@intel.com>
 <5af2d8bb-8591-78f6-8102-6f7d0df33d98@intel.com>
 <9a1ae0b5d7a5ee3c870195e942d58bdd9b3b71db.camel@intel.com>
 <CAJvTdKkYTQzY1UsH_o2QdN1bS4gVfT87bEwMvgUXYwd+VFD+=w@mail.gmail.com>
 <668e5126-f344-c30b-a743-877b1783cec7@intel.com>
 <0307a5881c875e0b104051792b0f5e7f0ff973c1.camel@intel.com>
 <147a619e-e595-90c5-7a2a-ffbc2d20be7c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147a619e-e595-90c5-7a2a-ffbc2d20be7c@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 08:19:03PM -0700, Dave Hansen wrote:
> On 10/13/22 19:06, Zhang Rui wrote:
> > Patch 4/8 ~ 5/8 are real fixes and they depends on patch 2/8 and 3/8 to
> > avoid possible regressions. So patch 2/8 ~ 5/8 should be stable
> > material.
> > 
> > patch 6/8 is also a bugfix, but we have not observed any functionality
> > issues so far.
> 
> If you want to make this really easy on me, you could take the changelog
> and comment revisions that I made in that testing branch that I shared,
> integrate them, and send it out again, and *only* include the bugfixes.

It's really simple; if it don't have a Fixes tag, it ain't a fix :-)
