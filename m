Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9856DD78B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDKKJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDKKJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:09:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE0330FA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:09:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE4ED219FE;
        Tue, 11 Apr 2023 10:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681207772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EV8e+y7eNRKrFN0k8UGFpRSD2keQGbtk2Rp81PGmh1o=;
        b=uPr2HSiN9KFEGP474YkBadjLab0gOtMS+1OSfO25IayTA0yjUfwB9F1Dx2ICgpPZVLMrFR
        mULtYW+rQYwIyySAdhvmHkpkQWJ4m3bd//cFUspraXLk+5QHy9SWB1PgIocOfFyBtj0lC1
        XJBDVyMTXGQjsZ/+yJkfKFJ7zFFQnSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681207772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EV8e+y7eNRKrFN0k8UGFpRSD2keQGbtk2Rp81PGmh1o=;
        b=BHQ9Gw2QP0Q7LUnJEEGkp5RgzyqBtc5tCALhs7YVgVkKISbNPTlHSK/w0kwzHx3NBuU+Xc
        XNsyb+MIEpZS0HAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF90E13638;
        Tue, 11 Apr 2023 10:09:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6ruhMtwxNWTRQAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 11 Apr 2023 10:09:32 +0000
Date:   Tue, 11 Apr 2023 12:09:32 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] rvmet-fcloop: Remove remote port from list when unlinking
Message-ID: <r5hxrqiiqfsj27f3jlb2avq6wulg3ksnuf5zg6xrgkdprgrpxy@ssusv6tvghqy>
References: <20230411092209.12719-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411092209.12719-1-dwagner@suse.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 11:22:09AM +0200, Daniel Wagner wrote:
> The remote port is never removed from fcloop_nports list. During module
> unloading it's possible to end up an busy loop in fcloop_exit, because
> the remote port is found in the list and thus we will never progress.
> 
> The kernel log will be spammed with
> 
>   nvme_fcloop: fcloop_exit: Failed deleting remote port
>   nvme_fcloop: fcloop_exit: Failed deleting target port
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---

Found a bunch more problems which need to be addressed. I'll collect all
changes and send them as series.
