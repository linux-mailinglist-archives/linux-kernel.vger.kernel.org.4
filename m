Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92735BBB2C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 04:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIRCnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 22:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRCnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 22:43:07 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69B0286CC
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 19:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=um5UnD1ZnyEAgcctB8e0bdxExLm3AihflJVjXCDL3Fo=; b=tg/t0BdHfoKvwqeStHEJvYxCKj
        rZLUKqRuZxEk9hbAMHPuAFwmEhGHIZ6DndFQ2wPvRlSV3suMSM4OyKJveh8Vv09AaMO2FKBCcA533
        5H1Ut8f2doPHZ7EDBTjeUyRxhVkXnjyjkGvHFIxS3Gh3gHa7SyN8VVm51NpYowegkigee6Y7tJ6Fz
        pHpYSKZGN2R9BNFja/qEOggFQIRBJNfDS1bHEr/GyqPFNQpjCIgoLnf+axOH6JuoOyteMTlr7eChs
        rMizovJ1fSZAPgXEwPIBeApYRO8px2NjfuL0cpsy3ox6axpfpnPBRMv6yX/oG7VOGqURNrhSDS4dp
        0i77AEbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oZkGj-000Okm-3D;
        Sun, 18 Sep 2022 02:42:54 +0000
Date:   Sun, 18 Sep 2022 03:42:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
Subject: Re: [PATCH] fs: use kvmalloc for big coredump file
Message-ID: <YyaFrarLHYW3HSnu@ZenIV>
References: <1661842523-26716-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAGWkznE5LhYq6dWB0zFkF2XdD-gd3MBcQ9fnUJmW59YL1GisMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznE5LhYq6dWB0zFkF2XdD-gd3MBcQ9fnUJmW59YL1GisMQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 10:29:10AM +0800, Zhaoyang Huang wrote:
> loop Eric W
> 
> On Tue, Aug 30, 2022 at 2:56 PM zhaoyang.huang
> <zhaoyang.huang@unisoc.com> wrote:
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > High order page allocation observed which even introduce kernel panic when generating
> > coredump file, use kvmalloc_array instead of kmalloc_array

Frankly, I would rather cap argc here - if you are trying to feed that many arguments
to your userland helper, your core_pattern is probably bogus.
