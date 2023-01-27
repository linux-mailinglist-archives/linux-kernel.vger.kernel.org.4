Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0143367E8DC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjA0PCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjA0PCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:02:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B567BE5C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674831710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cpnwFdVOm1Zj47z7bKaIB09hiU6oY7N8/Gf5N83iens=;
        b=MlkeF91FyKmT4XoLAWNwV/R8hLuN4MrEszzo4a+S2F3EEuqGQyOY9F+j2P77217sCMtXdM
        hQT7kOQZkPNWdAyH5UumwtXnmiRpqDIalrncrz/fK/FUTcewXa/cYF04PfY4zmy0sWv4rc
        /nfZ3OxjKvskVmDrNjuuV/lKVkLKhFw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-164-zpH7sl7GNpmKCvuMDOvLpg-1; Fri, 27 Jan 2023 10:01:48 -0500
X-MC-Unique: zpH7sl7GNpmKCvuMDOvLpg-1
Received: by mail-qt1-f200.google.com with SMTP id z25-20020ac84559000000b003b69eb9e75bso2227562qtn.17
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpnwFdVOm1Zj47z7bKaIB09hiU6oY7N8/Gf5N83iens=;
        b=sX5LyJOXoZdQ2XSCvTfqrXh0UgviXlcWzhgS5lZhmuk6FI/QDOUyFx0yrc/M387rdJ
         Pu+weECox4KN13aqPnRrpi7DSx03u/zttht9cPAHM/ZujI4cPb7Ql14vU9DvehsZsj45
         Adw6Vfa0fs5i5bOv1v9POp2DZtlHZeqjfFzdlz2rUh0HpKQkVAoAdd8brs7Pvf0MpOl/
         jCwy4JEwwGKzJjsqdDpchARL0g6jJCc/5X6WG+AeGnqKnuBCZFo9BaReawi5WA6bBstH
         Q+0ar+CAfAJ1MGgpQk6wdmP2VOUREqGhBxMuZsVYO20fOtX8ByTbPXyVeFIR9oWxxU8C
         Myfg==
X-Gm-Message-State: AO0yUKWtP0VummY92ESoLKEAN9Ut2MfCrHw3cCBLsEt21vJ3R4D6v5tD
        qKqz2vDjalRWX/wRR0AgAkIMAIzM9dsvD8Is3QCcEgk4XaDZr5yj04df02EYuA34w/Y2iXbkbr8
        bJnj0D9bWg7ni73eZljxdl1mv
X-Received: by 2002:a05:622a:2c3:b0:3b6:4175:5308 with SMTP id a3-20020a05622a02c300b003b641755308mr17875729qtx.54.1674831708241;
        Fri, 27 Jan 2023 07:01:48 -0800 (PST)
X-Google-Smtp-Source: AK7set/x1HX9msonBMoeJlqs+fQK4UQeP9EvDedgYKxRdacncyOCOpX4SimXF/NOROjlelwm68J6Jg==
X-Received: by 2002:a05:622a:2c3:b0:3b6:4175:5308 with SMTP id a3-20020a05622a02c300b003b641755308mr17875704qtx.54.1674831707878;
        Fri, 27 Jan 2023 07:01:47 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id s24-20020ac85ed8000000b003b2d890752dsm2740440qtx.88.2023.01.27.07.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:01:47 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, gregkh@linuxfoundation.org, mingo@redhat.com,
        peterz@infradead.org, ritesh.list@gmail.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        vincent.guittot@linaro.org, vishalc@linux.vnet.ibm.com
Subject: Re: [PATCH v2] sched/debug: Put sched/domains files under the
 verbose flag
In-Reply-To: <20230120163330.1334128-1-pauld@redhat.com>
References: <20230119150758.880189-1-pauld@redhat.com>
 <20230120163330.1334128-1-pauld@redhat.com>
Date:   Fri, 27 Jan 2023 15:01:44 +0000
Message-ID: <xhsmhedrgdns7.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/23 11:33, Phil Auld wrote:
> The debug files under sched/domains can take a long time to regenerate,
> especially when updates are done one at a time. Move these files under
> the sched verbose debug flag. Allow changes to verbose to trigger
> generation of the files. This lets a user batch the updates but still
> have the information available.  The detailed topology printk messages
> are also under verbose.
>
> Discussion that lead to this approach can be found in the link below.
>
> Simplified code to maintain use of debugfs bool routines suggested by
> Michael Ellerman <mpe@ellerman.id.au>.
>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vishal Chourasia <vishalc@linux.vnet.ibm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Link: https://lore.kernel.org/all/Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com/

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

