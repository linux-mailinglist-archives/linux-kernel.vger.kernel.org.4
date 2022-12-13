Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686B964C034
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbiLMXEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiLMXED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:04:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140FD13D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DvJekcslsdK7omBDZdseZHxFwmahCoRb/AUjED6RxSg=; b=ED1+EP4spiuK29WJRfp7tfP2QW
        cWWqccGfEx/OndvHrE/e9PkVFivUuk+NCSvxpiuDamWVgfcqF2xTiubqU/s6dTwY1wozRhT8Ays+e
        Wq0heAWA8Ma8s1LYMDXazPXz/H//ln91ah4/mRbBtACIdkqdpe0ykvmh9c8QZdfldEBVuoV7GMluX
        z3AfQNaMtgyKUm9BzZYYjhDCTpoarPtEbZUBSneVqHk4220iB+zFrrDdETqL2DX/88Qustls5D7Av
        ABBdzY+CwLMb8WSPHnVPtOuMTWFdPasAgQRv7lq5VNwSeDMPkG+lPAYbAxdieHMkj17V2C6lIPYD6
        q3Mndh0Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5EJV-0084bf-IE; Tue, 13 Dec 2022 23:03:53 +0000
Date:   Tue, 13 Dec 2022 15:03:53 -0800
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
Message-ID: <Y5kE2eAa8EZUxx5b@bombadil.infradead.org>
References: <20221115140233.21981-1-schspa@gmail.com>
 <m2zgc2vzwx.fsf@gmail.com>
 <Y5a3rAm21mCf2xrG@bombadil.infradead.org>
 <m2bko8c0yh.fsf@gmail.com>
 <m2pmcoag55.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2pmcoag55.fsf@gmail.com>
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

On Mon, Dec 12, 2022 at 09:38:31PM +0800, Schspa Shi wrote:
> I'd like to upload a V2 patch with the new solution if you prefer the
> following way.
> 
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 850631518665..8023f11fcfc0 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -452,6 +452,11 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>                 /* umh_complete() will see NULL and free sub_info */
>                 if (xchg(&sub_info->complete, NULL))
>                         goto unlock;
> +               /*
> +                * kthreadd (or new kernel thread) will call complete()
> +                * shortly.
> +                */
> +               wait_for_completion(&done);
>         }

Yes much better. Did you verify it fixes the splat found by the bots?

  Luis
