Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF80622C12
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiKINDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKINDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:03:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC65B1C112;
        Wed,  9 Nov 2022 05:03:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A5491F9D5;
        Wed,  9 Nov 2022 13:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667998996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJhfeFE1JFkFK9Og9dpyW2jthVhrwDkvsUy71SggFkg=;
        b=nKzzyvGVAtMwbOHkKJrkVFatGSJJumAb4zUJBWqh0bDwlqEvIvZT7HFXtm86V5ImBeXrxA
        S0q5v4KXVvJtz11ppIaL0GLWeUbmd6Y5B1vsMl2+HKIOVbHDXBPcsZmQ44nB1k+11LvTL0
        Syg4We+jCi9EjJ8AlKreph6dJxDTAD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667998996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJhfeFE1JFkFK9Og9dpyW2jthVhrwDkvsUy71SggFkg=;
        b=Bh20/oisrN6JYhjynLryQT8Z9fPrmZAWFJz0tj7zTfC7hobDCGTXTrlVDcyMRIiuy+Tpi2
        9TCMH6hYhyFaLcDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45E0B139F1;
        Wed,  9 Nov 2022 13:03:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id imPYDxSla2MgdgAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 09 Nov 2022 13:03:16 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Nicolai Stange <nstange@suse.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] padata: grab parallel_data refcnt for reorder
References: <20221019083708.27138-1-nstange@suse.de>
        <20221019083708.27138-4-nstange@suse.de>
        <20221028160401.cccypv4euxikusiq@parnassus.localdomain>
Date:   Wed, 09 Nov 2022 14:03:15 +0100
In-Reply-To: <20221028160401.cccypv4euxikusiq@parnassus.localdomain> (Daniel
        Jordan's message of "Fri, 28 Oct 2022 12:04:01 -0400")
Message-ID: <87cz9wb7qk.fsf@suse.de>
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

> On Wed, Oct 19, 2022 at 10:37:06AM +0200, Nicolai Stange wrote:
>> On entry of padata_do_serial(), the in-flight padata_priv owns a referen=
ce
>> to the associated parallel_data instance.
>>=20
>> However, as soon as the padata_priv got enqueued on the reorder list, it
>> can be completed from a different context, causing the reference to get
>> released in the course.
>>=20
>> This would potentially cause UAFs from the subsequent padata_reorder()
>> operations invoked from the enqueueing padata_do_serial() or from the
>> reorder work.
>>=20

<snip>

>> ---
>>  kernel/padata.c | 26 +++++++++++++++++++++-----
>>  1 file changed, 21 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/kernel/padata.c b/kernel/padata.c
>> index 0bf8c80dad5a..b79226727ef7 100644
>> --- a/kernel/padata.c
>> +++ b/kernel/padata.c
>> @@ -275,7 +275,7 @@ static struct padata_priv *padata_find_next(struct p=
arallel_data *pd,
>>  	return padata;
>>  }
>>=20=20
>> -static void padata_reorder(struct parallel_data *pd)
>> +static bool padata_reorder(struct parallel_data *pd)
>>  {
>>  	struct padata_instance *pinst =3D pd->ps->pinst;
>>  	int cb_cpu;
>> @@ -294,7 +294,7 @@ static void padata_reorder(struct parallel_data *pd)
>>  	 * care for all the objects enqueued during the holdtime of the lock.
>>  	 */
>>  	if (!spin_trylock_bh(&pd->lock))
>> -		return;
>> +		return false;
>>=20=20
>>  	while (1) {
>>  		padata =3D padata_find_next(pd, true);
>> @@ -331,17 +331,23 @@ static void padata_reorder(struct parallel_data *p=
d)
>>=20=20
>>  	reorder =3D per_cpu_ptr(pd->reorder_list, pd->cpu);
>>  	if (!list_empty(&reorder->list) && padata_find_next(pd, false))
>> -		queue_work(pinst->serial_wq, &pd->reorder_work);
>> +		return queue_work(pinst->serial_wq, &pd->reorder_work);
>> +
>> +	return false;
>>  }
>>=20=20
>>  static void invoke_padata_reorder(struct work_struct *work)
>>  {
>>  	struct parallel_data *pd;
>> +	bool keep_refcnt;
>>=20=20
>>  	local_bh_disable();
>>  	pd =3D container_of(work, struct parallel_data, reorder_work);
>> -	padata_reorder(pd);
>> +	keep_refcnt =3D padata_reorder(pd);
>>  	local_bh_enable();
>> +
>> +	if (!keep_refcnt)
>> +		padata_put_pd(pd);
>>  }
>>=20=20
>>  static void padata_serial_worker(struct work_struct *serial_work)
>> @@ -392,6 +398,15 @@ void padata_do_serial(struct padata_priv *padata)
>>  	struct padata_list *reorder =3D per_cpu_ptr(pd->reorder_list, hashed_c=
pu);
>>  	struct padata_priv *cur;
>>=20=20
>> +	/*
>> +	 * The in-flight padata owns a reference on pd. However, as
>> +	 * soon as it's been enqueued on the reorder list, another
>> +	 * task can dequeue and complete it, thereby dropping the
>> +	 * reference. Grab another reference here, it will eventually
>> +	 * be released from a reorder work, if any, or below.
>> +	 */
>> +	padata_get_pd(pd);
>> +
>>  	spin_lock(&reorder->lock);
>>  	/* Sort in ascending order of sequence number. */
>>  	list_for_each_entry_reverse(cur, &reorder->list, list)
>> @@ -407,7 +422,8 @@ void padata_do_serial(struct padata_priv *padata)
>>  	 */
>>  	smp_mb();
>>=20=20
>> -	padata_reorder(pd);
>> +	if (!padata_reorder(pd))
>> +		padata_put_pd(pd);
>
> do_serial is supposed to be called with BHs disabled and will be in
> every case after a fix for a separate issue that I plan to send this
> cycle.  Given that it (will soon...) always happen under RCU protection,
> part of this issue could be addressed like this, which puts the expense
> of dealing with this rare problem in the slow path:
>
> diff --git a/kernel/padata.c b/kernel/padata.c
> index 0bf8c80dad5a..cd6740ae6629 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -1110,6 +1110,12 @@ void padata_free_shell(struct padata_shell *ps)
>  	if (!ps)
>  		return;
>=20=20
> +	/*
> +	 * Wait for all _do_serial calls to finish to avoid touching freed pd's
> +	 * and ps's.
> +	 */
> +	synchronize_rcu();
> +
>  	mutex_lock(&ps->pinst->lock);
>  	list_del(&ps->list);
>  	padata_put_pd(rcu_dereference_protected(ps->pd, 1));
>
> pcrypt calls padata_free_shell() when all outstanding transforms (and
> thus requests, I think) have been freed/completed, so no new task can
> come into padata_reorder.  synchronize_rcu() then flushes out any
> remaining _reorder calls.
>
> This doesn't deal with pending reorder_work items, but we can fix it
> later in the series.
>
> What do you think?

Yes, I think that would work. Will you handle it alongside that fix for
a separate issue you mentioned above? Or shall I once this fix has
landed?

Thanks!

Nicolai

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
(HRB 36809, AG N=C3=BCrnberg)
