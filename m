Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88326FC56B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjEILxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbjEILxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4602736;
        Tue,  9 May 2023 04:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDD7A64609;
        Tue,  9 May 2023 11:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D8EC4339B;
        Tue,  9 May 2023 11:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683633181;
        bh=iDUKUbZirpdLT/vnKcBM+kYSe00R/wpZnwcBAxCQbnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1bPOiZKnSFiLiLDtQ3LlokHgGQOjwFeqjF2sJvt61xfBfEyxxAwUd9YekZxf2TGN
         QgrM9ySmN7DbaweowOOlrfViqNK3SKTeMw+V0NttIAXV8og+4XWQPPpMNGjVs+1pPZ
         TOI/DTI3R096tlA5EZ32dSL9UBuVu8uT5fx+axy6nDcLMhThlu1+kFlzkxHu9l0Tlx
         Cj66TLJ/YtYuVIm+3SGnqt8hxlZjaTTa2e8xwE8AuXR2sZGqcbHDBjLmyCYY7GNNv9
         iW4uHJgbgTczFJ/+gIHD3YjCte+cisebQsAvK1K6PPweCbLsNmNb5RRgjtQjCqt6eC
         bUMJ3jAAQThkQ==
Date:   Tue, 9 May 2023 13:52:57 +0200
From:   Simon Horman <horms@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        kexec@lists.infradead.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: kexec: include reboot.h
Message-ID: <ZFo0Gd/Eucw/0gtC@kernel.org>
References: <20230508-parisc-kexec-include-reboot-v1-1-78a155a8a0a4@kernel.org>
 <ZFoL9ntYCCfZFCNs@bhe.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFoL9ntYCCfZFCNs@bhe.users.ipa.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 05:01:42PM +0800, Baoquan He wrote:
> On 05/09/23 at 09:01am, Simon Horman wrote:
> > Include reboot.h in machine_kexec.c for declaration of
> > machine_crash_shutdown and machine_shutdown.
> > 
> > gcc-12 with W=1 reports:
> > 
> >  arch/parisc/kernel/kexec.c:57:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
> >     57 | void machine_crash_shutdown(struct pt_regs *regs)
> >        |      ^~~~~~~~~~~~~~~~~~~~~~
> >  arch/parisc/kernel/kexec.c:61:6: warning: no previous prototype for 'machine_shutdown' [-Wmissing-prototypes]
> >     61 | void machine_shutdown(void)
> >        |      ^~~~~~~~~~~~~~~~
> > 
> > No functional changes intended.
> > Compile tested only.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
> We may need to find out the places in all architectures and fix all of
> them.

I did check. It seemed to be needed for riscv, m68k and parisc.
I've sent out patches for all three. But I may have missed something.
