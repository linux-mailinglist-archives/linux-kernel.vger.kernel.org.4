Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371C1616F86
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKBVSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiKBVSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:18:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC9F2AC2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:18:32 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A2LBxuE027625;
        Wed, 2 Nov 2022 21:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ivz5RbZcb5Miq0dSvL8sFguitJpf9hxvWRqP31OCYsA=;
 b=Cffmb++KimgAuGoAJOAWZIO6Dv53/6VbTYGjfxVISBygACU5DkGYWAIBosiMX5VSkjhi
 UVSFiJz5hmmXI0sHqFPCV5osWPfXzjtIEa4j4YqgyTmC/sBj7XBL0tfK8mWj3TAop7Mv
 Uqu8cjyLrv8uMOdHD4m/+3npbeUKheobprYkfGQ1Wn8lEB5WjPez8MjhgDdHtRnnFgr7
 r3e9m0B4hnNSOKyGbh3KJzIPolp4XYgZkiKeooWG++2UZYTub2uWiwRAn0WWaxmYVCng
 wmscHxseCrVzeUpotRBm8OkMAfJBIXi8ptCRL0lmnH1aMRp0nDiusSrgra5a/2VY/5CM 8Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkm401gcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 21:17:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A2LHhNn025375
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 21:17:43 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 14:17:41 -0700
Message-ID: <7654d9c0-c181-ae6b-96ee-349f20f24b18@quicinc.com>
Date:   Wed, 2 Nov 2022 15:17:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH v2 2/3] accel: add dedicated minor for accelerator
 devices
Content-Language: en-US
To:     Oded Gabbay <ogabbay@kernel.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>
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
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
References: <20221102203405.1797491-1-ogabbay@kernel.org>
 <20221102203405.1797491-3-ogabbay@kernel.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20221102203405.1797491-3-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EvUllNQvDjyy5i4IO_N42kluT8NQatYS
X-Proofpoint-ORIG-GUID: EvUllNQvDjyy5i4IO_N42kluT8NQatYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 mlxlogscore=893 impostorscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211020141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/2022 2:34 PM, Oded Gabbay wrote:
> @@ -24,16 +33,6 @@ static char *accel_devnode(struct device *dev, umode_t *mode)
> 
>   static CLASS_ATTR_STRING(accel_version, 0444, "accel 1.0.0 20221018");
> 
> -/**
> - * accel_sysfs_init - initialize sysfs helpers
> - *
> - * This is used to create the ACCEL class, which is the implicit parent of any
> - * other top-level ACCEL sysfs objects.
> - *
> - * You must call accel_sysfs_destroy() to release the allocated resources.
> - *
> - * Return: 0 on success, negative error code on failure.
> - */

Why are we removing this?

>   static int accel_sysfs_init(void)
>   {
>   	int err;
> @@ -54,11 +53,6 @@ static int accel_sysfs_init(void)
>   	return 0;
>   }
> 
> -/**
> - * accel_sysfs_destroy - destroys ACCEL class
> - *
> - * Destroy the ACCEL device class.
> - */

Again, why remove this?  Adding it in one patch than immediately 
removing it in the next patch seems wasteful.

>   static void accel_sysfs_destroy(void)
>   {
>   	if (IS_ERR_OR_NULL(accel_class))
> @@ -68,11 +62,185 @@ static void accel_sysfs_destroy(void)
>   	accel_class = NULL;
>   }
> 
> +static void accel_minor_release(struct drm_minor *minor)
> +{
> +	drm_dev_put(minor->dev);
> +}
> +
> +/**
> + * accel_open - open method for ACCEL file
> + * @inode: device inode
> + * @filp: file pointer.
> + *
> + * This function must be used by drivers as their &file_operations.open method.

Feels like it would be helpful to have an accel version of 
DEFINE_DRM_GEM_FOPS() which helps accel drivers to get this right

> + * It looks up the correct ACCEL device and instantiates all the per-file
> + * resources for it. It also calls the &drm_driver.open driver callback.
> + *
> + * Return: 0 on success or negative errno value on failure.
> + */
> +int accel_open(struct inode *inode, struct file *filp)
> +{
> +	struct drm_device *dev;
> +	struct drm_minor *minor;
> +	int retcode;
> +
> +	minor = accel_minor_acquire(iminor(inode));
> +	if (IS_ERR(minor))
> +		return PTR_ERR(minor);
> +
> +	dev = minor->dev;
> +
> +	atomic_fetch_inc(&dev->open_count);
> +
> +	/* share address_space across all char-devs of a single device */
> +	filp->f_mapping = dev->anon_inode->i_mapping;
> +
> +	retcode = drm_open_helper(filp, minor);
> +	if (retcode)
> +		goto err_undo;
> +
> +	return 0;
> +
> +err_undo:
> +	atomic_dec(&dev->open_count);
> +	accel_minor_release(minor);
> +	return retcode;
> +}
> +EXPORT_SYMBOL_GPL(accel_open);
