Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD468611C40
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJ1VMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJ1VMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:12:12 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31611C69DB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:12:11 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id l9so4275915qkk.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y4o2iMhkVAOREnU53dwS8/e/eUJEe4Yh9KAfyD2uG24=;
        b=Aw+bp8eZXBoQunwBo4am7WGuexZkMaLGM2p2OYTqSUTQWn/iHKn1u8UgRkLowjDKDo
         sC08FfSA+1wbf1xIy080Meepcec18rkaQnkeLUTd6UI+gjGjfd6YIRinrmdR9MGS4T2g
         VhA11YOH5bPsC3xPSOS+dt0fpSBAaV2OBgPKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4o2iMhkVAOREnU53dwS8/e/eUJEe4Yh9KAfyD2uG24=;
        b=Y4oBEG9ZpGrocWjIe//NuPRLtwLG2r768Yij3Kl/kSwHRB0oDxoCJCy7rBlIYQDhAC
         0tddzMx+c0I9Ol4dwkh9OAuQotdRfJtWexzvsBGAqi2Gv2YCMa508VyLN4zrSfJq4aI2
         SyLuJMziAm220czOmj77gOe6Bc4NyuiZyw/+zFGzz4IyWx9cLE9IrBHBu2Wa4SCBMgNx
         MzPp516Oc7JJqlB/j/A7/FAeGNfBq2WD4ngSPypDijfMZms4Se6RRdkXN9wbIWLEJ0X/
         0EQg2UuJ7aOfpfhXFpI1ItU2yQz2jdoljrVvLZNHGzFwq03Nd2kU5qhcC28HkqkbuaY8
         YTlQ==
X-Gm-Message-State: ACrzQf3JIMv0Squ0ek1ImyhWlBHU7hcOa7bOM9xJDorNge+qNUnKfVXp
        l9GFiTdaC3huHWzNX+dBBtIC2bXCNKxEnA==
X-Google-Smtp-Source: AMsMyM5eh+e1kuToAZ+LQSntdt1SKPUE6aSBPFe1dMxISe8QIRLJhatjHksk6xckVL+NVWNTTMKkmg==
X-Received: by 2002:a05:620a:8002:b0:6ef:14a1:4b05 with SMTP id ee2-20020a05620a800200b006ef14a14b05mr1042934qkb.562.1666991530659;
        Fri, 28 Oct 2022 14:12:10 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id h10-20020ac8138a000000b0039953dcc480sm2870164qtj.88.2022.10.28.14.12.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:12:10 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id j7so7476138ybb.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:12:09 -0700 (PDT)
X-Received: by 2002:a05:6902:702:b0:6ca:a588:2904 with SMTP id
 k2-20020a056902070200b006caa5882904mr1110297ybt.571.1666991529675; Fri, 28
 Oct 2022 14:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <Y1w031iI6Ld29IVT@p183> <CAHk-=wiEXm3y7BrFnymC_6icE7seicGyyML+Oxd_BP9t=ztNKg@mail.gmail.com>
 <Y1xBwRCHoQtMyPf8@p183>
In-Reply-To: <Y1xBwRCHoQtMyPf8@p183>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2022 14:11:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKn9xcqqgDi2rSPUyn6g-1_j-ZwS0BaXuvvwDgNBSVQQ@mail.gmail.com>
Message-ID: <CAHk-=wiKn9xcqqgDi2rSPUyn6g-1_j-ZwS0BaXuvvwDgNBSVQQ@mail.gmail.com>
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

On Fri, Oct 28, 2022 at 1:55 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> It is not. Somehow millions of programmers manage to find their
> variables just fine in C and other programming languages.

That's fine. Go work with those projects.

The kernel also does lots of other things that people disagree with in
order to be a more cohesive body of work. Millions of programmers
manage with 2-space indentation and other horrors.

The kernel has its rules. Not having variable declarations in random
places is one of those rules. One of many.

Deal with it, and the fact that I won't apply your patch.

                Linus
