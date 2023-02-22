Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548D469F82C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjBVPhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjBVPhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:37:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101CC3C7B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:37:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 25D48CE0B05
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 15:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0408CC433EF;
        Wed, 22 Feb 2023 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677080219;
        bh=FbGIiq9m4fsIkQ+G9Zan/ZZaJI2SN3Ob8d8KZNzES+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FElNTwnoNw5GI+l3YQNREYrYkxJRkGmA/5AtFI0/jke1/Fcq7ObTygZjHTEygZ+Mz
         HRAbuUNJ9d61FE+ZbwFlxt3QTXqYi9RZj7GazHjLB7knLslEOMN5DfLuAHOW0VlzX1
         jyZnEXonL+VmxeRbFeRATbcXg5CPgSz1xOOVfwTMWo6EWFGBjioYExfWbF6H5NYr/x
         1rtFna9AfRs3CwUa3ldE2FjmzpKK7SLMgkRVqNBWNBqeDIFdb5Aae4AQgrYPaocwHx
         K3o0736AgiVWuWWUcxcEZIs+FX6SOBOir6BoIyBsDeKBD0RoxGCeb2+x1LT4/1Y56N
         nl4jsZ7Irtybw==
Date:   Wed, 22 Feb 2023 08:36:56 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     linux@leemhuis.info,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, luto@kernel.org
Subject: Re: [BUG][5.18rc5] nvme nvme0: controller is down; will reset:
 CSTS=0xffffffff, PCI_STATUS=0x10
Message-ID: <Y/Y2mJALiaNxZrX+@kbusch-mbp.dhcp.thefacebook.com>
References: <CABXGCsMiKe31UaoMV02gW4iJSKnBiO5jGQKej=Zem24mD0ObQw@mail.gmail.com>
 <YnNeTsSzFJqEK/s+@kbusch-mbp.dhcp.thefacebook.com>
 <CABXGCsPStDr8M6v2jCvC2mKOXf6wV1+_tNORPNkTTgToYbWRFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsPStDr8M6v2jCvC2mKOXf6wV1+_tNORPNkTTgToYbWRFw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 06:59:59PM +0500, Mikhail Gavrilov wrote:
> On Thu, May 5, 2022 at 10:19 AM Keith Busch <kbusch@kernel.org> wrote:
> 
> > The troubleshooting steps for your observation is to:
> >
> >   1. Turn off APST (nvme_core.default_ps_max_latency_us=0)
> >   2. Turn off APSM (pcie_aspm=off)
> >   3. Turn off both
> >
> > Typically one of those resolves the issue.
> 
> What to do if none of these steps helped? I attached log which proves
> that I am using both parameters nvme_core.default_ps_max_latency_us=0
> and pcie_aspm=off .

Those are just the most readily available things we can tune at
this level that has helped on *some* platform/device combinations.
Certainly not going to solve every problem.

You are showing that the driver can't read from the device's memory,
and there's nothing the driver can do about that. This is usually
some platform bios breakage well below the visibility of the nvme
driver.

Perhaps your platform's bridge windows are screwed up. One other
thing you can try is adding param "pci=nocrs" to have the kernel
ignore ACPI when setting these up.
