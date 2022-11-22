Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E596333CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiKVDQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiKVDQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:16:05 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBDD1FCD4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:16:04 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id j6so9315153qvn.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 19:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0CiyjDdTfauQUln/S8JKlz3FnBrq1FeGqO43v3NL0cI=;
        b=cyuE3iOBx0NFRc//xsPoso6mtBj6Dgo8Fe/NMGakYHCImhgWQUbZhVoubfovqm6G+h
         CDWydrrIb5+El7DyyxkxXVRmL3OkQKvrbZZt7t3EN9BXnE8ijpngmBxL+uUeFUdT56m3
         1fuEGfXMkMfAGAbAkJHCVXoUl35/jOrG5CyqwfDIE2Do0z8d+IL5Gal1MSbxua7DdP7C
         e40nfakVcSK7De/dX+J3RsP6XlDsb0AH2NtHrmnNyVmxIbZ/3roUow3DjGwg6iJq0gZn
         ucmNOfzdjViIEad+0Hb6Kca8QO5G8Vkx2TftaZcDUPMCsg5rHLt2I3zTOj+uVGGapsTS
         iNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CiyjDdTfauQUln/S8JKlz3FnBrq1FeGqO43v3NL0cI=;
        b=ly3NMXbI+zv3novPQXKGitL89OS4d/MMjM5KXwf+qg48IhxrRZBPDqSIG9E72/qU7e
         EgsYgN59Nx9zulQ3HlRkjRIsEoUfaEnHxJbqaUVzSlIrVnojHnAaV1uoA0cBhP9aSzej
         tQgUR0mvJbdlDSBZ7R63hi32w3Uz7tnqW0Jgxc8y33XjrSza8IenzRzVk+Q1ycj2VNIw
         dJ/M+D9oZwSYN7J01V7k0kn8UYZ5IvJZuaMhzKUgYix0hM3cu178/UB3dkEG0oTiWSUg
         cNW0mfvQQCPWcKhUQrdtsFuW678R+MkhQzP4eI9AXjSEJ+VVHR9mXUiguClhgFwCMVQC
         qKVA==
X-Gm-Message-State: ANoB5pkDe/JI6iaChP+/4UFFy/eh8K1AILFL0biYR2Y1de47fv7HjAn+
        Q31ZROkyeyI1IB7+0RqINFFD1w==
X-Google-Smtp-Source: AA0mqf6Pzmh6pPNAtrTTacw2SzyO5EjWygILYkNiEZQx2H1eUrRxOy+un4c9p4OEWs897pchLEGu4Q==
X-Received: by 2002:a05:6214:162e:b0:4c6:57f1:3514 with SMTP id e14-20020a056214162e00b004c657f13514mr3635896qvw.87.1669086963553;
        Mon, 21 Nov 2022 19:16:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id dt44-20020a05620a47ac00b006fbf88667bcsm3616176qkb.77.2022.11.21.19.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 19:16:03 -0800 (PST)
Date:   Mon, 21 Nov 2022 22:16:28 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not allocate from atomic pool
Message-ID: <Y3w/DFTAypX7L2mp@cmpxchg.org>
References: <20221122013338.3696079-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122013338.3696079-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:33:38AM +0900, Sergey Senozhatsky wrote:
> zswap_frontswap_load() should be called from preemptible
> context (we even call mutex_lock() there) and it does not
> look like we need to do GFP_ATOMIC allocaion for temp
> buffer there. Use GFP_KERNEL instead.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  mm/zswap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 2d69c1d678fe..f6c89049cf70 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1314,7 +1314,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
>  	}
>  
>  	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> -		tmp = kmalloc(entry->length, GFP_ATOMIC);
> +		tmp = kmalloc(entry->length, GFP_KERNEL);

There is another one in zswap_writeback_entry() that seems equally
arbitrary. They came in through the same commit, with no further
explanation as to this choice. Do you want to pick that up too?
