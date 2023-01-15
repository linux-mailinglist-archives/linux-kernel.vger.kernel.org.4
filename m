Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE966AF42
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 05:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjAOEIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 23:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjAOEIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 23:08:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77E1728A
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 20:08:34 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so30827303pjk.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 20:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DRIGaGwIEVC04sLYWcSi38AK8s1IVg2cHJh95N515UM=;
        b=HKcb9eK2oTEucFQqOgW+aFuLByrEEfTxbvgtdixpiC9ooB+0bllwFV/10FtH1AFcrv
         75oOW9m7Nqqscl470DLAMEOePP9xdbsP8gyfEk/Hqpg+UqOVaECCdf/Beb/Dhz8hTRel
         ef5mC6cE0hy1lnk134qfLOggW8plLAR6Ke2C8bkug5azRUwKIl6CEdX+XHgyHeqHbrQ7
         NH2kHpLPJBsZnpAlzBzE6bRZKsuNyPdGU5umkB8cpbYcNWyFKVh2Fq8lezPP/dIjMIOZ
         v8QnjCVju5ItltpmmCWi1EKINE+KUswTAXXVD7EkANxLXiX6uJIE5j9dY+csruxdk4a8
         4ZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRIGaGwIEVC04sLYWcSi38AK8s1IVg2cHJh95N515UM=;
        b=N7PJ/wAlIYnSPCqaXWdRQkRhW0nYZnvnnolqe/o5vD5n7ZOOzKk6YH7H01PV2jpjQ1
         aE2K+J6rXmDvgwCpSjcdugvzIqyirtW5Qt5gXnGAAxPOf/1aXnG4kdp+YG/6q6uHMyPO
         LtUISqeKX5yotVXJA3IMemqCQ8C/3DSsOtMbxJzQ006BcGVPStjUUIitLcxEGXfoeNqM
         2O/dInRKxa+zdyn7LsdQQtCG8sg64KkOeTVp2uvLbOI2FhG9EwCKHM7GRzbELw1xsgyO
         Mrwnd7HTL4meGe+gL2Zt76o1rXK5ulbH5oMxkaBhLprQEjO3Dcp4O+a7MId421sAxnnz
         Yj0Q==
X-Gm-Message-State: AFqh2kpx6KyjdPpY+C0lFcZn7h3wMeghs87S/KWaxe1Ap+s+jh1MWFCH
        q7y5KeNeh6XVxSB0Zj8K5RrG
X-Google-Smtp-Source: AMrXdXt1wr5bOBd1Lfe0cgIaOglyRZ+Ab9hHIbzgBDkbrRX8LxOl7Omu7bxEFjjz492AQfYqqpXgjQ==
X-Received: by 2002:a17:90a:72c4:b0:229:19f7:a60d with SMTP id l4-20020a17090a72c400b0022919f7a60dmr9722406pjk.0.1673755714240;
        Sat, 14 Jan 2023 20:08:34 -0800 (PST)
Received: from thinkpad ([220.158.159.143])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090a474700b00219463262desm14324402pjg.39.2023.01.14.20.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 20:08:33 -0800 (PST)
Date:   Sun, 15 Jan 2023 09:38:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony.luck@intel.com,
        quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org
Subject: Re: [PATCH v5 16/17] qcom: llcc/edac: Support polling mode for ECC
 handling
Message-ID: <20230115040825.GB6568@thinkpad>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
 <20221228084028.46528-17-manivannan.sadhasivam@linaro.org>
 <Y8Kv0GIk69MhcOjT@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8Kv0GIk69MhcOjT@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 02:36:16PM +0100, Borislav Petkov wrote:
> On Wed, Dec 28, 2022 at 02:10:27PM +0530, Manivannan Sadhasivam wrote:
> >  static int qcom_llcc_edac_probe(struct platform_device *pdev)
> >  {
> >  	struct llcc_drv_data *llcc_driv_data = pdev->dev.platform_data;
> > @@ -355,22 +361,31 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
> >  	edev_ctl->ctl_name = "llcc";
> >  	edev_ctl->panic_on_ue = LLCC_ERP_PANIC_ON_UE;
> >  
> > +	/* Check if LLCC driver has passed ECC IRQ */
> > +	ecc_irq = llcc_driv_data->ecc_irq;
> > +	if (ecc_irq > 0) {
> > +		/* Use interrupt mode if IRQ is available */
> > +		edac_op_state = EDAC_OPSTATE_INT;
> > +	} else {
> > +		/* Fall back to polling mode otherwise */
> > +		edac_op_state = EDAC_OPSTATE_POLL;
> > +		edev_ctl->poll_msec = ECC_POLL_MSEC;
> > +		edev_ctl->edac_check = llcc_ecc_check;
> > +	}
> > +
> >  	rc = edac_device_add_device(edev_ctl);
> >  	if (rc)
> >  		goto out_mem;
> >  
> >  	platform_set_drvdata(pdev, edev_ctl);
> >  
> > -	/* Request for ecc irq */
> > -	ecc_irq = llcc_driv_data->ecc_irq;
> > -	if (ecc_irq < 0) {
> > -		rc = -ENODEV;
> > -		goto out_dev;
> > -	}
> > -	rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
> > +	/* Request ECC IRQ if available */
> > +	if (ecc_irq > 0) {
> > +		rc = devm_request_irq(dev, ecc_irq, llcc_ecc_irq_handler,
> >  			      IRQF_TRIGGER_HIGH, "llcc_ecc", edev_ctl);
> 
> You need to request the IRQ first and then set edac_op_state above. I.e., this
> devm_request_irq() needs to move in the if (ecc_irq > 0) branch above.

May I know why? I also checked other drivers, most of them are doing the same.

Thanks,
Mani

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
மணிவண்ணன் சதாசிவம்
