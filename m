Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048076CA8E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjC0P2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjC0P2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:28:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC44E1FF3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:28:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-545dd1a1e31so37769547b3.22
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679930897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8JBRCY78ZSzuGLljBnUO/BHHKr3CYdvg+wmNXBil8g=;
        b=dqcHIJaGv5oQNTDf+jYjjPGGrIVf7GBwZMp7QKzoL40Ol9sdvVPKCNKWbbq9GE7KJw
         fTe0CyY9fv3KCh7uuvmqRddtg/Qdj1MvgfH3ZyNEhKzEzNOSYGKNPt782BB/RfXJWV0h
         YJXLib9kYrO/dThgwZ0DbEiBsrdteZ4adqj21utoOgQJb7NLVZKoUJW0adZJi/N4hmia
         erYe9zOl2i+p43YBOvbYEVtB4ZqgZkM/KEWnBpoH4GL6Yht+9fXQr+hIalSF/naVn7/t
         8Zo/gVSY6HGrlNNil6YicEPptQqFj0G/BaNEChxrR62BvW2eXaTWH4xtjoB4udj0inYZ
         TO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679930897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8JBRCY78ZSzuGLljBnUO/BHHKr3CYdvg+wmNXBil8g=;
        b=vgskFTXXwruTiDNI99J52dcRqbjPwi6c62iFEEvm6PiELWW+EwfKof3mXxuho1fmCE
         SNByePXM9G+B3+jJbMbcSBKC9aIYsI30wik5PuoCKDesaI7UlLbAxzdv+81vZBAezStR
         QiOel2VDuq21a0vmh2mGjsT/SfmCH+zfcy0bVWxToxeD714/Bh1tbO7yUsiFwDJYGgLb
         RTVtFtxGBHOtu+4JKtiWako+Wfwy4Inpu1SSVORSnzZcFyMbDLldu15DPBYth5siagmJ
         uEineBCc7PIAwKmYjMQZvAuvMKvHr1DLofyZn/5oVcdCar2F3ma0mSMaYUo+FYi2hlzy
         QghA==
X-Gm-Message-State: AAQBX9fLVDKfK7AYV3dgsFpJ4vd5ZdkJ++PLBDHCtsX8Q7fjKZ839O4f
        xklRj68J8vGeWxAdxwQbNBdJPj0wLkk=
X-Google-Smtp-Source: AKy350b83eGk6L6ND7l/neGCC3/wJiQDCcFmipF8r8V3OiF/SEkhLqe+P7zSzlOtyKX9choru9pVg685uOI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:eb02:0:b0:545:883a:544d with SMTP id
 n2-20020a81eb02000000b00545883a544dmr5743906ywm.9.1679930897136; Mon, 27 Mar
 2023 08:28:17 -0700 (PDT)
Date:   Mon, 27 Mar 2023 08:28:15 -0700
In-Reply-To: <151c3b04-31db-6a50-23af-c6886098c85c@redhat.com>
Mime-Version: 1.0
References: <20230322011440.2195485-1-seanjc@google.com> <151c3b04-31db-6a50-23af-c6886098c85c@redhat.com>
Message-ID: <ZCG2D1PyWobdb8jk@google.com>
Subject: Re: [PATCH 0/6] KVM: x86: Unhost the *_CMD MSR mess
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023, Paolo Bonzini wrote:
> On 3/22/23 02:14, Sean Christopherson wrote:
> > Revert the FLUSH_L1D enabling, which has multiple fatal bugs, clean up
> > the existing PRED_CMD handling, and reintroduce FLUSH_L1D virtualization
> > without inheriting the mistakes made by PRED_CMD.
> > 
> > The last patch hardens SVM against one of the bugs introduced in the
> > FLUSH_L1D enabling.
> > 
> > I'll post KUT patches tomorrow.  I have the tests written (and they found
> > bugs in my code, :shocked-pikachu:), just need to write the changelogs.
> > Wanted to get this out sooner than later as I'm guessing I'm not the only
> > one whose VMs won't boot on Intel CPUs...
> 
> Hi Sean,
> 
> did you post them?

No, I'll get that done today (I pinky swear this time).
