Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870E06C1D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjCTRR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjCTRQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:16:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367D520A33
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:12:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF50F1F385;
        Mon, 20 Mar 2023 17:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679332307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YqSNkzGSdpz0dCpuiv+8m3Z1Q+49YV56dDWSk8OLb8g=;
        b=uR+tVS6GiHTLAVTFF5EIEhvLo3/t37GYkxOnK/ecoA9BC4Q7GLrEPCQOlc9y8lWA2zWvM3
        WuKIoncMnlWAnosRJwTjaBzNvISO2VXVIj06VfKs1+pOjcUVHmslna3nNzG9Xv2gSwNOjJ
        x/x+VV6DjdfdGSkB0lNLtz5VklCFI4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679332307;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YqSNkzGSdpz0dCpuiv+8m3Z1Q+49YV56dDWSk8OLb8g=;
        b=gWFvW06LzCJv8YPrkKxpDyOs6WPeGaJ40hmWXWOteR9W7/ffovR+iAY51AbEcTgy+Rwc72
        q9kdx1yfSEHlX4Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C332613A00;
        Mon, 20 Mar 2023 17:11:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P1qfL9OTGGQNAwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 20 Mar 2023 17:11:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DCD23A0719; Mon, 20 Mar 2023 18:11:46 +0100 (CET)
Date:   Mon, 20 Mar 2023 18:11:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jack@suse.cz, jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: check for register_sysctl() failure
Message-ID: <20230320171146.ecqophvlz5hspmkb@quack3>
References: <20230320111229.a2zi3m5rszuhffwx@quack3>
 <20230320114029.76809-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320114029.76809-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-03-23 19:40:28, Yangtao Li wrote:
> > Well, but this is going to make system unbootable with
> > CONFIG_QUOTA && !CONFIG_SYSCTL.
> > Quota functionality actually does not depend on sysctl being
> > available so just continuing without sysctl is perfectly fine.
> 
> To be honest, I'm a little confused. Should we panic if quota
> registration fails, or should it depend on the user's cmdline
> parameters? Just like in the filesystem where we can choose
> whether to panic in case of exceptions.
> 
> Or, should we panic if registration fails when
> CONFIG_QUOTA && CONFIG_SYSCTL are enabled?

So I think that just ignoring the failure to register sysctl (as is
currently happening) is fine. Honestly, in practice this is not a likely
scenario so I don't think it matters much but if we wanted, we could print
a message that sysctl registration failed if CONFIG_SYSCTL is enabled.
 
> BTW, kindly ping for:
> https://lore.kernel.org/lkml/20230228103515.sb6qpvnmbvenvq73@quack3/
> 
> Not sure if you have forgotten to pick these two commits.

Yeah, sorry. Now picked up and pushed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
