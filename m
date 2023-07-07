Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3F074ACDC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjGGI07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjGGI06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:26:58 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C642990
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:26:54 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-47e3c76fe7fso597623e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 01:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688718414; x=1691310414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EboC65fgWAREYtxWfvNz98ia50RkMIl0KWcP+vppEMk=;
        b=KRHd5WV78gI9Ca6CIf7kTwe85HlLrHDZxoiMCI+Dxd2cjcar/yfhTI+IPdBDnVHfiY
         ABlnd9FB3Wqyr7tGadQFyUfw4q8+HEMY+8YGG2AEgIKl5+chkm+W2zG+gyBKK9NhdL1q
         A+mmr7TPfY9U7+5aTmbXkwxFahxxnADr6Xnzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688718414; x=1691310414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EboC65fgWAREYtxWfvNz98ia50RkMIl0KWcP+vppEMk=;
        b=Nrg0lVg3041fvoK2BqGqem2uA7Am2SQaBTpRQWujQjAPyqYhP8G8v5o+vsOf6fmK8x
         CEio7Dptiq8D7uOdmUf5VVsDcJ34LZqvnnZEZAAdI6vfTeBHo9wSVurvRIGGTpKRXkSa
         cOXXMY9CRl9W2Oq5YQyJbptMcIF30eYzv4dyZ4VSKz9IY563r3G7xVQp0QA8V1gl+NLX
         0q2GeAp4O0mYHMt33ifSgcUistAP0Vo3QyRl1fR1xcmoiU7gCUCai5WiFf57OMRfHkxA
         W45U/OD4pYa4vEqngL72AX1GnctzFXkjFNQNT5Yw9mJOSIksKnDnaL7pWDaZiwiUwzrM
         zczw==
X-Gm-Message-State: ABy/qLa96tYOuzRABHKxcdp5hL1uTdhomSgHmYGwRs9FYGosEcKQ9lX5
        dD+M35CZaQepvdCX2losJliayii8ww3zdm1YpAdCw50eUSFZLD6P
X-Google-Smtp-Source: APBJJlE7GDj1D77CvDfV4hOrxhawtbrbW6xhmVurbRx9ioCi4uqonWC0D1PInEw++SDhnLSuQiuC4b4wrc6mEO4lKNs=
X-Received: by 2002:a1f:5c05:0:b0:47e:19b4:85e9 with SMTP id
 q5-20020a1f5c05000000b0047e19b485e9mr2901372vkb.0.1688718413876; Fri, 07 Jul
 2023 01:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230706101100.75654-1-frank.li@vivo.com> <20230706101100.75654-7-frank.li@vivo.com>
In-Reply-To: <20230706101100.75654-7-frank.li@vivo.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 7 Jul 2023 16:26:43 +0800
Message-ID: <CAGXv+5F+FEtAoh0hs8Ld5Bz=3zvCZHSQ45v-oBGRZnv7KeNaxA@mail.gmail.com>
Subject: Re: [PATCH 07/11] media: verisilicon: Convert to devm_platform_ioremap_resource()
 and devm_platform_ioremap_resource_byname()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 6:11=E2=80=AFPM Yangtao Li <frank.li@vivo.com> wrote=
:
>
> Use devm_platform_ioremap_resource() and
> devm_platform_ioremap_resource_byname() to simplify code.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
