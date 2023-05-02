Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288D66F47D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjEBP4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjEBP4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:56:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18010D4;
        Tue,  2 May 2023 08:56:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AF1B421ED1;
        Tue,  2 May 2023 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683042990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vasl3Zao45k71qET2Cv7fJrQh++BoZZwFAggUA3Av5U=;
        b=tG9+8yL2LciJ4pAgNSGdXy9+mjdpD9nn8gdA1cxqmWY0BtMOsTCWhdaA1RjtXB5JHu+5SS
        400hWmR2P7BgSjjICGOCeBNdjCoj/Twg6lfNmHyY2Ab1OfQ/Gw3a6HMZqJSwm4vYE+PM0i
        NT0fem8OXlFUhAarQKi2QyZ9SXk3cfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683042990;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vasl3Zao45k71qET2Cv7fJrQh++BoZZwFAggUA3Av5U=;
        b=enD5aWtik20RB7OONKWjXSwFPxPgAIkKlM9QF6oNz1wyC12nh/EWyG1mutGD6F4R2dtOrr
        ax3qH2sex/bWhMBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A10D4134FB;
        Tue,  2 May 2023 15:56:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vCo/J64yUWSWMAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 02 May 2023 15:56:30 +0000
Date:   Tue, 2 May 2023 17:56:30 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 8/9] nvme-rc: Move discovery
 generation counter code to rc
Message-ID: <4txznlflpzliiljmqstfd3q2eqa75oihig6oe2shwux3x2udoa@qpsbmbmacjl4>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-9-dwagner@suse.de>
 <2nqdgwhiuvjsupuunxzzcoeumxqz3cosx52nhgtrv35u7nqsiq@2is3qc5gftl6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2nqdgwhiuvjsupuunxzzcoeumxqz3cosx52nhgtrv35u7nqsiq@2is3qc5gftl6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 04:23:27AM +0000, Shinichiro Kawasaki wrote:
> (Let me repost this message, since vger.kernel.org declined it due to too long message).
> 
> On Apr 21, 2023 / 08:05, Daniel Wagner wrote:
> > Move the discovery generation counter code to rc so that we can reuse
> > it in 002.
> 
> I think the core change in this commit is the removal of discovery related
> messages from tests/nvme/002.out. It removes the dependency to the iteration
> number constant 1000 in tests/nvme/002, and prepares for the next commit.
> If this understanding is correct, I suggest to note it in the commit message.

This change is really just changing nvme/002 to use the same infrastructure
as nvme/030 uses. The number loops isn't changed.
