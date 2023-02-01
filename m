Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0581268664D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjBAM5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBAM5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:57:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3954442DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:57:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47E8F61761
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA15CC433EF;
        Wed,  1 Feb 2023 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675256257;
        bh=8dtRUXoHN3LUlKfLhDcM61zlUbHfbbjOfI95C6JYLAQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=ClPgW21A6heaqpnKL9sHaOtJyXrz4nRxyJGWAswMJH4Pkh0PHJR9aHJ1Wfpu+HfVi
         YX5GsyUMi07pvqxP4D6tidoBz01e4C5d1eb0DD0Wm5sJkqjabGEc1gnpERxIWpbHFc
         czGQH8MIjGF/xwIS8G/I9VcLGAkpjHUlzm4dwjXDRVzU0NFMQYskxw2GQwrkhNx7RJ
         3conp0KsLw0K1SDcEoc97wukWESVfsXDvrav2JH9XiDFAvuT6lxOA9i9ozv5zj9sPJ
         7aBWmyrtXQuHmrTi+1Ir8z7uWeuGJZENfpqVDCvw1jxLiVypVVp+meyClsa9rjsLX9
         TbKOmuyVK5xYQ==
Message-ID: <938a8e61-4e47-1acc-938c-c90d213d2c86@kernel.org>
Date:   Wed, 1 Feb 2023 20:57:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     qixiaoyu <qxy65535@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     xiongping1@xiaomi.com, qixiaoyu1@xiaomi.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230113125859.15651-1-qixiaoyu1@xiaomi.com>
 <20230116030850.20260-1-qixiaoyu1@xiaomi.com>
 <7c12ebaa-4d3d-e475-dfb2-7b459cd26e64@kernel.org>
 <Y9ZWDVV3HJ431Fis@mi-HP-ProDesk-680-G4-MT>
 <Y9pZqOMBipT2NZk0@mi-HP-ProDesk-680-G4-MT>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/2 v2] f2fs: fix wrong calculation of block age
In-Reply-To: <Y9pZqOMBipT2NZk0@mi-HP-ProDesk-680-G4-MT>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/1 20:23, qixiaoyu wrote:
>>>
>>> How about updating as below to avoid lossing accuracy if new is less than 100?
>>>
>>> return div_u64(new * (100 - LAST_AGE_WEIGHT), 100) +
>>> 		div_u64(old * LAST_AGE_WEIGHT, 100);
>>>
>>> Thanks,
>>>
>>
>> We want to avoid overflow by doing the division first. To keep the accuracy, how

Alright,

>> about updating as below:
>>
>> 	res = div_u64_rem(new, 100, &rem_new) * (100 - LAST_AGE_WEIGHT)
>> 		+ div_u64_rem(old, 100, &rem_old) * LAST_AGE_WEIGHT;
>> 	res += rem_new * (100 - LAST_AGE_WEIGHT) / 100 + rem_old * LAST_AGE_WEIGHT / 100;
>> 	return res;

if (rem_new)
	res += rem_new * (100 - LAST_AGE_WEIGHT) / 100;
if (rem_old)
	res += rem_old * LAST_AGE_WEIGHT / 100;

Otherwise, it looks fine to me. :)

Thanks,

>>
>> Thanks,
>>
> 
> Friendly ping
> 
>>>>    }
>>>>    /* This returns a new age and allocated blocks in ei */
