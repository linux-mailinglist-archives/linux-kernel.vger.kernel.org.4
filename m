Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3DC6C943B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjCZM1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCZM1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:27:23 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086344C3F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:27:22 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id b18so7276886ybp.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679833641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuEsxrDbF/inLpKrbuVfZ5izqyJJinZBdUjdf7O5LUM=;
        b=V2gHZHslEdu3xrIj9mtxPLaMLoocSdj5ImvyU4v+44pm9nVKNP/zYL1Dg2eieY2dxp
         onkNUDhH4aQXyS5ed0T6dBP1v4bMpWcxzSnhyhvzCY/L15JMWN/KJCqFpN/dfiykJfAB
         9cWNgbjm86N+e4qqv1IeChEjzj55EXToH5TPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679833641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuEsxrDbF/inLpKrbuVfZ5izqyJJinZBdUjdf7O5LUM=;
        b=0dp1Hb97uozB6r8Ia9FxNIpGDOwQkhKdipnlrY315q2hG3pVCzleqRMWquAjPpDvva
         duP7JdmuguAi4mSEWNlQcptnZqjXeJ765MVYuiB7924o+4pS4cKiHqjWRhLRmwQxi3Yy
         CMZ5cg7iLYEO2+DG/dzV7B4OW6HJDH2df0pQ06A/btZm4vNyilGOKwBnWn6Xb0q7e+Es
         DnGlApnVRci2rJ1f2LSumJJ2Fncv2OpoZsGmswoYVQpbx1kMp88LeUXzmsC6iVKTdZ51
         7RbY9A9c1bSWDxnm72HlEarLa+Rqv8kr25J2s6UOhASeMhy5dLQ0vA1YZJQq5TLX5veb
         8eSg==
X-Gm-Message-State: AAQBX9fqU9tJQ3jWPLJcZErnBBN/8ksgyFwpkNsHbkUeHkAgeCpKBXWg
        iXVKEFaNbP86GohsytoYspKZpkroKNZwMZjKvBsHfQ==
X-Google-Smtp-Source: AKy350Z7FAUAxqILc0KDv/Q2NcQmwgP5WIczo/cB3lR7Oy5nlhBvDO4RBmlXSkSRRW9Lr0SX2xoh8S28f15LfRwm9Xk=
X-Received: by 2002:a05:6902:1108:b0:b6d:fc53:c5c0 with SMTP id
 o8-20020a056902110800b00b6dfc53c5c0mr6998960ybu.1.1679833641143; Sun, 26 Mar
 2023 05:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230315181902.4177819-1-joel@joelfernandes.org>
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 26 Mar 2023 08:27:10 -0400
Message-ID: <CAEXW_YQehT7Zj0G4nBj-0b+Ndq_FTxFzxQ-WYnBGJ=87wPBHYw@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] drbd: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 2:19=E2=80=AFPM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
>
> The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
> switch to the new kvfree_rcu_mightsleep() variant. The goal is to
> avoid accidental use of the single-argument forms, which can introduce
> functionality bugs in atomic contexts and latency bugs in non-atomic
> contexts.
>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>

Jens/Others, any chance for an Ack here?

 - Joel

> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  drivers/block/drbd/drbd_nl.c       | 6 +++---
>  drivers/block/drbd/drbd_receiver.c | 4 ++--
>  drivers/block/drbd/drbd_state.c    | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 60757ac31701..f49f2a5282e1 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -1615,7 +1615,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct =
genl_info *info)
>                         drbd_send_sync_param(peer_device);
>         }
>
> -       kvfree_rcu(old_disk_conf);
> +       kvfree_rcu_mightsleep(old_disk_conf);
>         kfree(old_plan);
>         mod_timer(&device->request_timer, jiffies + HZ);
>         goto success;
> @@ -2446,7 +2446,7 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct g=
enl_info *info)
>
>         mutex_unlock(&connection->resource->conf_update);
>         mutex_unlock(&connection->data.mutex);
> -       kvfree_rcu(old_net_conf);
> +       kvfree_rcu_mightsleep(old_net_conf);
>
>         if (connection->cstate >=3D C_WF_REPORT_PARAMS) {
>                 struct drbd_peer_device *peer_device;
> @@ -2860,7 +2860,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct gen=
l_info *info)
>                 new_disk_conf->disk_size =3D (sector_t)rs.resize_size;
>                 rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf=
);
>                 mutex_unlock(&device->resource->conf_update);
> -               kvfree_rcu(old_disk_conf);
> +               kvfree_rcu_mightsleep(old_disk_conf);
>                 new_disk_conf =3D NULL;
>         }
>
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd=
_receiver.c
> index 757f4692b5bd..e197b2a465d2 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -3759,7 +3759,7 @@ static int receive_protocol(struct drbd_connection =
*connection, struct packet_in
>                 drbd_info(connection, "peer data-integrity-alg: %s\n",
>                           integrity_alg[0] ? integrity_alg : "(none)");
>
> -       kvfree_rcu(old_net_conf);
> +       kvfree_rcu_mightsleep(old_net_conf);
>         return 0;
>
>  disconnect_rcu_unlock:
> @@ -4127,7 +4127,7 @@ static int receive_sizes(struct drbd_connection *co=
nnection, struct packet_info
>
>                         rcu_assign_pointer(device->ldev->disk_conf, new_d=
isk_conf);
>                         mutex_unlock(&connection->resource->conf_update);
> -                       kvfree_rcu(old_disk_conf);
> +                       kvfree_rcu_mightsleep(old_disk_conf);
>
>                         drbd_info(device, "Peer sets u_size to %lu sector=
s (old: %lu)\n",
>                                  (unsigned long)p_usize, (unsigned long)m=
y_usize);
> diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_st=
ate.c
> index 75d13ea0024f..2aeea295fa28 100644
> --- a/drivers/block/drbd/drbd_state.c
> +++ b/drivers/block/drbd/drbd_state.c
> @@ -2071,7 +2071,7 @@ static int w_after_conn_state_ch(struct drbd_work *=
w, int unused)
>                 conn_free_crypto(connection);
>                 mutex_unlock(&connection->resource->conf_update);
>
> -               kvfree_rcu(old_conf);
> +               kvfree_rcu_mightsleep(old_conf);
>         }
>
>         if (ns_max.susp_fen) {
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
