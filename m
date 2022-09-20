Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554CA5BD93D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiITBQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiITBQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:16:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4F540BF6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:15:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k21so855371pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=gU6sZmicsJoaIGHDKcaeVi6YbG7f7K09FK6stSvw1oI=;
        b=bxq3XL2/SXzRLYXzXWpmY1AzxAn850aE2sUXr91sQajALuLcinc6b1D0B5+Pw8PsYv
         gXhMaCrTNG9RNblSopazjRVJmorDkBbafi3AzCG9fyTlzAJDwjQHgVu6bCbLe/xWmheI
         jTfI8Fz+swp3k20Da3gKI5o8K5TM+aiATPAx6jtOTL2p2s0CERKddXDnkGHkKdDEcyeS
         K2hErCl84FDAjRHLKz+4S7vf0O0eHT4kq5cpg13OkeoXRtw7X0H7lkO+SeD3bZJ7gPbP
         bj4MCl6cNHjeSDRIFX4VyUU6CyONxJeo1PhKSix0Yq9+S4tiTnMJBhKkAV+eDP0h3Gq/
         PI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gU6sZmicsJoaIGHDKcaeVi6YbG7f7K09FK6stSvw1oI=;
        b=sIn17vm9p+USUh4oSlz+kUnoPtXPzgdZvBobLn0a9TuHHpXFIGvrhf8k2PAIEIMs7U
         VAI6m1B1oqehPC/0Xs9DBBtYoW+1Ca47EQinM51cc00luJYKjG+sj7cbCv+QvG6Pw0XG
         +QOYzMWzIU9bsf3GhQx5YXOmCNaxI9P4w7VcrAze/tuRYiDqD7pNEb2cFOvDXZQUIpnZ
         Oekp/W35xFR2i73vX9gEvi6eltO/6WlPMUR+3vhXNFuUw31vJuHUtnGIdO86p8q3gbqd
         uT1e6Pwm4o+yLBAYcwfaYy8CPdSlO4zTRW6ld6eRMpPiBMEWk+wVPtfF9kw/O8Ip4Z/3
         jMEg==
X-Gm-Message-State: ACrzQf2UXiV1C8rgFKPmRavhqFSSpLRTrEGMBsIq1U5G4vxTnLihEnWd
        zqlwmrArfxc9KToQ9ZSUvR+utQ==
X-Google-Smtp-Source: AMsMyM6mCK7tZiA7l0BLrWcQRyYYvKOaVe2pjavOYvJJvwlbgcBC0O2aPwLoQXTxhFVHA7vpHbllMA==
X-Received: by 2002:a17:902:c40b:b0:178:e34:efa9 with SMTP id k11-20020a170902c40b00b001780e34efa9mr2446911plk.10.1663636558956;
        Mon, 19 Sep 2022 18:15:58 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709027ed600b0017837d30a8csm13393plb.254.2022.09.19.18.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 18:15:58 -0700 (PDT)
Date:   Tue, 20 Sep 2022 01:15:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        mlevitsk@redhat.com
Subject: Re: [PATCH v3 0/7] KVM: x86: never write to memory from
 kvm_vcpu_check_block
Message-ID: <YykUSviPAOXEUouz@google.com>
References: <20220822170659.2527086-1-pbonzini@redhat.com>
 <YxoMCp+rMV1ZmRlU@google.com>
 <YyUcw49208H3jgMi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyUcw49208H3jgMi@google.com>
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

On Sat, Sep 17, 2022, Sean Christopherson wrote:
> The eponymous patch breaks handling of INITs (and SIPIs) that are "latched"[1]
> and later become unblocked, e.g. due to entering VMX non-root mode or because SVM's
> GIF is set.  vmx_init_signal_test fails because KVM fails to re-evaluate pending
> events after entering guest/non-root.  It passes now because KVM always checks
> nested events in the outer run loop.
> 
> I have fixes, I'll (temporarily) drop this from the queue and post a new version of
> this series on Monday.

And by "Monday" I meant "Tuesday", the weird pending_events snapshot thing sent me
down a bit of a rabbit hole.
