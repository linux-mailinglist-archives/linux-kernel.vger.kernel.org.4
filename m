Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D59C736B67
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjFTLvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjFTLvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:51:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD6310F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:51:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f7677a94d1so6094976e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687261871; x=1689853871;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uk/ZJntyyMN1aW63L6PViu326GWnEG+0qzLApQJoBK4=;
        b=3YLv+I26okscckStyGbHbFPskI4CeaFRPtd0R1imHtZnByNRNtKsZJUtovm1U7hvqT
         xcEHrfYSFvItVu8CSeAm/hWoNkJT0NfSNZK1ij5MF9ONXLqKTktczWt0nE2CDHKHnHVv
         ln2uYUSeoujHktL0nM+3kh0h9jtLXklNnKPDEpUlfyetAYRp0dIKF4kQ37y18iVdBiiQ
         KqGd+1dyE3xc6mtfVbghTJUWiTyWIt2hpgwGcKxtS9VMO2qRqzEmOcwabHnEI0SkUr+R
         pNwdK8Op6G90Y3Iu3qeQOywgsE0fiT3uhuf3iMiLu6cS3VREwCyuQAroGYo6GCA84my2
         fIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687261871; x=1689853871;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uk/ZJntyyMN1aW63L6PViu326GWnEG+0qzLApQJoBK4=;
        b=XoAGc0WTgohsnQn2c4cdnB0tzUuIC/Hq+k78K10Stndxax1nseqhlOifa5iCv+E/97
         zOP17RxiiLjLzciqBEON37TMLrSMlZ/kF620Agt1WY0oOgj8dMxmCGIUHethSKZgagDY
         bhW8HrxtXLbfD3u+LTrbUvwJKLaI/dq5aOrHnHRlwVKwYWY9Q+RY3d6pSCqKhA6iUNql
         U2DfV+xZPcJUXJNlnbacpeY0o4NkcaOr2t5PhkLJY4R78XFLG+7U6OBK+qhwuHuLVioJ
         fVbssiJYufGzoUMvs40X3Q6em53FM8ulP6OTz/mKhO0s9rkfStpT4a36ivsJGWgArlMU
         bPZA==
X-Gm-Message-State: AC+VfDwS+jyNN5cZgRi3Af9+FAwzlSHguRYuAgOHT1HTPSNxrdt3+8zW
        2vFXarrKok9ZLsRkScj3R7DPiA==
X-Google-Smtp-Source: ACHHUZ4pfCj5B++gOGfsy2RGGFxWJ5sfAJBHcLIq86dWGb+bAbgXYoQZfPoAQear3HV2O4i/Woq9ng==
X-Received: by 2002:a19:2d58:0:b0:4f8:5755:5b22 with SMTP id t24-20020a192d58000000b004f857555b22mr6731320lft.27.1687261871236;
        Tue, 20 Jun 2023 04:51:11 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:8530:a6a3:373f:683c])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003f80946116dsm13216151wmb.45.2023.06.20.04.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:51:10 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:51:05 +0200
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] kasan: add support for kasan.fault=panic_on_write
Message-ID: <ZJGSqdDQPs0sRQTb@elver.google.com>
References: <20230614095158.1133673-1-elver@google.com>
 <CA+fCnZdy4TmMacvsPkoenCynUYsyKZ+kU1fx7cDpbh_6=cEPAQ@mail.gmail.com>
 <CANpmjNOSnVNy14xAVe6UHD0eHuMpxweg86+mYLQHpLM1k0H_cg@mail.gmail.com>
 <CA+fCnZccdLNqtxubVVtGPTOXcSoYfpM9CHk-nrYsZK7csC77Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZccdLNqtxubVVtGPTOXcSoYfpM9CHk-nrYsZK7csC77Eg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 01:45PM +0200, Andrey Konovalov wrote:
> On Tue, Jun 20, 2023 at 1:33 PM Marco Elver <elver@google.com> wrote:
> >
> > > On a related note, it looks like we have a typo in KASAN
> > > documentation: it states that asymm mode detects reads synchronously,
> > > and writes - asynchronously. Should be the reverse.
> >
> > This says the documentation is correct, and it's actually called for
> > writes: https://docs.kernel.org/arm64/memory-tagging-extension.html#tag-check-faults
> >
> > Who is right?
> 
> Ah, right. I did a quick google to check when I was writing the
> response and found this: https://lwn.net/Articles/882963/. But looks
> like that cover letter is wrong and the documentation is right. I
> wonder what the point of the asymmetric mode is then.

Maybe not as strong, but asymm mode makes sense from a microarch point
of view, where writes are always committed into a store buffer, but
reads can only commit when the data (incl. tag) is available.

> So the current code that you have should work perfectly. The only
> change I'd like to see is in the documentation.

Something like this (or more?)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 7f37a46af574..3c58392d931e 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -135,6 +135,8 @@ disabling KASAN altogether or controlling its features:
   fault occurs, the information is stored in hardware (in the TFSR_EL1
   register for arm64). The kernel periodically checks the hardware and
   only reports tag faults during these checks.
+  Note that ``kasan.fault=panic_on_write`` results in panic for all
+  asynchronously checked accesses.
   Asymmetric mode: a bad access is detected synchronously on reads and
   asynchronously on writes.
 
