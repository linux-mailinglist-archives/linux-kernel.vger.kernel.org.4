Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013BA64F5F2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 01:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiLQAPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 19:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiLQANp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 19:13:45 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C848676162;
        Fri, 16 Dec 2022 16:11:33 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d3so3811249plr.10;
        Fri, 16 Dec 2022 16:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9FKRW77SPIzbxdxP83UgvxoJbJk4rIU/292OxhIMLU=;
        b=aXuvIuiXdqlx6q7HBT9BW5yA5Q5398YbwOY0qBvdLmfTiuGpvvQJAPsPRJXRlNBoLc
         pgrpNJzdA4cOuHfLR1VvpVIeHESPkMyXp/MDtLEk5Kpq9qAvcX2AtD85r04tYoKw0YEb
         GBJMjG6ETDhpudzbjWupMwB16AC8gWHhnC31Ln3/vNCnUvGqaKjiBPiKSu85XiOAV9av
         N0nGPKHqzusn5engUrRVOPPh199lQ8NUmZ9F44d0DFsP9grTkENjxBe8rWcJbqD1Ecc8
         tlDrlNOk4lYwoW1LWO9JfH4fBNDAg1tHq/4V4brOrMEd8yney6kN42q+qjs8ZQGtIldD
         vr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9FKRW77SPIzbxdxP83UgvxoJbJk4rIU/292OxhIMLU=;
        b=bcuwI4NzRhJKc9O/ZHfwi7A09FcpeVc2JI2bQHShHcXdaFB5ITLxmY3kQ72WN1Nr+Y
         XX1q0hd23kV/v+Sh6ad90vcqsRHbLllFUxmA8PrFZwaZ9M4Z9BnW3DoOdma1omdwoeSn
         aMPv3+Gl/DMVnYsZRA0uGc8t83G+r+MZWdHOPBbTVvNtw6qWksSHUOk4OGnouy5auLst
         aa9n6Wh+KBanbxc4u9irB/znep3tg3r4S3mdioMygjb/eTeFo/BD5y3Bls/v2u2787i7
         DSj+Wx34c31KhQZSxVy7E4/s8uZMllbFVHE6v2Ax4XnrZ47Gthhl0L5njtc5FV3hYxUB
         YvZg==
X-Gm-Message-State: ANoB5pmNSO+76HzYi8ROEYxSX/uuIZPzz22vf6F3xKog8c4MCzyxCb1Q
        LKZq7IFBKhiFEs8VCnnumkA=
X-Google-Smtp-Source: AA0mqf6JYJY9WXiUojJwOqSthqXA2oXk9c1ROzHxi4bFpSUsjgKkhLPmWzv47hbziVJ/1ZgOPz2flw==
X-Received: by 2002:a05:6a20:9598:b0:ab:9997:8ee2 with SMTP id iu24-20020a056a20959800b000ab99978ee2mr10658768pzb.6.1671235893233;
        Fri, 16 Dec 2022 16:11:33 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id k15-20020a63d10f000000b00478b930f970sm1975974pgg.66.2022.12.16.16.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 16:11:32 -0800 (PST)
Date:   Sat, 17 Dec 2022 13:11:25 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] [next] pcmcia: synclink_cs: replace 1-element array
 with flex-array member
Message-ID: <Y50JLZH/xVx9nxle@mail.google.com>
References: <Y5uN9Rr3v1uWH765@mail.google.com>
 <Y5z4Og3XmCGQwTO9@mail.google.com>
 <202212161542.CA466D97B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212161542.CA466D97B@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 03:42:47PM -0800, Kees Cook wrote:
> On Sat, Dec 17, 2022 at 11:59:06AM +1300, Paulo Miguel Almeida wrote:
> > One-element arrays are deprecated, and we are replacing them with
> > flexible array members instead. So, replace one-element array with
> > flexible-array member in struct RXBUF and refactor the rest of the code
> > accordingly. While at it, fix an edge case which could cause
> > rx_buf_count to be 0 when max_frame_size was set to the maximum
> > allowed value (65535).
> > 
> > It's worth mentioning that struct RXBUF was allocating 1 byte "too much"
> > for what is required (ignoring bytes added by padding).
> 
> What was the result of using __packed to make sure there wasn't a sizing
> error?
> 
> -Kees
> 

With or without __packed__ attribute, sufficient space would be
allocated which is good :-)

In both cases there is still some "extra space" (1 byte on __packed and
4 bytes on non-packed) but that should be negligible. OTOH, if I'm asked
to cull those bytes I am happy to do it too.

pahole -C RXBUF non-packed/drivers/char/pcmcia/synclink_cs.o
typedef struct {
	int                        count;                /*     0     4 */
	unsigned char              status;               /*     4     1 */
	char                       data[];               /*     5     0 */

	/* size: 8, cachelines: 1, members: 3 */
	/* padding: 3 */
	/* last cacheline: 8 bytes */
} RXBUF;

pahole -C RXBUF packed/drivers/char/pcmcia/synclink_cs.o
typedef struct {
	int                        count;                /*     0     4 */
	unsigned char              status;               /*     4     1 */
	char                       data[];               /*     5     0 */

	/* size: 5, cachelines: 1, members: 3 */
	/* last cacheline: 5 bytes */
} __attribute__((__packed__)) RXBUF;

- Paulo A.

