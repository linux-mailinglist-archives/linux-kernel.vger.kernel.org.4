Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F646B98C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCNPQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjCNPQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:16:09 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D081ADC3A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:15:35 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54195ef155aso132371047b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678806931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mb8+E6m2WqIPXijCkvn4+H21mgnHkoR10v1IMUUcZr0=;
        b=jmpaFxz/oWEOeDL/PrbbrCqP1pXG2ojMS2+Hx9jjRcV7LZgjVSAR3DME+ReuNpL8c/
         ONH1WiSNthp2LBz4uVfdpuxk7cphOrlLVzgNiPxHstfMOyKZezfKT2MmSMKg2Cv7m3hk
         UI4pEKHsv/iPaK91kJOTI39Ha1O5K8CPWJPznidxo7QlDYsthjhzaM6gUwZjR6+6tJFd
         GgbH4zWWxHITktqx/VBklAStEqaKE7O82Bpx+5efTw4TU9aJp1RMQ5eIm4KXyUpia6Ls
         GIUY/YdcyGtYG7YDNiBZIDxYt5q/ESX+K/uM4KUgz6PU6bQL/lhrW9HZZJjqFhjlUzKi
         UrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678806931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mb8+E6m2WqIPXijCkvn4+H21mgnHkoR10v1IMUUcZr0=;
        b=mBCd5odd5r/O/dbOrxmKuMRHi1MmGNOkG6yPqDKemuTHj3SjYfnLW7HrAqn7puZKOb
         GgFBLteD2Y4ugkf8gV3wJPcJH6AmEredhU7MDth3+zN9dC+dcPuzwOJQJTyp3L5GHBhO
         Ks8j3ia9A9JHwAMQUAtLsPDV3OKjY35N2RzhKXep0O2tItdFDEKhAUUPHKSBdLnPUH/G
         +eSoTe9yqcDF2qK7fZ8tMXIPxt0h91x8eoz2Jru63m9GEeiU0yuOnI1QaY853hCXmEWV
         TcdlNXurglWDy03zHQah2ngWxh41VHqs2bdi6xCx8B6j2kRwgtbh/9wxIT1fAzZxHD1T
         jvmQ==
X-Gm-Message-State: AO0yUKUW6EEIjuqXoYehmAus/T40GuG+kmYlLebrSC6zAasLF8iFZ+bZ
        u86APj3CjootAfOF7FkVd34BNaaYfSqpbzumO4FtZQ==
X-Google-Smtp-Source: AK7set+3WyW9TClwj2X0yiptPJxGPByLfapst5/lXWp5akUIAjVHjNZRjrO90CZQ6cFryPDzDTlhYelh94yojRjBxO0=
X-Received: by 2002:a81:a946:0:b0:52b:fd10:4809 with SMTP id
 g67-20020a81a946000000b0052bfd104809mr26039079ywh.0.1678806930921; Tue, 14
 Mar 2023 08:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230314131427.85135-1-kerneljasonxing@gmail.com> <20230314131427.85135-2-kerneljasonxing@gmail.com>
In-Reply-To: <20230314131427.85135-2-kerneljasonxing@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 14 Mar 2023 08:15:19 -0700
Message-ID: <CANn89iJzVjht5L1zxwCMTPXXoXdRMtRmzbL5UzHodhBJziCxYg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/2] net-sysfs: display two backlog queue len separately
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, stephen@networkplumber.org,
        simon.horman@corigine.com, sinquersw@gmail.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 6:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Sometimes we need to know which one of backlog queue can be exactly
> long enough to cause some latency when debugging this part is needed.
> Thus, we can then separate the display of both.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> ---
> v3: drop the comment suggested by Simon
> Link: https://lore.kernel.org/lkml/20230314030532.9238-2-kerneljasonxing@=
gmail.com/
>
> v2: keep the total len of backlog queues untouched as Eric said
> Link: https://lore.kernel.org/lkml/20230311151756.83302-1-kerneljasonxing=
@gmail.com/
> ---
>  net/core/net-procfs.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
> index 1ec23bf8b05c..8056f39da8a1 100644
> --- a/net/core/net-procfs.c
> +++ b/net/core/net-procfs.c
> @@ -115,10 +115,19 @@ static int dev_seq_show(struct seq_file *seq, void =
*v)
>         return 0;
>  }
>
> +static u32 softnet_input_pkt_queue_len(struct softnet_data *sd)
> +{
> +       return skb_queue_len_lockless(&sd->input_pkt_queue);
> +}
> +
> +static u32 softnet_process_queue_len(struct softnet_data *sd)
> +{
> +       return skb_queue_len_lockless(&sd->process_queue);
> +}
> +
>  static u32 softnet_backlog_len(struct softnet_data *sd)
>  {
> -       return skb_queue_len_lockless(&sd->input_pkt_queue) +
> -              skb_queue_len_lockless(&sd->process_queue);
> +       return softnet_input_pkt_queue_len(sd) + softnet_process_queue_le=
n(sd);
>  }
>
>  static struct softnet_data *softnet_get_online(loff_t *pos)
> @@ -169,12 +178,14 @@ static int softnet_seq_show(struct seq_file *seq, v=
oid *v)
>          * mapping the data a specific CPU
>          */
>         seq_printf(seq,
> -                  "%08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08=
x %08x %08x\n",
> +                  "%08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08=
x %08x %08x "
> +                  "%08x %08x\n",
>                    sd->processed, sd->dropped, sd->time_squeeze, 0,
>                    0, 0, 0, 0, /* was fastroute */
>                    0,   /* was cpu_collision */
>                    sd->received_rps, flow_limit_count,
> -                  softnet_backlog_len(sd), (int)seq->index);
> +                  softnet_backlog_len(sd), (int)seq->index,
> +                  softnet_input_pkt_queue_len(sd), softnet_process_queue=
_len(sd));
>         return 0;


It is customary to wait ~24 hours between each version, so that
everybody gets a chance to comment,
and to avoid polluting mailing lists with too many messages/day.

(I see you are including lkml@, which seems unnecessary for this kind of pa=
tch)

Please address the feedback I gave for v2.

Thanks.
