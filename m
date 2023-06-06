Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41CF723F6F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbjFFK2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbjFFK2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC87E60
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686047236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJVswKQZ4ZBsOXRb2fcji4jRQbDRIYhvTVo8Uo+LZ/k=;
        b=NOFducLaTL+srK9yZjweLW+S/DT0pbxPMqDBDGYKzNZeEx1saNGo8rxgs+isl1BZPG3KaT
        x/K2+twcjbgw+wdcfHW7oMdLRoXTHZ5fiQRNoX7Lrk9VAh+duE6X7ugEAwWEU9iTQjM8H3
        cxyVRjwSH0vLglkvOnhxhzO55ZRVbLs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-3BBF-QSBO3CPvFT-Hy6srQ-1; Tue, 06 Jun 2023 06:27:15 -0400
X-MC-Unique: 3BBF-QSBO3CPvFT-Hy6srQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75b147a2548so118788785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686047234; x=1688639234;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJVswKQZ4ZBsOXRb2fcji4jRQbDRIYhvTVo8Uo+LZ/k=;
        b=lLeu6CMV2S/2Zswi3RUBoNJ4o2oNQ9b8WyQyOeX4bkHNxa+LvNKGS560fl7VvQCkfY
         4O6sbXNdsCLhxOaFSqVEEXmDH2IpmKx0LPhe3jRz2AhmF5bR5d6o+JFK4cCjBsbTNmU4
         nmfBZ00AFB9/FylcTyYvz89YQEvxhy5y6nhcJzWcd9/SQ4Y8t0Ao6nkHpFanUvxc6zBG
         vFwU6+d/4mQm0U8bVs+NOuvcJ6N5jNI3z3LTyYfxvBNbpv0/R7QaJuJkzKuQdLxHbIq7
         ir+D8VlRQ4AXAidx8mlvBpBJiKSTLxuwnVchGSnkYgFnpQ2/WD9d2xyDb0iAYrkSlGW+
         A0nw==
X-Gm-Message-State: AC+VfDwFqpvzxszsyB1Se/ioKsZixMPX44sTpgkSk/c1EbQa9L5HKAUi
        lYalvvz64kwKqPD2MNO88WBnLOQu1TRBc5kvthFeH6wKmCHiXWemZeQro9saDSqWNFbyVvlDQTt
        1GYDmhzydCdvfDPLqrUWLiwdX
X-Received: by 2002:a05:620a:480e:b0:75e:b9ab:2690 with SMTP id eb14-20020a05620a480e00b0075eb9ab2690mr1406135qkb.6.1686047234471;
        Tue, 06 Jun 2023 03:27:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5OSiucGERn1Apv2naVnzdBF0n9nP1P0fLHpwJatKTXLloqbnBmljCcAsUu1droayCJqVXfwg==
X-Received: by 2002:a05:620a:480e:b0:75e:b9ab:2690 with SMTP id eb14-20020a05620a480e00b0075eb9ab2690mr1406116qkb.6.1686047234158;
        Tue, 06 Jun 2023 03:27:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-89.dyn.eolo.it. [146.241.114.89])
        by smtp.gmail.com with ESMTPSA id n13-20020ae9c30d000000b0075c97468f57sm4803347qkg.82.2023.06.06.03.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 03:27:13 -0700 (PDT)
Message-ID: <6bce1c55e1cd4295a3f36cb4b37398d951ead07b.camel@redhat.com>
Subject: Re: [PATCH RESEND net-next 2/5] net/sched: taprio: keep child Qdisc
 refcount elevated at 2 in offload mode
From:   Paolo Abeni <pabeni@redhat.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>
Date:   Tue, 06 Jun 2023 12:27:09 +0200
In-Reply-To: <20230602103750.2290132-3-vladimir.oltean@nxp.com>
References: <20230602103750.2290132-1-vladimir.oltean@nxp.com>
         <20230602103750.2290132-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-02 at 13:37 +0300, Vladimir Oltean wrote:
