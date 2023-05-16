Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5711D7047BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjEPIZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjEPIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:25:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC724C0E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:25:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f475366522so44769715e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684225527; x=1686817527;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pFJano5Bm7/4Wj7Vuhd/IaaZxuENtuX15bdwD6I5UE=;
        b=yKTPc8HoOitwxtMsm0g5H2PfHqBq1fDMyqj9xC9VY/mhHRpGiJMsmTpHHsmhZY1AEO
         A4uXaEk15ZQ9APsgaEdylQhGSTIUeUViIQW2rMQwnsBr8D8eeXjXIwBujotNW177eSGZ
         LtQtScRJ/u+xFyxU14aNcCZU6ScRlZNMOL+jIRfh9Dw7k1jEP/u52qfFKedPTJDAeNAW
         8K9mT8hmnyhFBhPMm0bxVXeeL9H8KBcPFcCDX6VT+2BmScTssobHm8CG84zH8S1T7gN4
         0giYXRkCziKcuUzej7ILcaoIWx57hlRffuU4XT6xHX+rzNQsassLehSrQ6xki7CIb46z
         Po8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684225527; x=1686817527;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pFJano5Bm7/4Wj7Vuhd/IaaZxuENtuX15bdwD6I5UE=;
        b=aUCJoBti0HdXZ8wg200lu11NLUeH3YOqQd22sGacFISwyjKOWFbKXFf7pINZYoIdPG
         PzX0UIiH1s2wQC8b9A+d+tkSfdEP4DMxslQ+RigSCzsvuQ8N8zOgPq/Stxo040jUuPD0
         QtlaJbywqonGW/nKRRzY8zepAVqhhZ4Vo9nDSh7d5dWA9WOfsme75CH50QfDmG5mu6MQ
         0vJ5R6SWpI2btQG6pEFxTnW6+nVXg9eJ3kfnCOuCAosV0bs5gBpjvtGb6gC9NPDVK2N1
         zIAKuWRD3vaJ9KU0/eH3JcnF9aF78Y8CsWsz85DmNgGvf5YMn2mE8UyTDImb2BDnivfy
         /Dgg==
X-Gm-Message-State: AC+VfDz5s1tiIvOlcqQ3Rb1TcapH64Vpsg+15KwyhN5yDnJHfHdHF6lU
        hGqauHUwN+Z4r7D20Yjzbm5l1A==
X-Google-Smtp-Source: ACHHUZ4cSbq7K4tEpauuBUbqTuMP7KQuJwf3JpcvbyifkW07RgANwscAx1w2Nmcd6poi1DpqAsrJww==
X-Received: by 2002:adf:ce84:0:b0:309:2b6:5c83 with SMTP id r4-20020adfce84000000b0030902b65c83mr8957075wrn.1.1684225527143;
        Tue, 16 May 2023 01:25:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r14-20020a5d494e000000b003063a92bbf5sm1727505wrs.70.2023.05.16.01.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 01:25:26 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>
In-Reply-To: <ZF9igb/nvL6GRBsq@yoga>
References: <ZF9igb/nvL6GRBsq@yoga>
Subject: Re: [PATCH] gpu: drm: bridge: No need to set device_driver owner
Message-Id: <168422552612.63953.10959326183714499182.b4-ty@linaro.org>
Date:   Tue, 16 May 2023 10:25:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
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

On Sat, 13 May 2023 15:42:17 +0530, Anup Sharma wrote:
> There is no need to exclusively set the .owner member of the struct
> device_driver when defining the platform_driver struct. The Linux core
> takes care of setting the .owner member as part of the call to
> module_platform_driver() helper function.
> 
> Issue identified using the platform_no_drv_owner.cocci Coccinelle
> semantic patch as:
> drivers/gpu/drm/bridge/samsung-dsim.c:1957:6-11: No need to set .owner here.
> The core will do it.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] gpu: drm: bridge: No need to set device_driver owner
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=728cb3f061e2b3a002fd76d91c2449b1497b6640

-- 
Neil

