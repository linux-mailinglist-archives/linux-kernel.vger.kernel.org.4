Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA59D6EA43C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDUHDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDUHDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:03:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC271FE7;
        Fri, 21 Apr 2023 00:03:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 76E591FDDC;
        Fri, 21 Apr 2023 07:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682060614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2rtWXlVT5BsQ+9u99bjnLdBNoxWAcQElzaxacnHOXTI=;
        b=1F8t7EYbDxtAnuR9jahNG2NSpaCyAN8tuFMnBdX0e9yVSzLrb9UO6uG+6VmdWHToruPTJO
        XcUaXvQOq9jPc2JZs1O7be9XRrm0QG703Ik2bv+15LpnlHvGuZlcjp0axKo+Wz/waAjm4w
        JxUni3tpgaWPkf0K7MZFqLolAmpSCn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682060614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2rtWXlVT5BsQ+9u99bjnLdBNoxWAcQElzaxacnHOXTI=;
        b=VtwYNriBGsu5v97+sGmbgOcQAu2YRRbXwoACP3zhiPTY+elacxfqPuPXXNBKyBMxkmzwlN
        Vkk0IGGso0ShA1Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A10F13456;
        Fri, 21 Apr 2023 07:03:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zZbgGUY1QmRKAgAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 21 Apr 2023 07:03:34 +0000
Date:   Fri, 21 Apr 2023 09:03:33 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 7/9] nvme-rc: Calculate IO size for
 fio jobs
Message-ID: <7qew4jvwfgvpsqlci6dh6r6vjmzrzaphbqzzxqvvpdfadkj3ab@vxvbvh26bvji>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-8-dwagner@suse.de>
 <6aa42bc9-e04e-cfc6-32cf-f1739944070b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aa42bc9-e04e-cfc6-32cf-f1739944070b@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 08:33:46AM +0200, Hannes Reinecke wrote:
 > +_nvme_calc_rand_io_size() {
> > +	local img_size_mb
> > +	local io_size_mb
> > +
> > +	img_size_mb="$(convert_to_mb "$1")"
> > +	io_size_mb="$(printf "%d" $((((img_size_mb * 1024 * 1024) / $(nproc) - 1) / 1024)))"
> > +
> 
> ... ending with ridiculous small io sizes on machines with lots of CPUs.
> Please cap nproc by something sane like 32.

Yeah, propably not really good long time strategy. I was wondering if we should
make run_fio() variants smarter and do the size callculation there and not by
the callee. If we do this, we could make the number of jobs dependend on CPUs
and image size a bit nicer.
