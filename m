Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B966C3EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjCUX7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCUX7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:59:11 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260B81BAD2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 16:59:10 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s15-20020a170902ea0f00b0019d0c7a83dfso9647390plg.14
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 16:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679443149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5TgmYXXeWayYCNTGCu8BIwutYqhzL+J5AuaxNOWQ14=;
        b=K78CHxxRyw3eAw/lRAkugKqBPDbx+Lgdb9/ajUNF0Cd7Lutp4f+lXc0JLwgO3Ix6v5
         EL7wEePqxAxEaTl305ChXhpApD9P0PVwjQH2f+5MEez32P64/Al6WRCcLFyprNa807U6
         qdhqbp+rH9kYUtZM2urxxO/guTKD+7kM98+k6iGLzyT1j8wvHvuBzP5M2LzA+u2BLQFS
         Wnh2pUFdCvgqV1V/Zz+OOeCKWh2RN26l32/BCj3zqyiR9bd8TWOM4eoH1ryzUawk+6JI
         h/DJFgsgmUB9IiYsnt+tm4JEfDKTHxKbIeQ0H+SPBRtMDe7JM5184Wkky8XBw2X1inGf
         BkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679443149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5TgmYXXeWayYCNTGCu8BIwutYqhzL+J5AuaxNOWQ14=;
        b=xuI7FRXGHHmuHwys7zpcWNQkU/4ZBAakErcCv8IQqjnkW007rnT0zIMNymQRLZklL8
         SRmYguFeRRVJz4Vu894GP3kp7SK2m73YDYv3/CYvqQtTThJ5k4IDaN9b1rF8/+02bZrf
         qEwjZii1o2QQWb3jIexOKQ09JSyxPkwTKs9USTSwEAHEpsI9DiO9u02Rxkapm08nLAmM
         oEgmLe2L6ot6+4AdIpFDL3o8I/po00RXCHdspgPnUPRCYoSUQKYN6XMlOz4YfAqSzqpt
         7Mt8Jklz6EKDREADH+v2IytcjcG/7FD8+NeTyysVBjtYhgH13VPKTKu3XWWY4blcVJ+V
         hPyA==
X-Gm-Message-State: AO0yUKUvUmuJfkYuTfcQPfO1mbIX9c6feAdSRY48nC8Ff5yAqInGRDbi
        9/v6cX6dU8jvdqWXHfr2lfWxdVfS9Wo=
X-Google-Smtp-Source: AK7set8kr3dsIHIaDK6jUuo0c8QyOdlkxUO/1IqHA4w5xLAfPid1BnozknowQG9QndIvxMq97bM5X+1g8/8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:7648:b0:23f:6efa:bd55 with SMTP id
 s8-20020a17090a764800b0023f6efabd55mr497162pjl.8.1679443149679; Tue, 21 Mar
 2023 16:59:09 -0700 (PDT)
Date:   Tue, 21 Mar 2023 16:59:08 -0700
In-Reply-To: <ZBhzhPDk+EV1zRf0@google.com>
Mime-Version: 1.0
References: <20230201132905.549148-1-eesposit@redhat.com> <20230201132905.549148-2-eesposit@redhat.com>
 <20230317190432.GA863767@dev-arch.thelio-3990X> <20230317225345.z5chlrursjfbz52o@desk>
 <20230317231401.GA4100817@dev-arch.thelio-3990X> <20230317235959.buk3y25iwllscrbe@desk>
 <ZBhzhPDk+EV1zRf0@google.com>
Message-ID: <ZBpEzGxB6XzpVMF4@google.com>
Subject: Re: [PATCH 1/3] kvm: vmx: Add IA32_FLUSH_CMD guest support
From:   Sean Christopherson <seanjc@google.com>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Ben Serebrin <serebrin@google.com>,
        Peter Shier <pshier@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
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

On Mon, Mar 20, 2023, Sean Christopherson wrote:
> On Fri, Mar 17, 2023, Pawan Gupta wrote:
> > Thats what I think, and if its too late to be squashed I will send a
> > formal patch. Maintainers?
> 
> Honestly, I'd rather revert the whole mess and try again.  The patches obviously
> weren't tested, and the entire approach (that was borrowed from the existing
> MSR_IA32_PRED_CMD code) makes no sense.

Yeah, revert incoming.  This is just the tip of the iceberg.  SVM completely drops
the error,  which is why there are no boot failures on AMD despite having the same
broken logic.  Neither SVM nor VMX marks the MSR as being passthrough friendly and
thus breaks MSR filtering.
