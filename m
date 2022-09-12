Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662625B638A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 00:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiILWSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 18:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiILWSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 18:18:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24A152834;
        Mon, 12 Sep 2022 15:16:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q9so420466pgq.8;
        Mon, 12 Sep 2022 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=HMsg24DgWn9pseOs15nZNZF3gasImsq/1+/HBiMz7zM=;
        b=XeejMlKnn3k/2+rKlg10fHdnnRTFqpQ2qV/ohuVnxt0athlfrrjaf/erEApEmGsURA
         tuwdkBLoruW/fmik1lzCqKnCibQ8uTe1aX86X4z//2Rc83RuYX4aN3bSaVaTm0YDbnYY
         61rlLNCH/b6xnXgXyev+idVVGAr1NSo/qgYYqcrTqgF7PKKHylECsXzFxq0EPV9psGDz
         iqluN5WfpnJ9ItbrJqx71wrluVtXNDGPYQhomfgbvA2xVFe3Y1lB2Rp5CDZgEzzWqBIe
         jm0wc2YvTPLhDXnq6W1LR8Q+r0aFo+tZL6m6pRYLivZG02n6X9E2/tH5argszecAxjec
         3Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HMsg24DgWn9pseOs15nZNZF3gasImsq/1+/HBiMz7zM=;
        b=VYoXNVclaiKh0VL/SQTj7bYPPf9vm2yZAGChIgOVNHw1JefO7Y2gE4gQvWxDN/hzp5
         0iJyrzl2dVePxIB2Zd5bJODJ4U7uUE2rscfgYm8EtqZK+EteXusABJQIPdJIqAImlWXV
         Ibr5eX2Oms5xdLafbb0iSAXolj7p/OhO2xdQBEF8pyzE3M5uzFlytDUcaJ2Rfbhrxu6h
         1+DzlDTmm/sBMssbNnBtMdVRjk/Y4bkAvIsTOBk+DHejXDYMZ0qhWc/NK0tPEoWDSRLQ
         +QYXHP+qZf2n8MRuC4WtZeeTd7mDF+cUoA26QrSurCCx5Sy3k8UXSs5vKMFd3nqqxAKp
         cJSg==
X-Gm-Message-State: ACgBeo0vVh2nB4I7AXQNsNtnlsXaVON07C6k6ELo6Om5YXH13g1dXmpz
        LGU0T0MkD4gCBB5fee/Mbiw=
X-Google-Smtp-Source: AA6agR62BngsLBHv6tGuYOzt7emkERNocqceIsWr3JBR9rcG2Fakapt2kwpnC44iHIcT3qGAagiJ7g==
X-Received: by 2002:a62:3384:0:b0:538:58ab:8fee with SMTP id z126-20020a623384000000b0053858ab8feemr24409123pfz.7.1663020994100;
        Mon, 12 Sep 2022 15:16:34 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id bd7-20020a656e07000000b0041c35462316sm6037455pgb.26.2022.09.12.15.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:16:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Sep 2022 12:16:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the cgroup tree
Message-ID: <Yx+vwLUYNl4U3IAv@slm.duckdns.org>
References: <20220912161812.072aaa3b@canb.auug.org.au>
 <Yx7iEv/wy5Olgu0M@hirez.programming.kicks-ass.net>
 <Yx9+IIQqizUB/DJu@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx9+IIQqizUB/DJu@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Sep 12, 2022 at 08:44:48AM -1000, Tejun Heo wrote:
> On Mon, Sep 12, 2022 at 09:38:58AM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 12, 2022 at 04:18:12PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the cgroup tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > 
> > Hmm,. TJ should I base sched/psi on top of drivers-core-next and your
> > cgroup tree?
> 
> Yeah, this is kinda nasty. Lemme just pull drivers-core-next into
> cgorup/for-6.1 so that folks don't have to worry about this and you can just
> pull that one.

I initially thought that driver-core-next was conflicting with
cgroup/for-6.1 but this is simpler. It's a straight forward conflict between
the PSI patchset in the tip tree and changes in cgroup/for-6.1 which are
cleaning up some cftype handling, and the patch that Stephen applied is
correct. So, we can do one of the following two:

1. Leave it as-is. Stephen's patch is correct and we can just let Linus know
   how to resolve it on the pull requests.

2. Pull cgroup/for-6.1 into the tip tree and preemptively resolve the
   conflict there.

I'm leaning towards #1 but #2 is fine too. Peter, what do you wanna do?

Thanks.

-- 
tejun
