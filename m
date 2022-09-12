Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1D75B6147
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiILSs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILSs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:48:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374D2186F2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:48:26 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bn9so11646168ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ajtCtNcs3weh6Y8N5o6lcKpUrALT4dcANWcW4NXZ6zE=;
        b=P/NMHCqKPibLKjl1SPZZBdBqH5dotxf3enKihGybHwv8/O9ykWM7srH1b9b8iLpPBN
         IHQYSEVR3ajiMG7+YhlxNjQHzfwRFVAF1kZTQXAEtf5CD268GiBdDD8L1d1RayQcAon3
         WtUH8cY8xntBhhBWcy/KN/D2nZyA9FyjM+/dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ajtCtNcs3weh6Y8N5o6lcKpUrALT4dcANWcW4NXZ6zE=;
        b=cf9zuJ3uVKESVdGcq+xQ8flQSWOoI3zyuJQ9sT3PIP4L5EIn0YpV9M5L1aHuZiy9AV
         YrVJAFG1RfKX5XNv6YOQU34bD3uiH78syyVNU14rRVKDzvkSP2YEYnaotpQl/5y9SY08
         yaVspSZGoV29HLtCZzdkIIPoWCECu/Y8pRMsKbdSqGfQwcPilShPNQtWPS5jSsJM97L1
         FRW3TdS/+FMmbv5EDDazdDpWlbHwsbGEJa9HBvQZdexnwV4YvOtELGZjLyQs/a9HKTmV
         Y3Hjsamnug1Uugjtn+0aTCHhIrDEqyGBRG/IfNgfcDH2T3q10kbRh9EI25VV84BRhoPE
         MzRg==
X-Gm-Message-State: ACgBeo3nkrM5RKvU2mJW46ZRk+L+nND9g3+l89QYaqdKlu0yWWlSZgOR
        U5XX9YJptaSuDWO+fEzbKAlhGvRcW0j/ZxFH
X-Google-Smtp-Source: AA6agR4jfrl0u0CYCDajikJNDklPzRlNBu9qDoYkG6jpDgorO98pIWmzEbIsI2q5HgaYB1sS/GulZg==
X-Received: by 2002:a2e:2244:0:b0:26b:e1c0:8ae8 with SMTP id i65-20020a2e2244000000b0026be1c08ae8mr5138818lji.146.1663008504368;
        Mon, 12 Sep 2022 11:48:24 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id o7-20020ac25e27000000b0049aa7a56715sm749751lfg.267.2022.09.12.11.48.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 11:48:22 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id f11so16327280lfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:48:22 -0700 (PDT)
X-Received: by 2002:a05:6512:2303:b0:49b:ec39:c4ab with SMTP id
 o3-20020a056512230300b0049bec39c4abmr103166lfu.512.1663008502265; Mon, 12 Sep
 2022 11:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220822180729.1.I8ac5abe3a4c1c6fd5c061686c6e883c22f69022c@changeid>
 <CAD=FV=W5X2XvvKT5tq+1ywJSmVB0TAHquGgn02uNmn4s-sqndg@mail.gmail.com> <CA+ASDXMetKHtL8Hm_=S7xPcHX19FDaCoXtHmh=E6i6pLEXQZ0g@mail.gmail.com>
In-Reply-To: <CA+ASDXMetKHtL8Hm_=S7xPcHX19FDaCoXtHmh=E6i6pLEXQZ0g@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 12 Sep 2022 11:48:09 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOMYGgaJSrxQUNFhN+9qT-kfedk_UJJnOO58iJpWdxu1w@mail.gmail.com>
Message-ID: <CA+ASDXOMYGgaJSrxQUNFhN+9qT-kfedk_UJJnOO58iJpWdxu1w@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm: bridge: analogix/dp: add panel
 prepare/unprepare in suspend/resume time"
To:     Doug Anderson <dianders@chromium.org>,
        Zhang Zekun <zhangzekun11@huawei.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>, xuqiang36@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 11:06 AM Brian Norris <briannorris@chromium.org> wrote:
> On Thu, Aug 25, 2022 at 10:37 AM Doug Anderson <dianders@chromium.org> wrote:
> > Given that this is _not_ an area that I'm an expert in nor is it an
> > area where the consequences are super easy to analyze, I'm a little
> > hesitant to apply this to drm-misc-next myself. Ideally someone more
> > familiar with the driver would do it. However, if nobody steps up
> > after a few weeks and nobody has yelled about this patch, I'll apply
> > it.

For this particular patch, I'd be interested in whether Zhang Zekun
has any feedback (even a Tested-by?), since they were patching this
function in the first place, which is why I paid attention:

Subject: [PATCH -next] drm/bridge: Add missing clk_disable_unprepare()
in analogix_dp_resume()
https://lore.kernel.org/lkml/20220816064231.60473-1-zhangzekun11@huawei.com/

But in absence of that...it has now been a few weeks :)

I'll also mark this to come back to again in a week or two, in case
somebody is still hoping to wait longer.

Regards,
Brian
