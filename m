Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AE564DC57
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLONgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiLONgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:36:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A64DECD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:36:40 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w15so3044049wrl.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbfBcU9A1qcZjZLYbdzPQwKvFqbEDNx+6TcqfmObulM=;
        b=xSxqvWtrRrWeU7bLIs1demiCzLhGsuTmM+xAgDZ3pQmMHq41LUzKmB9oEpTpMKvyNF
         J136QvZcaTBf4tEYPqK0/cvCMXPWKFbaN3V6saIHTNCFYgh15L3dK4Obm2YpbYxFGX1D
         +7e4U9lZrW5fD8idyHCRMwAEPAyE9Uy+J4vVgcNv4RMopsGzcco/3SgWxICwpG30PktZ
         jvQQny3aFcDyPqAgevQO39AqBaq8C8OUtHAwVjDSrLAuL1IO5mCJBBenQDt0P+TN4G+C
         Ag7tMtgpKBH0eCyBiTgbTbVxWRi3lXgBMI48DzbiUblrKwGDvxfWSkvrA0IjrX8VXke3
         TwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbfBcU9A1qcZjZLYbdzPQwKvFqbEDNx+6TcqfmObulM=;
        b=fWOT+PrMoOUm+67Dh4N/8tUCgWHbNVAZBBLHbdUWeqrYo8ijrlF8X0DSvMGT04bhqN
         dpb34ZP2gCFrqP09kK2l1g8WmNqP6fNeqiYtyF9P9o1TgrIK/X/2NCBLpiXtVJX2ciBU
         j3LBtgwujNdm9UKfgo5OLWtHrlPgWxbNHKRNBPBrmRtGhMeFc3AkEk1aM8l4rYONwEa0
         340xaHluIInN1HxCAkSLpsIdMmwBq5FREoTFF8qeCe8CzdMNLI8KUAu0MYLS+b/14q55
         yqKyV498wxd6AGrVJq24btWbwoQmxvYkKipAvUy/jntnXgdDjZpfPx6UVcOGc8Qxqh4P
         bizA==
X-Gm-Message-State: ANoB5pkG5E1FSi1WUjLagR6IkRQfnWmWbfB0c1o0atf3I6vLUxjlqPTP
        2Zs5fPevN84Io4IUDwNAClHqOA==
X-Google-Smtp-Source: AA0mqf5ZXBLizzx5vPqrVCYrI3ddotv22opYYEybkbq5yxVjFk5rwP1q5r7+TCgCn6Qx0cj8/izb1Q==
X-Received: by 2002:a5d:470c:0:b0:24d:867f:10e3 with SMTP id y12-20020a5d470c000000b0024d867f10e3mr12593771wrq.0.1671111399103;
        Thu, 15 Dec 2022 05:36:39 -0800 (PST)
Received: from prec5560.. ([2001:bf7:830:a7a8:7e6a:e951:1d52:a2ae])
        by smtp.gmail.com with ESMTPSA id e36-20020a5d5964000000b002425be3c9e2sm6019829wri.60.2022.12.15.05.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 05:36:38 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Robert Foss <robert.foss@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        open list <linux-kernel@vger.kernel.org>,
        Pin-yen Lin <treapking@chromium.org>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v7 0/2] *** IT6505 driver read dt properties ***
Date:   Thu, 15 Dec 2022 14:36:31 +0100
Message-Id: <167111122676.1425386.1293802929297712782.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103091243.96036-1-allen.chen@ite.com.tw>
References: <20221103091243.96036-1-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2022 17:12:41 +0800, allen wrote:
> This series let driver can read properties from dt to restrict dp output
> bandwidth.
> 
> Changes in v3:
> -Rename property name.
> 
> Changes in v4:
> -Use data-lanes and link-frequencies instead of "ite,dp-output-data-lane-count" and "ite,dp-output-max-pixel-clock-mhz".
> 
> [...]

Allen: The email name you use must exactly match Signed-off-by string,
or there will be issues like the below when applying the patch.

-:139: WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email name mismatch: 'From: allen chen <allen.chen@ite.com.tw>' != 'Signed-off-by: Allen chen <allen.chen@ite.com.tw>'


With that fixed, applied!

Repo: https://cgit.freedesktop.org/drm/drm-misc/


[1/2] dt-bindings: it6505: add properties to restrict output bandwidth
      commit: 380d920b582d0f83852ac6885af868d93c38095b
[2/2] drm/bridge: add it6505 driver to read data-lanes and link-frequencies from dt
      commit: 380d920b582d0f83852ac6885af868d93c38095b



Rob

