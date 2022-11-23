Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D19635C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbiKWMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbiKWMJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:09:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478ECBE3D;
        Wed, 23 Nov 2022 04:09:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F25091F6E6;
        Wed, 23 Nov 2022 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669205394;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OsAPnooUFhOrFu+T5/f/ZOlG5JygCkY86Xmb+dQVbcI=;
        b=SmC18lK269kZm4rG09peKbwjH8tVVGUSqJ5oMNXT+bIbZkKjVd0h/d9/10jhLB5nPMxLsf
        FrAKgTYas8BmQrLTv8WPdSqrc4Mmzt2zt7++kUghoXqbxpS1pG5lgMbfbTnKAddZBMUlzy
        QIcHnMX2jCn0YX0lymf1nYl53Ot750w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669205394;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OsAPnooUFhOrFu+T5/f/ZOlG5JygCkY86Xmb+dQVbcI=;
        b=mgZ0nooaq3mYGjIgOC8h5/83H59mBvN6urE4J+hyGpaFQiHpj+HcU8WBrPKme23gzwmHGv
        I2YJu37r80lt+sBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBB6913AE7;
        Wed, 23 Nov 2022 12:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D3zCMJENfmPcXQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 23 Nov 2022 12:09:53 +0000
Date:   Wed, 23 Nov 2022 13:09:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Boris Burkov <boris@bur.io>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the btrfs tree
Message-ID: <20221123120923.GK5824@suse.cz>
Reply-To: dsterba@suse.cz
References: <20221123081726.140b18d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123081726.140b18d1@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 08:17:26AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   e60fd7bf12f2 ("btrfs: fix improper error handling in btrfs_unlink")
> 
> Fixes tag
> 
>   Fixes: 6a1d44efb9d0 ("btrfs: setup qstr from dentrys using fscrypt helper")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: aa8270bea38f ("btrfs: setup qstr from dentrys using fscrypt helper")

Thanks, I thought I had squashed the commit e60fd7bf12f2, but apparently
not so the original reference became stale. Now fixed.
