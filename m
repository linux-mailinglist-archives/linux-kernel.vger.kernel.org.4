Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9937723A81
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbjFFHvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbjFFHub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C22C170C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686037482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=64mB8VnJDA/LxKxZFVStOvP5rlDWTh9CHxDvq7rI3pY=;
        b=BhvhtIZ/q/4Eti+aCMr0t+6EHPnr1Ga/BkIWXX59ltNRWO6nj0T1J5N4eEgWmYeMxoGEtZ
        JQ5IlgJzKtQqYmKchi7imsYdEJZxn9N/TgoNk7zqkFJ9ukzQkjb4lJVMo3pEWAI+fEyBYX
        t+U2QeWvETk3HJU9EeQ6gu0PvZ6L0XA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-TgYPjMx2NFeNOa4ANGONQA-1; Tue, 06 Jun 2023 03:44:41 -0400
X-MC-Unique: TgYPjMx2NFeNOa4ANGONQA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5ec8aac77so33910365e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 00:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686037480; x=1688629480;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64mB8VnJDA/LxKxZFVStOvP5rlDWTh9CHxDvq7rI3pY=;
        b=T0Oe88yeib4u/9kPfihPt0tMsSpldfroHJe7vxJ3NdHqqbdgMVH8U30Xjpyd8eTaw0
         zK6DKTi0/whvGH/TbMAPJQ/ShH0OT4BtJ8nlhIHzZu+9jeICM7Ca6tmCZei3drehb9C/
         rQhmP/1ur8Tmcz/3y+Wvfu0XmA43CkYA/vmYZ9z3PKjxBcHFir1Y0T9kr3GliAHP21zd
         QwdhXcbLw8Z2MS86sIL4MWG+icBMhtvT1exAVXYXFepV8uD/zlrTzT23NIW6jwrF4dhu
         s/yEcTbKTVka5N9ZXHwHTGIAY0ubnQVzh8NQIqCmngvdJKN/vAJYUpoeYOfqWrcUpMiV
         bnOQ==
X-Gm-Message-State: AC+VfDyuxcv1fFDb1Ye90k0jgSYJkSQioyfX6HKSRiET6P68hJH/PZmv
        aL0N90pMMLRtQStSKOUWHFEjXRO1f8t/YQpftt7VGsXSxDS5cfqhOkXbf3XPNfxvaLTmidiXPSx
        vwxpeKVekBXoMlqgmMkg/Pqmn
X-Received: by 2002:a1c:7203:0:b0:3f7:371a:ec8f with SMTP id n3-20020a1c7203000000b003f7371aec8fmr1220190wmc.15.1686037480089;
        Tue, 06 Jun 2023 00:44:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7dpBGyUoTgzJCdLYMvNIUDHo5Na/rUDhwLo/ZSEsYcWEmCjRC/CRJUIv7C4jxUFFaHrXM55A==
X-Received: by 2002:a1c:7203:0:b0:3f7:371a:ec8f with SMTP id n3-20020a1c7203000000b003f7371aec8fmr1220175wmc.15.1686037479745;
        Tue, 06 Jun 2023 00:44:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:d100:ce7e:d566:43f8:2b24? (p200300cbc709d100ce7ed56643f82b24.dip0.t-ipconnect.de. [2003:cb:c709:d100:ce7e:d566:43f8:2b24])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d428b000000b0030aded83385sm11794723wrq.27.2023.06.06.00.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 00:44:39 -0700 (PDT)
Message-ID: <5a3a4025-9dff-713b-8891-fef2bd450b01@redhat.com>
Date:   Tue, 6 Jun 2023 09:44:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] mm/migrate_device: Try to handle swapcache pages
Content-Language: en-US
To:     mpenttil@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Huang, Ying" <ying.huang@intel.com>
References: <20230606050149.25699-1-mpenttil@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230606050149.25699-1-mpenttil@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.06.23 07:01, mpenttil@redhat.com wrote:
> From: Mika Penttilä <mpenttil@redhat.com>
> 
> Migrating file pages and swapcache pages into device memory is not supported.
> The decision is done based on page_mapping(). For now, swapcache pages are not migrated.
> 
> Things can however be improved, for swapcache pages. Try to get rid of the swap cache,
> and if successful, go ahead as with other anonymous pages.
> 
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
> ---
> 
> v3:
>    - Adjust comments
>    - Add Reviewed-bys
> 
> v2:
>    - use folio_test_anon() (Huang, Ying)
> 
>   mm/migrate_device.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index d30c9de60b0d..f76ebccfe067 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -747,13 +747,23 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>   
>   		if (is_device_private_page(newpage) ||
>   		    is_device_coherent_page(newpage)) {
> -			/*
> -			 * For now only support anonymous memory migrating to
> -			 * device private or coherent memory.
> -			 */
> +
>   			if (mapping) {
> -				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> -				continue;
> +				struct folio *folio;
> +
> +				folio = page_folio(page);
> +
> +				/*
> +				 * For now only support anonymous memory migrating to
> +				 * device private or coherent memory.
> +				 *
> +				 * Try to get rid of swap cache if possible.
> +				 *
> +				 */
> +				if (!folio_test_anon(folio) || !folio_free_swap(folio)) {
> +					src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> +					continue;

I'm pretty sure the folio has to be locked in order to call 
folio_free_swap().

-- 
Cheers,

David / dhildenb

