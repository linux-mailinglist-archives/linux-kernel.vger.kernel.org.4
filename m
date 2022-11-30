Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0286963E59A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiK3XjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiK3XjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:39:03 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D244AF00
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:39:02 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so3518907pjs.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+55T+4ONOvaYsE+6obyb6DikaQJsPRvNFJ9o9IsRukA=;
        b=Hnitb+mv3s4ykP8SrDWRgX4N7fmyxP9h0XNLylRtM/CT+Y6HwowRv85rVfw36Wia1I
         HVZfo/MoqbuvWyZ79FwPILHpihssnWQ3IH0Et1BuvekGJu7R0+pBcXdYkhZyGLjD/1vb
         GnuUCnTe6F0Cdu+d0JuNVtFP/dvrPUtI8CQZYq8KvigG5eeccMNv2HrxBxaQwYWOuTKd
         wf7dX0tFBEhXFcXr9aSATpBBrFhFfg0xhGAgMMpeHs+tgpQwe1fUM2EcyDYQjsF4zueA
         XQo8cuK0BsgpSmI0Wp9+4lkslJx3MZJm2CPoXcwhHrtSgFETJwauw0LgDElwcaoQ+c0+
         T4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+55T+4ONOvaYsE+6obyb6DikaQJsPRvNFJ9o9IsRukA=;
        b=NRsLuIT4lly+A7SDDghed9DRvuMNgVy0AaASnUOFVzdqliBNAStrZPnaZnbac2WhnD
         tQRq9sSD9xZCCijbKmxRhK0wEVroOS91BT2ZKbpO4SkY1smoA11Zgz3Ye1RlQvLekKfT
         Ei6efb1CBTO5pnmtIMHmsetXndjYGjyKrq75dDSKJBV2FgRwKI0CqlNx6+71XHjsOS2p
         xIzkV7tY2QqQxXBoYwWT+y0xoy3pCMrxxUeAQwPogMMTCR9GSXtrqhy7X0VnhkE2aJ1q
         0xyqiRfRRcwTqdAXyJw94cDbam9i2tpTmAecc13yKmYPmV0sPZE6DMKOZg+EDYLXgsgV
         DUaA==
X-Gm-Message-State: ANoB5pld5rcn2oap1Dt5VcE1LMKTcLW1zN4/P+V35HS6e6O00g8JYRUg
        OGTEC7i7wwfh4WiU93lKrvBm4A==
X-Google-Smtp-Source: AA0mqf7Pumi1TwhZ/YS4keCyLs2pVgC7z3TCjEFYMruTaQ6IQ4xgog1/oM5nhDr7SbcBkXyWk35bLg==
X-Received: by 2002:a17:90a:4fc1:b0:213:16b5:f45e with SMTP id q59-20020a17090a4fc100b0021316b5f45emr71882071pjh.170.1669851541868;
        Wed, 30 Nov 2022 15:39:01 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d77-20020a621d50000000b00575fea99db9sm895901pfd.27.2022.11.30.15.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 15:39:01 -0800 (PST)
Date:   Wed, 30 Nov 2022 23:38:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 4/4] x86/reboot: Disable SVM, not just VMX, when
 stopping CPUs
Message-ID: <Y4fpkUUeu0s86Sh4@google.com>
References: <20221130233650.1404148-1-seanjc@google.com>
 <20221130233650.1404148-5-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130233650.1404148-5-seanjc@google.com>
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

On Wed, Nov 30, 2022, Sean Christopherson wrote:
> Disable SVM and more importantly force GIF=1 when halting a CPU or
> rebooting the machine.  Similar to VMX, SVM allows software to block
> INITs via CLGI, and thus can be problematic for a crash/reboot.  The
> window for failure is smaller with SVM as INIT is only blocked while
> GIF=0, i.e. between CLGI and STGI, but the window does exist.
> 
> Fixes: fba4f472b33a ("x86/reboot: Turn off KVM when halting a CPU")
> Cc: stable@vger.kernel

Argh, forgot the .org, and of course my scripts then failed to filter out the
address.
