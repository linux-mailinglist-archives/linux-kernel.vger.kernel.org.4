Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4EA5F0C34
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiI3NL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiI3NLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:11:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5EF176AE3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664543507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P4n0wbpA7qa1QlWhsnYkQ0ruJZmndCQFgnAxOwZr52k=;
        b=R2n4DmJ3WMhSeumsusDIg8HZqj6DnDsS8YJDjKLtSzE1lS3QH4RtL36KkmUxNHaNJnm41g
        LmcEwacNjI0sFmcLY+I2XVkqxp8atlSx7ACpooolp3GBeOKGJIFCqYQzBhkVpeNVEAbqP4
        GcpcP0O3LU1gInftdz/n/o9NikK6dJ0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-NcfBrLkvOdy66vN8kmYBiw-1; Fri, 30 Sep 2022 09:11:45 -0400
X-MC-Unique: NcfBrLkvOdy66vN8kmYBiw-1
Received: by mail-oo1-f69.google.com with SMTP id e9-20020a4a9b49000000b00475ea4651fcso1978529ook.17
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=P4n0wbpA7qa1QlWhsnYkQ0ruJZmndCQFgnAxOwZr52k=;
        b=ZJoWnoV3E1f+YbtWS4RFqKOMajX8cxITRJX8QcOyZzfpcZhB/Nl7axgtHuTtQTm0n8
         i0cFAtdqNmsr0Ic7E7t0trUo6SQH42K+WT7njfIckSe/TVF1PEYsoWFw5T7XEukY/Zim
         EszHMZpStschJIof3QaelU5UQWTC5KMoLpxlqKOJKqrwcGLAdsyEfDjVLFm6x+nXMvAR
         UGGU+KDkvI1C67p21pwzz4MZYtoXrKgfbaRrdNCSMAuAOjPQ7TvZGmSGF5/STLIiRV+j
         v8sy7r9zuTnODpBkEsxmW3BuZAJ+9R5SGfG/E5s4msFmifPSVqUNmX/NzkPsNJwDtGUi
         aJrw==
X-Gm-Message-State: ACrzQf0Ulu6iGuWwrICv1QdreSUGm22CoxOj8zTF+jMzpkSKcHetproh
        5QAOmqyWMSrWRDmyfVu0/K1MwwUD5663CnzQGqmFkC8DcL5I9eWq/Te2/ugh6nn3VoTu+Jc57LS
        Z4YpV7lN8cA0nEdoN1pUIBxwg
X-Received: by 2002:a05:6870:c68b:b0:131:cf20:9971 with SMTP id cv11-20020a056870c68b00b00131cf209971mr4438005oab.70.1664543505267;
        Fri, 30 Sep 2022 06:11:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM69CO8s606IrTu2JkEqnMnveYd7GKCzmdHKIcERVgd5HxIlzZvPuOBRdkx6iDgb8rr8jUFe6Q==
X-Received: by 2002:a05:6870:c68b:b0:131:cf20:9971 with SMTP id cv11-20020a056870c68b00b00131cf209971mr4437991oab.70.1664543505079;
        Fri, 30 Sep 2022 06:11:45 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::2e])
        by smtp.gmail.com with ESMTPSA id w19-20020a056830111300b006370abdc976sm555412otq.58.2022.09.30.06.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 06:11:44 -0700 (PDT)
Date:   Fri, 30 Sep 2022 08:11:42 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Zhou jie <zhoujie@nfschina.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhiramat@kernel.org,
        rostedt@goodmis.org, edumazet@google.com, rdunlap@infradead.org,
        christophe.leroy@csgroup.eu, rppt@kernel.org,
        mark-pk.tsai@mediatek.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init:Remove unnecessary (void*) conversions
Message-ID: <20220930131142.xbrkwxop6vixnvht@halaneylaptop>
References: <20220928014539.11046-1-zhoujie@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928014539.11046-1-zhoujie@nfschina.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

nit: $subject should have a space after init:, i.e "init: Remove".

On Wed, Sep 28, 2022 at 09:45:39AM +0800, Zhou jie wrote:
> The void pointer object can be directly assigned to different structure
> objects, it does not need to be cast.
> 
> Signed-off-by: Zhou jie <zhoujie@nfschina.com>

With the subject fixed up you can add:

    Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  init/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 98182c3c2c4b..5494caa24738 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1239,7 +1239,7 @@ __setup("initcall_blacklist=", initcall_blacklist);
>  static __init_or_module void
>  trace_initcall_start_cb(void *data, initcall_t fn)
>  {
> -	ktime_t *calltime = (ktime_t *)data;
> +	ktime_t *calltime = data;
>  
>  	printk(KERN_DEBUG "calling  %pS @ %i\n", fn, task_pid_nr(current));
>  	*calltime = ktime_get();
> @@ -1248,7 +1248,7 @@ trace_initcall_start_cb(void *data, initcall_t fn)
>  static __init_or_module void
>  trace_initcall_finish_cb(void *data, initcall_t fn, int ret)
>  {
> -	ktime_t rettime, *calltime = (ktime_t *)data;
> +	ktime_t rettime, *calltime = data;
>  
>  	rettime = ktime_get();
>  	printk(KERN_DEBUG "initcall %pS returned %d after %lld usecs\n",
> -- 
> 2.18.2
> 

