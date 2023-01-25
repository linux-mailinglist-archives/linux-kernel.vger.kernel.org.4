Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442E067BCB2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbjAYUgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbjAYUgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:36:32 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCF03F298
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:36:24 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y19so51549edc.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u4eR2LtK6JSyh3Q5RHhmM034T5UjI3kD0XYDbb7ZEds=;
        b=RZ2Rai8alR1i6fCvj0z381iQVjfI5jaNaqLXMhObpNnOtscrxNAD3c96J2JWPqXGMK
         lR4aLRUhP7DUMz6sPGRueeX4LQ99UplKWZr54huykBb4141vjUINoiptUGEYlFxX/bYf
         UpDBmfGBFr0VQAS437VlzD/mwY1C6Wmdeso7SSt9V19AbZFNVmk22T+fRAg17KJPAASF
         0SdxhsHyv+WJqZSH1kQe0snrEJvL/lsEjkyqSYXgmK6Al9WvArjeR7pCXgBbyVPOAk2D
         UnVfgbcXu1nR3t/R20cgXB/ej+sg76OztNITqtZqhRfhoniZzAqrKvP4DGei0IqJ4OI6
         mouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4eR2LtK6JSyh3Q5RHhmM034T5UjI3kD0XYDbb7ZEds=;
        b=IMK5NicTXXLgGI5ZOxlEvp29UI3t3kobdJ5Gi8jyt6NynUDwo+6pBVuR1titItVsSk
         X0Hs0A++HWVYnInWSXLhpDl9Dm0AfLuOnke11jz7re4haOrAxRH4Eai7wbn6HhQGptUu
         LJqs005dFdK4hslnUZQ0ULQMCipZw91IpytRVdMXU+KkjlVYzJLVyOSqHwJpQswXfdH1
         gW815WWl9BojvdYM92z/Lj0ZU92Vteno3b+ofSyVR6SnbqUOw2CMSTfdu3KhLDF82jXB
         uCl0sg55xQODeSiBEYn1PlArtm1FS2Q++/x1RX1smYKN65I+Pod4PeKm7v8eB/XvrXTn
         lttQ==
X-Gm-Message-State: AFqh2ko7HgBgrvaw3NEeTSujX3iIGVp/yriTmPCXjtF9IprC+kIaESDM
        pNjB0XoYwdRh5i9qmbYQUXE=
X-Google-Smtp-Source: AMrXdXt5TjJ0v7tfq5q0Y7mueGyQ0ye9CX05/lq/R2yOb8zyH0xKQgZTMORKRCYm9dgULdQmeBx4Sw==
X-Received: by 2002:a05:6402:100b:b0:462:6e5e:329a with SMTP id c11-20020a056402100b00b004626e5e329amr35382708edu.8.1674678982835;
        Wed, 25 Jan 2023 12:36:22 -0800 (PST)
Received: from andrea (host-87-14-222-101.retail.telecomitalia.it. [87.14.222.101])
        by smtp.gmail.com with ESMTPSA id q10-20020a056402518a00b004a08c52a2f0sm2414063edd.76.2023.01.25.12.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:36:22 -0800 (PST)
Date:   Wed, 25 Jan 2023 21:36:11 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
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
Message-ID: <Y9GSuzHFdRfLeAAp@andrea>
References: <Y9BdNVk2LQiUYABS@rowland.harvard.edu>
 <20230124225449.GY2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9CL8LBz+/mbbD00@rowland.harvard.edu>
 <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
 <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
 <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
 <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9F+SyLpxHwdK0rE@rowland.harvard.edu>
 <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Why do you want the implementation to forbid it?  The pattern of the 
> > litmus test resembles 3+3W, and you don't care whether the kernel allows 
> > that pattern.  Do you?
> 
> Jonas asked a similar question, so I am answering you both here.
> 
> With (say) a release-WRITE_ONCE() chain implementing N+2W for some
> N, it is reasonably well known that you don't get ordering, hardware
> support otwithstanding.  After all, none of the Linux kernel, C, and C++
> memory models make that guarantee.  In addition, the non-RCU barriers
> and accesses that you can use to create N+2W have been in very wide use
> for a very long time.
> 
> Although RCU has been in use for almost as long as those non-RCU barriers,
> it has not been in wide use for anywhere near that long.  So I cannot
> be so confident in ruling out some N+2W use case for RCU.

Did some archeology...  the pattern, with either RCU sync plus a release
or with two full fences plus a release, was forbidden by "ancient LKMM":
the relevant changes were described in

  https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/WeakModel.html#Coherence%20Point%20and%20RCU

  Andrea
