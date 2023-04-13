Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B823A6E0C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDMLJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMLJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:09:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241CB7D9E;
        Thu, 13 Apr 2023 04:09:50 -0700 (PDT)
Received: from frapeml500002.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PxxcV34P2z6J6xl;
        Thu, 13 Apr 2023 19:07:22 +0800 (CST)
Received: from [10.81.209.180] (10.81.209.180) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 13:09:47 +0200
Message-ID: <f9aec7fa-4b7a-65a3-c060-6c69298fc73b@huawei.com>
Date:   Thu, 13 Apr 2023 13:09:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce buffers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Alexander Graf <graf@amazon.com>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
 <0334a54332ab75312c9de825548b616439dcc9f5.1679309810.git.petr.tesarik.ext@huawei.com>
 <20230328040724.GB25506@lst.de>
 <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com>
 <8cf7c515-9ce6-a2ed-0643-972aa3eba2fb@huaweicloud.com>
 <20230407055704.GD6803@lst.de> <20230407121555.4290a011@meshulam.tesarici.cz>
From:   Petr Tesarik <petr.tesarik.ext@huawei.com>
In-Reply-To: <20230407121555.4290a011@meshulam.tesarici.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.81.209.180]
X-ClientProxiedBy: frapeml500008.china.huawei.com (7.182.85.71) To
 frapeml500002.china.huawei.com (7.182.85.205)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/2023 12:15 PM, Petr Tesařík wrote:
> On Fri, 7 Apr 2023 07:57:04 +0200
> Christoph Hellwig <hch@lst.de> wrote:
>[...]>> (Btw, in case anyone is interested, we really need to get started
>> on moving the dma fields out of struct device into a sub-struct
>> only allocated for DMA capable busses)
> 
> I like this idea. In fact, my WIP topic branch now moves the swiotlb
> fields into a separate struct, but I can surely go further and move all
> DMA-related fields.

I have looked into this now, and it looks like a nice cleanup. The
challenge is to get these patches reviewed by all affected maintainers,
and it would be blocking my work on dynamically allocated bounce buffers.

How about moving only some fields initially (coherent override, cma and
swiotlb)? These few are not used outside kernel/dma, but at least the
swiotlb part makes my patches easier to follow. I can move the rest as
soon as the dynamic patch series is merged.

Petr Tesarik

