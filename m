Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF99465E889
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjAEKCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjAEKCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:02:31 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8682C6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:00:52 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b145so20862570pfb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S5vBFARuIRiK64V5wwqFkQ5kzYGu77jWfbY7LeM0ol8=;
        b=gaUFFXLBJ8PxpmBmW3TEwh1Bh7dvc7x8b51VrFeqk/UV1oRAv7DGYCii+Tp1w2gdb+
         moNaPe8ZyZfVPqr7joC6v/1kXLO2chLGNwGG09hcl8F934DBj2+0p5dxma32DpPJgSyV
         zLkTt9/SFjk+1aeTbq49pfAEdGpcpJqtqClgwD4NvQ4jFLsYiaZJrC2pj7pkFKUR+YOv
         u5zYlsaxIj1tgiUKpyRkzQZQkNdURyjqziPtbH1aZPRr9jyEHSXkB3pwCC1OpMQuNsJ8
         JWKZ2zsxIP2frDFCQ7iETLcUCuYFiTYEqi2rNk+C1leadvkM7j5dpar2s3ivKLuif4Px
         sd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5vBFARuIRiK64V5wwqFkQ5kzYGu77jWfbY7LeM0ol8=;
        b=ZcfU75jkq3VbFVtYJqI1vsYR9jeAJIA/r9bFQg8+vB5SSTMjpnF8IWzRQzywpt23YO
         bWEAq4i6FGWG4nHj5qM+ckGQJ9StlS9mi3frAAujIWaH1bzh22j+Y2472T2eHnSjRyEQ
         aKg5csqKjuwZBxeaLP4KEUcrIoZTO55ogKQ+xfT5VOn2LldQ6/S4q3P0zfxHRg1GgrMI
         s/lfZp/w/gjnJoiUWavgXgg/9VMeCzvmec0JJxNJRYdTP9Nfvdbv/NQFWDXAQ/X+B4tc
         lLoxIk5Iqxg9Ve2aBG4nmeT6IU25WrHiE8pX3Sf4knegZ1mRZel4+qkUp7DU9Dwck4SE
         h9jQ==
X-Gm-Message-State: AFqh2kpgP24VHcw7DaT1R0wwY3dt9FzKWHjSU3ScFLTA+TuK5oNHSHkQ
        Nt/wf00LiQvZpaWTYVya7C0L
X-Google-Smtp-Source: AMrXdXuy76CFoqhJHzUdLoYbZsqoqgin0M+AYQcrcUafsVBfHmWvkfzOtigXyuToV0Hxsvl02rix2g==
X-Received: by 2002:a62:5801:0:b0:574:a541:574a with SMTP id m1-20020a625801000000b00574a541574amr48434720pfb.0.1672912851913;
        Thu, 05 Jan 2023 02:00:51 -0800 (PST)
Received: from thinkpad ([27.111.75.153])
        by smtp.gmail.com with ESMTPSA id a14-20020a62d40e000000b00581fddb7495sm11582395pfh.58.2023.01.05.02.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 02:00:50 -0800 (PST)
Date:   Thu, 5 Jan 2023 15:30:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, andersson@kernel.org, vkoul@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org
Subject: Re: [PATCH v5 00/23] ufs: qcom: Add HS-G4 support
Message-ID: <20230105100044.GA4463@thinkpad>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
 <yq17cy84gqc.fsf@ca-mkp.ca.oracle.com>
 <20230102084707.GA16638@thinkpad>
 <yq1r0w91zbw.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq1r0w91zbw.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 09:37:56PM -0500, Martin K. Petersen wrote:
> 
> Manivannan,
> 
> >> >   scsi: ufs: core: Add reinit_notify() callback
> >> >   scsi: ufs: core: Add support for reinitializing the UFS device
> >> 
> >> I would like to see some reviews of the proposed core changes.
> >> 
> >
> > Both patches are reviewed by Bart now.
> 
> Series applied to 6.3/scsi-staging, thanks!
> 

Thanks Martin! I presume that you have applied only the ufs patches as
mentioned in the cover letter. PHY patches are expected to go through PHY tree.

I cannot see the patches in 6.3/scsi-staging branch yet, so couldn't confirm.

Thanks,
Mani

> -- 
> Martin K. Petersen	Oracle Linux Engineering

-- 
மணிவண்ணன் சதாசிவம்
