Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F75D719F53
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjFAONC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjFAOM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:12:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C781A6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:12:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6077660c6so8757755e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685628767; x=1688220767;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+pyc2M4W79NW5jM6Yi5A6BoToDoHhe5rEuQkc7puW0=;
        b=c1n7cc7EuMobfAjw7tRsFwjRb8piUJFPmjeWQhM1LDJKUa0m/4xRMlHthNmgWuGOL/
         BsPyrOgbjtiSEWm2H4w1A6eRbRkBOABKsg7mXyi027yjeGvVWeZPcjjYGM2uIXcKPCIT
         Zn1ETyaSzcCfj4fpHu1JMtPFY2c7QGVn6FxpeRkSnLatppHdW9nDdQTCoNKdblCvtSCa
         z3Uppw2pzefwTE2otKgJTBZAtb1wijvT9USWSnM0jFTswBsh/9627dqiYY3euYxUOpU1
         i5WW3oRFiEOmt7h8bA+UnN1PnUr2xccj/1YdyLaK+0yfQVQytDLayzvqOSJlUTaZ01NR
         wj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628767; x=1688220767;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+pyc2M4W79NW5jM6Yi5A6BoToDoHhe5rEuQkc7puW0=;
        b=D+z3d96J8ZaQuecQaZ1mKArZAqLliFy0jyNcUDczaprqMHThmMA7uEj98sjB9CqlIB
         Iw8PuGcTFCYx82tmSKHxbtl93cXbT+qFRcS9Nqx+fC5nxFRkPjdadrlNRkr2EFOO3Z4u
         07To8mGPGJLfEt2yGThbCezmFZtOvwle5nithtentvepx0mTyXsgc3D387f5Gbugu/f0
         nDBkDuLZYNslMT41R4ayVH7RGdlUpoUQQyuwPmv8kT45NX5g8P+XToZ5osXqkBo/MY6U
         EBADMjIe+ZJuE8DvEl4gB34VYqIfdC69u4gEPd19fOn3jKLV2SZo3Wbr6uOPQlVIr13h
         IU/Q==
X-Gm-Message-State: AC+VfDyDS+SU78QTcfUw0QDrv2KQvpmGehJtWfiGmHfA1AJQoeRueq9I
        hTtDZJ5EKzoAZEcJujkFgQMWPfmR2w57GEnnobhMvQ==
X-Google-Smtp-Source: ACHHUZ7vQwVk+BxbzRERdlM6SSelmA5Q5GxOlJfvRMKf50IBfm8RuNZ/vGRElLDOFoO4qVYxzS9pfw==
X-Received: by 2002:adf:cc91:0:b0:306:3284:824f with SMTP id p17-20020adfcc91000000b003063284824fmr2364472wrj.8.1685628766781;
        Thu, 01 Jun 2023 07:12:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p12-20020adfcc8c000000b0030adfa48e1esm10629591wrj.29.2023.06.01.07.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:12:46 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221025-ts050-timings-v1-1-5c824bbb24d9@linaro.org>
References: <20221025-ts050-timings-v1-1-5c824bbb24d9@linaro.org>
Subject: Re: [PATCH] drm/panel: khadas-ts050: update timings to achieve
 60Hz refresh rate
Message-Id: <168562876603.86739.9442516356348966398.b4-ty@linaro.org>
Date:   Thu, 01 Jun 2023 16:12:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Jan 2023 10:39:42 +0100, Neil Armstrong wrote:
> This updates the panel timings to achieve a clean 60Hz refresh rate.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: khadas-ts050: update timings to achieve 60Hz refresh rate
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=29c6df0d942454cb43334cf0e36de068f4124b94

-- 
Neil

