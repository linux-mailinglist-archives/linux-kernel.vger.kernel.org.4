Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D61E70FB72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjEXQKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjEXQKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:10:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D99E4D
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:10:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f608074b50so13141045e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684944618; x=1687536618;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68APWrLI/lODKmNHwIM0ukcJpP1wefTEFp5Sr6qhG9I=;
        b=j2kolavyACh6gqcIimKmP/K323GslHL3Lyhf27xsdVH5SvQyk6YU5cyIUgIa7CWdfM
         IlQ03hhq0lnlMnPG/3ePrr01OcmHUx1+OugHMAf4QlTlh7UbylwGNhmBzZQNBJXMmsnW
         ybyc0ViCZdVLv0NZtJCg2d4WnpsW5zwDAiueQ6pN8q92EMPegJQJYQXU9tc0REspucvy
         LOJC398nCw4dAkszxjwPnhrdajF12s4RD+k+LDS+3fekoJDAWB1bUIc515Sn32yTik13
         zpWHi9kTAgEk02cpRrrv/gbY+tV9ofqtJlQjsG2UfFcSrdKy6tAySVVDGuqPoi5W9rTy
         xMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944618; x=1687536618;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68APWrLI/lODKmNHwIM0ukcJpP1wefTEFp5Sr6qhG9I=;
        b=djFIs66Mdh5NHTURfxSjQshDDCPTK1QAuA1qYtwdYwI0t4F25tPtlG5rGHvAfRP5wG
         YNnaPqN/EVyZHvFcTHk/HBBQprqOT5WMYUCLz6JTUBV+GFi0aBGrCs3J/5H8eDywPcQU
         k/EeyySbUDoYtIpeYc08fF4E5lQ+gP0PHmYYyF+8zJF8Ge0qbDsK4GvaSELAqJsco4L3
         9+xjqB+5/0gOWgDgS8mDdn1ZKMTP1Es3M525K1OT8lI2Kj6W0LnSHVR7OwenRQBpPNvj
         WBLoFYS3DXTdBOAxSiohlUPtvj106Jthu+CKXhuuXcQ7ZXLE+bVl86f+LN4cqVkoL6pC
         tHmw==
X-Gm-Message-State: AC+VfDzXSJ3bSPiWZ9biBIPZ8Bv6nEWfr/lb6RCVZ4qtEty2/vX22vET
        YP28u6AiBcIsQ1xxs5DddNoeUw==
X-Google-Smtp-Source: ACHHUZ7Hc7E2ydGg0YS+yWHxWltrgPKxcLAgicQOx2yuY8MZwOAy2cFJzu+reC17VIzNrkvp2fr0Hg==
X-Received: by 2002:a05:600c:224a:b0:3f6:53a:6665 with SMTP id a10-20020a05600c224a00b003f6053a6665mr239012wmm.19.1684944618231;
        Wed, 24 May 2023 09:10:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c214700b003f4f89bc48dsm2865399wml.15.2023.05.24.09.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:10:17 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Lijo Lazar <lijo.lazar@amd.com>, linux-arm-msm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Marek_Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Sean Paul <sean@poorly.run>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>
In-Reply-To: <20230524155956.382440-1-robdclark@gmail.com>
References: <20230524155956.382440-1-robdclark@gmail.com>
Subject: Re: [PATCH v5 0/7] drm: fdinfo memory stats
Message-Id: <168494461705.3403386.1668654169323555925.b4-ty@linaro.org>
Date:   Wed, 24 May 2023 18:10:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 24 May 2023 08:59:30 -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Similar motivation to other similar recent attempt[1].  But with an
> attempt to have some shared code for this.  As well as documentation.
> 
> It is probably a bit UMA-centric, I guess devices with VRAM might want
> some placement stats as well.  But this seems like a reasonable start.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/7] drm/docs: Fix usage stats typos
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0020582a8afe9a8570f80ec503c59bf049a616de
[2/7] drm: Add common fdinfo helper
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3f09a0cd4ea3b9d34495450d686227d48e7ec648
[3/7] drm/msm: Switch to fdinfo helper
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=51d86ee5e07ccef85af04ee9850b0baa107999b6
[4/7] drm/amdgpu: Switch to fdinfo helper
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=376c25f8ca47084c4f0aff0f14684780756ccef4
[5/7] drm: Add fdinfo memory stats
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=686b21b5f6ca2f8a716f9a4ade07246dbfb2713e
[6/7] drm/msm: Add memory stats to fdinfo
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3e9757f5ddb98238226ad68a1609aa313de35adb
[7/7] drm/doc: Relax fdinfo string constraints
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=90d63a150b85fd1debb9c01237fb78faee02746a

-- 
Neil

