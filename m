Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B646958BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 06:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjBNFzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 00:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBNFzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 00:55:13 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18471193C4;
        Mon, 13 Feb 2023 21:55:12 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id m12so16457456qth.4;
        Mon, 13 Feb 2023 21:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdJ9fniFiMZtLhBdU1wXemK+Te/gfkmtRDd7mbpe/aw=;
        b=Vrweeo9uMQ3b/QHWBD46fjgJJsq6/b/QDXTo5slP9tdnlEQ+cPF+BdszvEzDiOq56p
         gNS0HA6NTxaprzln+0H6wgVXH0sN/tGTXKDBuNgz6TU1LAqm1xfksUMN+TH+SSA9MDWy
         2JDaMr1i/VCA5juuiwSvT2I8rvMd+OazwiGGPdRnyhsJN2lMzB0JV07vcV8V8aipUTKE
         Onb+WKefS42Hztv08RH5XCJipWNgNU6/Pw83WKrvv6op9uzHscWQZxq/11akmRiOcdkj
         7egbGj/FGPz0VZqKfRIkAwrmVeRLDYTzdcvsYm/3qqNgaFr+SBhaFf58L3q80koxsSCX
         p5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdJ9fniFiMZtLhBdU1wXemK+Te/gfkmtRDd7mbpe/aw=;
        b=E1H3NywTS3v1c78/Q0pHNNrfdlcyjk5R4fJrC1Qka87JwmzD9+SCd8vWZF6X2lhcO5
         HTmjcg2LPOnn9IrskXdb2/Q1LipCGCS/aj0KWPgxXLTgxvLhVFnzJjropSIP3xrqSiGq
         XHuo78f89nfXZJUZh4stQVkMHFadYg5lC14iBLBcIZCCdDAy9IByZlQrLPECbc0fn5C7
         Vf/LDbTCfvOSBNkAkeNmVdrqIErPF5ow7aoXM9xunyrnFsCbUnsT0WGzMkZNU0X8KFXL
         Wk6T0/AXRXq7IT9y53FAEoB47cfVrSyNGweJWDtT/sj0j8oJ3kZUtprRED1TqKN3EJ0k
         pcgg==
X-Gm-Message-State: AO0yUKWDhHEGQCiUpk9Ie7zjleLmIB5nKVAl8xSHebrSmZpX/s35bLe1
        tsGyQok5A7FFV6cJBAazTZE=
X-Google-Smtp-Source: AK7set+wO1qqpoo/DkAMSvwPKVT/5IouHMAQyS4njpu1DL+o3BJB29itHdPu38mfLiTMFJQrEUVquw==
X-Received: by 2002:a05:622a:208:b0:3b8:6c68:6109 with SMTP id b8-20020a05622a020800b003b86c686109mr1787435qtx.21.1676354111181;
        Mon, 13 Feb 2023 21:55:11 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j8-20020ac85c48000000b003b9b41a32b7sm10792582qtj.81.2023.02.13.21.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 21:55:10 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0B84527C0054;
        Tue, 14 Feb 2023 00:55:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 14 Feb 2023 00:55:10 -0500
X-ME-Sender: <xms:PCLrYyn0Ye0pUOiSnjWFk5z96zMsGTHZ7PJNGYqkXd6LP6Svs2zYQA>
    <xme:PCLrY53n0_8XVTgIt_uxk_nTvdCbIGvt2MsjRMbUL5RzR3ufz8v0VF936jO-pG57V
    1VysT2r2QggIZOIXA>
X-ME-Received: <xmr:PCLrYwoEbfH8BPIZslp6FvqZTpEwayL3yiPvsEArs4CY7nYWhP1D2jpv0-rOQwilgfLqb8SF1E6wyxSEXIa6JOQbt2kQ0sXum6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeivddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:PCLrY2kgJ2dnhHXUVvqU_felNFJgjg5yaSR3QoiUF2h1if1F0Feg1Q>
    <xmx:PCLrYw3n1j3ZOlswQu_D5wIF4DKm3iSsxNwsT0015lD0Xp2d7CRYJg>
    <xmx:PCLrY9uq-C6iicybtnjIO5fgggyTncBOfRKWtCNDmz9J7ZtAJak16w>
    <xmx:PSLrY1sqS6huNKqQC00jc5-bwFwtMEaEtfSuO6_WwHOyIT_GOw9Z4A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Feb 2023 00:55:08 -0500 (EST)
