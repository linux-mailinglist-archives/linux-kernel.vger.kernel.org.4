Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10399663580
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjAIXn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbjAIXnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:43:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68B113CC0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:43:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E1FF61474
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEB9C433EF;
        Mon,  9 Jan 2023 23:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673307799;
        bh=3yd9JJa2BsCGT0J/Eov9WtOT/cMPRu6Yb6LDMAsw4dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbRoPBSRMlw2IYrVR04tNZ2HxMKaAXz09plnJQFA6FbgwAp14gh0Gc5XFjpSJUmG6
         Sxo36ylzDCqlU8BRfXC4ABCmgJs1d+Ep86Husm7kA+v1Yar33CbmnrBtuIpDU22Ebg
         PxbguczjQmrA/a+u2bPl/Oj86a7BAJqPzHOituRMYBwr5lZ/KaXRV+mfjumrB5gF9s
         1WWhrTOWa6Y7Jk51aOvyFWQ99xtb1Scb09O5qlN1ZJhjCXxG83lFhyHfs+K6y7SB/+
         BDv2gQ/Y5tapnFOExoGHoDZZNYL/tPHERRolzso0C7dihE3jXu4ERNgVNWv3cw9JIR
         UIzEG85Rb01kA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH] maple_tree: Fix handle of invalidated state in mas_wr_store_setup()
Date:   Mon,  9 Jan 2023 23:43:17 +0000
Message-Id: <20230109234317.1408-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109154012.3342cbb91defbc485db641c1@linux-foundation.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, 9 Jan 2023 15:40:12 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon,  9 Jan 2023 19:22:48 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Mon, 9 Jan 2023 16:55:42 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > 
> > > If an invalidated maple state is encountered during write, reset the
> > > maple state to MAS_START.  This will result in a re-walk of the tree to
> > > the correct location for the write.
> 
> Can we think of a Fixes: for this?
> 
> > > Link: https://lore.kernel.org/all/20230107020126.1627-1-sj@kernel.org/
> > > Reported-by: SeongJae Park <sj@kernel.org>
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > 
> > Tested-by: SeongJae Park <sj@kernel.org>
> > 
> > I confirmed this patch fixes the boot failure issue.  Nevertheless, the 'make
> > install' issue on my system is still not fixed.
> 
> Is this a mainline issue or an mm-unstable issue?

It's mm-unstable issue:
https://lore.kernel.org/linux-mm/20230107023954.1841-1-sj@kernel.org/


Thanks,
SJ
