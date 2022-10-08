Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CF05F84D5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 12:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJHKzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 06:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJHKzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 06:55:00 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA4F1835B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 03:54:55 -0700 (PDT)
Received: from [192.168.0.111] (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id 5F3554077B08;
        Sat,  8 Oct 2022 10:54:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5F3554077B08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1665226490;
        bh=RxbB1yCwkeTFutp5YWkMHM13rc/47srQLY5QYj5ZoPY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Qm/jLw0EMYsSTth59BVCDQh/y0QrX1F3Z4TktZVrMv59ytn/30coN87lZ6aGd6Xi/
         g+z/AI1gxPc5JDAddMLWWRCP2DyzPzjvvYjQHGldc0EW6Cp6i5nETVy7hUuYdYyBuM
         owyK/v5Lya+LIuowBbbzrzlw+zATs8hvC5rONJw8=
Message-ID: <3572970f-f40f-5410-651a-a5e019d328d8@ispras.ru>
Date:   Sat, 8 Oct 2022 13:54:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] tty: n_gsm: avoid call of sleeping functions from
 atomic context
Content-Language: en-US
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Pavel Machek <pavel@ucw.cz>, lvc-project@linuxtesting.org
References: <20220826193545.20363-1-pchelkin@ispras.ru>
 <20220827091353.30160-1-pchelkin@ispras.ru>
 <20220919113219.GA14632@duo.ucw.cz>
 <46a91b24-1c84-3ab8-2508-11720ee9ed5f@ispras.ru>
 <DB9PR10MB58814C87D370B045EFB6682EE05D9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
From:   Fedor Pchelkin <pchelkin@ispras.ru>
In-Reply-To: <DB9PR10MB58814C87D370B045EFB6682EE05D9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.10.2022 13:47, Daniel Starke wrote:
 > This patch breaks packet retransmission. Basically tx_lock and now 
tx_mutex
 > protects the transmission packet queue. This works fine as long as 
packets
 > are transmitted in a context that allows sleep. However, the 
retransmission
 > timer T2 is called from soft IRQ context and spans an additional atomic
 > context via control_lock within gsm_control_retransmit(). The call path
 > looks like this:
 > gsm_control_retransmit()
 >    spin_lock_irqsave(&gsm->control_lock, flags)
 >      gsm_control_transmit()
 >        gsm_data_queue()
 >          mutex_lock(&gsm->tx_mutex) // -> sleep in atomic context

As far as switching to tx_mutex turns out to have its own problems,
we suggest to revert it and to find another solution for the original
issue.

As it is described in commit 32dd59f ("tty: n_gsm: fix race condition in 
gsmld_write()"), the issue is that gsmld_write() may be used by the user 
directly and also by the n_gsm internal functions. But the proposed 
solution to add a spinlock around the low side tty write is not suitable 
since the tty write may sleep:

   gsmld_write(...)
    spin_lock_irqsave(&gsm->tx_lock, flags)
     tty->ops->write(...);
      con_write(...)
       do_con_write(...)
        console_lock()
         might_sleep() // -> bug

So let's consider alternative approaches to avoid the race condition.

We have found the only potential concurrency place:
gsm->tty->ops->write() in gsmld_output() and tty->ops->write() in
gsmld_write().

Is that right? Or there are some other cases?

On 05.10.2022 13:47, Daniel Starke wrote:
 > Long story short: The patch via mutex does not solve the issue. It is 
only
 > shifted to another function. I suggest splitting the TX lock into packet
 > queue lock and underlying tty write mutex.
 >
 > I would have implemented the patch if I had means to verify it.

Probably splitting the TX lock would be rather complex as there is
gsm_data_kick() which in this way has to be protected by packet queue
spinlock and at the same time it contains gsmld_output() (via
gsm_send_packet()) that would require mutex protection.
