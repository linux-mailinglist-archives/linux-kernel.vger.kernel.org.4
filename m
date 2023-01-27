Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6795067E28D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjA0LDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjA0LD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:03:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430F2525E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674817371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3zXIeNDbVEYsNZMd35a+KmGHR0oWBBKX2t8c6pdmTU=;
        b=EUYqqrYcWkEFLfoFmkOGCKM02hfTB/hUVZzGq0d3+oydtKMXClj69msIf9XuJRsx8zke2g
        eJYCuAq+DC6PcFuc/RWuucfd45MtLW91mGWLaK5UyNsv4hp4fRAKutrG6hyWxaasi/sJCY
        uO1ViTk9/SGCdcW/WLDl/HtfdCmqbr4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-641-pSrd6r8lPwGR4NIg8ZYtYw-1; Fri, 27 Jan 2023 06:02:50 -0500
X-MC-Unique: pSrd6r8lPwGR4NIg8ZYtYw-1
Received: by mail-ed1-f70.google.com with SMTP id c12-20020a05640227cc00b0049e2c079aabso3330050ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3zXIeNDbVEYsNZMd35a+KmGHR0oWBBKX2t8c6pdmTU=;
        b=05MB+TjUEIpZDaOSWlM7JEjl7VZzmh4kvuRCzfA51ulnn5b2zUlJtog/0SFJ0A7rVw
         6XCltrX62pK41u/vtwokIrjlM6OuycKmGNyfPYGPRDElJjsYG+zFlSCQb/nSOeT+lw22
         sDB60MubUk8ARTNH5dBXmS/0hRfMPa5+hE4RNzj1F009oiQU8qiVeBxtjEW5nY149Cs7
         X5GOtfjv/WjqhfgXogjO3LwQCHLQAm1xZnRgNuntqP8of6/2vFq0QsGMbFs1mFwoKCwH
         5ZZChnGDVvS6syyTc9motd0N06deHYr5cx42JLwSANYV/1pm6DIvjpxOvyFX2Bxo1WcV
         hKhA==
X-Gm-Message-State: AO0yUKXYINKOQSKR/AIR1YxA/SGvKA+7Pog466dKwP2fHan4ZDoHMu04
        46EuVLlg2/NsR8bHs3TgGFDlY7jyfwl33cgPdszNUT7tyrphmpstHo786ipwilLHGXVrR8tkdre
        j0GRwOmM6ymTYNgUe2tV3JSHw
X-Received: by 2002:aa7:cf93:0:b0:4a2:11c5:44f8 with SMTP id z19-20020aa7cf93000000b004a211c544f8mr777386edx.4.1674817369163;
        Fri, 27 Jan 2023 03:02:49 -0800 (PST)
X-Google-Smtp-Source: AK7set8PiWQ9xvT7KQIyI66NVLLiZYQ81dkyQmfw+yrGfEARBdCHZXQ0VuwCg2F2/d1GqcgtuR2Ukg==
X-Received: by 2002:aa7:cf93:0:b0:4a2:11c5:44f8 with SMTP id z19-20020aa7cf93000000b004a211c544f8mr777366edx.4.1674817368972;
        Fri, 27 Jan 2023 03:02:48 -0800 (PST)
Received: from redhat.com ([2.52.137.69])
        by smtp.gmail.com with ESMTPSA id j25-20020a50ed19000000b004a20fa1c659sm412845eds.82.2023.01.27.03.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:02:48 -0800 (PST)
Date:   Fri, 27 Jan 2023 06:02:44 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <20230127055944-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com>
 <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com>
 <87a62eqo4h.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a62eqo4h.fsf@ubik.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:13:18PM +0200, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > Then you need to copy it out once, and then only deal with the local
> > copy.  Otherwise you have an incomplete snapshot.
> 
> Ok, would you be partial to something like this:
> 
> >From 1bc9bb84004154376c2a0cf643d53257da6d1cd7 Mon Sep 17 00:00:00 2001
> From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Date: Thu, 19 Jan 2023 21:59:02 +0200
> Subject: [PATCH] virtio console: Keep a local copy of the control structure
> 
> When handling control messages, instead of peeking at the device memory
> to obtain bits of the control structure,

Except the message makes it seem that we are getting data from
device memory, when we do nothing of the kind.

> take a snapshot of it once and
> use it instead, to prevent it from changing under us. This avoids races
> between port id validation and control event decoding, which can lead
> to, for example, a NULL dereference in port removal of a nonexistent
> port.
> 
> The control structure is small enough (8 bytes) that it can be cached
> directly on the stack.

I still have no real idea why we want a copy here.
If device can poke anywhere at memory then it can crash kernel anyway.
If there's a bounce buffer or an iommu or some other protection
in place, then this memory can no longer change by the time
we look at it.

> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Amit Shah <amit@kernel.org>
> ---
>  drivers/char/virtio_console.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 6a821118d553..42be0991a72f 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1559,23 +1559,24 @@ static void handle_control_message(struct virtio_device *vdev,
>  				   struct ports_device *portdev,
>  				   struct port_buffer *buf)
>  {
> -	struct virtio_console_control *cpkt;
> +	struct virtio_console_control cpkt;
>  	struct port *port;
>  	size_t name_size;
>  	int err;
>  
> -	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
> +	/* Keep a local copy of the control structure */
> +	memcpy(&cpkt, buf->buf + buf->offset, sizeof(cpkt));
>  
> -	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt->id));
> +	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt.id));
>  	if (!port &&
> -	    cpkt->event != cpu_to_virtio16(vdev, VIRTIO_CONSOLE_PORT_ADD)) {
> +	    cpkt.event != cpu_to_virtio16(vdev, VIRTIO_CONSOLE_PORT_ADD)) {
>  		/* No valid header at start of buffer.  Drop it. */
>  		dev_dbg(&portdev->vdev->dev,
> -			"Invalid index %u in control packet\n", cpkt->id);
> +			"Invalid index %u in control packet\n", cpkt.id);
>  		return;
>  	}
>  
> -	switch (virtio16_to_cpu(vdev, cpkt->event)) {
> +	switch (virtio16_to_cpu(vdev, cpkt.event)) {
>  	case VIRTIO_CONSOLE_PORT_ADD:
>  		if (port) {
>  			dev_dbg(&portdev->vdev->dev,
> @@ -1583,21 +1584,21 @@ static void handle_control_message(struct virtio_device *vdev,
>  			send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
>  			break;
>  		}
> -		if (virtio32_to_cpu(vdev, cpkt->id) >=
> +		if (virtio32_to_cpu(vdev, cpkt.id) >=
>  		    portdev->max_nr_ports) {
>  			dev_warn(&portdev->vdev->dev,
>  				"Request for adding port with "
>  				"out-of-bound id %u, max. supported id: %u\n",
> -				cpkt->id, portdev->max_nr_ports - 1);
> +				cpkt.id, portdev->max_nr_ports - 1);
>  			break;
>  		}
> -		add_port(portdev, virtio32_to_cpu(vdev, cpkt->id));
> +		add_port(portdev, virtio32_to_cpu(vdev, cpkt.id));
>  		break;
>  	case VIRTIO_CONSOLE_PORT_REMOVE:
>  		unplug_port(port);
>  		break;
>  	case VIRTIO_CONSOLE_CONSOLE_PORT:
> -		if (!cpkt->value)
> +		if (!cpkt.value)
>  			break;
>  		if (is_console_port(port))
>  			break;
> @@ -1618,7 +1619,7 @@ static void handle_control_message(struct virtio_device *vdev,
>  		if (!is_console_port(port))
>  			break;
>  
> -		memcpy(&size, buf->buf + buf->offset + sizeof(*cpkt),
> +		memcpy(&size, buf->buf + buf->offset + sizeof(cpkt),
>  		       sizeof(size));
>  		set_console_size(port, size.rows, size.cols);
>  
> @@ -1627,7 +1628,7 @@ static void handle_control_message(struct virtio_device *vdev,
>  		break;
>  	}
>  	case VIRTIO_CONSOLE_PORT_OPEN:
> -		port->host_connected = virtio16_to_cpu(vdev, cpkt->value);
> +		port->host_connected = virtio16_to_cpu(vdev, cpkt.value);
>  		wake_up_interruptible(&port->waitqueue);
>  		/*
>  		 * If the host port got closed and the host had any
> @@ -1658,7 +1659,7 @@ static void handle_control_message(struct virtio_device *vdev,
>  		 * Skip the size of the header and the cpkt to get the size
>  		 * of the name that was sent
>  		 */
> -		name_size = buf->len - buf->offset - sizeof(*cpkt) + 1;
> +		name_size = buf->len - buf->offset - sizeof(cpkt) + 1;
>  
>  		port->name = kmalloc(name_size, GFP_KERNEL);
>  		if (!port->name) {
> @@ -1666,7 +1667,7 @@ static void handle_control_message(struct virtio_device *vdev,
>  				"Not enough space to store port name\n");
>  			break;
>  		}
> -		strncpy(port->name, buf->buf + buf->offset + sizeof(*cpkt),
> +		strncpy(port->name, buf->buf + buf->offset + sizeof(cpkt),
>  			name_size - 1);
>  		port->name[name_size - 1] = 0;
>  
> -- 
> 2.39.0

