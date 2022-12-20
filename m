Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6065269E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiLTSxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiLTSxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:53:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821FB25E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:53:20 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso9596360wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UzaumV1qmFEO+Q1QfIQVEyz9X6tRYoSPlnet4KT4SeU=;
        b=BwXrlbnI4MOJPppl3xaWkzqRn7rsVMlvfAbFJzqUV6pk1geozWThyH7nKND7+qD+CC
         AZhYZD/dRxcSx9OmHQ5WU6CLHG3qRdwqVaBhgWGznn98hJKAkYB9hhOkCg2tKUYHFdH5
         PxzBw+Tjrz8KVv0E0R90Ttr2tqvXx+Zujlgo8v1OEYdvKPiXL7v01605dhdyuuTLVrR0
         pFXpeY9AFf5EmCpP4VW/GU1ZpxcfnyOXnxspcAKD8+69RIbnaw9FviItL5mY0bGZ6l3V
         Fx8hkZrS4Wh9Xj9ntlbUIFL3ExPpPASpGZU8ngOC2w+VymcAp6nstjRZfoUXKDO2niNm
         Nyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzaumV1qmFEO+Q1QfIQVEyz9X6tRYoSPlnet4KT4SeU=;
        b=Plj8WCO5E2kKBmIr9NrXDzedthj3Bgi/+K2A4lDgxUGzdI+owSu7gUHF4aQ74BG5IP
         Es6//02wObRrhJ9YiOnKMVITIWeEDRQIJG2PiscgrDx7YyknMFF53TQoiRYq6xMIlBYC
         UgVw5NEmw/E4NHfx54Nn4+9ny3Si4ePkrefcyX0IqhyrJeD3y5zW2iiDVXhKSRCbtchP
         I/MStRhSDHJGVPRrniJOYw644Nv/Pjt8APt8rda6efFF8Nx0hjK02ott8ifGAWGX7h4T
         BxTdhfpvadFa5yTygHbCXNF38f5QBvaiRRn+dnUrd9+l7e3VCUpz8Q8C+dHJfwqd+clt
         fo/w==
X-Gm-Message-State: AFqh2kp8DqZYeLIop1TJEa+I8f8Yi9Da0JzwArNlYNVwGJM22m6yXARa
        0As5V4h5T0Wcfx0ujw371PM=
X-Google-Smtp-Source: AMrXdXsUNU2wbal/lIFQSPHp3gWmLxFK2JLY6OdIoUpfjNmrOJL1+CHBtos07cLIzoEOkkIT6SeKLQ==
X-Received: by 2002:a05:600c:3b87:b0:3d2:813:138a with SMTP id n7-20020a05600c3b8700b003d20813138amr2512071wms.35.1671562399046;
        Tue, 20 Dec 2022 10:53:19 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b003d35c09d4b9sm7338565wmb.40.2022.12.20.10.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:53:18 -0800 (PST)
Date:   Tue, 20 Dec 2022 18:53:18 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] mm: vmalloc: Replace BUG_ON() by WARN_ON_ONCE()
Message-ID: <Y6IEnojgQtQcUgDe@lucifer>
References: <20221220182704.181657-1-urezki@gmail.com>
 <20221220182704.181657-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220182704.181657-2-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 07:27:04PM +0100, Uladzislau Rezki (Sony) wrote:
> Currently a vm_unmap_ram() functions triggers a BUG() if an area
> is not found. Replace it by the WARN_ON_ONCE() error message and
> keep machine alive instead of stopping it.
>
> The worst case is a memory leaking.
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 0fc38c36e0df..e05a0dc79ac5 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2255,10 +2255,12 @@ void vm_unmap_ram(const void *mem, unsigned int count)
>  	}
>
>  	va = find_unlink_vmap_area(addr);
> -	BUG_ON(!va);
> -	debug_check_no_locks_freed((void *)va->va_start,
> -				    (va->va_end - va->va_start));
> -	free_unmap_vmap_area(va);
> +
> +	if (!WARN_ON_ONCE(!va)) {
> +		debug_check_no_locks_freed((void *)va->va_start,
> +			(va->va_end - va->va_start));
> +		free_unmap_vmap_area(va);
> +	}
>  }
>  EXPORT_SYMBOL(vm_unmap_ram);
>
> --
> 2.30.2
>

Absolutely in favour of this in principle (BUG_ON() is something we should
resort to in only the direst of circumstances), one small nit - perhaps it'd be
neater to simply make this a guard clause? E.g.:-

	if (!WARN_ON_ONCE(!va))
		return;

	...
