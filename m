Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C4E605025
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJSTKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJSTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:10:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC251814A9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:10:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g28so18121138pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tigera.io; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ktkbq0iHmuOGr8YKybw9yRJ3NFz4+wIdXshxJ8vlzvI=;
        b=hlq0t5O46kYRtoorj9rCVBuGvthMsQoJWM0Ekd+3w7Pidjgzzod8b/q1klsnYEsIDl
         CVnnlT7m+Bx3X9IgGerr/YH0Uspii3p6hwQXNHKN3ZBEK4143xhBRCSGKeG0XBF3D9Xo
         hN093Khih0GclxrQeK2qHp+jamrB+4BgiNECw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ktkbq0iHmuOGr8YKybw9yRJ3NFz4+wIdXshxJ8vlzvI=;
        b=8QdEA0B1AZ3VKbOha0fssNdDK/YALsJNh7xWOHwefotN0p/tBRenQzadvaNaJAiS4P
         qyPnX954VOenr9jTpr1ZBj3ygtgaXkFQ24+d8DTeHNDpAEtI3LT9vUvTpbHp7OjDMVNO
         q62AtksmE/rPve1XHeQ6jEqZmTJVZRgUBOEGVdT+7/NHF4wj6eOWdETgl7uzfUsj4RJI
         bgQgOCf5eq3xihTTKBx5pjPLH4vn8PXYIOX6Jiqat893H8DUa1/RCr6DNa3qRQBzsEo2
         pA5GadUCmZrP1gzCHlmy5odIk6ruDpmgD6MrSvYoteIE2DqkiDlCoMttIgnEyjC2vxuD
         oosQ==
X-Gm-Message-State: ACrzQf0IfNP+gT5WNG/I0gYbfAh2hQS9fIktQUSX4d5FWhp1EJnl+B2c
        NAkuCzZk8plxYR7556rLwP5Zxy+UR5g80OZu2fb5LaD7ElSmYw==
X-Google-Smtp-Source: AMsMyM6I0TBrtrMEp/rj71K4thQ8oUEjXuY+Q4aANUx5iDZd5PFDc8dAn90ga3hlsw8F4ZzIInbLU43h7zdaF5dS0Ew=
X-Received: by 2002:a63:1608:0:b0:45a:355a:9420 with SMTP id
 w8-20020a631608000000b0045a355a9420mr8420755pgl.354.1666206640880; Wed, 19
 Oct 2022 12:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAM=1FV3ODgP1+iST6zVh4EFY9WLf=Us8PTTmbH=8KF1Xc7zmvA@mail.gmail.com>
In-Reply-To: <CAM=1FV3ODgP1+iST6zVh4EFY9WLf=Us8PTTmbH=8KF1Xc7zmvA@mail.gmail.com>
From:   Tomas Hruby <tomas@tigera.io>
Date:   Wed, 19 Oct 2022 12:10:30 -0700
Message-ID: <CAM=1FV1Nt9a5-d7LneS=-o0S2=FnDeCxLPXrB==XYJvjJ8v=+A@mail.gmail.com>
Subject: Re: kernel BUG at net/core/skbuff.c:4219
To:     eric.dumazet@gmail.com
Cc:     edumazet@google.com, herbert@gondor.apana.org.au,
        jpiotrowski@linux.microsoft.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, seh@panix.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi,
> >
> > One of our Flatcar users has been hitting the kernel BUG in the subject line
> > for the past year (https://github.com/flatcar/Flatcar/issues/378). This was
> > first reported when on 5.10.25, but has been happening across kernel updates,
> > most recently with 5.15.63. The nodes where this happens are AWS EC2 instances,
> > using ENA and calico networking in eBPF mode with VXLAN encapsulation. When
> > GRO/GSO is enabled, the host hits this bug and prints the following stacktrace:
>
>
> I suspect eBPF code lowers gso_size ?
>
> gso stack is not able to arbitrarily segment a GRO packet after gso_size
> being changed.

Based on the stack trace, it happens for a tcp packet. Since it seems
like it is on egress from a host, I suspect that it is encapsulating a
tcp packet into a vxlan tunnel and useds bpf_skb_adjust_room() here
https://github.com/projectcalico/calico/blob/master/felix/bpf-gpl/nat.h#L77-L80
Not sure if it should use BPF_F_ADJ_ROOM_FIXED_GSO in that case.

Calico uses the flag when decapsulating packets here
https://github.com/projectcalico/calico/blob/master/felix/bpf-gpl/nat.h#L143
and it uses the flag as the packet is UDP.

Any of that could cause the BUG?


Tomas
