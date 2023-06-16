Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6227732A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245689AbjFPIjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244439AbjFPIja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:39:30 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11A2D4D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:39:29 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f6195d2b3fso494017e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904767; x=1689496767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+F5ipwxxMtT+ZL+axMsUdKjWgaE9QxBGsYhfSmi3Bo=;
        b=W/C/45Y/3zhiTtPpvcG+oQBZwfZ5g7rTr+QbB1r+SLIlE6ZA5yzpTnwAs1234kmUjM
         0Pbg41l0I+bW91cv5Ke2rocSgpb/vLiO8Tza3NibWrRH+iuH915PNep92HYcPX8LM2tl
         s1Esmikag74ZNvT2VKGiZEw431GwLo/IFPGLtwi5Kr5NnZX7eCcF9wKco/Wg1kg6/gl1
         fGkQX4wM2gzQzGrb8F6P15QtbZ0/syUgyuEu5+2JypX/0DkUHmDoMkBJ9cojdGNOP9JY
         D4c1xi6lz2+sKX6afDjUnC0c2i4CSXjZaHA1xLP2biB7LeDtQO6S56rxdTLRYcYyEIcX
         /jtg==
X-Gm-Message-State: AC+VfDzbiIBzBIMuOC14LSj07fqp6BOMvXpdBSZsh5I0xwFSiC0YRdNr
        Pvbb8SGxxRr+Y4m83bm0kE0=
X-Google-Smtp-Source: ACHHUZ4wb3vV9bVpaq4EyteKZUjh1t5PzqDgHPgzJy/mkbkoTBbQo0YxVo6f+ujNPpztmE5ggVE90w==
X-Received: by 2002:a19:5017:0:b0:4f6:266c:22fa with SMTP id e23-20020a195017000000b004f6266c22famr785310lfb.49.1686904767100;
        Fri, 16 Jun 2023 01:39:27 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-022.fbsv.net. [2a03:2880:31ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id s14-20020adfeb0e000000b0030ae53550f5sm23042511wrn.51.2023.06.16.01.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 01:39:26 -0700 (PDT)
Date:   Fri, 16 Jun 2023 01:39:22 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     pawan.kumar.gupta@linux.intel.com, jpoimboe@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
        leit@fb.com, hpa@zytor.com, x86@kernel.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] x86/bugs: Break down mitigations configurations
Message-ID: <ZIwfuvaRFNqZyCC7@gmail.com>
References: <20230615164417.3588162-1-leitao@debian.org>
 <87352shc98.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87352shc98.fsf@linux.intel.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 10:21:55AM -0700, Andi Kleen wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
> > There is no way to compile a kernel today with some of the speculative
> > mitigations disabled. Even if the kernel has
> > CONFIG_SPECULATION_MITIGATIONS=n, some Intel mitigations, such as MDS, TAA,
> > MMIO are still enabled and can only be disabled using a kernel parameter.
> >
> > This patchset creates a way to choose what to enable or disable, and,
> > get the mitigations disable if CONFIG_SPECULATION_MITIGATIONS is not
> > set, as the rest of other mitigations.
> >
> > Also, we want to print a warning message letting users know that these
> > mitigations are disabled.
> >
> > This is a follow up to this discussion: https://lkml.org/lkml/2023/6/12/798
> >
> 
> Isn't this all roughly equivalent to CONFIG_CMDLINE="mitigations=..." ?

It is, indeed. But, the main motivation for this patchset it to solve a
consistency problem on our Kconfig. The user would image that all
speculative mitigations would be disabled if he passes
CONFIG_SPECULATION_MITIGATIONS=n, but that is not true. The user needs
something else, such as CONFIG_CMDLINE="mitigations=off" or "mds=off".

This patchset give more consistency to our Kconfig options, and the user
doesn't need to read between the lines.
