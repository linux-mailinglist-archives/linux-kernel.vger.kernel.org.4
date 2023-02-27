Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB496A4AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjB0TfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0TfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:35:19 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A931C5AB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:35:18 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id d30so30369103eda.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=roOLllx9yWQfOFfWczd+S3/BZTg2O9V9j0zFGMwpmOI=;
        b=ndY50It+kTe3Sefbdo7yJtcZarpG9hbabus6Uwl5bLXgfiT7zAW/fy7nTw6opH+q4L
         uKS+jvoi8hRsWDqgNr7/A+xw+k0QDDtkGAKkKW3vBM5DxobutVvXannvt4ty1jVSbj09
         2jzqmR9CnScn5ds58fcQ+cN1bkDYvntcOdjEadt9sEgdhDbZrcwfe8wEixvCTbp4lMom
         hIp0BLcKRzVq+8FdHl+xuIdHtk2v6W2rhrxVtl7q1dHAp8Scq61+au8FPK7L4Du5Hi/o
         GLIl1AclxRO07Zh1/yux8LHUiRZ/YxTpshXi/fBu5gwJ0OK/eUtTazNC5QDVcFIwuRjq
         zn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roOLllx9yWQfOFfWczd+S3/BZTg2O9V9j0zFGMwpmOI=;
        b=k9RzCQBW36Q5qbWhQ85W556u+ihaWogdt1V2v5h2xHCAguvN5rGGHHjuuA8N9ORhiM
         OHPaNDNEWCc44swapRQdcS5u5FD+AM/5pAFpHTPHJwnubNJZDCjAvdMFFoPHrudnOJwR
         ffd7a/TsOxbq/NwKPZyC7qqM56blMo/TDNdrUMbJ3iamORiQNJ+t3dmqP8mMam1ewL3P
         RBIG9w23eOkabJFRV1aQlLWVrpfyj5SDj/yKBjejbh8mcx1yKTBQdhaLe/7Vy7fm1EJn
         Q8QqdDUOx5XInjtYUHvMN4XZu+k+6X8zu7sRW7xVBVZpE2ZZyC/k227U4ZyKOnBzaYwN
         Rt5w==
X-Gm-Message-State: AO0yUKUCKK12OAj+LOH4VfpxoXEZyvMOHgSZVsvNSMaRLSQl+YMeWll7
        vlBMImIrUTJh8ZtgMJ++AS0=
X-Google-Smtp-Source: AK7set/RFAWeCtMS2/+uHN4HXEDKvatvNetwnVtcg2nB5/05wIOhPlU1i9YAtjzQUhnQOBMWLVH2Zg==
X-Received: by 2002:a17:906:1c17:b0:8b1:88aa:46da with SMTP id k23-20020a1709061c1700b008b188aa46damr34552817ejg.48.1677526516583;
        Mon, 27 Feb 2023 11:35:16 -0800 (PST)
Received: from andrea (host-87-18-14-224.retail.telecomitalia.it. [87.18.14.224])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906854600b008d4df095034sm3591701ejy.195.2023.02.27.11.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:35:16 -0800 (PST)
Date:   Mon, 27 Feb 2023 20:35:11 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     paulmck@kernel.org, stern@rowland.harvard.edu, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y/0F74SbW6sbwz8r@andrea>
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 02:52:51PM +0100, Jonas Oberhauser wrote:
> As stated in the documentation and implied by its name, the ppo
> (preserved program order) relation is intended to link po-earlier
> to po-later instructions under certain conditions.  However, a
> corner case currently allows instructions to be linked by ppo that
> are not executed by the same thread, i.e., instructions are being
> linked that have no po relation.
> 
> This happens due to the mb/strong-fence/fence relations, which (as
> one case) provide order when locks are passed between threads
> followed by an smp_mb__after_unlock_lock() fence.  This is
> illustrated in the following litmus test (as can be seen when using
> herd7 with `doshow ppo`):
> 
> P0(int *x, int *y)
> {
>     spin_lock(x);
>     spin_unlock(x);
> }
> 
> P1(int *x, int *y)
> {
>     spin_lock(x);
>     smp_mb__after_unlock_lock();
>     *y = 1;
> }

nit: for readability if not for other, s/int *x/spinlock_t *x/.


> The ppo relation will link P0's spin_lock(x) and P1's *y=1, because
> P0 passes a lock to P1 which then uses this fence.
> 
> The patch makes ppo a subrelation of po by letting fence contribute
> to ppo only in case the fence links events of the same thread.
> 
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea


> ---
>  tools/memory-model/linux-kernel.cat | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index cfc1b8fd46da..adf3c4f41229 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -82,7 +82,7 @@ let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
>  let to-r = (addr ; [R]) | (dep ; [Marked] ; rfi)
> -let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
> +let ppo = to-r | to-w | (fence & int) | (po-unlock-lock-po & int)
>  
>  (* Propagation: Ordering from release operations and strong fences. *)
>  let A-cumul(r) = (rfe ; [Marked])? ; r
> -- 
> 2.17.1
> 
