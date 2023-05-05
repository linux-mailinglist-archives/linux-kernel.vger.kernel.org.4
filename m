Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF3B6F8253
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjEELz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjEELz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:55:57 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A591A4AD
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 04:55:54 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3ef69281e68so7563251cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 04:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1683287753; x=1685879753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=szBFeTXcgnKYLfPLuIFAzxMkaRZs5CSgukFz3sIyjig=;
        b=LO4Ii7MgCvK/t2TPTAL8KiO7PhbSdsIaoZBbJ+xhyOrIVLxwoIqJGJl5w84X8jdPJB
         oBM33DX3maempOGCvb++YQQp83kdRUnThnhIhMezWs2bNfIuq01iEtQiJJThfkwsnSpB
         gYvHP8r8dKLUX7vW0rps/C6tckT4Z4XlObmjZMDjDLFw7CH6YD/2n9/vDPl3Z42p7/Sf
         uF1PpAoBMdequAialZvyW42PhHv2Io94OGsWEz/M/TOxiRkAWkVcUTVz8s1eS2/pXOJe
         whvvzSfjVCDxGMgVUt/kIQI+tG89B1Mcp4N7PfR0G/LowFqxKc1rmkQEq8FJ5fnetdcV
         qMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683287753; x=1685879753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szBFeTXcgnKYLfPLuIFAzxMkaRZs5CSgukFz3sIyjig=;
        b=A8nZLIHj273+ia0Rt4USMQoQ8fAQFgyEbegbGChbenvGcgN6BPocKy+7pH9EuXLZyT
         xaq0oBE3GOLz4N/65kWtZ1lIiwx++rAFtx2nGt4a0Gmfk3sBXf/6izalDNN53NhsoOck
         ZknyRf8op7eTi8MFtTE2o6Z94DWrrIyxFGhjKJfHJw6VPazIbShP/Sy1a2tNSHJihaRL
         EujRltrzTiCSScQYOd7zvaZdl0fCGocuMy+QzscKpjjt1qbGVW/bvQTP+ehGmaeFBv7n
         pm7GOv/ZJhHzeK8/kM7+q5EUx/vBEP247mx9WnTjAy93X6MmKqgsoTuf3aFzB/Tzn6Mn
         1dKA==
X-Gm-Message-State: AC+VfDyVi4YSG5ggsVoOaVLwoyPrnu0v5zImwAxT2wx72R6pGesPrKoa
        gWZ4Tz8qszPC65QH3v7+u7kwQA==
X-Google-Smtp-Source: ACHHUZ45H4WDO9Ldo40z/BRMFJTWhg3fJeKIgwJk54ONxr1FMldx7OBn6Rs+XtGWqe+LV1CcStgXOQ==
X-Received: by 2002:a05:622a:15d5:b0:3f1:f8fa:11cd with SMTP id d21-20020a05622a15d500b003f1f8fa11cdmr1799671qty.49.1683287753192;
        Fri, 05 May 2023 04:55:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id fa4-20020a05622a4cc400b003ef311b39d7sm513354qtb.96.2023.05.05.04.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 04:55:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1puu2R-007s7x-Nb;
        Fri, 05 May 2023 08:55:51 -0300
Date:   Fri, 5 May 2023 08:55:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     ye.xingchen@zte.com.cn
Cc:     kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd/selftest: Use fdget() and fdput()
Message-ID: <ZFTux7dKpV5zrQwc@ziepe.ca>
References: <202305051412396252364@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305051412396252364@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 02:12:39PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> convert the fget()/fput() uses to fdget()/fdput().
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/iommu/iommufd/selftest.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 74c2076105d4..d3512fa673a5 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -583,17 +583,16 @@ static const struct file_operations iommfd_test_staccess_fops;
> 
>  static struct selftest_access *iommufd_access_get(int fd)
>  {
> -	struct file *file;
> +	struct fd f = fdget(fd);
> 
> -	file = fget(fd);
> -	if (!file)
> +	if (!f.file)
>  		return ERR_PTR(-EBADFD);

Why are you doing these conversions? This is wrong, fdget has to be
paired with fdput(), since the struct fd doesn't leave the stack frame
it cannot be correct.

I see your other patches have the same problem.

Jason
