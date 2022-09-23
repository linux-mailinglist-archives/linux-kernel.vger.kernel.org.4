Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3915E77F4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiIWKJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiIWKJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:09:22 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234CC91D96;
        Fri, 23 Sep 2022 03:09:19 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NA31Q6018917;
        Fri, 23 Sep 2022 12:09:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=fknyyhIlHGjzzk+MjxTZmqYQGCNZC6WJzQMhRqLApDk=;
 b=rnSIO2vLboEkRJQX5ucMwo+3YwnIXIrhEHZwGTf9s+AWcOTWcBPclkG6FcBz6AP3tqLq
 FmRBNw5loylsajy1hQGbQHSSjnrVhrbj/OFBXqfAwU0C/QVyuXaxCFYxNT0AV5rgJ3Zd
 aPv5FU2XnhmUJfDlRdcf0gj0m9lt+4n3NRllXwuk/1N1wb55pSUxaueUgF+WMFJqx3SK
 Evl87Jvvjgu2UrYNNVMGCSsFzpCzWB8SExhfIqSbuhjjanBWzd5DalKs19+689i4KOAS
 S4+/BIMYRztp3NCGnBP/tl5dTjjWO51vbSDsw7eWa3C2lYur10dj0iN2Yd2UjgRUoYga 6g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jr11xeura-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 12:09:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9D1CA10002A;
        Fri, 23 Sep 2022 12:09:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8671821D3ED;
        Fri, 23 Sep 2022 12:09:01 +0200 (CEST)
Received: from [10.211.7.228] (10.75.127.44) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 12:09:00 +0200
Message-ID: <a449a357-467f-972a-ca88-220b773157a9@foss.st.com>
Date:   Fri, 23 Sep 2022 12:08:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 0/4] remoteproc: restructure the remoteproc VirtIO
 device
Content-Language: en-US
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To:     Peng Fan <peng.fan@nxp.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
References: <20220826115232.2163130-1-arnaud.pouliquen@foss.st.com>
 <DU0PR04MB9417BE00D9CA0185660A4EB9884F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <3a197588-fa74-acce-d17c-a2c2556b1fe1@foss.st.com>
In-Reply-To: <3a197588-fa74-acce-d17c-a2c2556b1fe1@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_02,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 9/21/22 16:07, Arnaud POULIQUEN wrote:
> Hi Peng,
> 
> On 9/21/22 10:54, Peng Fan wrote:
>> Hi Arnaud,
>>
>>> Subject: [PATCH v8 0/4] remoteproc: restructure the remoteproc VirtIO
>>> device
>>
>> Sorry to get in at this late time, just try to catch up.
>> Not reviewing comments, just have a question,
>> Does remote core firmware requires changes to use this new feature?
> 
> For this series, it is not.
> For the whole work, it should not, but it will probably depend on the
> evolutions related to the reviews and requirements that will come.
> 
>> Does your 4 branches listed below still work with linux-6.x?
> 
> I have to rebase them. Today my github branches are based on v5.18.rc1
> I plan to do this end of this week or next week.
>    
>> Could the multiple vdev still share same mbox channel?
> 
> Yes I'm trying to keep the legacy support of the mailbox in the
> remoteproc platform driver.
> If no mailbox is declared in the virtio subnode it calls the rproc->ops->kick
> 
>>
>> I not own i.MX remote core firmware development, so if no need
>> firmware change, I would like give a try and see how it works.
> 
> Great! That would be nice to have your feedback. 
> Mailbox management is one point, I'm also ineterested in having feedback on 
> the memory regions management
> I will ping you when my work will be rebased on 6.0

My github branches have been rebased on top of thre rproc_next(1d7b61c06dc3)

As a first step you should be able to rebase on my step4-virtio-mailboxes[1]
without any update of your driver. If I did my dev well, I kept the
compatibility with the legacy.

[1] https://github.com/arnopo/linux/commits/step4-virtio-mailboxes

Regards,
Arnaud

