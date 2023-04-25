Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFBC6EE20E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjDYMoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjDYMoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:44:19 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C682A5FDD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:44:18 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-316d901b2ecso68605ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682426658; x=1685018658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=te/AU6YD3Nrp06W+/L24htOInvAS1q7FQ+X/iKWkuds=;
        b=K1ZWUUchq0Erw5U3Nvwwr6Mo6pQI0pLwySLG1iZlTS2NlkiPcqJL6ZJGTahZwp2eQL
         /fH5bojhLzWVrV5CCJg0gCzeyrpiaOiezhLx5FwHPvf5uARnYifDwuR2i54acxR2k9hg
         nfpIzgS+HrrFFAdD6nCGFJQXjJp9C//n46xY6fUNcuh8TXGFbjHw+O1v9F8NGO1xdXtw
         rrqR50Cf3+cRIVwbCVQtuAKHYwlfdtvhwG7yHD8loc3QydQOS3HSokGELGvZ5RO2ijuq
         lvKUiasZ9Iei9+KGhP9vcZaopFFCpvWhg3RuFBfr12ca4l6sfB7Mq+seYpX2lm48sA+d
         eAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682426658; x=1685018658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te/AU6YD3Nrp06W+/L24htOInvAS1q7FQ+X/iKWkuds=;
        b=C4QW3UDGD/3kVcGnAqumuWzdVmFj64ZqNvJsDJUC2s7erO5Pdyxael26nYqbi4Cpmi
         rUh3B1O4/t+5I+ycQ69+MwClJ94JDOgKv0qt3jMhlp2Cs+QIDOZdSHDuh/VrMbS5G82i
         73L0CMtBs097xYrNlMRHKPX9FeQF8iaXqP7xi3z+UO/SwksddIvx+Pc7f6FrkvvLjngL
         V1XRvYcY6S4V5InuW6AyoU06dPo9aE1E4VGkTwFPigRxF/6D3kd8YkWYvFpFwvD6/SvS
         3w7fi6Nn+xeUG1j0VLjoQ9HuZGlhPK/G6uJw7Yej7bxxDiOhnCWcnFidIuH69jcE+8db
         XsmQ==
X-Gm-Message-State: AC+VfDxootG9oC9hmdvuOnF0JdhsYvcGLmEKhVQYSI8kH3PasA6OopEl
        WTJe/MPP/1KMIiPk7KYcRb6ZyTLsL3fTH7TgYsrXCQ==
X-Google-Smtp-Source: ACHHUZ74AQK+Hh0UHK0Buv7tEFBp2Kr/Sz+rPOmb/ycOMlzaR8VN8UEyIksEFlfuHPAoisNNupP/MT4jPxfZHdEgMuk=
X-Received: by 2002:a05:6e02:1aaf:b0:313:93c8:e71f with SMTP id
 l15-20020a056e021aaf00b0031393c8e71fmr174663ilv.19.1682426657965; Tue, 25 Apr
 2023 05:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230224-track_gt-v8-0-4b6517e61be6@intel.com> <20230224-track_gt-v8-3-4b6517e61be6@intel.com>
In-Reply-To: <20230224-track_gt-v8-3-4b6517e61be6@intel.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 25 Apr 2023 14:44:06 +0200
Message-ID: <CANn89iLE5fVEom+VgcOtc4DdceYDNj0ftfkd4NjjmTi1LpaDzQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] lib/ref_tracker: add printing to memory buffer
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

On Tue, Apr 25, 2023 at 12:06=E2=80=AFAM Andrzej Hajda <andrzej.hajda@intel=
.com> wrote:
>
> Similar to stack_(depot|trace)_snprint the patch
> adds helper to printing stats to memory buffer.
> It will be helpful in case of debugfs.
>
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
