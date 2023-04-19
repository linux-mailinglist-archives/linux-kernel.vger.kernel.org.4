Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576D86E7785
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjDSKhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjDSKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:36:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09818A41;
        Wed, 19 Apr 2023 03:36:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6054D21987;
        Wed, 19 Apr 2023 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681900608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hBTOg25IsPxj0qWqx13dMLrckoNY7imS5h0ZNya05Po=;
        b=MWDz91LRmEubYBZAiah6DeyOVOVtq8pKh2mzdW6z+gbPWzUtDnVK/VTHX0zWf1eAPkdFcR
        LbPBlHy9cBSR6pP18I7GyNKBjNj8blCHka4YGQMBjKADUm29R8yAUX7/lEyyXfj/7bkqqA
        Q+NMjYIoLXVGoNGIa0cXe0KX8jXEx2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681900608;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hBTOg25IsPxj0qWqx13dMLrckoNY7imS5h0ZNya05Po=;
        b=IWiD+xzT5spCLdsQiQZE3mF6+D+NtBLOyoRVZjUbMy6J9Bsdd+AUlrx4edsrExAKbhUYRB
        OHyguUy4mLe/9NCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 527D81390E;
        Wed, 19 Apr 2023 10:36:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xOoPFEDEP2S3MgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 10:36:48 +0000
Date:   Wed, 19 Apr 2023 12:36:47 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Message-ID: <xwkb2nrwcc2ysgynznx6txhfjn73xy24qg5jvnye6r7k6jlw77@wwmiqgy6mooc>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
 <dd3850e3-045f-75a0-4980-9f44a05fd397@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd3850e3-045f-75a0-4980-9f44a05fd397@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 09:41:28AM +0000, Chaitanya Kulkarni wrote:
> were you able to test this with RDMA ?

Yes, I've tested it with all transports (loop, tcp, rdma, fc)

> just want to make sure we are not breaking anything since we are changing
> the order of module unload and stop_soft_rdma() in this patch ...

Sure thing
