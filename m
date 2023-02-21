Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9600269DAC9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjBUGwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjBUGv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:51:57 -0500
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632DBE39A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 22:51:49 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id s26so12962966edw.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 22:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHvJThuyHv60xEKEP3DfLorIeDtDqqvbyGFySsMcxiI=;
        b=QB8VDO9g6GZZF5/a+C5AwMnHXpNBFC9c4IJ6/w2bCA6RJwdMW6X7EX1ppYnhdrSMcf
         xGgnV+2BSQB+vEUKykFCZj4JAoGoL+8ui7z/apJcRyInOlte46w/aJtVRNilqqOi6HtX
         kfXsM2VOmoeutq7DMBkX/b843UsHJqCO44hM/BXPL4Z5ZGCRsB34/TJi+Ovf14YkLLTX
         6zl5qQHlSYkp8GdvFZnAOo5HgNtIeGQ9LqgBxR9BJbF/W2CdrZ2gRY68sDuSyE+eIQgN
         A01GcnRO891Xg4cH02JhA3B1pc6jUeLiy1M4vW7iN3etwULQSGCjCmF5S/Uagc/H2c4K
         5cyQ==
X-Gm-Message-State: AO0yUKX2Or9BDcQiR8T8azMEZAak1oUXzHzbDdGTrrA0PVU8mg/AmMCE
        GlsaGaC9ew0j+YtAf3RtPL0=
X-Google-Smtp-Source: AK7set/3MDVjo+Bx7Re7x8xD3Oys1QgCH2dbuDYKc77UUXx/xTXNU4VtM2+iSZKDVa8qeV4Z/p9YIQ==
X-Received: by 2002:aa7:d703:0:b0:4ac:bdeb:6dce with SMTP id t3-20020aa7d703000000b004acbdeb6dcemr3990597edq.39.1676962307735;
        Mon, 20 Feb 2023 22:51:47 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id u13-20020aa7d88d000000b004ab4c28a967sm1485354edq.44.2023.02.20.22.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 22:51:47 -0800 (PST)
Message-ID: <63030af8-5849-34b3-10e6-b6ce32c3a5bf@kernel.org>
Date:   Tue, 21 Feb 2023 07:51:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] char: pcmcia: cm4000_cs: Fix use-after-free in
 cm4000_fops
Content-Language: en-US
To:     Hyunwoo Kim <imv4bel@gmail.com>, laforge@gnumonks.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux@dominikbrodowski.net
References: <20220919040701.GA302806@ubuntu>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220919040701.GA302806@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping -- what's the status of these?

Should we mark cm4000_cs, cm4040_cs, and scr24x_cs as BROKEN instead?

Thanks.

