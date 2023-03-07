Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D416AF6F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCGUww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCGUwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:52:51 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DB3AA73C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:52:49 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id i6so12715657ybu.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 12:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678222368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtlzL8PevPLLFXmTlyBP00LAI0VoVwlqLagNnjCZdv4=;
        b=fdlVTqePrrMgmLA0JW6a0Ng4I6EcBFnbxzj1f8rvz9FF7sq40JYQC2DdqpIRaUXwtF
         41DGdXVFgMYIgg/CWadBAkKsiFqZVJDRVcT/G0T0TAkyR2d0ws0jMh8wEQEqQRgq9yoc
         U7COOaBe3VbfqlYczUr2DLpZa2xMBTTfH6ldU7N7JBpUakNOmIgXBMWu9Ffvx/K9Au7n
         VcvKRlDOWPOONtVpSY34SZw0r/Gm2NlMNU77Ll1Hc+M/jMXuZB8+VXbuyHJa/Ox0ZOHE
         Fo2MsvQV/i9CeqRz3ko4u+oTQvEjguxWHtXDnT9NJepNOKFsju2F4Q0Q/HJbvVbtJAgq
         inGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtlzL8PevPLLFXmTlyBP00LAI0VoVwlqLagNnjCZdv4=;
        b=fi88Db/t8r5d6/p3gl1eBLp5VEpBgPkv+kP7/GgSNFBYjlLp6Tg4I7UuZyabtxBlbF
         6i4VdocwJvIUOGdBDlvVkKzaHvrCbk+E9Nu0f3cyyG+MeujqL8ZdATqNh5LvaKHKWnms
         zJS40RIFoz44je9nKEwEAxBMMoHYSB+wtX5XzU9Pr4TJi6uJ3PSR/8opT2NzgZ7XSKdc
         O0+0XlvVn0+2YdgHmI8CPWOMOMS9EMezqmLnYkNbn54yRBDMtfs6r4QHQ309vSbX3obc
         P5nt0aKLldVv6l+BPPK7jzx+sTMu37yOxENq57InpTbvvyn10bZm/ZIjRx1pTeqajuBO
         2kMg==
X-Gm-Message-State: AO0yUKXd1QzONL+iKBSjmb7jUkKLdobSdu+hzOyFbAQhAzRF29CJQQ6s
        MZqe6zjdN/qWCbpWKOwH3yvgDsZ4ezTzyIySJkuXELAmCYwXEzz0
X-Google-Smtp-Source: AK7set/rWOufzYEq91GvmMEo7+BJ2m+ocGgid3S1JGWCk/qBjg1hP5yymE1zHmoD9Uvh4Fqvigk7F62XPCO37pxDjKI=
X-Received: by 2002:a25:9281:0:b0:b0a:7108:71e9 with SMTP id
 y1-20020a259281000000b00b0a710871e9mr5325940ybl.4.1678222368490; Tue, 07 Mar
 2023 12:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20230307133735.90772-1-daniel.lezcano@linaro.org> <20230307133735.90772-5-daniel.lezcano@linaro.org>
In-Reply-To: <20230307133735.90772-5-daniel.lezcano@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Mar 2023 21:52:37 +0100
Message-ID: <CACRpkdYqUHVkdTwfoQFLM_mkkb8XkUA1FN8=h04BpioDdQAL3g@mail.gmail.com>
Subject: Re: [PATCH v1 04/11] thermal/drivers/db8500: Use driver dev instead
 of tz->device
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 2:37=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:

> The db8500 driver uses the thermal zone device instead of the device
> attached to it. In order to prevent the drivers to access the thermal
> zone device structure, replace the thermal zone device by the driver
> to show the debug message.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Yep that's the right thing to do.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
