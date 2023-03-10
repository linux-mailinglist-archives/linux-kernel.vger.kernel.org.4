Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0BE6B3954
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjCJI5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCJIzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:55:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35C21091F4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678438268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCB3NLRMqFtG3fMsofAO3zKYURlj2MLuhu7W0R6/NpQ=;
        b=GikLs8+L4v3YNd3VL1BRYoLyLXpe8lMUQnSn9mG2VQsSNQBYV+Uz7lFcTgw+B+tkVypXzp
        f/0qgNd+ZjI4h0rTGJUxnZ1k2bl3YO9RiR4Em1FPo4esM75sgcfg69GE3IvbpprU3TyTIv
        K9WoM8x6g8U3CtYd7ojzoOCxFL2f58I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-YGclpmyAMJ-mpl2JkwJ49Q-1; Fri, 10 Mar 2023 03:51:06 -0500
X-MC-Unique: YGclpmyAMJ-mpl2JkwJ49Q-1
Received: by mail-wr1-f72.google.com with SMTP id l5-20020a5d6745000000b002c91cb49949so900789wrw.14
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678438265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCB3NLRMqFtG3fMsofAO3zKYURlj2MLuhu7W0R6/NpQ=;
        b=VUgmWFsuclvEd1viPSkVBnaL5fJdGh+SPnEXZ6ZQ73jJCCQ7u0cH3iHmXhDilEhUPN
         pa2flrD0OpSok3kz8131jBTttCyzmuYGh0nvGfD65U6NNPyzf/aPDpxTDC9ptM20gIJc
         iFnQn/Zc1Qy1xcpX/UNP0etmuuV2BZmm+GYFmi+Ohw1RtNfVHqKGeCjXB0IwvWyGR8JZ
         IpubWipTYJXgsJ9lwcuVIYPkfGJBOUnyoSLphbktqG3XcpfTR2UejhSBLkVOoaLgdnNe
         o+JOYiiF1Np8pBLCWqvOzrA7vBDLe7qxrawHAEPNwp3oT47LWIqecsXmjKFlBZrajMOa
         IB5w==
X-Gm-Message-State: AO0yUKXCHzODMW+5KSwD33SATl1+LAe9qgZWob+L8sEkUvg7fKnf2qrx
        QcvzkVNle4t2PPGytU8PzPPesrZZIInARi1IUH49hm3w2WpM635CfSl1FZz6HkopBFO9fb2tjvU
        27Jo0V6YnvqvOFbF6p0OP2Jcc9ykODags
X-Received: by 2002:a05:600c:3491:b0:3eb:2e19:ff3a with SMTP id a17-20020a05600c349100b003eb2e19ff3amr1925861wmq.7.1678438265304;
        Fri, 10 Mar 2023 00:51:05 -0800 (PST)
X-Google-Smtp-Source: AK7set+YCSlbveYwJJSJ8QQkuxSPnYyAuHAXqgAyeZXp5ze1IHRI4pjohjPqmISg5ZfMnz/zcZvJdw==
X-Received: by 2002:a05:600c:3491:b0:3eb:2e19:ff3a with SMTP id a17-20020a05600c349100b003eb2e19ff3amr1925847wmq.7.1678438265038;
        Fri, 10 Mar 2023 00:51:05 -0800 (PST)
Received: from redhat.com ([2.52.9.88])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c229200b003dc4a47605fsm2344351wmf.8.2023.03.10.00.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:51:04 -0800 (PST)
Date:   Fri, 10 Mar 2023 03:51:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, tglx@linutronix.de, hch@lst.de,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/11] lib/group_cpus: Export group_cpus_evenly()
Message-ID: <20230310035013-mutt-send-email-mst@kernel.org>
References: <20230228094110.37-1-xieyongji@bytedance.com>
 <20230228094110.37-2-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228094110.37-2-xieyongji@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 05:41:00PM +0800, Xie Yongji wrote:
> Export group_cpus_evenly() so that some modules
> can make use of it to group CPUs evenly according
> to NUMA and CPU locality.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Thomas can I get an ack from you pls?
Anyone else?

> ---
>  lib/group_cpus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index 9c837a35fef7..aa3f6815bb12 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -426,3 +426,4 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	return masks;
>  }
>  #endif /* CONFIG_SMP */
> +EXPORT_SYMBOL_GPL(group_cpus_evenly);
> -- 
> 2.20.1

