Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7F56D4C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjDCPnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjDCPnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:43:32 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0E230C6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=XmdBpYwnOs51Nmbqcym1o49LO1jgjUjPoYETGLOOPD4=; b=s2NYyKbc5/JjqjKlqp6XZM6XTF
        CeNzU4ZPFJUWFZeVM6zxbdb2sMyQYYh9aR6pcuvWQQ2yv0mjmpR3K5mlucKH372acyzcCgBbcSZBm
        Bk15/WVNOFVZTX4VGHIBwLEPxRpmNkbZfK0DPfYpI/17PqktHCRynlzZDrxz5UlrSAcG1XAriYY5k
        o8vQFt6bWuQhsxPibMouy//s0I7f9JiKS+XJnw77+FS4Z+YQw8dPKIyXvUO8+pe3R2VBwJ8WkcoIi
        pNhWuU2KDJfxxTzWjrRbjSjZWOu4PnNFgqCfcOBjoc3sGjF5wBxbt3nArzQmg1+ht1zsz5tEbGYQB
        l0R5mm/g==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1pjML5-00H4zq-Mv; Mon, 03 Apr 2023 09:43:24 -0600
Message-ID: <b3d5db24-7a88-3e23-03d5-fe4b0ee9f3e6@deltatee.com>
Date:   Mon, 3 Apr 2023 09:43:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Cai Xinchen <caixinchen1@huawei.com>
References: <2023040244-duffel-pushpin-f738@gregkh>
 <2023040250-pushover-platter-509c@gregkh>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <2023040250-pushover-platter-509c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, rafael@kernel.org, jdelvare@suse.com, linux@roeck-us.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kurt.schwemmer@microsemi.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux@dominikbrodowski.net, mporter@kernel.crashing.org, alex.bou9@gmail.com, jejb@linux.ibm.com, martin.petersen@oracle.com, dgilbert@interlog.com, jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org, hdegoede@redhat.com, akpm@linux-foundation.org, wangweiyang2@huawei.com, yangyingliang@huawei.com, jakobkoschel@gmail.com, caixinchen1@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Subject: Re: [PATCH 4/5] driver core: class: remove struct class_interface *
 from callbacks
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-02 11:58, Greg Kroah-Hartman wrote:
> The add_dev and remove_dev callbacks in struct class_interface currently
> pass in a pointer back to the class_interface structure that is calling
> them, but none of the callback implementations actually use this pointer
> as it is pointless (the structure is known, the driver passed it in in
> the first place if it is really needed again.)
> 
> So clean this up and just remove the pointer from the callbacks and fix
> up all callback functions.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Matt Porter <mporter@kernel.crashing.org>
> Cc: Alexandre Bounine <alex.bou9@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Doug Gilbert <dgilbert@interlog.com>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Wang Weiyang <wangweiyang2@huawei.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> Cc: Jakob Koschel <jakobkoschel@gmail.com>
> Cc: Cai Xinchen <caixinchen1@huawei.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, subsystem maintainers, this should go through my driver-core tree
> as it's part of a larger cleanup of 'struct class' handling.  I'm cc:ing
> you all to get reviews to verify I didn't do something foolish, but it
> has passed 0-day bot build testing already (which caught many foolish
> mistakes of mine...)
> 
> 
>  drivers/base/class.c                     |  4 ++--
>  drivers/base/core.c                      | 10 ++++------
>  drivers/hwmon/drivetemp.c                |  4 ++--
>  drivers/net/rionet.c                     |  3 +--
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c   |  6 ++----

For the switchtec changes:

Acked-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan
