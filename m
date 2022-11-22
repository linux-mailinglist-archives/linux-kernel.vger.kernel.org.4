Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0951D633AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiKVLOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiKVLNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E842DF3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669115568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HP9F+p2dxhYIWKllV/OXz0HrddctUZTEtcHm3XsSMgM=;
        b=e5EOo9jEZvK8vYPLqnq0SJ4Q81h1wEKlyO+2O3M/SHsBtC6eIHIWc82XoNiDmCEVMVmT2l
        7F+XziTUF4DqER1MIYy5NvI74OGqD+bF/jZazLckiF25/YZiOFuvAmQIQGIb04eXGMkRJ7
        YdzauP5QNAbVcGu3HBEA60J7ZbYn+zI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-380-RxcX3FCeN42hLpgxOyUD9w-1; Tue, 22 Nov 2022 06:12:46 -0500
X-MC-Unique: RxcX3FCeN42hLpgxOyUD9w-1
Received: by mail-wr1-f71.google.com with SMTP id v12-20020adfa1cc000000b00236eaee7197so4129696wrv.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HP9F+p2dxhYIWKllV/OXz0HrddctUZTEtcHm3XsSMgM=;
        b=AKH0M2LsvjtUmpWwGqVnFoZMs4pJ3Gnz4Odq5+Lk+X7JljshH3DvphIPLsl1GGPcFM
         9WIhrdInbvRUPjunx60vKBmIAu03MAUU9hHfucLB/PoshVgXK4oRWXH2qC4tjcjJf04B
         kr9mKJA2re2m7QjYm0b1XPh3JerAUDHSur80BzTtCwUS/6b4GQ6UyYSmdYk94eomg4nR
         G+oc4kAsvHn3NiyWbIDnpdWAJf0US6WWgM7A1I7HNNLFdzrZka1FPQpMyjjaUpU6C1k9
         7ZMXQ7e0CvZghMgh6YN3CSo9W5oLhnVPWTqrg66e+5AqcnE/dgVF4LGGE9YXLlZ4SR18
         oLng==
X-Gm-Message-State: ANoB5pn/dpEBn63RGgD8ZtXnwy4Zyj9c1A8iDYijY721oW1FbnBl0+iZ
        C/uQtUa2JlYLiaGK4+AyPx9Bc8OPCYqirRCPxG4/bf5Xrc/1YRr8LoQ3enfrnfWyds+BYSY9ocS
        UD3ntKalgXcRR8BRB1++5f/+e
X-Received: by 2002:a5d:5611:0:b0:241:cfa5:20d9 with SMTP id l17-20020a5d5611000000b00241cfa520d9mr7264589wrv.451.1669115565193;
        Tue, 22 Nov 2022 03:12:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4eHGBO4afRVPkSMaHqn1MkFLLySojli4V6rwYgdetBBdrXxXXecoWGsZzXevC5M5FqgjMGiA==
X-Received: by 2002:a5d:5611:0:b0:241:cfa5:20d9 with SMTP id l17-20020a5d5611000000b00241cfa520d9mr7264571wrv.451.1669115564924;
        Tue, 22 Nov 2022 03:12:44 -0800 (PST)
Received: from [192.168.0.5] (ip-109-43-176-72.web.vodafone.de. [109.43.176.72])
        by smtp.gmail.com with ESMTPSA id x2-20020a1c7c02000000b003b4935f04a4sm19134166wmc.5.2022.11.22.03.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 03:12:44 -0800 (PST)
Message-ID: <81612d82-7fc1-e2be-38a2-0db8314248cc@redhat.com>
Date:   Tue, 22 Nov 2022 12:12:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Amit Shah <amit@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20221114173811.1977367-1-clg@kaod.org>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] virtio_console: Introduce an ID allocator for virtual
 console numbers
In-Reply-To: <20221114173811.1977367-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 18.38, Cédric Le Goater wrote:
> When a virtio console port is initialized, it is registered as an hvc
> console using a virtual console number. If a KVM guest is started with
> multiple virtio console devices, the same vtermno (or virtual console
> number) can be used to allocate different hvc consoles, which leads to
> various communication problems later on.
> 
> This is also reported in debugfs :
> 
>    # grep vtermno /sys/kernel/debug/virtio-ports/*
>    /sys/kernel/debug/virtio-ports/vport1p1:console_vtermno: 1
>    /sys/kernel/debug/virtio-ports/vport2p1:console_vtermno: 1
>    /sys/kernel/debug/virtio-ports/vport3p1:console_vtermno: 2
>    /sys/kernel/debug/virtio-ports/vport4p1:console_vtermno: 3
> 
> Replace the next_vtermno global with an ID allocator and start the
> allocation at 1 as it is today. Also recycle IDs when a console port
> is removed.

Sounds like a good idea!

> @@ -1244,8 +1236,11 @@ static int init_port_console(struct port *port)
>   	 * pointers.  The final argument is the output buffer size: we
>   	 * can do any size, so we put PAGE_SIZE here.
>   	 */
> -	port->cons.vtermno = pdrvdata.next_vtermno;
> +	ret = ida_alloc_range(&vtermno_ida, 1, ~0, GFP_KERNEL);

Just cosmetics: I think you could use ida_alloc_min() instead.

> +	if (ret < 0)
> +		return ret;
>   
> +	port->cons.vtermno = ret;
>   	port->cons.hvc = hvc_alloc(port->cons.vtermno, 0, &hv_ops, PAGE_SIZE);
>   	if (IS_ERR(port->cons.hvc)) {
>   		ret = PTR_ERR(port->cons.hvc);

What if this if (IS_ERR()) error happens? The code seems to return early in 
this case - shouldn't the ID be freed again in this case?

  Thomas

