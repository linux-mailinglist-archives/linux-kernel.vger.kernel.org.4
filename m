Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBE06E7799
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjDSKmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjDSKm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:42:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1032118D4;
        Wed, 19 Apr 2023 03:42:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B04152198F;
        Wed, 19 Apr 2023 10:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681900944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qfmxrU7rqgnnhieg7x5c1b8MRuikfwddv02sfKrFJY=;
        b=nLgX070cza+RuPu4YZP37+VLVfH6ak/LLTFRb/U1HF6XzHVeH/fW1RwLUU8a/vUEtx0iNT
        XNL+akAOACz4WakiT2lbQeYw0TzJXfv5b/gyUtRcV9sKI+UYHrNMshYJdmHhJMSbZfSIZA
        xgeADsGl1K8qpCfPZlS9GKDWq4wCx60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681900944;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qfmxrU7rqgnnhieg7x5c1b8MRuikfwddv02sfKrFJY=;
        b=yl6kT564O47BeIeAbbUCpKJIOf6nSvnKUnH3AjGY0NHAr9fldXgBeIQXbQGRLfO9SwDait
        fcMkPOs9l6w35EAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A115F1390E;
        Wed, 19 Apr 2023 10:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2OBCJ5DFP2TENQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 10:42:24 +0000
Date:   Wed, 19 Apr 2023 12:42:24 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Message-ID: <3euieyvxpsww5p4m457pzupfipbnbv3atxauh2lrp54gqmqcco@hs7ytoop5osf>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
 <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 12:44:42PM +0300, Sagi Grimberg wrote:
> 
> > Before we unload the module we should cleanup the fc resources first,
> > basically reorder the shutdown sequence to be in reverse order of the
> > setup path.
> 
> If this triggers a bug, then I think it is a good idea to have a
> dedicated test that reproduces it if we are changing the default
> behavior.

Right, though I would like to tackle one problem after the other, first get fc
working with the 'correct' order.

> > While at it also update the rdma stop_soft_rdma before the module
> > unloading for the same reasoning.
> 
> Why? it creates the wrong reverse ordering.
> 
> 1. setup soft-rdma
> 2. setup nvme-rdma
> 
> 2. teardown nvme-rdma
> 1. teardown soft-rdma
> 
> I don't think we need this change. I mean it is a good test
> to have that the rdma device goes away underneath nvme-rdma
> but it is good for a dedicated test.

I was woried about this setup sequence here:

	modprobe -q nvme-"${nvme_trtype}"
	if [[ "${nvme_trtype}" == "rdma" ]]; then
		start_soft_rdma

The module is loaded before start_soft_rdma is started, thus I thought we should
do the reverse, first call stop_soft_rdma and the unload the module.
