Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751545E7EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiIWPon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiIWPoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:44:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DD5915D3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663947840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pzjUC4bstx9pJg5y7iDAvAE0+LZcPdS9/Pej8B218l8=;
        b=DxzuWlxQRvvd18hYxTHjHQIkCEfCW7ep3ymoSO/9GpBrofudRGewCvejHspnNo22dVtfvK
        Soi2MJ2t0ZzJqzDFAS2s2zd4dJScKANSqZIUXVAdoQ3PPJrwNRK9o1jxQKIq6QPJXSp9FY
        5jtZmdid7umxPGrWcFrRgpFgP2BzF/M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-22-2Of1KURkNHiNCktJ9FGN-g-1; Fri, 23 Sep 2022 11:43:59 -0400
X-MC-Unique: 2Of1KURkNHiNCktJ9FGN-g-1
Received: by mail-wm1-f72.google.com with SMTP id p9-20020a05600c23c900b003b48dc0cef1so152835wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=pzjUC4bstx9pJg5y7iDAvAE0+LZcPdS9/Pej8B218l8=;
        b=peR0NV4s+ee4K5dZ9vioozQqHlK1VwZebNcHmvoAGawEKAUVpaAjT4ch8kca/IEPL4
         H3oL1hsKSoBo8sbxFDc4H+j+o0K951B8ArBr4j4uIwBK16gArIi5+yAGjf83/KmIb42x
         RHa3X1po9AsellsxSidjJXSRwS/5VR4U0eMd3JPAeaen3dV6lcI9HEEjconiXpRVpOSC
         XzzMRE43CcR1uxut6jnnIJ2EZ4uJzGCLa4FQbxLwOgD3EEp4nCnsDv/3HawTSWrKD/l5
         XgDx4WWMQJV45Z1M4jkjPME7Ypyyw9pZz/l+5aQummsBVDRTvYy0bQMe2fdBRbuts+5s
         UEjA==
X-Gm-Message-State: ACrzQf2Qlte5/2xEwGYIJ1hrfEmaWvi+9z1SCm+rh8XfuCPWYFC4GgkO
        gPhNjLdLupV8QhqD/+bpn8jkxX19ke+64Y3F/0r65LW4Lr+iBlJLTWHsubrOuVFF+x4KqVCzFk+
        5+UieXWhFaw1Gc6s0CaLjDp/wGD8UC5Kii681XHUcdpn7oSdpH1aylIn2DBiWDR1powD46CGcsn
        EX
X-Received: by 2002:a05:6000:547:b0:218:5f6a:f5db with SMTP id b7-20020a056000054700b002185f6af5dbmr5656456wrf.480.1663947837433;
        Fri, 23 Sep 2022 08:43:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5krGcq+hx/u1IFVk3CVz6ha6bsdhFqUmcyDjHTV+YD+ZFbRbnGdvXrJ7B2NhW8wXZNhPKBHg==
X-Received: by 2002:a05:6000:547:b0:218:5f6a:f5db with SMTP id b7-20020a056000054700b002185f6af5dbmr5656433wrf.480.1663947837112;
        Fri, 23 Sep 2022 08:43:57 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id z18-20020adff752000000b0022860e8ae7csm7756424wrp.77.2022.09.23.08.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 08:43:56 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Hui Su <suhui_kernel@163.com>, mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: remove struct sg_lb_stats declaration
In-Reply-To: <Ywh88U1J9pSGOOMK@localhost.localdomain>
References: <Ywh88U1J9pSGOOMK@localhost.localdomain>
Date:   Fri, 23 Sep 2022 16:43:55 +0100
Message-ID: <xhsmhwn9u14g4.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/22 15:57, Hui Su wrote:
> remove unnecessary struct sg_lb_stats declaration
>
> Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
> Signed-off-by: Hui Su <suhui_kernel@163.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> ---
>  kernel/sched/fair.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 914096c5b1ae..54bacf635362 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9050,9 +9050,6 @@ static inline enum fbq_type fbq_classify_rq(struct rq *rq)
>  }
>  #endif /* CONFIG_NUMA_BALANCING */
>
> -
> -struct sg_lb_stats;
> -
>  /*
>   * task_running_on_cpu - return 1 if @p is running on @cpu.
>   */
> --
> 2.34.1

