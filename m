Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DB6698DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBPHaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBPHaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:30:14 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8224B392A1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:30:13 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id d66so1020114vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zgjdmMw404e96eCGT0CwRLnwbGzyDOlmcdjqegZU+w4=;
        b=U29za6dP4nZim4LX73LJtepxSFecuP04iFHVMGXIIuisBRRZ7kL0/VWKWH1sCfZ9HT
         HK5v10fiBN7n7KMtRCCc8Cj48nNuRpvwJY0qGcaH1Yuwlc+2qRCXLLeC0x1ru68PZr7d
         /PiCpCIHgxgl/sd0GSozR6wEbSm0s1TjHb7ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgjdmMw404e96eCGT0CwRLnwbGzyDOlmcdjqegZU+w4=;
        b=GkiakyppFA6uvxO8fVR5Tk+GPNNq980vDcgNzfh+by6Ie3FWwelvXPqbgPWQaRvIWL
         TbELfEntAl1qvgZfl6jpdDt3Au+Zjr/YLtHIRwXuECVWdp1gi0BTGD5TwzXdtZXwaYCU
         jtHjtXSWfgrqnouQb07SoM6MNW1JahwmUaH7OSaRfCBCH6iHezt7DHKFwc3LG1NSRY2G
         5flrGgNO3D6arXy7aoEY4L80k2Sg31nBEA/+uYu9lfYRViaPRSZVHrLJVWRnpv5hX7Dh
         EMdeDrLfNw8NlqgF1FOZTS1mZQ3E37OrWRMOBiWhoVc4S/aCa1YZjH6tpVJMetNiiIcQ
         aSAQ==
X-Gm-Message-State: AO0yUKUIQPhIo5esaadG/YI8retwY0YPyRdCn6+gFwTYJwXyLlc4UZ7H
        Y8OyPfctQQYhHdAF/I924z3F3xLzYr5A32bJSv3Ztw==
X-Google-Smtp-Source: AK7set+jJ/AVTqSNvsg91s9wgAmlKRg3temVxbwWlpvNRXd5CctR0P9VX7JvIhJNWWy7kb2HaRpKDPvC64m+RlpI6bs=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr931199vso.60.1676532612556; Wed, 15 Feb
 2023 23:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-9-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 15:30:01 +0800
Message-ID: <CAGXv+5F8OQX1WTDVLtLL3s_5ztVDO1hmzNN4uySsut74jbyoww@mail.gmail.com>
Subject: Re: [PATCH v2 08/47] clk: mediatek: mt2712: Move apmixedsys clock
 driver to its own file
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:41 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The only clock driver that does not support mtk_clk_simple_probe() is
> apmixedsys: in preparation for enabling module build of non-critical
> mt2712 clocks, move this to its own file.
> While at it, also fix some indentation issues in the PLLs table.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
