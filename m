Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707F6624EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiKKAbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiKKAbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:31:21 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3001B5F855
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:31:21 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id k5so3110590pjo.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BeArgbWRKJ56DeeZbQq60SOy0XSAuNerlwx2a6cRecA=;
        b=NIpdKfiDFZYAimTkKhDGW+TBqzF42/7ZtyCEkSzeNjsv5N2w69HDQx3TqvyGiJsN8S
         +/3d48s0G2LOjW/JTgezM60/h/RQdAWRjEPaThN6u5Y4aX0ReMPRIftQ6NWUQ5gAqAMf
         lLQ5C4DUhSBpSd9BchVBd4mZc3diTTbq8+36Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeArgbWRKJ56DeeZbQq60SOy0XSAuNerlwx2a6cRecA=;
        b=CZDmIjClnqm8lwUjeE283MVDXpjSz1x3G1tgnB1VJC5KjCbniHvpq/fUNUnifOr4Ja
         JuPtYwYryH0k79+hoNhf3gpB0cLhyUSoS63nvZo7jSsRWaXSPHOkoj8YqAy2Pyf6mcKO
         HwqBEG+fzJigxPNbwTKdUzh2wd/1/hp0ARUQfVAEyHqEJbBuib9zrqFOaOo3hHPLzWXa
         qWMRSEf3l3+sNQoE9XNislleF9OpbRi8ubAP0J2D8W/14GSE4k0UlxdTWGr4Ux97zDS6
         NXFjIdl/a36Ji4xwktZ7xm4F7lwvA5r8dM1sjRmJ/0bn2Xe49Cjnynomuciixtgyaf1O
         LJhA==
X-Gm-Message-State: ACrzQf0+KJey7BN2Q/Sl0MLYJL8PzJSvWoDTSPpGZcw9YcQ2mctBdJik
        X4NyT+HLODzmbzBbUF/aXmnvgQ==
X-Google-Smtp-Source: AMsMyM7PpSiwTrDvgomdUQ7mPXloqRN80xZFlIZJzRv22u0wsqZrE0mTs2EHLEjmgOAg4/kZB5K9pw==
X-Received: by 2002:a17:90a:cb95:b0:215:f80c:18e6 with SMTP id a21-20020a17090acb9500b00215f80c18e6mr2596437pju.45.1668126680779;
        Thu, 10 Nov 2022 16:31:20 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d55:c60d:579d:741c])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902d58b00b001868d4600b8sm277150plh.158.2022.11.10.16.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 16:31:20 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:31:14 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Wolfram Sang <wsa@kernel.org>, Tomasz Figa <tfiga@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hidenori Kobayashi <hidenorik@google.com>,
        stable@vger.kernel.org, linux-i2c@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] i2c: Restore initial power state when we are done.
Message-ID: <Y22X0iDsF2Y5cy95@google.com>
References: <20221109-i2c-waive-v5-0-2839667f8f6a@chromium.org>
 <20221109-i2c-waive-v5-1-2839667f8f6a@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109-i2c-waive-v5-1-2839667f8f6a@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/10 17:20), Ricardo Ribalda wrote:
> A driver that supports I2C_DRV_ACPI_WAIVE_D0_PROBE is not expected to
> power off a device that it has not powered on previously.
> 
> For devices operating in "full_power" mode, the first call to
> `i2c_acpi_waive_d0_probe` will return 0, which means that the device
> will be turned on with `dev_pm_domain_attach`.
> 
> If probe fails or the device is removed the second call to
> `i2c_acpi_waive_d0_probe` will return 1, which means that the device
> will not be turned off. This is, it will be left in a different power
> state. Lets fix it.
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: stable@vger.kernel.org
> Fixes: b18c1ad685d9 ("i2c: Allow an ACPI driver to manage the device's power state during probe")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
