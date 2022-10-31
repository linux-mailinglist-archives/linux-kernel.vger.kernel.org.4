Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6526138BB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiJaOIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiJaOIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE48810B51
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667225227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mq/zn5XUM8uoPhN9vYaQtRnxVLN3cHULMoBRhejHVPU=;
        b=QwcAQVO3FeGgUwNKEccU9FYiix2vF8PwrRY37I7I07EHVp5W7eGQE8AxFEWCTp/acrmKCY
        z0jnrC13bKP1qssiVOyNJaxHiybrwrG+oKCoX58Z3dSK5ybxiQORBSFROEKL5NHSk7aCk6
        8BdR1g8JQsIt3aClxDorWCS0SIiy2fA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-qhYl_DzHNNa2_ss28_Pywg-1; Mon, 31 Oct 2022 10:07:05 -0400
X-MC-Unique: qhYl_DzHNNa2_ss28_Pywg-1
Received: by mail-lf1-f71.google.com with SMTP id n19-20020a05651203f300b004b041f6cc94so1784965lfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mq/zn5XUM8uoPhN9vYaQtRnxVLN3cHULMoBRhejHVPU=;
        b=muJzXw/UC1nrJF2wpXWFin3a5I5Kvh3EtWkwk8esDwC+xS8vSI2sSrwT9VfMSyP4Jw
         twy2Ox8HXenP3dGW89Zo4dCHFUCkNMR0VFdCZ70+bTK24ybIhAdejrwMVGahz6jgl1+F
         LsXABZ3OMR08EEoAQUn5UfH1rcSZyAyc+VcRFRLx4Zd/tazvXK42AA/DaT6DwqIwb0dd
         ulMcfVcD6M9Bs0PyeOyr74uKUs9OnbgLOCz0aq7qAOs57/E528UeJjbsutx+8BAKf0xR
         sdpW2BxXSz6/cU1yA9p6rTa/5dJvotWyK6z2MtoWCYJST64mhz2x47mRztI0Wemo4PIc
         Yjsg==
X-Gm-Message-State: ACrzQf2txF1s+BOB9HiIKS5yYzdkNND5XN27iA8BWdZB7gOtYuOoYbPZ
        fU2wlfp6ani/IEV7wHXHoIQkP2H+e6HGaLu23C+88v24gSOcuLX7dxH3E2C1eq/AY9GsUub5bNT
        kBRXIrCWGkFyDeUi9aQnayZwqaNqmiohhwNT4WSNq
X-Received: by 2002:a19:a40d:0:b0:4b0:144:a246 with SMTP id q13-20020a19a40d000000b004b00144a246mr5258249lfc.416.1667225223907;
        Mon, 31 Oct 2022 07:07:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4nP4VuPVv+KnmBgDYg3Uvd6e/+CwmE7wzskgnpclP548X5qkDALuIJZA47pQQPTLocxmcIA3FxdFGgrz+fygY=
X-Received: by 2002:a19:a40d:0:b0:4b0:144:a246 with SMTP id
 q13-20020a19a40d000000b004b00144a246mr5258230lfc.416.1667225223647; Mon, 31
 Oct 2022 07:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <Y1o8hqwQKDpOTkNr@linutronix.de> <649af0f6-e5e2-c450-879c-e9153e0c0abc@arm.com>
 <Y1/NFIjRFZzszZB6@linutronix.de>
In-Reply-To: <Y1/NFIjRFZzszZB6@linutronix.de>
From:   Clark Williams <williams@redhat.com>
Date:   Mon, 31 Oct 2022 14:06:52 +0000
Message-ID: <CAMLffL_VY52DAHxVO_BE=nAjXwzvq-jmAOO4JwDT3vw3sHy15A@mail.gmail.com>
Subject: Re: [ANNOUNCE] v6.0.5-rt14
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, stable-rt@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can pick them up for v5.19-rt

On Mon, Oct 31, 2022 at 1:28 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-10-28 11:47:28 [+0200], Pierre Gondois wrote:
> > Hello Sebastian,
>
> Hi Pierre,
>
> > About the issues Valentin reported:
> >
> > - [SPLAT 1/3] arm_pmu: Sleeping spinlocks down armpmu_alloc_atomic()
> > will be fixed by:
> > https://lore.kernel.org/all/20220930111844.1522365-1-mark.rutland@arm.com/
>
> This is still pending and I don't see it in next. Could someone give me
> a ping once this is merged, please?
>
> > - [SPLAT 2/3] irqchip/gic-v3-its: Sleeping spinlocks down gic_reserve_range()
> > was fixed by:
> > https://lore.kernel.org/lkml/20211027151506.2085066-3-valentin.schneider@arm.com/
>
> That is
>    d23bc2bc1d634 ("irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve")
>    v5.17-rc1
>
> > - [SPLAT 3/3] gpio: dwapb: Sleeping spinlocks down IRQ mapping
> > was fixed by:
> > https://lore.kernel.org/all/20220419012810.88417-1-schspa@gmail.com/
>   3c938cc5cebcb ("gpio: use raw spinlock for gpio chip shadowed data")
>   v5.19-rc1
>
> Is someone picking the two up or RT-stable?
>
> > Regards,
> > Pierre
>
> Sebastian
>

