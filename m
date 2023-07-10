Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9DB74DC73
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjGJR2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjGJR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:28:43 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6657D187
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:28:39 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-635eedf073eso31177456d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689010118; x=1691602118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wLpjzQEenkbJ/gFlghd5REGFAGYnm9xmo03pfq2YYWo=;
        b=fSUBtljW2tupPgc7JdOUNMdW4laZhz1EUL6fRhFT3oIYk6LXlb8eDlvz5YyQcxCMhu
         aZqXgl3kHe/jI8ubKGqhnPmNH6yInPwogwdX9CwU5R/3lEEEXDaFIPIhhjoQNvbXGrIl
         +4oTH2UIJ+qNtwFB07Mi+9f41IUPzZV5Ui1ZnRzxAoLUclWyzjeEzZ903j5wwRW4zGoM
         aPjpSdDi+Wg/CDofCt429PZLE2hcKYYCt31G3IPKCA0aln05ua500196g40qrnXORZWw
         dYbf5r/HTkrGgweFngOzWZft3EaMNRxq/N0Ui6aL1pZMCkcd7Pw9/Tj/YchoqE9TRrEK
         2rGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689010118; x=1691602118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLpjzQEenkbJ/gFlghd5REGFAGYnm9xmo03pfq2YYWo=;
        b=gKFvuiQqOguJpVaZreK1AgMr/k232Pg4v2z/k8CefqUmiMIf3awUkSOpA6s18IorZ0
         ckhOTMd3ae3tGceYXbcudQP/OuvreD3jnJNZ4NiZAOsKRVweqDsUrlJBc6gkqZ0lFiQ3
         iPPkeAXTuN8XvonrnrlhNAuEpX/bZA297ZZ6FGI8YEycZghazCb/8lnBL2OpkAGNvq4J
         2/5HI4KyZbMTYoYkkz3PAzI6JPaG1JZ6zKkSojyvhQzv7rMWa9U1DExo2S0enqkJp/jy
         9UQjFz/L3jJfOZXcdza81f1pQUEWYJDsAV4N3YPtZvCa0XdFYpxYRz795LFCUu5VoaIN
         50dw==
X-Gm-Message-State: ABy/qLaLhd9qpKEcuLkCrrqpEgopgMbC8y0aMt9V/fTNCzbGPd81/zBV
        O+juiaArmEHlO4mIxMgpngMYlg==
X-Google-Smtp-Source: APBJJlFExA2moLbyNhVmA2Jybezw3b+s7HmTxgqMtHVXfr1jnmQ18NRx3XeqvNVgeBiLSgTXM+41bw==
X-Received: by 2002:a0c:dc01:0:b0:636:836e:8064 with SMTP id s1-20020a0cdc01000000b00636836e8064mr11800445qvk.63.1689010118491;
        Mon, 10 Jul 2023 10:28:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id d25-20020a0cb2d9000000b006166d870243sm54803qvf.43.2023.07.10.10.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 10:28:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qIugf-0004Gb-F9;
        Mon, 10 Jul 2023 14:28:37 -0300
Date:   Mon, 10 Jul 2023 14:28:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] iommu: Support mm PASID 1:1 with sva domain
Message-ID: <ZKw/xS7wOoRvNfnH@ziepe.ca>
References: <20230707013441.365583-1-tina.zhang@intel.com>
 <20230707013441.365583-6-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707013441.365583-6-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 09:34:40AM +0800, Tina Zhang wrote:
> Each mm bound to devices gets a PASID and a corresponding sva domain
> allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
> field of the mm. And that PASID and sva domain get released in iommu_sva_
> unbind_device() when no devices are binding to that mm. As a result,
> during the life cycle, sva domain has 1:1 with mm PASID.
> 
> Since the required info of PASID and sva domain are kept in struct
> iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
> field in mm struct.

This is not technically right, the domains need to be a list, and we
need to search the list. Almost always the list will have 0 or 1
entries in it.

> @@ -88,31 +98,41 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>  		goto out_unlock;
>  	}
>  
> -	if (domain) {
> -		domain->users++;
> -		goto out;
> +	if (unlikely(domain)) {
> +		/* Re-attach the device to the same domain? */
> +		if (domain == sva_domain) {
> +			goto out;
> +		} else {
> +			/* Didn't get detached from the previous domain? */
> +			ret = -EBUSY;
> +			goto out_unlock;
> +		}
>  	}

And if we do all of this we should just get rid of the horrible
iommu_get_domain_for_dev_pasid() entirely.

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 20135912584ba..1511ded7bc910 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1175,20 +1175,20 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
>  #ifdef CONFIG_IOMMU_SVA
>  static inline void mm_pasid_init(struct mm_struct *mm)
>  {
> -	mm->pasid = IOMMU_PASID_INVALID;
> +	mm->iommu_mm = &default_iommu_mm;
>  }
>  static inline bool mm_valid_pasid(struct mm_struct *mm)
>  {
> -	return mm->pasid != IOMMU_PASID_INVALID;
> +	return mm->iommu_mm->pasid != IOMMU_PASID_INVALID;
>  }

And these can now just test if the iommu_mmu->sva_domain is NULL

Jaon
