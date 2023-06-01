Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D974719A33
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjFAKxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjFAKxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:53:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D1C8107;
        Thu,  1 Jun 2023 03:53:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CE902F4;
        Thu,  1 Jun 2023 03:54:16 -0700 (PDT)
Received: from [10.1.26.32] (e122027.cambridge.arm.com [10.1.26.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 185603F7D8;
        Thu,  1 Jun 2023 03:53:28 -0700 (PDT)
Message-ID: <fca99838-991d-66a7-0c2c-16ae901e3935@arm.com>
Date:   Thu, 1 Jun 2023 11:53:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Content-Language: en-GB
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230525113034.46880-1-tony@atomide.com>
 <f44b5fb0-2345-df07-abab-c04abd6f8a13@arm.com>
 <20230601104431.GX14287@atomide.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230601104431.GX14287@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 11:44, Tony Lindgren wrote:
> Hi,
> 
> * Steven Price <steven.price@arm.com> [230601 10:04]:
>> I haven't studied this change in detail, but I assume the bug is that
>> serial_base_port_device_remove() shouldn't be dropping port_mutex. The
>> below hack gets my board booting again.
> 
> You're right. I wonder how I managed to miss that.. Care to post a proper
> fix for this or do you want me to post it?

I'll post a proper fix shortly. Thanks for the confirmation of the fix.

>> Thanks,
>>
>> Steve
>>
>> Hack fix:
>> ----8<----
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index 29bd5ede0b25..044e4853341a 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -3234,8 +3234,7 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
>>         wait_event(state->remove_wait, !atomic_read(&state->refcount));
>>         state->uart_port = NULL;
>>         mutex_unlock(&port->mutex);
>> -out:
>> -       mutex_unlock(&port_mutex);
>> +out:;
>>  }
> 
> Seems you can remove out here and just do a return earlier instead of goto.

Yes, this was just the smallest change. I'll do it properly with an
early return in the proper patch.

Thanks,

Steve

> Regards,
> 
> Tony

