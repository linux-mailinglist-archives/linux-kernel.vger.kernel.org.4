Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE606893F0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjBCJe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjBCJey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:34:54 -0500
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF661C580
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1675416862; bh=GlGVwWemaTv9wxXmIiCPESQ0KUcHH+OiHbxiUkvkm/A=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=LnNxXgI15WmHzxM7j+mcDQLR4hn1USAgC0xdofHy8qoC5S6f8+52TAzeqVUpCZyAF
         rd7+nbsVrhNtkxvO+jn4Kqj3eudf8Vi9B3qEr1v9jhOzgGznEVQrrsyu/eOFCF2Oqo
         IIqv++rNrgWhjsdTzclIMZXsxeAkOEF3NVgyMVXWP2MUtFEh1R9JQRDwtlq2xKkqJ7
         Zh/Af5XxCg+lezg3h+XeXZfwZw4XQJEK3v+MmrOzJLa/kDjSarqZMG6/rFYCd7YSW4
         CzOLmi2tN3lVyYMv1MRFYv1V/1oFHXxnWl6AXuGlRaDIwXVjlrtLTlaTpkmtuHYWfv
         7qpWsfMc8gyog==
Received: by gentwo.de (Postfix, from userid 1001)
        id 85E59B0067C; Fri,  3 Feb 2023 10:34:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 84EFEB00210;
        Fri,  3 Feb 2023 10:34:22 +0100 (CET)
Date:   Fri, 3 Feb 2023 10:34:22 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/5] mm/vmstat: use cmpxchg loop in cpu_vm_stats_fold
In-Reply-To: <Y9vcpO5Dh2G3Y6ib@tpad>
Message-ID: <5615572-974e-74cc-6c34-1de618b777cf@gentwo.de>
References: <20230201195013.881721887@redhat.com> <20230201195104.460373427@redhat.com> <fb371ac-cf69-28a6-eca0-6caccda4e0b8@gentwo.de> <Y9vcpO5Dh2G3Y6ib@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2023, Marcelo Tosatti wrote:

> > I thought you would only run this while the kernel is not active on the
> > remote cpu? Then you dont need any cmpxchg and you can leave the function
> > as is.
>
> The remote cpu can enter kernel mode while this function executes.

Isnt there some lock/serializtion to stall the kernel until you are done?

> There is no mode which indicates userspace cannot enter the kernel.

There are lot of thinngs that happen upon entry to the kernel. I would
hope that you can do something there. Scheduler?


