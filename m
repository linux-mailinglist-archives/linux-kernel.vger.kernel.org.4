Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A055BDDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiITHTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiITHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:18:58 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521C82723
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:18:54 -0700 (PDT)
Received: from [192.168.21.26] (unknown [176.59.41.79])
        by mail.ispras.ru (Postfix) with ESMTPSA id D9A754010159;
        Tue, 20 Sep 2022 07:18:45 +0000 (UTC)
Message-ID: <46a91b24-1c84-3ab8-2508-11720ee9ed5f@ispras.ru>
Date:   Tue, 20 Sep 2022 10:18:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] tty: n_gsm: avoid call of sleeping functions from
 atomic context
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Starke <daniel.starke@siemens.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
References: <20220826193545.20363-1-pchelkin@ispras.ru>
 <20220827091353.30160-1-pchelkin@ispras.ru>
 <20220919113219.GA14632@duo.ucw.cz>
Content-Language: en-US
From:   Fedor Pchelkin <pchelkin@ispras.ru>
In-Reply-To: <20220919113219.GA14632@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry for the late answering.

On 14.09.2022 14:38, Pavel Machek wrote:
 > Does this happen in 5.10, too? printk locking changed significantly in
 > recent years.

Yes. In fact, the bug was initially reproduced in 5.10 after backported
commits.

On 19.09.2022 14:32, Pavel Machek wrote:
> 
>> spin_lock_irqsave(&gsm->tx_lock, flags) // taken a spinlock on TX data
>>   con_write(...)
>>    do_con_write(...)
>>     console_lock()
>>      might_sleep() // -> bug
>>
>> As far as console_lock() might sleep it should not be called with
>> spinlock held.
>>
>> The patch replaces tx_lock spinlock with mutex in order to avoid the
>> problem.
>>
> 
> Do you have any hints why this might be correct?
> 

The thing you've pointed out is actually interesting. Mutex works well
in gsmld_write() but apparently I've missed the other contexts like in
gsmld_receive_buf().

> Have you tested it?
> 

Fuzzer has been covering that code and did not cause any lockdep
warnings, kernel bugs, hangs and similar issues. But maybe the problem
can cause some data corruption which can't be found by fuzzing tools.

> Locking around line disciplines is spinlock_irqsave elsewhere in the
> kernel.
> 
> Best regards,
> 								Pavel
>

I think it depends on the context. Overall, we'll look more deeply at
the problem. Perhaps logic in gsml_write() should be changed somehow
if it turns out that mutex usage is not allowed.

Fedor


>> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>>
>> Fixes: 32dd59f96924 ("tty: n_gsm: fix race condition in gsmld_write()")
>> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>> ---
>> v2->v1: sorry, now adapted patch from 5.10 to upstream
>>
>>   drivers/tty/n_gsm.c | 46 +++++++++++++++++++++------------------------
>>   1 file changed, 21 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
>> index caa5c14ed57f..be62c601058d 100644
>> --- a/drivers/tty/n_gsm.c
>> +++ b/drivers/tty/n_gsm.c
>> @@ -248,7 +248,7 @@ struct gsm_mux {
>>   	bool constipated;		/* Asked by remote to shut up */
>>   	bool has_devices;		/* Devices were registered */
>>   
>> -	spinlock_t tx_lock;
>> +	struct mutex tx_mutex;
>>   	unsigned int tx_bytes;		/* TX data outstanding */
>>   #define TX_THRESH_HI		8192
>>   #define TX_THRESH_LO		2048
>> @@ -680,7 +680,6 @@ static int gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
>>   	struct gsm_msg *msg;
>>   	u8 *dp;
>>   	int ocr;
>> -	unsigned long flags;
>>   
>>   	msg = gsm_data_alloc(gsm, addr, 0, control);
>>   	if (!msg)
>> @@ -702,10 +701,10 @@ static int gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
>>   
>>   	gsm_print_packet("Q->", addr, cr, control, NULL, 0);
>>   
>> -	spin_lock_irqsave(&gsm->tx_lock, flags);
>> +	mutex_lock(&gsm->tx_mutex);
>>   	list_add_tail(&msg->list, &gsm->tx_ctrl_list);
>>   	gsm->tx_bytes += msg->len;
>> -	spin_unlock_irqrestore(&gsm->tx_lock, flags);
>> +	mutex_unlock(&gsm->tx_mutex);
>>   	gsmld_write_trigger(gsm);
>>   
>>   	return 0;
>> @@ -730,7 +729,7 @@ static void gsm_dlci_clear_queues(struct gsm_mux *gsm, struct gsm_dlci *dlci)
>>   	spin_unlock_irqrestore(&dlci->lock, flags);
>>   
>>   	/* Clear data packets in MUX write queue */
>> -	spin_lock_irqsave(&gsm->tx_lock, flags);
>> +	mutex_lock(&gsm->tx_mutex);
>>   	list_for_each_entry_safe(msg, nmsg, &gsm->tx_data_list, list) {
>>   		if (msg->addr != addr)
>>   			continue;
>> @@ -738,7 +737,7 @@ static void gsm_dlci_clear_queues(struct gsm_mux *gsm, struct gsm_dlci *dlci)
>>   		list_del(&msg->list);
>>   		kfree(msg);
>>   	}
>> -	spin_unlock_irqrestore(&gsm->tx_lock, flags);
>> +	mutex_unlock(&gsm->tx_mutex);
>>   }
>>   
>>   /**
>> @@ -1024,10 +1023,9 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
>>   
>>   static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
>>   {
>> -	unsigned long flags;
>> -	spin_lock_irqsave(&dlci->gsm->tx_lock, flags);
>> +	mutex_lock(&dlci->gsm->tx_mutex);
>>   	__gsm_data_queue(dlci, msg);
>> -	spin_unlock_irqrestore(&dlci->gsm->tx_lock, flags);
>> +	mutex_unlock(&dlci->gsm->tx_mutex);
>>   }
>>   
>>   /**
>> @@ -1283,13 +1281,12 @@ static int gsm_dlci_data_sweep(struct gsm_mux *gsm)
>>   
>>   static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
>>   {
>> -	unsigned long flags;
>>   	int sweep;
>>   
>>   	if (dlci->constipated)
>>   		return;
>>   
>> -	spin_lock_irqsave(&dlci->gsm->tx_lock, flags);
>> +	mutex_lock(&dlci->gsm->tx_mutex);
>>   	/* If we have nothing running then we need to fire up */
>>   	sweep = (dlci->gsm->tx_bytes < TX_THRESH_LO);
>>   	if (dlci->gsm->tx_bytes == 0) {
>> @@ -1300,7 +1297,7 @@ static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
>>   	}
>>   	if (sweep)
>>   		gsm_dlci_data_sweep(dlci->gsm);
>> -	spin_unlock_irqrestore(&dlci->gsm->tx_lock, flags);
>> +	mutex_unlock(&dlci->gsm->tx_mutex);
>>   }
>>   
>>   /*
>> @@ -1994,14 +1991,13 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
>>   static void gsm_kick_timer(struct timer_list *t)
>>   {
>>   	struct gsm_mux *gsm = from_timer(gsm, t, kick_timer);
>> -	unsigned long flags;
>>   	int sent = 0;
>>   
>> -	spin_lock_irqsave(&gsm->tx_lock, flags);
>> +	mutex_lock(&gsm->tx_mutex);
>>   	/* If we have nothing running then we need to fire up */
>>   	if (gsm->tx_bytes < TX_THRESH_LO)
>>   		sent = gsm_dlci_data_sweep(gsm);
>> -	spin_unlock_irqrestore(&gsm->tx_lock, flags);
>> +	mutex_unlock(&gsm->tx_mutex);
>>   
>>   	if (sent && debug & 4)
>>   		pr_info("%s TX queue stalled\n", __func__);
>> @@ -2506,7 +2502,7 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
>>   	INIT_WORK(&gsm->tx_work, gsmld_write_task);
>>   	init_waitqueue_head(&gsm->event);
>>   	spin_lock_init(&gsm->control_lock);
>> -	spin_lock_init(&gsm->tx_lock);
>> +	mutex_init(&gsm->tx_mutex);
>>   
>>   	if (gsm->encoding == 0)
>>   		gsm->receive = gsm0_receive;
>> @@ -2538,6 +2534,7 @@ static void gsm_free_mux(struct gsm_mux *gsm)
>>   			break;
>>   		}
>>   	}
>> +	mutex_destroy(&gsm->tx_mutex);
>>   	mutex_destroy(&gsm->mutex);
>>   	kfree(gsm->txframe);
>>   	kfree(gsm->buf);
>> @@ -2609,6 +2606,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
>>   	}
>>   	spin_lock_init(&gsm->lock);
>>   	mutex_init(&gsm->mutex);
>> +	mutex_init(&gsm->tx_mutex);
>>   	kref_init(&gsm->ref);
>>   	INIT_LIST_HEAD(&gsm->tx_ctrl_list);
>>   	INIT_LIST_HEAD(&gsm->tx_data_list);
>> @@ -2636,6 +2634,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
>>   	}
>>   	spin_unlock(&gsm_mux_lock);
>>   	if (i == MAX_MUX) {
>> +		mutex_destroy(&gsm->tx_mutex);
>>   		mutex_destroy(&gsm->mutex);
>>   		kfree(gsm->txframe);
>>   		kfree(gsm->buf);
>> @@ -2791,17 +2790,16 @@ static void gsmld_write_trigger(struct gsm_mux *gsm)
>>   static void gsmld_write_task(struct work_struct *work)
>>   {
>>   	struct gsm_mux *gsm = container_of(work, struct gsm_mux, tx_work);
>> -	unsigned long flags;
>>   	int i, ret;
>>   
>>   	/* All outstanding control channel and control messages and one data
>>   	 * frame is sent.
>>   	 */
>>   	ret = -ENODEV;
>> -	spin_lock_irqsave(&gsm->tx_lock, flags);
>> +	mutex_lock(&gsm->tx_mutex);
>>   	if (gsm->tty)
>>   		ret = gsm_data_kick(gsm);
>> -	spin_unlock_irqrestore(&gsm->tx_lock, flags);
>> +	mutex_unlock(&gsm->tx_mutex);
>>   
>>   	if (ret >= 0)
>>   		for (i = 0; i < NUM_DLCI; i++)
>> @@ -3012,7 +3010,6 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
>>   			   const unsigned char *buf, size_t nr)
>>   {
>>   	struct gsm_mux *gsm = tty->disc_data;
>> -	unsigned long flags;
>>   	int space;
>>   	int ret;
>>   
>> @@ -3020,13 +3017,13 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
>>   		return -ENODEV;
>>   
>>   	ret = -ENOBUFS;
>> -	spin_lock_irqsave(&gsm->tx_lock, flags);
>> +	mutex_lock(&gsm->tx_mutex);
>>   	space = tty_write_room(tty);
>>   	if (space >= nr)
>>   		ret = tty->ops->write(tty, buf, nr);
>>   	else
>>   		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
>> -	spin_unlock_irqrestore(&gsm->tx_lock, flags);
>> +	mutex_unlock(&gsm->tx_mutex);
>>   
>>   	return ret;
>>   }
>> @@ -3323,14 +3320,13 @@ static struct tty_ldisc_ops tty_ldisc_packet = {
>>   static void gsm_modem_upd_via_data(struct gsm_dlci *dlci, u8 brk)
>>   {
>>   	struct gsm_mux *gsm = dlci->gsm;
>> -	unsigned long flags;
>>   
>>   	if (dlci->state != DLCI_OPEN || dlci->adaption != 2)
>>   		return;
>>   
>> -	spin_lock_irqsave(&gsm->tx_lock, flags);
>> +	mutex_lock(&gsm->tx_mutex);
>>   	gsm_dlci_modem_output(gsm, dlci, brk);
>> -	spin_unlock_irqrestore(&gsm->tx_lock, flags);
>> +	mutex_unlock(&gsm->tx_mutex);
>>   }
>>   
>>   /**
>> -- 
>> 2.25.1
> 
