Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC00C6E5BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjDRIWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjDRIWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:22:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DA7199A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:22:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so14387508wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681806123; x=1684398123;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOCCLAEeZnpHxAtmmGgzxPwF66rFZDU3rDLalgc9zEQ=;
        b=XyU1r783tqz29k99NMiDpHgiXTPnCw33Nun3tmjuQA4WFmEH0ddmRl6lTyFp2R+6l4
         6ifo7qBvBnbM6Rwv/p6HapTjL6018wlLFeeDGV1l4n3Fp3cEv5JfEnVdZ86mO9pyfWZr
         Rpg7jjEoDR6wgWs8JKtUTlaeang7N2hd77oTDgRKIuxHNU917kfI2zvhmvMMb+ydho/7
         h+VkPep9PARngBmsYdm1MGDjITVhD7zVrtUxxA6pb95jfeqnrqyVpkPfXev0yIe8qV3y
         6IlI2halY9wDtBv9RIlhCInHlPJ6aKq+BwyoUrvZ9lBFfeBUjUgpXnLl1ReslGMa5mP6
         o23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681806123; x=1684398123;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOCCLAEeZnpHxAtmmGgzxPwF66rFZDU3rDLalgc9zEQ=;
        b=lACYiDE50hAlF63lakHfl+w6Zkse0coxx19wD8MYKJa2B0SMp107PyVLDFGIRRKtvm
         x/Gq5EAdXZqpUcK6Fw/1QVKrLHDCQX1YOLG+bsZgUfbHuHOviUzmf+JOCVy+8aKoDlxK
         zJJQOY7z0qn/idaYXCmWsqtWEgeyIE6eI93ty70thgBXIfPN5u07nkdrJZN7n79EUUYM
         h9MPSy6uNRlbmVfsRMtBNwCTf9uAnD6fSVtSzHK5xaQdgekpVPlu5qYjJUq2R6x/6wl+
         xtEer8wvgOULeWAwVW9yBYHOz9PEAXX0NtWJbhcKI/aVI1HN7aLjx3azQa4JlkXjceSK
         pEfg==
X-Gm-Message-State: AAQBX9f0nVIvCdYxO6YgIp9a5rcBq4fdehLmELdieDn+WEildTauFi3e
        t6G+js7e18DfkK5cYcem4o8T+A==
X-Google-Smtp-Source: AKy350ZA7c/Isc4ixslJcBkYI3gZlJzvqaQTmuMdbZ40kxrfCu7z1GoBWjUWHvVpFGs6vR76VWOz0g==
X-Received: by 2002:a7b:c8d4:0:b0:3ef:6aa1:9284 with SMTP id f20-20020a7bc8d4000000b003ef6aa19284mr13088585wml.29.1681806123357;
        Tue, 18 Apr 2023 01:22:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y14-20020adffa4e000000b002f5fbc6ffb2sm12329185wrr.23.2023.04.18.01.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:22:02 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230417-topic-maple_panel_fixup-v1-1-07c8db606f5e@linaro.org>
References: <20230417-topic-maple_panel_fixup-v1-1-07c8db606f5e@linaro.org>
Subject: Re: [PATCH] drm/panel: novatek-nt35950: Only unregister DSI1 if it
 exists
Message-Id: <168180612256.1150495.3672863817651132915.b4-ty@linaro.org>
Date:   Tue, 18 Apr 2023 10:22:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Apr 2023 17:41:08 +0200, Konrad Dybcio wrote:
> Commit 5dd45b66742a ("drm/panel: novatek-nt35950: Improve error handling")
> introduced logic to unregister DSI1 on any sort of probe failure, as
> that's not done automatically by kernel APIs.
> 
> It did not however account for cases where only one DSI host is used.
> Fix that.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next-fixes)

[1/1] drm/panel: novatek-nt35950: Only unregister DSI1 if it exists
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=a50be876f4fe2349dc8b056a49d87f69c944570f

-- 
Neil

