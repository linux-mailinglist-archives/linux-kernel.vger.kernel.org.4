Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43FD734B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 07:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjFSF2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 01:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjFSF16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 01:27:58 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD0A139
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 22:27:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f8c65020dfso32812535e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 22:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687152476; x=1689744476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DbTMYrjZb0dUIT8WKz7rOIE4M95QEF04XbaC5iuYB9o=;
        b=DqE+aU0XxNh8r/PMdQMSrwkW/+mv5DmZNhNfwN2KQLU199Pd+KdYN658p1mLW/FdDD
         6B0lOv9HxzJ1X8G3eVm8ZSP9w5d9RyaFa5AJbqwarDcze2A0/2gFDeSYVt3YVUOstqjt
         5e8FODVqUDaUHdvsdSeEFwrgdKQrbFvICM23J3xSsc2JUW32vZXprURFOYQ4xqPbmWKl
         ePTdvjYu8JkFQW/0TebQjlLUJs3uFp1tlVtss9G6kUO1gUlfUCD0BPvSb1TPaelV+8iq
         u8xqi1CxoMxzhyB8p6zvggrGFamWulLQtIWSXNhdwXHa9YYVvdIaMVLGQQ8OzEur9TWL
         +JPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687152476; x=1689744476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbTMYrjZb0dUIT8WKz7rOIE4M95QEF04XbaC5iuYB9o=;
        b=lE1iR0IDApDBF1+r/bhyHvuUm4TrounHUz7xFHG+alK3RcG7L/jYEX6OdsRpI6afTO
         kLhjJJgRDfQQzUNNsGt7ghvX8a7u2QhqUV32uBfpH/vMJKGNHr0DonPl77RxO6aBj/GX
         CtJiLDarr5uusTryzkfYTyPM2Cx9YBf81OacQArrgflOeFrgSg6C/LHIWqdzIxyznrNS
         E90kJO+w3PnNlXFCkcZMruGRCjoPqHt2zEHtrjZzFL6yKfRLeh48A8IlNS5yZKQSfVbl
         btNt/lPy8ZvaIL3GS0NSBfy+2I8BIvjBiYPkhpziG1weYaQTD17Pqn5fYxMLIRHXE69K
         mftw==
X-Gm-Message-State: AC+VfDyCRULuCkszwq2issUlmmdOL0t/8CcsKPUmlV59P7MdMrMKIsLT
        DOf76/z5Vv4IDWie+UGqIcHQYg==
X-Google-Smtp-Source: ACHHUZ4jzPV2CdWRH+iAPoCYciUOA55iJGjFI7ikgf+cK1Z++PK8oGYRkJauvLgXTJcIgQMwBx6iSg==
X-Received: by 2002:a7b:cb8b:0:b0:3f8:f5d:52ee with SMTP id m11-20020a7bcb8b000000b003f80f5d52eemr6783915wmi.23.1687152476082;
        Sun, 18 Jun 2023 22:27:56 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n20-20020a1c7214000000b003f8d85b481esm9451224wmc.21.2023.06.18.22.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 22:27:54 -0700 (PDT)
Date:   Mon, 19 Jun 2023 08:27:51 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Fei Shao <fshao@chromium.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH] clk: Fix memory leak in devm_clk_notifier_register()
Message-ID: <8366a35f-bc2c-4aee-b2bb-5fc9b2a7072b@kadam.mountain>
References: <20230617160901.1.I2b151cdf7a72d9e3ecc7ab2ff38409ebe6d65d6b@changeid>
 <71168ceb-8273-4067-d0e0-c6c219d4618e@web.de>
 <CAC=S1ngN=TFQa0Y4FoSCOTUs8HRi4NEP1OwY8WccUEUMG_UDeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC=S1ngN=TFQa0Y4FoSCOTUs8HRi4NEP1OwY8WccUEUMG_UDeQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 11:56:56AM +0800, Fei Shao wrote:
> On Sun, Jun 18, 2023 at 4:06 AM Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > > This fixes the issue.
> >
> > Please replace this sentence by an imperative change suggestion.
> >
> > See also:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.4-rc6#n94
> >
> > Regards,
> > Markus
> 
> Thanks for the feedback. I just sent v2.

Markus is banned from vger lists...  He doesn't have a very accurate
perspective of what is important and what is not important.

regards,
dan carpenter

