Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E713669513
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbjAMLMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjAMLLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:11:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA33B4A1;
        Fri, 13 Jan 2023 03:05:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8992660307;
        Fri, 13 Jan 2023 11:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673607908;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Tw10lxq4j5R/zXZhZ75Omsd8NnJKx28l8uPE5JYkHQ=;
        b=X1r/ba8DCrKO9In7ntiuEZfcAahzgqmxiZ8ZfaW8Gz/Vl9g/HIWmMikc5XH3h/qe1bcOom
        cEtFnpVzCzJMZL+4fd4SEvc8URlwkbkgKw7uu2295DJ1XZNdbT93uF++vJPaztfKg9mRAn
        tMtax1miDHzCJyfwTTHmp+2aIExj/DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673607908;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Tw10lxq4j5R/zXZhZ75Omsd8NnJKx28l8uPE5JYkHQ=;
        b=tAXy3Gea1hiIMXSJHNn6g6wBUeBIpTpCUiDlZAqqDkacv5e0+jhJmbvdJ4OUU6GbZGQBiy
        BdLCP2olqVH+xgBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B7D11358A;
        Fri, 13 Jan 2023 11:05:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VpctGeQ6wWPXKAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 13 Jan 2023 11:05:08 +0000
Date:   Fri, 13 Jan 2023 11:59:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the btrfs tree
Message-ID: <20230113105932.GR11562@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230113103654.5cbc1d54@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113103654.5cbc1d54@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 10:36:54AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the btrfs tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> fs/btrfs/disk-io.c: In function 'btrfs_init_fs_root':
> fs/btrfs/disk-io.c:1531:22: warning: unused variable 'nofs_flag' [-Wunused-variable]
>  1531 |         unsigned int nofs_flag;
>       |                      ^~~~~~~~~

Will be fixed in the next for-next snapshot.