On 19. 09. 22, 6:07, Hyunwoo Kim wrote:
> A race condition may occur if the user physically removes the pcmcia
> device while calling open() for this char device node.
> 
> This is a race condition between the cmm_open() function and the
> cm4000_detach() function, which may eventually result in UAF.
> 
> So, add a refcount check to cm4000_detach() to free the "dev" structure
> after the char device node is close()d.
> 
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>   drivers/char/pcmcia/cm4000_cs.c | 58 +++++++++++++++++++++++----------
>   1 file changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
> index adaec8fd4b16..7103812b4019 100644
> --- a/drivers/char/pcmcia/cm4000_cs.c
> +++ b/drivers/char/pcmcia/cm4000_cs.c
> @@ -55,6 +55,7 @@
>   	} while (0)
>   
>   static DEFINE_MUTEX(cmm_mutex);
> +static DEFINE_MUTEX(remove_mutex);
>   
>   #define	T_1SEC		(HZ)
>   #define	T_10MSEC	msecs_to_jiffies(10)
> @@ -103,7 +104,8 @@ static int major;		/* major number we get from the kernel */
>   #define REG_STOPBITS(x)		(x + 7)
>   
>   struct cm4000_dev {
> -	struct pcmcia_device *p_dev;
> +	struct pcmcia_device	*p_dev;
> +	struct kref		refcnt;
>   
>   	unsigned char atr[MAX_ATR];
>   	unsigned char rbuf[512];
> @@ -146,6 +148,9 @@ struct cm4000_dev {
>   
>   #define	ZERO_DEV(dev)	memset(&((dev)->init), 0, sizeof((dev)->init))
>   
> +static void stop_monitor(struct cm4000_dev *dev);
> +static void cm4000_delete(struct kref *kref);
> +
>   static struct pcmcia_device *dev_table[CM4000_MAX_DEV];
>   static struct class *cmm_class;
>   
> @@ -416,6 +421,30 @@ static struct card_fixup card_fixups[] = {
>   	},
>   };
>   
> +
> +static void cm4000_delete(struct kref *kref)
> +{
> +	struct cm4000_dev *dev = container_of(kref, struct cm4000_dev, refcnt);
> +	struct pcmcia_device *link = dev->p_dev;
> +	int devno;
> +
> +	/* find device */
> +	for (devno = 0; devno < CM4000_MAX_DEV; devno++)
> +		if (dev_table[devno] == link)
> +			break;
> +	if (devno == CM4000_MAX_DEV)
> +		return;
> +
> +	stop_monitor(dev);
> +
> +	cm4000_release(link);
> +
> +	dev_table[devno] = NULL;
> +	kfree(dev);
> +
> +	device_destroy(cmm_class, MKDEV(major, devno));
> +}
> +
>   static void set_cardparameter(struct cm4000_dev *dev)
>   {
>   	int i;
> @@ -1629,6 +1658,7 @@ static int cmm_open(struct inode *inode, struct file *filp)
>   	if (minor >= CM4000_MAX_DEV)
>   		return -ENODEV;
>   
> +	mutex_lock(&remove_mutex);
>   	mutex_lock(&cmm_mutex);
>   	link = dev_table[minor];
>   	if (link == NULL || !pcmcia_dev_present(link)) {
> @@ -1673,8 +1703,12 @@ static int cmm_open(struct inode *inode, struct file *filp)
>   
>   	DEBUGP(2, dev, "<- cmm_open\n");
>   	ret = stream_open(inode, filp);
> +
> +	kref_get(&dev->refcnt);
>   out:
>   	mutex_unlock(&cmm_mutex);
> +	mutex_unlock(&remove_mutex);
> +
>   	return ret;
>   }
>   
> @@ -1703,6 +1737,8 @@ static int cmm_close(struct inode *inode, struct file *filp)
>   	link->open = 0;		/* only one open per device */
>   	wake_up(&dev->devq);	/* socket removed? */
>   
> +	kref_put(&dev->refcnt, cm4000_delete);
> +
>   	DEBUGP(2, dev, "cmm_close\n");
>   	return 0;
>   }
> @@ -1808,6 +1844,7 @@ static int cm4000_probe(struct pcmcia_device *link)
>   	init_waitqueue_head(&dev->ioq);
>   	init_waitqueue_head(&dev->atrq);
>   	init_waitqueue_head(&dev->readq);
> +	kref_init(&dev->refcnt);
>   
>   	ret = cm4000_config(link, i);
>   	if (ret) {
> @@ -1824,23 +1861,10 @@ static int cm4000_probe(struct pcmcia_device *link)
>   static void cm4000_detach(struct pcmcia_device *link)
>   {
>   	struct cm4000_dev *dev = link->priv;
> -	int devno;
> -
> -	/* find device */
> -	for (devno = 0; devno < CM4000_MAX_DEV; devno++)
> -		if (dev_table[devno] == link)
> -			break;
> -	if (devno == CM4000_MAX_DEV)
> -		return;
> -
> -	stop_monitor(dev);
> -
> -	cm4000_release(link);
>   
> -	dev_table[devno] = NULL;
> -	kfree(dev);
> -
> -	device_destroy(cmm_class, MKDEV(major, devno));
> +	mutex_lock(&remove_mutex);
> +	kref_put(&dev->refcnt, cm4000_delete);
> +	mutex_unlock(&remove_mutex);
>   
>   	return;
>   }

-- 
js
suse labs

