Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611B0610DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJ1JvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJ1JuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:50:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A52F2702;
        Fri, 28 Oct 2022 02:49:47 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MzHhK46HhzmVg3;
        Fri, 28 Oct 2022 17:44:49 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 17:49:45 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 17:49:44 +0800
Message-ID: <efa643b7-f841-19cf-87cd-40cb9eafb50a@huawei.com>
Date:   Fri, 28 Oct 2022 17:49:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Steffen Maier <maier@linux.ibm.com>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
References: <20221028020026.2870104-1-haowenchao@huawei.com>
 <cc9faad6-223f-23b2-2fcc-4b58916d13f0@oracle.com>
From:   Wenchao Hao <haowenchao@huawei.com>
In-Reply-To: <cc9faad6-223f-23b2-2fcc-4b58916d13f0@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggpeml500019.china.huawei.com (7.185.36.137) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/10/28 5:02, Mike Christie wrote:
> On 10/27/22 9:00 PM, Wenchao Hao wrote:
>> @@ -1779,6 +1803,7 @@ static int iscsi_user_scan_session(struct device *dev, void *data)
>>  		goto user_scan_exit;
>>  	}
>>  	id = session->target_id;
>> +	session->target_state = ISCSI_SESSION_TARGET_BOUND;
>>  	spin_unlock_irqrestore(&session->lock, flags);
>>  
>>  	if (id != ISCSI_MAX_TARGET) {
>> @@ -1899,6 +1924,7 @@ static void __iscsi_unblock_session(struct work_struct *work)
>>  	cancel_delayed_work_sync(&session->recovery_work);
>>  	spin_lock_irqsave(&session->lock, flags);
>>  	session->state = ISCSI_SESSION_LOGGED_IN;
>> +	session->target_state = ISCSI_SESSION_TARGET_ALLOCATED;
> 
> I think there are 2 issues with setting this to ISCSI_SESSION_TARGET_ALLOCATED
> here.
> 
> 1. We allocated the target_id in iscsi_add_session so it's weird to set
> the state late above.
> 2. We call the above function when we relogin, so it overwrites 
> ISCSI_SESSION_TARGET_BOUND.
> 
> I think we can just do:
> 
> @@ -1785,7 +1785,12 @@ static int iscsi_user_scan_session(struct device *dev, void *data)
>  		if ((scan_data->channel == SCAN_WILD_CARD ||
>  		     scan_data->channel == 0) &&
>  		    (scan_data->id == SCAN_WILD_CARD ||
> -		     scan_data->id == id))
> +		     scan_data->id == id)) {
> +
> +			spin_lock_irqsave(&session->lock, flags);
> +			session->target_state = ISCSI_SESSION_TARGET_SCANNED;
> +			spin_unlock_irqsave(&session->lock, flags);
> +
>  			scsi_scan_target(&session->dev, 0, id,
>  					 scan_data->lun, scan_data->rescan);
>  	}
> @@ -1972,6 +1977,7 @@ static void __iscsi_unbind_session(struct work_struct *work)
>  		goto unbind_session_exit;
>  	}
>  
> +	session->target_state = ISCSI_SESSION_TARGET_UNBINDING;
>  	target_id = session->target_id;
>  	session->target_id = ISCSI_MAX_TARGET;
>  	spin_unlock_irqrestore(&session->lock, flags);
> @@ -1983,6 +1989,10 @@ static void __iscsi_unbind_session(struct work_struct *work)
>  		ida_free(&iscsi_sess_ida, target_id);
>  
>  unbind_session_exit:
> +	spin_lock_irqsave(&session->lock, flags);
> +	session->target_state = ISCSI_SESSION_TARGET_UNBOUND;
> +	spin_unlock_irqrestore(&session->lock, flags);
> +
>  	iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
>  	ISCSI_DBG_TRANS_SESSION(session, "Completed target removal\n");
>  }
> @@ -2061,6 +2071,7 @@ int iscsi_add_session(struct iscsi_cls_session *session, unsigned int target_id)
>  		session->ida_used = true;
>  	} else
>  		session->target_id = target_id;
> +	session->target_state = ISCSI_SESSION_TARGET_ID_ALLOCATED;
>  
>  	dev_set_name(&session->dev, "session%u", session->sid);
>  	err = device_add(&session->dev);
> 
> 
> then in userspace we can do:
> 
> 1. if have conn in sysfs
> 	if session->target_state == ISCSI_SESSION_TARGET_ID_ALLOCATED
> 		if conn->state == ISCSI_CONN_UP
> 			/*
> 			 * we did the initial login and did a ISCSI_UEVENT_START_CONN
> 			 * but crashed/restarted
> 			 * before we were able to scan.
> 			 */
> 			sync session and scan session
> 		else
> 			/*
> 			 * the initial login didn't happen so
> 			 * just cleanup the kernel. Note: we could also
> 			 * finish setting the conn up but it probably doesn't
> 			 * come up enough to do this.
> 			 */
> 
> 	else if session->target_state == ISCSI_SESSION_TARGET_SCANNED
> 		do normal sync
> 	else if session->target_state == ISCSI_SESSION_TARGET_REMOVING
> 		wait for state to change to ISCSI_SESSION_TARGET_UNBOUND
> 		or setup session/conn in userspace so we can wait for
> 		ISCSI_KEVENT_UNBIND_SESSION then cleanup session/conn.
> 	else if session->target_state == ISCSI_SESSION_TARGET_UNBOUND
> 		cleanup session/conn based on their state and what's in sysfs
> 
>    if no conn in sysfs
> 	cleanup session
> 
> 
> If we are in agreement, then you can take my code above and merge it into
> your patch and resubmit in one patch.
> .

Thanks a lot for your suggestions, I just updated the PR in last night.

I would update this patch according to your suggestions.
