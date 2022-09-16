Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F1D5BB23B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiIPSgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIPSgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:36:24 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B5B6D74;
        Fri, 16 Sep 2022 11:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=3p1fjf6+XUColGE3d9QDmsCLNG1nGpDvT5jgoM7KnRc=; b=POMuk+t4ekbySgv39Yia/iPs6n
        cy3NAyVNTyiDpXaWNCB1SlinerYYZaLPIBe+cNzi+eB9otWICfz3CZ3C9sE6DOAUFj44u6bMY7Jpr
        btRK1D2nOrKoX5CJ6n537MRj8/r0z/01ApkyNajDgrcrm6VwGFUk8QZDhlbFB2OLtReHL3xbvumwG
        0Xz0DNi0bQVbe9k1aiWoOQGmK0Zuge2+Cgwk+YQLPBcd6o0chRUa54GwPZPOX2ZUHDSfApxtO6HTp
        5NrrWbdW8qz5YPJbYkaEwOUl0n9xR93zWvO0T9tFVE9E/MS2cNhikPeHRl4eaSrYUd8OnsL6VrBuw
        28QyGFzw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oZGCE-003JPP-GC; Fri, 16 Sep 2022 12:36:15 -0600
Message-ID: <641c8be0-69f6-0ab5-b174-411352ed5f94@deltatee.com>
Date:   Fri, 16 Sep 2022 12:36:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-CA
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        guoqing.jiang@linux.dev, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
References: <20220916113428.774061-1-yukuai1@huaweicloud.com>
 <20220916113428.774061-4-yukuai1@huaweicloud.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220916113428.774061-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: yukuai1@huaweicloud.com, song@kernel.org, guoqing.jiang@linux.dev, pmenzel@molgen.mpg.de, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 3/5] md/raid10: prevent unnecessary calls to wake_up()
 in fast path
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-09-16 05:34, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, wake_up() is called unconditionally in fast path such as
> raid10_make_request(), which will cause lock contention under high
> concurrency:
> 
> raid10_make_request
>  wake_up
>   __wake_up_common_lock
>    spin_lock_irqsave
> 
> Improve performance by only call wake_up() if waitqueue is not empty
> in allow_barrier() and raid10_make_request().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

