Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17595E7ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiIWPqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiIWPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:45:42 -0400
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Sep 2022 08:45:26 PDT
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85416FA0DF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1663947926; x=1695483926;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B0Z6lO/AYPTVpzI8xvjmvs6lklWmO2tJS2Pwo6sfTgo=;
  b=RqJVAeYb85F+7KjDbW7D4vMPDC41nP72lEwNmxBiBPeoYqsqfnC70U6b
   0ksqr5Z8MuD99PWjfAZdF5yL6IdPE7geodDu4FXng8ndemzltF2cnzEJJ
   sflMv6iE7AchuTHFv+NGUY+u3xw4dv8p89N8PMumBp7ewaCEa1NTTvTcO
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Sep 2022 08:43:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 08:43:21 -0700
Received: from [10.216.63.150] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 23 Sep
 2022 08:43:19 -0700
Message-ID: <5b013fa2-4ad7-5995-ae6d-52770106272a@quicinc.com>
Date:   Fri, 23 Sep 2022 21:13:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] cgroup: fix cgroup_get_from_id
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Tejun Heo <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <cgroups@vger.kernel.org>, Marco Patalano <mpatalan@redhat.com>,
        Muneendra <muneendra.kumar@broadcom.com>
References: <20220923115119.2035603-1-ming.lei@redhat.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220923115119.2035603-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/23/2022 5:21 PM, Ming Lei wrote:
> cgroup has to be one kernfs dir, otherwise kernel panic is caused,
> especially cgroup id is provide from userspace.
> 
> Reported-by: Marco Patalano <mpatalan@redhat.com>
> Fixes: 6b658c4863c1 ("scsi: cgroup: Add cgroup_get_from_id()")
> Cc: Muneendra <muneendra.kumar@broadcom.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   kernel/cgroup/cgroup.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index e4bb5d57f4d1..5f2090d051ac 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6049,6 +6049,9 @@ struct cgroup *cgroup_get_from_id(u64 id)
>   	if (!kn)
>   		goto out;
>   
> +	if (kernfs_type(kn) != KERNFS_DIR)
> +		goto put;
> +
>   	rcu_read_lock();
>   
>   	cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
> @@ -6056,7 +6059,7 @@ struct cgroup *cgroup_get_from_id(u64 id)
>   		cgrp = NULL;
>   
>   	rcu_read_unlock();
> -
> +put:
>   	kernfs_put(kn);
>   out:
>   	return cgrp;

Good catch.

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
