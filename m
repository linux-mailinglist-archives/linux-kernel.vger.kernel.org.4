Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9CA710096
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbjEXWDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEXWDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:03:32 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BF210B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:03:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso1138246b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684965811; x=1687557811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZ5PDW7meFLPxJz6yk7BxpA6R+nIgkvFNvqiUV7WSgc=;
        b=Ayznotjh2PSxFB94LzDpF4LwhkttUa6Fw0rGnuKWalMVacOTK7mV4CL0xBF1LKo1ml
         8F9adX46inH2F4zNJq0jstItuu8nRm0U+Duu/2IoiUC7lDVQUy7ShxgNrnKcLAlFXFxm
         2S2KchlyJGh9sf/KftGjh4MBYGE20QWUh+Ke+AqYZMipx5+PvGbpNAlWuEO2RxATkKLZ
         w5DUiOJTClo0Ug7sbG2GdQC1F2ZRPDgmmi9Fjtrni/cJTqtSIW8YXDBRO1cdytCaotLo
         Up5sehrer4IUUfIPZQmj06mLUB01EYvtDvdjYGulrgJh+XXbKrA1qt3e2khdwgD1VEgi
         P8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684965811; x=1687557811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZ5PDW7meFLPxJz6yk7BxpA6R+nIgkvFNvqiUV7WSgc=;
        b=XHIPlwNRgfqZN4a3xyeqGHX4TUJ9b/N0QRnkDdWsBspNI6SrB7T5319lml7Yj9RrVF
         SJAsdU5Nf5yKHwHUx9Buw5Z/YNNXRxn9F+EJ1YmATDAIx3+a91X1Oyh0IhDbiY0FkKI+
         igPcQPzneqbJWJbm/lrzTyOXVTsk2X0BLtmK454RQv7me1l5ayccnrPD1QTZtfseYwoo
         9rbjUHnCVf6f9c1Mffy+//bJyvQVkRlhJs0PTC1ZhQhqa0r1qBIAbrPHpkcvLKsBa7Nc
         tEmpCGo4xqLD2Nw5P0BCK1A2CelzJWD11ljECE1orjXXWRv+6WKpTo6h4nlXiIypPiWK
         0KHg==
X-Gm-Message-State: AC+VfDzZeipSxx6FpZHGTxQi9MiNUruFkwZBPILGa0RAboOMo3jLmcHT
        bpdPrfb9q393Wrz/pG1bTco=
X-Google-Smtp-Source: ACHHUZ6NAjayIhqnURTW454ydwuEShK8anCKtU3THGGPIXmBPlPIkL3oyYf8zNJ7j4GkKAkqxncbHQ==
X-Received: by 2002:a05:6a00:1248:b0:643:96bc:b292 with SMTP id u8-20020a056a00124800b0064396bcb292mr5226948pfi.5.1684965810460;
        Wed, 24 May 2023 15:03:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:be57])
        by smtp.gmail.com with ESMTPSA id y21-20020aa78555000000b00642c5ef6050sm8125987pfn.173.2023.05.24.15.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:03:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 24 May 2023 12:03:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Zqiang <qiang.zhang1211@gmail.com>, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org
Subject: Re: [PATCH v3] workqueue: Fix WARN_ON_ONCE() triggers in
 worker_enter_idle()
Message-ID: <ZG6JsJvWRWu8kZYC@slm.duckdns.org>
References: <20230524035339.25185-1-qiang.zhang1211@gmail.com>
 <CA+G9fYtXCMWObuaS64qb3FofiokK_nrq2tm8b8g2xDd8tyKTxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtXCMWObuaS64qb3FofiokK_nrq2tm8b8g2xDd8tyKTxw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 07:23:16PM +0530, Naresh Kamboju wrote:
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> 
> Since the probability of occurrence of this problem is only 3%,
> Anders took this up and applied this on top of Linux next and
> tested for 500 boot tests and all looked good.
> Thanks, Anders.

This was a tricky bug and I really appreciate the bug report and testing.
Thank you so much.

-- 
tejun
