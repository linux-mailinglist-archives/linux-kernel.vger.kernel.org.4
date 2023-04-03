Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA36D4D3D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDCQJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjDCQJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:09:04 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3C9D1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:08:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso33066330pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680538138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FReLfJ5RyVdrbXiYpGSEiw2ngxGjYmfHewo4jwkGSLo=;
        b=lg/XksLHRF0mCqn5cd62/i93K/9XsNi/UKaXq2wmKqKs+ZOLTGDg++Rp2XG8BFoP+R
         QspmHdp9B5qi8/2jNRqBwRVGinzRnYobyqmSkdR8qmZEECBJ5wyargRS3hQEOdgTUPWi
         mVPBHsuMqaqKe/PW28NCJac9OuqQSVqjiLsYu/+y7C+AmgeC6bfEd3pFxNAj3IFzAfWj
         wA2f1ooIt6rlDzI7TQTt9pEUOuNoFS7bpNmHSmx2geGVubaq4VgSf3jygYaqi0BccZDX
         J+ujIkpxnpMJj8fJpWyDtMBBeoxapyPm4bnBVv48weLyMscZIg9NkywvMG8GBJzgOsZ1
         efZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680538138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FReLfJ5RyVdrbXiYpGSEiw2ngxGjYmfHewo4jwkGSLo=;
        b=BLVVmRyeioj4itqdbLz0uR+yM68JIQEHY2NMs+OaKV9eXohSQ5uoyab6mXnzqzvsNc
         ukBB9fva8grgpLQ+s41g6Q7vUX3CpEbkbW5aNZdfzXPYpX4ZSZuH2CFbbITCgJ2AIxNr
         MLrT4f2IwJitsDJ59NxqB5bRNZvv/tdyQLaO9lJ8Oj0HiOFUZbszVeOnfShF1vdxducq
         iflhLuLlv/Me2yhw6f9H1LKRKvcJbrgFPeJwzNtKweT14tV2tO7fQ4KcWnEAr+o+a8XS
         IwSee1HLjpAm+U+Aeg/UelPGnAcDNBP04pv+jKMWOaEXu7ubvoIU52MvAbjsvQSujZIN
         A/3A==
X-Gm-Message-State: AAQBX9eKIvEmxtAe/sLR30oYC9IrzpmpvHO8Is+Emb8qg590xd7Mmkxs
        OVd2yPMHkNXjZV/vp1+gzsLr
X-Google-Smtp-Source: AKy350YTQOFeFPqGkXZukS9T2TYmxtydivmfM+gu0zZDzHiY5SbmtSdDu8RkO4nUco4wSwkrrnO+SQ==
X-Received: by 2002:a05:6a20:8c05:b0:de:808e:8f3d with SMTP id j5-20020a056a208c0500b000de808e8f3dmr19411536pzh.13.1680538138603;
        Mon, 03 Apr 2023 09:08:58 -0700 (PDT)
Received: from thinkpad ([27.111.75.109])
        by smtp.gmail.com with ESMTPSA id f23-20020aa782d7000000b005cd81a74821sm7133449pfn.152.2023.04.03.09.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:08:58 -0700 (PDT)
Date:   Mon, 3 Apr 2023 21:38:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, amit.pundir@linaro.org,
        regressions@leemhuis.info, sumit.semwal@linaro.org,
        catalin.marinas@arm.com, robin.murphy@arm.com
Subject: Re: [PATCH V4 00/11] Fix XPU violation during modem metadata
 authentication
Message-ID: <20230403160852.GD11346@thinkpad>
References: <20230117085840.32356-1-quic_sibis@quicinc.com>
 <20230327161857.GA32697@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230327161857.GA32697@willie-the-truck>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 05:18:57PM +0100, Will Deacon wrote:
> Hi Sibi,
> 
> On Tue, Jan 17, 2023 at 02:28:29PM +0530, Sibi Sankar wrote:
> > The memory region allocated using dma_alloc_attr with no kernel mapping
> > attribute set would still be a part of the linear kernel map. Any access
> > to this region by the application processor after assigning it to the
> > remote Q6 will result in a XPU violation. Fix this by replacing the
> > dynamically allocated memory region with a no-map carveout and unmap the
> > modem metadata memory region before passing control to the remote Q6.
> > The addition of the carveout and memunmap is required only on SoCs that
> > mandate memory protection before transferring control to Q6, hence the
> > driver falls back to dynamic memory allocation in the absence of the
> > modem metadata carveout.
> 
> [...]
> 
> >   remoteproc: qcom_q6v5_mss: Use a carveout to authenticate modem
> >     headers
> 
> With this change now merged, am I ok to downgrade the arm64
> arch_dma_prep_coherent() back to a clean?
> 

I think you can. If something breaks, we will fix it (without reverting) ;)

- Mani

> Thanks,
> 
> Will

-- 
மணிவண்ணன் சதாசிவம்
