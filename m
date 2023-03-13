Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FEF6B7487
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjCMKr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCMKrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:47:24 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68E453D94;
        Mon, 13 Mar 2023 03:47:22 -0700 (PDT)
Received: from dungeon.fi (dungeon.fi [81.4.110.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kasper)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4PZtdh1jZbz4BKKw;
        Mon, 13 Mar 2023 12:47:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678704440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jSbOH91PTg5uCkO4mWLFoGuNxDrNUjmjn2W/WzqjsG4=;
        b=s7+pqLETYqZKlqiSeUbRPR2Z13viDOkZRoMgVX7IYUif9IAScHhDof3Trx1M2ntqf6jbcB
        hl+eQ1URyGewhsBj/cOVb5a+oGOE/YFbLJbuvsyiE7aCbE/k6zbjs1RuQp6hvzCpDHUsmA
        qWOawX+tVkMvhHsmwwYOyajalOGwwsGEw5EQl9wYprxkxexBh1TV0UKd0GlRaVIKCq+iBk
        7O34szF59M4UHAV77CxTx1LBZ1nm8xNFZM/ypmFwEfx+q2gpqPu96PyGWNA4HYdnDuewuw
        bIDXRIjIzE7jxKthHNdrt5IeLIb09cUUsNHu0ulLNj8P1ajf/qvL0azaAGdFtQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1678704440; a=rsa-sha256;
        cv=none;
        b=ZoXgvzKxkEOS+CJ1t4pgE8FdBw/E0QfpLT3uaWEK/48t720uqqzed8qxh9WNu2uPZyyKf7
        J90FPD0fBvtkCCL7GxHwqB7ntFAL4vTfntBLpq5kyV5sqe5kJ+5zMONS+zJOgr26kzlKKb
        9LbKftJwK8SQm7EHxjCWqZLjhLvSVGQooJ23XjmoYL4dUB14MJDHtSbrIZAgg5sHeIE51n
        Dmg0JUpef+HNXsF/C52qJSmm1zGDkl3HV0BIFa64s71dWSGarE9OJzlqS2CpumsjLpP1L4
        /ouyqhZoPzUIZ2HgQIJPUd3aJk/TZj9dwtCCgJaNxZA5TUSoeRywMy81NMu8Gw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=kasper smtp.mailfrom=kasper@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1678704440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jSbOH91PTg5uCkO4mWLFoGuNxDrNUjmjn2W/WzqjsG4=;
        b=VIIFLRGvGi/L+TTexCdNMMv+LSD7dwPQ0ZhiP//OlTW3d+pEHfpf1zAWnGzQmASbB+689J
        wKifsmoWRi2tcY1/m/S0P0P8JoAwQwoYpQF4irmjczavpv053S3GNI87GH1JIKwen/aHk7
        OhI3dQRJHb+VwPlESkhYDzYsuZdR9cBwvxnhf9mQhRX0cZtXw+mksTdHrIlk4BQ+058fmt
        +3B6Q4R8scP+KtVb/yKl6lKBO/k8utfwC5jyJButG79o6hHUuzQsNoIWYh1iNSS+hiDVyr
        INfLcW34HiUD7jYv9xcX2fZ4q034LhtvQ7cD5tlgSMqpPAv7BxeTyF/TkSDOVg==
Received: from [IPV6:2001:14ba:440a:f000:f999:2447:3c0c:d88e] (dktgsyyj5xfwfrsyp7cjy-3.rev.dnainternet.fi [IPv6:2001:14ba:440a:f000:f999:2447:3c0c:d88e])
        by dungeon.fi (Postfix) with ESMTPSA id C6AE93F270;
        Mon, 13 Mar 2023 12:47:18 +0200 (EET)
Message-ID: <3c53eca1-ce62-e98d-ee52-269a09480658@iki.fi>
Date:   Mon, 13 Mar 2023 12:47:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZA7Wh2Z/DdKOsOYr@kroah.com>
 <20230313082734.886890-1-kasper@iki.fi>
 <e426ae4c-4e49-5773-e8da-919fa2e3dc33@suse.com>
From:   Jarkko Sonninen <kasper@iki.fi>
In-Reply-To: <e426ae4c-4e49-5773-e8da-919fa2e3dc33@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

     Hello,

It uses only one flag from the struct from user. Would it be better to 
store only that to state ?

Do I need locking at all in that case ?

The whole struct is stored just in case, if someone would implement 
other functionality later.

     - Jarkko


Oliver Neukum kirjoitti 13/03/2023 klo 11.54:
>
>
> On 13.03.23 09:27, Jarkko Sonninen wrote:
>> Add support for RS-485 in Exar USB adapters.
>> RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
>> Gpio mode register is set to enable RS-485.
>>
>> Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
>
>
> Hi,
>
> I am sorry, but locking is really broken here. All these contexts can 
> sleep.
> There is no need for a spinlock. As far as you need locking, just use 
> a mutex.
>
> Secondly, if xr_set_rs485_config() needs locking, so will 
> xr_get_rs485_config()
> or you can get the case that you return half a new and half an old 
> state to user
> space.
>
>     Regards
>         Oliver
