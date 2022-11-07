Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D20761FFAF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiKGUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiKGUnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:43:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA105FD2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667853731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=evzlFbUTnO3GwUjJoQCN6EwhyV6gOnjO3o6XcJLyk7g=;
        b=d4qGf+tXu3mowM5l/3r32ObykpmYRaA/ocwXsZMS4JxTlAoQbMQUOvLeFXB9sdZN0O36NK
        bOgoF+GrMAxCWYO3i9qOPdNOWuG0zfDgYxivkPB0hMkk9HWIf03O1zG5bMNGUH+9yUV+fM
        znSoiPfelq1V0/4i15iyhKthN0wteTA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-518-5wsHFpsnNiKlk1xVMqDJ8A-1; Mon, 07 Nov 2022 15:42:10 -0500
X-MC-Unique: 5wsHFpsnNiKlk1xVMqDJ8A-1
Received: by mail-wm1-f71.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so8934123wme.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evzlFbUTnO3GwUjJoQCN6EwhyV6gOnjO3o6XcJLyk7g=;
        b=aDHDhT3UYy3WWVYJgnneomSFDydXEE6U8X5mPFXXTIHrxm25cOrawdiCg7BxeA7rhV
         iueuJQG4S0hThHxc8HFvb9iZn7wW/tV2tMqeGth3U7yEjkIFjDoFsc0w5GaLQx03iMMt
         p8hyR7TY2byBkA3ZUGGJB8HlrkJ7jW5cDBRwqodQ+7BtGpj8PI2ucuVgJcDVzGmpi5GE
         fOkIRBXVtXRDvl7SK7A7mGlVLhEIWpBDmXRmICWl4KuXrKq1EmH3yRiC5bDvFzmz0XwQ
         LcuBmOmCrBhgAVLdFvpO85DZ/z310KdOlffxn5+KaaXuZNWGDZQ/8v51RGr8oYxSKubd
         cmPA==
X-Gm-Message-State: ACrzQf0PJ0emYAfTtmpq72TXnVahI5GOB+sLAUAAO4BhytGxbKSTUE+W
        9YL6N4on99yE3DYLZfIM65iMIJIR9i39TucEGv1679lGfQaYDoAw2z0fasjkcLEA5z1G0X+458T
        oGAuUHFHuSxgOeAeN2kaevLan
X-Received: by 2002:a5d:4e88:0:b0:236:590:f5a9 with SMTP id e8-20020a5d4e88000000b002360590f5a9mr30678055wru.126.1667853729523;
        Mon, 07 Nov 2022 12:42:09 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6WrUGrbJ5bDelW9gjzQbAoXk9wPLV0dNxhMA028zBS3d1N8r/SEQc4SPIPfwfT8tBzm7vyBA==
X-Received: by 2002:a5d:4e88:0:b0:236:590:f5a9 with SMTP id e8-20020a5d4e88000000b002360590f5a9mr30678048wru.126.1667853729282;
        Mon, 07 Nov 2022 12:42:09 -0800 (PST)
Received: from redhat.com ([169.150.226.212])
        by smtp.gmail.com with ESMTPSA id v14-20020adfedce000000b00236883f2f5csm8369250wro.94.2022.11.07.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 12:42:08 -0800 (PST)
Date:   Mon, 7 Nov 2022 15:42:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
Message-ID: <20221107153924-mutt-send-email-mst@kernel.org>
References: <20221107203431.368306-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107203431.368306-1-eric.auger@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> When the vhost iotlb is used along with a guest virtual iommu
> and the guest gets rebooted, some MISS messages may have been
> recorded just before the reboot and spuriously executed by
> the virtual iommu after the reboot. Despite the device iotlb gets
> re-initialized, the messages are not cleared. Fix that by calling
> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/vhost/vhost.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 40097826cff0..422a1fdee0ca 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
>  	}
>  
>  	vhost_iotlb_free(oiotlb);
> +	vhost_clear_msg(d);
>  
>  	return 0;
>  }

Hmm.  Can't messages meanwhile get processes and affect the
new iotlb?


> -- 
> 2.37.3

