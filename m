Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AEE605EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiJTLdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiJTLdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:33:49 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F521DC4FD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:33:39 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id p4so8761642uao.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HI1FRH7blO+xw/GktEIJ0NsQy6zVWD7UBE+3VS4ReY4=;
        b=AiUkVxm/esQZx72s8pLSfHtC3JCaF+nIMbndIdS77xLgY8QQgRIMr5LUimt6Bk1rUV
         AMDVLiMIe58nnz87SXa0P2Fayc+l53siWy9eTSbwRdCHQLnVWmwekMXaf65d/jnVo71G
         DtvETYWSc33op891xH1cVdzzcxOvVOc20m7RSt8GxfWTrqwAIloG1hon2lW+F3Uv/Rhy
         P4xo0gkrWv+wImfHFCaLfPu+rO/E/z1phv1IRdtqTWUgUhShOo5cXyQMEu/4juPlewu1
         PRAn8NcDC1xnhyspvnnxtRbQa4oK07JuZJWHS8SFskwcrhqx1ayY5AYz3C9Ac6LuW61X
         tznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HI1FRH7blO+xw/GktEIJ0NsQy6zVWD7UBE+3VS4ReY4=;
        b=FgKU8Jd/d62N6WKfVtNpJ9MWgifCndvGKIn8lpjHaLwimHI6uzZuoefmXkFt9Ru3JP
         DAdh77hZdW2GcaEk7ve17L+JxKv3kDjAw33ak39+8NEQqTmnc6KQPhlNAM1gknVrmqMR
         bebXm281t0nHCYZkiQTLDDUaxz8Te0m3bHAyquKz/X6W4UJVoAgOeEhS2jDWOhSqNq6/
         sLU6tVHHUddptG2r3ikhVq0M+22as8uTqcUHUORq+f7RoIYa7UXOyY+6BUuQxhL3g1Mk
         9hf243mDbXQ4/LWsWjXsSQdsIadTSyQAr/prN8xCx6WPPSMO7z3PnVyfl5F4mCX0HJAZ
         RYLA==
X-Gm-Message-State: ACrzQf10hShLfvznD2SmA7FwW0XZNdszEmVw1pnyyPbjANkB+LOIXini
        NmxomqN+Adl7pDuvTYmx1cbR5pbCET22rPPmuF3iLA==
X-Google-Smtp-Source: AMsMyM6NeTneSGXzxRaLdGSNRBb+kTu6k973JEV7pFe6l9OknX2laq35vfhVvZh8cCRvUQ7IsnuO71NnmkFR7ASq4rY=
X-Received: by 2002:a67:ab46:0:b0:3a7:d2b6:121b with SMTP id
 k6-20020a67ab46000000b003a7d2b6121bmr6228954vsh.16.1666265618281; Thu, 20 Oct
 2022 04:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-13-arnd@kernel.org>
In-Reply-To: <20221019152947.3857217-13-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Oct 2022 13:33:27 +0200
Message-ID: <CAMRc=McGcnvWybgYSiRAPg3fMv2ZYnmcsJXMq8qt33NeTA8sDg@mail.gmail.com>
Subject: Re: [PATCH 12/14] irqchip: remove davinci aintc driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:38 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The aintc driver was used on Davinci DM3xx and DM64xx SoCs, all of
> which got dropped from Linux, so this driver is orphaned as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
