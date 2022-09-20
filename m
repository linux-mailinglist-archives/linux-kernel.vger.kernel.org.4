Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1F35BEFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiITWRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiITWRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:17:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5184278BF2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:16:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y136so4075120pfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FwUOhYqsMP6xtd9/MCw9V5fFKqwT862ZZH0RJSft3e4=;
        b=Dlf6n6YigvqX6AcLR9i7RejZDv9FXJpCEqYwq6AZyPvPoB7bZGswGTg32azgCTmDf/
         tSP6m6yFhKdk+kBq9L+1LBGlj7V5NCJA9GQOXh4abWHBUqUq50fXrBNubPkALHSHG3l2
         tzy1NTVHTYuaBQDZCuNjWr1vU/7gaba3WDp0HOnfLxAxfK5lTId7xLurOEaCFq4dHge+
         nqAglwz2H65C7ZrMeDNxLLvIeZnXl6qYxiA60El0fKRGeGgjXLULxkqa2xfJtgErnPwQ
         vpUQ0bjH0YtaobybAfbYuwZ2wgCDoTkOTo7BRnq55KSY790TgL3nRqD67wz4UOYNbBK3
         OiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FwUOhYqsMP6xtd9/MCw9V5fFKqwT862ZZH0RJSft3e4=;
        b=q+yxIcv5b4jt5HKUW1iyTregVTcrS79C0syju7wlIGHYQfa/tEWH15ZBVcv3RGkIyh
         0TE/zpQjdDjJMcjWYUQxGymjycMFBbaTaLUE/82fR5Q3DuViF07ZiSUE7jMokN3C6G2B
         ezbniJ+E2eHSQU38yV4WF32fOF8RMwjaGDh9s+qt9n+UukUT0buFAe6jhqWqg949YVF0
         1f7sHpiEhQFTHg8CLtjryTRGxRDvmmXp9UytyEaBaZ+YoAt+S6/LJoDVlVvPLpVvYFdR
         d2Jl8PpFXK2QE9oFCVVA/vsMLIyVimKkNKWZybq++q8AR/HIdyeVNrpzjINjYXgbaH2n
         9YBA==
X-Gm-Message-State: ACrzQf2MvkL5p5FVQIHo7k/cHZSiZM10YT1BmCrsaNPENnsgtLJAJ+LE
        53fOrbXfYsst1b52K91u1Lmllw==
X-Google-Smtp-Source: AMsMyM7/DR+/Z9SYYBWpoQz4RH3MsYuMDCUp909I49IEerpoxPrJv4J29GLsp4G/Oe0NiR6U8Nfygg==
X-Received: by 2002:a05:6a00:1911:b0:545:cdf0:a61f with SMTP id y17-20020a056a00191100b00545cdf0a61fmr24948927pfi.32.1663712215442;
        Tue, 20 Sep 2022 15:16:55 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b0016c5306917fsm428943plf.53.2022.09.20.15.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 15:16:55 -0700 (PDT)
Date:   Tue, 20 Sep 2022 22:16:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: fix repeated words in comments
Message-ID: <Yyo701VSV6OBeDPP@google.com>
References: <20220831125217.12313-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831125217.12313-1-yuanjilin@cdjrlc.com>
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

On Wed, Aug 31, 2022, Jilin Yuan wrote:
> Delete the redundant word 'to'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---

Pushed to branch `for_paolo/6.1` at:

    https://github.com/sean-jc/linux.git

Unless you hear otherwise, it will make its way to kvm/queue "soon".
