Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90C06B7B99
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjCMPKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCMPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:10:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F29F6F488
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:10:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id g3so11648042wri.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678720214;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUCpRORXYheczJ2BQGJRtZxa6Mp6r71UmdeitjQxYvs=;
        b=vEISzWGhiiacHYL0o52p3JLVWsJJAPdmabMYBnS2nesKpktQWvCXn2KMfv0IXkNpWq
         +Q3LbHC+GTrzs7kM6THam9xBzj6gGzfuse00gsCVO3rOHQpZqvnF27fQyhW1NiaBQXdG
         ZZiIDvWA6G1Uqyg7hIzn7SXIeUKX1ICx8E6UUNZ+cRljV/bWrg93/Ito1H0ULCzG8gY3
         s+8kBhgFqskd+ByOqmJcOlfK7Rreon1MUmlE0sGZa+l2OT00cMo49N7bqkaEXyuO2jR7
         2t24HoUXpolSg5FlaplkfthhfAf9vp3b+vimF4sMu1kCVbWA1+VoF7XmEGzUkX2Bb48j
         AVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678720214;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUCpRORXYheczJ2BQGJRtZxa6Mp6r71UmdeitjQxYvs=;
        b=tuRk79XPDLXwwg4K3ZdJrRRQDCSIVrjkyWeGiBmFtsf4fqxlDlOUuByECj+bHinebk
         Uq/EwN56rpZ1Ez6/oW0glvRiwzZ0RUB0gmIVe2k1Cn+RalV/uOddl4TBVtqjA0UfIXF0
         txxcas+iNsReNc8AsndNJorEMqVdsdtZ/7YdY2ch5WHbCoA2QcFbq1KrvkF32y/ANgUm
         vYdTL0XiohkZ69Qtd+OmunaiGCFEtzo8WCdxRalPfo0M9h0ceMdfdqYAn3VdeUrrzgSf
         0qkKx0+KORgu4zvEqGvbtbiRJH+bzmME3jB5ujhtd6KxI+I0WWDE327rc9ovgCPmyqwR
         ajYg==
X-Gm-Message-State: AO0yUKXJuTaAy5pERMde2FoXiux7uEho26nouMCz/uQHTh/6IsZliNPS
        sLIazuENAfMk7dFawHuK2ncm5Q==
X-Google-Smtp-Source: AK7set/+LGifNvhK/I/kv9BBxsO4hCHbe7swNwWhTfx8XTxPTiY1Ws2H0VTcFWYtxno3NiyHa1z1yA==
X-Received: by 2002:a5d:69c7:0:b0:2ce:ac62:65ef with SMTP id s7-20020a5d69c7000000b002ceac6265efmr3809937wrw.31.1678720213839;
        Mon, 13 Mar 2023 08:10:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id a9-20020a056000100900b002cfe466e894sm1713054wrx.38.2023.03.13.08.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 08:10:13 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230313101858.14611-1-lujianhua000@gmail.com>
References: <20230313101858.14611-1-lujianhua000@gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: display: panel: Add Novatek
 NT36523 bindings
Message-Id: <167872021291.3272635.16381286857035586957.b4-ty@linaro.org>
Date:   Mon, 13 Mar 2023 16:10:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Mar 2023 18:18:57 +0800, Jianhua Lu wrote:
> Novatek NT36523 is a display driver IC used to drive DSI panels.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next-fixes)

[1/2] dt-bindings: display: panel: Add Novatek NT36523 bindings
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c61093b56a2ff15e449e8af56e96dc5a312baf25
[2/2] drm/panel: Add driver for Novatek NT36523
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0993234a00451e0a5c3e47d8b0f2e01dac6cedbf

-- 
Neil

