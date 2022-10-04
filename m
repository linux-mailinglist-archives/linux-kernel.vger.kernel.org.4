Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7E35F494C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJDSeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDSeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:34:09 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A015659FB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 11:34:08 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id mx8so2832817qvb.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SaIo47SBzdZWv7eviaRdxaNYgNxd6RGP4fIzEd8D8SQ=;
        b=YFV4aiH5nhA2s53TIm2aFzZ0tz9+c58+11edNM9pqQ8cFWbV4guJMzgFCx188E8esE
         t1tgX9GJodxQu0n9lcdjRCNY5d3x1JE38838NzQsZKmcKluNZ+Qi8IKZYUtRXVLUw0Nr
         Adq1jBliMVkLPimrwGduVqbiF5wOZnH1hQ/3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SaIo47SBzdZWv7eviaRdxaNYgNxd6RGP4fIzEd8D8SQ=;
        b=C2YJ5xTJXQKQlToaCneor3rPyT7HU33BKIQpT9VPN8NjbQlgKPqiRtNNhYFOLEtZMp
         1iTeuKVux6ssodAi/5Iie1oHCuL6lXkC6P8fZsXVB5g/xV5f5OVsEiIHcf9T2X4DKoa8
         FdvhqfhXJjNdKMxfpE5ImjxOaNB8zsu6Bcu5N/Ecn+pICAlL5HeI6VMrIW53HW95wKzz
         IsGSxuhxVTJPfIcSE/NSV2pa2TMSgEOOJB4RZiQDPPQPsscQTuVrrBh4ntebgwiTs8ej
         U/uRMOSlOYCx8PsyQ+lSC4+j8XHMgud6+T0rOUa8Ae5erfQdNpOOBPMg15+8+QD/KB96
         /xKg==
X-Gm-Message-State: ACrzQf1dkUvur6D28YNaiMZtpoCzY01yQdw60umrcRRfcp1nN6xrf+3X
        J+2mal8C9VNl5JB/wFuJSwoMmBcxW74Qew==
X-Google-Smtp-Source: AMsMyM5/NICe9IOAO1mSVrXgPb5aIJ7klNjtzf53Dg0fNqER3mu3+3LibLrI7QEbhAEUN7GSZe3LQQ==
X-Received: by 2002:a05:6214:2522:b0:4ad:6956:fc83 with SMTP id gg2-20020a056214252200b004ad6956fc83mr20819187qvb.37.1664908447545;
        Tue, 04 Oct 2022 11:34:07 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id y3-20020a05620a44c300b006ce60296f97sm493525qkp.68.2022.10.04.11.34.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 11:34:06 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id d15so8896335qka.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 11:34:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4111:b0:6cf:8490:fa7c with SMTP id
 j17-20020a05620a411100b006cf8490fa7cmr17099862qko.667.1664908446089; Tue, 04
 Oct 2022 11:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220926220134.2633692-1-khazhy@google.com> <fff022da-72f2-0fdb-e792-8d75069441cc@opensource.wdc.com>
In-Reply-To: <fff022da-72f2-0fdb-e792-8d75069441cc@opensource.wdc.com>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Tue, 4 Oct 2022 11:33:54 -0700
X-Gmail-Original-Message-ID: <CACGdZYKh4TXSaAAzJa13xsMH=tFzb4dYrPzOS3HHLLU8K-362g@mail.gmail.com>
Message-ID: <CACGdZYKh4TXSaAAzJa13xsMH=tFzb4dYrPzOS3HHLLU8K-362g@mail.gmail.com>
Subject: Re: [PATCH] block: allow specifying default iosched in config
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 3, 2022 at 11:12 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> This will allow a configuration to specify bfq or kyber for all single queue
> devices
That's the idea
> , which include SMR HDDs. Since these can only use mq-deadline (or none
> if the user like living dangerously), this default config-based solution is not
> OK in my opinion.
I don't think this is true - elevator_init_mq will call
elevator_get_by_features, not elevator_get_default for SMR hdds (and
other zoned devices), as it sets required_elevator_features.
>
> What is wrong with using a udev rule to set the default disk scheduler ? Most
> distros do that already anyway, so this config may not even be that useful in
> practice. What is the use case here ?
>
>
> --
> Damien Le Moal
> Western Digital Research
>
