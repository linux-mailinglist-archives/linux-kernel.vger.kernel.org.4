Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740CA6551C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiLWPCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbiLWPCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:02:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A4205D7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jGTZSdyngRKzjzBfe0/ecutPYFiMdCVieiSey3gpzJA=; b=zV2WPcOwTj1gVfuE6w/XIubUPl
        yGenidnCU/e1jYunxjlqqEysto+FilWIltmsROkiL13dJpgWLfmqN0WdQbIHNH9FCjYexqz7Hx9KM
        44Q4xV7c7j3tbShWe7nnYgkhylgOWlyrJIS8yjwLruG9X//wbZSou+UYERsZ+3QbHrDX7rcyyyGJu
        klHS78xW1TDXW00iLqyQJbuf0r3D1E5wTwwmGuIdAgnwbAM+VleDFbgYv1EuxFlcJyC1IukNegK27
        luLEWuysZ4T/ITBMApwNdGzrJliiikU0wqroVwYFi8H8/cv5wAmQy7/O4feXJyXgjXmsSMz+iiKam
        6T4XvwRQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8jYS-0099bz-9b; Fri, 23 Dec 2022 15:01:48 +0000
Date:   Fri, 23 Dec 2022 07:01:48 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com,
        syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com,
        syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
Subject: Re: [PATCH] umh: fix UAF when the process is being killed
Message-ID: <Y6XC3Du9pFKQFNkt@bombadil.infradead.org>
References: <m2bko8c0yh.fsf@gmail.com>
 <m2pmcoag55.fsf@gmail.com>
 <Y5kE2eAa8EZUxx5b@bombadil.infradead.org>
 <Y5oqxh2jnarlEKNG@bombadil.infradead.org>
 <m2o7s55gan.fsf@gmail.com>
 <m2ili43s2v.fsf@gmail.com>
 <Y6P2MUcTGU9LIrDg@bombadil.infradead.org>
 <m235983p58.fsf@gmail.com>
 <m2bknv3b1a.fsf@gmail.com>
 <m21qor3afi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m21qor3afi.fsf@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 08:09:38PM +0800, Schspa Shi wrote:
> 
> Attaching the full test program in case anyone wants to add some
> comments.

Good stuff.

That looks like a kernel sefltest. So you can just add it as an
initial selftest for completion so lib/test_completion.c and extend
lib/Kconfig.debug for a new kconfig symbol for it, and then just add
a script on tools/testing/selftets/completion/ with a simple makefile
which references a script which just calls modprobe. You can look at
tools/testing/selftests/kmod/ for an example.

But I still think you may want an SmPL Coccinelle grammer patch to hunt
down other users with this pattern. The beneefit is that then you can
use the same Coccinelle patch to also then *fix* the issue in other
places.

The current uaf on umh is not something I'm terribly concerned to be
exploited in the wild. I don't think other use cases would be easier,
but, all this work would close the gap completely.

Thanks for doing this.

  Luis