Date:   Mon, 13 Feb 2023 21:55:06 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+siOolJeC10k5D3@Boquns-Mac-mini.local>
References: <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+oBveWO2z6xdTW/@hirez.programming.kicks-ass.net>
 <Y+pWhyFJeE93nlWd@rowland.harvard.edu>
 <Y+plfZnEqw6mG+XH@hirez.programming.kicks-ass.net>
 <Y+rpD7QPheQQ8Lxj@boqun-archlinux>
 <Y+rr4p6njVOTSYxs@rowland.harvard.edu>
 <20230214052733.3354-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214052733.3354-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:27:33PM +0800, Hillf Danton wrote:
> On Mon, 13 Feb 2023 18:09:16 -0800 Boqun Feng <boqun.feng@gmail.com>
> > On Mon, Feb 13, 2023 at 09:03:14PM -0500, Alan Stern wrote:
> > > On Mon, Feb 13, 2023 at 05:51:11PM -0800, Boqun Feng wrote:
> > > > Basically if you have two lock instances A and B with the same class,
> > > > and you know that locking ordering is always A -> B, then you can do
> > > > 
> > > > 	mutex_lock(A);
> > > > 	mutex_lock_nest_lock(B, A); // lock B.
> > > > 
> > > > to tell the lockdep this is not deadlock, plus lockdep will treat the
> > > > acquisition of A and the precondition of acquisition B, so the following
> > > > is not a deadlock as well:
> > > > 
> > > > T1:
> > > > 	mutex_lock(A);
> > > > 	mutex_lock(C);
> > > > 	mutex_lock_nest_lock(B, A);
> > > > 
> > > > T2:
> > > > 	mutex_lock(A);
> > > > 	mutex_lock_nest_lock(B, A);
> > > > 	mutex_lock(C);
> > > 
> > > Why isn't this treated as a deadlock?  It sure looks like a deadlock to 
> > > me.  Is this an example where lockdep just doesn't get the right answer?
> 
> Syzbot reported deadlock[1] with A ignored.
> 
> [1] https://lore.kernel.org/linux-mm/20230130073136.59-1-hdanton@sina.com/
> 

Right, I think that's a false positive, however it's not related to
mutex_lock_nest_lock(). Anyway mutex_lock_nest_lock() cannot help that
case since these are three different lock class.

Actually, reading the code again, I think I made a mistake, for
mutex_lock_nest_lock(), the following *is* a deadlock to lockdep:

T1:
	mutex_lock(A);
	mutex_lock(C);
	mutex_lock_nest_lock(B, A);

T2:
	mutex_lock(A);
	mutex_lock_nest_lock(B, A);
	mutex_lock(C);

and this *is not* a deadlock to lockdep:

T1:
	mutex_lock(A);
	mutex_lock_nest_lock(C, A);
	mutex_lock_nest_lock(B, A);

T2:
	mutex_lock(A);
	mutex_lock_nest_lock(B, A);
	mutex_lock_nest_lock(C, A);

The current semantics of _nest_lock() is tricky, it only provides the
"nest" effect if it is the next lock acquired after the "parent" lock.
Maybe we can change and make it clear a little bit to make it more
useful.

Ah, actually someone found it 7 years ago:

https://lore.kernel.org/lkml/20150810095247.GA4606@fixme-laptop.cn.ibm.com/

;-)

Regards,
Boqun

> > Because A serializes B and C, so that particular piece of code doesn't
> > cause deadlock. Note that you can still use you normal mutex_lock() for
> > B, so if there is more code:
> > 
> > T3:
> > 	mutex_lock(C);
> > 	mutex_lock(B);
> > 
> > lockdep will report deadlock.
> > 
> > Regards,
> > Boqun
> > 
> > > Alan Stern
