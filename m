Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F64D737D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjFUIZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjFUIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:25:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE226DD;
        Wed, 21 Jun 2023 01:25:07 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 45B201EC0455;
        Wed, 21 Jun 2023 10:25:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687335906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UzIOwlXzTKsnwKvledRfSicki1g077/i1frFQKeb398=;
        b=kVUc4tYPLvRKdvWqsOvWOYtijpGr+4zCt1flUKUYDZHIrl6morlScITA46oAtTv3MuLOUb
        lPhKb4OLbimpNmtZOlQT7nVjO6QA1xanK90RAkU2QeADLW7WI1QnN4rrUOzjh8Yu4ZhP7W
        m89vnbXJdbQ7JW23zwAeVmkvQL70LIE=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OZEhM9ZKafAl; Wed, 21 Jun 2023 08:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687335903; bh=UzIOwlXzTKsnwKvledRfSicki1g077/i1frFQKeb398=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZgufZOmQYgG/ltuuRMXsySJ7FY24Qbbsh0AlkQxodLNWkLjksF47ZrTbgByyE2Ui
         j/HJytVy7OZu/yYU9ahNpxKnMQkMH0L1MoJ0SKuzNeW2/Hx2WJD/lPqjHu9hXShQil
         keDS8ER6PLIUZNiKZdBw38sMm92aaFhxtFAVO8J/BRrPqlaO3GrHjgX7FWOawfhbPN
         WQ35VSdy9OPTXOGxxlSXKAcbnw5M6TH8qDND8Yz/fK+L65tPBIWS/Zh9wXInJy/ZPJ
         Hyl56H6vfTyo5t/HL0EAdyUEt3n+DTZR4JtyD3xRoJAFkUCKMq8rgQYaE5iietSfMc
         VyIOb0pZo3mXwFDH4l3gt9kbuICfCEVkWacTpEoGIxakp62SMlYpP0qLJDodUmURCD
         Ri4MwhCmExGcJVcu7M8oOZN3KeOgf7d3tYpjSwxiAz2bNc1LfqUvhXJKWSnmmI3RzB
         WZC5td0cc+n4Pi6QPf+jMnLYRQuV8i/KWpm0gcJEafl7EPkTTkbMp4mnHysI2xqYLP
         /qbaJpK1cq6buqJtknNHvEahjjn34exwV1OhdY4LpVhOoJxd56eWVI2+Qh9b7y5PET
         yI6jqPllUIgKUnt7IpKZlj95z/EYu3GLIbRSfJmn4ICm8OdSCiSE3eszWIGNu8vdgZ
         OrzD/kyrin5GuglyDYG9voYs=
Received: from zn.tnic (p200300eA971dc592329C23fFFea6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c592:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA8DD40E019B;
        Wed, 21 Jun 2023 08:24:47 +0000 (UTC)
Date:   Wed, 21 Jun 2023 10:24:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v2 1/5] x86/speculation: Provide a debugfs file to dump
 SPEC_CTRL MSRs
Message-ID: <20230621082442.GCZJKzyjqRPMAnsWKZ@fat_crate.local>
References: <20230620140625.1001886-1-longman@redhat.com>
 <20230620140625.1001886-2-longman@redhat.com>
 <20230621074105.GE2046280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230621074105.GE2046280@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 09:41:05AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 20, 2023 at 10:06:21AM -0400, Waiman Long wrote:
> > Sometimes it is useful to know the states the SPEC_CTRL MSRs to see what
> > mitigations are enabled at run time. Provide a new x86/spec_ctrl_msrs
> > debugfs file to dump the cached versions of the current SPEC_CTRL MSRs.
> > 
> 
> Pff, clearly I can't even read email anymore..
> 
> We don't do this for any of the other MSRs, so why start now?

Hell no.

There's /sys/devices/system/cpu/vulnerabilities/ for that.

We are abstracting MSRs away from APIs - not do the backwards thing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
