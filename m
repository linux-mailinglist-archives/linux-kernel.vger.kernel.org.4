Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BB1600539
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiJQC3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJQC3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:29:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998D81A044
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 19:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D513B80E4A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE086C433D7;
        Mon, 17 Oct 2022 02:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1665973743;
        bh=jsK3qEANRyPmKldiqe7w+EnAwbL36O8N4IwTdPMdRJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gc5KnyyetB5mVmEtwZOa+ZpMS4OWiQa413XQbPSysavRW07fvPr8ZZMP4fF2dvzIT
         CrJ+ic+eyoAs1DxGaxANoDZ9OFhG4X3tdPS/Q4umCXzUi6xwjR2JZLCFu+pebIUdok
         uA1b0kCJvpC5TXe8cEG9dTgrr8ckLBeg5ioVarJY=
Date:   Sun, 16 Oct 2022 19:29:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joseph Qi <jiangqi903@gmail.com>
Cc:     Gang He <ghe@suse.com>, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: reflink deadlock when clone file
 to the same directory simultaneously
Message-Id: <20221016192902.4d7e70047ca5d04a2f585688@linux-foundation.org>
In-Reply-To: <06a7f382-5eaa-9489-3c28-aa4bfb804327@gmail.com>
References: <20210729110230.18983-1-ghe@suse.com>
        <5821fd0f-2018-dc1b-a5c0-f948a7debff4@linux.alibaba.com>
        <c7e1f0a7-e75c-d1e0-870d-dc480d070079@suse.com>
        <71608a14-58f4-dba0-d695-fee65de89192@linux.alibaba.com>
        <801438f5-655a-c708-aa25-343d54a2f11e@suse.com>
        <86e3d724-3147-ccaa-998f-0f857c575f7e@linux.alibaba.com>
        <a0a9710f-461a-99c8-92f6-a99bb11b3a4e@suse.com>
        <4ba3b404-824b-90a3-ef43-9ab6510ee073@linux.alibaba.com>
        <5a1af56c-3eab-5baf-62a3-1c98bac104ba@suse.com>
        <db7119a5-f120-cebe-42a1-dc2f64db620d@suse.com>
        <20221016162950.09db2b5f503ac87823cd1687@linux-foundation.org>
        <06a7f382-5eaa-9489-3c28-aa4bfb804327@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 09:51:14 +0800 Joseph Qi <jiangqi903@gmail.com> wrote:

> Hi Andrew,
> 
> On 10/17/22 7:29 AM, Andrew Morton via Ocfs2-devel wrote:
> > On Thu, 26 Aug 2021 13:56:16 +0800 Gang He <ghe@suse.com> wrote:
> > 
> >> So, I will send a new patch to fix this deadlock problem via dlmglue layer.
> >> For this patch, I want to change the patch comments as a reflink 
> >> improvement patch.
> > 
> > Did this ever happen?  I've been sitting on this patch for ages.
> > 
> Looked back this thread, the root cause of deadlock seems to be the
> asynchronous of fsdlm handling. So this is not a right fix.
> While for the performance improvement, I need some test data as well.

OK, thanks, I dropped the patch.
