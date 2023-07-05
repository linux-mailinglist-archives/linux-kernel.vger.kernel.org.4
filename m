Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0865B74868C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjGEOkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjGEOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:40:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9332B113;
        Wed,  5 Jul 2023 07:40:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so71769005e9.3;
        Wed, 05 Jul 2023 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688568038; x=1691160038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3wT82k64CogVsvKm/oeShAauRdxs/DXUWL2jzZ5ABsc=;
        b=LijYCru3ZrW1OVoiCOXNtdrFSOQzE3H6YRb+LpeLBGY3CtG45lLYWyH2KPemK2/cGC
         QNyE1l8Mh4YUWavOplSN6JD/boqYlmwmStptIthpBnOdjXKD9GZZf8OvrCBkFMbmBEVm
         7TaB+exYnqdW/aCPH0BC+i1aqcE1N/z534KhxYKSvH2T3Q7n8QE0XtTUshRMjkyu9ek1
         VXvY7aYk7jbxgFmijYdCYZGcwQxEDIm59zcPHRHbX4965qesB2PGCy9W0kaT+/whABn5
         SIq/HuXJ+i0zMDCiwW6T34B69wcM5z7cU9rlV+ztlvOn4vnexn6lKvS0BE0BXgHpWwkb
         A29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688568038; x=1691160038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wT82k64CogVsvKm/oeShAauRdxs/DXUWL2jzZ5ABsc=;
        b=WeO18iWUfizxrnABKA2Iz87hsyqfE5bS5mMdlEb5pKUKYcJIsaXATGJqe1IsXq+UNK
         qgchoSPHWGz92eT96Xq7GnAqS/93LLyJxvYfbzTs4C697q+DX3k4sUDjsyGes8kzQU0/
         gK7tq4djAmJt4kcj7t9jMPA+VlvLYMMIpG5yMiid1DXh1CLwQ9PQFQVC7mEjpBntl33L
         jfLl953qqv2UTpyrQ4KEBY60hF7F8OjoqhsWaU60aosMwlhTydknNvzFC/C4EFFkl71H
         FoS4+B3rcrtYygokCXnohu40Ek/9hD/iYbVxN3D1S8r7lYyZHihJI9jXrknX62uGURLQ
         OVlg==
X-Gm-Message-State: ABy/qLadDGBhka9LKv2TpKR/oTpAWNmjc7WZQOZ7IXPW0+tn5L1PRoDL
        Pkc4H/CngU03F22aFb6H6LswAWICLf6szAComeg=
X-Google-Smtp-Source: APBJJlFQ2OcB/cjUiVh/kl/mGdb9L/oqR9gkRGkTR7SKi6eY15M/odtmKtblAvW65B4sZp/3tzIug0pz8TINj3riaKE=
X-Received: by 2002:adf:df04:0:b0:313:eeb3:c57a with SMTP id
 y4-20020adfdf04000000b00313eeb3c57amr13626988wrl.15.1688568037789; Wed, 05
 Jul 2023 07:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230705090951.63762-1-dg573847474@gmail.com> <f7f1ddb5-a4fd-f79c-f870-8fa7410cd0c7@roeck-us.net>
In-Reply-To: <f7f1ddb5-a4fd-f79c-f870-8fa7410cd0c7@roeck-us.net>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Wed, 5 Jul 2023 22:40:26 +0800
Message-ID: <CAAo+4rXP+rckwXqgiROjJwz6f-G-4LGgtDiQ5MOUuJ3ON4-RGQ@mail.gmail.com>
Subject: Re: [PATCH v3] watchdog: s3c2410: Fix potential deadlock on &wdt->lock
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        wim@linux-watchdog.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I am sure you know what you changed in each version of your patches. I don't.
> Please provide change logs when you send new versions of your patches.

No problem, this is the change log for this patch.
---
Changes in v3:
- Also use spin_lock_irqsave() in s3c2410wdt_keepalive().
---
---
Changes in v2:
- Use function name instead of line number in the commit message.
---

Best Regards,
Chengfeng
