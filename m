Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADCE5EC74D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiI0PMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiI0PMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:12:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A1100395
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:12:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sd10so21422429ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rIT3T5nfBfgdp3S4can3yr3bG6afRaMGveOO8LpJvUg=;
        b=IhYS23hpFcbaqZ/GqGoEc1aJLXR/HRxP6hJ3bg3cz4cFAyBAS4m86GpiY63Uz6cp4k
         +cDxOVK589bGTZR6jQTIWkOpxy0lj2J5bUo9eIXjqs/FK85lbDWg6Zk/3ExsvFSw7F62
         m7syMyxV6oqDzZji0DSbITIUEFU6ZICV+qB14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rIT3T5nfBfgdp3S4can3yr3bG6afRaMGveOO8LpJvUg=;
        b=cWD9GlgHNOuDOQ1S8+J5MTBf/VWYenNOfTBdLqe5V+2jgJRsmRD8fk23nehY0TuOqP
         cWdS8JG18NkBQh71bxBXGAQyQg/4Nw9Hr5XpqzyKigoamCsPd6oOss/cZH3Hei24OCIj
         JU8vLkgs4MBeYmm7/DvRJXlD2UFU6xpD8M3B3fMoWIJpOtIyP6oHQs3FY0fEMnBbVJLO
         ScO2E1Z5JuYPrsWN9pFcT2z81gT1t7NEwI7onl+KVWql1QbgEuTLjb7hwRrxdKATPI5s
         6RA92CApB7sFmzfDGR90CCFmZT1sgrSMCr813h0R4pCyn0ZJyQs/CQIbYZCVfYWtCY6X
         RVgA==
X-Gm-Message-State: ACrzQf27kk7MDcLFYCB20K+3vHb08oS2wzRgxC49PxTBAIaCcWIZaGX9
        n+ZjfsxrkzFwgNVKeFS3qleP//JM0WV0icdk
X-Google-Smtp-Source: AMsMyM7bmcYzjr890oR/3BzPqhhFVDV81LjyLHhtPw+W+IP4+OCx22BMaJgjb2dm8PO+8IyAKYGpuw==
X-Received: by 2002:a17:907:2e02:b0:77c:5020:b8ef with SMTP id ig2-20020a1709072e0200b0077c5020b8efmr23112618ejc.299.1664291529696;
        Tue, 27 Sep 2022 08:12:09 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709064ec500b00782ee6b34f2sm905298ejv.183.2022.09.27.08.12.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:12:09 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id v28so2652538wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:12:09 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr17074684wrr.583.1664291528783; Tue, 27
 Sep 2022 08:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220927021021.488295-1-sean.hong@quanta.corp-partner.google.com>
In-Reply-To: <20220927021021.488295-1-sean.hong@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Sep 2022 08:11:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X9KmnAkj2PeDWzBYUk=Eq9JH7kcPDubVGOCOQewE3i5Q@mail.gmail.com>
Message-ID: <CAD=FV=X9KmnAkj2PeDWzBYUk=Eq9JH7kcPDubVGOCOQewE3i5Q@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Fix delays for INX N116BCN-EA1 (HW: C4)
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 26, 2022 at 7:10 PM Sean Hong
<sean.hong@quanta.corp-partner.google.com> wrote:
>
> This panel has the same delay timing as N116BCA-EA1. So, fix the
> delay timing from delay_200_500_p2e80 to delay_200_500_e80_d50.
>
> Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please include "Fixes" tags for patches like this, like:

Fixes: 9f4a57148120 ("drm/panel-edp: Add INX N116BCN-EA1")

In any case, this looks OK:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

8397d2984528 drm/panel-edp: Fix delays for INX N116BCN-EA1 (HW: C4)
