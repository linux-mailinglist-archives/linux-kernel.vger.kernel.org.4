Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B3A6445F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 15:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbiLFOpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 09:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiLFOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 09:45:27 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE02C22B26
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 06:45:23 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id y15so13838312qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 06:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4hTa2xZjkRMHJNZ79XdP0A79Ajl/IYyrQEqODl2bls=;
        b=HNNdvG9ZGO8uDEyJObMoacrWYH4sOixGmLUUDp3gE90yLfSBdQTdzauQ5wfz31oL2P
         eGdBLffB7f8uWEcQEcXQzZ2WzU6KDWdXWr7GwJT6Djqz8+It4K+XGkkvcintSQA8uM8O
         gRdzEReKdW6CqQhxux922px6XIziOI5UPuxZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4hTa2xZjkRMHJNZ79XdP0A79Ajl/IYyrQEqODl2bls=;
        b=VT1PgeDuWKrGZfv2ewrI5/Efyf86DssW/hUxVnzelg+ghE0IdHY0E50myqiiO0bigb
         IMW8aN6ocKQOYw46swN6nzWzsu4HnUUvanoHpHMc3wKUn9hTlRNNuHsaOo5RsAFMBHRW
         dfRsshTYresx7u17zmLAz6Q02bkiAiIgKFOl7gCS2w6JXoUs2K82sjxuzfb1xeaPa2Kj
         OoEDv8Yo0vrrNdJ1NuVVC+UbE+aZ7tXxwGhfp7H3Xc8kkFSG7dLq7NBucgmK7nsxy5Sm
         cecGLTGQ9961TIQnlfdqDAttg57FYRLoNOz93C4IfT/2AAOf3IFArit5/XUQgykUUES+
         rS3g==
X-Gm-Message-State: ANoB5plquh77SZ4eXVmPTvncr/IndFmq7SgNl4rucwK5DqsgENMPEagL
        VgvAPHNz5iZ3O1xSAwJHRnVMBg==
X-Google-Smtp-Source: AA0mqf4K9pzjO4hUKWL48OrUNx1IpNAiv7roFW9eSm+OEHyGYkqNB8vRdvbGCOrbshEFiwV1YILBIA==
X-Received: by 2002:ac8:7a81:0:b0:3a6:88c6:69fa with SMTP id x1-20020ac87a81000000b003a688c669famr28851448qtr.365.1670337922967;
        Tue, 06 Dec 2022 06:45:22 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id bm1-20020a05620a198100b006fa2b1c3c1esm15060825qkb.58.2022.12.06.06.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 06:45:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/1] rcu/kvfree: Add runtime sleep check for single argument
Date:   Tue, 6 Dec 2022 09:45:11 -0500
Message-Id: <E8261077-6AFB-4FA6-AEAB-3BEFF5ABEC23@joelfernandes.org>
References: <20221206122357.309982-1-urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
In-Reply-To: <20221206122357.309982-1-urezki@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vlad,

> On Dec 6, 2022, at 7:24 AM, Uladzislau Rezki (Sony) <urezki@gmail.com> wro=
te:
>=20
> =EF=BB=BFA single argument can be invoked only from a sleepable
> context. There is already a might_sleep() check to mitigate
> such cases.
> The problem is that it requires a kernel to
> be built with a CONFIG_DEBUG_ATOMIC_SLEEP option.
>=20
> In order to improve an extra runtime_assert_can_sleep()
> function is introduced by this patch. It is a run-time
> checking. Please note it only covers PREEMPT

I would call it preemptible kernels.

> kernels.

Also, It is not clear at all from the commit message about what we are check=
ing and why. Neither is it clear why the might_sleep() is insufficient.

The whole point of doing this is, the purpose of might_sleep() is to check w=
hether we are blocking in an atomic context. That will not help Eric issue w=
hich is totally different - we would like to know if we are using an API whe=
re we can block instead of an API where we do not need to, by providing addi=
tional rcu_head space.

> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
> kernel/rcu/tree.c | 17 ++++++++++++++++-
> 1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d155f2594317..bb798f07e768 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3232,6 +3232,19 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krc=
p,
>    return true;
> }
>=20
> +static void
> +runtime_assert_can_sleep(void)
> +{
> +    if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
> +        return;
> +
> +    if (preemptible())
> +        return;

These 2 iffs can be combined into 2-3 lines in this function. No need to add=
 more LOC than needed.

> +
> +    WARN_ONCE(1, "in_atomic(): %d, irqs_disabled(): %d, pid: %d, name: %s=
\n",
> +        in_atomic(), irqs_disabled(), current->pid, current->comm);
> +}
> +
> /*
>  * Queue a request for lazy invocation of the appropriate free routine
>  * after a grace period.  Please note that three paths are maintained,
> @@ -3257,8 +3270,10 @@ void kvfree_call_rcu(struct rcu_head *head, void *p=
tr)
>     * only. For other places please embed an rcu_head to
>     * your data.
>     */
> -    if (!head)
> +    if (!head) {
> +        runtime_assert_can_sleep();
>        might_sleep();

runtime_assert_preemptible() is a better name with a comment about big comme=
nt on top of the new function about false negatives for non-preemptible kern=
els. Can sleep sounds like might sleep which just adds confusion and does no=
t help code readers.

Also Paul raised a point about using 1-arg API in some sleepable contexts wh=
ere the caller does not want to introduce new space for the head. Have we co=
nfirmed there are not any? If there are, the warning will fire for those, as=
 false-positives.

Cheers,

 - Joel

> +    }
>=20
>    // Queue the object but don't yet schedule the batch.
>    if (debug_rcu_head_queue(ptr)) {
> --=20
> 2.30.2
>=20
