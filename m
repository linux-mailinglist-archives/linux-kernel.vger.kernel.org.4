Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE6C722531
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjFEMFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFEMFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:05:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DD092
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 05:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F12861157
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4EAC433EF;
        Mon,  5 Jun 2023 12:05:02 +0000 (UTC)
Date:   Mon, 5 Jun 2023 13:04:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shaoqin Huang <shahuang@redhat.com>
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] arm64: mops: handle MOPS exceptions
Message-ID: <ZH3Pa/Ct3XX613Yj@arm.com>
References: <20230509142235.3284028-1-kristina.martsenko@arm.com>
 <20230509142235.3284028-8-kristina.martsenko@arm.com>
 <628463d5-b9df-51bd-8e1f-b0a41a928d85@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <628463d5-b9df-51bd-8e1f-b0a41a928d85@redhat.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 07:43:27PM +0800, Shaoqin Huang wrote:
> Hi Kristina,
> 
> On 5/9/23 22:22, Kristina Martsenko wrote:
> > The memory copy/set instructions added as part of FEAT_MOPS can take an
> > exception (e.g. page fault) part-way through their execution and resume
> > execution afterwards.
> > 
> > If however the task is re-scheduled and execution resumes on a different
> > CPU, then the CPU may take a new type of exception to indicate this.
> > This is because the architecture allows two options (Option A and Option
> > B) to implement the instructions and a heterogeneous system can have
> > different implementations between CPUs.
> > 
> > In this case the OS has to reset the registers and restart execution
> > from the prologue instruction. The algorithm for doing this is provided
> > as part of the Arm ARM.
> 
> What is the Arm ARM? I'm not quite understand it.

The Arm Architecture Reference Manual:

https://developer.arm.com/documentation/ddi0487/latest

(the acronym we pretty well known among the arm/arm64 developers)

-- 
Catalin
