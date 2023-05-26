Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE3B712BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbjEZRfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEZRf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:35:27 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E519CA4;
        Fri, 26 May 2023 10:35:26 -0700 (PDT)
Received: from [10.10.2.69] (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id 25D1144C1026;
        Fri, 26 May 2023 17:35:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 25D1144C1026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1685122525;
        bh=dYeLF47soPl7A+3mco/KP4CbNt6s64UADpsf1OpQymM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pVeC0NSqyg0BQdlFdDE7MRCx9srs21kp9uSABHpC+mn3dAYyafLGtt/eD76tf+2Cc
         GkzTa70/deJoETlL7/UJCZXxzSQB+7co8if99rWDXJD4aCK3oJu7c5W7LBs0HHDBQx
         g5rpo9OEg2lALO1J/ndZkhVMg1Mpxn+mNxWXoOpY=
Message-ID: <09834e8d-ca48-e21d-fd96-9de87294a7f4@ispras.ru>
Date:   Fri, 26 May 2023 20:35:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] batman-adv: Broken sync while rescheduling delayed work
Content-Language: ru
To:     Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <mareklindner@neomailbox.ch>
Cc:     Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20230526161632.1460753-1-VEfanov@ispras.ru>
 <5834562.MhkbZ0Pkbq@bentobox>
From:   Vlad Efanov <vefanov@ispras.ru>
In-Reply-To: <5834562.MhkbZ0Pkbq@bentobox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven,


cancel_delayed_work_sync() and queue_delayed_work()

use WORK_STRUCT_PENDING_BIT in work->data to synchronize.

INIT_DELAYED_WORK() clears this bit.


The situation is :  __cancel_work_timer() sets WORK_STRUCT_PENDING_BIT

but INIT_DELAYED_WORK() in batadv_dat_start_timer() clears it

and queue_delayed_work() schedules new work.


Best regards,

Vlad.

On 26.05.2023 19:49, Sven Eckelmann wrote:
> On Friday, 26 May 2023 18:16:32 CEST Vladislav Efanov wrote:
>> The reason for these issues is the lack of synchronization. Delayed
>> work (batadv_dat_purge) schedules new timer/work while the device
>> is being deleted. As the result new timer/delayed work is set after
>> cancel_delayed_work_sync() was called. So after the device is freed
>> the timer list contains pointer to already freed memory.
> You are most likely right but could you please point out what in the worker is
> checked by the workqueue code that prevents it from being scheduled again?
> (and which seems to be overwritten as your patch seems to suggest)
>
> I think __cancel_work_timer marked the work as canceling but
> batadv_dat_start_timer reinitialized the worked (thus removing this important
> state). Would be nice if you could either correct me or confirm what I think to
> remember.
>
> Kind regards,
> 	Sven
