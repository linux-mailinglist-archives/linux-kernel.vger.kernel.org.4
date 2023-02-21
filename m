Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D9A69DE81
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbjBULLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjBULKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:10:39 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F2D2687E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:10:17 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id e194so4334890ybf.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wgIp62pzwCObd0eefLyPJFxxjkrzYi1dSStE7mQL2AA=;
        b=M+mG5uA81xf5aCvrdEKImP+VJGXmDOoJqSV+r/Np9pAPGarh/3KigKLHAJduKrCRrX
         yfJAUE+hTAKS4vY7r8f5gvgY/CCnf51ekJzzaqpFUufySN7hmYPkqflap430IybImOOV
         bysqaiyN8VG6pdJTvCkgxh5hG635ywJ2G1YnNDixu/CS+86I97Ku+HDjgDeTo+cO5bUz
         uLh4nS++PloEufwI+uVZIg+qkue9hI+AVhJ2h+utR2qlu49BI66EA7YwwwQuWRN3HxZg
         qEnQRj4XxbadSrvYNlII99cbV/eSB/63sjPluNknszurQNkgnBShrbyuPI9O4DUKberX
         c/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgIp62pzwCObd0eefLyPJFxxjkrzYi1dSStE7mQL2AA=;
        b=wzvlWUx+QcHyNcX3VTQg89gr7RLuhbnXi167wb1P56pdKd6o/yiIbxZ1HwB3R/Apq/
         mdlZutoKCg/bdt+o9IU16B46zPMTH7YIXm4zOSj64cT6z9OzfzdtElaU7QppsAHTCek+
         T7RjfTSgnEIKntdBdY1Oub4VTMNSnZ+4XUcDnc0jLQP0mYkJOv6T7K0xzMCL48up6R/X
         N9r322VotQUohZzYvoRVS2Fq7xnmPyZBnSJOTFh4AJl8b4yhUsPFowdE1oEFda5Qo8MJ
         qKe1Kj/oyRSvYKJUDjjYbmpgyc+Oi4EMX52zfViW3OsL3frchpoBclqbgt4X8lDKils2
         PZ2A==
X-Gm-Message-State: AO0yUKXGgNDBAIL8xgzeI3NG8WNmOpcA7dLdOmikq28nllG1EFvAxNjM
        Wa2pUr+M9baqxL5NIqlU1rGt03tYcYGaAyYjhW0B2w==
X-Google-Smtp-Source: AK7set9bxLWCg+I02dYRE6AtkeWcj7QVPcohWSsIO7j40qyvzrzqQVQ+iv+8opivluVMuJWItWi6KI8Sggt391jf/lE=
X-Received: by 2002:a05:6902:10ca:b0:9ed:13e9:fe68 with SMTP id
 w10-20020a05690210ca00b009ed13e9fe68mr366317ybu.3.1676977816195; Tue, 21 Feb
 2023 03:10:16 -0800 (PST)
MIME-Version: 1.0
References: <20230221094207.102006-1-balamanikandan.gunasundar@microchip.com> <20230221094207.102006-2-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20230221094207.102006-2-balamanikandan.gunasundar@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 21 Feb 2023 12:10:05 +0100
Message-ID: <CACRpkdb65OondM07Uje7UWy3Gc8BDT2eFg=tjE1diELxFJNaUg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mmc: atmel-mci: Convert to gpio descriptors
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmitry.torokhov@gmail.com, ulf.hansson@linaro.org,
        hari.prasathge@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:42 AM Balamanikandan Gunasundar
<balamanikandan.gunasundar@microchip.com> wrote:

> Replace the legacy GPIO APIs with gpio descriptor consumer interface.
> To maintain backward compatibility, we rely on the "cd-inverted"
> property to manage the invertion flag instead of GPIO property.
>
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
