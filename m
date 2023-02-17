Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E7E69A4B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 05:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBQEMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 23:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBQEMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 23:12:13 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA324D607
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:12:12 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id h10so4281008vsu.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=khYUeXPrSaACLyO7uuI0hTSia/FS90YP+QaX0EK1f8E=;
        b=KQjAOl0W735TB7cqm8bxPQGwfcUz3MsFGOO0QYejWnPkHM0jmCPg0vW9O+h7tkIpDF
         1cCT7ATb1VEm5BqNohdxSaaTSxCOurOvUwPQq/RwaRLt4niM7/ifA+BZwlvzTPeQ4tdO
         GTtYLPHlTkHKoWLvvx+358XlBEAkDdsPD0KNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khYUeXPrSaACLyO7uuI0hTSia/FS90YP+QaX0EK1f8E=;
        b=yABdCsf8fWaMwlepbvNrEm9pU8nsPFP617j0hEBRU5LODkA55eoy8t9uw4dDW8e99Z
         yZnRZoaqeUMLdCcmNconbS63uyRNVI9+vy0Cs58DUOyNnCZm3wuEHAoMvrrWJSNDN/ts
         EG/mbBERyW6StXMKbZ+S0qZaPwg6/Lv6MLG8g/Dr6ffw6h07UZ+ScNEZAGx0OA1pH0NQ
         fgBF3+12jIfpVPlrUBLruDFETKeUSWOYvwgOFuk1JO7DtIpdemK3q1rD2WH/ciSNCpsE
         LcrDxWU9sG0u71Jt0rQQBVINZl0QhDMJDkvFrIFwr1hhw4nc7vHWEXVNZ/qOMprIC/dj
         /vOw==
X-Gm-Message-State: AO0yUKUvCunPTk0HczpHKNgYiZlSI6dQYq/dnBc7M1U3GSY1Jv4DuwUl
        WTxrI+h/SQwn4WWZoqwgCfclAzAE4JX58uNe6IKv1w==
X-Google-Smtp-Source: AK7set/sHqw0F0KAlUssNSjqDO4mAX2C1vW3h2bJP5i6XlLsaFKqnO80PlYSXGZZLDvz4XXG6wfbSGjLay4IOoiera8=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1525298vso.60.1676607131719; Thu, 16 Feb
 2023 20:12:11 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-33-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-33-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 12:12:00 +0800
Message-ID: <CAGXv+5F5KxA_3jtbgXfat1xSL79_k+W7kzpiOZmGHyEM3fnSkQ@mail.gmail.com>
Subject: Re: [PATCH v2 32/47] clk: mediatek: mt7986-eth: Migrate to common
 probe mechanism
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
> Convert this driver to use the common mtk_clk_simple_probe() mechanism.
> While at it, also remove __initconst annotations (as these structures
> are used also at runtime).
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Git really doesn't produce good diffs on these large rewrites *sigh*.
