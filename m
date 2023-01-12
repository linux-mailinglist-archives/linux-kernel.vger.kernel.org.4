Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FB0667845
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbjALO4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240089AbjALOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:55:34 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78041140ED
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:42:53 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x4so9801297pfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lQ9//czqzS4KKyor5Lm6ZDh+CPpH8wgALdX62/JuyD4=;
        b=Hex7938yIPW3rYbY4suGUnOLBRwf2WhRq3aKDtv6u6XLlU2ZZZvyeioK9WfOFFrjLd
         YUJpfmmAfMh8hFR+z+Thdi55gthZopzPi0JfGovDSBLQ/nSEKlJiEJRRtRSpL+s9Hv6P
         HnQ9sEJkPgBVXzYSCSSqNFCAT2OXh98Qasslw4ik5TB/CWThzm5fkra8ZiiYyQlFo54l
         7dIiUSvWII1VHGoxsavLsnP58icaLOi1Kyqx8EYPkBp5Do2cw+oreLBbkTyIX96qcUbf
         KNvpcadji7NUA5IhmsVopSCHTQ3XraGXTJ6SwCGWNovDpOPzBGrgygpZ7xj5WHnP4Ajd
         Y0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQ9//czqzS4KKyor5Lm6ZDh+CPpH8wgALdX62/JuyD4=;
        b=CiGsG2UncJN2VlOdq5HzQ9z8sRD/N7ZiH7CGXr5mAK/eo9uENovjRkVtj7nGPhhi8J
         rFsSpow1cuxiD5Ps6gDwU7f3xElQdz1/jrm7zAn+BUTtiD0az5bwATIuqRTRmSybSC1x
         uzKrN0rqsem+ct0IusScJsMycby+hbWjm7tLrBybMjX84WHOdm3xTQrcAJ48b1Sir54h
         Y1LKCfFX2Dqo/FJRje/TaCaghvAUuqSCUs98FNisQxrtS7c3eKU7YKmYOz5cwwxTDGWH
         gfTDAPqB4laAMzOqBgPEi6WDO7CNHjnubRBCRKOI4U04eqM4ME8vpkhKNuONsRcMKOG8
         70GA==
X-Gm-Message-State: AFqh2kpnFJH7HyYP7nT6ieXdoAQewvNaDu89mIaCk42gzfY0In+L/hMy
        vEbEKyc7LaFN/OaVfSy9dINVjKwLUkg0OsiE7CC1fg==
X-Google-Smtp-Source: AMrXdXuGS1L/rcUS6f0+NxFhmx0fzTtOMW+Pr7Cmf7qvlb3pjmkrPoj6TgvTdK+UlNoj+41qAhg8NdDiIsr6ox+i+U4=
X-Received: by 2002:aa7:8744:0:b0:582:1c10:6793 with SMTP id
 g4-20020aa78744000000b005821c106793mr3728832pfo.44.1673534572989; Thu, 12 Jan
 2023 06:42:52 -0800 (PST)
MIME-Version: 1.0
References: <20230110110736.2709917-1-james.clark@arm.com> <20230110110736.2709917-2-james.clark@arm.com>
In-Reply-To: <20230110110736.2709917-2-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 12 Jan 2023 14:42:41 +0000
Message-ID: <CAJ9a7Vh2jc+62head4H2R4W4heGOiR4xTQCTRFMT5G5gPbLexw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] coresight: cti: Prevent negative values of enable count
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        suzuki.poulose@arm.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 at 11:08, James Clark <james.clark@arm.com> wrote:
>
> Writing 0 to the enable control repeatedly results in a negative value
> for enable_req_count. After this, writing 1 to the enable control
> appears to not work until the count returns to positive.
>
> Change it so that it's impossible for enable_req_count to be < 0.
> Return an error to indicate that the disable request was invalid.
>
> Fixes: 835d722ba10a ("coresight: cti: Initial CoreSight CTI Driver")
> Tested-by: Jinlong Mao <quic_jinlmao@quicinc.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-cti-core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index d2cf4f4848e1..838872f2484d 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -151,9 +151,16 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
>  {
>         struct cti_config *config = &drvdata->config;
>         struct coresight_device *csdev = drvdata->csdev;
> +       int ret = 0;
>
>         spin_lock(&drvdata->spinlock);
>
> +       /* don't allow negative refcounts, return an error */
> +       if (!atomic_read(&drvdata->config.enable_req_count)) {
> +               ret = -EINVAL;
> +               goto cti_not_disabled;
> +       }
> +
>         /* check refcount - disable on 0 */
>         if (atomic_dec_return(&drvdata->config.enable_req_count) > 0)
>                 goto cti_not_disabled;
> @@ -171,12 +178,12 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
>         coresight_disclaim_device_unlocked(csdev);
>         CS_LOCK(drvdata->base);
>         spin_unlock(&drvdata->spinlock);
> -       return 0;
> +       return ret;
>
>         /* not disabled this call */
>  cti_not_disabled:
>         spin_unlock(&drvdata->spinlock);
> -       return 0;
> +       return ret;
>  }
>
>  void cti_write_single_reg(struct cti_drvdata *drvdata, int offset, u32 value)
> --
> 2.25.1
>

reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
