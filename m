Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD4B6CD6B7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjC2JoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC2JoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:44:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F0E9B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:44:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E2BC01FDC3;
        Wed, 29 Mar 2023 09:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680083049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ig6sqEZUrYn/QAvnNzag4XDKU7oCgIVDyMP94kyTyUw=;
        b=mMEQjGmOUAbSDbllnpzbEJzevfkxfb9g6gM5+iO9pAn8zfBqif/sNFECmZzTq+rmOzIGDR
        7b5mJtlqF9gaecEeM8q5y5UNd9h+JfyyRy+scYfff1Lqmj5MJkViiKnXWYH3GrKeUeCSML
        rMFiAAYiRnTdlqhlBd6PX+7RCrnLuDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680083049;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ig6sqEZUrYn/QAvnNzag4XDKU7oCgIVDyMP94kyTyUw=;
        b=yKDdmpat9gOhjC6Rb1B7ZnLXpxmtrjxmcjH7789s3TpG6KjdJtpwC///YYCtg764jCsAIq
        V5MZRnx63zpTbjDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9F9A138FF;
        Wed, 29 Mar 2023 09:44:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G3BXLWkIJGRRDwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 09:44:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B94EAA0729; Wed, 29 Mar 2023 11:44:07 +0200 (CEST)
Date:   Wed, 29 Mar 2023 11:44:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Jan Kara <jack@suse.com>,
        Yangtao Li <frank.li@vivo.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Dave Chinner <dchinner@redhat.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Baokun Li <libaokun1@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: quota: avoid unused function warning for
 !CONFIG_SYSCTL
Message-ID: <20230329094407.cpypyfqdwrf7egco@quack3>
References: <20230328122244.2521387-1-arnd@kernel.org>
 <ZCMoZMftUgg7Mrv2@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCMoZMftUgg7Mrv2@bombadil.infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-03-23 10:48:20, Luis Chamberlain wrote:
> On Tue, Mar 28, 2023 at 02:22:31PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > Note: it may be better to just revert the 63d00e08515b patch, as the
> > -#ifdef CONFIG_SYSCTL
> > -	if (!register_sysctl("fs/quota", fs_dqstats_table))
> > -		pr_notice("quota sysctl registration failed!\n");
> > -#endif
> > +	if (IS_ENABLED(CONFIG_SYSCTL)) {
> > +		if (!register_sysctl("fs/quota", fs_dqstats_table))
> > +			pr_notice("quota sysctl registration failed!\n");
> > +	}
> 
> I'd agree to drop that patch and instead just use register_sysctl_init()
> iwht Arnd's strategy.

Ah, indeed, register_sysctl_init() is exactly what we need here. I didn't
know about that helper. Thanks for letting me know.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
