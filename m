Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C6F6293D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbiKOJHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbiKOJHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:07:10 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33B821E05
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:07:09 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p12so12594264plq.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BVzHUOg3Tw/oS7PqcIhE4bFaHM91oQiodH+CwJsS3b4=;
        b=cQNzhkJfVjxyKHBWiF4Trq5Tb7qKVSKPLT6h1vLWg7/3Q4RsgrlomSgDOqBJWObhJO
         ekLGK5Yyc2gpBQEs4FHjKosvholJvzPzfEJ1Ay48ZFXQ6XRtgKCDEXtr5gOu5bYEYeIX
         xLHMLM3T6F1sSQy8qXVbYx86hqV9lWWb2KYgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVzHUOg3Tw/oS7PqcIhE4bFaHM91oQiodH+CwJsS3b4=;
        b=XZkn5GlclE9kcsQG0V6hSJFTefn5sBD6lt4NtHh07qRnxOS/7iWdNqt9NUQ04SinWV
         cmraL+90UlVxcxapTNDT9mqfGblvkutB5q+RQ0al18wzSRcCopeGYyx5ZnhfSOeHllRZ
         H7U8PMKpE1KnYqWrciRti6xKaru3dFjSS9CdgeT4uPFZI7n5Y3ZmTUOTjdNiMyuLPmhr
         gRc8P2rtdK8cNe2miTOOpk6Hu6/aSeF8EWsg5pwHomvl5ErlsN+IGMyvLvTMre3GReBk
         t63SgGUB35Rr6F64THMKMaCqvMldYNZ9r8kzo559ievjIDSM+FkfTWJg3bw0NbmkMiOw
         LJVw==
X-Gm-Message-State: ANoB5pljA/eBo5KPl9tAVp0QxQFzWVZSKMWENbb9XtFL2usmSLCS5k0y
        wH8Xcri/O5MJLR8dTIBh5ydddA==
X-Google-Smtp-Source: AA0mqf5ZPq5c3BoUDT8xkuFzdF1QmWcMV7pUAtSTv0EFvGqy/jnfrTAIei6OAmdzrPX3VMusoP9+2w==
X-Received: by 2002:a17:903:228c:b0:183:6efe:65eb with SMTP id b12-20020a170903228c00b001836efe65ebmr3224312plh.34.1668503229437;
        Tue, 15 Nov 2022 01:07:09 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:4d49:6d15:b250:5977])
        by smtp.gmail.com with ESMTPSA id q16-20020a17090311d000b00182a9c27acfsm3378830plh.227.2022.11.15.01.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 01:07:09 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: allwinner: h6: Add IOMMU reference to Hantro G2 decoder
Date:   Tue, 15 Nov 2022 17:06:42 +0800
Message-Id: <20221115090644.3602573-1-wenst@chromium.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While doing some decoder tests with Fluster and Chrome's VDA tests, I
found that the Hantro G2 was failing, and there were IOMMU fault errors
in the kernel log.

Turns out the decoder is behind the IOMMU on the H6, as shown in the
user manual.

This series adds the "iommus" property to the binding and the dtsi.
Please have a look.


Thanks
ChenYu

Chen-Yu Tsai (2):
  media: dt-bindings: allwinner: h6-vpu-g2: Add IOMMU reference property
  arm64: dts: allwinner: h6: Add IOMMU reference to Hantro G2

 .../bindings/media/allwinner,sun50i-h6-vpu-g2.yaml           | 5 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi                 | 1 +
 2 files changed, 6 insertions(+)

-- 
2.38.1.493.g58b659f92b-goog

