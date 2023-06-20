Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEC3737216
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjFTQuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjFTQuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:50:05 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4492172C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:50:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-25695bb6461so4086612a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20221208.gappssmtp.com; s=20221208; t=1687279803; x=1689871803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bSEahIWuWvh3A7BBDnL3sX3amCBedgDlTKV+iX+mItU=;
        b=SxhmsbX6Uvs7i8kbMxodpZR+QM/TeG5Q9/PTbbf+nTBjNmZNZOIKh42iZEsrRuHeeF
         Za2QQqgN/0XBz3zQ3YTVUZp5DtXQSK5A5Zwf8tBAmDZW+SS3fnGTD34ycbx29Al92BhO
         35/b7SkO7kVeliy0yEr06uneHtycCB8sm33VyVIWxz+7xDGW8L4Mi7zYZYxmxkrcBkzJ
         4IC/h1iG8McWH7Zte2mCOSCnb3MdR+c1C5YN5A94+aboMoHUtKT0bA+43YHMRzrOMG4S
         DwjRkZm1CJHGCHg6BLv4jspf8oYa+YAAN8qntSwPW5g95H6Dux3/RpprTCvyHCzzZcNr
         Ht7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687279803; x=1689871803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSEahIWuWvh3A7BBDnL3sX3amCBedgDlTKV+iX+mItU=;
        b=Ph23qIyCOxtP73mybw+MazAfw8UqjVT5fImveiFZSfRBlfZ/GK2Ot70iDGLp7hM4U1
         2RZplXBZK2om9YdpTANQUX3M7uxpU5wosL03KByKXDWdOhq8RAjlaqCoVC2uDjHVMCyV
         ATrprocoMJlwm5MRkVg8yjwj0N1BNYG04Ark3ncKKOxo9y+oK7srkiYCaHNRVsueQbgt
         xwzTvlI29Drf4XtX9vzd1savPA77nUWCERimgUjEA+znYikRhJhhywzvbB9e9qnkabMo
         sYf22ZDdiyzzZgxVSdteCN26XRLcZpq/4wIUHA8FlJqUmvZMudT1ya89gtJ6WN7vUSnL
         lf9g==
X-Gm-Message-State: AC+VfDyV2KQj5WXN4ZjFEkI0TffdnHaAtA42djewdsrzQeZ/HxBITKI7
        yGNQGg14uF7R7s6T1W71UvaDZdzXxWmd9XZq85g=
X-Google-Smtp-Source: ACHHUZ5q1Ps0wpcvbhXOnSBBv6lSB4opr6Fio6gzh+fZ89ASCBCd62gJtbCxrdaFhw0jzwbhox4FCw==
X-Received: by 2002:a17:90a:430a:b0:259:bff8:17a2 with SMTP id q10-20020a17090a430a00b00259bff817a2mr25100145pjg.0.1687279802961;
        Tue, 20 Jun 2023 09:50:02 -0700 (PDT)
Received: from telecaster ([2620:10d:c090:400::5:ea8e])
        by smtp.gmail.com with ESMTPSA id na12-20020a17090b4c0c00b0023b3d80c76csm1753518pjb.4.2023.06.20.09.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:50:02 -0700 (PDT)
Date:   Tue, 20 Jun 2023 09:50:00 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
        linux-debuggers@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] x86/unwind/orc: add ELF section with ORC version
 identifier
Message-ID: <ZJHYuH/DD6tqJ+bu@telecaster>
References: <aef9c8dc43915b886a8c48509a12ec1b006ca1ca.1686690801.git.osandov@osandov.com>
 <20230614091751.GE1639749@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614091751.GE1639749@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:17:51AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 02:14:56PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Commits ffb1b4a41016 ("x86/unwind/orc: Add 'signal' field to ORC
> > metadata") and fb799447ae29 ("x86,objtool: Split UNWIND_HINT_EMPTY in
> > two") changed the ORC format. Although ORC is internal to the kernel,
> > it's the only way for external tools to get reliable kernel stack traces
> > on x86-64. In particular, the drgn debugger [1] uses ORC for stack
> > unwinding, and these format changes broke it [2]. As the drgn
> > maintainer, I don't care how often or how much the kernel changes the
> > ORC format as long as I have a way to detect the change.
> > 
> > It suffices to store a version identifier in the vmlinux and kernel
> > module ELF files (to use when parsing ORC sections from ELF), and in
> > kernel memory (to use when parsing ORC from a core dump+symbol table).
> > Rather than hard-coding a version number that needs to be manually
> > bumped, Peterz suggested hashing the definitions from orc_types.h. If
> > there is a format change that isn't caught by this, the hashing script
> > can be updated.
> > 
> > This patch adds an .orc_header allocated ELF section containing the
> > 20-byte hash to vmlinux and kernel modules, along with the corresponding
> > __start_orc_header and __stop_orc_header symbols in vmlinux.
> > 
> > 1: https://github.com/osandov/drgn
> > 2: https://github.com/osandov/drgn/issues/303
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Patch looks good to me; as a follow up I suppose we could verify the orc
> hash on module load, to ensure the module and main kernel agree on the
> ORC version used -- but we can do that later.
> 
> > ---
> > Hi,
> > 
> > This is v2 of my patch to make it possible for external tools like drgn
> > to identify versions of the ORC format. As stated in v1 [1], I don't
> > want ORC to be stable ABI; I just need a way to identify the format
> > being used.
> > 
> > This version incorporates Peter's suggestion to hash the ORC definitions
> > instead of requiring a manual version number; this is easier to maintain
> > and more resilient to backports.
> > 
> > I would love to get this in before 6.4 is released, and then hopefully
> > backport it to 6.3-stable.
> 
> So we're fairly late in the cycle and it would need justification to go
> into objtool/urgent -- preferably only fixes at this point.
> 
> But given we 'broke' the ORC layout this cycle, we can mark this with
> Fixes: for the two mentioned commits.
> 
> Josh?

Ping, Josh, any chance of getting this in to 6.4? Sorry to be cutting it
so close.
