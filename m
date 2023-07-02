Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BDB744C8D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 09:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGBHvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 03:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBHva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 03:51:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B3C10E6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 00:51:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2632336f75fso2364905a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 00:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688284265; x=1690876265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RD1AHeV1SJQ3uPTC/rrtRPO2tWOTjqWX/W+UKHi4DlY=;
        b=cqx5HqwqBin+wcFKtE1M6H13NwW+7Gfdj4tzQmrNQvb1w1iLUMrLTNPfl5jpeejVnt
         xt2BP73lE6yldnsXPjOYZ+QF7awCdYI4c1UIj+hZ7Ekt4AhXhgzfVeqeNyZXdZOLflfv
         G1Fx7tE+ZOaQ7kWynDLTLYWLolbqRSbtjmSMAWkZIiWYMP33Mg2BJIH4vn7emaXxQwIb
         M1xSZ3zzjdjPVnQBJ2C0YHdlzJCKOgH+02Fwf68pzLQJArjfeuHmaO+oc3sXKKzpku8w
         n3vmIi7/E9PgDki8ydBhlxJv7lJLVnQ+F1wjg43gsn+q1L5z7ouLzOc6Cecap4QWTx8K
         D2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688284265; x=1690876265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RD1AHeV1SJQ3uPTC/rrtRPO2tWOTjqWX/W+UKHi4DlY=;
        b=PlchoVrkEak7OQ/DS6avIYzlQTHkjXYzvU39qjMKRw59JuKko22HdX/VQywf+TeQMT
         QBxedgfuoPJcoYjnRRIXO+paxNS8R6h1vb6SlUxz9FRwAIz85O9PKM921J1wFqwxu7xG
         jQY3vr/MxWKVrYfX4Ev9XpecXMsORl9IxA3k7oIRw9zJOzzB5dr90UCWizPBGB0QTkKa
         ++ywTwBtfO/zZPIs9nJMyl2uBd14LM6zrHNxnFbgsLY1x47rKancuq+D6NIRnp4lEXhx
         5FpSite2mPgOKclyzgiyXY90Cd/4gZ03oEaDz1iTou8rHjI6lshuHsLNrF3WN6U1EknZ
         UyRA==
X-Gm-Message-State: ABy/qLbmKneqVVJvhaLgy3c7r2NlT9OhKfWB6zwWwJHKicxWwz/fuRGM
        bsHQmnUZEo8G1qevGt/YV1GwXqi8qu9rSjO95iWs
X-Google-Smtp-Source: APBJJlEhF/ip+GhDkYiwrUANCxYVx/LQKbYNlJmYerg2qXgEwMMAyjBDen3rf1/bhM27dSAtjXSd6e3tiZFTsEzQOqE=
X-Received: by 2002:a17:90b:3105:b0:262:e598:6046 with SMTP id
 gc5-20020a17090b310500b00262e5986046mr7984826pjb.28.1688284265107; Sun, 02
 Jul 2023 00:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com> <20230627113652.65283-3-maxime.coquelin@redhat.com>
In-Reply-To: <20230627113652.65283-3-maxime.coquelin@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Sun, 2 Jul 2023 15:50:54 +0800
Message-ID: <CACycT3vgtP8sjoZ2BQC=Y1Vrj1yBczaeas2z0uEGan5BAHm54Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] vduse: enable Virtio-net device type
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Marchand <david.marchand@redhat.com>,
        Cindy Lu <lulu@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>, xuanzhuo@linux.alibaba.com,
        Eugenio Perez Martin <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 7:37=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch adds Virtio-net device type to the supported
> devices types. Initialization fails if the device does
> not support VIRTIO_F_VERSION_1 feature, in order to
> guarantee the configuration space is read-only.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
