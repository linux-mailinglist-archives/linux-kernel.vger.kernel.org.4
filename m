Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2811874F720
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjGKRXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjGKRXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:23:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D211711;
        Tue, 11 Jul 2023 10:22:42 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BGmrQ4004850;
        Tue, 11 Jul 2023 17:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Dd4av3OA7sDfdLwFbUft5WszPcE37l6Zz5pV11nT7+w=;
 b=oybR2R5GSqWmiD+UUCyYs9kMaH52iIobJcAe/POJSRCH1Yhmx/lidlfdKcy6LSxbx5Jr
 S2mGuiAgr7scG9dkHZAEFA15XSpz6d6K7PzN83UKT1L60BUOMEsDXdL9974mUrhqwsv2
 9pWkOuNLhXb8UL7LKdNSnivTAAShFCYHVAn9a5JO3+kkjcWkPE4d+Ql2sWc7fUF5KZe9
 4gOd66qpRUNbdQGKcVhgyCLu1kxAOdxJw3JMQgJThdjvRN0XbLO3BDf6ctO43grqi2Uw
 ehr5Kd0fLk2ieRwz/TK8nY45ePPOVmJrCDD18vzgSH/2hSh4euTvGAoLmj/ixCh8Fxa4 4g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsax482h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 17:20:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36BHKpXW018001
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 17:20:51 GMT
Received: from [10.110.47.185] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 11 Jul
 2023 10:20:50 -0700
Message-ID: <7eaf29c9-c2bf-3979-687a-596d3ba538fa@quicinc.com>
Date:   Tue, 11 Jul 2023 10:20:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/client: Send hotplug event after registering a client
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, <javierm@redhat.com>,
        <noralf@tronnes.org>
CC:     <dri-devel@lists.freedesktop.org>,
        Moritz Duge <MoritzDuge@kolahilft.de>,
        Torsten Krah <krah.tm@gmail.com>,
        Paul Schyska <pschyska@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <amd-gfx@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20230710091029.27503-1-tzimmermann@suse.de>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20230710091029.27503-1-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n6Fnwihzb_lU2DPCKZ58uhtNAcMjQTE9
X-Proofpoint-GUID: n6Fnwihzb_lU2DPCKZ58uhtNAcMjQTE9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_09,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110154
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/2023 2:10 AM, Thomas Zimmermann wrote:
> Generate a hotplug event after registering a client to allow the
> client to configure its display. Remove the hotplug calls from the
> existing clients for fbdev emulation. This change fixes a concurrency
> bug between registering a client and receiving events from the DRM
> core. The bug is present in the fbdev emulation of all drivers.
> 
> The fbdev emulation currently generates a hotplug event before
> registering the client to the device. For each new output, the DRM
> core sends an additional hotplug event to each registered client.
> 
> If the DRM core detects first output between sending the artificial
> hotplug and registering the device, the output's hotplug event gets
> lost. If this is the first output, the fbdev console display remains
> dark. This has been observed with amdgpu and fbdev-generic.
> 
> Fix this by adding hotplug generation directly to the client's
> register helper drm_client_register(). Registering the client and
> receiving events are serialized by struct drm_device.clientlist_mutex.
> So an output is either configured by the initial hotplug event, or
> the client has already been registered.
> 
> The bug was originally added in commit 6e3f17ee73f7 ("drm/fb-helper:
> generic: Call drm_client_add() after setup is done"), in which adding
> a client and receiving a hotplug event switched order. It was hidden,
> as most hardware and drivers have at least on static output configured.
> Other drivers didn't use the internal DRM client or still had struct
> drm_mode_config_funcs.output_poll_changed set. That callback handled
> hotplug events as well. After not setting the callback in amdgpu in
> commit 0e3172bac3f4 ("drm/amdgpu: Don't set struct
> drm_driver.output_poll_changed"), amdgpu did not show a framebuffer
> console if output events got lost. The bug got copy-pasted from
> fbdev-generic into the other fbdev emulation.
> 
> Reported-by: Moritz Duge <MoritzDuge@kolahilft.de>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2649
> Fixes: 6e3f17ee73f7 ("drm/fb-helper: generic: Call drm_client_add() after setup is done")
> Fixes: 8ab59da26bc0 ("drm/fb-helper: Move generic fbdev emulation into separate source file")
> Fixes: b79fe9abd58b ("drm/fbdev-dma: Implement fbdev emulation for GEM DMA helpers")
> Fixes: 63c381552f69 ("drm/armada: Implement fbdev emulation as in-kernel client")
> Fixes: 49953b70e7d3 ("drm/exynos: Implement fbdev emulation as in-kernel client")
> Fixes: 8f1aaccb04b7 ("drm/gma500: Implement client-based fbdev emulation")
> Fixes: 940b869c2f2f ("drm/msm: Implement fbdev emulation as in-kernel client")
> Fixes: 9e69bcd88e45 ("drm/omapdrm: Implement fbdev emulation as in-kernel client")
> Fixes: e317a69fe891 ("drm/radeon: Implement client-based fbdev emulation")
> Fixes: 71ec16f45ef8 ("drm/tegra: Implement fbdev emulation as in-kernel client")
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Tested-by: Moritz Duge <MoritzDuge@kolahilft.de>
> Tested-by: Torsten Krah <krah.tm@gmail.com>
> Tested-by: Paul Schyska <pschyska@gmail.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Noralf Trønnes <noralf@tronnes.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: freedreno@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: linux-tegra@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.2+
> ---
>   drivers/gpu/drm/armada/armada_fbdev.c     |  4 ----
>   drivers/gpu/drm/drm_client.c              | 21 +++++++++++++++++++++
>   drivers/gpu/drm/drm_fbdev_dma.c           |  4 ----
>   drivers/gpu/drm/drm_fbdev_generic.c       |  4 ----
>   drivers/gpu/drm/exynos/exynos_drm_fbdev.c |  4 ----
>   drivers/gpu/drm/gma500/fbdev.c            |  4 ----
>   drivers/gpu/drm/msm/msm_fbdev.c           |  4 ----
>   drivers/gpu/drm/omapdrm/omap_fbdev.c      |  4 ----
>   drivers/gpu/drm/radeon/radeon_fbdev.c     |  4 ----
>   drivers/gpu/drm/tegra/fbdev.c             |  4 ----
>   10 files changed, 21 insertions(+), 36 deletions(-)
> 

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
