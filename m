Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9749C71540B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjE3Ctw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE3Ctu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:49:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB728E;
        Mon, 29 May 2023 19:49:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4f89f71b8so2299339e87.3;
        Mon, 29 May 2023 19:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685414987; x=1688006987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvM0y6VNRliRPDVUSeg1QBMWNmNUv7Ud9dd+nfoUaE0=;
        b=le0n9U0jpxczpwLhNAv68Y5WyqHzPFG3wGDw8gjr4YE57gf+MFqLu3KTSw+f9WtUu8
         7gCG/Tt7xKBtR+tq7O1qPk/TMukJVB/d+SRBNOvVR8Bi4RWk0gdFn5jhmvXaLdJzJQll
         mnXAKnVT4CnR080xsmKIhIDnKQ/reksgrLVqW//TvnrKIufM7vEh0d/HFDB1S2q2zGrr
         CTfGglXERMTtsrmtdbn27K7bFX8zgaLJV5kG0doVdaJt2B7o5ydm0L7K0E5e/mkLZeXQ
         hoxeA/B26ayOz0ZRyxlK4OrYJdnfbM6ZACj+z10HcJ0HGMWU4rUHpWwUUcKcRIUFL6q/
         1z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685414987; x=1688006987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvM0y6VNRliRPDVUSeg1QBMWNmNUv7Ud9dd+nfoUaE0=;
        b=OxZtLaKLeGjc0rtiAS2kVpznMLH5jiYS0yEVt+MooappWtl3d63dgUOBV75C6ukSab
         vUjVJkln2lh5M8L/4yFanYmkuf31uaMpwmBEA7CpcpN2+Kim+OH9B6I1WNdE4W/8qIDM
         SwFthyIlDaZpeXBKHPQU5FDaGzK7zIx99dAMyxdE2/o7JLOIsxN5miR0rF8bzZ1o0V3d
         VpqRl3JAo3BKI8HA4Rmbg8v3gVBJFimzexTHNFqotROPBgX3zSLITFEgpj8Y8d53gP3N
         fFE5M17kAXtW1BT8CrBlkzV/gNafI0FWbRhs+XOapxttrskwVUeunEn7h2hzDZ11w1YR
         gHoA==
X-Gm-Message-State: AC+VfDwGF/qkTOFRCvR8nw4KK+JhSz9DavlTxNGT+JHXgKb7PlWrvt7q
        S8+o1WuhrTbjDi6X7kaEMVz80Ps0Z2cCOCcKCA==
X-Google-Smtp-Source: ACHHUZ739/CeovCvPIhXrs4sB9knbUj4d0Hm3xMKoD6o96twxdpW9VkpLbxZyztTvA5/HFvlFuSiGvEXKZWks+gvsoI=
X-Received: by 2002:ac2:4c09:0:b0:4f3:a51f:54fb with SMTP id
 t9-20020ac24c09000000b004f3a51f54fbmr159241lfq.59.1685414987189; Mon, 29 May
 2023 19:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230530024120.17196-1-powen.kao@mediatek.com>
In-Reply-To: <20230530024120.17196-1-powen.kao@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 30 May 2023 10:49:35 +0800
Message-ID: <CAGaU9a85dmzuvozHMWj4n93gfwt4Xj1qoYi2oyY_3Tcc+bFg7g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] nvme: complete directly for hctx with only one ctx mapping
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        Ed Tsai <ed.tsai@mediatek.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 10:45=E2=80=AFAM Po-Wen Kao <powen.kao@mediatek.com=
> wrote:
>
> From: Ed Tsai <ed.tsai@mediatek.com>
>
> Refer to
> commit f168420c62e7
> ("blk-mq: don't redirect completion for hctx withs only one ctx mapping")
> When nvme applies a 1:1 mapping of hctx and ctx, there will be no remote
> request.
>
> But for ufs, the submission and completion queue could be asymmetric.
> (e.g. Multiple SQs share one CQ) Therefore, 1:1 mapping of hctx and
> ctx won't complete request on the submission cpu. In this situation,
> put this condition in block layer could violate the
> QUEUE_FLAG_SAME_FORCE, as a result, move this back to nvme.
>
> Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
