Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8CB7371F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjFTQm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjFTQmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:42:55 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BABBC0;
        Tue, 20 Jun 2023 09:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687279320; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=IOZtmLgZDADmJSjzSQ51F4PlLBd4cp53RGLr7LF+QWXelBrTbhJN6PjZisTZNJUDPm7c+y2I8ByXXrJIBgqTAMO+6kDVHtLIu/GRAvFFyHI08Vc+Cp4KPetrOlTE157AnAK8WPpgHhMZvq03LC51Z4oKoOb3dPASorNnt7geTlg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1687279320; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=qJi69R81WJTJUXdtcjhBcxv9lDqnm8in4CQ0BRYzBHk=; 
        b=Jb5sTL9AgfDfwL6sWiqC2QoEdO/WRDWJUK7xk458XuD2p1XSuu6OgqtgIIKNUIAHlGIy5sdR3tEdjXLztJFvgZUzlGuuPbr3T/6YrRzO79QcXs3CDP5OKpA+XocZjRjX0CqxLQUm3RG3EoW9SrOun0EpHqj2lsCJFDffJBS69lU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1687279320;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=qJi69R81WJTJUXdtcjhBcxv9lDqnm8in4CQ0BRYzBHk=;
        b=QUn0+eZZE9p4z9aiuHiaNFWed+IwW02PqYZlNjruEiJ1X7xiTwTk+pmX04PcX+bG
        bPMJxc8a9VPSknZsuS+zS2effZQ8iignMjwfPh6kG86LK4bkthgJzNrLnTqn7QwsGB2
        GjS3jMPx8DR9fl1EWcj0+54llvSXV+UK/hlucuW8=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1687279290236435.1731206576702; Tue, 20 Jun 2023 22:11:30 +0530 (IST)
Date:   Tue, 20 Jun 2023 22:11:30 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Dave Kleikamp" <dave.kleikamp@oracle.com>,
        "Hoi Pok Wu" <wuhoipok@gmail.com>,
        "Liu Shixin" <liushixin2@huawei.com>,
        "Dongliang Mu" <mudongliangabcd@gmail.com>
Cc:     "jfs-discussion" <jfs-discussion@lists.sourceforge.net>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+d2cd27dcf8e04b232eb2" 
        <syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.com>,
        "stable" <stable@vger.kernel.org>
Message-ID: <188d9aec760.2dfe3b2e316758.4209928399951806088@siddh.me>
In-Reply-To: <20230619131644.118332-1-code@siddh.me>
References: <20230619131644.118332-1-code@siddh.me>
Subject: Re: [PATCH v2] jfs: jfs_dmap: Validate db_l2nbperpage while
 mounting
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023 18:46:44 +0530 I wrote:
> Max number of pages = Page size / Min block size

Sorry for this typo, it should be max number of blocks (per page).

Will fix and send.

Thanks,
Siddh
