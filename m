Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F317054CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjEPROY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjEPROL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:14:11 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D33E83E4
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 10:14:10 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GFMCql029118;
        Tue, 16 May 2023 12:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=Z+Zp8qcTzyrig1+JoX4NpLUtCcN8UTaoOe4jcw3WnrM=;
 b=cPwUb73XDESm9IQOXInw77uxLtBeS2ZEhy8cqAD7Uc2J73fvOsO8JnmtSvI/JM8Uj7SQ
 w7dlzh0EG43GbCMXb4yckNShgUzjiaYcIyZvByanw+X3vuPwJ3WPo2idzR/4S+fuaNlI
 t8gHZFpQoWyBmcSNzKgOgs56EocYEMB49CFh0G4s3mFMNqrw9xnua5Dkorc+cZZCiypG
 Z2Qa4UOlxpqzLiKlru+JOzFx+h/LHK+hpb6uflDEKOovPioT0REVCZ1rXxukB/D16Uw8
 HCND2SxiNH/CHFZTjep/frP9VP0wdmsDp9XsyieOdOpmwn1Gh3Yzl0k0dH4PMdJqUFgM Tw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qj6ymvrp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 12:14:05 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 16 May
 2023 12:14:03 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 May 2023 12:14:03 -0500
Received: from [198.61.64.66] (EDIN4L06LR3.ad.cirrus.com [198.61.64.66])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A9E2EB38;
        Tue, 16 May 2023 17:14:03 +0000 (UTC)
Message-ID: <9a1d96ae-23eb-b979-5c85-ffff057f5e5f@opensource.cirrus.com>
Date:   Tue, 16 May 2023 18:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/5] debugfs: Prevent NULL dereference reading from string
 property
Content-Language: en-US
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20230516160753.32317-1-rf@opensource.cirrus.com>
 <20230516160753.32317-2-rf@opensource.cirrus.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20230516160753.32317-2-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tjmTow5D6Gpr1O0OEqo-Cruc9bjSxskI
X-Proofpoint-ORIG-GUID: tjmTow5D6Gpr1O0OEqo-Cruc9bjSxskI
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/5/23 17:07, Richard Fitzgerald wrote:
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -878,6 +878,9 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
>   		return ret;
>   
>   	str = *(char **)file->private_data;
> +	if (!str)
> +		return simple_read_from_buffer(user_buf, count, ppos, "\n", 1);
> +

Oh, this isn't right. I've somehow sent an older version that is missing
the call to debugfs_file_put(). Sorry. I'll send a v2 chain.
