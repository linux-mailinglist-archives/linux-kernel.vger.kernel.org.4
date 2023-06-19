Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DE0735D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjFSSIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjFSSIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:08:50 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1171B6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:08:45 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id BJIsqZyYl2I9nBJIsq55fS; Mon, 19 Jun 2023 20:08:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1687198120;
        bh=Wx1ETBPrfZZVrxxt24FvjkAxC9Gt56NgyV700P1vzmk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=aJvD697bFSvOXhI7gVn7ySiizq9VhYJ8/bcvjQhj6M/j47SVwIfZsOvhrUiSZncHc
         lMPrrmczuoCUo4jKMIhrcB2MONWjI6lncvMK3TvohySRKeK9arszdNON0uH8fYIP0l
         zbbvXwCLosHjwETZzsiqUhz0LvW9iMFna6X/KluIUVFr5qHJoRr3UWVn0TXcpK6emU
         Wt3HMSaEF/1EL6bCU9X+hfMuuPhfbflNkfHUhZNyjBIl9hvd0KxUUZ8vKXQcmiYWaD
         fKUo4Y3uCp2AKhqv8dMSrh2cZxRvhbGJNHCPoOAwvMaVYTaDfGdzB9YZBPFHs9L2py
         8xIAA9TV9dxwA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Jun 2023 20:08:40 +0200
X-ME-IP: 86.243.2.178
Message-ID: <e74dedeb-8fb0-8abf-5b14-1aae8e1462d2@wanadoo.fr>
Date:   Mon, 19 Jun 2023 20:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Content-Language: fr, en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
 <ba5df67e-534d-6f79-6277-80c755ca7e94@nvidia.com>
 <3decbaf1-250b-9b73-70fd-4cb9a204c452@kernel.dk>
 <00537d0c-159c-a802-6ed8-209109a69660@nvidia.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <00537d0c-159c-a802-6ed8-209109a69660@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28/04/2023 à 01:07, Chaitanya Kulkarni a écrit :
> On 4/27/23 16:01, Jens Axboe wrote:
>> On 4/27/23 4:59?PM, Chaitanya Kulkarni wrote:
>>> On 4/27/23 12:47, Christophe JAILLET wrote:
>>>> Group some variables based on their sizes to reduce holes.
>>>> On x86_64, this shrinks the size of 'struct nvmet_ns' from 520 to 512
>>>> bytes.
>>>>
>>> Although this looks good, we at least need to document what
>>> happens on other arch(s) which are not mentioned in the
>>> commit log ? is there a possibility that someone might come
>>> up with the contradictory data in future for the arch(s) which
>>> arch that are not mentioned here ?
>> The change is certainly not going to make things _worse_ for any arch,
>> so I think that's somewhat of a pointless exercise and an unreasonable
>> ask for something that makes sense on 64-bit arm/x86 and saves half the
>> space.
>>
> 
> disregard my comment, looks good...
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> -ck
> 
> 

Hi,


All my other nvmet patches have reached -next today, but this one seems 
to be missing.

So this is a gentle reminder, in case it got lost somewhere.

CJ
