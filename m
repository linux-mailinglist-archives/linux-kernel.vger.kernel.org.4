Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752186E6627
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjDRNnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjDRNnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:43:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56391B464;
        Tue, 18 Apr 2023 06:43:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 111E31F8D7;
        Tue, 18 Apr 2023 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681825402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oMzXDgeIe9bFmA8zBDQFasaEMBj1BPB8PAmctp5SKQA=;
        b=CHxs2l1AEj5yGxv61LcqpY0Y4cgMYFe4bldA2RQC2uDDd8nXfC1fSU26Zdrx+9CgXmUtH3
        QEssjcy8kgDoeaho/XiY1XGrlxO6YB2tQqzWUWPXgmVLOwjy9bn+v0zM72A79fWqgDipmN
        gTceghiK5McVB3rDEr97Y/IdRUugGs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681825402;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oMzXDgeIe9bFmA8zBDQFasaEMBj1BPB8PAmctp5SKQA=;
        b=KSexhj329+sezaAzmQF0TKFP8+X7DF5TORB/c3xF8eRfF1h5evdqburXoZU4hWjVQMhCGN
        JhCJQjp9ljY4XuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00FC513581;
        Tue, 18 Apr 2023 13:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yDI9AHqePmTLQAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 18 Apr 2023 13:43:22 +0000
Date:   Tue, 18 Apr 2023 15:43:21 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v3 0/4] nvmet-fcloop: unblock module removal
Message-ID: <nlogr5rdxqvilsz4iolktfpdvflvvithwaoa3vrx2fsjqlho4q@4upw7jq3aem2>
References: <20230418130159.11075-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418130159.11075-1-dwagner@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:01:55PM +0200, Daniel Wagner wrote:
> nvme/041 (Create authenticated connections)                  [failed]
> nvme/042 (Test dhchap key types for authenticated connections) [failed]
> nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
> nvme/044 (Test bi-directional authentication)                [failed]
> nvme/045 (Test re-authentication)                            [passed]

I suppose these should be disabled for fc as all this is tcp specific.
