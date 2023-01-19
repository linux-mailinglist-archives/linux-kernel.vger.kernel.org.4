Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEDA673C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjASOfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjASOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:34:38 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916B17F991
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:34:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso1403749wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx2sgR4I+PCqSdEJtAUh2LY7zlVFeams01kArMc5MAQ=;
        b=Hz0ugRV4NBOTO6QAdNbUHpUtlQLtvH6+/rvMt+dL9gK4pvFOCbn0EGhSaYRAnqMTYd
         rUGzPAV3+WrHZCog/auxZ4IFl3CVihBlMfMkLdkhfXFTIsVmwxVSmEKLInlefFnOshbr
         ldbdX5Aiks1Wd1enfa4K5FJ+SQuoxlzFmnx52wjB4Ybge1nzzykkv2ANTIXKMXOHXAKo
         PMk/GhsoKvGT9cLDsSMY0m6jLyejTS/JgX71IPmZvgoKcXm3ipkdZJz4fU/yQGg9du3c
         KeN/VMpUlVHX6QkfDFjpp8oyqWHx2EvCDnnR1GQxEP7Oy+MOU7ovfVlZsyBBnKSfvylB
         7ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yx2sgR4I+PCqSdEJtAUh2LY7zlVFeams01kArMc5MAQ=;
        b=JLhg/JMO94rY5q+Uy06MMzqXAR7iHcj+997vQ2LLWJLcRBSs7y0YuPgL4Mc4MezRLM
         w7wYO0ySJ9Y/9GqyX/4RyFPomHJqfreXhHQswLPPf4lxwt0/JvJJF5UWMgMinYJpF19K
         IBnWAZ8HlwnosEgU+MDjmt6nIQjv85qBCGy7+d383pfdudYowbFiH+r7yk/KRSlE5wpD
         eCkv4YH7uPTXf+lYk05ZdguPzmIsyWgLN/gifGAEC2TdUOz+SaYcJeNMNRxEuSoMowGS
         ZEo1wa7i9RxJDbht425uj3tOLPuIE25nPvGIyywNyVS+h2PGe2P9qtdkxQqvObZTjaoO
         SHVw==
X-Gm-Message-State: AFqh2krtzPSeZZx3k79ErT1N1iYRK9SjmHttaWZjqYWXY1ZA6Zcdq/2d
        pHNijj04gudtdGZWVguDsJwa6A==
X-Google-Smtp-Source: AMrXdXsgEg/Qm0W/QIFawUu26Bw1sWppVEJ4LAUXOnzVHWIuhwj3UOeKLF7fV5+pQcGTFgqIRBsMFg==
X-Received: by 2002:a05:600c:995:b0:3da:f4f5:ad0e with SMTP id w21-20020a05600c099500b003daf4f5ad0emr10396023wmp.9.1674138840071;
        Thu, 19 Jan 2023 06:34:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b003db012d49b7sm7832926wms.2.2023.01.19.06.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:33:59 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Richard Acayan <mailingradian@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20230119-topic-sm8550-vtdr6130-fixup-v1-1-82c4fb008138@linaro.org>
References: <20230119-topic-sm8550-vtdr6130-fixup-v1-1-82c4fb008138@linaro.org>
Subject: Re: [PATCH] drm/panel: vtdr6130: fix unused ret in
 visionox_vtdr6130_bl_update_status
Message-Id: <167413883934.668266.5467309619492454547.b4-ty@linaro.org>
Date:   Thu, 19 Jan 2023 15:33:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 19 Jan 2023 15:04:12 +0100, Neil Armstrong wrote:
> Fix the following warning:
> panel-visionox-vtdr6130.c:249:12: warning: 'ret' is used uninitialized [-Wuninitialized]
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: vtdr6130: fix unused ret in visionox_vtdr6130_bl_update_status
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=ebd05c0e12edc568243056711ce00f79e19eab68

-- 
Neil
