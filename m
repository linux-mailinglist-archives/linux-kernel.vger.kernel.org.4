Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FBD6D6045
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjDDM0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjDDM0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:26:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5BA40D1;
        Tue,  4 Apr 2023 05:25:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h8so129867961ede.8;
        Tue, 04 Apr 2023 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680611154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvEiamQupS534VfqUXbSuDpINFZftut0QS92LpEg7X4=;
        b=ITg0zr2umq6uJE5uWt38EKHKISLid7v1/LtdB0gMGwoJ7m76yE9AukVpmJ3D4ucMK0
         4VD5e/vOPPzmfkG6ioZCZQedRavVzn8oskNNDk9df6YjFG+SwOxecL3O0UuRX18nkZNo
         6DztwhTa8v0zPMYpinELW76yH9Ts58g0M5SRUCpfsjGZuLlnA6C+wXd1yqeN2gaTNXD6
         4bQKj3FygSn3gx6iGOtSY5yHfg9TtTA2eTBQkJTBLvJXUY3bwF+Q/rQIn/xGfInX+3dR
         aHbKnNxhhUv6UAfLSKnLu9t/mYRqlZwfxWeHYPwXicNp56Ua77Cux1GUemRhHdNRC4ug
         bSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680611154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvEiamQupS534VfqUXbSuDpINFZftut0QS92LpEg7X4=;
        b=WL32vLQ4f9FM5+qwTekctCJfPYHhaMgiVaNeezm49od53OvMc7V9KESjlD+NtOCTqY
         8Hw8JkwXmIf2soZNT+mW4EvjRHjtEGU1SIzI9twR7TzX+vKC5srEq4PP2lqBDrvwkEbE
         kzKqWnMNJUJtTd2PrUWNN7di9HWs2GKpRQtagEZVftx9HSdB8kqIqQADev97NZlGu5sk
         H75oWIkg9EX9l4V/7nqSY4h2KG82PgRZISrLWZdFkv4szwkXdwyRUz1T5tiLoXNpF3xo
         2yEKcXiXj1R3SD+PmTs5uhnB5ExDnqGikhv7z503IsgMrEtzn7elJyeFe14q5Crt9eli
         geHw==
X-Gm-Message-State: AAQBX9fUsyZdg0tryXHUoG+Cvz46QVP0f42C2zKLueo829KxGWfDXu1Y
        oDYfeu8Q6gW+PnoDQdnNYZY=
X-Google-Smtp-Source: AKy350ZtNIoX7YZQDjBWRvM/+GxlQgoOVYwVgBRI52Y/EHxaIjTiEupUcppEDvzfUr8QQ+yo7CRhGg==
X-Received: by 2002:a17:907:16a6:b0:947:f4e2:aa2c with SMTP id hc38-20020a17090716a600b00947f4e2aa2cmr13829357ejc.29.1680611154246;
        Tue, 04 Apr 2023 05:25:54 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bu7-20020a170906a14700b0093348be32cfsm5988062ejb.90.2023.04.04.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:25:53 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] gpu: host1x: Don't rely on dma_fence_wait_timeout return value
Date:   Tue,  4 Apr 2023 14:25:50 +0200
Message-Id: <168061111512.2057226.3790183208967549717.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230301135107.999976-1-cyndis@kapsi.fi>
References: <20230301135107.999976-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

On Wed, 1 Mar 2023 15:51:06 +0200, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> dma_fence_wait_timeout (along with a host of other jiffies-based
> timeouting functions) returns zero both in case of timeout and when
> the wait completes during the last jiffy before timeout. As such,
> we can't rely on it to distinguish between success and timeout.
> 
> [...]

Applied, thanks!

[1/1] gpu: host1x: Don't rely on dma_fence_wait_timeout return value
      commit: c1aaee94380874fd40f7bb8417c597aba3f72c75

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
