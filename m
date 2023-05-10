Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D43E6FE332
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbjEJRYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjEJRYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:24:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03455276;
        Wed, 10 May 2023 10:24:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8F6DE1F8B4;
        Wed, 10 May 2023 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683739452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kuetgIzwwu+7VqT/P0y7E9p5TtmeuKVCGagj0//uNXg=;
        b=YWD7wPAXrRp/wAp70Aa1nMiD75z2StfVsG9Y8R+nU0bqMuMoAr5bAEaUSEwT/kKxbx+ESo
        GNaaPHcFEEAievvqbVFjfWk174vWnNruT9gyxsZgbdyYUyTFKHJ8MEl3fwExMGzVNG5SE9
        tdntxfynuUo2gNbA/Abvbel7xUJBfmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683739452;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kuetgIzwwu+7VqT/P0y7E9p5TtmeuKVCGagj0//uNXg=;
        b=VMHcJ3ee1DpYaK0F65tjcDA8Jto+NLO6Hki7H5ikt768MwZWsEh38WEqMcvyEyJDDQlaDd
        iv7zegohShT4ASDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00F2213519;
        Wed, 10 May 2023 17:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hTFHLTvTW2SWDQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 10 May 2023 17:24:11 +0000
Date:   Wed, 10 May 2023 19:24:09 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 11/12] nvme/rc: Move discovery generation
 counter code to rc
Message-ID: <5mizvgs3mwoxbkgb3axuhgkmjjxa6svi4laksdccg3oue5fwf7@4mqtz2dm6phj>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-12-dwagner@suse.de>
 <4zt5oysmqw72l4xzfja2oer72hryisz6zzbboz7dmhhzfypuwx@yrf2utjkv66b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4zt5oysmqw72l4xzfja2oer72hryisz6zzbboz7dmhhzfypuwx@yrf2utjkv66b>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2023 at 11:34:51PM +0000, Shinichiro Kawasaki wrote:
> On May 03, 2023 / 10:02, Daniel Wagner wrote:
> > Move the discovery generation counter code to rc so that we can reuse
> > it in 002.
> 
> The last #12 patch no longer touches nvme/002, then I'm not so sure this patch
> is valuable. IMO, the lengthy 002.out has the role to check all of the 1000
> times discoveries are successful. So it looks the better to keep current
> nvme/002 as is.

While we don't update the counter anymore, I still think it's worthwhile to
do some cleanup. We have two tests which do the same thing so why not use common
code?
