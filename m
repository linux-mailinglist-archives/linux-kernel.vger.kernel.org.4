Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5546428F1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiLENHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiLENH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:07:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BE01BEAC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670245584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fysUMtd7nyS68Uh6akbyo7z/TqrJMUL08Oy/r5zD+R0=;
        b=eXYRAYPcs+N0cnCothl45L4Mfw3hcz7czXPP1bAcyGCxuOzJoiPStjbDKB+pCSWGF+tVux
        duillBH+kWy6CuU8tK0Ampc8dMi6BNCTbHUIvzbQrnzXnnkm+hMyD0T3FkentRBHOppYoM
        ErW/CLgWxyujvg5J575eH/kzyziskX4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-340-8B24OzxzMTS-_CHzVW0nNg-1; Mon, 05 Dec 2022 08:06:23 -0500
X-MC-Unique: 8B24OzxzMTS-_CHzVW0nNg-1
Received: by mail-wr1-f69.google.com with SMTP id a7-20020adfbc47000000b002421f817287so2269575wrh.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 05:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fysUMtd7nyS68Uh6akbyo7z/TqrJMUL08Oy/r5zD+R0=;
        b=hCG73yFWzs1R9zUS3aOjpr+JPSUvctyQ1w+TP3sDioZ1jpN5/wp+SZ5clPTbfum+nG
         2d4itiA690bh1yxt2ZX5gDXtzGKEq1jNn8ZChT+vbooywlxTm8w7h7gFtb3b/oavRu2y
         WyHnvaPTYb9sKnX4og0uT4lKo/3Ic8mscTqEmN4DiF9S5yRgYxbSXmqz5pbr678mh2de
         /wHiGjXn49qX9adNmYwhp51n6Dv43M3t8IPkrvwSl6vWm5tp0ietPfjDqrfX4+6iboVM
         7H2Q2m+EtGSXaCjVtRnSCRfBwEeIX1bYkdhZJg6qa4OHae9KQwjJ4E4NDvYddhmV0MeQ
         PeYQ==
X-Gm-Message-State: ANoB5pndVcYqiMlTFAiW4rY5xBqtzfobafYBqq6Jetzr0vdqXQzpU+WT
        Gty7DKBzT/nmySuytbOoO+FHmcQTA5XOKb86sGWLk7LybJxMmdn9R2f1ES1/mI/Llf777mZrQAA
        IqctLMt1f76A0xKatxReLl6tl
X-Received: by 2002:a7b:cb83:0:b0:3cf:96da:3846 with SMTP id m3-20020a7bcb83000000b003cf96da3846mr61506319wmi.10.1670245581737;
        Mon, 05 Dec 2022 05:06:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7RZfPMSS4umpthjPuwuEfbtfp0zUdyrA+FWxPzPvb5YZzdZ87NyoR3TcEQ0+8D1lPGIcScpg==
X-Received: by 2002:a7b:cb83:0:b0:3cf:96da:3846 with SMTP id m3-20020a7bcb83000000b003cf96da3846mr61506308wmi.10.1670245581511;
        Mon, 05 Dec 2022 05:06:21 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b003cf54b77bfesm23862340wmq.28.2022.12.05.05.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 05:06:21 -0800 (PST)
Date:   Mon, 5 Dec 2022 14:06:15 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Bryan Tan <bryantan@vmware.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH v3] net: vmw_vsock: vmci: Check memcpy_from_msg()
Message-ID: <20221205130615.jqnno74hnui6527c@sgarzare-redhat>
References: <20221205094736.k3yuwk7emijpitvw@sgarzare-redhat>
 <20221205115200.2987942-1-artem.chernyshev@red-soft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221205115200.2987942-1-artem.chernyshev@red-soft.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 02:52:00PM +0300, Artem Chernyshev wrote:
>vmci_transport_dgram_enqueue() does not check the return value
>of memcpy_from_msg(). Return with an error if the memcpy fails.
>
>Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
>Fixes: 0f7db23a07af ("vmci_transport: switch ->enqeue_dgram, ->enqueue_stream and ->dequeue_stream to msghdr")
>Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
>---
>V1->V2 Fix memory leaking and updates for description
>V2->V3 Return the value of memcpy_from_msg()
>
> net/vmw_vsock/vmci_transport.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

