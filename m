Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40F073393D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjFPTIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFPTIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:08:40 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10DD30D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:08:38 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-25e229aec3dso726921a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686942518; x=1689534518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEz7FfIZN3huE/l2112ub772mxm6PX8bbYzyishkX/4=;
        b=gbcEcMpEBnudr3ihFoQDuT3JoAPGVRITAisH8jJggrntH5W+CG6RO50ecLKFbxUKRV
         6T4s5tppddubITBqT/liEqjpMzPXX80j0qImHI/ycE3XhKfapv18qz8LFwjhYoiMCFCh
         hkZmXN/C5tjqdFgthuID5GLmP56hUOqPsqv6DfGj1OZTzUqF1+tRKQMewRWv/00zQi14
         w5XnSDM1XQRoMImqmqpjpeSpHiL1IXt5oBtbQPTTWdmXmPNHcQc3r5Q537mxg2ALYLdq
         D5igGYvzl97BIGstXGBA4OFxgJ0BtJyG7F2AL1bo+IjybArmuGFbANSP/8jUGFnShe6o
         84Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686942518; x=1689534518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEz7FfIZN3huE/l2112ub772mxm6PX8bbYzyishkX/4=;
        b=X4nhs0xi2lBuvt5zRgrT+L7l2ioLtl3UIBFGpguiaedsB7b058Qf0kFZP7m7yak/DB
         0aWnWxo16XfK2S9YRqZK+3OKQe+2Ik0jKkr1c28P/izqGmBRog4SbKiafw/4Yx4QpiBq
         7QqFaLSqkKcLfK/2qy200ntgpbsAcwVs+TOc9xc45rGEEGj94K8dVVIYVwl+ZuJESt0B
         XvPCyWqYG1QrKmNG3ZvLI5gDBZ2cdXG8Qr2dhbHXq7rWIgJBQTTcv+MosA6ew9b9GS3G
         w0kgyZxrOo9YWYO2vbfOu4JQ0MKAZALIt2IHplCIALyNuh7LaqGIZjYnyDKcI6x/I5Hf
         BHjg==
X-Gm-Message-State: AC+VfDywzezdqc8Bq2ad+kUM48QmSGEbA4iDuaSFcDl86qbrDNEp2Tc5
        wHMJvyhH1WLjVM91d6gACe4Gs0viOSk=
X-Google-Smtp-Source: ACHHUZ62PdbxBqYh3r8/bZdHs9z1v5xV8vJ/VyaWSreUYj/mYnoormwq52+DJN//VKd0WqFm//gwLTyOhOU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e413:b0:25b:db6d:1264 with SMTP id
 hv19-20020a17090ae41300b0025bdb6d1264mr410908pjb.4.1686942518289; Fri, 16 Jun
 2023 12:08:38 -0700 (PDT)
Date:   Fri, 16 Jun 2023 12:08:36 -0700
In-Reply-To: <ZIyx8XTkLSgvFZX0@a4bf019067fa.jf.intel.com>
Mime-Version: 1.0
References: <20230603193439.502645149@linutronix.de> <ZH4eNL4Bf7yPItee@google.com>
 <87pm694jmg.ffs@tglx> <ZICuhZHCqSYvR4IO@araj-dh-work> <ZIC/b+AwvH2wIz/o@google.com>
 <ZIECZMHxtEYnuBAJ@araj-dh-work> <ZIFPDvsKGZ7MVSMt@google.com>
 <ZIx6xCgdILbjcw7H@a4bf019067fa.jf.intel.com> <ZIyxPbtwwObi0Qkv@google.com> <ZIyx8XTkLSgvFZX0@a4bf019067fa.jf.intel.com>
Message-ID: <ZIyzNDS3BLGsv4PC@google.com>
Subject: Re: [patch 0/6] Cure kexec() vs. mwait_play_dead() troubles
From:   Sean Christopherson <seanjc@google.com>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Ashok Raj <ashok_raj@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Andrea Bolognani <abologna@redhat.com>,
        "Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?=" <berrange@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023, Ashok Raj wrote:
> On Fri, Jun 16, 2023 at 12:00:13PM -0700, Sean Christopherson wrote:
> > > Would this qualify for the smoke test pass? I'll continue to look for a
> > > secure boot install if this doesn't close it, just haven't landed at the
> > > right spot yet.
> > 
> > Good enough for me, thanks much!
> 
> Thanks a ton Sean.. if anything you have now scared me there is life for
> SMM afterall even in a guest :-)

LOL, you and me both.  Thankfully GCE's implementation of Secure Boot for VMs
doesn't utilize SMM, so to a large extent I can close my eyes and plug my ears :-)
