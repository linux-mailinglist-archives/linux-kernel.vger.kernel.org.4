Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB206C107C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjCTLPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjCTLOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:14:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADFF4C1F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:12:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9DCF21B71;
        Mon, 20 Mar 2023 11:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679310749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fMu9OffZX526pQrNBQvCNvgPtFd7h9D0cKj/XO+Ga+I=;
        b=HAer1enapI6ghlon68EOdykvbWSbTTUrQ//6JU+h+OnSAa4tgUVSHn1yrgEY5j6McikzeM
        GUNkX96Udvb7+GCN3bsJdsgVM4kEVbBDfFNR6S9Tg492f5PPxsI6n7gDhGKIvQyL5sOX8M
        zaTxZYpmYQ2oLazETy5G3Z8qMDZaPH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679310749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fMu9OffZX526pQrNBQvCNvgPtFd7h9D0cKj/XO+Ga+I=;
        b=LCLu0eGVS4WfTU1H1aBLmp9ir6TYfsayxhO6oZPz3tbJci6cDauIG5ic19UJv6JfCjCagy
        9X3pqfIw4i8qBJAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D856413416;
        Mon, 20 Mar 2023 11:12:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tOfENJ0/GGQtLQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 20 Mar 2023 11:12:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 46107A0719; Mon, 20 Mar 2023 12:12:29 +0100 (CET)
Date:   Mon, 20 Mar 2023 12:12:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: check for register_sysctl() failure
Message-ID: <20230320111229.a2zi3m5rszuhffwx@quack3>
References: <20230318160640.48461-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318160640.48461-1-frank.li@vivo.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 19-03-23 00:06:39, Yangtao Li wrote:
> register_sysctl() might fail, call panic() as with other failure
> checks in this function if register_sysctl() failed.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

...

> @@ -2955,7 +2955,8 @@ static int __init dquot_init(void)
>  
>  	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
>  
> -	register_sysctl("fs/quota", fs_dqstats_table);
> +	if (!register_sysctl("fs/quota", fs_dqstats_table))
> +		panic("Cannot register dquot sysctl");

Well, but this is going to make system unbootable with CONFIG_QUOTA &&
!CONFIG_SYSCTL. Quota functionality actually does not depend on sysctl
being available so just continuing without sysctl is perfectly fine.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
