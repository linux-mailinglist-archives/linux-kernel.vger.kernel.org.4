Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511D772FC7B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbjFNLcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjFNLco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:32:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281F810CB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:32:43 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qh37K3YrRzqTRl;
        Wed, 14 Jun 2023 19:27:41 +0800 (CST)
Received: from [10.67.110.89] (10.67.110.89) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 19:32:38 +0800
Message-ID: <86c6040d-17ab-fb01-2b75-717d82ba9345@huawei.com>
Date:   Wed, 14 Jun 2023 19:32:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v7] kobject: Fix global-out-of-bounds in
 kobject_action_type()
To:     <gregkh@linuxfoundation.org>, <prajnoha@redhat.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20230518091614.137522-1-xiafukun@huawei.com>
From:   Xia Fukun <xiafukun@huawei.com>
In-Reply-To: <20230518091614.137522-1-xiafukun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.89]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/5/18 17:16, Xia Fukun wrote:
> ---
> v6 -> v7:
> -  Move macro UEVENT_KACT_STRSIZE to the .c file to 
> improve maintainability.
> 

Gentle ping ...

UEVENT_KACT_STRSIZE is defined as the maximum length of the string
contained in kobject_actions[].

At present, the maximum length of strings in this array is 7. Based on
the actual meaning of these strings, these actions will not exceed 16
if there are any subsequent changes.

I have submitted v7 of the patch according to your suggestion and
tested it to ensure its functionality is correct.

Please take the time to review it.

Thank you very much.


> ---
>  lib/kobject_uevent.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 7c44b7ae4c5c..2171e1648dad 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -47,6 +47,14 @@ static LIST_HEAD(uevent_sock_list);
>  /* This lock protects uevent_seqnum and uevent_sock_list */
>  static DEFINE_MUTEX(uevent_sock_mutex);
>  
> +/*
> + * The maximum length of the string contained in kobject_actions[].
> + * If there are any actions added or modified, please ensure that
> + * the string length does not exceed the macro, otherwise
> + * should modify the macro definition.
> + */
> +#define UEVENT_KACT_STRSIZE		16
> +
>  /* the strings here must match the enum in include/linux/kobject.h */
>  static const char *kobject_actions[] = {
>  	[KOBJ_ADD] =		"add",
> @@ -66,7 +74,8 @@ static int kobject_action_type(const char *buf, size_t count,
>  	enum kobject_action action;
>  	size_t count_first;
>  	const char *args_start;
> -	int ret = -EINVAL;
> +	int i, ret = -EINVAL;
> +	char kobj_act_buf[UEVENT_KACT_STRSIZE] = {0};
>  
>  	if (count && (buf[count-1] == '\n' || buf[count-1] == '\0'))
>  		count--;
> @@ -77,21 +86,24 @@ static int kobject_action_type(const char *buf, size_t count,
>  	args_start = strnchr(buf, count, ' ');
>  	if (args_start) {
>  		count_first = args_start - buf;
> +		if (count_first > UEVENT_KACT_STRSIZE)
> +			goto out;
> +
>  		args_start = args_start + 1;
> +		strncpy(kobj_act_buf, buf, count_first);
> +		i = sysfs_match_string(kobject_actions, kobj_act_buf);
>  	} else
> -		count_first = count;
> +		i = sysfs_match_string(kobject_actions, buf);
>  
> -	for (action = 0; action < ARRAY_SIZE(kobject_actions); action++) {
> -		if (strncmp(kobject_actions[action], buf, count_first) != 0)
> -			continue;
> -		if (kobject_actions[action][count_first] != '\0')
> -			continue;
> -		if (args)
> -			*args = args_start;
> -		*type = action;
> -		ret = 0;
> -		break;
> -	}
> +	if (i < 0)
> +		goto out;
> +
> +	action = i;
> +	if (args)
> +		*args = args_start;
> +
> +	*type = action;
> +	ret = 0;
>  out:
>  	return ret;
>  }
