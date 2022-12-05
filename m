Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B01642B7B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiLEPUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiLEPTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:19:07 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70639DE80
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=MTyipn3/uiEaeHK3wKKsTALavbnGCjUvVFxs3KzPAMY=; b=TCe9/re9gJhq+wUcGBja5Ga82O
        M9vzBgSKe8uRc3bwCrVBnOXzTwsxltkc8HlrOvpBAVjdjAgfOOdgVdOjeEOUjMsX9Z1ikn0URqApN
        G9JMIJnhI4e9haiK3bjeATKWgCuhwc+AdHii1hFmRLkHq2BGxmNTBaZj3bihyjgg/PKUd9H0f+bWg
        0oel4oAbJCsd9WIjZyce5echdrsRVbwiw5NxPzDsPwGjJFmfT0rYSeqYwCFVU0JsTBFfMD14LXlbE
        oa19yvg8nDJBXh3kIBtbAyEimP1eG8+Jv9bFaP0pljwoiMVWYycqONtfCXCyt885qAgSM2NmPROJb
        ys4u2uP9bGuyxjcm5vHSasVtVbbx/lEAin2cs5vxtc3FZR0yxGvPeHLNz/ofZgnOd9bA2P6dN3/OI
        ZIZZ7XazRXQPySk6iBTE3gXYbcMU0RQ8yjTT942o1UV8Hdq95O1wBRnAgQDw8KT9fH7czaUxPt72B
        A4uS7RPDvri42FpnNJWjwhde8dVUiViP+W+rk35BxTM5CVM8IbK6rDmYZjKYJoyN4lOYZb9fG+Zh/
        kXQN01j1kFrfODFSaYTrl1VY4jeavuh+T62eglUXWdPsLtot+TAf3RQ7Mw2zt2x6rOAA//qR4aPnX
        pIjFoFIpGFwuDvfctuwijO12E59xEGTu3C+7ZFSeo=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] 9p/client: fix data race on req->status
Date:   Mon, 05 Dec 2022 16:19:01 +0100
Message-ID: <3368929.hG1Ktuj5m1@silver>
In-Reply-To: <20221205124756.426350-1-asmadeus@codewreck.org>
References: <20221205124756.426350-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 5, 2022 1:47:56 PM CET Dominique Martinet wrote:
> KCSAN reported a race between writing req->status in p9_client_cb and
> accessing it in p9_client_rpc's wait_event.
> 
> Accesses to req itself is protected by the data barrier (writing req
> fields, write barrier, writing status // reading status, read barrier,
> reading other req fields), but status accesses themselves apparently
> also must be annotated properly with WRITE_ONCE/READ_ONCE when we
> access it without locks.
> 
> Follows:
>  - error paths writing status in various threads all can notify
> p9_client_rpc, so these all also need WRITE_ONCE
>  - there's a similar read loop in trans_virtio for zc case that also
> needs READ_ONCE
>  - other reads in trans_fd should be protected by the trans_fd lock and
> lists state machine, as corresponding writers all are within trans_fd
> and should be under the same lock. If KCSAN complains on them we likely
> will have something else to fix as well, so it's better to leave them
> unmarked and look again if required.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

I must have missed the prior discussion, but looking at the suggested
solution: if there is no lock, then adding READ_ONCE() and WRITE_ONCE() would
not fix cross-CPU issues, as those would not have a memory barrier in that
case.

Shouldn't that therefore rather be at least smp_load_acquire() and
smp_store_release() at such places instead?

Best regards,
Christian Schoenebeck



