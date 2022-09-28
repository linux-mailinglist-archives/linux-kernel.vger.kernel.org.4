Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740E25EDEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiI1OUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiI1OUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:20:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC416B14F;
        Wed, 28 Sep 2022 07:20:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B488061EC2;
        Wed, 28 Sep 2022 14:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FF9C433D6;
        Wed, 28 Sep 2022 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664374846;
        bh=nCu7bxg7O17gscxvIVxhHY3v0ktqpxPeHl8mMAEm1MA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3GpYlh+sV4Gbc3PQY9YhEY+Ijeb7mMsW4CjT5GRqkpAG0Tlp+SX8N7VDwzEfbdDf
         DRQJcQ47vClvh62ZJjJCe21d2PDJIeCt7ahGxIrltFOkXggQTFgAk+h7LgpIkBLWdt
         AfutSZA1v/sE8/+y/DPqD4mUQfblrbGVgV0nWAwY9z5lAclZGye+MksphOD3ct8dbU
         2J+EDkOVCazPQHDbOuZpJgHwPYrzorM//2pAO6bCIOEoaYrukHwXGyMO3h1KucC0CW
         mZ6JnNFQ1HFEVXjx7GzTu1UozvQNXZkFjgtGRNXF9H4k3ObGqkERbQ4j1jxrS4nitz
         Qpk/YbfAj7TOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 717B2405F0; Wed, 28 Sep 2022 11:20:43 -0300 (-03)
Date:   Wed, 28 Sep 2022 11:20:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, renyu.zj@linux.alibaba.com,
        alexander.shishkin@linux.intel.com, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mike.leach@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, timothy.hayes@arm.com, will@kernel.org,
        xueshuai@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH] perf arm-spe: augment the data source type with
 neoverse_spe list
Message-ID: <YzRYO9aJxI4twVVj@kernel.org>
References: <1664197396-42672-1-git-send-email-renyu.zj@linux.alibaba.com>
 <20220926141032.30734-1-alisaidi@amazon.com>
 <YzG+goZySC4K8S4Z@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzG+goZySC4K8S4Z@leoy-huanghe.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 26, 2022 at 11:00:31PM +0800, Leo Yan escreveu:
> On Mon, Sep 26, 2022 at 02:10:32PM +0000, Ali Saidi wrote:
> > > When synthesizing event with SPE data source, commit 4e6430cbb1a9("perf
> > > arm-spe: Use SPE data source for neoverse cores") augment the type with
> > > source information by MIDR. However, is_midr_in_range only compares the
> > > first entry in neoverse_spe.
> > > 
> > > Change is_midr_in_range to is_midr_in_range_list to traverse the
> > > neoverse_spe array so that all neoverse cores synthesize event with data
> > > source packet.
> > > 
> > > Fixes: 4e6430cbb1a9("perf arm-spe: Use SPE data source for neoverse cores")
> > > Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> > 
> > Thanks for catching this, you're absolutely right.
> > 
> > Reviewed-by: Ali Saidi <alisaidi@amazon.com>
> 
> It's also good for me:
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

