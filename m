Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824FB64DCF5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiLOOiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLOOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:38:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0814D2E68B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 06:38:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B30161DD7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2746C433EF;
        Thu, 15 Dec 2022 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671115088;
        bh=QRu+xIsFY/9uH7UhtSSOV68HhJrjuEUs3s69HAiHpmo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ELa52evv0WF30IwEMN4T+wKwb52eLJWyYc1ICwwF1sZrRAU7VO5uNWMM2iMdZ9aGs
         eqdOzDDehLlzhNb6aj+l75vag9M3F5H6LBbadbTaWx8HnwOsdGJrXFo7FZf36BC9pH
         wkszOMKjeZ1Wr0DzbaoR/5qNSJoaU9U7xglfxh91/I+p41R9Y3orsg+4RcvYPHah+o
         mQF1YACW2YXKbuzqKb9TjzDVvawKE97krAtWAGj0jWM3bsJaXq+aAAb/NjhNkWzF9e
         YaR1F4Z//he5QlvCThDB33RA5tmIMTJUVjrZL5HLynYhhr1HaAmf59mKdZEodRGUT7
         by0K2lKTayC0w==
Message-ID: <0fb160e1-6948-d805-9262-63d436c01ad4@kernel.org>
Date:   Thu, 15 Dec 2022 22:38:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] f2fs: add missing doc for fault injection sysfs
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221215134844.12951-1-chao@kernel.org>
 <20221215141412.66752-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221215141412.66752-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/15 22:14, Yangtao Li wrote:
> Hi Chao,
> 
>> -What:		/sys/fs/f2fs/<disk>/gc_mode
>> -Date:		October 2022
>> -Contact:	"Yangtao Li" <frank.li@vivo.com>
>> -Description:	Show the current gc_mode as a string.
>> -		This is a read-only entry.
>   
>> -What:		/sys/fs/f2fs/<disk>/discard_urgent_util
>> -Date:		November 2022
>> -Contact:	"Yangtao Li" <frank.li@vivo.com>
>> -Description:	When space utilization exceeds this, do background DISCARD aggressively.
>> -		Does DISCARD forcibly in a period of given min_discard_issue_time when the number
>> -		of discards is not 0 and set discard granularity to 1.
>> -		Default: 80
>> -
>> -What:		/sys/fs/f2fs/<disk>/hot_data_age_threshold
>> -Date:		November 2022
>> -Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
>> -Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
>> -		the data blocks as hot. By default it was initialized as 262144 blocks
>> -		(equals to 1GB).
>> -
>> -What:		/sys/fs/f2fs/<disk>/warm_data_age_threshold
>> -Date:		November 2022
>> -Contact:	"Ping Xiong" <xiongping1@xiaomi.com>
>> -Description:	When DATA SEPARATION is on, it controls the age threshold to indicate
>> -		the data blocks as warm. By default it was initialized as 2621440 blocks
>> -		(equals to 10GB).
> 
> Why delete other node descriptions, mistake?

Oh, my bad, I missed to handle merge confilct correctly, will
fix in v2.

Thanks,

> 
> Thx,
> Yangtao
