Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3E6B4CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjCJQ3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjCJQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:29:13 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1507412C82C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:25:48 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso6443241wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678465546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uTjUs+xSTpJmpUXPUZmeFM9CvRhlnvmm+hubfgWSgEg=;
        b=g5Nt/cxAmxf+NZwUWDMIdt5tWqPfaOO6REhuI1HwCOHDbEAfiRzqmh+lDYJsSg+8Ak
         5aYZCzsx65lYjHpnSlSW+OHHzE9zzNCHRDddObmupVAJYaVR6ceqbz9did/iEl9ixr/X
         VThVU12E5C4GdrsDexkcjzJind3/UqD2vI7l8mvmfza630TbsQXMhDPPzv9qQejdo3I9
         S1yBpVNNU1pfUK3VMjDPEUSNPYqy9CGQFQonhVtUAFiz6PZ36oatbpxvuk60TqrJtSzU
         x3+o9Qi0sNeohOIyY9kmELThNVMy2SXA13ZqPbYT4rZ6Si8wifo9+gV6QKZCbBakcE/c
         GU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678465546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTjUs+xSTpJmpUXPUZmeFM9CvRhlnvmm+hubfgWSgEg=;
        b=le7rIs32BFIpKBRVBHqYqoWyIg1c2EO7Vhewhf6h7b4wLpnvQxm4iB7HS+t2G7xYJD
         YmLa5b7PLVfpRmISx859Btxzh3nNEAhl0wzxfoEBzwdEAVy0Rq4SXUQLTvfs/NY9jZeS
         tln0u/kI2Qluzv21wbVXANc0ujq+8IVx2DY0d3ngXqwGpa7r5VQ4Ve39jexhBYy2EBeR
         2/cRLN5+C9rCBJQMjVIzLbiBQKZCDJuSzuzvzs8ypI/spTrzOt29yiSZEPNsK1nRm8mI
         ioNQ6pA9s1TLtcXe++Tlkpo/w3iOxOnYGozJPeN6b0H1r+UT12h7Y2PTHWcqaATwc61K
         wHxg==
X-Gm-Message-State: AO0yUKVoqF1tGEC6cuNPqYi1clDt87qhhWsu57tTg8QNgt3HFQfNtDZt
        2bbYOiY7cS41tFQbzFBGoa43hMFOITm8ovn6YnhhV9ZwbJHK61oS
X-Google-Smtp-Source: AK7set9avmv8bq+VCtnDKgolFocuzy2nMv7JqFhNCPPGukBzD7lZ5vgsQ6zn8OH7H/p639xaoGkovQc+GN6Do+3AuSA=
X-Received: by 2002:a05:600c:a39a:b0:3e1:eddc:e3ae with SMTP id
 hn26-20020a05600ca39a00b003e1eddce3aemr1005713wmb.0.1678465546572; Fri, 10
 Mar 2023 08:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20230310144736.1546972-1-robh@kernel.org>
In-Reply-To: <20230310144736.1546972-1-robh@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 10 Mar 2023 09:25:35 -0700
Message-ID: <CANLsYkwmeZaYdpKyszh2QAs_MvMekP5W9wteX+Kbi7fsjFAPsg@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: st: Use of_property_present() for testing DT
 property presence
To:     Rob Herring <robh@kernel.org>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 at 07:51, Rob Herring <robh@kernel.org> wrote:
>
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/remoteproc/st_remoteproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
> index a3268d95a50e..50ef40671652 100644
> --- a/drivers/remoteproc/st_remoteproc.c
> +++ b/drivers/remoteproc/st_remoteproc.c
> @@ -379,7 +379,7 @@ static int st_rproc_probe(struct platform_device *pdev)
>                 clk_set_rate(ddata->clk, ddata->clk_rate);
>         }
>
> -       if (of_get_property(np, "mbox-names", NULL)) {
> +       if (of_property_present(np, "mbox-names")) {
>                 ddata->mbox_client_vq0.dev              = dev;
>                 ddata->mbox_client_vq0.tx_done          = NULL;
>                 ddata->mbox_client_vq0.tx_block = false;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> --
> 2.39.2
>
