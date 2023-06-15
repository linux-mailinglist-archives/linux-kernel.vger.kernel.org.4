Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BE4730E70
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242853AbjFOE5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjFOE5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:57:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FA92121;
        Wed, 14 Jun 2023 21:57:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EC566135A;
        Thu, 15 Jun 2023 04:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D6DC433C0;
        Thu, 15 Jun 2023 04:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686805061;
        bh=NI50AhFx7ZUwE6ybmdWA7qMYMJyQVxtZkX6gjLq3zPM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PlwlekPq2XT7vEW0OSLt6fILJ7HBbX5t13BYhYUVaP6OaTqAonp6H0nfvQfsh4I+y
         rfwrm3vjfptTqULiByp//aPmWQsj//9fB/WSM5zAyIx59nURG0NzGXfXi8QQBqcAqZ
         gK3K9mVhnMa4oKX6lwF6DMuhZK4Hh63QgQdvy93QFMqozZxa/m/44Z4DQcHJ+gWPJp
         t+Elf11F/GOBooDDlOEqqA7miWU0oa0GYhEHnh55Zp/+z6LSvEEW6fbIq66hZO3dNT
         x/7/P4JFxUCzGPdPEStb9Ssh0QekmsX7m9A9IoVfuUdvHr7SVgFIDlBlwdsnzQl4ln
         MVOsd5zDwMWIA==
Message-ID: <9633f1a6-2e33-4a40-3fdb-0c1c4e4cd720@kernel.org>
Date:   Thu, 15 Jun 2023 13:57:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Waking up from resume locks up on sr device
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Hannes Reinecke <hare@suse.de>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com>
 <ZIQ6bkau3j6qGef8@duo.ucw.cz>
 <07d6e2e7-a50a-8cf4-5c5d-200551bd6687@gmail.com>
 <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
 <b2cf6d96-a55a-d444-d22e-e9b3945ba43f@jmbreuer.net>
 <84f1c51c-86f9-04b3-0cd1-f685ebee7592@kernel.org>
 <37ed36f0-6f72-115c-85fb-62ef5ad72e76@suse.de>
 <b0fdf454-b2f7-c273-66f5-efe42fbc2807@kernel.org>
 <859f0eda-4984-4489-9851-c9f6ec454a88@rowland.harvard.edu>
 <41b069c7-8723-4507-3e5a-1d1878db9002@kernel.org>
 <20230615044015.GA4720@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230615044015.GA4720@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 13:40, Christoph Hellwig wrote:
> On Thu, Jun 15, 2023 at 09:10:28AM +0900, Damien Le Moal wrote:
>>> Here's what commit e27829dc92e5 ("scsi: serialize ->rescan against 
>>> ->remove", written by Christoph Hellwig) says:
>>>
>>>     Lock the device embedded in the scsi_device to protect against
>>>     concurrent calls to ->remove.
>>>
>>> That's the commit which added the device_lock() call.
>>
>> Thanks for the information.
>>
>> +Christoph
>>
>> Why is adding the device_lock() needed ? We could just do a
>> scsi_device_get()+scsi_device_put() to serialize against remove. No ?
> 
> No.  scsi_device_get just increments a reference count, and thus
> prevents ->release from beeing called.  ->remove is not in any way
> affected by the refcount.

What ->remove cb are you talking about ? The gendev one ?
I am trying to understand why the use of device_lock() helps in any way given
that this is not used by any other functions in scsi. And given that
scsi_rescan_device() should always be called with a ref on the scsi device (and
so on the gendev as well) held, why would this function be racy with device remove ?

Note that I did find a couple of places where scsi_rescan_device() seems to not
be called with a reference to the scsi dev held, e.g.  store_rescan_field() and
store_state_field().

-- 
Damien Le Moal
Western Digital Research

