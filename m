Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1EE6CB301
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjC1BM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1BM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:12:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B451991
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=L7FSNc1vgVAeJP3WQWgrBGVSgOd3ygmN34pdIvG5vvk=; b=Bsc9lcMjTD95pplz1jlvMeUI7b
        9idPhq/QIdIwe6y2JXuROqOjQiFn49gj46z2bKgZni4pjOfDceTY8ksFgqo/NxHX92G6JEUweVxRo
        CwVJB/pqUA4QwZ/E1qaHzzWrknz7nX3yvKxnI3Ls3Zyp4gZ5NdUfX544NQ4jDS9cUODYAn/42yqnN
        q1C40ug3w5fw3cOz6PIdk5m5SDm3XW4cXH0r7cTkjGbRS7fFi+cQm1WCNcM+SUOZBDXRgN/I3B0Xl
        OxxzuVWygOXx9hmUZ1srTeTvEfeHY0+nWEQcqBR6BjHIKEi9oh2aXYy/x3FRJUPffuq2oGD33uS1H
        ngS9f8hA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgxsj-00Clkw-33;
        Tue, 28 Mar 2023 01:12:13 +0000
Date:   Mon, 27 Mar 2023 18:12:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Jeff Layton <jlayton@kernel.org>,
        Eric Van Hensbergen <ericvh@gmail.com>, lucho@ionkov.net,
        asmadeus@codewreck.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: 9p regression linux-next next-20230327
Message-ID: <ZCI+7Wg5OclSlE8c@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdevops uses 9p for its client / host setup to enable rapid kernel
development on guests using the host to compile / guest to install
a read-only-mount.

I updated the kernel today to next-20230327 and see the 9p mount won't
come up and so boot fails. I'm starting to bisect and see next-20230301
was OK. So at least have:

next-20230301: GOOD                                                             
next-20230315: GOOD
next-20230327: BAD

Once I narrow this down a bit further I'll poke back.

What sort of tests are run for 9p before some development changes get
pushed into a tree that lands on linux-next? If none exists, simply
testing 'make linux' works with kdevops could perhaps be a start.

  Luis
