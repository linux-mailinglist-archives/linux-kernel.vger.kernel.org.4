Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE064D986
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLOK1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLOK1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:27:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529952E4;
        Thu, 15 Dec 2022 02:27:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BBE9520F72;
        Thu, 15 Dec 2022 10:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671100028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yi1j32638121uUkrd5VI1ko6llH+YBRN+da4F96TPoY=;
        b=AhbyzMrL5rrJBm0s+wy3Kan0wdkB9iIFNKUdWwX5DOeDZrFjSiA5LncheEpslE2Eud/rS3
        vTXIcmioFqcyBar23lVjjor87q4fA5WjuPEoNZKnUr6LDjCb9vNNStQmtbCTLP7iA0vcxO
        ZJPUuv9/D8pEESbvSjbard/1Cuovni4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671100028;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yi1j32638121uUkrd5VI1ko6llH+YBRN+da4F96TPoY=;
        b=0jz0jEeGSk/napn+mrIoVfrNaoa4XcTGVBeY2lUEQOiO5AAxhnF4fQHNHQ0xhLwjP8Gtk9
        5NFVwUEEH+1DG3Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5F1F138E5;
        Thu, 15 Dec 2022 10:27:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rCx0KHz2mmNGUAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 15 Dec 2022 10:27:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7ABF2A0727; Thu, 15 Dec 2022 11:27:07 +0100 (CET)
Date:   Thu, 15 Dec 2022 11:27:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yuwei Guan <ssawgyw@gmail.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>,
        paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v1] block, bfq: do the all counting of pending-request if
 CONFIG_BFQ_GROUP_IOSCHED is enabled
Message-ID: <20221215102707.hvnhzwd425f3dccy@quack3>
References: <20221110112622.389332-1-Yuwei.Guan@zeekrlife.com>
 <3153dcb3-dd9b-7a2b-a15a-8244d805f246@huaweicloud.com>
 <CALJQGLmOaEnHawYvNz5fk_MtGhz6DPpW+8E-hgvmWxF--8V4zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALJQGLmOaEnHawYvNz5fk_MtGhz6DPpW+8E-hgvmWxF--8V4zA@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yuwei!

On Thu 15-12-22 09:48:59, Yuwei Guan wrote:
> Yu Kuai <yukuai1@huaweicloud.com> 于2022年11月14日周一 11:33写道：
> >
> > Hi,
> >
> > 在 2022/11/10 19:26, Yuwei Guan 写道:
> > > The 'bfqd->num_groups_with_pending_reqs' is used when
> > > CONFIG_BFQ_GROUP_IOSCHED is enabled, so let the variables and processes
> > > take effect when ONFIG_BFQ_GROUP_IOSCHED is enabled.
> > >
> >
> > This patch looks good to me, fell free to add:
> > Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> >
> > BTW, this patch need to be reviewed by Jan or Paolo before it can be
> > applied.
> 
> Could you help to review this patch.

Yeah, the patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
