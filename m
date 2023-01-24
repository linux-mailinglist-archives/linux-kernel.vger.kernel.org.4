Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB83167936D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjAXIrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjAXIrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:47:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F4A3A878
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:47:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87C0B21A16;
        Tue, 24 Jan 2023 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674550023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lCCPo/qZKUgkl1A1uwAl5uAdTqTdM1xEfDlBTbLn/sw=;
        b=PS0to3KIyVNOqVWaWb8uciLw2/AD8C5Raxn2gNJyjC04sN09tsS5RzuvUpY2j8/CPPR3YI
        JFArz3piz9mR3niFZXA91+/m1Uv3odaDimFTcWobJsd1Ue0pth41U9pJ34yI90UBL3dCqD
        hcb+kOOP80to2jRCGv4XBiCVLqzUs5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674550023;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lCCPo/qZKUgkl1A1uwAl5uAdTqTdM1xEfDlBTbLn/sw=;
        b=JkUvuLLU8hka+YKOB8vSvoeEtCLcXyG56fTKgupelAVsoa6PylVlU53q9xr/oVJD0fnVFn
        LAmjQ7aXymiAkBAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7144113487;
        Tue, 24 Jan 2023 08:47:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yp+iGwebz2NSOwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 08:47:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 65E57A06B5; Tue, 24 Jan 2023 09:47:02 +0100 (CET)
Date:   Tue, 24 Jan 2023 09:47:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Vladislav Efanov <VEfanov@ispras.ru>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] udf: Check return code from udf_update_extents
Message-ID: <20230124084702.xew5wmbvmj6gz4j6@quack3>
References: <20230120091028.1591622-1-VEfanov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120091028.1591622-1-VEfanov@ispras.ru>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20-01-23 12:10:28, Vladislav Efanov wrote:
> udf_add_aext() does not create new extent and returns ENOSPC if new
> block was not created by udf_bitmap_new_block(). The caller,
> udf_insert_aext(), does not check this return code and returns OK to
> its caller(udf_update_extents). Finally the error is being lost. So
> an inconsistency in inode.i_size and extents length becomes.
> 
> Later this inconsistency leads to WARNING:
> 
> WARNING: CPU: 3 PID: 1104 at fs/udf/truncate.c:226
>         udf_truncate_extents+0x7e0/0x8e0 fs/udf/truncate.c:226
> 
> RIP: 0010:udf_truncate_extents+0x7e0/0x8e0 fs/udf/truncate.c:226
> Call Trace:
>  udf_write_failed.isra.0+0x173/0x1c0 fs/udf/inode.c:179
>  udf_write_begin+0x8d/0xb0 fs/udf/inode.c:214
>  generic_perform_write+0x20a/0x4e0 mm/filemap.c:3333
>  __generic_file_write_iter+0x252/0x610 mm/filemap.c:3462
>  udf_file_write_iter+0x2cc/0x4e0 fs/udf/file.c:168
>  call_write_iter include/linux/fs.h:1904 [inline]
>  new_sync_write+0x42c/0x660 fs/read_write.c:518
>  vfs_write+0x75b/0xa40 fs/read_write.c:605
> 
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>

Thanks for the fix but I have a very similar fix already queued in my tree
in linux-next: 19fd80de0a8 ("udf: Handle error when adding extent to a
file").

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
