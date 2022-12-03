Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083306418A5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiLCUPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLCUPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:15:50 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558881C431
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 12:15:47 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id ay32so921308qtb.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 12:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B/AEv8iOuQcHXjiDxVYoVxL1UQJyViE9h9B1gaIqSa0=;
        b=Cx/n/Xr8KSW6ERq+sGaS1PpfNqfNITiNFLNfdP0bHEu5mS15d8EB/GfgCq/+8atMB5
         twQto8mQPQbDmNu4HBYnqgF46LG/YrE+IRLZ8Qlzb3hHMHbh/BqOy1508TvH+q1E5o66
         8p2bAKFbOgUX8ZqGGp9Prkvjmqa/b1zTN0JJUawuCQezi4AyOy+vmeY0vbjPncLBnuzO
         GVVNw0pm3+dbbGv1pLgwqN7/nJRRFQ80TqDgqiY14ueon3nO0MZjFAXUsfB5hT7/79Zk
         QfsGBG2zHgZrHJw0HRLtVvkf9OerobadcMHCsKPOj5cxSfx2Ofa7xG+MIuNkPVr69Qfe
         cWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/AEv8iOuQcHXjiDxVYoVxL1UQJyViE9h9B1gaIqSa0=;
        b=7gO9YgtvaTBD49MgMBV6FbqkcXyUfxsgQ9B239VICKvQ5XbSwJVEnZp1VN9IGTCK4u
         D6Lt8vDnhjKEPo2eszXG2q37RAD7FyJwcN0feVOfTzEj28qY3tNyHJ1JA0EsKzCEyQFI
         vjzm48TboasB2mrviRWN30KtmrKV0IekN284/oY4ZWhttHBV0ir5liP0rREnyK89SLdp
         ghhOq91CSgLgJ3i0D8IMU7n/h2RzMGKRBhXEslLpdY35dImJlp3UMffwYdK2tG+GwahJ
         rMtRXSRK5KFdyQkBaQW4mAD8imEc+JzMHbZVHvu5Jn6c7EXx4asB1/iXsSEnbDPR1Xm+
         koIQ==
X-Gm-Message-State: ANoB5pn6vD8fpTBrG2ponVAkbczr6xKo3XO++pwD1o6AqSqV6LWmRqD5
        4J02NQMwEnqvzsTbhw44mKQ=
X-Google-Smtp-Source: AA0mqf50a2vkWerBtBV/3hecxcLLFnJJBfICx/iNwiSw/lYlHfxRLocCKu44T0YFclV99J4e72btgA==
X-Received: by 2002:ac8:743:0:b0:397:92e9:a517 with SMTP id k3-20020ac80743000000b0039792e9a517mr69414151qth.56.1670098546413;
        Sat, 03 Dec 2022 12:15:46 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id bi13-20020a05620a318d00b006fb0e638f12sm8772687qkb.4.2022.12.03.12.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:15:45 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2017227C0054;
        Sat,  3 Dec 2022 15:15:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 03 Dec 2022 15:15:45 -0500
X-ME-Sender: <xms:b66LY7FwAbVA3uvmoqApWlyfrRbb1_bcbpEMY4ySG9Wr-joeR-pzSw>
    <xme:b66LY4Ud_gXCqv1PfM4zdREg6XJ8cFAQ2jV79bi01Umct78uqq4r6FDONA7GLI6yg
    casPXzs1v-HwIcBJA>
X-ME-Received: <xmr:b66LY9JntF8S1io1_YTAhI8B8ZZyLdo4RBANJQ14WBg9KhnSOOLSYdHTvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtgddufeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepfffhkeekvdelkeffkeffteeljedvhedvgedtueehudfhveetledvteff
    veffhfevnecuffhomhgrihhnpehstghhvggurdgtohhmpdihohhuthhusggvrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgv
X-ME-Proxy: <xmx:b66LY5FMkusmKIIGqC7r6KIw6bQUsm9VcSEEVxS5rp1LcZF8BDGrZA>
    <xmx:b66LYxWkBE4bTvG23PHF5EImO73_2lJCSyddViAfq0wVj3u1CMqxMw>
    <xmx:b66LY0NXp12k_hzETFIWsXZBlQ8tFRqZlz7yfxF3lpx3HIJSnT6nsg>
    <xmx:cK6LY7ZtfdmlhL8GfhfDgs9No67sbB-ZchMJt4DgwDNLL5bpfj_mhg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Dec 2022 15:15:42 -0500 (EST)
Date:   Sat, 3 Dec 2022 12:14:29 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools: memory-model: Make plain accesses carry
 dependencies
Message-ID: <Y4uuJS6dAuRT7t6r@boqun-archlinux>
References: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
 <Y4pIwqK7SWft1xCl@boqun-archlinux>
 <4262e55407294a5989e766bc4dc48293@huawei.com>
 <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 11:02:26AM -0800, Paul E. McKenney wrote:
> On Sat, Dec 03, 2022 at 11:58:36AM +0000, Jonas Oberhauser wrote:
> > 
> > 
> > -----Original Message-----
> > From: Boqun Feng [mailto:boqun.feng@gmail.com] 
> > Sent: Friday, December 2, 2022 7:50 PM
> > 
> > > > Reviewed-by: Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > > s/Reviewed-by: Reviewed-by:/Reviewed-by:^2 to save some space ? ;-)
> > 
> > 
> > Oh, I didn't know I'm allowed to compress things like that! Can I use ² as well to save another character?
> 
> Heh!  I might miss that, and who knows?  The bots might think that "²"
> was the first letter of your name.  ;-)
> 
> > > I wonder is this patch a first step to solve the OOTA problem you reported in OSS:
> > >	https://static.sched.com/hosted_files/osseu2022/e1/oss-eu22-jonas.pdf
> > > If so maybe it's better to put the link in the commit log I think.
> > 
> > It's not directly related to that specific problem, it does solve some other OOTA issues though.
> > If you think we should link to the talk, there's also a video with slightly more updated slides from the actual talk: https://www.youtube.com/watch?v=iFDKhIxKhoQ
> > do you think I should link to both then?
> 
> It is not hard for me to add that in if people believe that it should be
> included.  But default is lazy in this case.  ;-)
> 

I brought this up because, as we recently experience in RCU code, we
need answers of "why we did this?" to the future us ;-)

I agree with Alan, this seems like a good idea, but having some big
picture of why we do this may be better.

Regards,
Boqun

> 							Thanx, Paul
