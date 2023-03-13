Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A9B6B779F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCMMfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCMMe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:34:58 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ECB584BA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:34:47 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e194so11633229ybf.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678710887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsHVLwfcxVAYySt9LSyHUL3FcFzpHzX+V7FtukH7vRo=;
        b=BGIEPb7mIl6tVYtg3mr1ncRxAzzbqOfM7H4uuLFeRNXzTWzrWs6Gtz2Oetn9JALfzH
         LXa+gu93ekJ6Pf51iMCHELNNLcxYJmelUXh7SJISqumFbqgTDOkLptDgXepF0/IWCpbc
         pew09vdfJ/+kaZlbk7QMQncaiG5KlIGIVIaVM4807KiVkvMwtDvDnkbbiFUYkpjzubGO
         6mVPdOTS2F/Q6KbFUrlsYW/xVWwa/a7kN4ttj7ltSZ2bPQ69h7trce42B6r6OYm+56Md
         dt7Jubvj6OMrtIpn3s2rvckDnjpgdwIhRZSM7q31CtuVpa1+eS2Td++jByvPQ6mtbXAV
         gpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678710887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsHVLwfcxVAYySt9LSyHUL3FcFzpHzX+V7FtukH7vRo=;
        b=b/PFHdYpbT7pOZDvSH/x+LXfEWYd6J7annSECGupDmdmNEgn4dN++CuEj0QU9l5uGi
         uFC2ux+cYUya6wEjJZssxM/H9JVL84iFCqrneF0M6xRMLBLxp8QrpnKuGnhO74AwNEqG
         SkCCbDVMkuQSfXXRcsCSCg9XE0z/MXIp94PK/jIXgneBw1xl+pOFmEEZr7fSRUk80/zW
         7+ShQJDltZZQd1OWVxvQZUfhUI2rAN53wvjq4ISpgRdlv9ufbOBdwJTs8oWaP8JrEhIr
         SOEO1+peQD+SZcXqyJnWHoadoKOb9YmR99Rxlk3TB8uThDsXgt6HN1BC18eLNgrHG5oD
         GDvw==
X-Gm-Message-State: AO0yUKXe8SHsYtPQkMLyzBgN0/GJ1LvZNF6la3nMV4NRMe+vw6iyJlKT
        FrfQX9GbdHP/AvH2YVs1tFXxssXzssTzgWvMMYZTZA==
X-Google-Smtp-Source: AK7set82rpjxTuF9kCeDnmiGukE3YYZXrIdCpcqWKnHZrvThh4hI99qgocyXflmmscBnqfrZ3Iw45toaZGVUzBcifj4=
X-Received: by 2002:a25:d512:0:b0:b1d:5061:98e3 with SMTP id
 r18-20020a25d512000000b00b1d506198e3mr11990649ybe.6.1678710886550; Mon, 13
 Mar 2023 05:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230311151756.83302-1-kerneljasonxing@gmail.com>
In-Reply-To: <20230311151756.83302-1-kerneljasonxing@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 13 Mar 2023 05:34:35 -0700
Message-ID: <CANn89iKWewG7JZXQ=bmab9rSXUs_P5fX-BQ792QjYuH151DV-g@mail.gmail.com>
Subject: Re: [PATCH net-next] net-sysfs: display two backlog queue len separately
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 7:18=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Sometimes we need to know which one of backlog queue can be exactly
> long enough to cause some latency when debugging this part is needed.
> Thus, we can then separate the display of both.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/core/net-procfs.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
> index 1ec23bf8b05c..97a304e1957a 100644
> --- a/net/core/net-procfs.c
> +++ b/net/core/net-procfs.c
> @@ -115,10 +115,14 @@ static int dev_seq_show(struct seq_file *seq, void =
*v)
>         return 0;
>  }
>
> -static u32 softnet_backlog_len(struct softnet_data *sd)
> +static u32 softnet_input_pkt_queue_len(struct softnet_data *sd)
>  {
> -       return skb_queue_len_lockless(&sd->input_pkt_queue) +
> -              skb_queue_len_lockless(&sd->process_queue);
> +       return skb_queue_len_lockless(&sd->input_pkt_queue);
> +}
> +
> +static u32 softnet_process_queue_len(struct softnet_data *sd)
> +{
> +       return skb_queue_len_lockless(&sd->process_queue);
>  }
>
>  static struct softnet_data *softnet_get_online(loff_t *pos)
> @@ -169,12 +173,15 @@ static int softnet_seq_show(struct seq_file *seq, v=
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
> +                  0,   /* was len of two backlog queues */

You can not pretend the sum is zero, some user space tools out there
would be fooled.

> +                  (int)seq->index,
> +                  softnet_input_pkt_queue_len(sd), softnet_process_queue=
_len(sd));
>         return 0;
>  }
>
> --
> 2.37.3
>

In general I would prefer we no longer change this file.

Perhaps add a tracepoint instead ?
