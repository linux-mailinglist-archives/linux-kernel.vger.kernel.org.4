Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969906C5A12
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCVXLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCVXLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:11:15 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065A912073
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:11:00 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id q88so6918348qvq.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679526659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZL9DTkjJb3n7mVTugZ10aveYNAwV6wrK6ovdb1S8+U=;
        b=Sp2gAFF8dlEY31YXpKbaZ5LvO1GdLwUEwLbSBAy/GF6nVrO9pbuMGmPsFuR0Bmve/K
         +xYN2xH96sEAdsGyVf7noFv8C+mAKfBOp91ilP6Xt9ieqmJhcT22SsTQiRAkK54/vmQO
         Z3tPd89q5efOTSLIQF6Ddi2IV7xClqkmxx4KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679526659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZL9DTkjJb3n7mVTugZ10aveYNAwV6wrK6ovdb1S8+U=;
        b=PPrCh52oybAOMiAgKm7PugJPaZbFhHO0EfYkHfsPqEBz8NUviS9cOVkMwBtcl5lVxC
         pXUh0c9h6RYgEn7RAHMHWBASeU3211VHmaCdvVO07+nZqjJeKVZCNhNRy5bZvo3tLO1i
         LFVRbNEQ4OBnqGOhbTehAK2y+LzDBCCl/uFVSeyDb5J7UPobGVSGaQmOQpjNJe59zPyb
         okwn7LypheHWaGwbPjlw8DTtPB1Z6GWZ1k1gGzn/1pbLhhzQitbdVTiyaUCU10/h7AKn
         J3K6rIcMPFPpreYh/wufJ9E5e+sbVojUZzDVcsyEoIPvH72SCd3qeznNl4GXXiqp0RJW
         DdLQ==
X-Gm-Message-State: AO0yUKWA/lkZ0XaATEAUKnCL3MIX+Ghgj4KPybnAPw39R7cU4p//Auq3
        lnOU1eaUiAlrKfr5knaBHAKHhA==
X-Google-Smtp-Source: AK7set85SVCDnzLXoJqV79SCI/o/OWtkO+89+dvJ14a/nmtvtF1SE+n//pr3tLilVxb7494mv34sVw==
X-Received: by 2002:ad4:5cc8:0:b0:5b2:fb2:4b1d with SMTP id iu8-20020ad45cc8000000b005b20fb24b1dmr10245615qvb.12.1679526659115;
        Wed, 22 Mar 2023 16:10:59 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id p17-20020a374211000000b007428e743508sm12183990qka.70.2023.03.22.16.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 16:10:58 -0700 (PDT)
Date:   Wed, 22 Mar 2023 23:10:58 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 04/13] tracing: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Message-ID: <20230322231058.GA70593@google.com>
References: <ZBNYogVe9spBmTm2@pc636>
 <70A3066E-3B61-4B81-B36D-69BC27DAD5E9@joelfernandes.org>
 <20230318121131.3a9cc1ae@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318121131.3a9cc1ae@rorschach.local.home>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 12:11:31PM -0400, Steven Rostedt wrote:
> On Thu, 16 Mar 2023 14:01:30 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > If so, Steve please send a patch when you are able to and with Vlads Ack,
> > we can take it via the RCU tree if that is Ok with you.
> 
> Daniel acked it, so you can just take it as he can be responsible for that code.
> 
> For the trace_probe.c if you get an ack from Masami, then you can take
> the original patch as is.


Masami, do you Ack the changes of the original patch to trace_probe.c ?

Here it is again:
https://lore.kernel.org/lkml/20230201150815.409582-5-urezki@gmail.com/


thanks,

 - Joel

