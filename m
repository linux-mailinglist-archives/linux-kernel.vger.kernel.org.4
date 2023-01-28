Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9B167F39C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 02:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjA1BNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 20:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjA1BNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:13:39 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D73078AD8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:13:21 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o13so6239813pjg.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9NIl2COXvudH/2TUG9HlbD55DTPEYr6JyawT6Piovw=;
        b=p4IXFD1+GOy/BO49wCddjWpLy5JQM8MnJTHFNoTElf6AZhyIt8EPeWvp0c4DqdIGSQ
         2EV4p6C2IMe/vU/P7Pp8HganiqNDO7swiau1HH7n70wA1GoaFM+kjD42e2A+xcEyntFc
         7+4/mk0BpC+dnTjhVe+qYU4E6Zl2lSLBQWCX9WMdYJ78TFw4Qd6byQJk+pzt0oMnIyIt
         A568qWJSreYSMCcxUMjdN89Gj5gBIFTpU1pGk5AW+7rb/9ZI2A6Cvcnz1RQa/Wq63ISx
         QJmJb+8+ma3NepcE1oYZqV+tY4OToCVIdeyxNWC6nmfvrAGhbxPyn1Uoe2YQRmq72NEC
         0DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9NIl2COXvudH/2TUG9HlbD55DTPEYr6JyawT6Piovw=;
        b=ae/QR80Q1ubdTVLgRmQuNYT6QQX5xITLCDIA7PpkSL3LuLToS14Yf5ItY/SjevNix7
         Lxj/P5Ok6kANBw8HLRF2dtlzlQMh0RisfHKVWeNz/+Qx4kWsj/npHToqfBQWoL5WSjcK
         d3u8MwSwu4/sUBhm/XlvOkwIT1SBlILHxfSOUETIM54msfrdwxZnAFlQhhyP9CAdhA4n
         R2WPTf8mKDWjDL4urcJGUSPgBEpsSsDNw3bAtY28GdoaiBlgdVJIU/t7Z5XtUn1weqeV
         wKoCiLP258KiSNHZlXp/XeLZ9gXvlbgreQE2vJOf3P4IQVfvkY9GRC3WYjcKNHoRmkFF
         DLoA==
X-Gm-Message-State: AO0yUKXD7rztinOUec+kgmKFgKUM2UToWkAEQ81tCkDPtvAkNIpdR2kC
        ZIy/NxzeUHTpjhU63W+HKpGvGg==
X-Google-Smtp-Source: AK7set99eTIGPlT9GdoLO1Rx+rLUJeqv7QqQJTZpeEKKsGbhDnnOkhVg/9JFaBS7dtXLkrh1VQTdtw==
X-Received: by 2002:a05:6a21:33aa:b0:b9:14e:184b with SMTP id yy42-20020a056a2133aa00b000b9014e184bmr244186pzb.3.1674868400563;
        Fri, 27 Jan 2023 17:13:20 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a9bca00b00218cd71781csm3330017pjw.51.2023.01.27.17.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 17:13:20 -0800 (PST)
Date:   Sat, 28 Jan 2023 01:13:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        Jing Liu <jing2.liu@intel.com>,
        Wyes Karny <wyes.karny@amd.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 00/11] SVM: vNMI (with my fixes)
Message-ID: <Y9R2rPOy0JmwBuNx@google.com>
References: <20221129193717.513824-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129193717.513824-1-mlevitsk@redhat.com>
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

On Tue, Nov 29, 2022, Maxim Levitsky wrote:
> Hi!
> 
> This is the vNMI patch series based on Santosh Shukla's vNMI patch series.
> 
> In this version of this patch series I addressed most of the review feedback
> added some more refactoring and also I think fixed the issue with migration.
> 
> I only tested this on a machine which doesn't have vNMI, so this does need
> some testing to ensure that nothing is broken.

Apologies for the slow review.

Did a fast run through, mostly have questions to address my lack of knowledge.
I'll give this a much more thorough review first thing next week (my brain is
fried), and am planning on queueing it unless I see someone truly busted (I'll
fixup my nits when applying).