> > 
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [1].
> > 
> > Link: https://github.com/KSPP/linux/issues/79
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > ---
> > Changelog:
> > 
> > - v3:
> >   fix size calculation mistakes using overflow.h macros: (Req: Andy
> >   Shevchenko, Kees Cook)
> >   add notes struct RXBUF size (Kees Cook)
> > 
> > - v2: removed changes to how the size of RXBUF was calculated. I
> >   changed my mind after thinking about the existing padding in the
> >   struct. Happy to discuss it if anyone sees it differently.
> > 
> > - v1: https://lore.kernel.org/lkml/Y5mMWEtHWKOiPVU+@mail.google.com/
> > ---
> >  drivers/char/pcmcia/synclink_cs.c | 33 +++++++++++++++++++------------
> >  1 file changed, 20 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> > index b2735be81ab2..eee6772a0978 100644
> > --- a/drivers/char/pcmcia/synclink_cs.c
> > +++ b/drivers/char/pcmcia/synclink_cs.c
> > @@ -105,7 +105,7 @@ static MGSL_PARAMS default_params = {
> >  typedef struct {
> >  	int count;
> >  	unsigned char status;
> > -	char data[1];
> > +	char data[];
> >  } RXBUF;
> >  
> >  /* The queue of BH actions to be performed */
> > @@ -229,12 +229,18 @@ typedef struct _mgslpc_info {
> >  } MGSLPC_INFO;
> >  
> >  #define MGSLPC_MAGIC 0x5402
> > +#define MGSLPC_MAX_FRAME_SIZE 65535
> > +#define MGSLPC_MIN_FRAME_SIZE 4096
> >  
> >  /*
> >   * The size of the serial xmit buffer is 1 page, or 4096 bytes
> >   */
> >  #define TXBUFSIZE 4096
> >  
> > +/*
> > + * RXBUF accommodates at least 1 buffer (header+data) of MGSLPC_MAX_FRAME_SIZE
> > + */
> > +#define RXBUF_MAX_SIZE (sizeof(RXBUF) + MGSLPC_MAX_FRAME_SIZE)
> >  
> >  #define CHA     0x00   /* channel A offset */
> >  #define CHB     0x40   /* channel B offset */
> > @@ -529,7 +535,7 @@ static int mgslpc_probe(struct pcmcia_device *link)
> >  	tty_port_init(&info->port);
> >  	info->port.ops = &mgslpc_port_ops;
> >  	INIT_WORK(&info->task, bh_handler);
> > -	info->max_frame_size = 4096;
> > +	info->max_frame_size = MGSLPC_MIN_FRAME_SIZE;
> >  	init_waitqueue_head(&info->status_event_wait_q);
> >  	init_waitqueue_head(&info->event_wait_q);
> >  	spin_lock_init(&info->lock);
> > @@ -2611,19 +2617,20 @@ static int mgslpc_proc_show(struct seq_file *m, void *v)
> >  static int rx_alloc_buffers(MGSLPC_INFO *info)
> >  {
> >  	/* each buffer has header and data */
> > -	info->rx_buf_size = sizeof(RXBUF) + info->max_frame_size;
> > +	if (check_add_overflow(sizeof(RXBUF), info->max_frame_size, &info->rx_buf_size))
> > +		return -EINVAL;
> >  
> > -	/* calculate total allocation size for 8 buffers */
> > -	info->rx_buf_total_size = info->rx_buf_size * 8;
> > +	/* try to alloc as many buffers that can fit within RXBUF_MAX_SIZE (up to 8) */
> > +	if (check_mul_overflow(info->rx_buf_size, 8, &info->rx_buf_total_size))
> > +		return -EINVAL;
> >  
> > -	/* limit total allocated memory */
> > -	if (info->rx_buf_total_size > 0x10000)
> > -		info->rx_buf_total_size = 0x10000;
> > +	if (info->rx_buf_total_size > RXBUF_MAX_SIZE)
> > +		info->rx_buf_total_size = RXBUF_MAX_SIZE;
> >  
> >  	/* calculate number of buffers */
> >  	info->rx_buf_count = info->rx_buf_total_size / info->rx_buf_size;
> >  
> > -	info->rx_buf = kmalloc(info->rx_buf_total_size, GFP_KERNEL);
> > +	info->rx_buf = kcalloc(info->rx_buf_count, info->rx_buf_size, GFP_KERNEL);
> >  	if (info->rx_buf == NULL)
> >  		return -ENOMEM;
> >  
> > @@ -2695,10 +2702,10 @@ static int mgslpc_add_device(MGSLPC_INFO *info)
> >  		current_dev->next_device = info;
> >  	}
> >  
> > -	if (info->max_frame_size < 4096)
> > -		info->max_frame_size = 4096;
> > -	else if (info->max_frame_size > 65535)
> > -		info->max_frame_size = 65535;
> > +	if (info->max_frame_size < MGSLPC_MIN_FRAME_SIZE)
> > +		info->max_frame_size = MGSLPC_MIN_FRAME_SIZE;
> > +	else if (info->max_frame_size > MGSLPC_MAX_FRAME_SIZE)
> > +		info->max_frame_size = MGSLPC_MAX_FRAME_SIZE;
> >  
> >  	printk("SyncLink PC Card %s:IO=%04X IRQ=%d\n",
> >  		info->device_name, info->io_base, info->irq_level);
> > -- 
> > 2.38.1
> > 
> 
> -- 
> Kees Cook
