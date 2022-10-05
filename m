Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286F05F54CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJEM6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJEM6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5097823A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 05:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664974712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PcaYC0H1vCup6Kjr2sCqcoA1xxuF0buomfH/nQEEIfk=;
        b=QAmjEF3xF1lYD0PpG+5E0ijOF7OFMefJGVNIv/HQQo847PetrFSZPkV4r4ww9JoyLkgElU
        UP5G3XLsPgCQpTnzMz0H4N0Ft9KCewo1dBGc1CIIS8iKBg11mcIIIvljqp7NZOuvqv6eda
        OCNlLthEiMm57oku7K/s1ogvDskCaxM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-ZRt2-_SINnOGB0mhOLFU3A-1; Wed, 05 Oct 2022 08:58:28 -0400
X-MC-Unique: ZRt2-_SINnOGB0mhOLFU3A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D28BB3C11EA1;
        Wed,  5 Oct 2022 12:58:27 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88D694A9254;
        Wed,  5 Oct 2022 12:58:27 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 9D797416CE48; Wed,  5 Oct 2022 09:57:49 -0300 (-03)
Date:   Wed, 5 Oct 2022 09:57:49 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] crypto/pcrypt: Do not use isolated CPUs for
 callback
Message-ID: <Yz1/TVUV+KnLvodg@fuller.cnet>
References: <20221004062536.280712-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004062536.280712-1-leobras@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 03:25:37AM -0300, Leonardo Bras wrote:
> Currently pcrypt_aead_init_tfm() will pick callback cpus (ctx->cb_cpu)
> from any online cpus. Later padata_reorder() will queue_work_on() the
> chosen cb_cpu.
> 
> This is undesired if the chosen cb_cpu is listed as isolated (i.e. using
> isolcpus=... kernel parameter), since the work queued will interfere with
> the workload on the isolated cpu.
> 
> Make sure isolated cpus are not used for pcrypt.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  crypto/pcrypt.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
> index 9d10b846ccf73..9017d08c91a8d 100644
> --- a/crypto/pcrypt.c
> +++ b/crypto/pcrypt.c
> @@ -16,6 +16,7 @@
>  #include <linux/kobject.h>
>  #include <linux/cpu.h>
>  #include <crypto/pcrypt.h>
> +#include <linux/sched/isolation.h>
>  
>  static struct padata_instance *pencrypt;
>  static struct padata_instance *pdecrypt;
> @@ -175,13 +176,16 @@ static int pcrypt_aead_init_tfm(struct crypto_aead *tfm)
>  	struct pcrypt_instance_ctx *ictx = aead_instance_ctx(inst);
>  	struct pcrypt_aead_ctx *ctx = crypto_aead_ctx(tfm);
>  	struct crypto_aead *cipher;
> +	struct cpumask non_isolated;
> +
> +	cpumask_and(&non_isolated, cpu_online_mask, housekeeping_cpumask(HK_TYPE_DOMAIN));

Since certain systems do not use isolcpus=domain, so please use a flag
that is setup by nohz_full=, for example HK_FLAG_MISC:

static int __init housekeeping_nohz_full_setup(char *str)
{
        unsigned long flags;

        flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
                HK_FLAG_MISC | HK_FLAG_KTHREAD;

        return housekeeping_setup(str, flags);
}
__setup("nohz_full=", housekeeping_nohz_full_setup);

Also, shouldnt you use cpumask_t ?

Looks good otherwise.

Thanks!


>  
>  	cpu_index = (unsigned int)atomic_inc_return(&ictx->tfm_count) %
> -		    cpumask_weight(cpu_online_mask);
> +		    cpumask_weight(&non_isolated);
>  
> -	ctx->cb_cpu = cpumask_first(cpu_online_mask);
> +	ctx->cb_cpu = cpumask_first(&non_isolated);
>  	for (cpu = 0; cpu < cpu_index; cpu++)
> -		ctx->cb_cpu = cpumask_next(ctx->cb_cpu, cpu_online_mask);
> +		ctx->cb_cpu = cpumask_next(ctx->cb_cpu, &non_isolated);
>  
>  	cipher = crypto_spawn_aead(&ictx->spawn);
>  
> -- 
> 2.37.3
> 
> 

