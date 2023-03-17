Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7086BE7E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCQLUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCQLUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:20:40 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721ABBE5CB;
        Fri, 17 Mar 2023 04:20:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id ix20so4959334plb.3;
        Fri, 17 Mar 2023 04:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679052010;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LUsFZcElnirxMxsGWtP7RpSM3YXWjq7ve24NpjNKOq4=;
        b=ciczQQTdLiTc+HUCmmexi03FzlaRtMQGL18B7mO7Hq8hZFnn/xcgnVIlZP1IcGIY0G
         yWUuxuH85wIKkiFfQYkCxR3UUpKJZvAC/CUK1tdNSQ3y0LVfArFj1w1yDhciKsFWKP5+
         gvgvGXUlm3sfuK0J3eLG1AD6f59ECtjWIy3ygCKErSpNbxcZQFtg5n16Mm+v7/83OvVi
         cvt1M0/Pfr+2Fe9mzDwXetgSZXCTmNqq3EPawocTbkYT3eZ6m6/xccPjitzWR9zaHRJW
         JUsAck+XGGz57+s6BgWJLJkUcfXUImEkUHbbJ0EJyKDINWt6f30XQgVM9Q0cSMQuvbOH
         n8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052010;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUsFZcElnirxMxsGWtP7RpSM3YXWjq7ve24NpjNKOq4=;
        b=rf9q8M3Gmt8FXkQAfdDC/ammt9mLUR/qz8Zf+1cfTuo18JGfruM+DHSwAeljkCAOA3
         LZyTWHAGPeR/NYrgF5JfaB0OLyg6wztEkHFSd6NfMo+PswUgm8PJl+JBANHApVA4Jd/U
         LpqSbNHlGZ1+9186dulcUeuvF+sgmZqZpOA3xu57btQUXNXoto9+563ISm9eey5ll88w
         vD++th0ydqKhnPb9bmVybRe3jWGPiKmK+8iEDbvJxCq+7mN+ZIZZeElPqMDqOiqjN9EC
         3PRcmhHe7ABzo3hFjFu+LxooEaxgfsS8IzKbjGuKGVp7LI/nRN3a77eZIYp8TQgmrXCP
         WVRw==
X-Gm-Message-State: AO0yUKX+am8nlNDsfFu1V9Wcc5KJfcQAMR/+v9M+iNems29Bh6ddr2n1
        gCqFRtEvHMrwHznofx4mpQI=
X-Google-Smtp-Source: AK7set+cnEYFS/OwqzUJQae17ZAKvPAAq2PqJq+ey3hbHNcnG3FI0vSYRDvIEbGSDE3UZCfx+Tnbvg==
X-Received: by 2002:a17:90b:4d86:b0:23d:5196:eca8 with SMTP id oj6-20020a17090b4d8600b0023d5196eca8mr7890564pjb.20.1679052010159;
        Fri, 17 Mar 2023 04:20:10 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d084:8252:e846:af61])
        by smtp.gmail.com with ESMTPSA id ca20-20020a17090af31400b00233d6547000sm1187175pjb.54.2023.03.17.04.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:20:09 -0700 (PDT)
Date:   Fri, 17 Mar 2023 04:20:06 -0700
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
Subject: Re: [PATCH 2/4] Input: tm2-touchkey: drop of_match_ptr for ID table
Message-ID: <ZBRM5oAoJc/3sUaw@google.com>
References: <20230312131514.351603-1-krzysztof.kozlowski@linaro.org>
 <20230312131514.351603-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230312131514.351603-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 02:15:12PM +0100, Krzysztof Kozlowski wrote:
> The driver will match mostly by DT table (even thought there is regular
> ID table) so there is little benefit in of_match_ptr (this also allows
> ACPI matching via PRP0001, even though it might not be relevant here).
> This also fixes !CONFIG_OF error:
> 
>   drivers/input/keyboard/tm2-touchkey.c:335:34: error: ‘tm2_touchkey_of_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thank you.

-- 
Dmitry
