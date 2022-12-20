Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F048B6520E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiLTMpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbiLTMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:44:35 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8622611C00
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:42:12 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so11036536wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJJ50xWxBsBPwyj6/W9ULMCq+MmJKS8E+J4eWZ49RM0=;
        b=gRE7Vr1upbSZhXXMLbcosNUNhX1PT06NUozE5LUlXE6VLOKzu0aKzKD4gXWHPg0FDF
         cC1+Y0R+waXcwynCupEjzl8x3SVVqJOvu/f07vWHpRvxx6UJ223ZZKZd7YfdYWaeyDA/
         9FR7rtraBl2a+I/OCY4bUX6ht4J5WgTNXWmhGTcdON2H91wywpY6SkhXtSlEkQAshNyw
         3RzfU16rlrAsGJcppdd5UpV1ogsQnruiftdcxP6HVmuLw4n/9eRvioir5CMcyGe8y4tQ
         SAuKrnNu4D9Cs6MvTTBPPs5U3HMoaKXerTnl/obaWCW9RWqO6x/vdhw5elMBGd8iktyn
         YvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJJ50xWxBsBPwyj6/W9ULMCq+MmJKS8E+J4eWZ49RM0=;
        b=Ydy8xvThFDOtQNbg1J04cHPthVWaJuSD/PMr59Ghb9tN2i3G2a4aNPsUEtHR4P+23t
         QvhRe1OUZi/lES+G8QJKbCTN7tlGvIeMnR5ry3eataClS7Fi/8mhdzHaQ10pWe8fecCP
         Vvob8knrnrB443h0ilD9U8X9xQFbsan0rtTVFPOA6CeUOAXv9fSG8kIJUNT0P4oGhRk6
         bdBbSU7pwBnuq9l19wrhJJ0ayarwKtyKCPZmlOSHsnBUj5wnV1cZajJzORKAibRHciRI
         EVICLy56wIOOxYa4gfdLVfXwe24yHkL3eVhQYX9KU/y8ZWkOfRbP7N7Mf2MlxOz04Hlb
         XxZw==
X-Gm-Message-State: AFqh2kppLuPM1RNFPp8ywZ2u/7XIYZ8NW7x0CxM8U2EdqlSKumppKA8k
        j/uJVpf72P+DUB04FylXKHE=
X-Google-Smtp-Source: AMrXdXv/griEx+hQUxAfxPLT/1U9I4ZzwAyBPpb+RWe78Ol70ltrmy1wnr8omueutF8BkWrrxOqd1Q==
X-Received: by 2002:a05:600c:5118:b0:3d3:494f:6a39 with SMTP id o24-20020a05600c511800b003d3494f6a39mr10477772wms.16.1671540130665;
        Tue, 20 Dec 2022 04:42:10 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c1c9200b003a84375d0d1sm25398750wms.44.2022.12.20.04.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:42:09 -0800 (PST)
Date:   Tue, 20 Dec 2022 12:42:09 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 2/7] mm/vmalloc.c: add flags to mark vm_map_ram area
Message-ID: <Y6GtoQRnLf+EBul2@lucifer>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-3-bhe@redhat.com>
 <Y52rllbXHMwbpJ8K@lucifer>
 <Y6AaPKT7mdVxdHRl@MiWiFi-R3L-srv>
 <Y6AqRauq6wEYK0n5@lucifer>
 <Y6BYD24wzAogqRyT@MiWiFi-R3L-srv>
 <Y6Bgt7k1H7Ez4EEb@lucifer>
 <Y6GnF51yd+d1qINF@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6GnF51yd+d1qINF@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 08:14:15PM +0800, Baoquan He wrote:
> Hmm, for the two kinds of vm_map_ram areas, their code paths are
> different. for unmapping vmap_block vm_map_ram, it goes through
> vb_free(). I can only do the clearing in free_vmap_block().
>
>   -->vm_unmap_ram()
>      -->vb_free()
>         -->free_vmap_block()
>
> For non vmap_block vm_map_ram area, I can do the clearing in
> vm_unmap_ram().
>   -->vm_unmap_ram()
>      -->__find_vmap_area()
>      -->free_unmap_vmap_area()
>
> As said earlier, clearing va->flags when unmap vm_map_ram area, or
> clearing va->vm in remove_vm_area(), these have better be done.
> However, not clearing them won't cause issue currently. Because the
> old vmap_area is inserted into free_vmap_area_root, when we allocate a
> new vmap_area through alloc_vmap_area(), we will get q new vmap_area
> from vmap_area_cachep, the old va->flags or va->vm won't be carried into
> the new vmap_area. Clearing them is a good to have, just in case.
>

Sure, this is more so about avoiding confusion and perhaps some future change
which might not take into account that flag state could be invalid.

I guess logically speaking, this is still a block when you are unmapping ram, so
it's not unreasonable to retain the VMAP_BLOCK flag. In that case I'd say we're
good simply clearing VMAP_RAM here. Thanks for the explanations!

> Rethinking about this, I may need to do the clearing when freeing
> vmap_block. Otherwise, people will be confused why the clearing is not
> done.
>
> @@ -1815,6 +1815,7 @@ static void free_vmap_area_noflush(struct vmap_area *va)
>
>         spin_lock(&vmap_area_lock);
>         unlink_va(va, &vmap_area_root);
> +       va->flags = 0;
>         spin_unlock(&vmap_area_lock);
>
>         nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
>

That sounds like a good idea!
