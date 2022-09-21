Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9D25BFF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiIUN5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIUN5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:57:10 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1107C762;
        Wed, 21 Sep 2022 06:57:08 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LAd6nf018770;
        Wed, 21 Sep 2022 15:57:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=p5n6JZ/MvDLEob3Aq7Bn5o8Qu4JCjzxYZgvJw8uwVQs=;
 b=JPWvisKGbz25bLWkCzC+5hdqpX3/QadFNrmK8rses0QCMTeXpRXrgD057WdC++okwAkt
 6VXfThQxZpGJpomFtEWSO3TYnXryAZwCRzgqvIrO2xnQO0/V8YQAHOJnbbPv5XlVEuZZ
 r0eP+2pJBfIT+67lPfC0gSwqctXYSD6/mqv8GE1rMzZm5uUbKn1Ewdk2SMNCtLdd2OjE
 Ox5+bH3UtXL5bbLOrDQQjGGhbbSFUeKTr5PSh2zkFfrE58xj8firft7xTctb05xjSt2B
 6rIy17JD78KKCK1dVNx4KNBC6VQMEhUsWX36+a/fOM56JPCKTZpUHJ1MwSKafX9VURQg oA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jr11x135c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Sep 2022 15:57:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 047CF100038;
        Wed, 21 Sep 2022 15:57:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EF9E1231517;
        Wed, 21 Sep 2022 15:57:00 +0200 (CEST)
Received: from [10.201.22.245] (10.75.127.49) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 15:56:59 +0200
Message-ID: <8a1c0474-2cb1-3669-a6b0-c2ce0abad88f@foss.st.com>
Date:   Wed, 21 Sep 2022 15:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 0/4] remoteproc: restructure the remoteproc VirtIO
 device
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <andersson@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
References: <20220826115232.2163130-1-arnaud.pouliquen@foss.st.com>
 <20220919223027.GG759648@p14s>
 <66e27df5-7697-446d-df7c-eb50e6d06f46@foss.st.com>
 <20220920202201.GB1042164@p14s> <20220920205147.GC1042164@p14s>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220920205147.GC1042164@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_08,2022-09-20_02,2022-06-22_01
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 9/20/22 22:51, Mathieu Poirier wrote:
> On Tue, Sep 20, 2022 at 02:22:01PM -0600, Mathieu Poirier wrote:
>> On Tue, Sep 20, 2022 at 03:44:18PM +0200, Arnaud POULIQUEN wrote:
>>> Hi Mathieu,
>>>
>>> On 9/20/22 00:30, Mathieu Poirier wrote:
>>>> Hi,
>>>>
>>>> On Fri, Aug 26, 2022 at 01:52:28PM +0200, Arnaud Pouliquen wrote:
>>>>> 1) Update from V7 [1]:
>>>>>
>>>>> - rebase on rproc-next branch [2], commit 729c16326b7f ("remoteproc: imx_dsp_rproc: fix argument 2 of rproc_mem_entry_init")
>>>>>   The updates take into account the integration of the
>>>>>   commit 1404acbb7f68 ("remoteproc: Fix dma_mem leak after rproc_shutdown")
>>>>> - add Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org> according to reviews on V7
>>>>>
>>>>>
>>>>> [1] https://lkml.org/lkml/2022/7/13/663
>>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/log/?h=for-next
>>>>>
>>>>> 2) Patchset description:
>>>>>
>>>>> This series is a part of the work initiated a long time ago in 
>>>>> the series "remoteproc: Decorelate virtio from core"[3]
>>>>>
>>>>> Objective of the work:
>>>>> - Update the remoteproc VirtIO device creation (use platform device)
>>>>> - Allow to declare remoteproc VirtIO device in DT
>>>>>     - declare resources associated to a remote proc VirtIO
>>>>>     - declare a list of VirtIO supported by the platform.
>>>>> - Prepare the enhancement to more VirtIO devices (e.g I2C, audio, video, ...).
>>>>>   For instance be able to declare a I2C device in a virtio-i2C node.
>>>>> - Keep the legacy working!
>>>>> - Try to improve the picture about concerns reported by Christoph Hellwing [4][5]
>>>>>
>>>>> [3] https://lkml.org/lkml/2020/4/16/1817
>>>>> [4] https://lkml.org/lkml/2021/6/23/607
>>>>> [5] https://patchwork.kernel.org/project/linux-remoteproc/patch/AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch/
>>>>>
>>>>> In term of device tree this would result in such hierarchy (stm32mp1 example with 2 virtio RPMSG):
>>>>>
>>>>> 	m4_rproc: m4@10000000 {
>>>>> 		compatible = "st,stm32mp1-m4";
>>>>> 		reg = <0x10000000 0x40000>,
>>>>> 		      <0x30000000 0x40000>,
>>>>> 		      <0x38000000 0x10000>;
>>>>>         memory-region = <&retram>, <&mcuram>,<&mcuram2>;
>>>>>         mboxes = <&ipcc 2>, <&ipcc 3>;
>>>>>         mbox-names = "shutdown", "detach";
>>>>>         status = "okay";
>>>>>
>>>>>         #address-cells = <1>;
>>>>>         #size-cells = <0>;
>>>>>         
>>>>>         vdev@0 {
>>>>> 		compatible = "rproc-virtio";
>>>>> 		reg = <0>;
>>>>> 		virtio,id = <7>;  /* RPMSG */
>>>>> 		memory-region = <&vdev0vring0>, <&vdev0vring1>, <&vdev0buffer>;
>>>>> 		mboxes = <&ipcc 0>, <&ipcc 1>;
>>>>> 		mbox-names = "vq0", "vq1";
>>>>> 		status = "okay";
>>>>>         };
>>>>>
>>>>>         vdev@1 {
>>>>> 		compatible = "rproc-virtio";
>>>>> 		reg = <1>;
>>>>> 		virtio,id = <7>;  /*RPMSG */
>>>>> 		memory-region = <&vdev1vring0>, <&vdev1vring1>, <&vdev1buffer>;
>>>>> 		mboxes = <&ipcc 4>, <&ipcc 5>;
>>>>> 		mbox-names = "vq0", "vq1";
>>>>> 		status = "okay";
>>>>>         };
>>>>> };
>>>>
>>>> I was in the process of applying this set when the last patch gave me a
>>>> checkpatch warning about "virtio,rproc" not being documented.
>>>>
>>>> I suggest to introduce a new "virtio-rproc.yaml" based on this work[1], with the
>>>> above in the example sections.
>>>
>>> Yes I saw the warning, but for this first series it is not possible to declare
>>> the associated "rproc-virtio" device  in device tree.
>>
>> I understand and agree with your position.
>>
>> I am going ahead and merging this set in order for it to get some exposure in
>> linux-next.  That said be on the ready to address potential problems it may
>> cause.

