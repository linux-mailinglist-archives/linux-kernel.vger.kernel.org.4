Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA04616FD4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiKBVdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiKBVdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:33:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB376594
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE03161C4B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E53C433D6;
        Wed,  2 Nov 2022 21:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667424794;
        bh=8cJlPuX9KORwrRCS43g+lWrI3lYT3ryduTT5NHnhsxk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j87avb9KFFvWqE8oox9WQx6FuI8b5CdDyi1bi1LBnP/fqG9zgYlAb0tcoFWU0a1dk
         GVunEsCdSua/Zokpg1E/ETEtNXLiXKLc/uL/DhzffEZtImpeMb767bubnxLE2fbzzv
         Oxf1K26mK7n6zwrGhd9HTh4fJUMGex7L3nshFQ4U=
Date:   Wed, 2 Nov 2022 14:33:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     wuqiang <wuqiang.matt@bytedance.com>
Cc:     mhiramat@kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, mattwu@163.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] kprobes,lib: kretprobe scalability improvement
Message-Id: <20221102143312.a1b09fe962e8e1057fd4a872@linux-foundation.org>
In-Reply-To: <20221102023012.6362-1-wuqiang.matt@bytedance.com>
References: <20221101014346.150812-1-wuqiang.matt@bytedance.com>
        <20221102023012.6362-1-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Nov 2022 10:30:12 +0800 wuqiang <wuqiang.matt@bytedance.com> wrote:

> Tests of
> kretprobe throughput show the biggest ratio as 333.9x of the original
> freelist.

Seriously.

I'll add this for some runtime testing.

Are you able to identify other parts of the kernel which could use
(and benefit from) the new objpool?
