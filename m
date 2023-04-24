Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC226EC794
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjDXIFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjDXIF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:05:28 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CE399
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:05:27 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54f8e823e47so45662107b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682323527; x=1684915527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zympgsGXJK0H9fEUC44Mmed4PGvFG4LKfOOmAOBmWVo=;
        b=CFlwITicOUd0drvtoXImi5P+ObED/43JuW+GrEUK00FM+z4l/1sBXlBfgGpFk3fLeG
         8P5m4kpQGtf4Jb7yFj82Wg4l5wpswsZcim6oZZ8EhEpPoSlgR+4JRuz8vmN+CMv4U6sJ
         b9yt1f7s/4scSNHof3THudtGnWLPtSIGecYcF2q+Xku5aPXoLTeN/cf7N0+2ahk+22yy
         YhbuwXzZekIP31wG2XalUfLKMzZiYZaARl8c0z3ZsdYe4ZHR1Os6oYnlgyRmdqNwC/8/
         GL3PaVO71lAGWQ+Vgoh/Y+yEX34fPH1f7q+Lr7zLkcvBpGJeta3Aoh1qK88wrgklxkmO
         /ghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682323527; x=1684915527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zympgsGXJK0H9fEUC44Mmed4PGvFG4LKfOOmAOBmWVo=;
        b=Ef5bivLwTaTwQCrdk7tDJVjq8RHrduIBRmK2HAZkcRCDrU2C1V3c4tZAQMPO1mgTTZ
         vBxGHUZF0idASmy7aRam5F49oiey1VYHU1Bj8wPpOAFwuWziZ6yo7SfSin2UXwawnIYL
         az5l+CHxcI3Cj5+tS0ojCPwBB4joAQxJwjFeJH2YH2Kya3VCEbboycMXX6eWJ0NutGF7
         iLd3NmP2cbqIMGxRe9Tgyse/K2k+Z/8G+NAeiJ9clBcuFhYJa9QRo/P64hMy8SVSpBCS
         FrCeheyMZcFViWpDJZTULM6GHEvhfVo4x1qn5G/taKDYoq5TmfrbhXyjAG6vbGrDmbHy
         Sy8A==
X-Gm-Message-State: AAQBX9fY6vdwnAb+AyJnAd+gdWluPiWm+ubXe5sR+ArcsJfxG7bEcs09
        zvsJG6ghOal8s32E4xD4EQhk+2jF1EuiKvWTSxNq/w==
X-Google-Smtp-Source: AKy350bU3+GRCXOx27f4Xrkltn2TroIypMC/iX0pWtnmX0xp3c9/RsMrEKbvhWeDFm0i6n0B2GZoVlwl9D+D7MfgV78=
X-Received: by 2002:a81:61c4:0:b0:555:cbdc:c6 with SMTP id v187-20020a8161c4000000b00555cbdc00c6mr8250272ywb.9.1682323527184;
 Mon, 24 Apr 2023 01:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230421091319.79744-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230421091319.79744-1-yang.lee@linux.alibaba.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 24 Apr 2023 10:05:16 +0200
Message-ID: <CACRpkdaKHkwpdUvYq+usSOmQ8q=WTyMpFLEswpHRaW6qryYVxQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/tve200: Use devm_platform_ioremap_resource()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:13=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.co=
m> wrote:

> Convert platform_get_resource(),devm_ioremap_resource() to a single
> call to devm_platform_ioremap_resource(), as this is exactly what this
> function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

That's a nice optimization.
Patch applied!

Yours,
Linus Walleij
