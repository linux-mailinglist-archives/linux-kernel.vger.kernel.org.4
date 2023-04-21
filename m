Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603386EACCA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjDUOZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjDUOY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:24:59 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7671705
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:24:58 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-329577952c5so693945ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682087098; x=1684679098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fev/HjWH2B8yyfQiDGZ9D/O2oZYyJ9gGuApag0ZRVwc=;
        b=TVGpX8Rsft5hzMr9h6Hwyheu0HJYGuHxxs7ojc6Kil4QcUiO/DlWT0in/uLxRo6Cjj
         k1VQcRlDqVO4SIIb5IVwDa4JdfL4zYLvXGhLV/kB+NM5PH/u+XjBKfnkjEQ9QVQmK60w
         Vc8FzK6DfY5mi2TbK4uHxCC49bYsU4nxKZJdASBm+oks7LbQ+RxB90HBUI6mYlegxr7U
         1XR6A+LHNGRyTDAhBVssIxGbpCl6otjWPglcnEPEXNFs1XXpb+XtVA4I/tlXGMqxR+pq
         8D4T4nbhmC3rl/qw+IT0JwOuDIGlL0G4YOWFtTiFq80UoDYKM6UOS6EJnHjngA/3Jjn6
         mLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682087098; x=1684679098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fev/HjWH2B8yyfQiDGZ9D/O2oZYyJ9gGuApag0ZRVwc=;
        b=XpP08QL+bEjaYoG42dyaog7OfGLsqCRt/gf8Fff58+AfeRgweuq/Tb6VGGsvzqfZxt
         6dt7qkrYPoI66bn+5ysQ/G8jKMjIJc+fcW7UppwNCyaxBhtnGDVLldbOqzg6P01CS6ZB
         Ii1BFcWXPceXzHTCVBwh0wjHvDDiep2eWQlSsnzjHrJfLBp4LRN4bqw+Aad4+818oRQb
         Jta4NqjTlZBLYHoyEuw0w2E+65/vxip4LpH17IVNFhcS73RL/fwNFl0FPj/VPNpm54ix
         F/uZAy/gO2VHCo251jJo+ceslUvhgAUTPUQGldZtpNRp/pK6l3wbI+TA9qApmEApZZC1
         HLzw==
X-Gm-Message-State: AAQBX9dXLE42kNFRxhKh5emGZdU07SUdTXBCGy2f5b/vz4csSLdokP+j
        wTmeiS6p/DNhAEmtzIYgoZ7knfTP7lPX/+JDFtEAiA==
X-Google-Smtp-Source: AKy350Z0juoPECKlzKlGMdUfKVumXOK21XHMESzNTTUc7EvrFvimwX3M8kvTGyloRw/nYChUw0o5sGJI99iK2oqYk/g=
X-Received: by 2002:a05:6e02:1a22:b0:32a:b8fd:19be with SMTP id
 g2-20020a056e021a2200b0032ab8fd19bemr279553ile.18.1682087097600; Fri, 21 Apr
 2023 07:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230224-track_gt-v7-0-11f08358c1ec@intel.com> <20230224-track_gt-v7-1-11f08358c1ec@intel.com>
In-Reply-To: <20230224-track_gt-v7-1-11f08358c1ec@intel.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 21 Apr 2023 16:24:43 +0200
Message-ID: <CANn89iL65YYs_+cJs6STTH=7n22VLi-eru2FzFh1rtrxp_a7Aw@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] lib/ref_tracker: add unlocked leak print helper
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andi Shyti <andi.shyti@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 1:35=E2=80=AFPM Andrzej Hajda <andrzej.hajda@intel.=
com> wrote:
>
> To have reliable detection of leaks, caller must be able to check under t=
he same
> lock both: tracked counter and the leaks. dir.lock is natural candidate f=
or such
> lock and unlocked print helper can be called with this lock taken.
> As a bonus we can reuse this helper in ref_tracker_dir_exit.
>
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> ---

SGTM, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>
