Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7298A67963C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjAXLKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjAXLKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:10:02 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17F56598
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:10:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b7so13517525wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4oKCI5ACpgbDZbAvlVer1995rjpFR6RmkMuuKT6A3o=;
        b=d1Loaglaq1QzepcSdJ41h/8RIHKpKQON8T+qUgeCMTb8OrEcODNIeZZytCF6prVWff
         Y8ARe9Dt05xV9y37CNn2XAbC7g7/1jpv4dl3RZnGjXcNrtF3q7SsrxO6PYgAz2tuGwzi
         MMq26m4kpE72qaB7nXNU8lBUyrQVjB+N8SeAt2vow9jgW1Nv2ufnW3Ws16s40aFxQoa9
         d8f8jv16d33JoqS96qXp8mT590Edg3it/iRPGrC1ieMa2dYoLbJb9IGDV7TayAu71iLc
         6IA5S1UsMgxQu0jgFsdYq5AQhwfmDhpJ9W7uHIVMbV/btNSLTW3qbiPDuQbMuKcLIqU3
         8rBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4oKCI5ACpgbDZbAvlVer1995rjpFR6RmkMuuKT6A3o=;
        b=GeIqDRfYlNDh0ID3cLwzaZHgLv9R7wHxTX3xhfTRdgNUm/iMPmXLiT0Ivs+fp9MNq1
         UtkV7VcBwNlR8ShnOTYgl7oCALyVyu73p4Nd+/G9xXViJl17pwgwS4IuthHNskSuHm+1
         TU+KdA0pTZhapNQaQC8rrl/6YzSZlfdj84eeA/imN9ltRR1GEPmj9ukrpeF7AtRC/CrF
         El+vKUHa2mo4R8JvuJS/qTThLU7c0xypq9KVR5nEHY9svC8TyYEnvIRVEGqn2nv3E1Bu
         9u0qMv03cSyG2mq0yCpcxGn7j0F115NNjXvQI+dbddNU9SaXkI5+eIIAIGXbJknFFHuV
         fDtg==
X-Gm-Message-State: AO0yUKUswlGH/w9DAj6T4RAqpaZQkBGO92XjNzsV3MePMr2XVTOk6wVJ
        u1trCFPDUH4+VPG/f6R44O4=
X-Google-Smtp-Source: AK7set/P7KQrEpcvED6ctNInHHpGpO2LOstaXvsZJ4RM8pJpdsOzcUr8oFDqnza+RCbgOjrm7eN+3w==
X-Received: by 2002:adf:e50c:0:b0:2bf:b33b:fb7a with SMTP id j12-20020adfe50c000000b002bfb33bfb7amr713615wrm.25.1674558598764;
        Tue, 24 Jan 2023 03:09:58 -0800 (PST)
Received: from andrea ([5.169.157.171])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d67d1000000b002425be3c9e2sm1589861wrw.60.2023.01.24.03.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 03:09:58 -0800 (PST)
Date:   Tue, 24 Jan 2023 12:09:48 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <Y8+8fH52iqQABYs2@andrea>
References: <Y8q6v3BZ8dlyoTxo@rowland.harvard.edu>
 <20230120175804.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8rff3HJ2o9wUyGT@rowland.harvard.edu>
 <20230120192032.GR2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8r7SBdfuZX/y1cd@rowland.harvard.edu>
 <20230120212037.GW2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y82dWEW4RwclDTGM@rowland.harvard.edu>
 <20230123201659.GA3754540@paulmck-ThinkPad-P17-Gen-1>
 <Y88/5ib7zYl67mcE@rowland.harvard.edu>
 <20230124040611.GD2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124040611.GD2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There is the one below, but I am (1) not sure that I have it right,
> (2) not immediately certain that the Linux-kernel implementation would
> forbid it, (3) not immediately sure that it should be forbidden.
> 
> In the meantime, thoughts?

As it stands, P0 to completion, then P1 to completion, then P2 to
completion should meet the "exists" clause; I guess we want "x=1"
in the clause (or the values of the stores to "x" exchanged).

  Andrea


> ------------------------------------------------------------------------
> 
> C C-srcu-observed-3
> 
> (*
>  * Result: Sometimes
>  *)
> 
> {}
> 
> P0(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	int r1;
> 
> 	r1 = srcu_read_lock(s);
> 	WRITE_ONCE(*y, 1);
> 	WRITE_ONCE(*x, 1);
> 	srcu_read_unlock(s, r1);
> }
> 
> P1(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	int r1;
> 
> 	r1 = READ_ONCE(*y);
> 	synchronize_srcu(s);
> 	WRITE_ONCE(*z, 1);
> }
> 
> P2(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	WRITE_ONCE(*z, 2);
> 	smp_mb();
> 	WRITE_ONCE(*x, 2);
> }
> 
> exists (1:r1=1 /\ x=2 /\ z=2)
