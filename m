Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD426030AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJRQVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJRQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:20:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA29A3F58
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:20:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y14so33483542ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MzvQBJdkcDIYDd+OfMrFmk39apicV8PtEEGy7jmzxjU=;
        b=bOocASXc0vmOiyCGAuVKd+CFpXVrpxLO+ctGA4ZYCkz5L9EH9pWuRQ69uCSRIOvRBa
         ozmkbjbCC5Zwm5Wj7FrNRgw1cRed3ys+6A7Ovm4TilVhK9N00NKt0xU/M4xTHyakrS5j
         h1gQQe/oz9T1Wz0RRD9UJ6yzmAk8AZlDIQVySXuIlyUVjYenkire49NliuRKV3VCbENE
         cr3QT3ioHcPzU3TanppmxJRCUkk5GX+fpqiKLCL6sZ8lJMsLnL0comcuO7Qv/uBRuObM
         cMStOZFJKs0cL9KtAd5prqA8Za1l/Oe3Ekror1cnVmrm/JD7HZw4zAlDzuccTm8yIiBP
         XFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzvQBJdkcDIYDd+OfMrFmk39apicV8PtEEGy7jmzxjU=;
        b=Lmvg/qwvzHSughJWGSlKL3sZJmaJIBOr7gHJ5L/OeuT9HZkonKwsVIJQ1l+6B9jafu
         dP2olXKcGovx2lrvVf5fmEYRuutx/fygGBpcLE50uentQR0Tj4ZujdC3dzylRuz8MTPI
         kgPZSWN9bwRAVD3HvS47+3No6s85odo/iV8+MIMk/39Z0p8V1eSOEvfZyWiMD8rrbFUQ
         +ErnJ5xv/aa8MqkfM8N/cNO2ShWkDFKyQO9R6U/Ide03feJFdjU5yUSL3LmrWZZqQpB9
         CRUVN47EZTGqsrttE5vy/Du4N2wfIa1+PUusUgR+Vv8oHO/FfhRd/ORfsQYl/5DoZJUd
         aR4Q==
X-Gm-Message-State: ACrzQf0BXDXRphBoAuPVHHhN/Hn3uT4Lv5sHWX4m9D8GYB9lrFu79W5b
        Q9L4gIf3L7ylCzf+MppIiPSMT2k4Kb8lDGipPhmK0w==
X-Google-Smtp-Source: AMsMyM4R5enAOd9XqDkfiKl/EbFKi5tQCoMH//Bde0GSDZs7ANvUEBJ/IOKqXxtIsfT7y/Np8v4om6fq8TzN4MxVieE=
X-Received: by 2002:a17:907:628f:b0:72f:58fc:3815 with SMTP id
 nd15-20020a170907628f00b0072f58fc3815mr3136905ejc.719.1666110057245; Tue, 18
 Oct 2022 09:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221013160040.2858732-1-dionnaglaze@google.com>
 <20221013160040.2858732-3-dionnaglaze@google.com> <ba5b3553-370f-3114-b920-5efe9b40ab0f@amd.com>
In-Reply-To: <ba5b3553-370f-3114-b920-5efe9b40ab0f@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 18 Oct 2022 09:20:46 -0700
Message-ID: <CAAH4kHZKSxK1qeBALtiLO2kR7wUQ0K292HYGbipC=vAMgyFLJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] virt/coco/sev-guest: interpret VMM errors from guest request
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
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

>
> The GHCB spec has to be OS agnostic, so in the specification I would be
> adding a value of 16 so that this matches. Not sure we don't want to just
> use 2. We might be able to say the VMM error codes will follow the POSIX
> standard, but then the currently defined value of 1 doesn't quite match an
> EPERM.
>
> Thoughts?
>

I also thought it was a bit weird. Let's use 2. I'll send a v2.

-- 
-Dionna Glaze, PhD (she/her)
