Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8811969A4B1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 05:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBQELL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 23:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjBQELH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 23:11:07 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C024D616
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:11:06 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id s21so676391uac.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv51RN8ZPOSL8FQMrMpj33QZt/iLBJxo7WnaABcymgk=;
        b=DYxHCc7b94d68sW0RoGk9gagBMyxtdDN6ZZy48NmvLaaHnt38gta0+CDNPAbYc3so4
         /SgF9PF2nYjmkmh2zYbcPTz4Br7W9vvhQYszgRZqFtzcBwgio7+SC1kFTI/lLJAykPBk
         OBk+xsO16aSE1VkdBd103+usgkctZt32pu9o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tv51RN8ZPOSL8FQMrMpj33QZt/iLBJxo7WnaABcymgk=;
        b=L+yfAf2AeI3dF7lB7L4OW2Nj/8kMadBuE7aKxivJx0wKJOmQzmkSCXyeKlRWCkt9/O
         5MeMRknldhZXb3BMqdZJ7y7MiH2cJu5IbLVPex1vaZN2uVPdzWBmIomZRPPAbCjWZnaB
         YTSzSsfQWvnXmH0Jc6H2HbvNhOcVnwfR6IicQ1eLe0MspIcAUNg+vHztj9OqMMfIvDrQ
         MDNlXd5qtiUwButLV2SeaZtehCNIIprxV1AxUfJ/kKHJkOanPslsbu6kF+f6a7DvmGod
         nZY4b3n0GOmJKy5vIQZIjMFSkPXoI4f/W5fd7I0cqcz3vuekvTWWVdRE7F1RFm4E+e36
         egnw==
X-Gm-Message-State: AO0yUKXmUAmwtuWM0tmRG29w97EBEp2o23GDuk12gtznXsvo/q8G2KqI
        xzBLH+WsbZ5wA+35bXiQ7WjHvdxhJkyYB68EeAE+Rg==
X-Google-Smtp-Source: AK7set9g5rkkJR+rAneFO6YGqzw7ZUvJlNsFBBbIlTyh1g8j02B0R2Ks5BYAGdkMReLp8trUMQdhXOpABSd7Re3e7rg=
X-Received: by 2002:ab0:6f07:0:b0:67a:2833:5ceb with SMTP id
 r7-20020ab06f07000000b0067a28335cebmr1346837uah.0.1676607065792; Thu, 16 Feb
 2023 20:11:05 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-32-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-32-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 12:10:54 +0800
Message-ID: <CAGXv+5HUBj4v04zhqVgQApc+uq_7U7B7wrydACLHBBOmy2CVeQ@mail.gmail.com>
Subject: Re: [PATCH v2 31/47] clk: mediatek: mt7986-infracfg: Migrate to
 common probe mechanism
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Convert this driver to use the common mtk_clk_simple_probe() mechanism.
> While at it, also use module_platform_driver() instead, as this driver
> just gained a .remove() callback during the conversion.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
