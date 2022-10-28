Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5466E611B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJ1U3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJ1U32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:29:28 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96784B877
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:29:27 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x13so4817083qvn.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B/0q7x7+qjN99OJ/2oEOEybhUKk96jVS5LgZ/DYyGqM=;
        b=HZQaVEg7A3nWhTltLxXM1tqni+i4mHJRSmqM4zwQct4rXvc7HT6MFXXcVOYaQO6GSp
         pxy+IS83Qi1hWhPdE+ClDKzIf6qzYLHLf8A2k8vDrk67lfegdeJHwDQ4HQ5c61N/eeJD
         Jnfm4sYHegcxjMwzvjUz684rUfJcR2W63g1uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/0q7x7+qjN99OJ/2oEOEybhUKk96jVS5LgZ/DYyGqM=;
        b=dcbQRPmigMF19oTrri2VWaof/mnugQORSM53d6uwibnThslSLF7pU6q9LAdEhmBn4F
         Jauzwwo7DMK7bCuqCUKq3xpganoNnuPqJVqVUyyeezw2H4ktzPGhIiPjJmfeErjjL7e3
         cAeabIgB4VWGDR3KrAjgDLbfBzU3JozZGhtrHNn2JoTa7O0Vabq0gkoiVX+6IAmpXgRy
         fuYJ4gq0sNuBE82IyKbcVgNb7g9SuLGyFTCLNrlzWDSBBhSpVndU96XF44f6Hrjzlna6
         QELA10Z4UxXv303Mf+9PWRFKsuHEq4BGewNo7g7cIKLTbKOhmooQx2HuGoEm4qB096oR
         Ht0w==
X-Gm-Message-State: ACrzQf2ICoQWC+Q4D9aYbOxdEKuKUjNEP9fm54AlhFtxt9iMi4o5d4tR
        q+6sHpLpFMR0WCoHRSAe7t1ekoGCIhFisg==
X-Google-Smtp-Source: AMsMyM68OWBkFXLJl2G0bCRT4mBzxhHo0v3JIWVb1Ll98hep/oJQgTL1V9lVFTsgrFkXU+eEPb7h1A==
X-Received: by 2002:a05:6214:20aa:b0:4bb:7e1a:9df0 with SMTP id 10-20020a05621420aa00b004bb7e1a9df0mr1131246qvd.34.1666988966480;
        Fri, 28 Oct 2022 13:29:26 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id bq8-20020a05620a468800b006ee77f1ecc3sm3637244qkb.31.2022.10.28.13.29.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 13:29:25 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-35befab86a4so57366977b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:29:24 -0700 (PDT)
X-Received: by 2002:a81:555:0:b0:36b:2d71:5861 with SMTP id
 82-20020a810555000000b0036b2d715861mr1254502ywf.340.1666988964567; Fri, 28
 Oct 2022 13:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <Y1w031iI6Ld29IVT@p183>
In-Reply-To: <Y1w031iI6Ld29IVT@p183>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2022 13:29:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEXm3y7BrFnymC_6icE7seicGyyML+Oxd_BP9t=ztNKg@mail.gmail.com>
Message-ID: <CAHk-=wiEXm3y7BrFnymC_6icE7seicGyyML+Oxd_BP9t=ztNKg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: drop -Wdeclaration-after-statement
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        rafael.j.wysocki@intel.com, masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 1:00 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Putting declarations in the beginning of the block is an afterfact from
> single pass compiler era. Compiler would parse all declarations, layout
> stack frame and proceed to generate code.

No, putting declarations at the beginning is still kernel syntax.

Don't declare variables in multiple places. It gets really confusing.
Put all declarations at the top of the block they are contained in.

IOW, -Wdeclaration-after-statement does exactly the right thing, and stays.

This is not about "old compilers", this is about coding rules.

                Linus
