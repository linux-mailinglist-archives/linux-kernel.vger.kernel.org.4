Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F117F6C60E9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCWHia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCWHiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAF61815A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679557045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ASpqWWfn4/Pghp46A648jZMTYKlpL4ywq85+5CfPLiM=;
        b=NfdCFV/tyWkMHPvk62C7eNWPo2v/iV5AI85EkIDHKYSWc3wO87tlH0G1tGM34S9kSJasEn
        WNO6s9zvBZrq//A4hnl6X7Fi9emwXLvpU7ii/D6sArHgrAefZ7lqtlBSHZMZEsPY8oBaRv
        3wMcFfDFTB80Y25+eEtWo6AdcQAK1Xk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-kPOxcW8ONO2y9RUBazl5IQ-1; Thu, 23 Mar 2023 03:37:24 -0400
X-MC-Unique: kPOxcW8ONO2y9RUBazl5IQ-1
Received: by mail-ed1-f71.google.com with SMTP id p36-20020a056402502400b004bb926a3d54so30656726eda.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679557043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASpqWWfn4/Pghp46A648jZMTYKlpL4ywq85+5CfPLiM=;
        b=lTqnBaEBysZDn+qYGBx8gGxx66+48Rv+8Eopw104iOugmb6trbY06acB+q5DLvIbBU
         y7c9Fk1zt07EH7hjtg2QY0ah5TWyyshwVJCzZtv8feLSI9T8o1uGSmlOkDIH3nUOaR+a
         j44j9byRk3oMqA/oMQy278tVnyN790vyE3fSzF5s7da+may/VEz2XMEDzSC8lDh1vTjK
         AKFRnU18zFNQdMidCqYdLqJEO7sDR1xxwjJ2GSQc50slTItQVzqvrGnnLntdkPNLoNi/
         n7onx+R6orsa+YNm8vVM9LaOU6kEdQQSFiaN/ZL6w7Bw0jt0pS0b0iQRYIjl6eIJeqvA
         kN4A==
X-Gm-Message-State: AO0yUKUS3bEU/r/Te++RvB5r/S7p2pdHgXjxqoM+pxACm0mE8Lrdu16M
        QZth6kxYr6/rEE2pNhqSJMsytiAraexIhrOs+iH8zTK3vP9saCbOvPF6LtGPf10uLrQYdUEQmcH
        Nd1oHIxqzwymd6pO53cQbSnS/
X-Received: by 2002:a17:906:7211:b0:933:3a22:8513 with SMTP id m17-20020a170906721100b009333a228513mr10805912ejk.53.1679557043439;
        Thu, 23 Mar 2023 00:37:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set8b/L3BTDQBOOU5TMs2+wIlVxaD2QXEXQ7Fntb3f/aW6QW0aeG0Wm8pxwOFNNaJCGOwphxUNQ==
X-Received: by 2002:a17:906:7211:b0:933:3a22:8513 with SMTP id m17-20020a170906721100b009333a228513mr10805896ejk.53.1679557043131;
        Thu, 23 Mar 2023 00:37:23 -0700 (PDT)
Received: from redhat.com ([2.52.143.71])
        by smtp.gmail.com with ESMTPSA id d7-20020a1709067f0700b00882f9130eafsm8208911ejr.26.2023.03.23.00.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 00:37:22 -0700 (PDT)
Date:   Thu, 23 Mar 2023 03:37:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, brauner@kernel.org,
        syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
Message-ID: <20230323033557-mutt-send-email-mst@kernel.org>
References: <20230322185605.1307-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322185605.1307-1-michael.christie@oracle.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 01:56:05PM -0500, Mike Christie wrote:
> vhost_task_create is supposed to return the vhost_task or NULL on
> failure. This fixes it to return the correct value when the allocation
> of the struct fails.
> 
> Fixes: 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process") # mainline only
> Reported-by: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

The affected patch is not upstream yet, right?
I don't know if the tree in question allows rebases - linux-next
does. So ideally it would be squashed to avoid issues during bisect.
Still it's error path so I guess not a tragedy even without squashing.

> ---
>  kernel/vhost_task.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index 4b8aff160640..b7cbd66f889e 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -88,7 +88,7 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
>  
>  	vtsk = kzalloc(sizeof(*vtsk), GFP_KERNEL);
>  	if (!vtsk)
> -		return ERR_PTR(-ENOMEM);
> +		return NULL;
>  	init_completion(&vtsk->exited);
>  	vtsk->data = arg;
>  	vtsk->fn = fn;
> -- 
> 2.25.1

