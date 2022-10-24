Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135D160BB74
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiJXVAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbiJXU7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:59:31 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CD31057F7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:05:53 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id cy15-20020a056830698f00b0065c530585afso6436502otb.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jIUhXCylWTZyNF0ZZmlYqRt2dvHO3F0L1QAEk1qEOdA=;
        b=HKNQqa9nE7I5KHjD1Kgg9r8gsp+/lkT00xq1s1N/WqPzv82hGtdg4ru/MPSat9GVQH
         mKihWdsl2O7Jk3W2xsc2tl9n3av8Dex2X0OBP3Nkk8X34r1018FV1Sf2lzONZxhV8h2X
         kLjJMF2Wug76tH7D/OJiZeNyz/ulzWzidfQJ5yiiN5wV8RbBh7k/jL6DPQMnpd6U1pfn
         61wE4Z58mlmj93aoi+K16koSgiH47MsJdLheTEeLcMTLXCpOM7P5u+TOY4NrOdriVmvW
         S8dVPijwh8oXQlYMtpbdAmQYz3z3bTSSOV+coYntKJm7naJxl7wfG7mVFbfvr6C+bewi
         mY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIUhXCylWTZyNF0ZZmlYqRt2dvHO3F0L1QAEk1qEOdA=;
        b=Fu4zonKC7wxwxok2Ph3m2PP+GTf9ycY05Byk3ejoEkBlSsV3a/q9fRsEsyQi5dz9iP
         R1sMKJmJQmYzgZRbF3fkjnnuak1pumPxP+hODuuV1LXHRzmhuOrwgelyTr/h7fIlUmIL
         ezqsy+/SoJUeodGqm6RoR1JdUMkcwNk92n8cWDnre2Ulz1Ko86fPXC9jRiVZII2gBywv
         GJ/UVhn1b3tvPOfGPYbWtAXa9Olsl5trA0cGorgfDp7a3+GdtQ03T1ck8R4QCY08UYC7
         LzVtnefCWNGFqPQ4ASC7rdegIRY6Goocy24VzZpbwaAFDR30RFOA9N8ONCMbiKCjH0R6
         qU0g==
X-Gm-Message-State: ACrzQf0sDEj08LkX27FBfnXyYkagiJBQITc/s6MWkZoVPLJ0QrBlGBEo
        wTeRqBnS0qD22E+Ky/t1U7ZqoO5dlYy/T07MfYQoUgkgM9Q=
X-Google-Smtp-Source: AMsMyM7v32guca965IG+5az6BzOI3Xcx78mmvt0lTEpANPeogcGiz1tjcRfDBpEOXd60mtEGsL6cmh7O797JScjDu50=
X-Received: by 2002:a9f:3626:0:b0:3b5:c921:e0aa with SMTP id
 r35-20020a9f3626000000b003b5c921e0aamr20604005uad.92.1666634228830; Mon, 24
 Oct 2022 10:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221021222811.2366215-1-eugenis@google.com> <Y1OdfXuLmp/gr1Z4@kroah.com>
In-Reply-To: <Y1OdfXuLmp/gr1Z4@kroah.com>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Mon, 24 Oct 2022 10:56:57 -0700
Message-ID: <CAFKCwrg4=MdqNVcma-OnbmDDZXtporAr0x=uBn3rCO7dbC4hFQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: Consolidate TCR_EL1 fields
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Oct 22, 2022 at 1:15 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> What stable kernel branch(es) do you want this applied to?

5.15, sorry I forgot to mention that. Thank you!
