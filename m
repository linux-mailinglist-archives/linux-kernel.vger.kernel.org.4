Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6F63D610
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbiK3M41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiK3M4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:56:23 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417AC4AF1E;
        Wed, 30 Nov 2022 04:56:22 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f13so26787487lfa.6;
        Wed, 30 Nov 2022 04:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4n4Rmn2+hL+sb6SthagDvmYUmd9v80kaLiVhP5QVD3s=;
        b=hM2C/JJipHE0NssqshaieloPzbqX2890mUlJ93k/KB7RbHCP9Eoe2x60we3Icoe0Vw
         akTJgj85AlCEVJAp9R9lBae24DOQQg1I31SGIYxtqAg8y1U0O0j0yXCZP+7K+Owumthf
         X1GODKixGcox2f8NCUzC5n8ewnp8bOBGzEFu8Zhwwy1nmZ0ZgL3ENFNZhlhbwdbWTCQ5
         oN0L9JXiSVF09ub4e1wfK1M7RCu6xYpdBKBLGvERUubhYnSRO+AMqcxB9Bh3ctc6Onmu
         l5BPBNelx9jGHLa9FF8KdFFt1d0+/blNlTXy1V2vcMhdQ7ZDY0M1kxX4WCko5TF1HExn
         TdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n4Rmn2+hL+sb6SthagDvmYUmd9v80kaLiVhP5QVD3s=;
        b=19SYepF2d3l3knvTQdw6ma3FPMMP1m4J+036KbVS5E14YLbNIb4ke9A5rDfTiDs/Gp
         PSkvnV4ikTP7idZQHzoPjq50rp7yZjFnLrmd94w8uh4HcqD0YA2NoX9YHMAhfqeJ8Dh9
         auj3fPKKlab3NKWFkGd6DXzjvhXdKv3WqXXQEIyhxRSOmw0yPCm2nYPWfk33m5wfuWFI
         2xjA8FI1w8xu2yao83+mE85ZJXxB3YClk1/M2uxT7L4mD2chZDcb+hoh3Ms9vm0PFNhn
         rk2ngHOE7y1mA4OQ4QUpnS5bh4zH/625HUwP3njbgQmgj5TFBEz+H3uSSOxM4yBx1CgB
         qVMg==
X-Gm-Message-State: ANoB5pkuJ3FNQpLWZQLcHYlCTkIRm6XQYCqETmx/ALdeXieF0qbiI9Ac
        AD/Sn0U6GMMpWTIobSK4lG4=
X-Google-Smtp-Source: AA0mqf6AtLceB37mD91TwgSsjTW1So+gjiWnxbsmWjercUyyO8pkkaoWj6LbCijX3kDE7ZX+hccRyQ==
X-Received: by 2002:ac2:4d4f:0:b0:4ae:2436:818c with SMTP id 15-20020ac24d4f000000b004ae2436818cmr19365933lfp.346.1669812980354;
        Wed, 30 Nov 2022 04:56:20 -0800 (PST)
Received: from pc636 (host-90-235-25-230.mobileonline.telia.com. [90.235.25.230])
        by smtp.gmail.com with ESMTPSA id g5-20020a2eb5c5000000b0027781448499sm125715ljn.85.2022.11.30.04.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 04:56:20 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 30 Nov 2022 13:56:17 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 3/4] rcu/kvfree: Move need_offload_krc() out of
 krcp->lock
Message-ID: <Y4dS8X+Ir7egYBTD@pc636>
References: <20221129155822.538434-1-urezki@gmail.com>
 <20221129155822.538434-4-urezki@gmail.com>
 <20221129233833.GA154809@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129233833.GA154809@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 03:38:33PM -0800, Paul E. McKenney wrote:
> On Tue, Nov 29, 2022 at 04:58:21PM +0100, Uladzislau Rezki (Sony) wrote:
> > Currently a need_offload_krc() function requires the krcp->lock
> > to be held because krcp->head can not be checked concurrently.
> > 
> > Fix it by updating the krcp->head using WRITE_ONCE() macro so
> > it becomes lock-free and safe for readers to see a valid data
> > without any locking.
> 
> Don't we also need to use READ_ONCE() for the code loading this krcp->head
> pointer?  Or do the remaining plain C-language accesses somehow avoid
> running concurrently with those new WRITE_ONCE() invocations?
>
It can be concurrent. I was thinking about it. For some reason i decided
to keep readers as a "regular" ones for loading the krcp->head.

In this case it might take time for readers to see an updated value
as a worst case scenario.

So i need to update it or upload one more patch on top of v2. Should
i upload a new patch?

Thanks!

--
Uladzislau Rezki
