Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59486987AD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBOWLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBOWLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:11:23 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1596743442
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:11:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u2-20020a25ab02000000b0090f2c84a6a4so10781751ybi.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oudIwnEPPAGRBRrCfLq7ua1hvqy4La4rrkSnZmTBp/0=;
        b=JCTFc/XD5KHvKUrSaQKv4dzmCop87QijxyX9tGllF1EmLMsNtkfsSpbL5bEwPHeUOm
         1W0AucJ3Vw4PiLgErIrY1vjRWlX/0/WOdGveetOzf+XsPm2dGek2Tz4tBfrube1okBem
         bIX9j6lejcv6kRaVIGGPvTTHNkOe4SprqNdhqJ7m1XWhtPsvLRSrRm4wgqd0fwKJoRhR
         /0j0sj0irfUMMJjuNvDzHuNkFSV+dylfdM7/JX0PUoW8zt1C0k46H7YBiVbLE0ynLqG8
         NfNOHPZDkR80w/hvTm8S7cH5LMrlgeasn+fA+3ym8uu4AJit4sKoKk5x6czlO6oG4EnE
         Ihpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oudIwnEPPAGRBRrCfLq7ua1hvqy4La4rrkSnZmTBp/0=;
        b=PUrBBOQ0PZhw6ZKgO/Lf1tJIH+Rp70qW6MZeN0WAuBM9azzPUH5tbtSG+Icy454tAV
         vNH5NgXG4AMRV2XVt0WDZCvv20O+ZJeTX1xD10kjC/pouUrKrr6p2OqvHUNysyy92F2Q
         qTKePVUyTX6GOCV7B+nro6W7TK9RcsEw/r3uncCr+rxc+bWgURtkXXwfxl09ypMBeBV1
         THDeZiEahMkAZQTSWxyQPoUuhF1bb2Ozrgnz3sZoraJhGc2WnrqGAxNNa0KsAXibA1lc
         WPcAc79O5LiqfzIRWrbUSz3v2aMhqDcbzuf0FZXXo0E4NG4uHDujsQTjiWgfyTtoudZN
         gqmQ==
X-Gm-Message-State: AO0yUKU0mVN7QWUCuzxFwinxOfvUY91/xRjZor1ZLdFlsPiZ5kbT92Pj
        SFAIBcDUVjs225m/eB6XLH3vECznBDc=
X-Google-Smtp-Source: AK7set9syMGwwbPlXmBc/5glGE+EpC18KxAdh4RUvLmWB8+O0XSG5n+IUtEl9uk0lbMxdt5l4FX6JvCAe2A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:205:b0:8e9:abfc:1a38 with SMTP id
 j5-20020a056902020500b008e9abfc1a38mr12ybs.10.1676499079682; Wed, 15 Feb 2023
 14:11:19 -0800 (PST)
Date:   Wed, 15 Feb 2023 14:11:17 -0800
In-Reply-To: <c3b6efc8-4f47-449f-d3f0-1f16ae756bee@amd.com>
Mime-Version: 1.0
References: <20230207002156.521736-1-seanjc@google.com> <c3b6efc8-4f47-449f-d3f0-1f16ae756bee@amd.com>
Message-ID: <Y+1YL7jaNEUUYfGq@google.com>
Subject: Re: [PATCH v2 0/3] KVM: SVM: Fix GATag bug for >256 vCPUs
From:   Sean Christopherson <seanjc@google.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023, Suthikulpanit, Suravee wrote:
> 
> 
> On 2/7/2023 7:21 AM, Sean Christopherson wrote:
> > Fix a bug in KVM's use of the GATag where it unintentionally drops a bit
> > from vCPU IDs greater than 255 and as a result wakes the wrong vCPU.
> > 
> > Suravee and/or Alejandro, can you give this proper testing?  It's compile
> > tested only at this point.  I'll do basic testing before officially
> > applying, but AFAIK I don't have access to x2AVIC hardware, nor do I have
> > a ready-to-go configuration to properly exercise this code.
> > 
> > Thanks!
> > 
> > Sean Christopherson (2):
> >    KVM: SVM: Fix a benign off-by-one bug in AVIC physical table mask
> >    KVM: SVM: WARN if GATag generation drops VM or vCPU ID information
> > 
> > Suravee Suthikulpanit (1):
> >    KVM: SVM: Modify AVIC GATag to support max number of 512 vCPUs
> > 
> >   arch/x86/include/asm/svm.h | 12 +++++++-----
> >   arch/x86/kvm/svm/avic.c    | 37 ++++++++++++++++++++++++++++---------
> >   2 files changed, 35 insertions(+), 14 deletions(-)
> > 
> > 
> > base-commit: 32e69f232db4ca11f26e5961daeff93906ce232f
> 
> For the series:
> 
> Tested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Thanks much!

Paolo, do you want to grab this directly, or should I throw this in next for a
few days and send a separate pull request?  Or do something else entirely?
