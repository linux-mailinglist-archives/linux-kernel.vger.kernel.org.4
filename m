Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4016CFE6B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjC3IfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjC3IfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:35:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6867AAD;
        Thu, 30 Mar 2023 01:35:02 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnGtP6PTCz6J7sL;
        Thu, 30 Mar 2023 16:34:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 09:35:00 +0100
Date:   Thu, 30 Mar 2023 09:34:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <yangyicong@hisilicon.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 1/4] hwtracing: hisi_ptt: Make cpumask only present
 online CPUs
Message-ID: <20230330093458.00002c50@Huawei.com>
In-Reply-To: <94e7d85a-d580-94c5-ae2c-fe6a77c21487@huawei.com>
References: <20230315094316.26772-1-yangyicong@huawei.com>
        <20230315094316.26772-2-yangyicong@huawei.com>
        <20230328172409.000021f5@Huawei.com>
        <94e7d85a-d580-94c5-ae2c-fe6a77c21487@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 11:53:14 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> On 2023/3/29 0:24, Jonathan Cameron wrote:
> > On Wed, 15 Mar 2023 17:43:13 +0800
> > Yicong Yang <yangyicong@huawei.com> wrote:
> >   
> >> From: Yicong Yang <yangyicong@hisilicon.com>
> >>
> >> perf will try to start PTT trace on every CPU presented in cpumask sysfs
> >> attribute and it will fail to start on offline CPUs(see the comments in
> >> perf_event_open()). But the driver is using cpumask_of_node() to export
> >> the available cpumask which may include offline CPUs and may fail the
> >> perf unintendedly. Fix this by only export the online CPUs of the node.  
> > 
> > There isn't clear documentation that I can find for cpumask_of_node()
> > and chasing through on arm64 (which is what we care about for this driver)
> > it's maintained via numa_add_cpu() numa_remove_cpu()
> > Those are called in arch/arm64/kernel/smp.c in locations that are closely coupled
> > with set_cpu_online(cpu, XXX);
> > https://elixir.bootlin.com/linux/v6.3-rc4/source/arch/arm64/kernel/smp.c#L246
> > https://elixir.bootlin.com/linux/v6.3-rc4/source/arch/arm64/kernel/smp.c#L303
> > 
> > Now there are races when the two might not be in sync but in this case
> > we are just exposing the result to userspace, so chances of a race
> > after this sysfs attribute has been read seems much higher to me and
> > I don't think we can do anything about that.
> > 
> > Is there another path that I'm missing where online and node masks are out
> > of sync?
> >   
> 
> maybe no. This patch maybe incorrect and I need more investigation, so let's me
> drop it from the series. Tested and everything seems fine now.
> 
> I found this problem and referred to commit 064f0e9302af ("mm: only display online cpus of the numa node")
> which might be the same problem. But seems unnecessary that cpumask_of_node()
> already include online CPUs only.

Seems it was fixed up for arm64 in
7f954aa1a ("arm64: smp: remove cpu and numa topology information when hotplugging out CPMU")

If we could audit all the other architectures it would be great to document
the properties of this cpmuask and possibly simplify the code in the
path you highlight above (assuming no race conditions etc)

Jonathan
 
> 
> Thanks.
> 
> > Jonathan
> > 
> >   
> >>
> >> Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>  
> >   
> >> ---
> >>  drivers/hwtracing/ptt/hisi_ptt.c | 13 +++++++++++--
> >>  1 file changed, 11 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> >> index 30f1525639b5..0a10c7ec46ad 100644
> >> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> >> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> >> @@ -487,9 +487,18 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> >>  			    char *buf)
> >>  {
> >>  	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
> >> -	const cpumask_t *cpumask = cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev));
> >> +	cpumask_var_t mask;
> >> +	ssize_t n;
> >>  
> >> -	return cpumap_print_to_pagebuf(true, buf, cpumask);
> >> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
> >> +		return 0;
> >> +
> >> +	cpumask_and(mask, cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev)),
> >> +		    cpu_online_mask);
> >> +	n = cpumap_print_to_pagebuf(true, buf, mask);
> >> +	free_cpumask_var(mask);
> >> +
> >> +	return n;
> >>  }
> >>  static DEVICE_ATTR_RO(cpumask);
> >>    
> > 
> > .
> >   

