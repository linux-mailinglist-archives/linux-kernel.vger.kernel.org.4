Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9C76C24E1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCTWsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCTWsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:48:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B9235EF6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:48:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a19cf1b8ddso3325ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679352519;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7OpRJ3NaHifOdXnXMOAjL7A3rwwZXBDeBcL7dk4Zj7U=;
        b=AYUI9qTKz/8bfjZBpZaxodLM9aq535dUaaz2yXD9Sl0Y6RcMZptCZRM/BPtAGXInqg
         jRjFc52pUQY2lMr7qfe1uQrL5xaxxkQSVpS1OHJ2+pEG9IQXybD/3qBmv16OSC3/epDF
         Xk7Z9Kk2wtRnUT3VoOg8KuUlucKELPRv8jpFQfedooD+5KBx7yoyzEEthSfM5/BBM3wk
         wixnnlSPmkGfnXIl0Fr7x9qBGUofnB+GPKWjtXnQqzPgzNE5KVdyEfcQjMI4ZeKIkYrO
         neLcVoHzdNWF7+6jN3BBjG2L0TWEnKXTn/cNu+3e8PW8yEYBPFq+gxbdyCV42CZP1SYn
         /3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679352519;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OpRJ3NaHifOdXnXMOAjL7A3rwwZXBDeBcL7dk4Zj7U=;
        b=EtKodt1QJte6Q0+YsuIlh5hExLgiNj2dv8oWQ5ncSsJ+HW+UiJedUtete2w76nJjXK
         bLlSWbhJ+L4HFxFF1Sat3NwLeoaYrgLiydvqB8GKzkr6WMewNle4rJSy3DuFEl8e+cAE
         QjAxduA+ylOaRa1bxgfahcZkH+24hqx0xLG/ufPDRyI799PpIJtQ58J/p588PKHWW+kv
         nSL9MvrxFfvNIq1K61owRlqItHPNRWGZU4OVg2yE0KaqkJWuDrQtxFTRvXjR4mboTn/3
         WsagQhPNEULbQjSwgnEfzCvr/jpM0k8R+IZdi/t+2hzo2QnzwyXSVB0XcmoI6biDbS8F
         3ZKA==
X-Gm-Message-State: AO0yUKURowrDvhoLr1QPL/lMKQmkCQwtF7JjE8DlidOoZxQemlKquOfD
        PPPSVX/ak0e1Gte8l1wZDrwFtjXbEhZIhlPye8nKJg==
X-Google-Smtp-Source: AK7set/dSoy8sg1l9KlZyobKlqFU1sPfjBmkRl+PE2Qm9gfFmX1SOHoBDUXVGnxw7y3t4r6CiZMsow==
X-Received: by 2002:a17:902:e74f:b0:198:af4f:de07 with SMTP id p15-20020a170902e74f00b00198af4fde07mr34213plf.7.1679352519390;
        Mon, 20 Mar 2023 15:48:39 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090a0a0900b0023cfdbb6496sm10275879pjo.1.2023.03.20.15.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 15:48:38 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: core: Optimize the structure of
 'tg_cfs_schedulable_down' function
References: <20230319200255.3640-1-kunyu@nfschina.com>
Date:   Mon, 20 Mar 2023 15:48:36 -0700
In-Reply-To: <20230319200255.3640-1-kunyu@nfschina.com> (Li kunyu's message of
        "Mon, 20 Mar 2023 04:02:55 +0800")
Message-ID: <xm26o7onvy2j.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li kunyu <kunyu@nfschina.com> writes:

> Optimize if branches and define  in the branch statement
> block=E3=80=80parent_quota variable.

It's not an optimization; it is arguably a slight style improvement.

>
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  kernel/sched/core.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 488655f2319f..7e8535d2e36d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10915,15 +10915,12 @@ static int tg_cfs_schedulable_down(struct task_=
group *tg, void *data)
>  {
>  	struct cfs_schedulable_data *d =3D data;
>  	struct cfs_bandwidth *cfs_b =3D &tg->cfs_bandwidth;
> -	s64 quota =3D 0, parent_quota =3D -1;
> +	s64 quota =3D RUNTIME_INF;
>=20=20
> -	if (!tg->parent) {
> -		quota =3D RUNTIME_INF;
> -	} else {
> +	if (tg->parent) {
>  		struct cfs_bandwidth *parent_b =3D &tg->parent->cfs_bandwidth;
> -
> +		s64 parent_quota =3D parent_b->hierarchical_quota;
>  		quota =3D normalize_cfs_quota(tg, d);
> -		parent_quota =3D parent_b->hierarchical_quota;
>=20=20
>  		/*
>  		 * Ensure max(child_quota) <=3D parent_quota.  On cgroup2,
