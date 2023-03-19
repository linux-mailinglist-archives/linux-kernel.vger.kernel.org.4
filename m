Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8B16C0590
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjCSV33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjCSV3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:29:06 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788091F490;
        Sun, 19 Mar 2023 14:28:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DA915320091A;
        Sun, 19 Mar 2023 17:28:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 19 Mar 2023 17:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679261294; x=1679347694; bh=+n
        bSnyLU6yl2KmpB/zPsJtib/REyWaxwDq6pNd+Q7og=; b=PuS5eKn/GnNNDUlmXF
        3tKhtb6SErYLbFTjOMwB7MiS0EQECE/eT1YBtTpys7f1NydKzj4RpIP/P3E5BF3m
        DsoR1rt6fJVl+yFmZkogf2emMeypZYtOSh6onkDssKmHit24JXcx4zB7NCT9QGWT
        rnBM7xYKw4y1Kowo5h+71HrAUYBB3VdQmQiV1pSmNxT987t4zuLXoomzQQ5PUf/3
        EfVUElEpVvKaaImTNpK5c+z3w9fPO074sV2KQnSFWVy6rW/XRkKcfgeIxDKvP2NZ
        e/vvZfY5en4DpJYBWbgBVi6sO+2TQofjZpt0/LJQYVO2FRNzwDcn7YX8aAnwu6ji
        yQow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679261294; x=1679347694; bh=+nbSnyLU6yl2K
        mpB/zPsJtib/REyWaxwDq6pNd+Q7og=; b=eVyRyTFDKWvZYcV2wR6Ph3WDSUUv2
        2gb54Y/4sDhE/oHHOk5AHGcMiNiFsCa2+B2ejFrRSUuKdzMlWvd+DQz44S6MqcYs
        T7H8YpMpgOQL+ceSeIYgK6+b+teJhy5pbDg7aUd3ixnBmCVjC53hQQy6Ad3rMFWY
        ItfwJfEOnjhTfXqyyYC6tqif19bglDPL/wEq4T+mCqx3EiInIcahnlF+cJr3wKJ6
        qIM4haH31EIFYZYXcdIhq22HwTHdns0pEMIKQlH07OwR6cKAxaWjpCCYkcWDg1dE
        FawhJ2uFNyLCGpxBmoOFqfoFFBNSneS0fJzx0cxybx0O8U43F1fHgnx2Q==
X-ME-Sender: <xms:bn4XZI3Fg7N0TDC9ttp2OwK9xCdg5089H6TiW_lTIWP4emUEl16tNQ>
    <xme:bn4XZDHniX7MsFfgcOyePdyaqZkzX8GkzGxUot-xZwRttrbMqHi-lpoPPWbFjrKPG
    2ckhg6V5EMXta97208>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefiedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:bn4XZA7O-VzK5RR4lHueT9u478y-cBCKityWJ5wtwdVwJPfAGHyGrg>
    <xmx:bn4XZB28SGNKqixB8gJLle1Dpp8eMnxH9tcY3YN0ljTTNkOiKLZtQQ>
    <xmx:bn4XZLHq-WuPwIH323-Fu7OztBG4KJQvFxB9yQEhcVN2g-OSy_JhNQ>
    <xmx:bn4XZAQ9W7vIdP4BbMjqc4sp4yZ7PWTUlzGwvhCTA3TcLBZ5-MnOzA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1B698B60086; Sun, 19 Mar 2023 17:28:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <53e4c004-003a-47dc-9376-06c2571e0ae9@app.fastmail.com>
In-Reply-To: <20230320082323.61889e67@canb.auug.org.au>
References: <20230320082323.61889e67@canb.auug.org.au>
Date:   Sun, 19 Mar 2023 22:27:52 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Olof Johansson" <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023, at 22:23, Stephen Rothwell wrote:
> Hi all,
>
> Commit
>
>   41341224e4fd ("ARM: mmp: remove obsolete config USB_EHCI_MV_U2O")
>
> is missing a Signed-off-by from its committer.

Ok, thanks for letting me know. I've pushed out
the fixed soc/arm branch and the for-next branch now.

for-next still has both the broken and the fixed
commit until I regenerate it.

      Arnd
