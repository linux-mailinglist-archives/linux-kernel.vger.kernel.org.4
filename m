Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22905F09B5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiI3LPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiI3LOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:14:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753BA634B;
        Fri, 30 Sep 2022 03:54:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8EE2B827EC;
        Fri, 30 Sep 2022 10:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2039BC433D7;
        Fri, 30 Sep 2022 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664535279;
        bh=HVnpN+6G03dyXeH6Itki+AorPuIjzmu4GUoqYlXcpBw=;
        h=From:To:Cc:Subject:Date:From;
        b=fsv7HUMxitIbxckYO45kKgCquCSKXAxnlZHaobNnKdendjBgnIu1+U5pigip7ayn1
         A2Q9IWx088SPMNjWVmcaS3RbwUt6abVJhbcUxWU7TRnPB8IwEEV0yShFJZniA+fc+H
         DSs9e+c5AE/lXZbZQF6nvW4wprez20nifUduoM6St0vuJ+fj0SgCJp4sb26LjjWoZI
         bTfNKpZfkfs7/fipuQfBQH5c6cJGI1XQZEb4KorH2qi/dtWHqxEJL+pEwEFaRipJIN
         D+YoJgXzcsQVBzHwAsnCT3RWBjbZeHHcc9OqTEieR6MNYUpOhY45DsvY4R9bxR6kaB
         bT8We4zTRbqIw==
From:   broonie@kernel.org
To:     Lucas Stach <l.stach@pengutronix.de>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm tree
Date:   Fri, 30 Sep 2022 11:54:34 +0100
Message-Id: <20220930105434.111407-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the drm tree, today's linux-next build (x86_64
allmodconfig) failed like this:

/tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function 'dc_stream_remove_writeback':
/tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:55: error: array subscript [0, 0] is outside array bounds of 'struct dc_writeback_info[1]' [-Werror=array-bounds]
  527 |     stream->writeback_info[j] = stream->writeback_info[i];
      |                                 ~~~~~~~~~~~~~~~~~~~~~~^~~
cc1: all warnings being treated as errors

Caused by

    5d8c3e836fc224 ("drm/amd/display: fix array-bounds error in dc_stream_remove_writeback()")

I have reverted that commit for today.
