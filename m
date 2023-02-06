Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4845968C5A3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjBFSVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBFSV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:21:29 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD1F1AF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=lpwdT/RuaHygkdvz14Fb8UvvPiz1fNL3mCOd3vJsEEw=; b=ip3K6M+XNCMQTJracKLJExTdzH
        LbFDoB4Vh7CmJfHDujJ3G+QROjd3qLkUOxLk3irWo8mQIV977WJnYe8Z94la7+BU8449Hvoz83UGZ
        JJ5+jWA2ZfDdlfM8C0Wxa6GdmONCwGbftvpUVhpqiMNTRllOmMu1L6ojiTdK7gc/4z7YKGPWd0V8y
        uMFkdkdDSibSDNApkYDi5U3r86ANRinZs3lzD/dqVoGzx9ZlnqdfBB9bhcaDsUUFyLgGXIbYH5sjb
        kv0VbEZu7Armz5FEUSmsy27UOwHl04bsgxiJ1DOjgm9pVZaKJ+vtb2lhO4U57ChVVb0eW291wbXFN
        ZUul8Ecw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1pP67F-005dKL-GY; Mon, 06 Feb 2023 11:21:22 -0700
Message-ID: <16a26e56-3795-50f8-a32f-d3528696847f@deltatee.com>
Date:   Mon, 6 Feb 2023 11:21:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-CA
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <202302020153.4eL3mwiK-lkp@intel.com>
 <6359dcaa-0817-4819-321c-f786809ff89d@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <6359dcaa-0817-4819-321c-f786809ff89d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: chaitanyak@nvidia.com, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, axboe@kernel.dk, lkp@intel.com, hch@lst.de, gregkh@linuxfoundation.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: drivers/pci/p2pdma.c:199:44: sparse: sparse: dereference of
 noderef expression
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-02-06 8:26 a.m., Chaitanya Kulkarni wrote:
> Logan,
> 
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> sparse warnings: (new ones prefixed by >>)
>>>> drivers/pci/p2pdma.c:199:44: sparse: sparse: dereference of noderef expression
>>
>> vim +199 drivers/pci/p2pdma.c
>>
>>     193	
>>     194	static void p2pdma_page_free(struct page *page)
>>     195	{
>>     196		struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
>>     197		struct percpu_ref *ref;
>>     198	
>>   > 199		gen_pool_free_owner(pgmap->provider->p2pdma->pool,
>>     200				    (uintptr_t)page_to_virt(page), PAGE_SIZE,
>>     201				    (void **)&ref);
>>     202		percpu_ref_put(ref);
>>     203	}
>>     204	
>>
> 
> Did you get a chance to look into this ?

Oh, I didn't notice that email. Wonder why it took this long for sparse
to see that.

Looks like we need to add a rcu_derference_protected() around the p2pdma
dereference there. I can send a patch later this week.

Thanks,

Logan
