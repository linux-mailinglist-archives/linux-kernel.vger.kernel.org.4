Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41206A1DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBXOtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjBXOss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:48:48 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D87243468
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:48:47 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id nf5so13662359qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=61deQ49HnXGkoUkLNggYTHIJjMLpwD5kpbtpJH3iCnI=;
        b=IARloLvK0k+L9uroaj5Qvx7tm4lXWGGmP1t8T0PTO126uWoe2DQSng0vLu0xVnYQ+6
         El7vc2fBLr6VlDCEuMNJ8m9fzdXdFXf3A5Lt0bNRa5QpE5xzEXHUU4ysjhWl6lUC6A1X
         oGoa9UEMJxooU3OOmEHuywHVcZkFNf7o6G6uxsQC8cTpzfqd22c52Fcoqfkt50mPnfVI
         j6q9DEHZ8q1pleHO1Z2J5MfKy3Rp4670r+xg8UYHiLSKV40XjgMsSyrdq3W0QpMQAu0V
         Js9XapnoDopAoqcIe+v4fsgUbioJ0Gmbw/OHNztEk01neHcKKu2RhDh0PXtmJsafaR2y
         5D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61deQ49HnXGkoUkLNggYTHIJjMLpwD5kpbtpJH3iCnI=;
        b=cC4rQ457TZH5auxuOLoBsi8VgHyFsT9DMIh50RyzG3tEtRyavEupMFwOxRm19j6xtH
         Ndz+opgBd8isYnG1jXo81rfaY9cq7Cb2YcUW6pPGWNxbTx04bN3jdJtoA6GBHn7bccUR
         dCCYtiBrszFBbGJ0JKOjbFyQJB0hXiAJgoCNGA64jLcOK02nwMBj9L8ajE3+yx0WWCX8
         QLAYHVDk0ebXXXqH8dscJPdN5WgaX2hRuo6JOI7wunQ1pCqCNEgVzMCp//j+8SsK9viW
         h77zKPLycNltEnTFWebLk369Rm9Uyj/z/OMSQMfJ4AuQiBKk4K+rVmCH8xiseoAp3Bp1
         qhYA==
X-Gm-Message-State: AO0yUKU82Kv1BxculpRkc7gdw/1bi4+llOzqpx2POWor0EHSKci/1tO6
        6WxSLvi+BlxJ6up33JgWV3jOPnVqH3DVCPDe
X-Google-Smtp-Source: AK7set9sya6q6kit2OuLNVamL/ohelX01lcDgOn+JTcXXrN3qsxwx8LToTpLoTX+kGW1TkDJM3uXYg==
X-Received: by 2002:a05:6214:e62:b0:56e:9a34:4eaf with SMTP id jz2-20020a0562140e6200b0056e9a344eafmr22780499qvb.36.1677250126510;
        Fri, 24 Feb 2023 06:48:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id i124-20020a378682000000b0071d0f1d01easm6688147qkd.57.2023.02.24.06.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 06:48:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pVZNN-008N83-0x;
        Fri, 24 Feb 2023 10:48:45 -0400
Date:   Fri, 24 Feb 2023 10:48:45 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     baolu.lu@intel.com, yi.l.liu@intel.com, kevin.tian@intel.com,
        heng.su@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [Syzkaller & bisect] There was "iommufd_test" WARNING in v6.2 in
 guest
Message-ID: <Y/jOTXCgySjAQnuX@ziepe.ca>
References: <Y/hOiilV1wJvu/Hv@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/hOiilV1wJvu/Hv@xpf.sh.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 01:43:38PM +0800, Pengfei Xu wrote:
> Hi Jason,
> 
> Greeting!
> 
> Platform: ADL-S and x86 platforms
> Host kernel 6.2.0-rc7 which doesn't enable iommufd by host kconfig setting as
> below:
> "# CONFIG_IOMMUFD is not set"
> 
> Guest kconfig with iommufd enabled: https://github.com/xupengfe/syzkaller_logs/blob/main/230224_044002_iommufd_test/kconfig_origin
> Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230224_044002_iommufd_test/repro.c
> v6.2 problem dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230224_044002_iommufd_test/v6.2_c9c3395d5e3dcc6daee66c6908354d47bf98cb0c_dmesg.log
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230224_044002_iommufd_test/bisect_info.log
> 
> There was "iommufd_test" WARNING in v6.2 in guest:
> [   32.012827] ------------[ cut here ]------------
> [   32.013027] WARNING: CPU: 1 PID: 393 at drivers/iommu/iommufd/selftest.c:403 iommufd_test+0xb19/0x16f0
> [   32.013410] Modules linked in:

I didn't include the IOMMU_TEST_OP_MD_CHECK_REFS in the syzkaller
descriptions, how did you hit this?

Anyhow, it is a small issue in the test suite because uptr + length overflows:

--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -568,13 +568,17 @@ static int iommufd_test_md_check_refs(struct iommufd_ucmd *ucmd,
                                      void __user *uptr, size_t length,
                                      unsigned int refs)
 {
-       if (length % PAGE_SIZE || (uintptr_t)uptr % PAGE_SIZE)
+       uintptr_t end;
+
+       if (length % PAGE_SIZE || (uintptr_t)uptr % PAGE_SIZE ||
+           check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end))
                return -EINVAL;

Jason
