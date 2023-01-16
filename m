Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3AE66BD16
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjAPLnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjAPLnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:43:33 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B514ED8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:43:32 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id a11so2214792lfg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DDY2ydxs0Md/L6JTm4RZDTBwRYkpSjvKBRY/2I51biw=;
        b=MuEmOHgkGzLLTvws9Ihl7oSSt7/unm2LvNMye1oPgRHA9WTV+nmYv1zRxhFy2Inj9m
         CraJ3ViaAD8MHQcap+2CPtIYkB0TcMKg/UIy74J461txx86a+mF91H0aClhukZzqUImc
         WtFGgFR55RW0WH/7OXqSdHM9ybt/gaRx9Rq25uN1WPPXKDplLZW5vSkZOYJsvMKjvWUQ
         Ni1bB8KCAYdV+fvULM6diqWCnwIbDVIjR7OfPNUUJWvOStl3GeUXQT1QKsqiNRuBpgay
         bVXtSU9nL0B1UQCLJ0YKDUKS/KjqFl3MQ0wU1286f1nITThwv1xhBnkUYp8PHRIMWj5Y
         wX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDY2ydxs0Md/L6JTm4RZDTBwRYkpSjvKBRY/2I51biw=;
        b=KJNEtq5mSbfFBcH3yGxFaZHpthYuMQhF5HM5nPISvd4HDrbkSrj6iUBkoFkEjpuMEY
         ilaqsa1bLO0xQOz/slHlca2CGkd8t0uxhjZus0rFdXNWCTGOVcVDw/Vp0xi1Kd+XDKCD
         ApF+8DhDSujgw7m6hWXh4i5birDsvr12OuynCGGXQW0JaNHqycltQHEwMd5crh1bi/bc
         m+mdqngTLBo6fxrHWdaZFRaiza2kqFKshxXYVY1lCfFhXi3Nj5+CHHoScdrYXV/QOdQM
         B+8fbROUdMgwBTMUB2Wy/jbveIUK4XDhjzyw7aWS4DjagWTSCFJ4grwaIYs1oJ+OfmFK
         7EOQ==
X-Gm-Message-State: AFqh2kpKGlfSKRQyRjgDNZVcXvp1dPgRkQi5Thdl0Pihj3spjdELD8nD
        Kc84bSkoSudpQwgbCdehAzI=
X-Google-Smtp-Source: AMrXdXuMz0sQSCLXjhBIYQOM3hUdQls1ndH+6zB95ktI9QD+ueAd+usUmv6UfkcJc2/bAcy6BdyfoQ==
X-Received: by 2002:ac2:5933:0:b0:4ce:e773:db6c with SMTP id v19-20020ac25933000000b004cee773db6cmr4184383lfi.57.1673869411313;
        Mon, 16 Jan 2023 03:43:31 -0800 (PST)
Received: from pc636 (host-90-235-24-7.mobileonline.telia.com. [90.235.24.7])
        by smtp.gmail.com with ESMTPSA id j5-20020a05651231c500b004b5480edf67sm4998955lfe.36.2023.01.16.03.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:43:30 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 16 Jan 2023 12:43:28 +0100
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, urezki@gmail.com,
        lstoakes@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 4/7] mm/vmalloc: explicitly identify vm_map_ram area
 when shown in /proc/vmcoreinfo
Message-ID: <Y8U4YKjVxh1ugnwv@pc636>
References: <20230113031921.64716-1-bhe@redhat.com>
 <20230113031921.64716-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113031921.64716-5-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:19:18AM +0800, Baoquan He wrote:
> Now, by marking VMAP_RAM in vmap_area->flags for vm_map_ram, we can
> clearly differentiate it with other vmalloc areas. So identify
> vm_map_area area by checking VMAP_RAM of vmap_area->flags when shown
> in /proc/vmcoreinfo.
> 
> Meanwhile, the code comment above vm_map_ram area checking in s_show()
> is not needed any more, remove it here.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmalloc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 13875bc41e27..4a10b3b692fa 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4225,11 +4225,7 @@ static int s_show(struct seq_file *m, void *p)
>  
>  	va = list_entry(p, struct vmap_area, list);
>  
> -	/*
> -	 * s_show can encounter race with remove_vm_area, !vm on behalf
> -	 * of vmap area is being tear down or vm_map_ram allocation.
> -	 */
> -	if (!va->vm) {
> +	if (!va->vm && (va->flags & VMAP_RAM)) {
>  		seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
>  			(void *)va->va_start, (void *)va->va_end,
>  			va->va_end - va->va_start);
> -- 
> 2.34.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
