Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFFF6F41B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjEBKfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBKed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:34:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8824EED
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 03:33:49 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24dea6d5ce8so2776706a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 03:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683023629; x=1685615629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+fuCCjs/TuYV/kdxEssyG9fBViHn9SkyVnmjJ20wEqs=;
        b=af2cIXWlSqt3grnqXOjULu9dBmX6JlyAsdsMzZ2ah5y8Bg7NJV8LrvhRgsF++6JiOJ
         GHKBVYgTXvPo0u6l4VWjHP61F2l0pVb0QN1LFhzmHPnIBaVAlgjfFO5mFKToFii46g43
         YD8RunEGDJ0ju6TNbSmVlwCIHiLQ91ONmioPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683023629; x=1685615629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fuCCjs/TuYV/kdxEssyG9fBViHn9SkyVnmjJ20wEqs=;
        b=H+0yIJAYQAI6IyaXddf2lgyFzuElx2Em2mIHsY6BXgcu0ia/cYyu6NN72AH5w/pN9h
         9V3pfmMg4yxtl1rXA4FgEAheCnQMLgzdGjYNGgJjimZUv7zyDDWizqk8yQNCnc3uBJri
         WmvSoPlW+ByMMI9oXGgx6cKSNmDTHjE+7X1dGVlwDI3ySxZV22P1w2xbmGhA2vFDqUcG
         LIBS6HslPyOw5SWPXVMue84AC8y2vaAyyLVZ3EtM1fpOHFgLMgRIZN7usg5g5rEog6GS
         NgoOlaPWZ8VXea2JwMFUtPosV900lNZ6sW33JWj6buQ08uwWKDHrxsg/ZQuoarJFnOm9
         0Xaw==
X-Gm-Message-State: AC+VfDxsg9Frsgye0BF44sftUu+hpnw7vjz5/5SH5RkhvL3jchGe4W2X
        sIXNoSNHKkhNfAE5YByv+TluRg==
X-Google-Smtp-Source: ACHHUZ7D5b++XGhn6qJsIBk064qWgKtkGNwvj98P5C8vUDm8zn+JHtAlSMG7N3iifFpFnF9FClShVw==
X-Received: by 2002:a17:90a:8182:b0:24b:6d50:fed8 with SMTP id e2-20020a17090a818200b0024b6d50fed8mr17168034pjn.24.1683023628961;
        Tue, 02 May 2023 03:33:48 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:b873:4627:7ea:a0dd])
        by smtp.gmail.com with ESMTPSA id y23-20020a1709029b9700b001a69c1c78e7sm19465521plp.71.2023.05.02.03.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 03:33:48 -0700 (PDT)
Date:   Tue, 2 May 2023 18:33:44 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>, kernel@collabora.com,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] thermal/drivers/mediatek/lvts_thermal: Fixes to the
 interrupt handling
Message-ID: <20230502103344.GA3388518@google.com>
References: <20230428195347.3832687-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230428195347.3832687-1-nfraprado@collabora.com>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 03:53:44PM -0400, Nícolas F. R. A. Prado wrote:
> 
> Fixes in the interrupt handling of the LVTS thermal driver noticed while
> testing it on the Spherion Chromebook (mt8192-asurada-spherion) with the
> MT8192 support series [1].
> 
> These are standalone fixes and don't depend on anything else.
> 
> [1] https://lore.kernel.org/all/20230307163413.143334-1-bchihi@baylibre.com/
> 
> Thanks,
> Nícolas
> 
> 
> Nícolas F. R. A. Prado (3):
>   thermal/drivers/mediatek/lvts_thermal: Handle IRQ on all controllers
>   thermal/drivers/mediatek/lvts_thermal: Honor sensors in immediate mode
>   thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts

This series seems to have solved all interrupt storm issue I ran into, so

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
