Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B54730178
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245508AbjFNOQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245532AbjFNOQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA5110CB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686752118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gs9UsFHiOqFVLHIkbMkZs+XlwUJlhoeynhzk+GnTL8Q=;
        b=fBhNcUQ51rw06ne3TQ2VLDajj/mjFzlfFNJRPJUmDaISzu9cQlGvIbqN45bYLY8sZhdY/Q
        3sH1wI8uS0Mf7bOpHQ7w9JoAbqmeq3R30IAgtwLTvFvQeoCe/Fx6c1UxtKYOkhfefeqmus
        /tIoaDUfcKOXmx1OxoTHgCRIqyMzcRg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-Wav4OnFRP12MaEttHWo0eg-1; Wed, 14 Jun 2023 10:15:17 -0400
X-MC-Unique: Wav4OnFRP12MaEttHWo0eg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30fb1f3c30aso1813802f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686752115; x=1689344115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gs9UsFHiOqFVLHIkbMkZs+XlwUJlhoeynhzk+GnTL8Q=;
        b=DVVb0RE7MpibuoNgTKsZbXa0y0UIFlNJgOSDXRIYFZJsPaMowdoNOoHosVXUTxDKpe
         qbcy5pD2LcHM//+5/4hwLqGMDqr0nlLW+5IrEUiQuJJJFA3pIj2pfFp6fYN8H6du776N
         SKaZh/n8/G9ziyseYvhNa0PZksTWpuOvlM1s+jgCuLU3+ZQLvWDA6dGTogIGutze35Yy
         r3zjXQF7oXmdZCTQJd1QggJQCkFTCZum53JzKlESTVlyM6zqbaE7WA8I2Q+RUJP9LOxa
         mP4oIuGA9CsLGNFCH+DraqbkRjPutR1fPb6u/YTorjSUVrChHoq7G0ky2zmweGCnW1aa
         m+bg==
X-Gm-Message-State: AC+VfDx46yNUGvFLBQ0ocQiyCMyE64P86xatfwCcwyUxSUlytZLfDivU
        fpUOnClbWPxeoi/T6f4sdeWRsu2ixZX07m2TuC1DNkN31/ZLbbMPDlfmN653zfy5jWsioqj/A7X
        3Sgf7YnvjjPi03NeNBvMC0sE5
X-Received: by 2002:a05:6000:100a:b0:30a:a478:f559 with SMTP id a10-20020a056000100a00b0030aa478f559mr9364248wrx.2.1686752115778;
        Wed, 14 Jun 2023 07:15:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Ughal3Ksk9mWSBNbC9/117BFdtAMq/ce7h59A0MFXhuh3csYI3NW44NB41eA0ulZ91dSNCw==
X-Received: by 2002:a05:6000:100a:b0:30a:a478:f559 with SMTP id a10-20020a056000100a00b0030aa478f559mr9364231wrx.2.1686752115421;
        Wed, 14 Jun 2023 07:15:15 -0700 (PDT)
Received: from localhost.localdomain ([151.29.46.22])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bca47000000b003f80b96097esm15014202wml.31.2023.06.14.07.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:15:14 -0700 (PDT)
Date:   Wed, 14 Jun 2023 16:15:12 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
Message-ID: <ZInLcNqGpLCw8xsn@localhost.localdomain>
References: <cover.1686239016.git.bristot@kernel.org>
 <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
 <CAEXW_YT0DmvQo_gfCq5uzpZpf36HmfzXozo9+=sYJp-hZx4qTQ@mail.gmail.com>
 <b2cd0072-d226-4adb-ddf5-958d9635f881@kernel.org>
 <CAEXW_YR9Tfw5KyFU7TQtYE02k+DpaMXH=osx9Ws5w_j1YpHxhg@mail.gmail.com>
 <841849b5-1f9c-4f0e-2de8-1da278256888@kernel.org>
 <CAEXW_YQ7vEakRcJgva_PYEnsj4ZLafH-pXQiJ5STCkM7dQAttg@mail.gmail.com>
 <4849295d-9aef-836f-0e5f-063e2075380a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4849295d-9aef-836f-0e5f-063e2075380a@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

So Daniel provided the gory details :) .. but please let me highlight
one of his points below, which I think it might clarify why we might
want to start with a special case, patch 6 improved approach, before
possibly moving to more complex implementations.

On 14/06/23 15:45, Daniel Bristot de Oliveira wrote:

...

> By postponing the enqueue/replanishment of the DL server here, we are fixing the
> problem in a practical way, that works without breaking existing useful properties &
> use-cases.

In my understanding, if we simply postpone actual activation of the DL
server up to the point it really needs to boost/run for giving CFS tasks
some breath (the infamous 0-laxity :), we save RT tasks from useless
interruptions and still can keep EDF/CBS working w/o much changes.

It looks like a low hanging fruit, small improvement on what we have today
than doesn't prevent us for implementing more complex features (i.e., full
blown hierarchical scheduling, alternative schedulers) in the future if
the need arises.

Thanks!
Juri

