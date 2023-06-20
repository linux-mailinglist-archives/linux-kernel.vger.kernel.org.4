Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F63737317
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjFTRnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFTRnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:43:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16FE10F8;
        Tue, 20 Jun 2023 10:43:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A1D99218A8;
        Tue, 20 Jun 2023 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687283015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OG2008PZjL0H9Xg+EBwGxKiyxoGstQ6drRqgvSMoZ2U=;
        b=kbcXvQY3RYkvHnWKVwTn/IOquzAhVGCwkxaHFRltVx4zdu2RSAoWrw2p+EZy11f/MGfN1r
        4eLvz6nq62gzJhTaj90TBCRqD64KBe2lz0G0sFyADOOZR5Mf3D+04GJD1n3uS9qHwnrUNv
        djkQPlcCOkPR51gY4VirFwy6/y4IgJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687283015;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OG2008PZjL0H9Xg+EBwGxKiyxoGstQ6drRqgvSMoZ2U=;
        b=u48D7GdjcIHgrGOBrltXSNJBzLd2ps3OZRfiXjdf1s5zps8A+KWCquFl5mRopZQ90pDxSq
        ZKMKjsI4r/h/5uDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93D2F1346D;
        Tue, 20 Jun 2023 17:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wQgWJEflkWTsMgAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 20 Jun 2023 17:43:35 +0000
Date:   Tue, 20 Jun 2023 19:43:35 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <vbbbnzcm6r4jzcc54crix7kjsg647w57te7t2weu7vhuwxg54n@u6cwcn62bfbd>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <af640019-b867-d488-0443-797a75ba4195@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af640019-b867-d488-0443-797a75ba4195@grimberg.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 05:07:43PM +0300, Sagi Grimberg wrote:
> 
> > When the host has enabled the udev/systemd autoconnect services for the
> > fc transport it interacts with blktests and make tests break.
> > 
> > nvme-cli learned to ignore connects attemps when using the
> > --context command line option paired with a volatile configuration. Thus
> > we can mark all the resources created by blktests and avoid any
> > interaction with the systemd autoconnect scripts.
> 
> Hmm... is this hapenning with non-fc as well?

I haven't seen a problem for TCP or RDMA yet but in principle it should also
exists. I can do some tracing to see if we have also problem thern. Two of the
udev rule match on the subsystem and the event type.

> > +_nvme_cli_supports_context() {
> > +	if ! nvme connect --help 2>&1 | grep -q context > /dev/null; then
> > +		    return 1
> > +	fi
> > +	return 0
> > +}
> 
> Not a great way to check support.

Yeah, agree, it's a bit dodgy. I'll try to figure out a different way. Any
suggestions?
