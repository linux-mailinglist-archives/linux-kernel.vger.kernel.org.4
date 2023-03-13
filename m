Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2886B78B9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjCMNVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjCMNVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:21:14 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325FC36086
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:21:12 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id s12so12971441qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1678713671;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHO4CXHOhldd2DiUrl/ejsH2q5KI1USw1eGFcu9b0ig=;
        b=M9gNpCcWhIhO+Pofqekr3Qvzn7isiotq8cegImZnyEf2n2rRcx6ujt+RThmAJWVx1m
         KsutCj1fcM/SBSO5HQwRTsAJyYDhmt0/IqBfvjdXFVtdVYYexrx/vani0sPd9Y6C8bSR
         z+OwIsC47lXc71oHHs45SAWYkHgGLU4yWN7bd2W5/4SbhWoB131V3DhK9R0oyYHIgdiT
         GLKhzZWhNR16MXD6iO4dIBhEdtFKYpqqp+gVV6ujs2ZNXBLTPPDItje3mLuQRcVHTvLo
         M7m9O3u292cjuyIbj939FmhD/m8xKkxFDeqc5BzmVb5bUrKk6SCJgvobQsO4suoLSnjN
         k3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678713671;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHO4CXHOhldd2DiUrl/ejsH2q5KI1USw1eGFcu9b0ig=;
        b=vTBWw+hnFCnUEx2jJT1Y9qg5q7rQC/Tb9GGww7QF50gntANpw3+GV/ES3j8Zbiur8K
         pOdPe8qFdI1/2U1jjbw8aq1snho4ep3nNbJyKCJowBbqwgoK1eBPtnC3zbu5SQUdfIRN
         FL9Jw+sw1ZWUGwE3aR36KQdKxgpETFRE1jZ4G+WOvdq9e1/A5zO/kC+VArE6iZITOKoS
         oYwOqJShNYW+5fGOwzQu0R0oFVLCJY574pj3FCE/O/Fl6E9Q3ZeVIkHsaSxafUv9laiJ
         zu/p84tKpeATOlgmxPGODZ11+hHCVu9dmCcQCL0g07Vegn3lIDgZ9694iF0NqK0TVZYV
         XkPg==
X-Gm-Message-State: AO0yUKXSmP+7jIwdhNxwLMoPVcr2rPlYlNEAewddrjgAti8OMvOwXJgQ
        9Bi0Mct7VDeGzgWstEqwSq6hqQ==
X-Google-Smtp-Source: AK7set+qWcXGYSBmUrPiyqZz3kW+BzfzdfMTNJfcQQkggbUK3AbU2ZrHzChSpTh7a62BChLAPG+PxA==
X-Received: by 2002:a05:622a:1045:b0:3bd:1a07:2063 with SMTP id f5-20020a05622a104500b003bd1a072063mr58524181qte.45.1678713671251;
        Mon, 13 Mar 2023 06:21:11 -0700 (PDT)
Received: from cs.cmu.edu (tunnel29655-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:582::2])
        by smtp.gmail.com with ESMTPSA id y1-20020ac87081000000b003b860983973sm5426091qto.60.2023.03.13.06.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:21:10 -0700 (PDT)
Date:   Mon, 13 Mar 2023 09:21:08 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, jack@suse.com,
        anton@tuxera.com, linux-ntfs-dev@lists.sourceforge.net,
        ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] coda: simplify one-level sysctl registration for
 coda_table
Message-ID: <20230313132108.5xbzbxz62jjzecat@cs.cmu.edu>
Mail-Followup-To: Luis Chamberlain <mcgrof@kernel.org>, dhowells@redhat.com,
        linux-cachefs@redhat.com, jack@suse.com, anton@tuxera.com,
        linux-ntfs-dev@lists.sourceforge.net, ebiederm@xmission.com,
        keescook@chromium.org, yzaikin@google.com, j.granados@samsung.com,
        patches@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230310231206.3952808-1-mcgrof@kernel.org>
 <20230310231206.3952808-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310231206.3952808-5-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me, nice little cleanup.

Jan

On Fri, Mar 10, 2023 at 07:04:07PM -0500, Luis Chamberlain wrote:
> There is no need to declare an extra tables to just create directory,
> this can be easily be done with a prefix path with register_sysctl().
> 
> Simplify this registration.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Jan Harkes <jaharkes@cs.cmu.edu

> ---
>  fs/coda/sysctl.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
> index fda3b702b1c5..a247c14aaab7 100644
> --- a/fs/coda/sysctl.c
> +++ b/fs/coda/sysctl.c
> @@ -39,19 +39,10 @@ static struct ctl_table coda_table[] = {
>  	{}
>  };
>  
> -static struct ctl_table fs_table[] = {
> -	{
> -		.procname	= "coda",
> -		.mode		= 0555,
> -		.child		= coda_table
> -	},
> -	{}
> -};
> -
>  void coda_sysctl_init(void)
>  {
>  	if ( !fs_table_header )
> -		fs_table_header = register_sysctl_table(fs_table);
> +		fs_table_header = register_sysctl("coda", coda_table);
>  }
>  
>  void coda_sysctl_clean(void)
> -- 
> 2.39.1
> 
> 
