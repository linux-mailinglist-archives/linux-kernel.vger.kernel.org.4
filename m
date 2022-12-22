Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A537F653C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbiLVGoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLVGow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:44:52 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CD52189C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 22:44:51 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 7so745848pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 22:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=086dsIWiKVuDdE5qHTcupmnKCG4y2yzrnr4Huev2NRw=;
        b=UtaOxFFLchWt5Jb/3Qqzm81/vYaqvIO89JpWehCUn/CUHFGzoM5mnpGGBFlYqQAoGd
         HNaC4hz9Wsd4cdrkLx4Nc3B37RZeAXNTTbWL+/LYmA84syobG+0riP0NUwuuMOLk0vM9
         31gmckA5xEiwm+8UXywQe5qkGm3622bwgeIVe534hNeHlbnrHCysSoCqhjwrJwPlkRNH
         xmSbqkhkZGSyFCxhD8DJcIVlOqa5aOvOkcRUxPZKzzjMp46TLQ3zogc3AjHVRg2Hd/hE
         u7zVrjzMsbBqYzgul0riADWu8PTfE+0rGq7xHVnf0NatXFT2v3uTvvZPalPduYNE26Vg
         GhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=086dsIWiKVuDdE5qHTcupmnKCG4y2yzrnr4Huev2NRw=;
        b=c7ptD69GR4XzK1Htj8HngE9WA9JUaAFslTZpOQNC4Sup+chbNJ/th+U5PzKJlzdK/w
         lm47AlwNJlf9XkPQ9eGI3YU6twYKGNoFFsefDVGSXI9Um4S39exU+j5ovqom5Q6iEwTC
         gStXm9YA2bls8qKLpUdARZdic22IQTiXUx+DBOrebdE6iSrXY4DK6nY7HKUmH2j/rRtC
         du/x8JTVGVy0ZPqQAgUkDTbh3dMGhxEuFO0PAemrC4kSEwJQoPRykifmvPqlg5wMzebP
         MOc3KYqN9AvPmQfpEZ7Fy8x7snUnfPQkKBxuXgpQF/qw2buu4dY++OOMcmsgpIl1Gshp
         pPcA==
X-Gm-Message-State: AFqh2kqkurQzAq1qpCP7FIvMqm7jbid7BiN+ZjowLenp9FPTqnuTJYZ0
        VdW1CecWnonGvPjOPe9W/8nwGQ9QPg5EeUAHqTfBIQ==
X-Google-Smtp-Source: AMrXdXt0UcjoP66yyusLKIKTSX4FRsTvLnD0LVdmB5/Zjm2T6SMC5OAPDw1o6lqRfglsrE+itHgRlexlQR8eCOjBmiM=
X-Received: by 2002:a65:45c8:0:b0:48c:5903:2f5b with SMTP id
 m8-20020a6545c8000000b0048c59032f5bmr224962pgr.504.1671691490591; Wed, 21 Dec
 2022 22:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20221222060427.21626-1-jasowang@redhat.com> <20221222060427.21626-5-jasowang@redhat.com>
In-Reply-To: <20221222060427.21626-5-jasowang@redhat.com>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Thu, 22 Dec 2022 08:44:12 +0200
Message-ID: <CAJs=3_D6sug80Bb9tnAw5T0_NaL_b=u8ZMcwZtd-dy+AH_yqzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq command
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Adding timeout to the cvq is a great idea IMO.

> -       /* Spin for a response, the kick causes an ioport write, trapping
> -        * into the hypervisor, so the request should be handled immediately.
> -        */
> -       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -              !virtqueue_is_broken(vi->cvq))
> -               cpu_relax();
> +       virtqueue_wait_for_used(vi->cvq, &tmp);

Do you think that we should continue like nothing happened in case of a timeout?
Shouldn't we reset the device?
What happens if a device completes the control command after timeout?

Thanks

Alvaro
