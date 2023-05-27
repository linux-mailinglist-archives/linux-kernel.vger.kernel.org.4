Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6788D7130F1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 02:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbjE0Asj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 20:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjE0Ase (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 20:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBBE135
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 17:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685148463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9b3vzINIXR1anUzVhEr78wZfx7TKxIm6CwvQnMGeGU=;
        b=jDSXvIsWfFKzFQptBOU16nQa/jV7WqFbqEPTYNEjjZfzZBTZ5gz77EX/D3q+76ILtKKlYB
        +C5/JPeF5IS+OSkK1WpNeAHpzHbp6g3P1h3/gFWwRmZRYCYj/0ny1TdAlgNJhr1Kq+uk+0
        PcJpvf7N798bLHZMNfRsBQkQZZkt/EM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-Tia2ZjGJNI60Mfn3WyoCrg-1; Fri, 26 May 2023 20:47:42 -0400
X-MC-Unique: Tia2ZjGJNI60Mfn3WyoCrg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f813917b42so420831cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 17:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685148462; x=1687740462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9b3vzINIXR1anUzVhEr78wZfx7TKxIm6CwvQnMGeGU=;
        b=OZQhA2MVfpiMXgzRJPjj+RyRm5hRJIAA7+Qni1jL/HD7sLH4nWNTbpfkmvkaHxh3gH
         kibvBQ4xAgPR+YBgI2rJjdlysinIXwUYJzH/v2Yo0qsvM1bI12fDQtr1lyfmc0+IQbEE
         SK+F9zFoGvnuCaqF2LSybk9ikG7nAndJkzyQEnxFexEfz/yIwnOWr9nhdpYJyyM+iaPy
         80GhKK7Nl/WMQV3vNP5QnxqBk2qevIc9yFUD7sprlbbnEoimVrmEkePFVIVyPV65cZ1Q
         yRbMXKJNOlvb0g1ZqfxZLLFmp+WzuKI2OrUqYssCpyK+FCIpHad/XsL8hCkMc+PZEyxj
         rXBg==
X-Gm-Message-State: AC+VfDwUT2ZMC6Bv4Ew3SXxzAWW379psaMZYMQcGRvfQ6zWbetLfQJy0
        RRy3jsQ4b9+r6sOnD2uxFBqbp/VNpSbWs2FD2lH+r9zURiuB1PcEdQfQ6GGlt84pNOSa9QsPyu/
        KXV+ynInXoV63OJpD+EIF0S3ur49Dc3+bj+xGM4v2
X-Received: by 2002:a05:622a:86:b0:3f6:a490:49c0 with SMTP id o6-20020a05622a008600b003f6a49049c0mr3648216qtw.49.1685148461916;
        Fri, 26 May 2023 17:47:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HF6ptc85/qFKOadVoNN128ATBRgixZ9TzgK4szV2iFc9QcAgqllIS1WAphW/kC0r338Dd24DCMx6ic7EY3KQ=
X-Received: by 2002:a05:622a:86:b0:3f6:a490:49c0 with SMTP id
 o6-20020a05622a008600b003f6a49049c0mr3648186qtw.49.1685148461651; Fri, 26 May
 2023 17:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221013184028.129486-1-leobras@redhat.com> <20221013184028.129486-5-leobras@redhat.com>
In-Reply-To: <20221013184028.129486-5-leobras@redhat.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Fri, 26 May 2023 21:47:30 -0300
Message-ID: <CAJ6HWG62EgsivTKFUwwtSEsozY40PO8CD9P9wP7=NfYwhpBbnw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] crypto/pcrypt: Do not use isolated CPUs for callback
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Antoine Tenart <atenart@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wang Yufen <wangyufen@huawei.com>, mtosatti@redhat.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping
(for this single patch)

On Thu, Oct 13, 2022 at 3:41=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> Currently pcrypt_aead_init_tfm() will pick callback cpus (ctx->cb_cpu)
> from any online cpus. Later padata_reorder() will queue_work_on() the
> chosen cb_cpu.
>
> This is undesired if the chosen cb_cpu is listed as isolated (i.e. using
> isolcpus=3D... or nohz_full=3D... kernel parameters), since the work queu=
ed
> will interfere with the workload on the isolated cpu.
>
> Make sure isolated cpus are not used for pcrypt.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  crypto/pcrypt.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
> index 9d10b846ccf73..0162629a03957 100644
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
> @@ -175,13 +176,15 @@ static int pcrypt_aead_init_tfm(struct crypto_aead =
*tfm)
>         struct pcrypt_instance_ctx *ictx =3D aead_instance_ctx(inst);
>         struct pcrypt_aead_ctx *ctx =3D crypto_aead_ctx(tfm);
>         struct crypto_aead *cipher;
> +       const cpumask_t *hk_wq =3D housekeeping_cpumask(HK_TYPE_WQ);
>
>         cpu_index =3D (unsigned int)atomic_inc_return(&ictx->tfm_count) %
> -                   cpumask_weight(cpu_online_mask);
> +                   cpumask_weight_and(hk_wq, cpu_online_mask);
>
> -       ctx->cb_cpu =3D cpumask_first(cpu_online_mask);
> +       ctx->cb_cpu =3D cpumask_first_and(hk_wq, cpu_online_mask);
>         for (cpu =3D 0; cpu < cpu_index; cpu++)
> -               ctx->cb_cpu =3D cpumask_next(ctx->cb_cpu, cpu_online_mask=
);
> +               ctx->cb_cpu =3D cpumask_next_and(ctx->cb_cpu, hk_wq,
> +                                              cpu_online_mask);
>
>         cipher =3D crypto_spawn_aead(&ictx->spawn);
>
> --
> 2.38.0
>

