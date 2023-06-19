Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BCB735057
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjFSJdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjFSJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:32:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89C2294C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:31:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30fcda210cfso2923200f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687167062; x=1689759062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RalpslVZc2FQG+5YgH7hd3vxpCutTY0S3rDmPYgx9FI=;
        b=mPFnvw0vkeKji1lWrj49QPjRhlGnUVdB1CU1Tk51aw4iLfaJU3SWF+uta7TgKrfyvN
         7sQtnaO8fybIMTeePz6bVleuUDkDObOTz3RxdbmvDswH1Uz+KXrmzapsH4nN3GDI3Lu1
         7J5ydxUtAgnrsIO4IY+pxiKJ6I52KbY1pJ/dzJMQdT7x5y9uO0QHcFg/UvB/IZLSbagv
         Sq//qz/BOTTk9ImpsMOvdtTChffB+bpXKawY7shiVSehIqHD4Fzp2+VVQtnXF94ebCIT
         ikFn5gZy4+Wn2fIZZOoHAfZR1oGKKQ0OzAidtNoRZ0Om2Ypd2k/s8aildk2gSLqRJbJF
         3y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687167062; x=1689759062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RalpslVZc2FQG+5YgH7hd3vxpCutTY0S3rDmPYgx9FI=;
        b=M7nSTnJoTCL32Km+g8/u4dHqhx398WXRK9VZ6gko2hVcbPtAU/JCWV+AF0UF8N8I65
         rCZdD792/Bn4QBZpXaDYdH787a0sUkCaS32FdWtRTf3qdoJ3behZEo1OgPNyRbZZPFgh
         pta1A29SmeogevliCgugtEPDFYyadm62Sh1/fYBGUvWRT+zWXbI7Xt6iVzxtXR4VeS8E
         sQhVKxCc7suKKY4C2AuigwUCwf8f2jDAZqkMllEcWpZQFQh5Z2pvQjGa6ghXV+FVSyEv
         oFe46GXdCj0/LJPTPL4uU7lkco0byAiNwLCUF8M5Hxw5hVCM6LLGGmNeqjkENP59N9h4
         VaZg==
X-Gm-Message-State: AC+VfDymyprDVTjH/pIPFiQ3YFf25JRbfVAwJBYXsG2bv6nXymysJD0h
        2j73wMBk+HvqUcDLQ3HYnuNEZA==
X-Google-Smtp-Source: ACHHUZ76gOgtGmTO6zfU1oiguTxmRVnFRw94zFTBW3Yv6TmypahinGuI+i9HEHzl5qKzwAOIT28rhQ==
X-Received: by 2002:adf:ef50:0:b0:30e:45a5:9476 with SMTP id c16-20020adfef50000000b0030e45a59476mr7095098wrp.1.1687167061962;
        Mon, 19 Jun 2023 02:31:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d50cb000000b0030fb828511csm24309331wrt.100.2023.06.19.02.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:31:00 -0700 (PDT)
Date:   Mon, 19 Jun 2023 12:30:57 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Fei Shao <fshao@chromium.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: clk: Fix memory leak in devm_clk_notifier_register()
Message-ID: <8352fe9a-f76d-4ddb-aec4-d2c443f2fb2a@kadam.mountain>
References: <20230617160901.1.I2b151cdf7a72d9e3ecc7ab2ff38409ebe6d65d6b@changeid>
 <71168ceb-8273-4067-d0e0-c6c219d4618e@web.de>
 <CAC=S1ngN=TFQa0Y4FoSCOTUs8HRi4NEP1OwY8WccUEUMG_UDeQ@mail.gmail.com>
 <8366a35f-bc2c-4aee-b2bb-5fc9b2a7072b@kadam.mountain>
 <ea5c0b0b-7aa5-d4eb-def9-fa279d69cd44@web.de>
 <56998d04-7f09-4982-b0f1-20ef917aa524@kadam.mountain>
 <6e1071ec-f19a-454c-215a-b5193984bc6b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e1071ec-f19a-454c-215a-b5193984bc6b@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Markus you always answer every email with more questions instead of
just listening to what I am saying.  This is why you were banned.

Even though you are banned, I encourage people to merge your patches
if they fix bugs.  And if your review comments are about bugs then they
are welcome.  If they are about coding style or grammar then they are
distracting.

I know that you are going to ask more questions but I am not going to
respond further.

regards,
dan carpenter

