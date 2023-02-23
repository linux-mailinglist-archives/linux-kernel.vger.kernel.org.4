Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2016A01A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjBWD6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBWD6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:58:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5EE1024E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:58:20 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so6954860wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IxsGBXV15vlKxvjhvdM60Z0zaiMtg1YCb2+rbW/W2ro=;
        b=f62pn7qnbDZPQPC27XciIzjpEUO9N1R8bF4LgHcNulv5+2GQNhIhYRglneCR0HRN+D
         UyWBjuyBG66Y3NmxrSrAgpKVv6WL+hzFIo5B9COZ5TIQPVhATe8RaTz7kNZVJUDFNwPY
         bGM/X0mRtNdfRRTF+xI5/dkRUuqIMLlwXO5wWgZTPQUkTkuUgpMkkmulBxIFNT3VoRx6
         e3tSdmTDUg7WhUcEnAt+F1yHhDjJz7V96LkfkOjbmxgZL4HdlSHhGfaYzIHhJtNHGJq3
         4zQ3zVUHqLJkR9TY1F3wewEOcbZTgn9W7e75rb+YhFP/ZEch5Od8yGskheTAw/m37okN
         nWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxsGBXV15vlKxvjhvdM60Z0zaiMtg1YCb2+rbW/W2ro=;
        b=S/THb26qFTy3y+fU7hKfzRz+Gmn1vu9fC+F+y75npHdKwU9mJUZ0yD6tCR0Sv+5HJK
         LhNuTsTRMHPODEukpefxEEUdiDkr4R5sZkj2kxq52IgAfPkMgdt/BVqdUVFsz/WHZ9ra
         siQj7fFck/YUCdHQu4efnFFLaDOBmgS84IcXgDs0i4XsxbenRE467QuD4XoP+E+r29Qe
         0G8Wl/RFOUySpMzqYDvYSOxsfEmiM9wbABdXj3XtyXFBwH2d7I/KcXa0Z1huLEDNqBUj
         shpzWKmQ6Tu/c5Cds05hZ8BRT8zMxS0pLn+rKtN/VFQi4wRJdYByu/QGiiEXb0voGFem
         m3Mg==
X-Gm-Message-State: AO0yUKUwmUi9/3CTS96Me2Eeh0WX0cXMcJRFvCumhh7jxuU8fUn78U0s
        /Nd3cWoSRj7pl/GAPybj/EnZ+zUNlggteDcYvWKVuXuTm+wNpYgG9CM=
X-Google-Smtp-Source: AK7set81Io+7cYMCH8vgLkj3wEespo3eo98ecXfzfsqmr2KHVd8D8Oi4GQsLqaZX1HE9YoYR0AXH41YD+LNq4uhCDz0=
X-Received: by 2002:a05:600c:1c95:b0:3db:1d5e:699 with SMTP id
 k21-20020a05600c1c9500b003db1d5e0699mr1152414wms.195.1677124698785; Wed, 22
 Feb 2023 19:58:18 -0800 (PST)
MIME-Version: 1.0
References: <CAP-5=fWxF6in4vQyGuh=0kpAYEXAYZN_KobXCY=TX2oxssZ+HQ@mail.gmail.com>
 <Y7w2qshoCEjKKVlz@kernel.org> <CAP-5=fUeC2nhUhFN69+sL687csSsoi5=ZEkRH70vUy+kTiF52g@mail.gmail.com>
In-Reply-To: <CAP-5=fUeC2nhUhFN69+sL687csSsoi5=ZEkRH70vUy+kTiF52g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Feb 2023 19:58:06 -0800
Message-ID: <CAP-5=fVaH0p4NkKiQSxaxZnT5zR=hbwSArO2n0L7tCNZwBumKQ@mail.gmail.com>
Subject: Re: Google Summer-of-Code 2023
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

The Linux Foundation was selected as a GSoC organization for 2023!
https://summerofcode.withgoogle.com/programs/2023/organizations/the-linux-foundation

This means we're looking for contributors until March 19th:
https://developers.google.com/open-source/gsoc/timeline

Some project ideas are listed here:
https://wiki.linuxfoundation.org/gsoc/2023-gsoc-perf

Please help to share!

Thanks,
Ian

(Resend in plain text because of LKML's HTML filters)
