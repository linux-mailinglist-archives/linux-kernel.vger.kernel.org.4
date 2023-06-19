Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5626A735661
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjFSMEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFSMEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:04:00 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2607811D;
        Mon, 19 Jun 2023 05:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687176174; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=PUlEb5/yFcJ3vdmEBdlKMXQmv7Z+Q/5nGdJBgdt7hSBsi8xvOxi1KK7s+Q02aDhfIk8G19FSypzg2BAMtrKlszhaGP3XnqLK3i8Pj/oE8h4g+we4DMhXqhtQXx7MjxpR6aRrsbC/OfTZCzpYDazvEZoF4FMUbW7UIGDNyyHA/qU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1687176174; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ssQr11wA5JNcyAnldJTk18B1wXzPiiGhQYpVTxFwBAA=; 
        b=RyFwWo3mC+FA9gY0i/iluDoecDHQeAM5dnB5HfM/jYqR+OxJX86o3+ZcpXMwy38UXtY3e8QrOQMJYmNDb0CQ+QNR9d68ov8EvPCK5+UovOabbk1CtNNt8/fzaznLUz0o7CsgZEyX1HhEO4wsr4Pzhp34MmoCK2kcEt3aJAauE24=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1687176174;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=ssQr11wA5JNcyAnldJTk18B1wXzPiiGhQYpVTxFwBAA=;
        b=pvP+LrH2/zxPlq+yzHyBrlLvbtd1jnZ/NhfO3saQ2gD94VnDGnt38vrhXfb+Iqj0
        MCOAI74wI1JM44ogmBQ7apVqVs5XmhHZtTG6uhXImvCtwrKX4leOgaaa7cCCmgU86Pg
        OvCv0g29VoYWsAT3IlTxFR1Ctj26VOVHLgQorYc8=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1687176143401505.491704779305; Mon, 19 Jun 2023 17:32:23 +0530 (IST)
Date:   Mon, 19 Jun 2023 17:32:23 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Dave Kleikamp" <dave.kleikamp@oracle.com>
Cc:     "Dongliang Mu" <mudongliangabcd@gmail.com>,
        "Liu Shixin" <liushixin2@huawei.com>,
        "Hoi Pok Wu" <wuhoipok@gmail.com>,
        "jfs-discussion" <jfs-discussion@lists.sourceforge.net>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Anup Sharma" <anupnewsmail@gmail.com>,
        "syzbot+d2cd27dcf8e04b232eb2" 
        <syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.com>,
        "stable" <stable@vger.kernel.org>
Message-ID: <188d388e20c.68252734185979.7356640998684740177@siddh.me>
In-Reply-To: <6284256f-dacc-e287-fe07-377491f87ca3@oracle.com>
References: <20230605140151.635604-1-code@siddh.me> <6284256f-dacc-e287-fe07-377491f87ca3@oracle.com>
Subject: Re: [PATCH] jfs: jfs_dmap: Validate db_l2nbperpage while mounting
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2023 03:46:09 +0530, Dave Kleikamp wrote:
> Actually the sanity check should be much smaller. The maximum value
> should be L2PSIZE - log2(MINBLOCKSIZE). In reality, I think it's always
> zero.

Thanks for the review, will amend the patch and send.

Thanks,
Siddh
