Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB26C61F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCWIiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjCWIiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323C812BE6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679560535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q2h2VoBtpKVUit8eaQH7nfWe6R/baAp4jt1GjEBXDY0=;
        b=R2H3ksIEiRbc2/07aCrRAJDR4KkJPpLpCazz0pDchHF8QEMDRchnugiqvnw3hi47V//t85
        fBPzu4WUQpZLc5XqYAINS35TCO3nxXTEsktVDyrqdqc9BKjasCSYrfwgijrmo1ZDrfhNoC
        1ao39RCnGdtXbgbfeOMZuJKhhic1xkw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-2ATDj_GmNY6s1FAez6DU_w-1; Thu, 23 Mar 2023 04:35:34 -0400
X-MC-Unique: 2ATDj_GmNY6s1FAez6DU_w-1
Received: by mail-ed1-f69.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so30681226edc.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679560533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2h2VoBtpKVUit8eaQH7nfWe6R/baAp4jt1GjEBXDY0=;
        b=YNcYtIR1IEH9Seuin+gp4V+kbu4BuX5S85AJZa9EWJM4YLQ6cmLoc1i4UMuUSRZ1tL
         RiHCRVd7XIDSCruZLgM//k7om8Q17gNT2vDMzaERjrfoA9h8+g3aSCTr0jNY3z8UVa4O
         ordZAOBpEiL9YiqveRltsApD1Xgsc4rcQTJZODU9MHwdwlNFh9eSbUzUrykKEoL2GuAs
         L8hPbjgY+jlxfRZtqtTyHW/O8+Pls3UAWhtsZbJOkneYDnlekfrikxcpixp0g8bQlffF
         GMLYhJaz7degX0101YDbZdd1oW00CXgw+7OkYnE9NGmfQGtSZ6vBWQZTnppmAyB3t019
         S04A==
X-Gm-Message-State: AO0yUKUnpNFFl6ZRdX1+wdKY2iQlZut6cr5+GHCDwHrrtk1dIjIf1bzV
        OgzRZoIEjehoHPPnRYX1IQ01Ky6Rf74csXsrlGl6CU0IB2eqPIIkfWMIYgOsZdUms1nha9ctrsf
        1tQqlsy7OANYljrj9/ajTA+A+
X-Received: by 2002:a17:907:8a1a:b0:920:7827:302 with SMTP id sc26-20020a1709078a1a00b0092078270302mr5999927ejc.18.1679560533390;
        Thu, 23 Mar 2023 01:35:33 -0700 (PDT)
X-Google-Smtp-Source: AK7set/p1OILgt7zsTiuJiRZ7Ij2OcC72M1xyP4ZUGnat8eDmsjI/i5k0yeLe/IK3B+iTBt07ZITsg==
X-Received: by 2002:a17:907:8a1a:b0:920:7827:302 with SMTP id sc26-20020a1709078a1a00b0092078270302mr5999917ejc.18.1679560533151;
        Thu, 23 Mar 2023 01:35:33 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170907985300b008c327bef167sm8324109ejc.7.2023.03.23.01.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 01:35:32 -0700 (PDT)
Date:   Thu, 23 Mar 2023 09:35:30 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, brauner@kernel.org,
        syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
Message-ID: <20230323083530.6clofhwkixfkmvgw@sgarzare-redhat>
References: <20230322185605.1307-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
>vhost_task_create is supposed to return the vhost_task or NULL on
>failure. This fixes it to return the correct value when the allocation
>of the struct fails.
>
>Fixes: 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process") # mainline only
>Reported-by: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> kernel/vhost_task.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
>index 4b8aff160640..b7cbd66f889e 100644
>--- a/kernel/vhost_task.c
>+++ b/kernel/vhost_task.c
>@@ -88,7 +88,7 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
>
> 	vtsk = kzalloc(sizeof(*vtsk), GFP_KERNEL);
> 	if (!vtsk)
>-		return ERR_PTR(-ENOMEM);
>+		return NULL;
> 	init_completion(&vtsk->exited);
> 	vtsk->data = arg;
> 	vtsk->fn = fn;
>-- 
>2.25.1
>

