Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5826F4459
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjEBMzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjEBMyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:54:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C7E526B;
        Tue,  2 May 2023 05:54:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C75D81F8D6;
        Tue,  2 May 2023 12:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683032092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KbeXHGKWj2YyZ1B4O+LLJ0cAowHX1KL4MZ0ye5IodE0=;
        b=agtIXfyiT/A60NnvYLWabSU43bc+veyerxOHpQdJC/Nx8hJZsVnRQALybNg0BKE3chUKb8
        AvudVQ3Qp6zlEBK6dN8EQzfp0jq104A5DIjFWmMm5CkvP63GQ2doPWvUqGL9aCCzkdgwgN
        CWpyj18S8I0y4CdDcnmtbG6G7ElShnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683032092;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KbeXHGKWj2YyZ1B4O+LLJ0cAowHX1KL4MZ0ye5IodE0=;
        b=NU92dZ2HIKWCyjU+aPZkQuFndzCN85HxRWzQL6ZGDZ9r2jmNrpOywKjDNCGG2K8K/SU1v/
        UtMoZRj69Ia0emDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9C2F134FB;
        Tue,  2 May 2023 12:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GxJWLRwIUWQDSQAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 02 May 2023 12:54:52 +0000
Date:   Tue, 2 May 2023 14:54:52 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 2/9] nvme: Do not hard code device
 size for dd test
Message-ID: <p5eminun5jsblyb3k5nycsrefpzlzqlrihozlz3ezh65hcsfnu@pxhvomc3qwmn>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-3-dwagner@suse.de>
 <z3lbxnnewuwnozrme27okchaxytt7zegj4emgpt4gmewsvcr5k@aordfdu7tai4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z3lbxnnewuwnozrme27okchaxytt7zegj4emgpt4gmewsvcr5k@aordfdu7tai4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -	dd if=/dev/urandom of="/dev/${nvmedev}n1" count=128000 bs=4k status=none
> > +	size="$(blockdev --getsize64 "/dev/${nvmedev}n1")"
> > +	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
> > +	count=$((size / bs - 1))
> 
> Do we need -1?

Not really. My aim was to just to make it test case a bit more
reliable. The original test didn't fill up the disk either.

I am going to drop it.
