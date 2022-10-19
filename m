Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39AD6050EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJST6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiJST60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:58:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F4E1D7990
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:58:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k2so42543085ejr.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nqrfsFeMZfhS6bWD+SqFGStrFEtikJ1tMdLJO6M50G0=;
        b=ohHVHUZpt9ghwKIidSTWnprL1GGUhR9ERIhhQbx0GrQ6VI4mel8AgICDKxC+ETReG4
         Hx2thc25Y/19zTRvrW/40ljXJSCt9VotWsgZPFHzUJYDCS71k8RqLAdA7i5jmP0qDIZj
         PHkADZoElKbnm6kPF77hwVBZ5xRJx2DQ2Z1j0E3Eloc/XWb7dLp53KIoLOC8LQaxGcN4
         6yqm497aICXHaOUAW8Me08UqAU7jeOcBlUexVHGrIGJuGHV9Rb3n2Q7e8a4GFRm8bs/D
         rrxnDqAt6PKbyszg71Qk/Ey5HMCRqYYZ3m2i6y0SPKuZfF1m9+Tw2JSTYthtOZSKjJGU
         ev6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqrfsFeMZfhS6bWD+SqFGStrFEtikJ1tMdLJO6M50G0=;
        b=kv2NDDo3NeT5Ljkiu89doCPyn7wmMcSH5QrZ/5gOHItJrxnFzctANvi9kdy0vs4p+N
         OSfqVZ+tBghfv81N62uZhoF2GTonTe6G6KRBCd1VzBQKrciizn5FznfRNcu1CFIpLU5S
         9iHGEj+VvxUgc6ovgUo0J+xVPskcVovTh8lDVOFWqWe3qbwQkv9hzW3xFrZckTfaKtcx
         0VupYxhtRTCEmUtrBxKoSzMAxY1ZKjkNvfH4qTAeZdCqj4/1BFy6YorYB6HPuOESKx2K
         WkwtzFjt2ExArb/OQsxjt8oJyiAyXsNytu4jWxP/QHBHAeYShUfdFmphxQ3G1Pzvo017
         Gh4A==
X-Gm-Message-State: ACrzQf11yORctQCyX6FenXILte2/nJIJ6NJHbbja+n/+nzrFN5Hnndah
        HVYrRtmUEaEDpO8pcptHlpNtYhCCrriXI9XzxFsKAQ==
X-Google-Smtp-Source: AMsMyM58eimJIicZuAGyvvAtMXJEcRcuyhKl3zVGhHFcA6PIJz39oLN/Du35tIIn+DRMrA1LAvqWpr3bDlpI6fU2CgM=
X-Received: by 2002:a17:906:9b87:b0:733:1795:2855 with SMTP id
 dd7-20020a1709069b8700b0073317952855mr8145776ejc.156.1666209503024; Wed, 19
 Oct 2022 12:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221012002323.2015637-1-dionnaglaze@google.com> <CAMkAt6qj-iHzk+FqCGh5z4EZHB9BzOfqES8RmjgYXs3CSg3CXQ@mail.gmail.com>
In-Reply-To: <CAMkAt6qj-iHzk+FqCGh5z4EZHB9BzOfqES8RmjgYXs3CSg3CXQ@mail.gmail.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Wed, 19 Oct 2022 12:58:12 -0700
Message-ID: <CAAH4kHbf6HO05bSwcSsqXTYKTn6wz44mivNY6ZpNrCVzgO3jRg@mail.gmail.com>
Subject: Re: [PATCH] virt/coco/sev-guest: Initialize err in handle_guest_request
To:     Peter Gonda <pgonda@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
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

> And currently we have:
>
> static long snp_guest_ioctl(...)
> {
> ..
>   input.fw_err = 0xff;
> ..
> }
>
> Which I think is an attempt to make fw_err make sense if the FW is
> never called, should we try to maintain that property?

fw_err = 0xff doesn't make sense to me actually. It's not a documented
code that the firmware was never called.
Still, we can simply pass fw_err to snp_issue_guest_request rather
than an unsigned long err, since a null pointer results in an -EINVAL.


-- 
-Dionna Glaze, PhD (she/her)