Yes sure!

> 
> I am getting conflicts because of the patches previously applied to rproc-next.
> Please resent a series that applies to "7d7f8fe4e399" and I'll move forward with
> the merge.
> 

I just sent the V9 to address the rebase.

Thanks,
Arnaud


>>
>>> So at this step it seems not make senses to create the devicetree bindings file.
>>> More than that I don't know how I could justify the properties in bindings if
>>> there is not driver code associated.
>>>
>>> So i would be in favor of not adding the bindings in this series but to define
>>> bindings in the first patch of my "step 2" series; as done on my github:
>>> https://github.com/arnopo/linux/commit/9616d89a4f478cf78865a244efcde108d900f69f
>>>
>>> Please let me know your preference.
>>>
>>> Regards,
>>> Arnaud
>>>
>>>
>>>>
>>>> Thanks,
>>>> Mathieu
>>>>
>>>> [1]. https://elixir.bootlin.com/linux/v6.0-rc6/source/Documentation/devicetree/bindings/virtio/virtio-device.yaml
>>>>
>>>>
>>>>>
>>>>> I have divided the work in 4 steps to simplify the review, This series implements only
>>>>> the step 1:
>>>>> step 1: Redefine the remoteproc VirtIO device as a platform device
>>>>>   - migrate rvdev management in remoteproc virtio.c,
>>>>>   - create a remotproc virtio config ( can be disabled for platform that not use VirtIO IPC.
>>>>> step 2: Add possibility to declare and probe a VirtIO sub node
>>>>>   - VirtIO bindings declaration,
>>>>>   - multi DT VirtIO devices support,
>>>>>   - introduction of a remote proc virtio bind device mechanism ,
>>>>> => https://github.com/arnopo/linux/commits/step2-virtio-in-DT
>>>>> step 3: Add memory declaration in VirtIO subnode
>>>>> => https://github.com/arnopo/linux/commits/step3-virtio-memories
>>>>> step 4: Add mailbox declaration in VirtIO subnode
>>>>> => https://github.com/arnopo/linux/commits/step4-virtio-mailboxes
>>>>>
>>>>> Arnaud Pouliquen (4):
>>>>>   remoteproc: core: Introduce rproc_rvdev_add_device function
>>>>>   remoteproc: core: Introduce rproc_add_rvdev function
>>>>>   remoteproc: Move rproc_vdev management to remoteproc_virtio.c
>>>>>   remoteproc: virtio: Create platform device for the remoteproc_virtio
>>>>>
>>>>>  drivers/remoteproc/remoteproc_core.c     | 154 +++---------------
>>>>>  drivers/remoteproc/remoteproc_internal.h |  23 ++-
>>>>>  drivers/remoteproc/remoteproc_virtio.c   | 189 ++++++++++++++++++++---
>>>>>  include/linux/remoteproc.h               |   6 +-
>>>>>  4 files changed, 210 insertions(+), 162 deletions(-)
>>>>>
>>>>> -- 
>>>>> 2.24.3
>>>>>
