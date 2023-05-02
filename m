Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DF76F45C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjEBOHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjEBOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:07:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13AC1FC9
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 07:07:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68957622C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 14:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F29C4339E;
        Tue,  2 May 2023 14:07:44 +0000 (UTC)
Date:   Tue, 2 May 2023 15:07:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Justin Forbes <jforbes@fedoraproject.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jmforbes@linuxtx.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Revert arm64: drop ranges in definition of
 ARCH_FORCE_MAX_ORDER
Message-ID: <ZFEZLZHBosQK9xaH@arm.com>
References: <20230428153646.823736-1-jforbes@fedoraproject.org>
 <ZEv76qfIiJcUvdql@arm.com>
 <ZE1pcwi95nPdlKzN@kernel.org>
 <CAFbkSA3SzjWZ_Q8XC6-_Kzc+jmUN6sG7vzbSD5X1bRvPUaJg3Q@mail.gmail.com>
 <ZE3mdYajdFnvl1by@kernel.org>
 <CAFbkSA0O-4YgNt-7KPhvx+vhvRNc38PO8E--GVAWKVgHK-_9Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFbkSA0O-4YgNt-7KPhvx+vhvRNc38PO8E--GVAWKVgHK-_9Mw@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 04:24:38PM -0500, Justin Forbes wrote:
> On Sat, Apr 29, 2023 at 11:02 PM Mike Rapoport <rppt@kernel.org> wrote:
> > Why the default MAX_ORDER was not acceptable on arm64 server machines but
> > it is fine on, say, x86 and s390?
> > I'm not asking how you made it possible in Fedora and RHEL, I'm asking why
> > did you switch from the default order at all.
> 
> Because the MAX_ORDER on aarch64 with 4K pages is more tuned to the
> needs of the average edge client, not so much those of a server class
> machine.  And I get it, I would say well over 90% of the Fedora users
> running aarch64 are indeed running on a rPi or similar with a small
> memory footprint, and workloads which match that.  But we do support
> and run a 4K page size aarch64 kernel on proper server class hardware,
> running typical server workloads, and RHEL has a lot more users in the
> server class than edge clients.   RHEL could probably default to 64K
> pages, and most users would be happy with that. Fedora certainly could
> not. 

I was talking to Marc Zyngier earlier and he reckons the need for a
higher MAX_ORDER is the GIC driver ITS allocation for Thunder-X. I'm
happy to make ARCH_MAX_ORDER higher in defconfig (12, 13?) if
CONFIG_ARCH_THUNDER. Mobile vendors won't enable this platform.

Regarding EXPERT, we could drop it and do like the other architectures
but we'll have randconfig occasionally hitting weird values that won't
build (like -1). Not sure EXPERT helps here.

-- 
Catalin
