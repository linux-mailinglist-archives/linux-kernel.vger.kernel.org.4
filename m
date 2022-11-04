Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F9361A41F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKDWgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKDWgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:36:23 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6D931355
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 15:36:21 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x18so3981482qki.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 15:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1zC8UEjJyr6ERwRFhd60fEFxppRP/2qjA9WE/ETUXQ8=;
        b=EVURWeSJRAu6YaJSGaJGEBMAw9qbUR7Rh54BjMj2hjCocMww2MHJukxkKMbCMkiVDt
         qAI6HJRRwV0S+MkJT8IdtRtHWwF0k6LfbSDOxuha0KjwgcqUGxW1Pw+yGYLAnY28D42Z
         +TDCUoMpCdzxWdzEDG4HjBQ2eAWQBhxuonTyOmt3ItW+1pqCNEWS0+D8j1vxvmvJYCeH
         dGvY0/RG4CkuHxAAIgPMWZgtQINCvLl5FqfDhJc1qaWNUB6/4KkthJuFNKhzz38RtRO1
         i1eOSgpx/68VQoKtt55EucpQgiWeadNYHgXqKA4j2pGZGNWIEsMHAHcY0edahlr/yM4m
         YWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zC8UEjJyr6ERwRFhd60fEFxppRP/2qjA9WE/ETUXQ8=;
        b=I2RDbc6f4d+T+ciozLt0Gald8L7M44MAdfjbau1KnTPoCe2CosTEdAtIvOgPzLmwFF
         BcmoG0WRBIyvLBb/bNuPgbpbKFY6bitwIDE+RZjt+hdyGE/sKY9CvI7B0nQubZAuKdKj
         ViE1iI5c3oISErxFu06lQSkEHR4ZRZTdzRkViiKKnW1LY31ij+pavZ+JDMWr64tGAKai
         X3/4FJLOa7X7Py6o5KhAyUr0bYU88N+NN1S8eqKJYAIHIZGoHU+iU0hTtFvQM9AOllOx
         fRPQIFBPdEI17N5rlbMH+LUgcZTbT7umkbciLID0+pfdJkW8Njj7cf5rUKZsgxSQUURu
         9tng==
X-Gm-Message-State: ACrzQf0IAGoKTR+Acgec7SCVnyaAGeiep0pGZcjcRSfGKh2rRNvIxvbN
        DO6P/OMlqCLSscCLcVFHN0JHFVSrxLLXHXt2dFJcmA==
X-Google-Smtp-Source: AMsMyM5ZUWwN6ZOftzJUZihBtsuRpC/KpJNVxiWGu7dCgigkNvzEymSqNdF7fTpB1VC/FSQ1Z9lu9hitI8Xp1WCqGo8=
X-Received: by 2002:a05:620a:a82:b0:6fa:5397:4991 with SMTP id
 v2-20020a05620a0a8200b006fa53974991mr273849qkg.620.1667601380458; Fri, 04 Nov
 2022 15:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221028141220.29217-3-kirill.shutemov@linux.intel.com>
 <b5d04a6c-79b4-bbdc-b613-6958d9f75d53@linux.alibaba.com> <4bfcd256-b926-9b1c-601c-efcff0d16605@intel.com>
In-Reply-To: <4bfcd256-b926-9b1c-601c-efcff0d16605@intel.com>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Fri, 4 Nov 2022 15:36:09 -0700
Message-ID: <CAAYXXYy6xPPD0bLz9RrVO6FDWA9d8hiz4Po0hcEe0oupGq=L2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/tdx: Do not allow #VE due to EPT violation on the
 private memory
To:     Dave Hansen <dave.hansen@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Cc:     Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com, ak@linux.intel.com, bp@alien8.de,
        dan.j.williams@intel.com, david@redhat.com,
        elena.reshetova@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        x86@kernel.org
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

On Fri, Oct 28, 2022 at 7:12 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:

> +        *
> +        * Kernel has no legitimate use-cases for #VE on private memory. It is
> +        * either a guest kernel bug (like access of unaccepted memory) or
> +        * malicious/buggy VMM that removes guest page that is still in use.
> +        *

I think this statement is too strong and I have few concerns on this approach.
I understand that there is an issue of handling #VEs on private pages
but it seems like we are just hiding the problem with this approach
instead of fixing it - I do not have any fix in my mind- .
First there is a feature of injecting #VE to handle unaccepted pages
at runtime and accept them on-demand, now the statement is saying this
was an unnecessary feature (why is it there at all then?) at all as
there is no legitimate use case.

I wonder if this will limit how we can implement the lazy TDACCEPT.
There are multiple ideas floating now.
https://github.com/intel/tdx/commit/9b3ef9655b695d3c67a557ec016487fded8b0e2b
has 3 implementation choices where "Accept a block of memory on the
first use." option is implemented.  Actually it says "Accept a block
of memory on the first use." but it is implemented as "Accept a block
of memory on the first allocation".  The comments in this code also
raises concerns on the performance.

As of now, we do not know which one of those ideas will provide an
acceptable performance for booting large size VMs. If the performance
overhead is high, we can always implement the lazy TDACCEPT as when
the first time a guest accesses an unaccepted memory, #VE can do the TDACCEPT.

I am not trying to solve the lazy TDACCEPT problem here but all I am
trying to say is that, there might be legitimate use cases for #VE on
private memory and this patch limits any future improvement we might
need to do on lazy TDACCEPT implementation.



> +        * In both cases terminating TD is the right thing to do.
> +        */
> +       if (!(td_attr & ATTR_SEPT_VE_DISABLE))
> +               panic("TD misconfiguration: SEPT_VE_DISABLE attibute must be set.\n");
> +
>         setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>
>         cc_set_vendor(CC_VENDOR_INTEL);
> --
> 2.38.0
>
