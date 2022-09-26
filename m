Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F206A5EAF8A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiIZSVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIZSVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:21:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A715E550
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:17:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso757248pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Il0vkOLUU8Wr/hKXeWfSAnVT8noJuQa95krgaKi1p4s=;
        b=ndO8+/R02S9Z+MftcCPkoi50pEbp5cagm+Obh6sygHFMVdgUXeF5PNyfPJt6YEvCYt
         7RdkC9KxTEQ1Fv/6bZMFZkGIr9/TUJh/Dn0IquOtJBsG2IK16fFoMTYGcZh2H8d8P2Lv
         E0BL7I628eb7+l3xct+uiGuiEncpwJ/CGtXsOiVIS4zoIaaY54OEdOK3WFHmS14qRzp2
         0Ty0K9rYGGS0QkRH54SSZ8pTvZ8nhEavH4e/sfuRnTYiClyswgBgufRD61NvhQumJNje
         eV1nrk8nwKijMExrhQbqdT0tI2hk4ZcnTxN4TKSFoN6qylvUs4R0SxSojqwRZok22yWi
         sWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Il0vkOLUU8Wr/hKXeWfSAnVT8noJuQa95krgaKi1p4s=;
        b=3EfmJVgPedl/j/o0P02W8LSTmVnf3fmR8Jwcdfe5710hecLjq1momicmVKGUtrekBv
         jTeeG1ZxO3gKw09M4JJB2vOiLriQF979j0aHTpHVW5az7H7Q7qyO2RWrt2R0nt2+nq1I
         0A1+mys4Rma20w3BI0LtjJ37RrGBzRiSsUYwZSuPh/HvH+RtcUvGsAZ6Gz6eR3kwkQb2
         A4aUixQqUpuYYpUc9TghAEnDlX+pNKrXwbe2rPpIdxrYxuSk379pcifxzJ8schCL9sAh
         mN/LDSa8ZU4s4U+YwZsQxJecqJa5/znfhldgvLST5J9rbF547QFFnUO2RieNACIio8p+
         EU8w==
X-Gm-Message-State: ACrzQf3gchOcOAzp6gsl1uSGtKeGBm65IrQYO1hhHb1l5towocHuykAi
        o3vtxjgDmzzJGE8kBkITx9uJqrJExozvbCKqO6xKcQ==
X-Google-Smtp-Source: AMsMyM7HLUfbdMpdW3guEO/IoUjYq2oQz+OyMDkq7nLclHX/EA7jhIcMm5L/Nfwp+rvUkCew0JIURYshd4k1BklGYCE=
X-Received: by 2002:a17:90b:1d0f:b0:202:be3e:a14a with SMTP id
 on15-20020a17090b1d0f00b00202be3ea14amr49839pjb.102.1664216231609; Mon, 26
 Sep 2022 11:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvyD9OWF53ua2EZmyf+=YTx4f1mezDNkVLMxf3BKXW=_w@mail.gmail.com>
 <YzHIwvzhM9DSW9cF@dev-arch.thelio-3990X> <YzHJRH9hO1lfjSPp@dev-arch.thelio-3990X>
 <CAKwvOdkYr-Nv6PowyJ10DuP-uFLcvH1oGWSeQH3Dz_JM8vwp2w@mail.gmail.com> <YzHpT7t+9uSIYm0k@shell.armlinux.org.uk>
In-Reply-To: <YzHpT7t+9uSIYm0k@shell.armlinux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Sep 2022 11:17:00 -0700
Message-ID: <CAKwvOdkCCyP8W2pHf9ETKMgUtKCgcSwUb6=bMJ_8riwjyknpCw@mail.gmail.com>
Subject: Re: arch/arm/probes/kprobes/core.c:409:30: error: .fnstart must
 precede .save or .vsave directives
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        llvm@lists.linux.dev
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

On Mon, Sep 26, 2022 at 11:02 AM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Sep 26, 2022 at 10:42:45AM -0700, Nick Desaulniers wrote:
> > > On Mon, Sep 26, 2022 at 08:44:05AM -0700, Nathan Chancellor wrote:
> > > > Thank you for the testing and report! I brought this up on GitHub on
> > > > Friday as I noticed this as well:
> > > >
> > > > https://github.com/ClangBuiltLinux/linux/issues/1718
> >
> > Thanks for the reports. I'll take a look at filing additional bug
> > reports against clang, then moving the definition of
> > __kretprobe_trampoline to out of line assembler.
>
> Are you saying that .save should be accepted without a .fnstart?

No. It's just a bug in clang's inline assembler. But it does make
sense to just move it to out of line assembler anyways; having it be
inline provides little to no benefit.

Should I be using UNWIND from arch/arm/include/asm/unwind.h on these
.fnstart/.save/.pad/.fnend directives?
-- 
Thanks,
~Nick Desaulniers
