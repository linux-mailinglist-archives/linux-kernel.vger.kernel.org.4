Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CE4734CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjFSHzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSHzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:55:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19560FA;
        Mon, 19 Jun 2023 00:55:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B877B2188E;
        Mon, 19 Jun 2023 07:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687161314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzodxslVWR34FWKTezh8R+HCLqkf9hKJ6nwhZ2cYyW0=;
        b=eNlw2lEdFwRO24qHwcZk6RTiyPfPkFK/qnznneFVO8rBVp3e+AZ/aqo7cxuiWUi7UZx3/u
        vkV2Xoh4sMJjXcH5IJeusAnX5mWTuVn8oi5gpUC4jlQYE+YlD/QdEUarmKV36IYMkRGmVb
        scGcJ9MfBs7nhXYSgMCL6L2HxVXQ96Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687161314;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzodxslVWR34FWKTezh8R+HCLqkf9hKJ6nwhZ2cYyW0=;
        b=5dGQ0ErR9rr16jt9qdW7WZcepprWjTCTT6S4BuS9s9Siz9XZJXBmmJ4JbJ68RjM0Wj1Dsm
        qnkil/Q7ipU84tCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A99C3139C2;
        Mon, 19 Jun 2023 07:55:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3PtfKeIJkGRQBgAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 19 Jun 2023 07:55:14 +0000
Date:   Mon, 19 Jun 2023 09:55:14 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v1 0/2] nvme-fc: Fix blktests hangers
Message-ID: <iek6a3eegnjirapsuw2jtptxttgor2e4bvoljlr2swqwzagso5@b7k5kq6j2ab2>
References: <20230615094356.14878-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615094356.14878-1-dwagner@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:43:54AM +0200, Daniel Wagner wrote:
> A couple more fixes to enable blktests for the fc transport.

I let run blktests in a loop and eventually the unloading of the fs module
blocked again with

      nvme_fcloop: fcloop_exit: Failed deleting remote port
      nvme_fcloop: fcloop_exit: Failed deleting target port

So the reordering of the module unloades in blktets just made it a bit harder to
hit but it's still possible to hit this. So we should also consider

https://lore.kernel.org/linux-nvme/20230418130159.11075-2-dwagner@suse.de/
