Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D230E734E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjFSIuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjFSIty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:49:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11639172B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:48:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30fcda210cfso2882016f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687164522; x=1689756522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rGTEAJDFiZ4dQ8L7EwttIx6gajukmPL0eVmPz17NAsQ=;
        b=j7+7i9s/PdRvCYKPgAkFd0Sei40Oxz9g3kgWojJl4eUHbUuYJz3+TcsRi+mgqqkvpK
         onO4rPWddMXSOXYpjxoYaT+V4AJP4U/GiNCxjfXiQ3OnUAG/uYoFNXdaLeJPPRHlcAY6
         t72qH8qR6xbxu5MnjJpePPptw86Rxw6D9KbIK4wIha8XQFbKqjPRAMg/iEFJDun8leNr
         2/RLhfETqUmozvIL6HYpIMtx1H1lBVNgalvm/rI4LQdPyiHV6Xbpgc5i9mSWxlfBEE2x
         LpFDKf42nWb6nr1W/ir2fUdkrhxAfObXB2F/1H7KI/Ga2Sd9jPIV/Wdqx/pLBYnyKxHg
         MdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687164522; x=1689756522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGTEAJDFiZ4dQ8L7EwttIx6gajukmPL0eVmPz17NAsQ=;
        b=gjiAw/P3hBo4GE7XtOhvOk8JnB/rkmC2HOG6ygtJymaqUe3Id9ERTgZMKUleuR43mS
         09yoCOUKEvnL5cGPbb4uJqLJ0Fglw/EAnfVSVgbwP8m1ffDr/vnuEY1qKbREuI1kaf2C
         noTjE3AUWkSX5aMaUcF36dT+KjPpZuPABzH78TNeMovSo+S69pjhcNZ87iSMvL9rgDcA
         U980oRv2BJBRmJSFutw9eA+4lt5n8fO12DdUitCc39v70TbyXmeE3FSlElLFGPHUUGiH
         0DKTMF+3SC1ogZ1Xj9uIdWjwJrVlA/1rcI7wjFGzQSlUSjcGOLImjQ8ou/gazAamYnc2
         q3UA==
X-Gm-Message-State: AC+VfDzXQu+rZ5C0rsWEMyY/B+tok098kN7i7UATdDzVrs7bGkmZOYu/
        fm8AU/DT40FzbaUhvxlVxpvnZQ==
X-Google-Smtp-Source: ACHHUZ7cUpvHpXNrD9bnFgMGdhq4SzVWigiC9NX8/PCD8Z+Q6jkCriK2VH8fxKKsQYNODM9VD9CCFQ==
X-Received: by 2002:a5d:6a4b:0:b0:311:1b27:74a6 with SMTP id t11-20020a5d6a4b000000b003111b2774a6mr6370222wrw.28.1687164522248;
        Mon, 19 Jun 2023 01:48:42 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b0030fa3567541sm27705657wro.48.2023.06.19.01.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:48:40 -0700 (PDT)
Date:   Mon, 19 Jun 2023 11:48:36 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Fei Shao <fshao@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: Fix memory leak in devm_clk_notifier_register()
Message-ID: <35f6212e-69f8-432f-a5c8-99ed5c844f11@moroto.mountain>
References: <20230619112253.v2.1.I13f060c10549ef181603e921291bdea95f83033c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619112253.v2.1.I13f060c10549ef181603e921291bdea95f83033c@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 11:22:53AM +0800, Fei Shao wrote:
> devm_clk_notifier_register() allocates a devres resource for clk
> notifier but didn't register that to the device, so the notifier didn't
> get unregistered on device detach and the allocated resource was leaked.
> 
> Fix the issue by registering the resource through devres_add().
> 
> Fixes: 6d30d50d037d ("clk: add devm variant of clk_notifier_register")
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

How did you find this bug?

I can think of some ways to find this bug with static analysis.

KTODO: static analysis:  look at unused parameters

Both GCC and Clang have a warning for unused parameters.  I think the
last time I looked at GCC it had a lot of false positives for functions
which were called as pointers but hopefully that has been fixed now?
Smatch does not have a check for this.  If someone were to write it,
I would probably the check under the --pedantic flag so it would be
turned off by default.

regards,
dan carpenter

