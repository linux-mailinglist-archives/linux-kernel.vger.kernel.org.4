Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D295863AD04
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiK1Pxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiK1Pxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:53:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE6F31DDF7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:53:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1F23D6E;
        Mon, 28 Nov 2022 07:53:35 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1CB73F67D;
        Mon, 28 Nov 2022 07:53:25 -0800 (PST)
Message-ID: <8a46bb18-4cc4-dd08-1f06-399d3c875ad8@arm.com>
Date:   Mon, 28 Nov 2022 15:53:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 20/20] iommu: Rename attach_dev to set_dev
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-21-baolu.lu@linux.intel.com>
 <01296f25-b507-c965-9840-119487a00534@arm.com> <Y4TNK9J8NijPbOVZ@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y4TNK9J8NijPbOVZ@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-28 15:00, Jason Gunthorpe wrote:
> On Mon, Nov 28, 2022 at 01:41:56PM +0000, Robin Murphy wrote:
>> On 2022-11-28 06:46, Lu Baolu wrote:
>>> With the retirement of the detach_dev callback, the naming of attach_dev
>>> isn't meaningful anymore. Rename it to set_dev to restore its real
>>> meaning, that is, setting an iommu domain to a device.
>>
>> English grammar alert: this part is confusing, since the usual in-context
>> reading* of "set[ting] X to Y" is going to imply assigning a value of Y to
>> some unique property of X. Given the actual semantic that when we attach the
>> device to the domain, we are setting the (current) domain as a property of
>> the device, I think the most logical and intuitive abbreviation for this
>> method would be set_domain(), where the target device is then clearly
>> implied by the argument (as the target domain was for attach_dev()).
> 
> This is the iommu_domain_ops, it seems a bit weird to call it
> set_domain when it is already acting on a domain object.
> 
> set_device_domain()
> 
> ?

Ah, the iommu_domain_ops split had completely slipped my mind - maybe 
with that additional context, assign_dev() might work well enough to 
maintain the pattern while still being sufficiently different?

Otherwise, set_device_domain() (or just set_dev_domain()) sounds fair to me.

Cheers,
Robin.
