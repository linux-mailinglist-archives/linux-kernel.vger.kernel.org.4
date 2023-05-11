Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F275F6FFC17
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239426AbjEKVul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjEKVuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:50:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82703A93;
        Thu, 11 May 2023 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xU7fZnVdzagYrmtjwdn7klJrvtP0zckutlKJ2V4cbrI=;
        t=1683841838; x=1685051438; b=qHPlL8XB5vgd1uyfiOgoEFiZgNWRPP8QqIEuGEsyVktlZkb
        w2BrNlDzB//uAFYqaEPVX6/y7yaqZ+f7IaMD5I3xh70oSFoJzrmXM5+lF2TrnwLSpZHPxc046Fm8G
        f80vpSyjDOTXGchiuDaqEylxr1TkEZygOJd3QKBKGkGmAWkn8LGBEtL1qastn5kgfMevvxDy+yeRl
        DtCTjQIi2tObpKSFk0Z+Ppa8Ae0nxoXDZu4OJPN5ivWqftzPaKZRVFCUDGIbUqDqMeJKHQYXhGkN/
        IskrPaQupjUKgwvhl73J7zBWPgLMkSLo8n+Xaf1GJWsRTkqQvGyCaUqRJW/MFmFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pxEBI-006fls-2U;
        Thu, 11 May 2023 23:50:36 +0200
Message-ID: <aa7a0e08edf6567db027058cd331dfae86f54e62.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 2/3] wifi: cfg80211: add a workqueue with special
 semantics
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 11 May 2023 23:50:35 +0200
In-Reply-To: <20230510220918.96de601f45f6.I28a06f59bf647db6dea519e6fca1894f94227d73@changeid>
References: <20230510201205.308542-1-johannes@sipsolutions.net>
         <20230510220918.96de601f45f6.I28a06f59bf647db6dea519e6fca1894f94227d73@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that I look at this more ...

> +static void cfg80211_wiphy_work(struct work_struct *work)
> +{
> +	struct cfg80211_registered_device *rdev;
> +
> +	rdev =3D container_of(work, struct cfg80211_registered_device, wiphy_wo=
rk);
> +
> +	spin_lock_irq(&rdev->wiphy_work_lock);
> +	while (!list_empty(&rdev->wiphy_work_list)) {
> +		struct wiphy_work *wk;
> +
> +		wk =3D list_first_entry(&rdev->wiphy_work_list,
> +				      struct wiphy_work, entry);
> +		list_del_init(&wk->entry);
> +		spin_unlock_irq(&rdev->wiphy_work_lock);
> +
> +		mutex_lock(&rdev->wiphy.mtx);

If I just change the locking here to take the wiphy.mtx before looking
at the list, which basically doesn't matter, then I don't even need
workqueue_pause() and all, nor do I even need a separate workqueue, just
schedule_work() will be good enough ... Just needs a _bit_ more work
when cancelling and here we should reschedule the work if the list isn't
empty after the first round, but overall that ends up far simpler.

So I think I'll drop the workqueue pause/resume the next time around,
FWIW.

johannes

