Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA566D5596
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 02:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjDDAfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 20:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjDDAfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 20:35:12 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A162026AD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 17:35:10 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id jl13so22387151qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 17:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680568509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=89t77E0GCaocHYERVbpqEfvdDRudJVKzocTuC0O/3pU=;
        b=RFZIAK3uyFOvXUL9RIthq6yhKCqdkBwTauoZDr6OKTcqmD6U0Js6mfP9tUb8tQDuIw
         FaaQb0FLXbRDoarbYv6RiFZgjZ9irxQtxiJ8xLhhfLAomQk86+TiDJVoww85P10et/6O
         KiA99eylkKLfcnkR8qgSVUp76lmqtxvyzRh4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680568509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89t77E0GCaocHYERVbpqEfvdDRudJVKzocTuC0O/3pU=;
        b=5tJvI6T4O2GU/CsW2gLDNExZmoO0IPFzWuePdsezoCOE8UbSgUMW8Ew2btBlth2TzU
         AGum/f3YGZfA5Pi7qLMvQa50iKV/9RiPu90JUH0gIErNUC/BTUUH+LTp0HTUSspaTQqe
         sbTi1KvigcK3Gszl+DswTSFvIS8OB1Dq+uY9p91ub//1XM9BVLJ88kymk2G17/wciwsV
         eeX8/e7/oriCC3A9fRfkb2QxAY7YcOSqNzDz+Yzwh3PY9IMpNGoACmnGS7dSrko2O/bt
         GczOvIYTimX4D2zzCiKHqGwfASKuHS7dASgxvckm5DTx2JEqnbnc/ePJ9X9ksstBsb1B
         iSoA==
X-Gm-Message-State: AAQBX9dgj5TWwPqbFfgl6dPMj75TOei0PmLCLt5Z8Ll3Z9cM2glfWpKW
        yBOaV7JgXsHElDXlCNg0A12whg==
X-Google-Smtp-Source: AKy350YjxFimkOwi8SJYjrxfRPlO7r4I1CrglSM8TtHnUGdVa70gMbM/rGVdLWaT0dtfgRF4qYj7qg==
X-Received: by 2002:a05:6214:d85:b0:5d5:fd1d:6ef5 with SMTP id e5-20020a0562140d8500b005d5fd1d6ef5mr945540qve.12.1680568509360;
        Mon, 03 Apr 2023 17:35:09 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id jh14-20020a0562141fce00b005dd8b9345b0sm3003150qvb.72.2023.04.03.17.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 17:35:08 -0700 (PDT)
Date:   Tue, 4 Apr 2023 00:35:08 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, hch@lst.de,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: Re: [PATCH rcu 04/20] srcu: Begin offloading srcu_struct fields to
 srcu_update
Message-ID: <20230404003508.GA254019@google.com>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
 <20230330224726.662344-4-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330224726.662344-4-paulmck@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 03:47:10PM -0700, Paul E. McKenney wrote:
> The current srcu_struct structure is on the order of 200 bytes in size
> (depending on architecture and .config), which is much better than the
> old-style 26K bytes, but still all too inconvenient when one is trying
> to achieve good cache locality on a fastpath involving SRCU readers.
> 
> However, only a few fields in srcu_struct are used by SRCU readers.
> The remaining fields could be offloaded to a new srcu_update
> structure, thus shrinking the srcu_struct structure down to a few
> tens of bytes.  This commit begins this noble quest, a quest that is
> complicated by open-coded initialization of the srcu_struct within the
> srcu_notifier_head structure.  This complication is addressed by updating
> the srcu_notifier_head structure's open coding, given that there does
> not appear to be a straightforward way of abstracting that initialization.
> 
> This commit moves only the ->node pointer to srcu_update.  Later commits
> will move additional fields.
> 
> [ paulmck: Fold in qiang1.zhang@intel.com's memory-leak fix. ]
> 
> Link: https://lore.kernel.org/all/20230320055751.4120251-1-qiang1.zhang@intel.com/
> Suggested-by: Christoph Hellwig <hch@lst.de>

[..]
> @@ -236,8 +236,12 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
>   */
>  static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  {
> +	if (!is_static)
> +		ssp->srcu_sup = kzalloc(sizeof(*ssp->srcu_sup), GFP_KERNEL);
> +	if (!ssp->srcu_sup)
> +		return -ENOMEM;
>  	ssp->srcu_size_state = SRCU_SIZE_SMALL;
> -	ssp->node = NULL;
> +	ssp->srcu_sup->node = NULL;
>  	mutex_init(&ssp->srcu_cb_mutex);
>  	mutex_init(&ssp->srcu_gp_mutex);
>  	ssp->srcu_idx = 0;
> @@ -249,8 +253,11 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
>  	ssp->sda_is_static = is_static;
>  	if (!is_static)
>  		ssp->sda = alloc_percpu(struct srcu_data);
> -	if (!ssp->sda)
> +	if (!ssp->sda) {
> +		if (!is_static)
> +			kfree(ssp->srcu_sup);
>  		return -ENOMEM;
> +	}
>  	init_srcu_struct_data(ssp);
>  	ssp->srcu_gp_seq_needed_exp = 0;
>  	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
> @@ -259,6 +266,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)

[1] Here there is an if (!init_srcu_struct_nodes(...)) that the diff does not show.

>  			if (!ssp->sda_is_static) {
>  				free_percpu(ssp->sda);
>  				ssp->sda = NULL;
> +				kfree(ssp->srcu_sup);
>  				return -ENOMEM;
>  			}
>  		} else {


Just a comment about the original code with reference to [1].

Here if allocations in init_srcu_struct_nodes() fail, it will return false
and execute the "if (!ssp->sda_is_is_static)" bit.

So if the allocation in [1] fails, then if sda_is_static is true, we return
-ENOMEM, however  if sda_is_static is false, we do the following:

        ssp->srcu_sup->srcu_ssp = ssp;
        smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */
        return 0;

Is that really correct?

In other words, if init_srcu_struct_nodes() returns false, then passing along
the return value of init_srcu_struct_nodes() back to the caller of
init_srcu_struct_fields() depends on whether is_static = true or false. That
seems a bit wrong to me, init_srcu_struct_fields() should always return
-ENOMEM  when init_srcu_struct_nodes() fails to allocate memory IMHO, whether
is_static is true or not.

Sorry if I missed something subtle, and if the code is correct to begin with.
Also I feel the return paths could be made better to also fix the above issue
I mentioned. How about the following diff on top of the series, would it
work?

Thanks!

---8<-----------------------

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index a887cfc89894..1975d06986fa 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -255,29 +255,30 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->sda_is_static = is_static;
 	if (!is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
-	if (!ssp->sda) {
-		if (!is_static)
-			kfree(ssp->srcu_sup);
-		return -ENOMEM;
-	}
+	if (!ssp->sda)
+		goto err_free_sup;
 	init_srcu_struct_data(ssp);
 	ssp->srcu_sup->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
-		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
-			if (!ssp->srcu_sup->sda_is_static) {
-				free_percpu(ssp->sda);
-				ssp->sda = NULL;
-				kfree(ssp->srcu_sup);
-				return -ENOMEM;
-			}
-		} else {
+		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
+			goto err_free_sda;
+		else
 			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
-		}
 	}
 	ssp->srcu_sup->srcu_ssp = ssp;
 	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */
 	return 0;
+
+err_free_sda:
+	if (!is_static) {
+		free_percpu(ssp->sda);
+		ssp->sda = NULL;
+	}
+err_free_sup:
+	if (!is_static)
+		kfree(ssp->srcu_sup);
+	return -ENOMEM;
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
