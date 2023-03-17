Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8FB6BE7E3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCQLUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCQLUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:20:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBF77606F;
        Fri, 17 Mar 2023 04:19:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso4841024pjb.3;
        Fri, 17 Mar 2023 04:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679051997;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0QpTAcEGna+yl0Brgjs6Bn1Df3Qs/JcBmXdFEtNXC5g=;
        b=YZg9RHZNhV9AbpV23NNl/0lXMU+MUi9FN4QqL+Hb4nrSE0HrJLNi2MTjtmBkjepaB8
         v4pBAwLPxRthKYBdqWp9Tnzd78Vzct8z7dLJK/5X1tsAtYUNAskzND0Pyg9IcV24AJ9G
         3R0Z6QZso3IjfPyJC03m7PiTKDPGS0znxpOsKsUfJaZpv9JqnKPsBPxkXs3RroV4FN1S
         5EZcSw7XsrVSdJ5alGdVwwaSsRUFOvPR79O1Yz1LEeHVPPVsmeNb1rsfuYS9fAO5l++j
         ACokctnNgoW3iLl140V4Av989j42K3OPilWswUJhH/zyMzwqzhiaBvc2tEHkN4Fk6d55
         rY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679051997;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QpTAcEGna+yl0Brgjs6Bn1Df3Qs/JcBmXdFEtNXC5g=;
        b=Mz/st4ohhNugutmseO/ZsJo4pMkvqUeslAS447MDy1qDAsB+vtUFpuLAqoz5wn+fsK
         ZLVv4bQSR72rbxqIJGFlgPDBRdaujk/3xJZ7aIJ7BGVOVZmBDLtKvKGV+FuxBwlE3HIj
         SnUu29b21T2W9FF5bbpyQ+SXft4KDmmxYe5HdUNp/QTr5QOro7nJJlOAGIRoNG5yu4vS
         TNCUxMyDLO3BeSeudlozuzi+VDT7eOnIIGdXtYuXvAguGx0pkgtvOChO/5Q/7axtLtu4
         UymHYPpxOg0tbMqOCHF2X6U5ShIWjCe1PcjG3mxulEVj4cG6kJOnD2ezLfgQNT1yUAsD
         EESw==
X-Gm-Message-State: AO0yUKVPHc4kUoMwcStKYhUWKJmZikNwSbJhEvTQoeLSc8/b8Mltqunz
        FjVUgi8pJfO3kA3UxaGnSy4DD0SE3AaR1g==
X-Google-Smtp-Source: AK7set8LcvpwH/OcfmOgBd9z/URO4reQNgW2quausnEUb7s/x7XYAMDRnIMNlLgalnJzoLZoQJxJsA==
X-Received: by 2002:a17:902:dacf:b0:19d:62b:f040 with SMTP id q15-20020a170902dacf00b0019d062bf040mr8295103plx.37.1679051997006;
        Fri, 17 Mar 2023 04:19:57 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d084:8252:e846:af61])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b0019cad2de86bsm1329122pli.156.2023.03.17.04.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:19:56 -0700 (PDT)
Date:   Fri, 17 Mar 2023 04:19:52 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/4] Input: st-keyscan: drop of_match_ptr for ID table
Message-ID: <ZBRM2GPgh9u5PJaS@google.com>
References: <20230312131514.351603-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230312131514.351603-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 02:15:11PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:
> 
>   drivers/input/keyboard/st-keyscan.c:251:34: error: ‘keyscan_of_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thank you.

-- 
Dmitry
