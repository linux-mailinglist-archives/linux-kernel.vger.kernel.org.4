Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5395060DAF6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiJZGJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiJZGI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:08:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443AE5924D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:08:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f37so26582804lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AQkFYRMFfXcuqnRcd5m+fYI759MoxQcwxUzEDkbo1SE=;
        b=weuKcUHywG8ZesBbFANZ9FB0o9RqWvSCMP2tlTH+iTy81QUj/HHOydfK9fF46TXkVV
         hn0aoQM/4wY04vxz/lHIFwW8KpuP1rJROqiGCoCmlxHUCgJybETGbvNzcdvbbq2kTfBd
         FUwTqq+1dctUt2C/B72NWmH5BBJNErQ4i29z+/Sbn1dokL3edOjfqUuRiySRiQYSfMwS
         ewLEzfs3QpAwPY+THp+zKuWET4/axtn4NnR+16aBdXfrXHu0QlXEgqKETc3e38lCzt7l
         vL2ktf2IbcZbzjQNXA75f3nNvrX8hcm1dDgtZb1vAY+11heBsAfYwhdXvb1ebsRQvR8G
         RpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQkFYRMFfXcuqnRcd5m+fYI759MoxQcwxUzEDkbo1SE=;
        b=wRPPwij0U/3tBorN3+XwFsxd8sSYl9Z5FhxN8P4N7Nn2gu9dBNyNLd4FoHg7dDnpUB
         uN5KfGmHuIh10WrSG59Ec7XqDeA4AgGdMTXGc7ZASvw+It0qZ5MEM2mX5kWvVJDqrzZO
         ZXdwlUnHsSclN2Vsd6dyYTwXA3UP6qwnoQBOI5QiZcgWspqvvSKOwpB+cn0DDJTK5+cO
         BqQTET1OX3xqDxy/GUeIaX2RWWbWxlzgZhCUj5r1baK2aOLqEuGgdGWHYm2saFRTVTda
         XYxqNZ19OMaww71GmO/SnoSVrhBUGcaSfrI3QPz/012fU0CB34+It9yXBkmTYPeLPpM6
         gIzQ==
X-Gm-Message-State: ACrzQf3cJtKbYK/yhmq15V+OLsk9C1v2S+NnrBT2Q59sNKPIrDwhr48B
        rXZH34++HL2S9PaiaAmEWuT5Jw==
X-Google-Smtp-Source: AMsMyM7aBlusqzl2oZMMOP75nbW9SLTYRVvCS1Z9KkDA0+hM7L4qVTHgav6Vj9SBZUpunCdpnGWYEA==
X-Received: by 2002:a05:6512:108a:b0:4a2:7ec0:2fb7 with SMTP id j10-20020a056512108a00b004a27ec02fb7mr17134312lfg.553.1666764535618;
        Tue, 25 Oct 2022 23:08:55 -0700 (PDT)
Received: from [127.0.0.1] (85-76-42-158-nat.elisa-mobile.fi. [85.76.42.158])
        by smtp.gmail.com with ESMTPSA id e11-20020a05651236cb00b0048af3c090f8sm726299lfs.13.2022.10.25.23.08.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Oct 2022 23:08:55 -0700 (PDT)
Date:   Wed, 26 Oct 2022 09:08:49 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
CC:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/12] drm/msm/dp: HPD handling relates to next_bridge
User-Agent: K-9 Mail for Android
In-Reply-To: <20221026032624.30871-10-quic_bjorande@quicinc.com>
References: <20221026032624.30871-1-quic_bjorande@quicinc.com> <20221026032624.30871-10-quic_bjorande@quicinc.com>
Message-ID: <5974CB5A-699F-4768-9DAA-FAE507CFAD53@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26 October 2022 06:26:21 EEST, Bjorn Andersson <quic_bjorande@quicinc=
=2Ecom> wrote:
>From: Bjorn Andersson <bjorn=2Eandersson@linaro=2Eorg>
>
>The DisplayPort controller's internal HPD interrupt handling is used for
>cases where the HPD signal is connected to a GPIO which is pinmuxed into
>the DisplayPort controller=2E
>
>Most of the logic for enabling and disabling the HPD-related interrupts
>is conditioned on the presence of an EDP panel, but more generically
>designs that has a downstream drm_bridge (next_bridge) could use this to
>handle the HPD interrupts, instead of the internal mechanism=2E
>
>So replace the current is_edp-based guards with a check for the presence
>of next_bridge=2E

This does not sound correct=2E The next bridge might be a dummy bridge, no=
t supporting the hpd=2E Please change this to use the enable_hpd()/disable_=
hpd() callbacks=2E This way the drm_bridge_connector framework will make su=
re to enable hpd handling for the bridge that is actually supposed to gener=
ate hpd events=2E


>
>Signed-off-by: Bjorn Andersson <bjorn=2Eandersson@linaro=2Eorg>
>Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc=2Ecom>
>---
>
>Changes since v2:
>- None


--=20
With best wishes
Dmitry
