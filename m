Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8074171FFE6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjFBLDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjFBLDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:03:31 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C3ACE;
        Fri,  2 Jun 2023 04:03:29 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 35DCA5FD1D;
        Fri,  2 Jun 2023 14:03:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685703807;
        bh=P21ZCO8cvJf6YwlmF8pYgOOnkYfHNy2KTyAlbb0APBE=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=kmylLnV7Csqk12Xvc0Kg+idFZT1QbN8IU3H1rnWJi24+VlEVvT6mFRIIVlprgmIqm
         7fjR7BL/zgn0viCj8vWO7Vdw2Kjq66n6NME1f2zxetKrwqJrgWat4ClJGF6Myjw/wN
         D49WKauAxcUcTUyWslpRrsM+6ZZ0O6TZVUI9A/ZtBA1J9k4cRNoQHnGomjAHLGva78
         8/s7NJ+4dxuNiX3EeFhMewOPtzyXJ2K8gXCu55KAX5D64nS+7spOzdKA8x3XjE6BZs
         D84N6D0D3f8NrrghoJv34G83VFDkU6zdKcwzb60Zre1iLn+wIkYxoN7Jygj5F+toX6
         cEOqA7RhIlkXw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Jun 2023 14:03:17 +0300 (MSK)
Message-ID: <e6302401-7a07-a2fa-621b-29f62ef60261@sberdevices.ru>
Date:   Fri, 2 Jun 2023 14:03:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v1] leds: trigger: pattern: add support for hrtimer
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>, kernel test robot <lkp@intel.com>
CC:     Pavel Machek <pavel@ucw.cz>, ye xingchen <ye.xingchen@zte.com.cn>,
        Kalle Valo <kvalo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, <kernel@sberdevices.ru>
References: <20230522190412.374474-1-mmkurbanov@sberdevices.ru>
 <202305230549.ekneaQ89-lkp@intel.com> <20230601185116.GL449117@google.com>
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
In-Reply-To: <20230601185116.GL449117@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/02 03:06:00 #21401484
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee,

On 01.06.2023 21:51, Lee Jones wrote:
>>    drivers/leds/trigger/ledtrig-pattern.c: In function 'pattern_init':
>>>> drivers/leds/trigger/ledtrig-pattern.c:454:74: warning: implicit conversion from 'enum <anonymous>' to 'enum pattern_type' [-Wenum-conversion]
>>      454 |         err = pattern_trig_store_patterns(led_cdev, NULL, pattern, size, false);
>>          |                                                                          ^~~~~
>  
> Did you fix this already? 
> 
> I don't see a subsequent submission?

Sure, I intend to send the updated version very soon (hopefully today).

-- 
Best Regards,
Martin Kurbanov
