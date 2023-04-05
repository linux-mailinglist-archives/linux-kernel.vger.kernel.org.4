Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8211F6D78EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbjDEJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbjDEJx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:53:58 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CCB59C5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 02:53:57 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5419d4c340aso666155107b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680688436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iOSArHk024MTuP20+LfK+TSvK8bw9LtXROoLVLejjk=;
        b=7Uhb3WdWDVsf6TYFe+umMn4wDTRYNHiTsp6yIjkcoLw1p1l29pM7WBJ+zVMXhUxiVO
         SQO/CIrJBNske5zK5KEWcDWbfCQyjxXDOYX11DjJMvBID3Ab9xoi8VxMKHrwUm/NFJUr
         Cw3fTVW7kcZOTsSzLVL7195o404s3Epv9UQC8tngCiX57FYxqsHOGZiSdWsT/n7dU2Fh
         XGTW1qow/H7Qj0A3OOtckT3HkZ5e5zB83WaZsle70oQvMQDlJLMrSQqfxN8ObRrkg4Dp
         wQXrSYee3501or48hdVKDtLOKW46fCozI31k7KRkKUnWbgvKRZmhOLctJhJ+yfXP8yw4
         RR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680688436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iOSArHk024MTuP20+LfK+TSvK8bw9LtXROoLVLejjk=;
        b=I2uOZbG6aJ0fq433MDDboW1uRf1nDlPXjS1au3f2EqXBEur9fyyEBbNMs1AO5f7Gsy
         mc0FMD2qYQbXsfGxmBF4hfUTPRvN+S18jtKovh9HbXPm3qgzdPxPs7LbCPGn4Dz5BRSL
         DXY6lRDzgVygLflaixjuLXv5zKj9bpJTsRfyrWBLue6nHejXM3sJuoZGA+MAXP42IG2s
         oaHVogRUs3WmomB64oJFbpwYP8WP/KvILsVJ6uDf25Cud3fa5hW41L7QNTQwdB89Bbtc
         YtSxP9+Yr8hmUqFdGdXawmIJM+bH4peJcp/QGoXdDW+sHIXuUHN0AarwZA8dEO1UTHIU
         1iKg==
X-Gm-Message-State: AAQBX9e/pC98wHoYi3+Vgw6FZnqOQlQwCybtrsOfWMm7AXiDUelNPQvB
        4lTA7iUupxOZbyFzNhY6SCNvGbIdWSAy4FYmvDCKbQ==
X-Google-Smtp-Source: AKy350ajegbH1cuY0qZ0BH0n+8kNh3daZf3iUgBZUAQloEazK8c1dLkyVfoFXBAExarPcPJs42OwNyuAKjoJ5gK5rTA=
X-Received: by 2002:a81:ad0b:0:b0:545:3f42:2d97 with SMTP id
 l11-20020a81ad0b000000b005453f422d97mr3195246ywh.3.1680688436322; Wed, 05 Apr
 2023 02:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com>
 <20230207-iommu-support-v2-10-60d5fa00e4e5@baylibre.com> <9847bc48-c96c-3599-e876-bcf9ebf1522e@linaro.org>
In-Reply-To: <9847bc48-c96c-3599-e876-bcf9ebf1522e@linaro.org>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 5 Apr 2023 11:53:45 +0200
Message-ID: <CAFGrd9pBdaHLGUZHkaz2_XKafyX=dxu9UckQxrphg52EG=A1SQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] memory: mtk-smi: mt8365: Add SMI Support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I will move the driver patch before the DTS patches in the next version=
.

Regards,
Alexandre


Le mer. 5 avr. 2023 =C3=A0 11:43, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> a =C3=A9crit :
>
> On 05/04/2023 10:06, Alexandre Mergnat wrote:
> > Add MT8365 SMI common support.
> >
> > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> > ---
>
> Why the driver patch is after DTS? Driver code cannot be mixed with the
> DTS on branches/repos, so such ordering suggest your patchset is not
> bisectable.
>
> Best regards,
> Krzysztof
>
