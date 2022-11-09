Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0212622C15
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiKINDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiKINDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:03:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D42C6366;
        Wed,  9 Nov 2022 05:03:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 17B131F9D4;
        Wed,  9 Nov 2022 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667999010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4xnB2FFSgIPLitOIlbCwaiWC7GoReRhbRsURO07TQ0=;
        b=Xm31G740IveQJJwhpWqUouc4Qsq/BDHAnFTzYGiD5NmA+tdwDHYyTLur7ncjMfLLhFeygF
        uXyoZ+Xh6JTmFQE2wCgTqbYRm8N/qeK001qR/OI6m2Uz/SQLh9NEqHmpVUksZtqXei1pop
        s2PPVroL0SiClfsO8awjsBPtidOCYZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667999010;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4xnB2FFSgIPLitOIlbCwaiWC7GoReRhbRsURO07TQ0=;
        b=oDtVvztBbAlN2veZB8lqZO92F4/sIxjVZFcwdP9lenRwjE97F1IiGDZ2dhKxbDYJoZi7BP
        6TGmNP5WP+1ItXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9A95139F1;
        Wed,  9 Nov 2022 13:03:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v2jvMyGla2M+dgAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 09 Nov 2022 13:03:29 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Nicolai Stange <nstange@suse.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] padata: avoid potential UAFs to the padata_shell
 from padata_reorder()
References: <20221019083708.27138-1-nstange@suse.de>
        <20221019083708.27138-6-nstange@suse.de>
        <20221028161402.rh2p6feok2kjbjuq@parnassus.localdomain>
Date:   Wed, 09 Nov 2022 14:03:29 +0100
In-Reply-To: <20221028161402.rh2p6feok2kjbjuq@parnassus.localdomain> (Daniel
        Jordan's message of "Fri, 28 Oct 2022 12:14:02 -0400")
Message-ID: <87bkpgb7q6.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Wed, Oct 19, 2022 at 10:37:08AM +0200, Nicolai Stange wrote:
>> Even though the parallel_data "pd" instance passed to padata_reorder() is
>> guaranteed to exist as per the reference held by its callers, the same is
>> not true for the associated padata_shell, pd->ps. More specifically, once
>> the last padata_priv request has been completed, either at entry from
>> padata_reorder() or concurrently to it, the padata API users are well
>> within their right to free the padata_shell instance.
>
> The synchronize_rcu change seems to make padata_reorder safe from freed
> ps's with the exception of a straggler reorder_work.  For that, I think
> something like this hybrid of your code and mine is enough to plug the
> hole.  It's on top of 1-2 and my hunk from 3.  It has to take an extra
> ref on pd, but only in the rare case where the reorder work is used.
> Thoughts?
>
> diff --git a/kernel/padata.c b/kernel/padata.c
> index cd6740ae6629..f14c256a0ee3 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -277,7 +277,7 @@ static struct padata_priv *padata_find_next(struct pa=
rallel_data *pd,
>=20=20
>  static void padata_reorder(struct parallel_data *pd)
>  {
> -	struct padata_instance *pinst =3D pd->ps->pinst;
> +	struct padata_instance *pinst;
>  	int cb_cpu;
>  	struct padata_priv *padata;
>  	struct padata_serial_queue *squeue;
> @@ -314,7 +314,7 @@ static void padata_reorder(struct parallel_data *pd)
>  		list_add_tail(&padata->list, &squeue->serial.list);
>  		spin_unlock(&squeue->serial.lock);
>=20=20
> -		queue_work_on(cb_cpu, pinst->serial_wq, &squeue->work);
> +		queue_work_on(cb_cpu, pd->ps->pinst->serial_wq, &squeue->work);
>  	}
>=20=20
>  	spin_unlock_bh(&pd->lock);
> @@ -330,8 +330,10 @@ static void padata_reorder(struct parallel_data *pd)
>  	smp_mb();
>=20=20
>  	reorder =3D per_cpu_ptr(pd->reorder_list, pd->cpu);
> -	if (!list_empty(&reorder->list) && padata_find_next(pd, false))
> -		queue_work(pinst->serial_wq, &pd->reorder_work);
> +	if (!list_empty(&reorder->list) && padata_find_next(pd, false)) {
> +		if (queue_work(pd->ps->pinst->serial_wq, &pd->reorder_work))
> +			padata_get_pd(pd);

As the reorder_work can start running immediately after having been
submitted, wouldn't it be more correct to do something like

		padata_get_pd(pd);
		if (!queue_work(pd->ps->pinst->serial_wq, &pd->reorder_work))
			padata_put_pd(pd);

?

Otherwise the patch looks good to me.

Thanks!

Nicolai

> +	}
>  }
>=20=20
>  static void invoke_padata_reorder(struct work_struct *work)
> @@ -342,6 +344,7 @@ static void invoke_padata_reorder(struct work_struct =
*work)
>  	pd =3D container_of(work, struct parallel_data, reorder_work);
>  	padata_reorder(pd);
>  	local_bh_enable();
> +	padata_put_pd(pd);
>  }
>=20=20
>  static void padata_serial_worker(struct work_struct *serial_work)
>

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
(HRB 36809, AG N=C3=BCrnberg)
