Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887D75ED560
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiI1GvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiI1GuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC181128
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664347742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y6zUQ1QeMABO48yK91yy+7BFQ5QVaCICeA10q23nqLI=;
        b=JCpJ519bqqMtxTq3XqcX9c6IePAjBmVXdl8DHH1LKhtNmzq27d2FnP0QaPWeha+xl67nc0
        VcksHIWD1wwjaJyX5dq3iMS8YRFXqmwMtUKuikijxG498culhAzJxwmOD/wyS2wntk/DCT
        wyqO130ItB+56E6vS9XYbsMtEVWx9lo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-nxBisCmmNtS3aDH23RHAfw-1; Wed, 28 Sep 2022 02:48:58 -0400
X-MC-Unique: nxBisCmmNtS3aDH23RHAfw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB28E85A5A6;
        Wed, 28 Sep 2022 06:48:57 +0000 (UTC)
Received: from localhost (ovpn-13-211.pek2.redhat.com [10.72.13.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 961F82024CB7;
        Wed, 28 Sep 2022 06:48:56 +0000 (UTC)
Date:   Wed, 28 Sep 2022 14:48:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     cgel.zte@gmail.com
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] kexec: Remove the unneeded result variable
Message-ID: <YzPuVVm5TwOilkGW@MiWiFi-R3L-srv>
References: <20220908010352.342820-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908010352.342820-1-ye.xingchen@zte.com.cn>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/22 at 01:03am, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value kimage_add_entry() directly instead of storing it in
> another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  kernel/kexec_core.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index ca2743f9c634..969e8f52f7da 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -561,23 +561,17 @@ static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
>  static int kimage_set_destination(struct kimage *image,
>  				   unsigned long destination)
>  {
> -	int result;
> -
>  	destination &= PAGE_MASK;
> -	result = kimage_add_entry(image, destination | IND_DESTINATION);
>  
> -	return result;
> +	return kimage_add_entry(image, destination | IND_DESTINATION);
>  }
>  
>  
>  static int kimage_add_page(struct kimage *image, unsigned long page)
>  {
> -	int result;
> -
>  	page &= PAGE_MASK;
> -	result = kimage_add_entry(image, page | IND_SOURCE);
>  
> -	return result;
> +	return kimage_add_entry(image, page | IND_SOURCE);
>  }
>  
>  
> -- 
> 2.25.1
> 

