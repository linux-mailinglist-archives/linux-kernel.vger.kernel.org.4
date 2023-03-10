Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108996B32F1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 01:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjCJAzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 19:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCJAzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 19:55:35 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC952F34DB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 16:55:31 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id ne1so2689211qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 16:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678409731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+uJ25jQ+MXikhQk+40cCXbpkdq02pm9Z8nSn09JPc4=;
        b=OAybaaeM9yb7q1OS2RJM//hJipMHt5TzwcfAUfPmrxGeQ+nJz0c+YpDgz5qP+tkz5y
         1q6JuS1iR2pqMe1ualukvZq7A8W+ghiTJqs+5v4Q7STkTteaknPHK/QHf3WgqPCybSJo
         k4GlfqWGh2ZXG2SSMhCqZuWyWF2838gkmWVtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678409731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+uJ25jQ+MXikhQk+40cCXbpkdq02pm9Z8nSn09JPc4=;
        b=bnoL6n3LufrFgNh8LHmo7jNbL93Y8axi3HNYFvhVtUuzLs6r14+OMHMd7bR1ouFoIn
         8CsnfZkj/r64JgxyPeQYSQr0VSMgTe+w6VE2YIOsUAr8BkRxVIb2SmlyK7ewqNgdJ/v9
         zBtFzsfbGimGOPYQDD/GNyp5XBqA9d/cQfDp0yvgDIcPCiEB7JYtoibMR/ZAxY9FXaKc
         MaN8NzbeUnOIieM3cme857wDN4eTFXUOgbmy9OA3jVmXY7bmwME+5uXS/WF2HMlNJz4Z
         Esv1DbDkwMPLjzJVCTi7NYNjt6k9SJWVU2o95Z1vBGDTH83mb9n6YBwe8hRIFywtnjQ6
         nXUg==
X-Gm-Message-State: AO0yUKUQu6f672QDoToLLNcwcQVvM37E/flBXLIuzsPFJQX18Wqf5XAo
        5h8MGFlO32vt3Hl7k7UOyDE6iA==
X-Google-Smtp-Source: AK7set8CY2LJIqzBMBqGQ6iHnL0EIZbfa2k6lpmGNjPR7f+vGT6J0SlINuNgn0GupBAs2CyAsQahfw==
X-Received: by 2002:a05:6214:29ef:b0:56b:fa99:7866 with SMTP id jv15-20020a05621429ef00b0056bfa997866mr38258901qvb.7.1678409730734;
        Thu, 09 Mar 2023 16:55:30 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id l17-20020a37f911000000b0074281812276sm297141qkj.97.2023.03.09.16.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 16:55:29 -0800 (PST)
Date:   Fri, 10 Mar 2023 00:55:29 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 07/13] RDMA/rxe: Rename kfree_rcu() to
 kfree_rcu_mightsleep()
Message-ID: <20230310005529.GA339498@google.com>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-8-urezki@gmail.com>
 <ZAnjnRC1wY3RIFhM@pc636>
 <ZAnpdKV/VvvX0TZz@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAnpdKV/VvvX0TZz@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 03:13:08PM +0100, Uladzislau Rezki wrote:
> > On Wed, Feb 01, 2023 at 04:08:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > The kfree_rcu()'s single argument name is deprecated therefore
> > > rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
> > > underline that it is for sleepable contexts.
> > > 
> > > Please check the RXE driver in a way that a single argument can
> > > be used. Briefly looking at it and rcu_head should be embed to
> > > free an obj over RCU-core. The context might be atomic.
> > > 
> > > Cc: Bob Pearson <rpearsonhpe@gmail.com>
> > > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > Could you please add you reviwed-by or Acked-by tags so we can bring
> > our series with renaming for the next merge window?
> > 
> > Thanks!
> > 
> __rxe_cleanup() can be called in two contexts, sleepable and not.
> Therefore usage of a single argument of the kvfree_rcu() is not correct
> here.
> 
> Could you please fix and check your driver? If my above statement
> is not correct, please provide Acked-by or Reviwed-by tags to the
> path that is in question.
> 
> Otherwise please add an rcu_head in your data to free objects over
> kvfree_rcu() using double argument API.
> 
> Could you please support?

Also this one needs renaming? It came in because of the commit in 6.3-rc1:
72a03627443d ("RDMA/rxe: Remove rxe_alloc()")

It could be squashed into this patch itself since it is infiniband related.

Paul noticed that this breaks dropping the old API on -next, so it is
blocking the renaming.

---8<-----------------------

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b10aa1580a64..ae3a100e18fb 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -731,7 +731,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		return -EINVAL;
 
 	rxe_cleanup(mr);
-	kfree_rcu(mr);
+	kfree_rcu_mightsleep(mr);
 	return 0;
 }
 
