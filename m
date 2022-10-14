Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D82D5FF525
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJNVTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJNVS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:18:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A581D0658;
        Fri, 14 Oct 2022 14:18:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D387221B9;
        Fri, 14 Oct 2022 21:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665782335;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+TCaQ540EPlXNGS4Chc6NGWohA+QlBQOvH68/+BJkiI=;
        b=m50QE4YrHygzGZ2j/DIhUrQmESWB6sam+JX02SMDHdGwaov1wayXLw7lWSxkkCE59JcS9G
        NoMGqF+GNd8UDta50o3dIjeJDBcs/NwPhyP1xI3ompnAHKqM2FzFRf7t0IoM1RVLpH1h7e
        oBo3RUE37sw8DRwkoE2WbLYUMToonUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665782335;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+TCaQ540EPlXNGS4Chc6NGWohA+QlBQOvH68/+BJkiI=;
        b=LQpPIxNTgWdJf1BCjIbWMx3jzZE8usWU93KNFlfC3D7y301yPbx+QteyRoW2CdhFmgMYzC
        EzgDpZr0zFN2/KDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D247113A4A;
        Fri, 14 Oct 2022 21:18:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HzukMT7SSWPafQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Oct 2022 21:18:54 +0000
Date:   Fri, 14 Oct 2022 23:18:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: fix single directory build
Message-ID: <20221014211847.GL13389@suse.cz>
Reply-To: dsterba@suse.cz
References: <20221014201811.1118103-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014201811.1118103-1-masahiroy@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2022 at 05:18:11AM +0900, Masahiro Yamada wrote:
> Commit f110e5a250e3 ("kbuild: refactor single builds of *.ko") was wrong.
> 
> KBUILD_MODULES _is_ needed for single builds.
> 
> Otherwise, "make foo/bar/baz/" does not build module objects at all.
> 
> Fixes: f110e5a250e3 ("kbuild: refactor single builds of *.ko")
> Reported-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Now it works, thanks.

Tested-by: David Sterba <dsterba@suse.com>
