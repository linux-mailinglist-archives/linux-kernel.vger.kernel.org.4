Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1185C5E6CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiIVUZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIVUZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:25:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09194D4308
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:25:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id e5so10424501pfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cNYKHjCXGHwA6gkDe3m1/Mipnx1ERqXA6xSU0q3Y+ZY=;
        b=lMppMlY3TXx+2JubIDlxi3jCLHZUazHVJWaD2U71k1qmwj+gjmzer+3MnvCj0gsNb7
         OpaTnF/oCXgzTFSMj75M9qbqov2TAtTo1KYACVBI6BqTjZaE6Q84ZIJMYDPsqOhy1SgP
         1AG65abpY8FTpFMDA3yZkedWrpaMiY2g7BrTHrAG/vT71zvEq0llw5e2vDagl+p1hCag
         9RP8eYvAIssm2TslekZgISJUmkCq1ryS7p26hsZkwO2Km3FSFIR4YpISsBDyfpnn7AJN
         1xgGw87IbqxgiVrsqfc1EcLBHdgYQPi6vHi/HDCKCO2lrs2L8EpP2FOowS0BwgvIXbet
         hw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cNYKHjCXGHwA6gkDe3m1/Mipnx1ERqXA6xSU0q3Y+ZY=;
        b=sMuuLMflPPWcXYixzZjYiucECB4/MaWDCkm+nmCfe0Z7KbDlao9u0Jtgk/JRxeAP+h
         5NlGdSrwvW3GksZkgFV7xcwx4TM2ErqlC3JvTH6q63rD1jE9j4Ef/aR1oaolpdXsK2cN
         TCw3vb++XaW9S3aY+DeEPvOVloYc5ypkF2dbMTA1e6CRV1g7FscK6YGMuEvIQXt5eeU4
         xsNZ7q5yvl8E8hs/Yd68WrJySsA2Ozv2wkz1uwbfr7hmkob3kBD5ESfvcMveR8b31glo
         aRg09gC2X8nKZKNhogcZH2gSE4m6BG/DrT3dzwIj6oyh13TA+IzjSpwEequt0gd//ztN
         Qcsg==
X-Gm-Message-State: ACrzQf3bTZ5e5vzQ0FCUWqQyhTEpm+zuxGGVEZ8PftsjvcGfiozDcyRs
        sbg1bohhD6D7lj6QfQbkyOrpJw==
X-Google-Smtp-Source: AMsMyM4fhHNxOFdOFgBnADpcIe7DbJBMYYMbH6058a3uazv9hRKVPfD+O/+VPtKVB3q84AOWjesaOA==
X-Received: by 2002:a65:680e:0:b0:43c:f0f:4554 with SMTP id l14-20020a65680e000000b0043c0f0f4554mr4097366pgt.469.1663878337390;
        Thu, 22 Sep 2022 13:25:37 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090acf9600b002008d0df002sm175975pju.50.2022.09.22.13.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 13:25:37 -0700 (PDT)
Date:   Thu, 22 Sep 2022 20:25:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Vipin Sharma <vipinsh@google.com>, pbonzini@redhat.com,
        jmattson@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: selftests: Check result in hyperv_features.c
 test only for successful hypercalls
Message-ID: <YyzEvar3EXBG9Cbe@google.com>
References: <20220922062451.2927010-1-vipinsh@google.com>
 <87fsgjol20.fsf@redhat.com>
 <YyzDmYAhWkMRt6E4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyzDmYAhWkMRt6E4@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022, Sean Christopherson wrote:
> The bug Vitaly encountered is exactly why it's pre

Premature send :-)

What I was going to say...

The bug Vitaly encountered is exactly why upstream process _strongly_ prefers
splitting patches by logical changes, even when the changes are related or tiny.
Bundling the fix for the egregious bug with the enhancement makes it unnecessarily
difficult to grab _just_ the fix.  In this case, Vitaly was on top of things and
there was minimal fallout, but imagine if the fix was for KVM proper and needed to
be backported.  Some unsuspecting user would grab the "fix", apply it to their
kernel, and suddenly be presented with previously unseen failures.
