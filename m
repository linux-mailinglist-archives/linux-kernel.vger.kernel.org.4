Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0285672926
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjARUQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjARUQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:16:08 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B307E5D7FF;
        Wed, 18 Jan 2023 12:16:07 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id l125so17666837vsc.2;
        Wed, 18 Jan 2023 12:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I4ilFk+1HdZgZljeEPe4BfQTGo6zmvKGQ3ASs4fGH4E=;
        b=iHIkqiBpPvAE7ymZW+0WDNWZGWJ4jjZLpsnmWylDRABzpMA05FLxtS+3r9W+Bo2D3p
         sEHc2xrxde+tthr/ESXE3BYOtj588RosREmOOU6yThaOXZGIPV2Y7XLO7JiO8q8mg1a9
         HtciM/aZWKi4+wYpRaggOZ/SldcKVJZdnQqxh4bJzDoGxPPuqxxM3iScsOMfiFVRuoLR
         +arU0tvvNirX0f3B1Y5lM4LpWnnlObo3MdhDR8hIDZTNa3Mw3Ips6vLhn3EfAwrzybMP
         Nwd3jgVvodStsSRXYMyChVhQ3q7AJmB6W4FFpbeNS1SZ0NyZXcqamz6cuN7plMn4lOlF
         /hQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4ilFk+1HdZgZljeEPe4BfQTGo6zmvKGQ3ASs4fGH4E=;
        b=Y+OjZ0Qy0w0UG3e1S+dK6MGpfI4ojTrQ9nWr/IAU7h/+og9wq+tATBJa4GwLxVXc3c
         mLK3e4R7gfBJg7PAP83kzxUN607yl2MdNbIuhyuJj7nzpeSbgect77FDSibwOc/q8oje
         txhYKMS+THqr4vl27YCq3CedbRoiWlps9033+DvAhMFhnKbQ3tsRUR8XLBbT9Xr18NYB
         aAd9mIaVEz5sr0YDP+dz8Dgoe0LCJ7is0d/tK5QMDJqY2lz/oaWUohjUhYSD3SSQSEJa
         kp8WBMMg2LrSCbCEYPxYnmsKHfC/zyggX9ejS/qIfwzEc+kQVseInH43kg5G16KBCGj4
         gawQ==
X-Gm-Message-State: AFqh2kp6xW28nqlYdOmZ+5jGPr+7YKN43yfEfMjHw9HWj3DjIKgVsI5o
        S9Ob0M5BXwR8Zh2U+v2tPk2J3vpWeB45GWopiZw=
X-Google-Smtp-Source: AMrXdXv47ndtBRK2U4O/8xM25+unbtJA5XsFxO7rDVlDQvBV/9IVN1yn3YcsN6+bFZ676VuMpo0++yno7KHA9uLRDnA=
X-Received: by 2002:a67:d097:0:b0:3d0:cb3d:ad47 with SMTP id
 s23-20020a67d097000000b003d0cb3dad47mr1312594vsi.76.1674072966756; Wed, 18
 Jan 2023 12:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20230118095440.41634-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230118095440.41634-1-andriy.shevchenko@linux.intel.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Wed, 18 Jan 2023 15:15:40 -0500
Message-ID: <CAE2upjSJ6CuNkpga1ThnDCmVHLSq30zN3A+UR89+nAkrhOaW5g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] platform/x86: intel/pmc: Switch to use acpi_evaluate_dsm_typed()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.
Reviewed-by : Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>


On Wed, Jan 18, 2023 at 4:54 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/tgl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
> index e3e50538465d..c245ada849d0 100644
> --- a/drivers/platform/x86/intel/pmc/tgl.c
> +++ b/drivers/platform/x86/intel/pmc/tgl.c
> @@ -221,9 +221,9 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
>
>         guid_parse(ACPI_S0IX_DSM_UUID, &s0ix_dsm_guid);
>
> -       out_obj = acpi_evaluate_dsm(adev->handle, &s0ix_dsm_guid, 0,
> -                                   ACPI_GET_LOW_MODE_REGISTERS, NULL);
> -       if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
> +       out_obj = acpi_evaluate_dsm_typed(adev->handle, &s0ix_dsm_guid, 0,
> +                                         ACPI_GET_LOW_MODE_REGISTERS, NULL, ACPI_TYPE_BUFFER);
> +       if (out_obj) {
>                 u32 size = out_obj->buffer.length;
>
>                 if (size != lpm_size) {
> --
> 2.39.0
>


-- 
Thanks,
Rajneesh
