Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B26863EC64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLAJZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLAJZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:25:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E019D287
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669886648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UgJ+HDh8KhhTBQLgmfONT+YSYAYl+JCf9dmOxyoPJKY=;
        b=N1/PSGKv5YW8MDhRPCJ4zKklu1dF0Tjsd4HUfWspcu25TULowDZN4Pie1P80aAWt63TSrG
        H5P+jRh5GB1Vl0+L7ylyW2RjEira1PWDo1JAKf6Sxj/+3PwCTX8OFB52wcrXL5RfaBVp5n
        LTYV8bNuEa9LXHzlkJ0gsCFN53P0KbU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-SARdwcseOP6SDHCCNBOvzA-1; Thu, 01 Dec 2022 04:24:06 -0500
X-MC-Unique: SARdwcseOP6SDHCCNBOvzA-1
Received: by mail-wm1-f70.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso600924wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgJ+HDh8KhhTBQLgmfONT+YSYAYl+JCf9dmOxyoPJKY=;
        b=JJtjH3XHDwxf454vcAcNdSZ4MOQezze3HZCL3BCTDLL3R0ioKTixjF7HS9BHsO/ie9
         t+ALQBMh2n3AVg3+gOryqGkL0Dam0vJTS3w9SLRYceP4R7zPKs1vdw3NFp8f+sunDho4
         H1MOB9qXYxVq0rlqeD4eeUzCniaaxU3Sd+WeiQfhPc6mpyT6gNttsdkqOIdnPfb5S6ZM
         DqJsNKIp1nPT/ILMp7e3Qf7j9X/KD5n+htMNz8vak3Rn7RLVd74hjjHgqEpJMqPnb2M9
         fNxiu3ZvDh3lsa+BTaClSpPnSlLjTOfvfwVip35bDL2Zv15tVutCHhk5SiniVOkyZDkn
         7sdg==
X-Gm-Message-State: ANoB5pntksixPMePrNq1xHY1scDdPiwTr+RHfbvo/Meip1oIXbIdt7jv
        gbz18TI1LPeuHp583ukTrQ6rLQf9d7ko5kS0t0hC3U1ZTE3SuLs/DPFOh+Phd92uI+EvSVFligb
        mQ3HusTZJOGqFuENdcuk3mx+a
X-Received: by 2002:a5d:4ccb:0:b0:236:d611:4fcf with SMTP id c11-20020a5d4ccb000000b00236d6114fcfmr29574584wrt.192.1669886645078;
        Thu, 01 Dec 2022 01:24:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf51AfiJW8ivh3gMCG70OBpMd9MsL8P1xJEHEG5W9Kg8EmdeOizi/C3u9PaCATJ6V1Bz8hc4Hw==
X-Received: by 2002:a5d:4ccb:0:b0:236:d611:4fcf with SMTP id c11-20020a5d4ccb000000b00236d6114fcfmr29574568wrt.192.1669886644807;
        Thu, 01 Dec 2022 01:24:04 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id l5-20020a5d5605000000b002367ad808a9sm3868673wrv.30.2022.12.01.01.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:24:04 -0800 (PST)
Date:   Thu, 1 Dec 2022 10:23:30 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Dexuan Cui <decui@microsoft.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        Bobby Eshleman <bobby.eshleman@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v2 2/6] hv_sock: always return ENOMEM in case of error
Message-ID: <20221201092330.ia5addl4sgw7fhk2@sgarzare-redhat>
References: <9d96f6c6-1d4f-8197-b3bc-8957124c8933@sberdevices.ru>
 <a10ffbed-848d-df8c-ec4e-ba25c4c8e3e8@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a10ffbed-848d-df8c-ec4e-ba25c4c8e3e8@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 05:05:53PM +0000, Arseniy Krasnov wrote:
>From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>This saves original behaviour from af_vsock.c - switch any error
>code returned from transport layer to ENOMEM.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/hyperv_transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 59c3e2697069..fbbe55133da2 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -687,7 +687,7 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
> 	if (bytes_written)
> 		ret = bytes_written;
> 	kfree(send_buf);
>-	return ret;
>+	return ret < 0 ? -ENOMEM : ret;

I'm not sure for hyperv we want to preserve -ENOMEM. This transport was 
added after virtio-vsock, so I think we can return the error directly.

@Dexuan what do you think?

Thanks,
Stefano

