Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7DB6F47DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjEBP77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjEBP7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:59:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE941997;
        Tue,  2 May 2023 08:59:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D98061FD72;
        Tue,  2 May 2023 15:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683043187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K1utLzmHsMkc77b/rZG5l9bAIP83HIHK1q56lBCBh68=;
        b=q4JE4PMVUMYIh9YxHKlcJ0852aU/Y8LMfQK9tqHPT6u+KcUYZEuYTd3DTSsp0OCw+6S8he
        qijqwFwvn5FTZfRoDfumxWOBdyhZ/cuNVBeYLMjwzJwOI5H1VTWNg8ERp4DqtEn5XmOqdi
        rB77lSfgvjxaPdWE59gSyph61eNfeLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683043187;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K1utLzmHsMkc77b/rZG5l9bAIP83HIHK1q56lBCBh68=;
        b=ZBH8RB3YLCd8fdbO+LsXEvmiV5vdSBFLaWAhS9tcSvUJ9B5BEUBmC/qeXDg/Sf8j+YDr1t
        vvhaMgzhFH0nZEAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA5C5134FB;
        Tue,  2 May 2023 15:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fQ1kMXMzUWSvMgAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 02 May 2023 15:59:47 +0000
Date:   Tue, 2 May 2023 17:59:47 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 9/9] nvme: Make the number iterations
 configurable
Message-ID: <iephcaynceoq5gpcvpcjzqngyjdefockihh23fxqez3yme3syr@avykw2xnyyyy>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-10-dwagner@suse.de>
 <yuwidfmwcg2iue2fm4wqyd2p3vmzo34t6hqr7rvf3d3rkh3ag3@wvpu4f3aqhly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yuwidfmwcg2iue2fm4wqyd2p3vmzo34t6hqr7rvf3d3rkh3ag3@wvpu4f3aqhly>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 04:12:06AM +0000, Shinichiro Kawasaki wrote:
> >  nvme_img_size=${nvme_img_size:-"350M"}
> > +nvme_num_iter=${nvme_num_iter:-"100"}
> 
> The commit log of tests/nvme/002 says that "Test nvme discovery with many (1000)
> subsystems so the discovery log page exceeds 4k.". Can we fulfill this test
> purpose with the default value 100?

I am going to drop the nvme/002 change in this case and set the default of
nvme_num_iter to 1000.

> Also, nvme_num_iter will need description in Documentation/running-tests.md.

Sure.
