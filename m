Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26DE65DF91
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbjADWEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbjADWEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:04:48 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6EE3FA25;
        Wed,  4 Jan 2023 14:04:47 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id fy8so21951722ejc.13;
        Wed, 04 Jan 2023 14:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAgESyffyGfL2EhiYgHo7ieKIsVwn7XJhQmStMSRKhc=;
        b=phZ4NEuz02LsQ6So2V3GDbdOgwyUdlRwWhE5T2GTNM/a5pN71DO/CDYus16Rv/B0ZK
         pJ0qqJvDjI4bKk9DQPd/Lrk5Jjy9BrpWHESRd9N09T8gtnRjrW9MoNVa+KtRnr4zLubD
         7tTmunNmEQ3JXQcKYJ05+jf/lTcKuELd6zucImxruAGzLylewyGpovnNdY3icMfC3m7E
         n7hW6kSKL78yD7ihTeiIvHudmokzhrkGqT0vsMGR08nr0JnlWzpLRS9K2VxR0fvV6LYA
         ZXe2NwMbfNEoNtoJ/Gjw8WW2adAZM36yGRp+BE6Vx39jQA4BQqJJ8ifhw03MCZAgOd1R
         T59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAgESyffyGfL2EhiYgHo7ieKIsVwn7XJhQmStMSRKhc=;
        b=xwS3+IZyTFfKNYgzJR/oRGI9d3QoIIiyCH4DYqqPEKvkeFwB9whOVFdYrqWvwGyNFu
         R2ujkg2O7JnO5dM8k2p4pHb9jQ1IE6rfJM3A+QBLIjupZAdSfmDleUf9gtSQqzeJDd6F
         Jhuu55H15FJEYeiGGN3alKMTLbyYCCm+tqqcAyxLel0o+qLyrl15PRz9yu6KF37faSrH
         6rlGIEOGWaaf0X3KMbst0kD0Qm5iP0IxdHONBWu3Z2spKz/Hv4LqvJju+q8dQz4yDSsC
         QmVLOJzzM0KUGOGRQlccuBjRpYvOKc2gW0Bf32FrKJEVyPK4PmgUFVZL8AoDiMhT+ZbK
         ZTAw==
X-Gm-Message-State: AFqh2kpHEBM08qKNjSTIWkghL9aITLiuy0JM2hVxZ7C2NUjyC01jI6bB
        wJRkA+bK93txNrMrmIYqWg4=
X-Google-Smtp-Source: AMrXdXueZ4a9lP4WZD0oUUo0ysvovdN+8hgWpPMcryijlJBywkg9NIsmu669fcPxczi1QTbkkiMVIw==
X-Received: by 2002:a17:906:ecf7:b0:7c4:f6e4:3e92 with SMTP id qt23-20020a170906ecf700b007c4f6e43e92mr49873730ejb.31.1672869885740;
        Wed, 04 Jan 2023 14:04:45 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id jg34-20020a170907972200b0084cb8589523sm5336958ejc.139.2023.01.04.14.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:04:44 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 2/6] iommu/sun50i: Track masters attached to the domain
Date:   Wed, 04 Jan 2023 23:04:43 +0100
Message-ID: <8201525.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <20230103010903.11181-3-samuel@sholland.org>
References: <20230103010903.11181-1-samuel@sholland.org>
 <20230103010903.11181-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 03. januar 2023 ob 02:08:59 CET je Samuel Holland napisal(a):
> The refcount logic here is broken. The refcount is initialized to 1 with
> no devices attached, so it will be decremented back to 1 when the last
> device is detached. However, refcount_dec_and_test() returns true only
> when the refcount gets decremented to zero, so the domain will never be
> cleaned up, and the hardware will never be disabled.
> 
> Replace the refcount with a mask of masters attached to the domain. The
> domain can be cleaned up when the last master detaches. This mask is
> also necessary to correctly set the bypass register.
> 
> Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


