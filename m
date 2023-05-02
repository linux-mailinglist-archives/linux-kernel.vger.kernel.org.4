Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643C96F44F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjEBNXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbjEBNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:23:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1855FDE;
        Tue,  2 May 2023 06:23:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E03531F8C4;
        Tue,  2 May 2023 13:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683033785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cVyGvuVej8o6VtC2kw0WOrsF91VmhITkrYcbcgb8tfQ=;
        b=DXWmvcU5Q9/vNjjgtDZTV6BiwPTBJb5GnDIkXZm5QbBCHynsVtsWmyPltOV1SBP2++OVsB
        8YmYzhsLUlKe//up2w3THeNhHZHdeRPA92TPRYec3ldnbP7id5SDIlJBL+WBJ5m+GncNVA
        Tn057kkhxPy3PD/WR63QQflh02t6ibc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683033785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cVyGvuVej8o6VtC2kw0WOrsF91VmhITkrYcbcgb8tfQ=;
        b=xhYIpqPxD9R5VTPoYygRuVXNWWxm1z7Zyb4W8uD1N4Rhd2OlqIT70h+yZcI/+u6xH6/X7L
        Q5oBY1xQNs5kgoCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3B38134FB;
        Tue,  2 May 2023 13:23:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Tg+YM7kOUWT1WAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 02 May 2023 13:23:05 +0000
Date:   Tue, 2 May 2023 15:23:05 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Message-ID: <clh6gmnivvi5e4o7pzr3mxfale3vlymgepdntkjtvub4cazyvk@myovldb6bcnx>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-4-dwagner@suse.de>
 <le6qqxhkbdaacsifz4b3mody53gllg4rzhowm2j62y56y56y6k@pmlukhvwjw24>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <le6qqxhkbdaacsifz4b3mody53gllg4rzhowm2j62y56y56y6k@pmlukhvwjw24>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > --- a/tests/nvme/035
> > +++ b/tests/nvme/035
> > @@ -32,7 +32,7 @@ test_device() {
> >  	port=$(_nvmet_passthru_target_setup "${subsys}")
> >  	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
> >  
> > -	_xfs_run_fio_verify_io "${nsdev}" "900m"
> > +	_xfs_run_fio_verify_io "${nsdev}"
> 
> On the other hand, this change for nvme/035 does not look good. It runs the
> test on TEST_DEV, which may take very long time without TIMEOUT config.

I'll add the nvme_img_size argument here instead (nvme: Make test image size
configurable)
