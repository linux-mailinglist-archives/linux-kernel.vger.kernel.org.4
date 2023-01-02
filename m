Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1798B65AE5B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjABIrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjABIrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:47:15 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295BA21BA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:47:14 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id n4so29015331plp.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 00:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tkq2fYPAAfCT6CmgtdbmFTqHCyc6irGoNXfZDkU6fuw=;
        b=p93mZ34atd0r0rIEpm6svkrRZ9FPVeK8Dv9EYEQJHXFoyIEM7K6vf2gGV60goJnIc9
         HevkH6rQ2a+EMePniVp0o2vvM0xSld1KA+S6zcwr1Nzqijv0jpTc9u2vNON/jc0RM2TX
         IgRGoM+k6l4pwYnEABIPni9VfHqCtZFhetDOjA8nbxvJ306OXVIKSSj5UrlgtJhcJK3v
         U7Y1JyH0OO2PGyVm8ZyD9fLPcDxj7G19HzjE469P537WGdBJjYFke8rz+zg9U9hHu/+D
         CEcIS6MDBoo0znvZwNvz6lotdJRJPIqcws6AcGj29i8n8MCQfTafeaku7BXtHTy6LmNP
         oSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkq2fYPAAfCT6CmgtdbmFTqHCyc6irGoNXfZDkU6fuw=;
        b=K7ZDZN9DKptAjMzurP9k7lo4pfOOJXqmESfV4AMlupSeY3h+eJ9Uw0pW7ZfN//VQkV
         k54U5ECylr/hayppOqUO1Sexm7e35/KB0wiDr8eg5NCo6BE8NS4nfaQ1OsfIgVKrMXwY
         xp8GKqpc9hDPdv/iddwTfc28eHypEIJiTtKeSmFDEK10Q6Rg+89bm/zVfogLqVy4UtO1
         w94R794v+Em7GtXDbbXneoZIqRbb1rAYywzVDxJqOggfbFZihgrLkuv+TjkVAtXA1Z8p
         Ve1RHy4GAxctre4c7fgK5QypEOpDz66F4TPp7fA3+obkIT74lXEdEVxfpbIEa5YkD0Sj
         1wVQ==
X-Gm-Message-State: AFqh2kpRu6IgPHoUncKxJEY9v+z/mxNVcJKzHefLHI7RGUB82PVz7YAv
        tBQCxRcGnp+gdRl/zwI/+UjE
X-Google-Smtp-Source: AMrXdXs4EMX0rX34O8k6lqYjXiFN2NlmyBxs4ZAhDFblSqzK9GJaN+YN/7NTn4wtD7Cl5I+616O4mw==
X-Received: by 2002:a17:90a:b10b:b0:225:cc25:802f with SMTP id z11-20020a17090ab10b00b00225cc25802fmr33334186pjq.28.1672649233597;
        Mon, 02 Jan 2023 00:47:13 -0800 (PST)
Received: from thinkpad ([220.158.158.187])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a430700b0020bfd6586c6sm16618209pjg.7.2023.01.02.00.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 00:47:12 -0800 (PST)
Date:   Mon, 2 Jan 2023 14:17:07 +0530
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
Message-ID: <20230102084707.GA16638@thinkpad>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
 <yq17cy84gqc.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq17cy84gqc.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Fri, Dec 30, 2022 at 06:29:24PM -0500, Martin K. Petersen wrote:
> 
> Manivannan,
> 
> >   scsi: ufs: core: Add reinit_notify() callback
> >   scsi: ufs: core: Add support for reinitializing the UFS device
> 
> I would like to see some reviews of the proposed core changes.
> 

Both patches are reviewed by Bart now.

Thanks,
Mani

> -- 
> Martin K. Petersen	Oracle Linux Engineering

-- 
மணிவண்ணன் சதாசிவம்