> 
> Thanks,
> Arnaud
> 
>>
>> Thanks,
>> Peng.
>>
>>>
>>> 1) Update from V7 [1]:
>>>
>>> - rebase on rproc-next branch [2], commit 729c16326b7f ("remoteproc:
>>> imx_dsp_rproc: fix argument 2 of rproc_mem_entry_init")
>>>   The updates take into account the integration of the
>>>   commit 1404acbb7f68 ("remoteproc: Fix dma_mem leak after
>>> rproc_shutdown")
>>> - add Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org> according
>>> to reviews on V7
>>>
>>>
>>> [1]
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.
>>> org%2Flkml%2F2022%2F7%2F13%2F663&amp;data=05%7C01%7Cpeng.fan%
>>> 40nxp.com%7Ce0e5200d739a48e7439508da87599d14%7C686ea1d3bc2b4c
>>> 6fa92cd99c5c301635%7C0%7C0%7C637971116202643149%7CUnknown%7C
>>> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
>>> CJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=77pEuwAI7Lh61hx1%2B
>>> Hs79Cu0G5KOa6mzQ0PnTC5r8Xk%3D&amp;reserved=0
>>> [2]
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.ke
>>> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fremoteproc%2Flinux.g
>>> it%2Flog%2F%3Fh%3Dfor-
>>> next&amp;data=05%7C01%7Cpeng.fan%40nxp.com%7Ce0e5200d739a48e7
>>> 439508da87599d14%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
>>> C637971116202643149%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
>>> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
>>> C%7C&amp;sdata=iWUSzKkN9BpHwqbO62awIcyVf9PXcftcdt2kytWVR78%3D
>>> &amp;reserved=0
>>>
>>> 2) Patchset description:
>>>
>>> This series is a part of the work initiated a long time ago in the series
>>> "remoteproc: Decorelate virtio from core"[3]
>>>
>>> Objective of the work:
>>> - Update the remoteproc VirtIO device creation (use platform device)
>>> - Allow to declare remoteproc VirtIO device in DT
>>>     - declare resources associated to a remote proc VirtIO
>>>     - declare a list of VirtIO supported by the platform.
>>> - Prepare the enhancement to more VirtIO devices (e.g I2C, audio, video, ...).
>>>   For instance be able to declare a I2C device in a virtio-i2C node.
>>> - Keep the legacy working!
>>> - Try to improve the picture about concerns reported by Christoph Hellwing
>>> [4][5]
>>>
>>> [3]
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.
>>> org%2Flkml%2F2020%2F4%2F16%2F1817&amp;data=05%7C01%7Cpeng.fan
>>> %40nxp.com%7Ce0e5200d739a48e7439508da87599d14%7C686ea1d3bc2b4
>>> c6fa92cd99c5c301635%7C0%7C0%7C637971116202643149%7CUnknown%7
>>> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw
>>> iLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=oPWSfUweLdhUFK5X9
>>> 2YcGHem8s%2Bfelcr%2FHx9JAlKG%2BI%3D&amp;reserved=0
>>> [4]
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.
>>> org%2Flkml%2F2021%2F6%2F23%2F607&amp;data=05%7C01%7Cpeng.fan%
>>> 40nxp.com%7Ce0e5200d739a48e7439508da87599d14%7C686ea1d3bc2b4c
>>> 6fa92cd99c5c301635%7C0%7C0%7C637971116202643149%7CUnknown%7C
>>> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
>>> CJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=HPpnlaykes8R1Kz1dEN
>>> nirEHkDNr7JvRs%2FcsaDPuLdI%3D&amp;reserved=0
>>> [5]
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatc
>>> hwork.kernel.org%2Fproject%2Flinux-
>>> remoteproc%2Fpatch%2FAOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E
>>> %40cp7-web-
>>> 042.plabs.ch%2F&amp;data=05%7C01%7Cpeng.fan%40nxp.com%7Ce0e520
>>> 0d739a48e7439508da87599d14%7C686ea1d3bc2b4c6fa92cd99c5c301635%
>>> 7C0%7C0%7C637971116202643149%7CUnknown%7CTWFpbGZsb3d8eyJWIj
>>> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
>>> 3000%7C%7C%7C&amp;sdata=GtNruefDreOoogL%2BlntAC7GBfk6E1Goq4j%
>>> 2BYXt36RdI%3D&amp;reserved=0
>>>
>>> In term of device tree this would result in such hierarchy (stm32mp1
>>> example with 2 virtio RPMSG):
>>>
>>> 	m4_rproc: m4@10000000 {
>>> 		compatible = "st,stm32mp1-m4";
>>> 		reg = <0x10000000 0x40000>,
>>> 		      <0x30000000 0x40000>,
>>> 		      <0x38000000 0x10000>;
>>>         memory-region = <&retram>, <&mcuram>,<&mcuram2>;
>>>         mboxes = <&ipcc 2>, <&ipcc 3>;
>>>         mbox-names = "shutdown", "detach";
>>>         status = "okay";
>>>
>>>         #address-cells = <1>;
>>>         #size-cells = <0>;
>>>
>>>         vdev@0 {
>>> 		compatible = "rproc-virtio";
>>> 		reg = <0>;
>>> 		virtio,id = <7>;  /* RPMSG */
>>> 		memory-region = <&vdev0vring0>, <&vdev0vring1>,
>>> <&vdev0buffer>;
>>> 		mboxes = <&ipcc 0>, <&ipcc 1>;
>>> 		mbox-names = "vq0", "vq1";
>>> 		status = "okay";
>>>         };
>>>
>>>         vdev@1 {
>>> 		compatible = "rproc-virtio";
>>> 		reg = <1>;
>>> 		virtio,id = <7>;  /*RPMSG */
>>> 		memory-region = <&vdev1vring0>, <&vdev1vring1>,
>>> <&vdev1buffer>;
>>> 		mboxes = <&ipcc 4>, <&ipcc 5>;
>>> 		mbox-names = "vq0", "vq1";
>>> 		status = "okay";
>>>         };
>>> };
>>>
>>> I have divided the work in 4 steps to simplify the review, This series
>>> implements only the step 1:
>>> step 1: Redefine the remoteproc VirtIO device as a platform device
>>>   - migrate rvdev management in remoteproc virtio.c,
>>>   - create a remotproc virtio config ( can be disabled for platform that not
>>> use VirtIO IPC.
>>> step 2: Add possibility to declare and probe a VirtIO sub node
>>>   - VirtIO bindings declaration,
>>>   - multi DT VirtIO devices support,
>>>   - introduction of a remote proc virtio bind device mechanism , =>
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithu
>>> b.com%2Farnopo%2Flinux%2Fcommits%2Fstep2-virtio-in-
>>> DT&amp;data=05%7C01%7Cpeng.fan%40nxp.com%7Ce0e5200d739a48e74
>>> 39508da87599d14%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C
>>> 637971116202643149%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
>>> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
>>> %7C&amp;sdata=XtF%2FQnml3QXFL7rgqST1Z2FotUzoj%2FD57WfiuAVMnr8
>>> %3D&amp;reserved=0
>>> step 3: Add memory declaration in VirtIO subnode =>
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithu
>>> b.com%2Farnopo%2Flinux%2Fcommits%2Fstep3-virtio-
>>> memories&amp;data=05%7C01%7Cpeng.fan%40nxp.com%7Ce0e5200d739
>>> a48e7439508da87599d14%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
>>> C0%7C637971116202643149%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>>> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
>>> 7C%7C%7C&amp;sdata=6gq28c6a1TJ%2FdkvokcEjgy6FKQcKTXSz%2BNAbJPo
>>> mjac%3D&amp;reserved=0
>>> step 4: Add mailbox declaration in VirtIO subnode =>
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithu
>>> b.com%2Farnopo%2Flinux%2Fcommits%2Fstep4-virtio-
>>> mailboxes&amp;data=05%7C01%7Cpeng.fan%40nxp.com%7Ce0e5200d739
>>> a48e7439508da87599d14%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
>>> C0%7C637971116202643149%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
>>> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
>>> 7C%7C%7C&amp;sdata=wfy2euuOPoMmBMIH3BOsGcsEYGSTWsDaRr7ENN
>>> QCK70%3D&amp;reserved=0
>>>
>>> Arnaud Pouliquen (4):
>>>   remoteproc: core: Introduce rproc_rvdev_add_device function
>>>   remoteproc: core: Introduce rproc_add_rvdev function
>>>   remoteproc: Move rproc_vdev management to remoteproc_virtio.c
>>>   remoteproc: virtio: Create platform device for the remoteproc_virtio
>>>
>>>  drivers/remoteproc/remoteproc_core.c     | 154 +++---------------
>>>  drivers/remoteproc/remoteproc_internal.h |  23 ++-
>>>  drivers/remoteproc/remoteproc_virtio.c   | 189 ++++++++++++++++++++---
>>>  include/linux/remoteproc.h               |   6 +-
>>>  4 files changed, 210 insertions(+), 162 deletions(-)
>>>
>>> --
>>> 2.24.3
>>
