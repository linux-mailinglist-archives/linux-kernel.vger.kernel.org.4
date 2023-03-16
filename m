Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE35E6BCAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjCPJcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjCPJcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:32:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA6E49897
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678959081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CS1wqtcOK2buYZ6heyq67kcFUemEQNu97cyhCyrzUp4=;
        b=WatcLJSLPp5iRIQ5LCzAS+zyC0q2dltXlsT5isRxb6Se16oq9edshyR8YzITqj24O9zOZb
        ryd0EyvGGyj1CVUFzpMDaOLDZSF7QBfWTx1Wcw1eFzAa8EqjWcR8oB7djHI018rcFSAk0x
        7TgsR/EmNWFTu8efMiroBbknNW5DWhQ=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-w5mlkGBrMwCuzx_mWw2nyA-1; Thu, 16 Mar 2023 05:31:20 -0400
X-MC-Unique: w5mlkGBrMwCuzx_mWw2nyA-1
Received: by mail-ot1-f70.google.com with SMTP id e12-20020a9d63cc000000b006944a810ab3so523638otl.20
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678959079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CS1wqtcOK2buYZ6heyq67kcFUemEQNu97cyhCyrzUp4=;
        b=oYsnC8EV0t3LkBo0iU6MP7HdGLtEyALYmC7r17tU5zDLYk4Jh+tQbdVelZsM/aQoJ8
         /xUqvFwUwJAmrzNhVLvDjHbakc/FRUrbuA0YPOYO9JXS8I4kIjJ8OWdjJNZUPiNYTKyw
         29mb5/Da9cVft1H8FLrVFkLNSmTgmief+Tf44JQMdjxZr9x7DveVjLc7GSY2xZ0iNi3j
         wWdsXqbrh1dQKCPCDi1uv53bYPeGsyNYjvyePnMyiYWbjttrY+aFcESWz+ZtT4yT8hp8
         MpxL/Xv/y6+huf5yQxcMYuOxEZJjhgDpvaGgXiNrLVw/NnqYC+StyKdOanIkloeisTTh
         uzVQ==
X-Gm-Message-State: AO0yUKUY7XiU8V29OXyo687cGuvx040q3bIXtDoWMpDQGzCPVlK4jGB1
        AwakYExD1PYaWHTZYKZQbh8qsy/hsqeVLnJQQOKWeLdtF/VSaHbr5iekD1ZxZ3aXDCY0NVgcZ07
        j131+/Vm40fU9CWrFxvLr9Yd2lcmYcb5wyJLEIbqUCbIIRteWIVU=
X-Received: by 2002:a05:6808:4285:b0:383:fad3:d19 with SMTP id dq5-20020a056808428500b00383fad30d19mr1815813oib.9.1678959079004;
        Thu, 16 Mar 2023 02:31:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set9pBzOokvEbcx6aOLA28L4vBQN4JkIIhkDIzzehrOEGVuar/34lDJFkgZD2rtlQCkDjH1qP1S+BEyo4gJ/aWZA=
X-Received: by 2002:a05:6808:4285:b0:383:fad3:d19 with SMTP id
 dq5-20020a056808428500b00383fad30d19mr1815808oib.9.1678959078836; Thu, 16 Mar
 2023 02:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com> <20230228094110.37-2-xieyongji@bytedance.com>
In-Reply-To: <20230228094110.37-2-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 16 Mar 2023 17:31:07 +0800
Message-ID: <CACGkMEsak_C1TTdq4PRXx46HHw42hjvcbZM+B_mGS-kJ6AA4eA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] lib/group_cpus: Export group_cpus_evenly()
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, tglx@linutronix.de, hch@lst.de,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 5:42=E2=80=AFPM Xie Yongji <xieyongji@bytedance.com=
> wrote:
>
> Export group_cpus_evenly() so that some modules
> can make use of it to group CPUs evenly according
> to NUMA and CPU locality.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  lib/group_cpus.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index 9c837a35fef7..aa3f6815bb12 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -426,3 +426,4 @@ struct cpumask *group_cpus_evenly(unsigned int numgrp=
s)
>         return masks;
>  }
>  #endif /* CONFIG_SMP */
> +EXPORT_SYMBOL_GPL(group_cpus_evenly);
> --
> 2.20.1
>

