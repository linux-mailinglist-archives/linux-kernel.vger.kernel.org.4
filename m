Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0687D6BBA29
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjCOQtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCOQtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E934E3C3B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678898898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nm5gfruTLsdagm9njmR29/Ig/a6aY+NuRLyWyFUeNqo=;
        b=FQSiS9fdfUyaG1punQWH9LZA1+RfMd2cNJ5xsSQWz4yr1SqzdJzwjeJk3CzHqpGOPcdHcb
        wXMlog5vwafcEpMz7RW41+nwhiKjjVKfatODIxalzyuwzenfWPnBDqwTPfDFx3fjJRGH08
        CqeYrwW6HcbE4mC3s9oQHaZZUtH5X3E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-OrOHAQrROeedLzyEuGOZ-w-1; Wed, 15 Mar 2023 12:48:17 -0400
X-MC-Unique: OrOHAQrROeedLzyEuGOZ-w-1
Received: by mail-wr1-f72.google.com with SMTP id bn9-20020a056000060900b002cfe8493fe6so1170273wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678898896;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nm5gfruTLsdagm9njmR29/Ig/a6aY+NuRLyWyFUeNqo=;
        b=sqLDhFVtcfqfrZeAicE/FwaQNnCJXubbkudcYjzY4Apxn6e6rocjaUavJ0UQvxrKMW
         wKP5vhdVZ7hfqwY+gCod8rndHiagxX3Un3GlspvTLnyUBrRbosJhITyFu4acKujAipty
         KT+DwA348Kz54ENvbGgrHW5IpRS2Ma72J+A+4EmOx6fDVSg4nL+0PjuRsh+AYvqOwSdM
         mKXn2/wJK1bL4enjBuATEvkZSvH3w4XqwJi66kJ4KkjvooALLshGhJGBB6+kj9cQIcvV
         RIamdSomi7GAdmqKTLAqB0Hg5EV79TuoC/H+u3K/f5siP+Sbbem3y8rmWQLqdpyiLcZt
         0bAQ==
X-Gm-Message-State: AO0yUKXPZGtzRM/1464qRDXV1PYYdy2QsY5T2Js9grQfdbmqt0bsH7CY
        YNHSyYVFxCBT9VRZpndSnuoUOQXfQSDTA0THBCJctv6EgYnJBHWPGja6VRfrL+UGMwxgjYdQhPr
        9Jk4DKPXyr1KjMTg9qMetnA7T
X-Received: by 2002:adf:f209:0:b0:2d0:27dd:9c40 with SMTP id p9-20020adff209000000b002d027dd9c40mr2037092wro.26.1678898895832;
        Wed, 15 Mar 2023 09:48:15 -0700 (PDT)
X-Google-Smtp-Source: AK7set9jfn/9WqJrQVlsKAuBzHsI/W7q2SC2Q1SzV+VIJZiJybGCBhMLfTelmL18XXOCJLm0rYHCmQ==
X-Received: by 2002:adf:f209:0:b0:2d0:27dd:9c40 with SMTP id p9-20020adff209000000b002d027dd9c40mr2037086wro.26.1678898895600;
        Wed, 15 Mar 2023 09:48:15 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id h13-20020a056000000d00b002cfec8b7f89sm4560610wrx.77.2023.03.15.09.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:48:15 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jeremy Kerr <jk@ozlabs.org>, Jakub Kicinski <kuba@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Barry Song <baohua@kernel.org>
Subject: Re: [PATCH 1/2] sched/topology: introduce node_has_cpus() macro
In-Reply-To: <20230222025029.453834-1-yury.norov@gmail.com>
References: <20230222025029.453834-1-yury.norov@gmail.com>
Date:   Wed, 15 Mar 2023 16:48:12 +0000
Message-ID: <xhsmhbkkum04z.mognet@vschneid.remote.csb>
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

On 21/02/23 18:50, Yury Norov wrote:
> Currently, to check if NUMA node has CPUs, one has to use the
> nr_cpus_node() macro, which ends up with cpumask_weight. We can do it
> better with cpumask_empty(), because the latter can potentially return
> earlier - as soon as 1st set bit found.
>
> This patch adds a node_has_cpus() macro to implement that.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

