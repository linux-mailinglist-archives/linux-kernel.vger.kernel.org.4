Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A0C6EE7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbjDYS7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbjDYS7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:59:30 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FFFCC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:59:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a686260adcso66133605ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682449169; x=1685041169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mIzFM7fMr8+jO5+B9CBJwYQH3vH9wMHrtgZK9/UkDvw=;
        b=kVHStCnBcskCRFxJY9masCCD2ayUCGleBryGjSCHfYJulnoYo0QRUp82qE9mxFhFue
         BDHL8Cqwerbf55aySmm2IsQP8HQj/oo8f25mHbR09Yq6Zb+QKm3RPryMab3fhucViJS4
         2Omu5EXPaI61nirjvGSy3p3avIzoVIuCLnVo+Wgsb38Rm+IbpzBhwbYOnj/8u4NtiluP
         Fx5pIT9nx9gG3zY7JVLYKfarUua9yFRmtD/MM35FR9rKcVazKTt5N/m2QxL+WlJ30Fhx
         fVbBN+9PnnpJ04b6Mnr2GSTYkunoxeSVTicEzCjGovVYL+Cy9jWUkQ079j1t40tE9Q4T
         7Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682449169; x=1685041169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIzFM7fMr8+jO5+B9CBJwYQH3vH9wMHrtgZK9/UkDvw=;
        b=h3F92SDohjbpdLyP1C0Rl+CNZaibVM8ACi1oqk1rNNJpwp203uD87pwCznac6KoZM6
         Ce0cxFChmfO4SpKyF930+jGwNqeUOyOVdvgjP23Jg8Ry+GN9LIQWyJiddb6qvVm5+VGZ
         1Ex5MIcS8ZaR3qVhJJX1+M3ShnrdzVCFBEJpaO1ewQoY6g51/ktVNN326xgjOM3q4Y2m
         ilmzu2iqrll7TeOypay/n4GY9w3NILVVmftyrFYLKVBSkG1XZ9MuZwOutdzZ0g4iVFiP
         XB+5/6uIdrz3/nS6ulCK4JLM/cYDVRUNhlhUajCJKK6nN+zBkMAXHlsFeFKkWLdrwJLW
         gZ0w==
X-Gm-Message-State: AAQBX9dYwzdv0ViMX8CeG4jDSNe6RM7Jn35jGgeCQksKrYZtYB8veNfJ
        ebnkPSc+hi3QwAHfpH7W0n5nyw==
X-Google-Smtp-Source: AKy350Yp8ecYf4ZdqfAdlkJ1ToX3HHhIMzVARbG0mLO6vDnifGVSvtr4Qg+vFOxUUCYMWR6bIgWgHA==
X-Received: by 2002:a17:902:e403:b0:1a6:91f0:f7fd with SMTP id m3-20020a170902e40300b001a691f0f7fdmr14797237ple.60.1682449169230;
        Tue, 25 Apr 2023 11:59:29 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id jf2-20020a170903268200b001a207906418sm8626042plb.23.2023.04.25.11.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:59:28 -0700 (PDT)
Date:   Tue, 25 Apr 2023 18:59:25 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Chuang Zhang <zhangchuang3@xiaomi.corp-partner.google.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Chuang Zhang <zhangchuang3@xiaomi.com>
Subject: Re: [PATCH v2 1/2] Binder: Add timestamp to transaction record
Message-ID: <ZEgjDfUHQ0/rPhhP@google.com>
References: <cover.1682333709.git.zhangchuang3@xiaomi.com>
 <5ac8c0d09392290be789423f0dd78a520b830fab.1682333709.git.zhangchuang3@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ac8c0d09392290be789423f0dd78a520b830fab.1682333709.git.zhangchuang3@xiaomi.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 07:05:14PM +0800, Chuang Zhang wrote:
> From: Chuang Zhang <zhangchuang3@xiaomi.com>
> 
> This patch adds a timestamp field to the binder_transaction
> structure to track the time consumed during transmission
> when reading binder_transaction records.
> 
> Signed-off-by: Chuang Zhang <zhangchuang3@xiaomi.com>

Acked-by: Carlos Llamas <cmllamas@google.com>

Thanks
