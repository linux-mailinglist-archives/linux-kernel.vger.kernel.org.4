Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FFE6C52F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCVRtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVRtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:49:40 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D1753DB8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:49:39 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id k1-20020a632401000000b0050beb8972bfso4833292pgk.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679507379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dsyiAdjciLomvR7zo/rxP12/2llmHgaouRXJN9t17RQ=;
        b=gunIUjyn90Zxg9Ds5jVzO7KrTCYCzCbMIhz+g0TVvHab4gIDGmfYMyiMjYKOR1Q4hF
         Pd1YgmApASIt/7CpsdoWCQu3Q9Zncq7pEFP2Fbq5lymG0p1keukJV0HdYYfRkeMiaIX1
         bzt1fxTxwum0Kr8b/qb1KnjTrF5/Ph+zsLwB/jFQn5Md+n+APIFOfqUoiEevOAgfBwgV
         geyr2IsOXoYVedhKnfR14UhF4p9MnEmRH7Ict+li2Kejz++OjUnb8oQslPqrwi/1mLn5
         dbdAjUlA51l3kzLHRRHzI+j+bmYeOokl2ziYsi4VipZ0xnVC+b0IjnpfWid7PzPEdTzJ
         0cRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679507379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsyiAdjciLomvR7zo/rxP12/2llmHgaouRXJN9t17RQ=;
        b=l9j4TIUfjwhndPWupDhWG4GBk/mTSgBUxFhnqV0YXgUF3USJCoPUhxIzNC34/MYasc
         UGHHe++QokbsedOKYaNy2+kRRur3ijtgoOmxgTvlMBPJ6UimiUNCTyrW/5ZR9KyKPoOI
         JvdfqtOpOst9wXLLyaS7qHeC02atqlur4b06ZBQRuV47wc63neuuY1PxWo1MIXHT95O4
         Fb6KBc9VEs91B2bkvKzjhZb4VV7JeZo3JHqP1qHVqo0Znh5Ar3o4DVdPtej0zd9ckMqF
         zHty0gK+oQg/7ktH3CDGNv3k+7dl4djFLWUMWSqppHe30yv9y3wuYXUt2wILzXfj2Mg5
         VMeg==
X-Gm-Message-State: AO0yUKVkmis6pEWh8lFUsvGabiTwNbs31hRCmP4f8HExsdAIbELQGzwX
        987QrBkQKfFoQj6c+W69yzRnBbGvQMQ=
X-Google-Smtp-Source: AK7set8EUT+58AxbbTlVDSXdjZXe51CmACxL4CLRD1sdZ+gusQMK9722D6WWpg2gcfzXKrY13Ji8cdmYMwY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:244f:b0:1a1:d366:b0bd with SMTP id
 l15-20020a170903244f00b001a1d366b0bdmr1425995pls.9.1679507378884; Wed, 22 Mar
 2023 10:49:38 -0700 (PDT)
Date:   Wed, 22 Mar 2023 10:49:37 -0700
In-Reply-To: <20230307023946.14516-35-xin3.li@intel.com>
Mime-Version: 1.0
References: <20230307023946.14516-1-xin3.li@intel.com> <20230307023946.14516-35-xin3.li@intel.com>
Message-ID: <ZBs/sSJwr7zdOUsE@google.com>
Subject: Re: [PATCH v5 34/34] KVM: x86/vmx: execute "int $2" to handle NMI in
 NMI caused VM exits when FRED is enabled
From:   Sean Christopherson <seanjc@google.com>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        andrew.cooper3@citrix.com, pbonzini@redhat.com,
        ravi.v.shankar@intel.com
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

On Mon, Mar 06, 2023, Xin Li wrote:
> Execute "int $2" to handle NMI in NMI caused VM exits when FRED is enabled.
> 
> Like IRET for IDT, ERETS/ERETU are required to end the NMI handler for FRED
> to unblock NMI ASAP (w/ bit 28 of CS set).

That's "CS" on the stack correct?  Is bit 28 set manually by software, or is it
set automatically by hardware?  If it's set by hardware, does "int $2" actually
set the bit since it's not a real NMI?

> And there are 2 approaches to
> invoke the FRED NMI handler:
> 1) execute "int $2", let the h/w do the job.
> 2) create a FRED NMI stack frame on the current kernel stack with ASM,
>    and then jump to fred_entrypoint_kernel in arch/x86/entry/entry_64_fred.S.
> 
> 1) is preferred as we want less ASM.

Who is "we", and how much assembly are we talking about?  E.g. I personally don't
mind a trampoline in KVM if it's small and/or can share code with existing
assembly subroutines.
