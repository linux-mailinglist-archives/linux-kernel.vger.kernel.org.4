Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F54632260
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiKUMiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiKUMiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:38:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A580B54F5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:37:58 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i64-20020a1c3b43000000b003d016c21100so3057904wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfJ6ReGcbvudqGx5aWnlLmh808mEmKwe4YM900G8GoU=;
        b=bhLvzu/iY7Mjd1xlH9twYzc2DCTHHIuR6cmeB16W+qrctjI2VgehKZyGjhsb0y/s9Q
         rb5YPfiHqcjgLHbMXVp1UA7FFBV5n7zmRJIowCr2t4gxPwYHqilNJKTuooB3QAcZFDKk
         fZPBYxMNpqfIMW4A5i2NiTps5MXN74532w65v0P6trMHqwWrfavqhd07zEWt36odoyfn
         4ZHkqB9bGKS91KyjTFGnfRiCUkjx9qVv3VGl8kFEL6Oy+w8gJ+FQWT1UgfYoNk4Wjtj3
         +WY+DtEaJYy5UC5YzyvXglazmcTU9wPC4nUtmeIyCSRMxit9IPjY7hrBVMj9Kwo3Wn3C
         1kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfJ6ReGcbvudqGx5aWnlLmh808mEmKwe4YM900G8GoU=;
        b=C+2HvcOMLEQ69WUET0Px0UFf2knswV4/KCd6cBIEyfoZjdCzKVARJjq3V2J0VZFBw0
         /cuNQ4E7k5n9ztzvKjB7jUY4tV/WTinmJHiu8dddXAdGYJoKX7N3NH3XltCjvuJOiURi
         Vl3C9W0L4MIOlOsmAJfDeaIXluvDJN6jtMz06qW6z+65DhPgVq146vFfd3rQIKU2Tzxf
         ivNLWqgeicgKZCIJHHCXgsEYijmOiVDQw0P93/WnhHIaYOT9f+j5j1a03K+JOPQgAL6A
         lM0ta7yxgsW4cufHM9UUkbBd2SDdXMWuAE0pun46E0aznuTQr5WnD45xj2WWWXas42KI
         mSMQ==
X-Gm-Message-State: ANoB5pm6px3jeEBjIp5onxLHZarjToPsV+pwyMOa23AJCTwrSFLigQPZ
        SAm8MBg6U4JdELjFOJXnjHSKjg==
X-Google-Smtp-Source: AA0mqf5JngN/dT4Kr7SbrPWvWx3miCH34ldho+VQ75xmRL5193rxCxFZa4xfx0c7V+FzhXpY/pFlwQ==
X-Received: by 2002:a1c:7401:0:b0:3cf:934b:b7ad with SMTP id p1-20020a1c7401000000b003cf934bb7admr1734188wmc.22.1669034276591;
        Mon, 21 Nov 2022 04:37:56 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e21-20020a05600c219500b003cf894dbc4fsm13496353wme.25.2022.11.21.04.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 04:37:56 -0800 (PST)
Date:   Mon, 21 Nov 2022 14:37:54 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/2] ufs: host: ufs-qcom: Clear qunipro_g4_sel for HW
 version major 5
Message-ID: <Y3txIoDn3hFBXt0Y@linaro.org>
References: <20221116121732.2731448-1-abel.vesa@linaro.org>
 <20221116121732.2731448-2-abel.vesa@linaro.org>
 <57b0669c-3826-dc33-36a4-2d8220da768a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57b0669c-3826-dc33-36a4-2d8220da768a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-16 13:28:53, Konrad Dybcio wrote:
> 
> 
> On 16/11/2022 13:17, Abel Vesa wrote:
> > On SM8550, depending on the Qunipro, we can run with G5 or G4.
> > For now, when the major version is 5 or above, we go with G5.
> > Therefore, we need to specifically tell UFS HC that.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >   drivers/ufs/host/ufs-qcom.c | 4 ++++
> >   drivers/ufs/host/ufs-qcom.h | 2 ++
> >   2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > index ca60a5b0292b..72334aefe81c 100644
> > --- a/drivers/ufs/host/ufs-qcom.c
> > +++ b/drivers/ufs/host/ufs-qcom.c
> > @@ -227,6 +227,10 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
> >   	ufshcd_rmwl(host->hba, QUNIPRO_SEL,
> >   		   ufs_qcom_cap_qunipro(host) ? QUNIPRO_SEL : 0,
> >   		   REG_UFS_CFG1);
> > +
> > +	if (host->hw_ver.major == 0x05)
> > +		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
> > +
> >   	/* make sure above configuration is applied before we return */
> >   	mb();
> >   }
> > diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> > index 751ded3e3531..10621055bf7f 100644
> > --- a/drivers/ufs/host/ufs-qcom.h
> > +++ b/drivers/ufs/host/ufs-qcom.h
> > @@ -36,6 +36,7 @@ enum {
> >   	/* On older UFS revisions, this register is called "RETRY_TIMER_REG" */
> >   	REG_UFS_PARAM0                      = 0xD0,
> >   	REG_UFS_PA_LINK_STARTUP_TIMER       = 0xD8,
> > +	REG_UFS_CFG0                        = 0xD8,
> Are you sure these two should point to the same register? Maybe it deserves
> some kind of a comment?

The REG_UFS_PA_LINK_STARTUP_TIMER is used by non qunipro variants. (UFS
versions below 2.x)

The REG_UFS_CFG0 is used by qunipro variants. (UFS versions above 2.x).

Will add a comment to the later one that would look like this:
"/* Found on UFS versions above 2.x only */"

Thanks,
Abel

> 
> Konrad
> >   	REG_UFS_CFG1                        = 0xDC,
> >   	REG_UFS_CFG2                        = 0xE0,
> >   	REG_UFS_HW_VERSION                  = 0xE4,
> > @@ -75,6 +76,7 @@ enum {
> >   /* bit definitions for REG_UFS_CFG1 register */
> >   #define QUNIPRO_SEL		BIT(0)
> > +#define QUNIPRO_G4_SEL		BIT(5)
> >   #define UFS_PHY_SOFT_RESET	BIT(1)
> >   #define UTP_DBG_RAMS_EN		BIT(17)
> >   #define TEST_BUS_EN		BIT(18)
