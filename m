Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F02749B5D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjGFMHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGFMHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:07:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C081726;
        Thu,  6 Jul 2023 05:07:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C7D221DEA;
        Thu,  6 Jul 2023 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688645229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A6CSdnWoHNwfH4kj12EMC7KfnLYNWpmURNF30/yrN+g=;
        b=hy57rb9Aa0kmR9Oh5ZsHhxr/R1DCQFjEsTU4FrlPUH+krueOoG6ESYIt1VjXW/oxUB7hEk
        Vsp5Qm6yg7kC1ZLcyAh9XIPY3Iy6JRUjYH7O6BDsv+sIsynud6qu+EP9BnV0uFiUrzDR+M
        Z2XhHOUJeN+zbYTxxANeAZjFOnkf6MU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688645229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A6CSdnWoHNwfH4kj12EMC7KfnLYNWpmURNF30/yrN+g=;
        b=yJ7gydxHy8JaOUPrLu4a7gjy+YgzsJuhq4bX1+ZxeOXKg+2BcWqmlvUaJCmXwJkpL2mZgF
        yMpJ5OqQjNWdvHCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D90E1390F;
        Thu,  6 Jul 2023 12:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YNuiAm2upmRyLAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 06 Jul 2023 12:07:09 +0000
Date:   Thu, 6 Jul 2023 14:07:08 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Ewan Milne <emilne@redhat.com>
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Message-ID: <7kcc75btp5bo5oqjnpqlwwo37l2f4atwfemknbmvqagrqicl2i@njn4tai7e4m7>
References: <20230620133711.22840-1-dwagner@suse.de>
 <20230620133711.22840-5-dwagner@suse.de>
 <594f73f2-59b0-bbcb-d7a0-6d89e2446830@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <594f73f2-59b0-bbcb-d7a0-6d89e2446830@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Sat, Jul 01, 2023 at 05:11:11AM -0700, James Smart wrote:
> As much as you want to make this change to make transports "similar", I am
> dead set against it unless you are completing a long qualification of the
> change on real FC hardware and FC-NVME devices. There is probably 1.5 yrs of
> testing of different race conditions that drove this change. You cannot
> declare success from a simplistic toy tool such as fcloop for validation.
> 
> The original issues exist, probably have even morphed given the time from
> the original change, and this will seriously disrupt the transport and any
> downstream releases.  So I have a very strong NACK on this change.
> 
> Yes - things such as the connect failure results are difficult to return
> back to nvme-cli. I have had many gripes about the nvme-cli's behavior over
> the years, especially on negative cases due to race conditions which
> required retries. It still fails this miserably.  The async reconnect path
> solved many of these issues for fc.
> 
> For the auth failure, how do we deal with things if auth fails over time as
> reconnects fail due to a credential changes ?  I would think commonality of
> this behavior drives part of the choice.

Alright, what do you think about the idea to introduce a new '--sync' option to
nvme-cli which forwards this info to the kernel that we want to wait for the
initial connect to succeed or fail? Obviously, this needs to handle signals too.

From what I understood this is also what Ewan would like to have.

Hannes thought it would make sense to use the same initial connect logic in
tcp/rdma, because there could also be transient erros (e.g. spanning tree
protocol). In short making the tcp/rdma do the same thing as fc?

So let's drop the final patch from this series for the time. Could you give some
feedback on the rest of the patches?

Thanks,
Daniel
