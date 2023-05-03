Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F0C6F54A4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjECJ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjECJ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:26:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5931F44A1;
        Wed,  3 May 2023 02:26:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FC92224E9;
        Wed,  3 May 2023 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683106000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1PDsSAco8cHUixikjZOolUtD+5H8EiTfwaQidAB+Qko=;
        b=1RnvefgQoYI61aYy0NCfmMqi2RGDq3YmAqwQE8zGGB4EISiw9cMvq+D42rr75UNO1J7OL+
        MwHk9DHqe7/9TGLVKtigHbETACiNwhiuFM76xv6wJ5QxLUQJ0W2hDNiyn8HAbWqb/QWErA
        CDsMDCcqlgS5HHd7XdsyHKEwi3m0uo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683106000;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1PDsSAco8cHUixikjZOolUtD+5H8EiTfwaQidAB+Qko=;
        b=dcpOmmQZgay41/gjTazJQbd9fzWz2TLkx+O2T2ReVo3wPHdmik6n+qdWruOJDNbp0chFMG
        1NrTPqZeQJMcWWBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 001B21331F;
        Wed,  3 May 2023 09:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8/V/O88oUmT1EwAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 03 May 2023 09:26:39 +0000
Date:   Wed, 3 May 2023 11:26:39 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 01/12] nvme/rc: Auto convert test device size
 info
Message-ID: <w4cdwu5ol4gbwdwyig5rk76xvqqe3xzpolcvbypfjkzl47mgwx@dhztqv36j3xu>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-2-dwagner@suse.de>
 <c7532fd7-f9da-b8b3-a7d1-b72c18d8df11@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7532fd7-f9da-b8b3-a7d1-b72c18d8df11@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 09:22:07AM +0000, Chaitanya Kulkarni wrote:
> On 5/3/23 01:02, Daniel Wagner wrote:
> > Introduce a convert_to_mb() helper which converts the size argument
> > to MBytes and use in test device require function. This makes it
> > possible to use user input strings in future.
> >
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >
> 
> Much needed mb helper, looks good.

I am sure the helper can be written way smarter but my shell-foo
skills are a bit limitted. Still a starting point :)
