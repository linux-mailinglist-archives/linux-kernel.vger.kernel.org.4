Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F7C61536A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiKAUkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiKAUkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:40:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5747DF62
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 13:40:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so77576pjl.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOdWYdGW3s/P7m5FZD4/WdL1KbYLkJOJKiY+fmsgK1Y=;
        b=de8L7i8dhThB5jPU0QJ+wNCGKLfERSiRy+Nbh6pG252kQcQxnKnQdrC/dzwc2hsMlr
         aXSqguw0WCWoiHLlL8FFhFYXq5any+pt0sbBNK/Z6RyfW/Q96G2LiLAVl79je4VnNTZc
         rx7+QW6x2/TMYXuBQq6Crli0IYNQMfIW0re3/mURukLaYSLsG+CEd0VMlMAyPCD7M4C9
         9GGqwlrOuFinXjL1GQ/xEE6TwHb2EZbofdPaFWrE2pP5qCy4pczRGQwKJ17LIBJtMrYw
         lyxeDfIa0ZOR5vN8EbK8VDmf6DZ5plNsAi7rnapRAvQL37amHSUoIZZVL9z71/lBWZ0o
         pHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOdWYdGW3s/P7m5FZD4/WdL1KbYLkJOJKiY+fmsgK1Y=;
        b=ri3hP7j6ThoPdwX6JGyBgAzYF7vF0s0mNcXAqYULyF1qP+PI3JfCu8qVSdAvA3+ss5
         PSV+l4tfU0QIad2v6ZYXd62QFgrPhUUQh8XTRc5V0YJFR44i6xAwjurOmBSSQQ4a5MiX
         hwBODRkWHlussf62a8UGxbsZq7cxZgm7ITz+PbOvBbyND/1iMdHks6Ne7K+TETvDDjoX
         lKB7NvtVK1jBTZ2YHv79zqUOm50MjvraQIzINu3RAJywGga87fIa6cG1/XEosR5LzYtm
         EMIsbeHBmTFFIuq88yp3D/MkQQAVOsDy6/B3LrhR5D4tDtTJ4/EvFGWGI5Tb98v1/gEn
         Z2Hg==
X-Gm-Message-State: ACrzQf1R2XHHjW8aUdsKOzm3UjBCMmr9tN9gjTPk6ySZeLCTgRpUCf4D
        Pv34Ia6n+XsvM+TMcu16E1/lbg==
X-Google-Smtp-Source: AMsMyM6VfVb9FYoLCNZggIxd4jHQV9YIO5CmtN8F82LNyD+04hIVSj/1BCmis1ty+4F5c9ub9uHCgA==
X-Received: by 2002:a17:902:d2c4:b0:187:a4e:f9c1 with SMTP id n4-20020a170902d2c400b001870a4ef9c1mr18314924plc.168.1667335240174;
        Tue, 01 Nov 2022 13:40:40 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id o10-20020a62f90a000000b005625d5ae760sm7103069pfh.11.2022.11.01.13.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:40:39 -0700 (PDT)
Date:   Tue, 1 Nov 2022 14:40:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Add support for MT8195 SCP 2nd core
Message-ID: <20221101204037.GA1656603@p14s>
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927025606.26673-1-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

A lot of comments related to the handling of SCP 0 and 1 have already been made
on this patchset, along with my own advice from the previous patchset on how to
move forward.  As such I will wait for a new revision.

Thanks,
Mathieu

On Tue, Sep 27, 2022 at 10:55:55AM +0800, Tinghan Shen wrote:
> The mediatek remoteproc driver currently only allows bringing up a 
> single core SCP, e.g. MT8183. It also only bringing up the 1st 
> core in SoCs with a dual-core SCP, e.g. MT8195. This series support 
> to bring-up the 2nd core of the dual-core SCP.
> 
> v2 -> v3:
> 1. change the representation of dual-core SCP in dts file and update SCP yaml
> 2. rewrite SCP driver to reflect the change of dts node
> 3. add SCP core 1 node to mt8195.dtsi
> 4. remove redundant call of rproc_boot for SCP
> 5. refine IPI error message
> 
> v1 -> v2:
> 1. update dt-binding property description
> 2. remove kconfig for scp dual driver
> 3. merge mtk_scp_dual.c and mtk_scp_subdev.c to mtk_scp.c
> 
> Tinghan Shen (11):
>   dt-bindings: remoteproc: mediatek: Give the subnode a persistent name
>   dt-bindings: remoteproc: mediatek: Support MT8195 dual-core SCP
>   arm64: dts: mt8195: Add SCP core 1 node
>   remoteproc: mediatek: Remove redundant rproc_boot
>   remoteproc: mediatek: Add SCP core 1 register definitions
>   remoteproc: mediatek: Add MT8195 SCP core 1 operations
>   remoteproc: mediatek: Probe MT8195 SCP core 1
>   remoteproc: mediatek: Control SCP core 1 boot by rproc subdevice
>   remoteproc: mediatek: Setup MT8195 SCP core 1 SRAM offset
>   remoteproc: mediatek: Handle MT8195 SCP core 1 watchdog timeout
>   remoteproc: mediatek: Refine ipi handler error message
> 
>  .../bindings/remoteproc/mtk,scp.yaml          | 132 ++++++++--
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   2 +-
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  14 +-
>  .../mediatek/vcodec/mtk_vcodec_fw_scp.c       |   2 +-
>  drivers/remoteproc/mtk_common.h               |  35 +++
>  drivers/remoteproc/mtk_scp.c                  | 241 +++++++++++++++++-
>  include/linux/remoteproc/mtk_scp.h            |   1 +
>  7 files changed, 397 insertions(+), 30 deletions(-)
> 
> -- 
> 2.18.0
> 
