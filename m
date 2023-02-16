Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAEE698E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBPIMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBPIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:12:11 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456722886B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:12:07 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id z15so1092401vsj.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dfTtDbofkY1pATTMEv/SAf76IfaGsSIyYJtG+jJyho8=;
        b=lySNA01DIQWkgwtRvj/X6Ob8tzm+Mn+oE9MXXNMKCbzvD9/ImDRgbys0KYR05gATMg
         LzjYmu0MdtH7jHJ/j02SeRJC7YJcrsh+Yc/RdgaLqqNjaRmafziWbucC1pGdMsO/eK1K
         Py/e5RdiSHfWAh/qPd2tLOt2MiqOxsRoiL19Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfTtDbofkY1pATTMEv/SAf76IfaGsSIyYJtG+jJyho8=;
        b=L3A9Dmq1VO1YJ9ddf/AG8cdSbylh7NATQW06GhILKQtTFBGquaamv39fa8TQsLwjrP
         LJXQf12tVFQRHlVmnDQjy+Ko8zUorC/PnE1F3zVlk7FAKUEYKJW2fp26K1feck2oXbWH
         PloQ8WNUg3RttHcDoUx0PU5Fl3fImDdhsYQBVfrOAMDP7Q6Xd+eDPXJ74mjbd/ecUujE
         +Tv1w+5eOjJ4oBTmKSO0QjDSbHV5Ks2TSb/HLsjSWBohxoNpIa2L0zKs9y1DVdEMsj2i
         waHGyCy0ldXTU+2+CBFMjlbPG2S4T6qA60KQbvjiUzYKvXuAMW3575qMSZcbekl22jxW
         +RKg==
X-Gm-Message-State: AO0yUKVoj6Cs/vfJevWzfJVssCt67O/QrRvvYBcRAr0Mz3qJtKXn3owN
        yRdV2YdDZxldyHqfNDFJ7s2/1xWJABUeRFaDQf8dJg==
X-Google-Smtp-Source: AK7set9GLZD9CV/33MRERq3c7/9G84mUxES45gMMthrTTkVHz/fhYLvw9tN1hgVZOMakIs5IYmKdncbES1i/ffC40Zg=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr948306vso.60.1676535126416; Thu, 16 Feb
 2023 00:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-19-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-19-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 16:11:55 +0800
Message-ID: <CAGXv+5EVLKwf8F9SxauWP4O61wxdEFwk7hhir16r82Xp-pDe7A@mail.gmail.com>
Subject: Re: [PATCH v2 18/47] clk: mediatek: mt8183: Move apmixedsys clock
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

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for migrating all other mt8183 clocks to the common
> mtk_clk_simple_probe(), move apmixedsys clocks to a different file.
> While at it, use the builtin_platform_driver() macro for it and fix
> some indentation issues in the PLLs table.

You also implemented error handling. That probably deserves a separate
patch with a Fixes tag.

ChenYu
