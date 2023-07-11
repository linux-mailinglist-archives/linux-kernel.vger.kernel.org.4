Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0BB74F992
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGKVII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjGKVIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:08:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ADE10F2;
        Tue, 11 Jul 2023 14:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=bXiTiMUgJ5wgNi4O9q39ceTcIre3EBRHft3p8v4q4jU=; b=sAbOMecYFOIvVqR8a31WimFxvT
        Upa8xMlkw3aFApRVvOnH3gdglXr09cqPX+5Z3X37W7PAd6zdyDGKPOqXpeO7U72cOwVnbRNlgzu2L
        YHIFNC1hsC4RhRRrqIsmlsqOlhiixCi9UmY2bkLliolKHjr0IS0TfGsdlLimUfver/DPtntzM4hRf
        JEtKtUwk+U8N0jEpCBuHhxsYSst5buW8A7HptyrjnM4mGpwRF8KpCul/47vLMNiH1aINHoHAZtpiQ
        aDqQpLE0Nx5UQbhyXHVDQjdMgu6YKie7A2Fu6Z8owXk9+lvjSj6bnK4yL7yO6bjfcRSFH9Fj1FRIe
        Yz8N2EiQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJKaU-00FtYb-0Y;
        Tue, 11 Jul 2023 21:07:58 +0000
Message-ID: <fc25d296-b245-9a5d-302f-c313f239569e@infradead.org>
Date:   Tue, 11 Jul 2023 14:07:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net] wifi: airo: avoid uninitialized warning in
 airo_get_rate()
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230709133154.26206-1-rdunlap@infradead.org>
 <ZK2QeBZKWi0Q6vuW@corigine.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZK2QeBZKWi0Q6vuW@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 7/11/23 10:25, Simon Horman wrote:
> On Sun, Jul 09, 2023 at 06:31:54AM -0700, Randy Dunlap wrote:
>> Quieten a gcc (11.3.0) build error or warning by checking the function
>> call status and returning -EBUSY if the function call failed.
>> This is similar to what several other wireless drivers do for the
>> SIOCGIWRATE ioctl call when there is a locking problem.
>>
>> drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]
> 
> Hi Randy,
> 
> There seem to be other calls to readStatusRid() in the same file
> with similar properties. Perhaps it would be best to fix them too?
> 

Yes, there are 40+ calls that could have problems.
Please see this thread:
  https://lore.kernel.org/all/2f6ffd1c-a756-b7b8-bba4-77c2308f26b9@infradead.org/

This is an attempt to shut up the build error/warning, which only occurs after
this one function call.

For such an old driver/hardware, I don't plan to do massive surgery
to it.

>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Link: lore.kernel.org/r/39abf2c7-24a-f167-91da-ed4c5435d1c4@linux-m68k.org
>> Cc: Kalle Valo <kvalo@kernel.org>
>> Cc: linux-wireless@vger.kernel.org
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: netdev@vger.kernel.org
>> ---
>>  drivers/net/wireless/cisco/airo.c |    5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff -- a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
>> --- a/drivers/net/wireless/cisco/airo.c
>> +++ b/drivers/net/wireless/cisco/airo.c
>> @@ -6157,8 +6157,11 @@ static int airo_get_rate(struct net_devi
>>  	struct iw_param *vwrq = &wrqu->bitrate;
>>  	struct airo_info *local = dev->ml_priv;
>>  	StatusRid status_rid;		/* Card status info */
>> +	int ret;
>>  
>> -	readStatusRid(local, &status_rid, 1);
>> +	ret = readStatusRid(local, &status_rid, 1);
>> +	if (ret)
>> +		return -EBUSY;
>>  
>>  	vwrq->value = le16_to_cpu(status_rid.currentXmitRate) * 500000;
>>  	/* If more than one rate, set auto */
>>

-- 
~Randy
