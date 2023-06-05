Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5367229CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjFEOwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjFEOwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:52:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BB4102
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:52:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6AE2D21B69;
        Mon,  5 Jun 2023 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685976728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KJ5Vvn/f/LcaLzfrsc9YEqYfn9KBb8ZzT6iAUABQLqA=;
        b=ir/MmgDg8dXjmB0MsVdXPBkcm3ypWRUbDpVoUSEK4ekRixxn6k+WaWhyfCl/C4jrW1dXuM
        cR1Ur6bGEEZ8PyypBvHgh2nIxVMn6Z8KVgKNXOt+UfLupNFH4Txt8Axnup0veLtQSIf2BP
        0p8F7OP+u2miZdkWZ9pLZrxshM2dKkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685976728;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KJ5Vvn/f/LcaLzfrsc9YEqYfn9KBb8ZzT6iAUABQLqA=;
        b=DOsazAXrHZRVT8vAEdfE0KEG/SQ4kjCyOWKb4casDLkUx31icT/MgsXp2n9kDm6fHPNDJB
        f8G6jeHMuvT5xlCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E7CF139C8;
        Mon,  5 Jun 2023 14:52:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qFsIF5j2fWSfYQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 05 Jun 2023 14:52:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EA639A0754; Mon,  5 Jun 2023 16:52:07 +0200 (CEST)
Date:   Mon, 5 Jun 2023 16:52:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix two issue about quota
Message-ID: <20230605145207.ypagyiromug2imzs@quack3>
References: <20230605140731.2427629-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605140731.2427629-1-yebin10@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-06-23 22:07:29, Ye Bin wrote:
> Jan Kara (1):
>   quota: Properly disable quotas when add_dquot_ref() fails
> 
> Ye Bin (1):
>   quota: fix warning in dqgrab()
> 
>  fs/quota/dquot.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks! I've queued the fixes into my tree.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
