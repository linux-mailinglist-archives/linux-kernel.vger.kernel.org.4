Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A42B6E6935
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjDRQRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjDRQRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:17:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D83B3C38;
        Tue, 18 Apr 2023 09:17:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 50E3821A73;
        Tue, 18 Apr 2023 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681834662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b2qUHxbFNWuVEA2GFkOYquFZaX+TXj0U5db+f7oebUc=;
        b=YprVtvHJtRcqjlb3CsUw2yq2ICBKIMjhBhRuz0tFbup2qCvM5Ywz1qUmcgSSLHy4ffJKti
        QPVjiXbxBgVO02PXo3Rc0Yke5FyuchVzvW9vF14UdYg4Vem2xful+Ro260ioOiYODQuGLE
        FjSaZcciQgN60rDLszBPTMWiEMyQwLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681834662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b2qUHxbFNWuVEA2GFkOYquFZaX+TXj0U5db+f7oebUc=;
        b=H/2rgK6FudddyhQ9P22occLyWHJ43icsOXCK30w75uiWE++dPUKrrlBZDKldFoK37CqXz3
        cZ4ZlCGz/2W6w8CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 410D613581;
        Tue, 18 Apr 2023 16:17:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id owDcD6bCPmSMHwAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 18 Apr 2023 16:17:42 +0000
Date:   Tue, 18 Apr 2023 18:17:41 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests] nvme-rc: Cleanup fcloop resources in reverse
 order
Message-ID: <wdecxjd73uaser6l2274rvgz6q4xr7ytcljor3zyggbebjf3w6@kt4mfriults3>
References: <20230418123252.3725-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418123252.3725-1-dwagner@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 02:32:52PM +0200, Daniel Wagner wrote:
> We need to free the resources in the opposite order as we allocate them.
> The deleting the rport first will also free the other resources. When
> we try to release lport and tport they are already gone.

I found some more ordering issues with fcloop resources.
