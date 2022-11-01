Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E746614ACF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKAMgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAMf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:35:58 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866E017E18;
        Tue,  1 Nov 2022 05:35:57 -0700 (PDT)
Received: from [172.20.1.180] (unknown [62.168.35.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id ADB7A4322D;
        Tue,  1 Nov 2022 12:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667306155;
        bh=yMqVNQ37QE/swhD8lx9zl7UI7paDGjPB00joSztAPmc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=NRxBwuer4t7KCW2gfFyggTHYWsjAXZ9haWFs8cVWsYB8EPqoHgq5gFBj5w0jP/fA0
         Le4Wme5QVbHe89ysv9n44tP7rJU4tDxq1FPPfWRox9wks+KiqKK6YBfjPDcQ6gLAYF
         mSRWtKfl00ZG0Cp81nGs5obenLhtnmOcq7Q9TiewYebGxH7K8kRP168jP7TyTFuIQx
         zx0X3lfKgzJgAamaOhdq6MqhjJU4RMNHlC/8qbXLlT7IqH8i5dTlePhTJH21UdHffr
         tpZ3c0Jbyy8ojGZEAWUOGsvh5GGj+6sl5azKLbg3JM1uxAVQ3Q4lJjsC2P+1BkjVv5
         vVI0aU2tLzncg==
Message-ID: <39d370af-9e7f-f487-8448-3ee6bcbfc9f4@canonical.com>
Date:   Tue, 1 Nov 2022 05:35:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] apparmor: Add __init annotation to
 aa_{setup/teardown}_dfa_engine()
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221029012505.227136-1-xiujianfeng@huawei.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221029012505.227136-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 18:25, Xiu Jianfeng wrote:
> The aa_setup_dfa_engine() and aa_teardown_dfa_engine() is only called in
> apparmor_init(), so let us add __init annotation to them.
> 
> Fixes: 11c236b89d7c ("apparmor: add a default null dfa")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree


> ---
>   security/apparmor/match.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> index 5095c26ca683..b97ef5e1db73 100644
> --- a/security/apparmor/match.c
> +++ b/security/apparmor/match.c
> @@ -31,7 +31,7 @@ static char stacksplitdfa_src[] = {
>   };
>   struct aa_dfa *stacksplitdfa;
>   
> -int aa_setup_dfa_engine(void)
> +int __init aa_setup_dfa_engine(void)
>   {
>   	int error;
>   
> @@ -59,7 +59,7 @@ int aa_setup_dfa_engine(void)
>   	return 0;
>   }
>   
> -void aa_teardown_dfa_engine(void)
> +void __init aa_teardown_dfa_engine(void)
>   {
>   	aa_put_dfa(stacksplitdfa);
>   	aa_put_dfa(nulldfa);

