Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9963AEAB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiK1RQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiK1RQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:16:26 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720F026ADA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:16:24 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id p141so8082402iod.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CreFJnpSk8f9KZRtNa7zxCTw5ecWwO03PmMJeB2tgb4=;
        b=Kszx2K/eTr4D3Pr5No5udVkTLAUpsE2m1XrbZGT/vHtToj2mi+5R7eeYsMH11o+nDu
         s1tR4n6VdMa2/Gv459+amB7yJlL/1qYZnDJjgBxo9DZLIkjH/qKtpPvbBh4Drlq/6ZdQ
         g2delAJRSC4vP8xrJi8khKoY0GroPOJNkrDk6r680HngkOcort6wpXYJQefu+9c9VLFV
         LDisqkwf9rZ/IZq4oh1Nak+H5E9pJM2zWboNAV2O1CqBEOaLD44byQ0yMRrIT+Xks/YK
         IYDGOcMSBJy8jrSL2yv4oYWwIsYrzMDMCZOZ0bjk3DCBvxHAsVjoqqzT69i56cnUjjVh
         A6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CreFJnpSk8f9KZRtNa7zxCTw5ecWwO03PmMJeB2tgb4=;
        b=JvGmG7ct9Vo3tkRMDuy0rZaad1lQJmYvtxhJcCVPn0HqXwCi7bW1VQnnizyvl0QWZc
         pFMosQNJ8muhu1lPPsKH+WOe3MgNVNfbbH0b7ZNJYgSvmdCwtSnmBLAfGoXIB1y5VhSy
         atEf1VYL1OjDl6U1WZaj6Lc4nZ3FGMvr/+8P0P44Rz9U8NBy+ibCY4vLFPTo5C7MPBt0
         H+LuN3x4gckCovT8ecWYpdT+MfpaVvW9HyE70TO2XTiSfFeRWb9MjTGIlAn1utC4yP75
         bb53k/k1Wwpl/K2PEmLV7WxO7hyI9Ksw3M3AinXYhNi3i6dyCERmk7Iam1SeTVQToVzF
         ij0w==
X-Gm-Message-State: ANoB5pk7Lqxu3krWJSP64dcCKVOY+bAicjE7J1g1s0vro62/u7HFgx1f
        nSp7tfuBzZQBWX++LRPcujQUYu9V7vkWRA==
X-Google-Smtp-Source: AA0mqf5gsAt2roIXwDDS3r56dxT9+PFeaIp5xrPjLwg3VxeZYdd4A16SaFZ/pBurXab38/HPTPBfbQ==
X-Received: by 2002:a02:ca45:0:b0:363:a4ae:5a80 with SMTP id i5-20020a02ca45000000b00363a4ae5a80mr25212634jal.105.1669655783587;
        Mon, 28 Nov 2022 09:16:23 -0800 (PST)
Received: from google.com (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with ESMTPSA id p40-20020a056638192800b003738c0a80b4sm4532082jal.144.2022.11.28.09.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:16:23 -0800 (PST)
Date:   Mon, 28 Nov 2022 17:16:20 +0000
From:   Matthias Kaehlcke <mka@google.com>
To:     Owen Yang <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Abner Yen <abner.yen@ecs.corp-partner.google.com>,
        Gavin Lee <gavin.lee@ecs.corp-partner.google.com>,
        Harvey <hunge@google.com>, Stephen Boyd <swboyd@chromium.org>,
        Bob Moragues <moragues@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: qcom: Add zombie
Message-ID: <Y4Ts5KPJMb6Rh8DP@google.com>
References: <20221125174415.v5.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221125174415.v5.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 05:44:24PM +0800, Owen Yang wrote:
> Add an entry in the device tree binding for sc7280-zombie.
> 
> Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
> ---
> 
> (no changes since v1)

That is not correct. As far as I recall there were at least changes in the
position at which the new entries are inserted and some changes in the commit
message too.

It's not super important for a trivial patch like this, but please make it
a habit to post an accurate change log for each version.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
