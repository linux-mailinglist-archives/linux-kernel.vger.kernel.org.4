Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87B369D9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjBUD4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjBUD4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:56:44 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC18234CE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:56:43 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id b20so2752547vsu.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1676951802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqDsQXq0wgsqsnlCPzEpWrmYSd40mlSm295kuBDRUBs=;
        b=a576ZMtkJ7Wv2NTnDHOI0gLegs2OTwTRw4jOexe5dLNmAaNjOHVJCF6pwYBJdUh9n1
         9nmKmtWLiYerZd0TvGBHPGhtTZYDfvJ7zxaF3ByekVS2R5KmfaU/VQyD5BCLZy+3bWIl
         VPiSIzzUTNFLEz8Y922qFV56bcbGdxdV5iqCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676951802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqDsQXq0wgsqsnlCPzEpWrmYSd40mlSm295kuBDRUBs=;
        b=tlsS7XoK9SHqP+pwaHg+P5SbDhHCoDhPTisvHlkbqAcw/9Lbh4pcLwN2yo2QYppJkm
         21ntPJ8xaSKJm2sU+eV+KtL0A2nLgvNT8fJT9C7buXnNoFQDkkEZYyrMB5eMsSbwVI94
         Y5wu2jewbF8SaNuBIKRASuNPH8/R5cuWzbLwdSTeTU6zwuBsOuDdEOz4tx7nxBGRwwoQ
         Ufc4fy2AyaeMP1QOZplKmjiA/rOxwwYCv0we9M388AL4oMooVyMuKk4Zxs0hCPy/g6kh
         33JGYVcD5l611cILjEws/9eza/prb0/4CzOup2kFPvXyeVFvcXN8o/Mvo9qHCy7lAUPh
         n4DA==
X-Gm-Message-State: AO0yUKWl0ppx7KLA5vRQJ1LfhHJaw7ytsedJcIICSnIHryv3HJ81Z70S
        mX7u/WmfoRQrtaNZ846sv7pmMheiiMmBFImIyzKqYA==
X-Google-Smtp-Source: AK7set+5W/3qgD0aWYJFtRSK5l93LCmMajQHrsK61PYbkZspKKT1iGGlN/4NpN2NHg4rJwn/ADLh9XJz8DmljXjQSmc=
X-Received: by 2002:a67:f6c1:0:b0:411:a14d:6bac with SMTP id
 v1-20020a67f6c1000000b00411a14d6bacmr833727vso.44.1676951802590; Mon, 20 Feb
 2023 19:56:42 -0800 (PST)
MIME-Version: 1.0
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com> <20230220150111.77897-51-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220150111.77897-51-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 11:56:31 +0800
Message-ID: <CAGXv+5Eh0FQOVM1kgDKCTYQvmEXtwCVov8ZjqMn1n1diuvam7w@mail.gmail.com>
Subject: Re: [PATCH v3 50/55] clk: mediatek: mt8135: Move apmixedsys to its
 own file
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
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:02 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for migrating mt8135 clocks to the common simple
> probe mechanism, move the apmixedsys clocks to a different file.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
