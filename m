Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E2B67C587
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbjAZIJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjAZIJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:09:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051D4677A8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:09:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so572244wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGmVBtO5zBSgKaXSgL7/y1bcT0XKFt+9R+LKypxoxTE=;
        b=Ve2PnYAAJYp/xCfrXznkM6RZzbksDbuJVz8AQ0YWXYYyNY4v56yZ/uEdbJXxG6+1+7
         UTQrr8r0LaeA2+EvzpAYHxXZH3ca8PSNdLyJsgsSpbehn8c6whIdj4UMjzKeJ9zzOyL3
         BQycjc3zo+SXm5p6Vx2TlLQsG/Qw3k5z+vho0FsplYOvwdIav4wwM/DFEiifop2dbAiI
         ethS71TMFFN6NOPPmNYogMRE/OYEOJhx/NuFqBA6ALohORxgN13jXowG6tuCJoqECjM4
         XAg/nIZFiPlwUyryNeSaVTAFKxr1zx+w3u0bcNpREvTg+1UaxCXxrhs2ag/p0+4iaNgH
         rWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGmVBtO5zBSgKaXSgL7/y1bcT0XKFt+9R+LKypxoxTE=;
        b=L9yU0Ne+ZNmeYhjRJwcRbn/+n79IrrgPOju5NZEuQuFrZ8zb0L3pQR/DrEdNvzX2U4
         j20FL3oTnTD18fGBLYVCYtTdSoLsf7/pHj1O7Gxze68PwfQ8wp/ramoK3FehDtdPcloU
         qvslrOyW+c7MMhC/GSiUtYnvbP+MB6lZ7weUONNA+EVzIdE6K0+XJjHa5DXJyZ+xrfb5
         zgTEuIptQYblQKomiOTdhGL9lsrRlRt927FqhLJUQroPVc5JEA07ziff0PtbMlqDiiun
         RkXj2d/Muy19DWeoJmjqIgyvnOcHK2JDmM+mLP1frBPaIx3XahJSPPWY6bvOrNi3HoFu
         dMSg==
X-Gm-Message-State: AFqh2kqnwaKvUdo+FKRSWbTjL0H7gmRubEEhQJxf61jC1lPQmiVk8PAf
        DG9m7YZ2WeZv2Yu7lJ1b2CnFfzu3wwW7bgq3gPI=
X-Google-Smtp-Source: AMrXdXtF06imT3eYJ7vI/pwAmKhSEKZoqoRp2QOeeZfmYR4oo7CVvI6UI0SLSOWQFSaPAo34VtwLKw==
X-Received: by 2002:a1c:7216:0:b0:3cf:614e:b587 with SMTP id n22-20020a1c7216000000b003cf614eb587mr35204528wmc.26.1674720560564;
        Thu, 26 Jan 2023 00:09:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c479400b003da119d7251sm735499wmo.21.2023.01.26.00.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 00:09:20 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
In-Reply-To: <20230124233442.22305-1-rdunlap@infradead.org>
References: <20230124233442.22305-1-rdunlap@infradead.org>
Subject: Re: [PATCH] drm/bridge: Kconfig: fix a spelling mistake
Message-Id: <167472055986.422719.2396635475523592126.b4-ty@linaro.org>
Date:   Thu, 26 Jan 2023 09:09:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 24 Jan 2023 15:34:42 -0800, Randy Dunlap wrote:
> Correct a spelling mistake (reported by codespell).
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: Kconfig: fix a spelling mistake
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=d703a0f45a70e6ed4749780ed5efb2d1ec042297

-- 
Neil

