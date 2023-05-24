Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5244370FB71
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjEXQKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbjEXQKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:10:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6641BB
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:10:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f60804faf4so9578435e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684944617; x=1687536617;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sonO3GOYzGccW/51txZZdB4M9CGgorlp/b5UFoGyaco=;
        b=huJrIL8GrNYmxaL+91OktyHSNGC4Uj9H6LgChlHFde8wRuazQA2qKQx6gCLm5EeUL2
         ChyzSS3yZGt2x8Op/sPCRDNJ0ZBVe22BFbk5n7wqOh3LXQN3gNw2KahY5+Y4d7fAPypg
         guLngSIAs+OA9FpyZelrGBAx01iPnej6Pxh7AaBFHLpBkcLKz4zj5MECgG68A+pkFuSl
         W2tTk2kgJLFACbkK6DcSAREyG9sqVzJko7HCcFQROj/IKjqcPi5ksUUb75URizrZUeDH
         1pJkY+oznh25umOaeF2AuwhXQ6sJXhvqLrjKjkeTnLqslRGHojbcxLvb+wlSlazue9a9
         NfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684944617; x=1687536617;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sonO3GOYzGccW/51txZZdB4M9CGgorlp/b5UFoGyaco=;
        b=WpE+OKgJbCGw5sLwhRd1EezMwqgp9J1bVLYFIqgiBQUXWFWNjh1c/xUWd02fmoK8hT
         GrqP96Z/cnhfIUm3jGtIrbMhfOAIJs+HOG5M2LuU/hxpbLKU+te7qm6u5J4Nh1lj+gJa
         gIBqDN/hGmKaXYPu+WM5WOLNg2HUInquGFd1ayjgByp0me5yiE0KDYle8ftHW2S0kFcl
         tsN4+IdOCeQOWbuyq5/9BAX+UWu+xOsT4mX8+peJIu0XyvoglyzXA9XSQrpFJSSC1LjE
         kT1vI0d2OwWpbGn0K15OSeaq9rq/kPchFsjr/+XhVziJVxfqfkoFlKD9Zn9XmbEdWps4
         IzPw==
X-Gm-Message-State: AC+VfDwtqXgep0skLyftrqKQpiDgsAa+hlUlmjUBFjTu1E+9pEKVVcKj
        0PLwORl5ICjBHF/nsrX5WuTDyA==
X-Google-Smtp-Source: ACHHUZ6TpR8oaLW3NZ/tDgs34qpc3OAVHAqUENH6gjAtwJ10LJtGbVpmkQsfflTucQ7R54D29ZedZQ==
X-Received: by 2002:a7b:ce87:0:b0:3f4:2327:53c2 with SMTP id q7-20020a7bce87000000b003f4232753c2mr248128wmj.19.1684944616955;
        Wed, 24 May 2023 09:10:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c214700b003f4f89bc48dsm2865399wml.15.2023.05.24.09.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:10:16 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lijo Lazar <lijo.lazar@amd.com>, linux-arm-msm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Peter Maucher <bellosilicio@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>
In-Reply-To: <20230515143023.801167-1-robdclark@gmail.com>
References: <20230515143023.801167-1-robdclark@gmail.com>
Subject: Re: (subset) [PATCH v4 0/9] drm: fdinfo memory stats
Message-Id: <168494461551.3403386.4095735722928777312.b4-ty@linaro.org>
Date:   Wed, 24 May 2023 18:10:15 +0200
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

On Mon, 15 May 2023 07:30:07 -0700, Rob Clark wrote:
> Similar motivation to other similar recent attempt[1].  But with an
> attempt to have some shared code for this.  As well as documentation.
> 
> It is probably a bit UMA-centric, I guess devices with VRAM might want
> some placement stats as well.  But this seems like a reasonable start.
> 
> Basic gputop support: https://patchwork.freedesktop.org/series/116236/
> And already nvtop support: https://github.com/Syllo/nvtop/pull/204
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/9] drm/docs: Fix usage stats typos
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0020582a8afe9a8570f80ec503c59bf049a616de
[2/9] drm: Add common fdinfo helper
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3f09a0cd4ea3b9d34495450d686227d48e7ec648
[3/9] drm/msm: Switch to fdinfo helper
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=51d86ee5e07ccef85af04ee9850b0baa107999b6
[4/9] drm/amdgpu: Switch to fdinfo helper
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=376c25f8ca47084c4f0aff0f14684780756ccef4
[5/9] drm: Add fdinfo memory stats
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=686b21b5f6ca2f8a716f9a4ade07246dbfb2713e
[6/9] drm/msm: Add memory stats to fdinfo
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3e9757f5ddb98238226ad68a1609aa313de35adb
[7/9] drm/doc: Relax fdinfo string constraints
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=90d63a150b85fd1debb9c01237fb78faee02746a

-- 
Neil

