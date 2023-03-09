Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4B76B3037
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCIWLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCIWK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:10:59 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F055F6024
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:10:58 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id op8so2447353qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 14:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678399857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWhT84CK6LOvh74niMhTS7YujYkiY2d3+6ptF98Dgak=;
        b=rz5prbdOcEyLdpQBMKt0TOvKzC2C/IfVp0Km9x1EhHRqM08tce38j3WxOXADVaO2Nb
         udadLQ3IORYDH5B7MFJXp7Rm07MksreX7YK0mrMUQul1pOqDvNvs3p0Dasdxsxq3G1Us
         Xs0HspJ+tjRRIvhQS+EiRpkd3FMuGKUJojft4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678399857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWhT84CK6LOvh74niMhTS7YujYkiY2d3+6ptF98Dgak=;
        b=Upj+/UF6YLcMZpmK5cEN9ZSpudyDBScyhPBp9KB5LvZ6bf1Myd3Lyrm3jDxBXFhe3j
         ePXDW0Gu7JhizBA3pKuaKu+8x7WTmKKcHQByNIR1eckF06DlJg++fQk20Bz86P86gVMp
         FhlIQ1R/fR9PPym4VJwvEmrO7jMl5896/oq78ObQUF4HJVlUxGdeDYqTdsPPWJ46Kzqg
         a0Y28GcNEOUTXMohV4/AIEciYum9O+/ht/usw3tKERsWXdWfhRlgkUoN9z1ZJMV4R7GJ
         Brs94zfnjS08iRleK0iVdflqcAt0l8KAKT+uT3n83wTcIALtjWMZweBdc65EXfozX5LY
         L4HA==
X-Gm-Message-State: AO0yUKUw+n5SEq2yRmGVpsTTO0zQfL0V+Gkykg+OnRtrOPZl+Ro0wWRO
        6LNwGDDbcZFprX/df337lxFdzg==
X-Google-Smtp-Source: AK7set/IkaMJWra/Hd4Ec5D5NNMfYHcNZHJCeHl5jb4VMObRe9L2a42goReF50PoPRF6RkjXLf6FLQ==
X-Received: by 2002:a05:6214:2263:b0:56b:f1f7:c67f with SMTP id gs3-20020a056214226300b0056bf1f7c67fmr41522345qvb.6.1678399857362;
        Thu, 09 Mar 2023 14:10:57 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id r9-20020a374409000000b00741a8e96f25sm54780qka.88.2023.03.09.14.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 14:10:56 -0800 (PST)
Date:   Thu, 9 Mar 2023 22:10:56 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <20230309221056.GB148448@google.com>
References: <20230303213851.2090365-1-joel@joelfernandes.org>
 <ZAc1wsvd4trjP/xi@lothringen>
 <ZAc+vVZUhXdhpSki@pc636>
 <CAEXW_YRTLQpQpOW-+n+X59pmB=4TkV=gdsMiQfBkdK_4wO9Jug@mail.gmail.com>
 <20230307173313.GJ1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230307185443.GA516865@google.com>
 <20230307192726.GL1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAhYP9a8u05hzsOn@pc636>
 <20230308144528.GR1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAnXxr9OyFT63xSx@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAnXxr9OyFT63xSx@pc636>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 01:57:42PM +0100, Uladzislau Rezki wrote:
[..]
> > > > > > See this commit:
> > > > > > 
> > > > > > 3705b88db0d7cc ("rcu: Add a module parameter to force use of
> > > > > > expedited RCU primitives")
> > > > > > 
> > > > > > Antti provided this commit precisely in order to allow Android
> > > > > > devices to expedite the boot process and to shut off the
> > > > > > expediting at a time of Android userspace's choosing.  So Android
> > > > > > has been making this work for about ten years, which strikes me
> > > > > > as an adequate proof of concept.  ;-)
> > > > > 
> > > > > Thanks for the pointer. That's true. Looking at Android sources, I
> > > > > find that Android Mediatek devices at least are setting
> > > > > rcu_expedited to 1 at late stage of their userspace boot (which is
> > > > > weird, it should be set to 1 as early as possible), and
> > > > > interestingly I cannot find them resetting it back to 0!.  Maybe
> > > > > they set rcu_normal to 1? But I cannot find that either. Vlad? :P
> > > > 
> > > > Interesting.  Though this is consistent with Antti's commit log,
> > > > where he talks about expediting grace periods but not unexpediting
> > > > them.
> > > > 
> > > Do you think we need to unexpedite it? :))))
> > 
> > Android runs on smallish systems, so quite possibly not!
> > 
> We keep it enabled and never unexpedite it. The reason is a performance.  I
> have done some app-launch time analysis with enabling and disabling of it.
> 
> An expedited case is much better when it comes to app launch time. It
> requires ~25% less time to run an app comparing with unexpedited variant.
> So we have a big gain here.

Wow, that's huge. I wonder if you can dig deeper and find out why that is so
as the callbacks may need to be synchronize_rcu_expedited() then, as it could
be slowing down other usecases! I find it hard to believe, real-time
workloads will run better without those callbacks being always-expedited if
it actually gives back 25% in performance!

thanks,

 - Joel

