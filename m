Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459EA6DCC06
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjDJUMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJUMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:12:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F5610DD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:12:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681157522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vdW463lMrSIv6E0tgsiWW1gHVmKWpAD6pFZXhTowmDg=;
        b=Qx6ain5zpkrw9c0mIzTsdZJ2CziF6CqWWukuvArgsC4szGXpIxgHH/QINUH69+TsLjxssH
        ZtxAQFYwuObC448FwupWmc7cUrlmNSCsooOlcluSRtZZY6pYhdU1BzpiCRzn6PbD3KizpC
        4L7T1dbr7DA9xUiX9gIYM06Sfvfta2AfHmq2q35mD6ZAtj2jcPQDNrmZzdvmzJ8GMApr5/
        iGlCfU6kuA3lVF3/mkvgmYEof908j9ue1JEDCXtEoce6c8IjDMHZkEJXk6Xcu/CUbBu0+W
        UGBgV1oE9MTEaT3pNQ3m6Qwa6IBMyht89rhKb2igK55qXqX/QkuQS/OYHXhnqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681157522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vdW463lMrSIv6E0tgsiWW1gHVmKWpAD6pFZXhTowmDg=;
        b=qCqxFj5jAYh3BVZhm6uZMnl5peEQBRM5008KIMURBjiOGz05/O+U/0Y2t9lJJYalfATkJu
        tJYspYOL2pZ2mQAA==
To:     Ye Bin <yebin@huaweicloud.com>, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, linux-mm@kvack.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Cc:     linux-kernel@vger.kernel.org, dchinner@redhat.com,
        yebin10@huawei.com, yebin@huaweicloud.com
Subject: Re: [PATCH v2 1/2] cpu/hotplug: introduce 'num_dying_cpus' to get
 dying CPUs count
In-Reply-To: <20230406015629.1804722-2-yebin@huaweicloud.com>
References: <20230406015629.1804722-1-yebin@huaweicloud.com>
 <20230406015629.1804722-2-yebin@huaweicloud.com>
Date:   Mon, 10 Apr 2023 22:12:02 +0200
Message-ID: <87bkjv1oq5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06 2023 at 09:56, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
> Introduce '__num_dying_cpus' variable to cache the number of dying CPUs
> in the core and just return the cached variable.

Why?

That atomic counter is racy too if read and acted upon w/o having CPUs
read locked.

All it does is making the race window smaller vs. the cpumask_weight()
based implementation. It's still racy and incorrect.

So no, this is not going to happen.

Thanks,

        tglx


