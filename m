Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD43617CE3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiKCMo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiKCMoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:44:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C806F101EF;
        Thu,  3 Nov 2022 05:44:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d26so4822390eje.10;
        Thu, 03 Nov 2022 05:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1DVWcK/fPvxwYKjOU/YI+rXNMZdzDbCW84zWy8prE4=;
        b=H5fIzf9eK0AjkszI67lchy3AV48ysJKI18cu/KsnSygYiagzdB6hDcxlgV644EbUOf
         xWuKOLU8GHJDkJy4wjcIe6JNzEzbc+idLVlioTCdwuzQIFmB/cXPVV8RVHK+vfenkWSr
         gC2LPzyXDP5xn3nUgfJPCYPOqniYMH4ZovzOSevgIUEVjU2NMpj/TWittDGuN8zicnvX
         dgnVa29c/HMfcJ2krTNMdflND3jUIGd8epI21piYQUAS6LLnJuTRkWhxrUQXWpqEf8dl
         4VhrnIRMC89N8vAp2ChrXfuTxpWgPmPIMVs40iZSt5D9ZZjqzMBQW6FtHllwn9wmu0d2
         Ob4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1DVWcK/fPvxwYKjOU/YI+rXNMZdzDbCW84zWy8prE4=;
        b=0ewwAQJPZN1O0DmQ6hOTRKrquV7nVenYEoYSlmUqAZPKvgFa5Uy+a1lDplI0Af3mPB
         EXDSR98jgoZe1Wgq46pXwb7c2hsFNTJciMBC9V33p6WN4+vLrLBCjd4tuKsIz2yANuIF
         Wm5hQusvUKs0Wfi+LVO6zZIn3GlgURyC9EvypE8+zuV9W1SsPyc+VmHWPwdd3KFkRa60
         d6Li+n+aNgDDGK+scrQyDhzq3CCiFW3f9oyfCwo6yjQTHqjqWfr2TEenaMB0adTnatys
         BTVf/Eqj0jQwvG2sAO0ypFs6BAZpeIwF5tNUWCodnoSc8Wpb3oddlwxldrq9bcVkhZno
         mKoQ==
X-Gm-Message-State: ACrzQf0t8L843a463C1kHh1ll1Eu8+LMOZebHFkzcJ5xL8f2E1w0Ujlw
        8fdTfe6yqMs/2bRGh1IkiPE=
X-Google-Smtp-Source: AMsMyM5QaKNutgTeV3yG2v5UgXmJ9MxmPLRixJKR5Md9zyqeXWU6KmQDHm0pJmMonDg7w3EQmuQSPQ==
X-Received: by 2002:a17:907:97d5:b0:7ac:5f72:6c1a with SMTP id js21-20020a17090797d500b007ac5f726c1amr28561297ejc.126.1667479493163;
        Thu, 03 Nov 2022 05:44:53 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id p23-20020a056402155700b004615e1bbaf4sm460429edx.87.2022.11.03.05.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:44:52 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 3 Nov 2022 13:44:51 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y2O3w3d3qmTg6VAP@pc638.lan>
References: <20221102184911.GP5600@paulmck-ThinkPad-P17-Gen-1>
 <755B5ED1-653D-4E57-B114-77CDE10A9033@joelfernandes.org>
 <20221102202813.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ+SxBoNUkPHhC3O0DJNQtZomN_4GPtvaWuDs5sSU4FAw@mail.gmail.com>
 <20221102223516.GT5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102223516.GT5600@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > Though I am thinking, workqueue context is normally used to invoke
> > code that can block, and would the issue you mentioned affect those as
> > well, or affect RCU when those non-RCU work items block. So for
> > example, when other things in the system that can queue things on the
> > system_wq and block.  (I might be throwing darts in the dark).
> > 
> > To be safe, we can implement your suggestion which is basically a form
> > of my initial patch.
> > 
> > Should we add Tejun to the thread?
> 
> Let's get organized first, but that would be a good thing.  Or I could
> reach out to Tejun internally.
> 
> For but one thing to get organized about, maybe kfree_rcu() should be
> using a workqueue with the WQ_MEM_RECLAIM flag set.
> 
It can be as an option to consider. Because such workqueue has some
special priority for better handling of memory releasing. I can have
a look at it closer to see how kvfree_rcu() works if it goes with WQ_MEM_RECLAIM.

--
Uladzislau Rezki
