Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5D061F86F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiKGQI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiKGQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:08:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A44F20F41
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:08:01 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A7FP1aN004108;
        Mon, 7 Nov 2022 16:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sGNP3t/VS5t8CiFaoNcaIFwb9G2LQ14GZqqeeXLbyTI=;
 b=NfIdxftgqUoJyll44+omONY3NAZNh5StgXfbd2h6gXEZqgJ+FuFo+fFtg7g5sTYZVWrM
 6lGUzh7hDTm0lRIRlAs7iPHhJZqHRUEXF0QqLoH6jnMeS0G8eo4476MYKM75WQT/42/p
 GLj6V1Edk0Yvbpe+T/FWOy97Un1AnQLfmZRyf9GJazEsFmynzQ/9Fm0jtnStLnGyx/AH
 YIyCNosV91ljUjGVlWgmuFVxrjJaN9Vf1zrxUQlEINsVTaCuXsMui3GFZA84NvcyKxsa
 735rdXWuF/o7ibEK+pnTwWEDqomVdNjq9zCqwCimflb9CYFXypWFKSPydM2trg8Ka/Ht DA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kppqj1v2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 16:07:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A7G7U6u027262
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Nov 2022 16:07:30 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 08:07:29 -0800
Message-ID: <6f756dec-b386-a822-5f52-c121c00525b4@quicinc.com>
Date:   Mon, 7 Nov 2022 09:07:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH v3 0/3] new subsystem for compute accelerator devices
Content-Language: en-US
To:     Oded Gabbay <ogabbay@kernel.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20221106210225.2065371-1-ogabbay@kernel.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20221106210225.2065371-1-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ejok4OBQVTOa0uwWOCEAXGmLUF5m1pUV
X-Proofpoint-ORIG-GUID: ejok4OBQVTOa0uwWOCEAXGmLUF5m1pUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 clxscore=1011 adultscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/2022 2:02 PM, Oded Gabbay wrote:
> This is the third version of the RFC following the comments given on the
> second version, but more importantly, following testing done by the VPU
> driver people and myself. We found out that there is a circular dependency
> between DRM and accel. DRM calls accel exported symbols during init and when
> accel devices are registering (all the minor handling), then accel calls DRM
> exported symbols. Therefore, if the two components are compiled as modules,
> there is a circular dependency.
> 
> To overcome this, I have decided to compile the accel core code as part of
> the DRM kernel module (drm.ko). IMO, this is inline with the spirit of the
> design choice to have accel reuse the DRM core code and avoid code
> duplication.
> 
> Another important change is that I have reverted back to use IDR for minor
> handling instead of xarray. This is because I have found that xarray doesn't
> handle well the scenario where you allocate a NULL entry and then exchange it
> with a real pointer. It appears xarray still considers that entry a "zero"
> entry. This is unfortunate because DRM works that way (first allocates a NULL
> entry and then replaces the entry with a real pointer).
> 
> I decided to revert to IDR because I don't want to hold up these patches,
> as many people are blocked until the support for accel is merged. The xarray
> issue should be fixed as a separate patch by either fixing the xarray code or
> changing how DRM + ACCEL do minor id handling.

This sounds sane to me.  However, this appears to be something that 
Matthew Wilcox should be aware of (added for visibility).  Perhaps he 
has a very quick solution.  If not, at-least he might have ideas on how 
to best address in the future.

> The patches are in the following repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git/log/?h=accel_v3
> 
> As in v2, The HEAD of that branch is a commit adding a dummy driver that
> registers an accel device using the new framework. This can be served
> as a simple reference. I have checked inserting and removing the dummy driver,
> and opening and closing /dev/accel/accel0 and nothing got broken :)
> 
> v1 cover letter:
> https://lkml.org/lkml/2022/10/22/544
> 
> v2 cover letter:
> https://lore.kernel.org/lkml/20221102203405.1797491-1-ogabbay@kernel.org/T/
> 
> Thanks,
> Oded.
> 
> Oded Gabbay (3):
>    drivers/accel: define kconfig and register a new major
>    accel: add dedicated minor for accelerator devices
>    drm: initialize accel framework
> 
>   Documentation/admin-guide/devices.txt |   5 +
>   MAINTAINERS                           |   8 +
>   drivers/Kconfig                       |   2 +
>   drivers/accel/Kconfig                 |  24 ++
>   drivers/accel/drm_accel.c             | 322 ++++++++++++++++++++++++++
>   drivers/gpu/drm/Makefile              |   1 +
>   drivers/gpu/drm/drm_drv.c             | 102 +++++---
>   drivers/gpu/drm/drm_file.c            |   2 +-
>   drivers/gpu/drm/drm_sysfs.c           |  24 +-
>   include/drm/drm_accel.h               |  97 ++++++++
>   include/drm/drm_device.h              |   3 +
>   include/drm/drm_drv.h                 |   8 +
>   include/drm/drm_file.h                |  21 +-
>   13 files changed, 582 insertions(+), 37 deletions(-)
>   create mode 100644 drivers/accel/Kconfig
>   create mode 100644 drivers/accel/drm_accel.c
>   create mode 100644 include/drm/drm_accel.h
> 
> --
> 2.25.1
> 

