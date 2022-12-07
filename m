Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B357C645EF4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiLGQbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLGQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:31:35 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9422790E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:31:34 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d3so17506026plr.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3tHC8UqGNgJNk6TUIr7bCokV90g8koZJwnZS2XdsT8=;
        b=Bzv/XCuwwJeZpjtRBlwO9DkjSATcs16n9qA3P9iyyDu7jYUvKcPWPmGcoa3v8Gqy2H
         s5JtXDeazntWePvMSvPmhL2nEhTEjASGm6tcFws5Zx0J9k27Ui1g16FoVhA1FYR752YO
         AP7tewK1w+ChRx+hN2XVejvySz6oPhTVMXrs6XlW+FKjWXbiLfR1vdsb6jYU96aU77K6
         K2yekX0/qMqhDCMnlyZCckcGLvAvse+ijkIu2pAC98vcRZ3LM9e5RbVnTJ9QPvnhIbMs
         ZtBmSKQ3jUb4grz+NtOBOOTyIaIhXpd7K05JlTFFru1ikNx0Y8Q5y6mfbMy/lWvwW9t0
         E4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3tHC8UqGNgJNk6TUIr7bCokV90g8koZJwnZS2XdsT8=;
        b=52V/YTq3yUjazF5Ycuo4PSIIqY4UTsoHzOhLDkD7F7aZhOzAFkWeYEczP0GGOW7Wg3
         /rh7NlyKL2d5W4VAup23XL/9I+25jpcDxUhLT2BKgfg/BT1plSLmyIvxQFB3p24F6n76
         fX1omu40cyRt0R62370m4Xsi+4Hp2yv4BMTi5IW3b2Uy2onKXUrBeULxIU0sS/5tGlGw
         KqAcfPOlSKc6bi3UlbWAFe77oi7WUfKeg8HdxiGNM4wQwgwsh0tJ0umjY1OLMfOcfjuQ
         lFX6lDr24UxGuuxtIK/QCa0N2EuP78qsusRUAlzowsNrnSGTkHwcOZwkdt2x1yhlEwQq
         IPKQ==
X-Gm-Message-State: ANoB5pkS3M+yRuIuVjPB55604Z8cVDg2fq7FNR7/xOuQqTzYljZBwSF6
        GHO4meEp6R+ZJppiNkaDAgQVDg==
X-Google-Smtp-Source: AA0mqf7Qtio1AnDmo3m6zWhMSlgbTaneoN4QTCspu3qSGcyilWQUe0Gek8GBl/yxGHLPvLa+ZgcnUg==
X-Received: by 2002:a17:902:e154:b0:189:6d32:afeb with SMTP id d20-20020a170902e15400b001896d32afebmr1142361pla.1.1670430694283;
        Wed, 07 Dec 2022 08:31:34 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902f39100b00178b9c997e5sm14769739ple.138.2022.12.07.08.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 08:31:33 -0800 (PST)
Date:   Wed, 7 Dec 2022 16:31:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC 8/9] RISC-V: KVM: Implement perf support
Message-ID: <Y5C/4s7OannaS8+H@google.com>
References: <20220718170205.2972215-1-atishp@rivosinc.com>
 <20220718170205.2972215-9-atishp@rivosinc.com>
 <Y4oxNbQwOldICdnw@google.com>
 <CAOnJCU+Eo7do0Rd+S4RBOMYpY+sG8ODqpkqA-Cii92bO-cG5+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOnJCU+Eo7do0Rd+S4RBOMYpY+sG8ODqpkqA-Cii92bO-cG5+Q@mail.gmail.com>
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

On Wed, Dec 07, 2022, Atish Patra wrote:
> On Fri, Dec 2, 2022 at 9:09 AM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Mon, Jul 18, 2022, Atish Patra wrote:
> > > RISC-V SBI PMU & Sscofpmf ISA extension allows supporting perf in
> > > the virtualization enviornment as well. KVM implementation
> > > relies on SBI PMU extension for most of the part while traps
> > > & emulates the CSRs read for counter access.
> >
> > For the benefit of non-RISCV people, the changelog (and documentation?) should
> > explain why RISC-V doesn't need to tap into kvm_register_perf_callbacks().
> 
> As per my understanding, kvm_register_perf_callbacks is only useful
> during event sampling for guests. Please let me know if I missed
> something.
> This series doesn't support sampling and guest counter overflow interrupt yet.
> That's why kvm_register_perf_callbacks support is missing.

Ah, I missed that connection in the cover letter.

In the future, if a patch adds partial support for a thing/feature, it's very
helpful to call that out in the lack shortlog and changelog, even for RFCs.  E.g.
adding a single word in the shortlog and sentence or two in the changelog doesn't
take much time on your end, and helps avoid cases like this where drive-by reviewers
like me from cause a fuss about non-issues.

 RISC-V: KVM: Implement partial perf support

 ...

 Counter overflow and interrupts are not supported as the relevant
 architectural specifications are still under discussion.

Thanks!