> The taprio qdisc currently lives in the following equilibrium.
>=20
> In the software scheduling case, taprio attaches itself to all TXQs,
> thus having a refcount of 1 + the number of TX queues. In this mode,
> q->qdiscs[] is not visible directly to the Qdisc API. The lifetime of
> the Qdiscs from this private array lasts until qdisc_destroy() ->
> taprio_destroy().
>=20
> In the fully offloaded case, the root taprio has a refcount of 1, and
> all child q->qdiscs[] also have a refcount of 1. The child q->qdiscs[]
> are visible to the Qdisc API (they are attached to the netdev TXQs
> directly), however taprio loses a reference to them very early - during
> qdisc_graft(parent=3D=3DNULL) -> taprio_attach(). At that time, taprio fr=
ees
> the q->qdiscs[] array to not leak memory, but interestingly, it does not
> release a reference on these qdiscs because it doesn't effectively own
> them - they are created by taprio but owned by the Qdisc core, and will
> be freed by qdisc_graft(parent=3D=3DNULL, new=3D=3DNULL) -> qdisc_put(old=
) when
> the Qdisc is deleted or when the child Qdisc is replaced with something
> else.
>=20
> My interest is to change this equilibrium such that taprio also owns a
> reference on the q->qdiscs[] child Qdiscs for the lifetime of the root
> Qdisc, including in full offload mode. I want this because I would like
> taprio_leaf(), taprio_dump_class(), taprio_dump_class_stats() to have
> insight into q->qdiscs[] for the software scheduling mode - currently
> they look at dev_queue->qdisc_sleeping, which is, as mentioned, the same
> as the root taprio.
>=20
> The following set of changes is necessary:
> - don't free q->qdiscs[] early in taprio_attach(), free it late in
>   taprio_destroy() for consistency with software mode. But:
> - currently that's not possible, because taprio doesn't own a reference
>   on q->qdiscs[]. So hold that reference - once during the initial
>   attach() and once during subsequent graft() calls when the child is
>   changed.
> - always keep track of the current child in q->qdiscs[], even for full
>   offload mode, so that we free in taprio_destroy() what we should, and
>   not something stale.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  net/sched/sch_taprio.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>=20
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index b1c611c72aa4..8807fc915b79 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -2138,23 +2138,20 @@ static void taprio_attach(struct Qdisc *sch)
> =20
>  			qdisc->flags |=3D TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
>  			old =3D dev_graft_qdisc(dev_queue, qdisc);
> +			/* Keep refcount of q->qdiscs[ntx] at 2 */
> +			qdisc_refcount_inc(qdisc);
>  		} else {
>  			/* In software mode, attach the root taprio qdisc
>  			 * to all netdev TX queues, so that dev_qdisc_enqueue()
>  			 * goes through taprio_enqueue().
>  			 */
>  			old =3D dev_graft_qdisc(dev_queue, sch);
> +			/* Keep root refcount at 1 + num_tx_queues */
>  			qdisc_refcount_inc(sch);
>  		}
>  		if (old)
>  			qdisc_put(old);
>  	}
> -
> -	/* access to the child qdiscs is not needed in offload mode */
> -	if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
> -		kfree(q->qdiscs);
> -		q->qdiscs =3D NULL;
> -	}
>  }
> =20
>  static struct netdev_queue *taprio_queue_get(struct Qdisc *sch,
> @@ -2183,15 +2180,24 @@ static int taprio_graft(struct Qdisc *sch, unsign=
ed long cl,
>  	if (dev->flags & IFF_UP)
>  		dev_deactivate(dev);
> =20
> -	if (FULL_OFFLOAD_IS_ENABLED(q->flags)) {
> +	/* In software mode, the root taprio qdisc is still the one attached to
> +	 * all netdev TX queues, and hence responsible for taprio_enqueue() to
> +	 * forward the skbs to the child qdiscs from the private q->qdiscs[]
> +	 * array. So only attach the new qdisc to the netdev queue in offload
> +	 * mode, where the enqueue must bypass taprio. However, save the
> +	 * reference to the new qdisc in the private array in both cases, to
> +	 * have an up-to-date reference to our children.
> +	 */
> +	if (FULL_OFFLOAD_IS_ENABLED(q->flags))
>  		*old =3D dev_graft_qdisc(dev_queue, new);
> -	} else {
> +	else
>  		*old =3D q->qdiscs[cl - 1];
> -		q->qdiscs[cl - 1] =3D new;
> -	}
> =20
> -	if (new)
> +	q->qdiscs[cl - 1] =3D new;
> +	if (new) {
> +		qdisc_refcount_inc(new);
>  		new->flags |=3D TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
> +	}
> =20
Isn't the above leaking a reference to old with something alike:

tc qdisc replace dev eth0 handle 8001: parent root stab overhead 24 taprio =
flags 0x2 #...
	# each q in q->qdiscs has refcnt =3D=3D 2
tc qdisc replace dev eth0 parent 8001:8 cbs #...
	# -> taprio_graft(..., cbs, ...)
	# cbs refcnt is 2
	# 'old' refcnt decreases by 1, refcount will not reach 0?!?

kmemleak should be able to see that.

BTW, what about including your tests from the cover letter somewhere under =
tc-testing?

Thanks!

Paolo

