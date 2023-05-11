Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FB76FFCBE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbjEKWi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbjEKWiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:38:20 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BD97D80
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:38:15 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-335d6260e9bso343375ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683844694; x=1686436694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=eejqH/9O92EsPm8qWB0tudYgKhmb4VqybKPOzBG+lTDIcmvCNyDudD6MeNPmr7j49k
         uXR1u6U85Xpd55ege6fODvCYJg0zP0TF96UhDoTd0rDqfQzgJuODfYSUB/t8uuqVVjhy
         mHFYtthhyiYQbwHWQpCmKHINKf19mzv/Vrp98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683844694; x=1686436694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=JjfcMF4vPlJ1p9VgLxcmD7NcG3x/Yp0rjF3peKnICSkpeoyT1e+nz4g0FoZIcNvqOR
         PGcGhiLa8TzaFV0jP+ZLsIc6AZq6E90YT3MEIaU08nGCTJ7ErWUQdJiyvirl+WIIRE1t
         CAKKjYh4nDt2Yo7vXDepO26iBF5D1jO8qUCbEp7N0RLfn3GUjUIVnEn1bhsmLkar60TQ
         HLariE+3iRWEn3W8n/4CDMu3dBz1qTmmqYWEHJfCrzL7Sl9GdozSZBxQjJl0thY1KQ6M
         dHZBtOy9OnPIXw6+t9y5b3RmVrvT0LIEq/zmft/BfAPw0IE725zmlhche/wt9JJMWwx8
         8rOg==
X-Gm-Message-State: AC+VfDw8NfTqJESc/MdlJM/qH5LzhfzOw0jqJXIPWX1YKKZKiTM6BAUf
        UGkxlc1oOfIUAnie+302cSo/e4WKWMcMFGyzyaHpNw==
X-Google-Smtp-Source: ACHHUZ5WTdU3AW+XrAoPVq2lUePuxoUdj1Fob3vdUdL637VkgTu6Cc7qeyKA7QvxdOi9A9liBIcfGEf9zAPH4dxzyuI=
X-Received: by 2002:a05:6e02:1b81:b0:32f:7715:4482 with SMTP id
 h1-20020a056e021b8100b0032f77154482mr123404ili.4.1683844694484; Thu, 11 May
 2023 15:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
 <20230511150539.2.I88dc0a0eb1d9d537de61604cd8994ecc55c0cac1@changeid>
In-Reply-To: <20230511150539.2.I88dc0a0eb1d9d537de61604cd8994ecc55c0cac1@changeid>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 11 May 2023 15:38:02 -0700
Message-ID: <CAODwPW_amsFd2a57nv5WqXknp6o1QPvXD5tVmsxZdjMHsTjg0Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] irqchip/gic-v3: Disable pseudo NMIs on Mediatek
 devices w/ firmware issues
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wenst@chromium.org, Eddie Huang <eddie.huang@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Tinghan Shen <tinghan.shen@mediatek.com>, jwerner@chromium.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        yidilin@chromium.org, Seiya Wang <seiya.wang@mediatek.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Julius Werner <jwerner@chromium.org>
