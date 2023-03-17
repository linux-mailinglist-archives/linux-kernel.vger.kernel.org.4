Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ACB6BEF09
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCQRBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCQRBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:01:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB11A1F497
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tc1Ck3nSI1pzzPl4+IjJKsv3yrqxTz0ggGGySc5PqMk=; b=OatFwPX6rue4x+TmhOQdgZmaq2
        2cSOfVq7OUoCdwdgKaBEI2THeqIiOLZTtObXJuXo5eKytZAPpF1xExhV4KBTNOEJUwZxZnOlmijmD
        AwZKUW3bp60Vvw72Yemk49E8XebDa84m/E5ijkSBeQAJkHkcdVNvkjh3v3z6Jtuzl0k4CaRQefjqU
        jpIu6a2NgFb3yssWQZ5mbBqJkfC/e0Ya+PwzRgBDlUWV6MX1gHGQbZ/WMMINY+y9I4FRbzIeP/YJ/
        p5c2+HK4GnOhAJsyLCa6+qqMO6WfunfwYvaNM/UGvfU0saRakTmqnaV6GSvL+U/HjF208/C6oc5Js
        sLNTWvvw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pdDS2-002psH-2q;
        Fri, 17 Mar 2023 17:01:10 +0000
Date:   Fri, 17 Mar 2023 10:01:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 9p caching with cache=loose and cache=fscache
Message-ID: <ZBSc1jjYJn6noeMl@bombadil.infradead.org>
References: <ZA0FEyOtRBvpIXbi@bombadil.infradead.org>
 <CAFkjPTmVbyuA0jEAjYhsOsg-SE99yXgehmjqUZb4_uWS_L-ZTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkjPTmVbyuA0jEAjYhsOsg-SE99yXgehmjqUZb4_uWS_L-ZTQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 01:22:34PM -0500, Eric Van Hensbergen wrote:
> I was looking at kdevops the other day - cool stuff.  Was trying to
> figure out how we could do v9fs CI with it.

Happy to help any questions you may have about it!

> Both cache=loose and cache=fscache currently don't validate via host.

What does this mean exactly?

Right now a host with debian 6.0.0-6-amd64 certainly does not seem to push
out changes to 9p clients on VMs but Josef informs me that with 6.2-rc8
he did see the changes propagate.

So I'm about to upgrade the host forward now in hopes that this is
somehow resolved on a newer debian testing kernel.

1) The simple test is boot up the guest, read a file mounted with 9p.
2) On the host append a file and sha1sum it.
3) Client side sha1sums after a few seconds

Today on 6.0.0 I see absolutely no updates, I have to reboot the guest.
Josef seems to indicate he does not see this issue on 6.2-rc8. So
curious if this was a bug fixed.

> I have a patch series which adds some new cache modes (readahead and
> writeback) that give closer to the loose performance but with tighter
> consistency (open-to-close) - these patches are in my ericvh/for-next
> tree.

Good to know!

For the typical workflow for kdevops we do kernel compilations on the
host over and over and over again. Take your typical kernel day, that's
how often we do that. So it is conventiant to just have the guest run
'make modules_install install' instead of:'reboot; make modules_instal install',

Do none of the existing 9p cache modes not support open-to-close policies
at all?

Right now the cache mode used is cache=loose as that's the default,
what do you recommend for a typical kernel development environemnt?

> I've also started on some patches to add cache=tight which will
> do dir caching like loose but with validation, and potentially also
> will add a new flag that will indicate how often loose should
> revalidate.  There is also some discussion of decoupling fscache from
> the revalidation policy.

I see !

> So the stuff in for-next will make it into the next kernel, there is a
> writeback fix patch that still has some bugs when cache=fscache that
> I'm working through, but the base patches add the new cache modes.
> The new dir cache along with tight policy will hopefully get done in
> the next month and so should be ready for next merge window as well.

Nice!

  Luis
