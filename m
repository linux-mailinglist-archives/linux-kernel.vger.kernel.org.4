Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABD567F29B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjA1AGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjA1AGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:06:12 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F11126FE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:06:11 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id c5-20020aa78805000000b0058d983c708aso3071854pfo.22
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6eQXh7MQlL9INvJ7bQlQBjXn8/parUiPWkEDqdSfug=;
        b=Cpnt+BwP145ujea1Utkqc9U5vBz5vDaoV5ftSZ6EUhOGk1n2rQ9xAqT8+gOgds0UAj
         kc6uHfPq5pU62bhF44GTuzSATyNPjb+R0vqU7oYTz+LagAIe6g6ReLRSw5Zk2r1u/heb
         AYPBsrl8i/FXWK3xk1WqPY6aqNiC38gM3Y3eTut4OhcP650YnUlx8EnBcgtgAKihb7My
         62QS8JDiAgJcN2g2hS18GQs7eRgMTKk1hBtOQIb9G2JjCHp7q02ncJR0JFIL4a93WHWG
         it0DLHmh9pe+cPmW0Oj/2vtRsKZZ09VlntB9+NsHOG3eZlORLh6iqyksSyX0ReVH0J/6
         sgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6eQXh7MQlL9INvJ7bQlQBjXn8/parUiPWkEDqdSfug=;
        b=S3d1BP82iWPcXv6mQe4PLQfk4ixoAPGGZF6/R5aQUvJVaOEInuvZXnZoSQlgX+CIPi
         zDhHZAXX91LI7zzA3noqAHu5ZDbt83DfupxFCF8+k0u9CWBb/KlpwRvtHGLDZyQ97Vkp
         8cJtU3pNdEtSPljDaaKQG5BZeGo1DytB6XKgApCV+4b7rQgvM7iw2W5gSUfmYEQOJz+o
         6zu6J551yHvbVhIOTmGz3vbOxHULdNmnRDcspkxxd/Hrw9TkRulQU6tBtVwJKoVeMTqA
         stAUaYgWuPQl2TyBaxvjx34lErpf6gbTkDSmfCPDSr5aAxiMqxPJ2LO6+lu/TR3d2pSa
         QaWQ==
X-Gm-Message-State: AFqh2kptbarakw/mti+jaQjO/joewZNV2gDMmGF+T9DGNvMjBufJOkpe
        8XQL6LOcXAAHJzjNZgUVC0PeIktG26I=
X-Google-Smtp-Source: AMrXdXtkvr9gTeBVrIKLfrp6ZIEjmtnJZOwG43G5gd/gZZeB148K3WUvBOu4cR1gxNLInDbtwrSqcEC5o8M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:778c:b0:192:ba7a:2be4 with SMTP id
 o12-20020a170902778c00b00192ba7a2be4mr4774876pll.27.1674864371054; Fri, 27
 Jan 2023 16:06:11 -0800 (PST)
Date:   Sat, 28 Jan 2023 00:05:50 +0000
In-Reply-To: <20221130233650.1404148-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221130233650.1404148-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <167424175801.2640527.5679926568908656054.b4-ty@google.com>
Subject: Re: [PATCH v4 0/4] x86/crash: Fix double NMI shootdown bug
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, stable@vger.kernel
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 23:36:46 +0000, Sean Christopherson wrote:
> Fix a double NMI shootdown bug found and debugged by Guilherme, who did all
> the hard work.  NMI shootdown is a one-time thing; the handler leaves NMIs
> blocked and enters halt.  At best, a second (or third...) shootdown is an
> expensive nop, at worst it can hang the kernel and prevent kexec'ing into
> a new kernel, e.g. prior to the hardening of register_nmi_handler(), a
> double shootdown resulted in a double list_add(), which is fatal when running
> with CONFIG_BUG_ON_DATA_CORRUPTION=y.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/4] x86/crash: Disable virt in core NMI crash handler to avoid double shootdown
      https://github.com/kvm-x86/linux/commit/26044aff37a5
[2/4] x86/virt: Force GIF=1 prior to disabling SVM (for reboot flows)
      https://github.com/kvm-x86/linux/commit/6a3236580b0b
[3/4] x86/reboot: Disable virtualization in an emergency if SVM is supported
      https://github.com/kvm-x86/linux/commit/d81f952aa657
[4/4] x86/reboot: Disable SVM, not just VMX, when stopping CPUs
      https://github.com/kvm-x86/linux/commit/a2b07fa7b933

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
