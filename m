Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101515BF51A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiIUD4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiIUD4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:56:10 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1528561DB3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:56:06 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h188so4662369pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=GdtwTg+D4nT/COBO+AtXOA77edWo+Q4jHVx++0FwAms=;
        b=FYfeDqRO1LSKwsqgAJWNsoPNtSEldUC0H6Ro/IRHBojFppptOvg700LJYDphc720Lu
         AwGdP0+LbUMOsefRSU3lQgmM9wOLWZ3VYPaN3gqn9wBfS2ZD2cejdEOr4MeqxGvDf+Fu
         MNaU0py2W+vFxOgPqL3L+zUlwaplUHzUk84JxSTKMOcPSeLhTt8sfTLtxmZgE4BdQV/r
         4bwoXdNf2FR0aVg0biV43c1zCtfEUS7DPQXH6jAFr2c6gjmC6aq0EewQCFd47pN2R5d2
         VbW+u542DJjTJpvQviZWm4k8nXoEQpQH2eeWBDjn6LBPHfAVdMGPP8F0Nd50vYNie5cD
         IJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=GdtwTg+D4nT/COBO+AtXOA77edWo+Q4jHVx++0FwAms=;
        b=hYOxzbBk1fcfSrhP6SHeT8bUAyoG9x2ETzrMGiLOdoB7feX52vagf8oxRIeJL9JjnI
         CZGsqU9hkCjW3djzkTTxvTHAFseQP9v/i6uXXx3nU/qFaTWH0/1dChTTl1gECtpaNkWM
         VOpM7S5QcI9LUhu6Oz8pnC05vncMCYKr29RFNx0t+Z/Z8jGK8M4SJksYe1aycRnouLmT
         lGxU+yr+jtb/jDuMvbjv+tf4en1noteVuGJiLAgOQz7Wa/AyzfzkavTFm9YZWBMTtkSU
         niqBkGyeUxTwg9o7hC9ahLBCD0UWbOlWhOGKf74YxOuXfc/+m36zWdm5mZTHCyGhxABK
         M1/A==
X-Gm-Message-State: ACrzQf0XuPOpSfCrHUm4uR5BS+MivBQzmKHlBLWX9srU0xQRyI8aGGJh
        CR+ALTBwEaU27AHan0zAwddT8Q==
X-Google-Smtp-Source: AMsMyM7jK+7f/QgumLk3HUuCmU3usUyavWCyyZrAZ2qV4NLFFk8ZX3rgB3gpYH/3bRun7nZ7Lvpqdw==
X-Received: by 2002:a63:b64:0:b0:439:8143:c184 with SMTP id a36-20020a630b64000000b004398143c184mr22774576pgl.22.1663732565567;
        Tue, 20 Sep 2022 20:56:05 -0700 (PDT)
Received: from [10.255.231.119] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id z9-20020a62d109000000b0053e794e66fcsm773263pfg.107.2022.09.20.20.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 20:56:05 -0700 (PDT)
Message-ID: <bdcf9676-7846-1f14-1dd1-80cb9dcb0794@bytedance.com>
Date:   Wed, 21 Sep 2022 11:55:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH v2] iommu/iova: Optimize alloc_iova with rbtree_augmented
To:     "wangjie (L)" <wangjie125@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, haifeng.zhao@linux.intel.com,
        john.garry@huawei.com
References: <20220824095139.66477-1-zhangpeng.00@bytedance.com>
 <42909903-5b6c-efe8-9ed3-3ac012f1a421@huawei.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <42909903-5b6c-efe8-9ed3-3ac012f1a421@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch seems to solve the performance issues i have.  Currently my 
> nic's rx performance is unstable in large-capacity scenarios. I applied 
> this patch to 5.19 rc4 and tested 8 times rx performance in these 
> scenes. Here are test results, "before" row is the result of 5.19 rc4. 
> "after" row means 5.19 rc4 with this patch, the unit is Mbits/s
> 
>      1    2    3    4    5    6    7    8
> before    55430    76701    84194    77560    88292    90106    87770    
> 77273
> after    92770    92767    92792    92764    92742    92696    92781    
> 92756
> 
> Obviously, after using this patch, the performance is stable.

Thank you for your test. Can you add a "Tested-by" token?
I plan to update the commit message in the next version.
