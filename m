Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3988373A12F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjFVMsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjFVMsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:48:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54B5193;
        Thu, 22 Jun 2023 05:48:14 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MCCCVs028146;
        Thu, 22 Jun 2023 12:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZnXKwDJCmpNLo0BVLBFTTmnOcdUdxoUTDz2INcncd5s=;
 b=Em6+nFh6MIADfcFTsYAwUj4mpD0xvsl0kNY28ypt8NaenRkq6OTTVMvUPipBBiOuLY9A
 UepsZsQCnvzXvFmrXOAyoB354SEMfaaDs+bfOczJhFAkM6u9UW8ey61htjq51RKln7pe
 YFINu+0e7CkcfQEC0k7KS0WawK4669dVyIyDwsuoIopGDW2F6Fln+nEYs5u4LGpbhV4c
 MDbTRnVoBOSgPglVkrxvx8JbgdLfGiafA56Pep+knwqYub6SFQjg1mpjKtHYY4sx1Eo2
 GHQ4cnCr1neHEP0pWlfDIFQFgGSRAdyeKK8S/ZblZnpgYhGwyq+JIepnUwc2j16YRhbN ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcp3k151v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 12:47:29 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MCCF4p028899;
        Thu, 22 Jun 2023 12:47:28 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcp3k150m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 12:47:28 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35M3Pbbp023319;
        Thu, 22 Jun 2023 12:47:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r94f53f9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 12:47:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35MClKer17302058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 12:47:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD5A620040;
        Thu, 22 Jun 2023 12:47:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E07020043;
        Thu, 22 Jun 2023 12:47:18 +0000 (GMT)
Received: from [9.171.1.190] (unknown [9.171.1.190])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 22 Jun 2023 12:47:18 +0000 (GMT)
Message-ID: <2bd0da80754331e00f66c724138d9bbf157e1565.camel@linux.ibm.com>
Subject: Re: [PATCH v10 5/6] iommu/dma: Allow a single FQ in addition to
 per-CPU FQs
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-doc@vger.kernel.org
Date:   Thu, 22 Jun 2023 14:47:18 +0200
In-Reply-To: <20230310-dma_iommu-v10-5-f1fbd8310854@linux.ibm.com>
References: <20230310-dma_iommu-v10-0-f1fbd8310854@linux.ibm.com>
         <20230310-dma_iommu-v10-5-f1fbd8310854@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -L5DK6LIKNXBkDMbv58a_9My2c2n4j5V
X-Proofpoint-ORIG-GUID: Kvl6x-pcaGo5ydQSLF0ieEdnFokEMGpS
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_08,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=897 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-05-24 at 16:53 +0200, Niklas Schnelle wrote:
> In some virtualized environments, including s390 paged memory guests,
> IOTLB flushes are used to update IOMMU shadow tables. Due to this, they
> are much more expensive than in typical bare metal environments or
> non-paged s390 guests. In addition they may parallelize poorly in
> virtualized environments. This changes the trade off for flushing IOVAs
> such that minimizing the number of IOTLB flushes trumps any benefit of
> cheaper queuing operations or increased paralellism.
>=20
> In this scenario per-CPU flush queues pose several problems. Firstly
> per-CPU memory is often quite limited prohibiting larger queues.
> Secondly collecting IOVAs per-CPU but flushing via a global timeout
> reduces the number of IOVAs flushed for each timeout especially on s390
> where PCI interrupts may not be bound to a specific CPU.
>=20
> Let's introduce a single flush queue mode that reuses the same queue
> logic but only allocates a single global queue. This mode is selected by
> dma-iommu if a newly introduced .shadow_on_flush flag is set in struct
> dev_iommu. As a first user the s390 IOMMU driver sets this flag during
> probe_device. With the unchanged small FQ size and timeouts this setting
> is worse than per-CPU queues but a follow up patch will make the FQ size
> and timeout variable. Together this allows the common IOVA flushing code
> to more closely resemble the global flush behavior used on s390's
> previous internal DMA API implementation.
>=20
> Link: https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde0062=
57b6f@arm.com/
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com> #s390
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---

Gentle ping. As stated in the cover letter this version aimed to
resolve the only outstanding feedback of removing the .tune_dma_iommu()
op in favor of a .shadow_on_flush flag in struct dev_iommu. This then
let's the dma-iommu choose a single queue and larger timeouts and IOVA
counts. This leaves the dma-iommu  with full responsibility for the
settings.

Thanks,
Niklas
