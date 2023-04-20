Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335BC6E9D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjDTUsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjDTUsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:48:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F3A10B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 13:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LKc/fJIYHijdEIglTa+FsQbwIJmZsw0Xj352C7shrQc=; b=c576q9RTF8ZOJFOjJt76wqaF7k
        KNrWZWen1S3BZtctmbzufl1uJudkXd5qXeqnez681d110Imr0U34RdSedS3pJYU/tHUsMwmFR9MnA
        ah1YgBjFftU5rAM7E3AgSWb7ZR5mAGzpjeiOq3WVU3BfKQ1/sZTOgHYcXLdl8iAhCID6PA7B2asLk
        UqFlrSMX0e36DBXO57QBnP8qm3Va+tQWuhDXO0gD5x0C+VKDYf1Tr11Tmg9T2WF/KQfyr9zZdrpKm
        vhjbggVCT9HwtBOnr8N7b2R0Ugi2Sfq+JLGxQ7+gcSra2cMVvlVAKjsV20DZJPoBwwkpRNzcpdARq
        70zkCJKg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppbCD-00AxMd-2E;
        Thu, 20 Apr 2023 20:48:01 +0000
Date:   Thu, 20 Apr 2023 21:48:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Arnd Bergmann <arnd@kernel.org>,
        akpm <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
        ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ocfs2: reduce ioctl stack usage
Message-ID: <20230420204801.GO3390869@ZenIV>
References: <20230417205631.1956027-1-arnd@kernel.org>
 <20230418-fortgehen-inkubationszeit-5d3db3f0c2b1@brauner>
 <7555eaf9-b195-5189-3928-c7292e4a0ba5@linux.alibaba.com>
 <20230418-vielmehr-nominieren-7f2adb0f6703@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418-vielmehr-nominieren-7f2adb0f6703@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 02:56:38PM +0200, Christian Brauner wrote:
> On Tue, Apr 18, 2023 at 05:37:06PM +0800, Joseph Qi wrote:
> > Andrew picked ocfs2 patches into -mm tree before.
> 
> Yup and that's fine obviously, but this belongs to fs/ and we're aiming
> to take fs/ stuff through the dedicated fs trees going forward.

Er...  Assuming that there *is* an active fs tree for filesystem
in question.  Do you really want dedicated e.g. affs, adfs, etc.
git trees - one for each filesystem in there?
