Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72586633722
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiKVIan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiKVIaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:30:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0B33FBBE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669105728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z94rTogxpTfB3zkjuR47qQ/M+hZd3Seb7BgxdhYJsLY=;
        b=IzxQkNcadQkYyjJ5RY64i3lffAi3t3S1VMSVSG2pNVlt64VSwv/gXyDS3o08NPP6OLxhAG
        QptnJ0S/M0ff1F3APKHy+HAMAmibaD0hkuLZx8KIW+4XivX0+kF70OcArz0A1brXQbnIUc
        nHIHcGRnWJzXfATquvqA2JvHVHZXA8g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-634-kwVdvwCxN7C3hgveKl_XvQ-1; Tue, 22 Nov 2022 03:28:47 -0500
X-MC-Unique: kwVdvwCxN7C3hgveKl_XvQ-1
Received: by mail-qv1-f72.google.com with SMTP id nk7-20020a056214350700b004c68c912c93so12730797qvb.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z94rTogxpTfB3zkjuR47qQ/M+hZd3Seb7BgxdhYJsLY=;
        b=JWh08mWPvNGQqGyhuyHQELqMcqOnkYXc6ZrEo+xFaSk5y9cQpi6eOvgbAaNwA0fDHh
         R/3jcRqD6lhWMrxUjz2MS7b8rNWLv8YzCG4mntxEsFp1YAeTYJFoaDy7G3nPrGeCLyYe
         JrmEghloZ0tf0NOpLKtAtS/+78S2qDZPnvWtka3nOQ83AUBOy3vcoIC/d3bdYoJrK8Bn
         qzEXtUH4RgjK4FbcKPcfc4RqX7uRhGCW6phC4vOvDUUvynHSDOpWCMlbl89rZA4QJoqo
         EnVClSrT8AT/SHcj42rxYVn4SCB6t3fB+/MNhq69YOGLutv0DEjFtCiXkcJst4wPY5NZ
         q24g==
X-Gm-Message-State: ANoB5plMfTkQhCLJR/OpdM77WGDnFLGm7Ddr+qBXyP3LLod9dhFrzWqS
        z4PMtgaDdDXPbJ2PHwZ0tWwV/zkCEq25IEIqHmZW44d3mlIis7oVqGbU6zCQHJCk0XFkg1lwv5e
        uKg2vJTGwxF49f24SOIRa2m4P
X-Received: by 2002:a37:80c:0:b0:6fa:2cab:4945 with SMTP id 12-20020a37080c000000b006fa2cab4945mr4570780qki.256.1669105727021;
        Tue, 22 Nov 2022 00:28:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Pliy5jAIfnm9v3oSdvBPyuy3r56Bwe/AXa5iDcJN9dM4Xf2uSXIiYOCiXMtfAJUuyEn+oOQ==
X-Received: by 2002:a37:80c:0:b0:6fa:2cab:4945 with SMTP id 12-20020a37080c000000b006fa2cab4945mr4570766qki.256.1669105726782;
        Tue, 22 Nov 2022 00:28:46 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a258a00b006bb82221013sm9827463qko.0.2022.11.22.00.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 00:28:46 -0800 (PST)
Message-ID: <0a568e890497f4066128b1ce957904e0c5540c16.camel@redhat.com>
Subject: Re: [PATCH net] sfc: fix potential memleak in
 __ef100_hard_start_xmit()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Nov 2022 09:28:42 +0100
In-Reply-To: <Y3e8wEZme3OpMZKV@unreal>
References: <1668671409-10909-1-git-send-email-zhangchangzhong@huawei.com>
         <Y3YctdnKDDvikQcl@unreal> <efedaa0e-33ce-24c6-bb9d-8f9b5c4a1c38@huawei.com>
         <Y3YxlxPIiw43QiKE@unreal> <Y3dNP6iEj2YyEwqJ@gmail.com>
         <Y3e8wEZme3OpMZKV@unreal>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 2022-11-18 at 19:11 +0200, Leon Romanovsky wrote:
> On Fri, Nov 18, 2022 at 09:15:43AM +0000, Martin Habets wrote:
> > On Thu, Nov 17, 2022 at 03:05:27PM +0200, Leon Romanovsky wrote:
> > > Please take a look __ef100_enqueue_skb() and see if it frees SKB on
> > > error or not. If not, please fix it.
> > 
> > That function looks ok to me, but I appreciate the extra eyes on it.
> 
> __ef100_enqueue_skb() has the following check in error path:
> 
>   498 err:
>   499         efx_enqueue_unwind(tx_queue, old_insert_count);
>   500         if (!IS_ERR_OR_NULL(skb))
>   501                 dev_kfree_skb_any(skb);
>   502
> 
> The issue is that skb is never error or null here and this "if" is
> actually always true and can be deleted.

I think that such additional change could be suite for a different net-
next patch, while this -net patch could land as is, @Leon: do you
agree?

Thanks!

Paolo

