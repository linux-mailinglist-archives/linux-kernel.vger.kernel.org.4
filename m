Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760C06C24BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCTWZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCTWZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:25:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37231CAE4;
        Mon, 20 Mar 2023 15:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC394B81106;
        Mon, 20 Mar 2023 22:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE2EC433D2;
        Mon, 20 Mar 2023 22:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679351076;
        bh=JVOU84AlcZqGS6txTHxsZrMnzURkZ9tj2sVJblykpKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eu40JiFDUnUSXH5yCF7+t29gZ6N/9P2QrbNYiDLGwA7AbN+WP1c0ZhRepBg1+oUDv
         xxu7xZli58Cjfzs4K/mZtQAp+k6RGqDnSix6ZTi1MhWMSmERT/1EA6yvdNbWA9yBAj
         Usrhdfd7Wh78V1ADeZNgIU/mw464Jatje/pPNji1kBwyQ8mpy0y01i83zHZY3zdsSr
         XmAGZhB+o1/KFYspIZAz5qXyS3knhen+TxoLrS0usxdehnu+JkyrEQGAjBXeEskjFM
         4aECdGKqtcErhfvWlrNuugU1WAf0WJIAhMxVFsWpOeNBzraId+K8goMXHn4xC56AJa
         IK3CaKxsdkS0A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D1F9A4052D; Mon, 20 Mar 2023 19:24:33 -0300 (-03)
Date:   Mon, 20 Mar 2023 19:24:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Cc:     Ian Rogers <irogers@google.com>, Ben Hutchings <benh@debian.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf jevents: Sort list of input files
Message-ID: <ZBjdIbF7BDphCH+k@kernel.org>
References: <20230320201841.1133-1-bwiedemann@suse.de>
 <CAP-5=fUGbT8=spY=e6NPJvf_+Ct6VksFzWM6Eybf=gst_J=Xmw@mail.gmail.com>
 <5064f88a-952a-6f3f-f280-e76e09603c1b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5064f88a-952a-6f3f-f280-e76e09603c1b@suse.de>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 20, 2023 at 10:30:00PM +0100, Bernhard M. Wiedemann escreveu:
> 
> 
> On 20/03/2023 21.48, Ian Rogers wrote:
> > I think this may already be addressed by sorting prior to output:
> > https://lore.kernel.org/r/20220812230949.683239-5-irogers@google.com
> > 
> > Could you confirm?
> 
> Hi Ian,
> 
> I was testing on 6.2.6 which includes that patch and it was still affected.
> The trouble with sorting at the end is, that there can be influences of
> ordering in earlier processing steps, that don't get ironed out by the sort
> later.
> 
> Some more experimenting showed that only the ftw scandir needed sorting,
> which allows to further simplify the patch to
> 
>      """Replicate the directory/file walking behavior of C's ...
> -    for item in os.scandir(path):
> +    for item in sorted(os.scandir(path), key=lambda e: e.name):
>        action(parents, item)
> 
> 
> Without the patch, a random diff in pmu-events.c starts with
> -static const struct compact_pmu_event pme_amdzen2[] = {
> +static const struct compact_pmu_event pme_silvermont[] = {
> 
> 
> While I'm testing on scratch ext4 filesystems where dirindex causes
> randomness, you could also use the disorderfs FUSE-filesystem with its
> shuffle mode to give you random order.

So, Ian acked the current patch, but you found some further
simplification, can you please resubmit?

- Arnaldo
