Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1DA6214B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbiKHOEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbiKHOES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:04:18 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444E71F2E2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 06:04:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r14so22627070edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 06:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pOuVUHGB/nt6SD3eKG4y+yC+LFY5psBIun28gN8DHxQ=;
        b=mraXDAzEvWUkYLdSfSn1oRI4J+qXiisU8WT7Qggw18Rw6Q+sh/JibKl07KdjgPOJWR
         qOnatlGuDYYIvmXex51fHCx8FJj9dLZhOdTX6/Cp1u/rZmfOkwRzLR+RpQtycVZhidkC
         69bcIS+EJi3YA2PEvE/LKqqpHV02CquDM1LwHhrma4He9YS13Y0zVFy5Bakb23/5gRXa
         2mYWTnktCFARrLKz8N69FgePGFflbub380jZFYyC7yI+R9ldALUj6QkzsSWmqapybZxr
         GamK8uzwUd+U56OyQWxqEm9o9APD69DrYlMB1NzPMxIU0EOm8J4Pv4ZGwdWh25vdW48d
         xfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOuVUHGB/nt6SD3eKG4y+yC+LFY5psBIun28gN8DHxQ=;
        b=B7VlaKE+4J0sk9iEwKHAuFlCOd4HoPOOpx/DjTHvZ8O+Z0cNTVsNA2t11xSdw6WzLY
         479nAOFvbDyuZaCLLfPRng6Nd6lvnij7P/6cOEQUSWOMivbPVgM3jY9ZxQUkgbzw4gPR
         RGO4M/36qV90me81DjumCFQM4v9wqZfEu8JexaJzd5+jvul5MGHsT99AKnkPxsjd3J2A
         du5Zo3pEDu3a7kpwFH8GrLxfw3GLKkmNWiRjGZhZ9G63NdUp5YxRuw26szKgqhJ7qoT/
         ileyZ+1OZ4G/eVYnuIdfkMvI0L6j1aEE39fARW5al3B3PpkNW8OoIshhviErQW+DFYVh
         WgEA==
X-Gm-Message-State: ACrzQf3X1R0dDYK1+KuwTERjeRUTR82ikmytxGrOwZfrETHoav6moq/x
        uh2LRKlTUYegq7ekERyPdXGIZXdBywhZ8ao8Q7Ikfw==
X-Google-Smtp-Source: AMsMyM6OmDm5JLRbBgRu649DZayk9rNcoLdssTC0WnZ1PiM9RebJDA8TA269o8C4w/BaRm2nHDaHmJfeCM/QsVkv0jU=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr56020551edb.46.1667916255780; Tue, 08
 Nov 2022 06:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20221103181051.26912-1-quic_bjorande@quicinc.com>
In-Reply-To: <20221103181051.26912-1-quic_bjorande@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 15:04:04 +0100
Message-ID: <CACRpkdbp=7qDYSy1cYX3J9J6BgUdu1pwgkxd-Jem5r2t=C96gA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sc8280xp: Rectify UFS reset pins
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 7:11 PM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:

> From: Anjana Hari <quic_ahari@quicinc.com>
>
> UFS reset pin offsets are wrongly configured for SC8280XP,
> correcting the same for both UFS instances here.
>
> Signed-off-by: Anjana Hari <quic_ahari@quicinc.com>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Patch applied for fixes (looks to me like it should go into fixes
at least).

Yours,
Linus Walleij
