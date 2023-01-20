Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7870B675525
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjATNAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjATNAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:00:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B66EA57A6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674219591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HNMmaz9aXWp8dmmkUCqryhR5pSgcfts2GGGLwXQogAg=;
        b=enQA4uwlHrYwGR3+kvKAHxJBZYkA+NkbkEFe5elVEeo7MdBYtiO6NSeShOh7dui7h5BNYs
        NuFBNf3qFeGXisM5FQkjwQKtO6onfPvmgoACef5r3i0Q5ZMZJZR0qraMrZucH2SquC+tVW
        DKsYIhANtlIuIUQ77Vh7QMluqchhWuw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-w-dlqhnWNhWRin04IgvrBQ-1; Fri, 20 Jan 2023 07:59:50 -0500
X-MC-Unique: w-dlqhnWNhWRin04IgvrBQ-1
Received: by mail-wm1-f71.google.com with SMTP id o2-20020a05600c378200b003daf780e783so1303327wmr.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNMmaz9aXWp8dmmkUCqryhR5pSgcfts2GGGLwXQogAg=;
        b=A1hYpd0TqFEya8QEID2SMdMl+28cpPnIXVae4sAAorEogyCtU9WZgRjqc0bGjxTGRZ
         R6Xej7ImYwvtVVqXmL7LZfdeEsLCXxOz9AKSLLM02ft83yncA/EiNLaYPVcsqagC3K7v
         2x/Y9aGbg1mBS6uRgOuy+6DIePWxFDlMdftX3IV9NTeLRVx/Tym1QxJOziUGOEz93BBH
         ZgztgBZ/aDeSWo5pi1oCz8xWRrFOvgy5WkvWCHMXazB1qn0MAobb5MFqUr/RZHih+nxG
         1+PVZJStgLHa0Ghrya1287yBTv8jgqE4WPzVXJXLQeg/NfTFqzBJiwEq4Yc98A41BRob
         K0jA==
X-Gm-Message-State: AFqh2krzsoqWFHs/26ZV7Vdi8J0anL0YW4r+lLPQWA2pygpBhnbh20kY
        5d8O9v0scZHtTtXwuYqDs5gkLn+JCf3IbdMt+81/AyFnlPq1s2hzdVPq8gkF3cdyWGnGpAWJdIP
        pX0Lx4hk7yhdA2ujTDCNxb9Ie
X-Received: by 2002:a05:600c:3d98:b0:3d6:ecc4:6279 with SMTP id bi24-20020a05600c3d9800b003d6ecc46279mr10350556wmb.27.1674219588936;
        Fri, 20 Jan 2023 04:59:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt1rDVbBpQ3DlhTm2hQw+6Fpr2BkmomVLr2yMXKq89LfWNXBSPNtUsMb6Cu3+DBPqxwVx4taw==
X-Received: by 2002:a05:600c:3d98:b0:3d6:ecc4:6279 with SMTP id bi24-20020a05600c3d9800b003d6ecc46279mr10350535wmb.27.1674219588688;
        Fri, 20 Jan 2023 04:59:48 -0800 (PST)
Received: from redhat.com ([2.52.19.29])
        by smtp.gmail.com with ESMTPSA id k16-20020a7bc410000000b003d99469ece1sm2181710wmi.24.2023.01.20.04.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:59:48 -0800 (PST)
Date:   Fri, 20 Jan 2023 07:59:44 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <20230120075729-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:57:17PM +0200, Alexander Shishkin wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The ADD_PORT operation reads and sanity checks the port id multiple
> times from the untrusted host. This is not safe because a malicious
> host could change it between reads.
> 
> Read the port id only once and cache it for subsequent uses.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


I suspect anyone worried about this kind of thing already uses a bounce
buffer. No?  The patch itself makes the code more readable, except maybe
for the READ_ONCE thing.


> ---
>  drivers/char/virtio_console.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index f4fd5fe7cd3a..6599c2956ba4 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1563,10 +1563,13 @@ static void handle_control_message(struct virtio_device *vdev,
>  	struct port *port;
>  	size_t name_size;
>  	int err;
> +	unsigned id;
>  
>  	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
>  
> -	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt->id));
> +	/* Make sure the host cannot change id under us */
> +	id = virtio32_to_cpu(vdev, READ_ONCE(cpkt->id));
> +	port = find_port_by_id(portdev, id);
>  	if (!port &&
>  	    cpkt->event != cpu_to_virtio16(vdev, VIRTIO_CONSOLE_PORT_ADD)) {
>  		/* No valid header at start of buffer.  Drop it. */
> @@ -1583,15 +1586,14 @@ static void handle_control_message(struct virtio_device *vdev,
>  			send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
>  			break;
>  		}
> -		if (virtio32_to_cpu(vdev, cpkt->id) >=
> -		    portdev->max_nr_ports) {
> +		if (id >= portdev->max_nr_ports) {
>  			dev_warn(&portdev->vdev->dev,
>  				"Request for adding port with "
>  				"out-of-bound id %u, max. supported id: %u\n",
>  				cpkt->id, portdev->max_nr_ports - 1);
>  			break;
>  		}
> -		add_port(portdev, virtio32_to_cpu(vdev, cpkt->id));
> +		add_port(portdev, id);
>  		break;
>  	case VIRTIO_CONSOLE_PORT_REMOVE:
>  		unplug_port(port);
> -- 
> 2.39.0

