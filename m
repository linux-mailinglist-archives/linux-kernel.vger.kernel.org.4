Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BECA70FDF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjEXSpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjEXSp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:45:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5CE113
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:45:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30a8fa6e6fcso868048f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684953925; x=1687545925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1hMnvoeUoCZnbHrNuVsla24G5BNFJJL9beLYNSsvRM=;
        b=YgAiJ9z9ibDogJfaasDo6C5OeW3zJXF894YwJYN3ALG5HUz6zUzvaxJb5XQKWKoAdz
         XW5DBF7Mxx7u+e9qXyuqDAWLduPmpxaMXX7xhkoYrzEOrRj6DiZM3mqdi97FTDF2tE9L
         +XA6ahZqyKE4bOgMaxBZEmSSsbO1aCQI5p7faY0OGD3fHtUtCAQhqGIMLKKC+noRda/1
         PeydBbpm2NBK/l+qZ9P2s8GlVUOM9TuhRqP8ZcRX2GQ1XrP9uFVNaj2EiU4w48JFQ0ia
         jcMWyEkbiLO+2AfZ1rdz7C1I8Lu3N8rDJnY+geEwVa75I0vT60nIqOGmhJZKjKaH4Xae
         t6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684953925; x=1687545925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1hMnvoeUoCZnbHrNuVsla24G5BNFJJL9beLYNSsvRM=;
        b=EzppoHs3XUvEVGTS0veyVxl1tpgVa5gVQd6OKH1hYN7VKm0QiRHayDLILtzNUZfIYr
         2xhTrI+X4DXI3jYwyiroRWOenYTusvi/bCmKIxm1A1KyChT4doG3aW5sAC6SDR05z7IL
         bTtLqrBOUexgqTvNI4s7Kopq3wvqpmi/qvpxLtRXPmqpYoWkkgecDuQWl/c/NsBJHYln
         i6o6OhVa+jrrOvl19gXiP6t/QQH00QwkrAvSWOS3eGFKsnGSvTiofoBGRW9pamEyq9pG
         o3ZU80ruqvm7oPO3BXJDDCkfC5ccrpmMIeRmZcu2xeHghLCTVSUxnAg8zcis+T4PNrhp
         CCzA==
X-Gm-Message-State: AC+VfDzluhskhuhWF7ojBtgwvbFfki+NL00heLzJ5dY3NGZXZmNETHRF
        LTBHHJfRFRVmwteyGY07xqZYQ7o194ytYxrl0Ic=
X-Google-Smtp-Source: ACHHUZ7I2oNSbrNDjbxamJS48zoaByuWTXyMzWRfwH3+tjta5nbySmVuOZM+ybhBHq45hEbKhdYWsQ==
X-Received: by 2002:adf:f108:0:b0:2dd:11b8:8aa9 with SMTP id r8-20020adff108000000b002dd11b88aa9mr554531wro.15.1684953924882;
        Wed, 24 May 2023 11:45:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c228a00b003f42461ac75sm3182088wmf.12.2023.05.24.11.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 11:45:22 -0700 (PDT)
Date:   Wed, 24 May 2023 21:45:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Wang Zhang <silver_code@hust.edu.cn>
Cc:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>,
        hust-os-kernel-patches@googlegroups.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] i2c: ocores: use devm_ managed clks
Message-ID: <4fef4e18-e924-41f5-863f-df488131708a@kili.mountain>
References: <5572a733.abc0.18846f13b0b.Coremail.m202171703@hust.edu.cn>
 <20230524154318.2259-1-silver_code@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524154318.2259-1-silver_code@hust.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 11:43:18PM +0800, Wang Zhang wrote:
> While it is not entirely clear why the original author implemented this
> behavior, there may have been certain circumstances or issues that were not
> apparent to us.

This is an easy to answer question.  :P  Those are fancy new functions
which weren't available at the time.

regards,
dan carpenter

