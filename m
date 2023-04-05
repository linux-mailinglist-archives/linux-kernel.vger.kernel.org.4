Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BF56D77D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbjDEJKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbjDEJKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:10:48 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C4B30F8;
        Wed,  5 Apr 2023 02:10:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q16so45705811lfe.10;
        Wed, 05 Apr 2023 02:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680685843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m5eGS81xIRzLVimyFVJHz1me2KIfa7Aw0JDi4lE6yBw=;
        b=TbCR88LIwsj+xunQFMt8mYgULUxfDkMgKE704G9q8TE7up5QaiL3uV0TuVe7A1EAme
         l1C4HfppATuridvxmMYvFEcdU6dlgjOFjL+VtQEFN3b+m+tTpIAe7/25wPFSzhlFvIyQ
         Sjeu9j2PjeDpsYI97wiDXx9nEtCNeUDBJclyEfPei+so20voQiqeOTlYC4ZvJmakq9dM
         PYY2LVGSZNw0fL/F4xgf9RINzkRqwkGFHhIMkM9SOWMXHm1gPVY3O+90P+sM2hOS6vBd
         8c7xZATz8lSKLxJwFuxFiwfFbfA6Sj/7nX4xQ3+VEBK5DyeDsfEOWNCbz1dyEPvvgQm5
         eDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680685843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5eGS81xIRzLVimyFVJHz1me2KIfa7Aw0JDi4lE6yBw=;
        b=6boarZeUNvA+2Mv5i9WZszZ3In1QoOeYwIl5NRNOphIyy+BkIWfHACohiOVB1193oo
         VZI4HW3nxloA2KarrKwrA0fb1lFBWVmrBam1wReWDB/51oC0oZbRzOypPG68//Ymh4v2
         0JhVDK2DvSfAiRQ3waoBU83h7RJr6HOOulcl3Q/4RJsyYP/1bNYoMdagqgSVesN9re+J
         tJQmbHvlKImkzGpTvugOeKEAIvbnmQeAy6mvjmG9z6pjwMaDu7e17igRuGFFG7jlckWG
         J17NBzuYeogDBU1t8+48ym73SMhSd9M8rascQdvZa/zNdc5BOjjr9jh2UOok3lPE2YGw
         Doow==
X-Gm-Message-State: AAQBX9ecy4mVzsXhtikZuThWI6RMixavdz7w5b/AcYFPlX7aemVU0Hzg
        kihGeowOynr0VOVrwZt4T1E=
X-Google-Smtp-Source: AKy350b4K3jar6nPjP8Wefj/hXUqqcReTrTgL118VOV452uc4quiQbvnwrzxkzB+7r26cGDjjB2FyA==
X-Received: by 2002:ac2:4294:0:b0:4e8:44a5:6018 with SMTP id m20-20020ac24294000000b004e844a56018mr1371310lfh.44.1680685842747;
        Wed, 05 Apr 2023 02:10:42 -0700 (PDT)
Received: from pc636 (host-90-233-209-177.mobileonline.telia.com. [90.233.209.177])
        by smtp.gmail.com with ESMTPSA id l14-20020ac2554e000000b004e811e3554dsm2756772lfk.185.2023.04.05.02.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 02:10:42 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 5 Apr 2023 11:10:39 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        RCU <rcu@vger.kernel.org>, quic_neeraju@quicinc.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/1] rcu/kvfree: Add debug check of GP ready for ptrs in
 a list
Message-ID: <ZC07DxeqllxP2Zpv@pc636>
References: <20230404141300.908202-1-urezki@gmail.com>
 <f92cb016-b978-40ab-b025-bf2410b0537d@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f92cb016-b978-40ab-b025-bf2410b0537d@paulmck-laptop>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 05:00:13PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 04, 2023 at 04:13:00PM +0200, Uladzislau Rezki (Sony) wrote:
> > Triiger a warning if a grace period is not passed yet for
> > objects queued on a linked list via rcu_head structures.
> > 
> > Once detached, take a full snapsot of GP sequnces to check
> > later that a grace period is passed and it is safe to free
> > all pointers.
> > 
> > Based on latest 'dev' branch.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Very good, thank you!
> 
> I queued the patch wordsmithed as shown below for review and further
> testing.  Please check for any errors.
> 
> How should we go about testing this code?  The way that it would get
> exercised in production would be during an out-of-memory event, correct?
> 
Either by flooding kfree_rcu() calls by many threads or simulate a
low memory condition. I applied i high pressure using 1 000 000 frees
by 64 kthreads on 64 CPUs system.

IMHO, we have two GP checks, one for bulk and another one for list
and it looks like enough at least from my point of view.

--
Uladzislau Rezki
