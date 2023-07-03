Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ADF74555E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGCGTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjGCGSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:18:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2742B12E;
        Sun,  2 Jul 2023 23:18:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A3BD31FD70;
        Mon,  3 Jul 2023 06:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688365117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GUoBaQDxjkZi1Sem7EpqwhIMMA5Ih8do3OoTKvP4LWw=;
        b=MtQcbPcdhzin7AFReIh58w+BF26CTYT8jrPqHE+Rm845NDzAQzwbPCvgiFHBPOzGAH6QNE
        KYl8ANZ7hlETd+MP0AqPJ55A0Tjwb/UsHztNkgEVWinsbLlJiVIVhzkSPT5SC5x4wqG6UA
        iMY2V/q1flzCFuw9K5pBNKA4WzpcWVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688365117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GUoBaQDxjkZi1Sem7EpqwhIMMA5Ih8do3OoTKvP4LWw=;
        b=DD0ZzlPyk8Vzs7/j6rh7vTx8Sfq+Yi2XW8geOrAO5zjz+LClrftyp0ZK47ls78snspzfSw
        3nKxMKiuwxIz+eDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94FCE138FC;
        Mon,  3 Jul 2023 06:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fbtTJD1oomSpMwAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 03 Jul 2023 06:18:37 +0000
Date:   Mon, 3 Jul 2023 08:18:37 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v2 0/3] More fixes for FC enabling
Message-ID: <exbq2w5c2ny24pxjprhiozbcaftqwumq6o4cvq2sjy6bqi4lvi@nqkeh2vs5seu>
References: <20230628151623.11340-1-dwagner@suse.de>
 <aji2laz4lypl4lspduoeef4uviuoysl5rweu25zmzplj3psg7f@ryxrnjorfsr2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aji2laz4lypl4lspduoeef4uviuoysl5rweu25zmzplj3psg7f@ryxrnjorfsr2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 05:43:01AM +0000, Shinichiro Kawasaki wrote:
> On Jun 28, 2023 / 17:16, Daniel Wagner wrote:
> > I (think) address all the feedback I got from Sagi and Shinichiro except one.
> > The _have_nvme_cli_context() (previously _nvme_cli_support_context()) function
> > is still there. I didn't find any other good way to achieve this and I found in
> > blktests another function doing the same: _have_fio_zbd_zonemode().
> 
> I found that the latest blktests fix for the hostnqn/hostid issue created
> conflict with the 2nd patch in this series. Sorry about that. (Actually, I guess
> this series could be enough for the issue...)

No problem.

> Daniel, I can fix the conflict and repost the series to the list. Or you can fix
> the conflict by yourself. Please let me know your preference.

I'll rebase and fixup the conflict. Also give it another quick test run just to
make sure all still works.

> Other than that, I think the three patches are good enough to apply.

Great!
