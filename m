Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877AC64617F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLGTHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLGTHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:07:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6622183C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:07:43 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so2614268pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 11:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MIIsC5n7QdCrwcQHmEVu9CQ5CUNGyRG2niR/eVQTyw0=;
        b=LuEPjlp29xXvhszc9RKkHf6piCKKDeFwO7yr9EzkeMEbEfs4Ha2coRFR2D9Vv/OlmW
         kbnv79bt+vD1NP1+Kdox9Yqctkailz5+b41kLfM7WlHSBkfsuzIUuahGyWmmty3LHgJ/
         bwcKnmQA9XyR39zorh6CfHARke6VID8xDdAfVviw1MCH9mdVR9Xl2OPnDJX7gs9ZSPHq
         f1TT4OxX/TNVNAhZGlEsPLW6l3ZxFtfISQAlkxXeV8vmDWC6aDycJqB8jMS9pQ6w1/UW
         v4PmlMZ1YU3sqW7wzksCBlOkJ5b4WnPNR3VCOA1dNBdqi2el+f0n9GYJeENws/x23OW8
         S1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIIsC5n7QdCrwcQHmEVu9CQ5CUNGyRG2niR/eVQTyw0=;
        b=JGREeB2yWZScP4XeIy6nNdBTMb9YFOI5KdGbSZPjhHDLpltYBtljtEI2FWjqr5+LJ+
         cyetNQ1Z5Rw5CDm3Dri0Mk8EbV+fKgjIJZOu8+7FTmTrmveyp9wyDDQrprBQcg7ibue7
         bF7T1rQ2EM/MFOWWrQblFhYpsg+8+qAevKSFJ6Cnf+2hJoz1ACrYJQzsO/k5do5AR/PV
         qXv9oxsvkU9SPSVVQ+DhRIToNnzosSKA9cJXEMEA6a4pKgcvfeQPwyz8sW8XXMATkn4S
         IWJv7BlsBQz8cp/2ZS+57/Rls1Dc0mhnuGxjbuD6gUsFY+71TKl294YGbTYlvzpMALYS
         6/jw==
X-Gm-Message-State: ANoB5pkTYbvQiCS7k4+pElfN6fkGV99SpXg6OAmm6QmND+wXr9bZqjNa
        cJjojcn/aUJT0eC3U/uCekYuOA==
X-Google-Smtp-Source: AA0mqf55MWjxuHrH3IT7R8UFXI80tu1WDPZA5MI0p/jv2F4oxIFUeP9djV9/MtxqV/qX/TVXvxz/Yw==
X-Received: by 2002:a05:6a20:e60e:b0:9d:b8e6:d8e5 with SMTP id my14-20020a056a20e60e00b0009db8e6d8e5mr1461920pzb.2.1670440062946;
        Wed, 07 Dec 2022 11:07:42 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b00189fdadef9csm645772plg.107.2022.12.07.11.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 11:07:42 -0800 (PST)
Date:   Wed, 7 Dec 2022 19:07:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michael Sterritt <sterritt@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH kernel 3/3] x86/sev: Do not handle #VC for DR7 read/write
Message-ID: <Y5Dke3WOpd8bJK9q@google.com>
References: <20221201021948.9259-1-aik@amd.com>
 <20221201021948.9259-4-aik@amd.com>
 <Y4jmmfrUXAzydM0G@google.com>
 <Y5DjBAH1P38hjJRP@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5DjBAH1P38hjJRP@zn.tnic>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022, Borislav Petkov wrote:
> On Thu, Dec 01, 2022 at 05:38:33PM +0000, Sean Christopherson wrote:
> > Probably high time to add a helper/macro to convert the SEV_STATUS to
> > the SEV_FEATURES field.
> 
> Nah, there's a couple of
> 
> MSR_AMD64_SEV*
> 
> defines in arch/x86/include/asm/msr-index.h.
> 
> Bit 5 should simply be added there.

Ah, yeah, that's much better.
