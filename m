Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BC26095C0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 21:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiJWTHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 15:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiJWTHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 15:07:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F207550BC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:07:32 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y4so6801854plb.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vxuF9kYe8hiUZgthp1fPj2oasxNSqUYeuQAWi1KfdpI=;
        b=NGQfpHT1/lSNP/ctN/5db3V8w7tXM2IKMhuOdWc/+RU053BxefVqTN2izj/Gzyk3GF
         rMGF+0xkowpdEMxlP76WcJUeLIJX7ywVpwGrf57QMXHerM++oZKF3D9NHX0jypdYuN0M
         cI/mLYyPYDDSzJ6s5CHr9shiJpBgVNZsVnCOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxuF9kYe8hiUZgthp1fPj2oasxNSqUYeuQAWi1KfdpI=;
        b=cayaQsDrLIMH2TJAUGF+E+k9qN576vDGM/RaZSZOfJFpNvOmKdhmXw7X5htdXeWf9H
         eQEAygEGrfe+CtahadHkI5wJxin9FRpLm2HR9lF2R4ny9JchdFHXnQhPHB/YK/AqjJHv
         jrm7g2/Pnfud1cJdC4LKVE1U7z19dER+8KClHu4dJ2AOsU6nREIp3zHcfINp4sW+ddKT
         IUpshjkCNuELKsOk9cCm1w6K+zxJRawWHzcZQUTIn7MWIJwLU8Q+f18HjwH32VQpMkUK
         86aj/50aQQo5xsTcDIgp2qAAOX/hX/O5Tt/HYASAahUIJ/KdP31Z2+OSvDwH+bYjM3Z4
         CiDg==
X-Gm-Message-State: ACrzQf2hI8CxyUNsCvnZkdnSibIAAF1MWVYOSXQ6ky7ST0iuAXigHoye
        vdZF6P3q8GD8ahMwe1seDjH8/ghA5N+uTA==
X-Google-Smtp-Source: AMsMyM5wpIjgNKM21qjRhUb5wGBeVafC2DrPIAUk4zzuZcM/DgHEFpuQLX0eUrSX6p2FtvDAZz9J4g==
X-Received: by 2002:a05:6214:c8a:b0:4b4:3e6d:8cac with SMTP id r10-20020a0562140c8a00b004b43e6d8cacmr24731300qvr.104.1666552041205;
        Sun, 23 Oct 2022 12:07:21 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id t12-20020ac8588c000000b0039cd4d87aacsm11763963qta.15.2022.10.23.12.07.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 12:07:20 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id e62so8949917yba.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:07:20 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:6ca:9345:b2ee with SMTP id
 c4-20020a5b0984000000b006ca9345b2eemr7353445ybq.362.1666552040395; Sun, 23
 Oct 2022 12:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <166654892458.2211781.4685104302005471754@leemhuis.info>
In-Reply-To: <166654892458.2211781.4685104302005471754@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Oct 2022 12:07:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=S4zUePrFp-i-O7OL5pP+jHCWTWSmxzhdn7nqZJ9-qQ@mail.gmail.com>
Message-ID: <CAHk-=wj=S4zUePrFp-i-O7OL5pP+jHCWTWSmxzhdn7nqZJ9-qQ@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2022-10-23]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
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

On Sun, Oct 23, 2022 at 11:22 AM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi Linus! Below is a slightly edited report from regzbot listing all
> regression from this cycle that the bot and I are currently aware of.

Thanks.

I'll fix up the obvious ones right away to not miss -rc2:

> [ *NEW* ] v6.1-rc1: Regression in notification of sethostname changes
> [ *NEW* ] Reboot failure on big endian mips systems

because that first one looks trivial, and the second one I don't want
to see *again* in an rc on Guenter's list of problems ;)

The others I will have to wait for maintainers for.

                Linus
