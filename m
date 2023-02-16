Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845BF698E30
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBPH7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBPH66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:58:58 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9DEB2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:58:57 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id bi17so783317vkb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FUAm0dza/a6VVYw+sGcsIq5PuVfxpu3iI76RDCW26E8=;
        b=HDYgFSVUxfgi3rCp8OiA59w7Jsp+KNJ9d7STmmepYo4ATncHuUaxhCcTe7M0eiwJRB
         0PtBt7EozjJRRZYwZ7Gm5UXoatYhX8+alm2niPrCGSIlkCbVNNk9gR7ghW2gyY13zxsI
         HOSr4j/WI8GyxZNU360jMLYBGMR3Ee3toaVNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUAm0dza/a6VVYw+sGcsIq5PuVfxpu3iI76RDCW26E8=;
        b=e9uBe8pL8Sc5h5A+iwdS/gdV3ZuC7AOgwMFSSrQrk5ZoeNFt7TT5hWP1mG1hRNNCkh
         3NlbAThjMq0+Ucu2lQriFWWBggR6qzIgLRDqQDdMlGdUA1x/+3GJrrYvOT37vjE88jrT
         7gzprxp04lL1nJ1qCv81QMt6c1mbxsK2GyzbJTuvzAppRW2eer6O1wwKeZKO+J8a16Fe
         V6e17QJULq/HND4OtkFXXv8BS1EVcBQCMdnx7wWhNh5y8FLAWc3L+TPaXN7N/9+yh9az
         lCrRXnqi5GJwktYsc1Yo5JDzpHHoTUtYxpCVL9wr5UGYHdQRR9D0AsYpA72V29+mbbyi
         p4Qg==
X-Gm-Message-State: AO0yUKWJWBsCFpMWMmC7XZno/wm3M9g/x4M9Zgm4JQJkrBJ6XxNW4XTi
        IQHK9FGrB3GpVMjfBg/TuukDOWAWz+HyZdfaYrWBSw==
X-Google-Smtp-Source: AK7set8em8cNpEtfR7NNLJCYhRN3qLWEg9u+FeF7hd2SjZGepRPou1AUAu3rownJ1iaBcdIps8JIBHnvHr18yaQhr/4=
X-Received: by 2002:a1f:a447:0:b0:3e8:66ce:a639 with SMTP id
 n68-20020a1fa447000000b003e866cea639mr781674vke.2.1676534336494; Wed, 15 Feb
 2023 23:58:56 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-14-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-14-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 15:58:45 +0800
Message-ID: <CAGXv+5EiSVixnW_ukv-=unuP0LOik4LsSiOqi9trWOyU96YYgg@mail.gmail.com>
Subject: Re: [PATCH v2 13/47] clk: mediatek: mt8365: Convert to mtk_clk_simple_{probe,remove}()
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

On Tue, Feb 14, 2023 at 9:41 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> All clocks in this driver are supported by the common simple probe
> mechanism and it's now possible to migrate to it.
>
> While at it, also switch to using the module_platform_driver() macro.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
