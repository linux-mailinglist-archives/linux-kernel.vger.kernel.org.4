Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD03C73FDF6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjF0OgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjF0OgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E40273C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687876523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2I4RPsehThqnH3/y9cWZQKNuT4LiknWjJr+uizynBV8=;
        b=ZtlIT+dnAlxAhHDhkTkpQ4VTzYPS8xkbBZZbqV5JUH6WD4q0q7CUSK///ZsNTAGisInq1t
        gffBV2q9LFbRZrMVqVBaSOPWLgrVtq/L9JW+xpYGyJ6NCQrUXE712h/wVYyD+gH6tw58cs
        7yHILZ1B5GhDy+SZvjXPXxC0Y10w/i4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-P1wMmus1OWeUyFMiaMsNZw-1; Tue, 27 Jun 2023 10:35:04 -0400
X-MC-Unique: P1wMmus1OWeUyFMiaMsNZw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9874fbf5c95so525482066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876492; x=1690468492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2I4RPsehThqnH3/y9cWZQKNuT4LiknWjJr+uizynBV8=;
        b=jKaHANq0T0aZMGkFfwFGVgMEDQjBivqN0uFTgr7cu3+yXPZRR8deNsurmwDbvBM9I2
         Fn6ThjmF9WaASZMYb7M6RFyGLIGDb3ib56CBcnaiTh4nnopP+GyPWAratRxZOtH/+lIH
         CiZDiPBCPlhYTOkJ5NR/bnrTDFZznFVPL7KuHL4wxW4WF5y+VVPe0aiT89N9TB0hmZvj
         mxrEXU2Fk5hTgmMsOPCeKbVLbmeaj5gVDB7lwGhUWCbxwoxrDTBVfWdHf9sEzz/cQh75
         udE8y2ygGACM+vdKwFmqy0Zw/rcEzn6DmyyhZdBRivMi8GuX1jc+hP9FweKz0FCuvWdu
         vbDA==
X-Gm-Message-State: AC+VfDxT9qaDkgRHuZyWjs5TocCiLVBrpXGV4y+xdbiL+fpDCzOrjfxl
        7dxtTXVjB1UmpkFS53GrWTCRLJvlXCq1ZRSTaDTOFHAs21MNg20pBGCnMME5XA8/Dtb8IZoqYF6
        +RFpHzj7c2SEh6O0oZlsnJO8R
X-Received: by 2002:a17:907:8686:b0:987:d0c3:e300 with SMTP id qa6-20020a170907868600b00987d0c3e300mr28330433ejc.26.1687876492628;
        Tue, 27 Jun 2023 07:34:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7j3siesSuwDDTtjYEMoIX15DvUDbPq20AHtUXQVahommtxFi3hAAB5BjCBJEb1dI9s6am0ng==
X-Received: by 2002:a17:907:8686:b0:987:d0c3:e300 with SMTP id qa6-20020a170907868600b00987d0c3e300mr28330412ejc.26.1687876492365;
        Tue, 27 Jun 2023 07:34:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906948e00b00988b86d6c7csm4607674ejx.132.2023.06.27.07.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 07:34:51 -0700 (PDT)
Message-ID: <6a566e51-6288-f782-2fa5-f9b0349b6d7c@redhat.com>
Date:   Tue, 27 Jun 2023 16:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Content-Language: en-US, nl
To:     Sumitra Sharma <sumitraartsy@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Fabio <fmdefrancesco@gmail.com>,
        Deepak R Varma <drv@mailo.com>
References: <20230627135115.GA452832@sumitra.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230627135115.GA452832@sumitra.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/27/23 15:51, Sumitra Sharma wrote:
> kmap() has been deprecated in favor of the kmap_local_page() due to high
> cost, restricted mapping space, the overhead of a global lock for
> synchronization, and making the process sleep in the absence of free
> slots.
> 
> kmap_local_{page, folio}() is faster than kmap() and offers thread-local
> and CPU-local mappings, can take pagefaults in a local kmap region and
> preserves preemption by saving the mappings of outgoing tasks and
> restoring those of the incoming one during a context switch.
> 
> The difference between kmap_local_page() and kmap_local_folio() consist
> only in the first taking a pointer to a page and the second taking two
> arguments, a pointer to a folio and the byte offset within the folio which
> identifies the page.
> 
> The mappings are kept thread local in the functions 'vboxsf_read_folio',
> 'vboxsf_writepage', 'vboxsf_write_end' in file.c
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  fs/vboxsf/file.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
> index 572aa1c43b37..5190619bc3c5 100644
> --- a/fs/vboxsf/file.c
> +++ b/fs/vboxsf/file.c
> @@ -234,7 +234,7 @@ static int vboxsf_read_folio(struct file *file, struct folio *folio)
>  	u8 *buf;
>  	int err;
>  
> -	buf = kmap(page);
> +	buf = kmap_local_folio(folio, off);
>  
>  	err = vboxsf_read(sf_handle->root, sf_handle->handle, off, &nread, buf);
>  	if (err == 0) {
> @@ -245,7 +245,7 @@ static int vboxsf_read_folio(struct file *file, struct folio *folio)
>  		SetPageError(page);
>  	}
>  
> -	kunmap(page);
> +	kunmap_local(buf);
>  	unlock_page(page);
>  	return err;
>  }
> @@ -286,10 +286,10 @@ static int vboxsf_writepage(struct page *page, struct writeback_control *wbc)
>  	if (!sf_handle)
>  		return -EBADF;
>  
> -	buf = kmap(page);
> +	buf = kmap_local_page(page);
>  	err = vboxsf_write(sf_handle->root, sf_handle->handle,
>  			   off, &nwrite, buf);
> -	kunmap(page);
> +	kunmap_local(buf);
>  
>  	kref_put(&sf_handle->refcount, vboxsf_handle_release);
>  
> @@ -320,10 +320,10 @@ static int vboxsf_write_end(struct file *file, struct address_space *mapping,
>  	if (!PageUptodate(page) && copied < len)
>  		zero_user(page, from + copied, len - copied);
>  
> -	buf = kmap(page);
> +	buf = kmap_local_page(page);
>  	err = vboxsf_write(sf_handle->root, sf_handle->handle,
>  			   pos, &nwritten, buf + from);
> -	kunmap(page);
> +	kunmap_local(buf);
>  
>  	if (err) {
>  		nwritten = 0;

