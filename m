Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76893621A57
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiKHRWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiKHRWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:22:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CD2E1C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:22:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 722FFB81BE0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 17:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A90C433D6;
        Tue,  8 Nov 2022 17:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667928166;
        bh=EBlNNpN7MBm+O+67jLDhlUEULw61dZCE5Kh/19OPtsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3Qn0KdLF8TnGQvdKxzEauemDFC/wJjbGcUAsuoXqGm1H36vKWC7fz1uyQ4ja4gLL
         PtObRw8k5Io4fyWl8tVoH5XD69mYqJG3gVg5EwelDTjWg+DYw6KaSCjH7/lWOl7XgB
         /stqFfGY64EpQB3676Sum/0Ri3ngvLCUB5XbL+Wgf3PkesWmp2wcTUqyXp9tYNHtvo
         0JyvRUdJxSjeLycb1ViilsqYRjwmmCjrfM72A91yI6W38k+dS4SjjxLoHn22bcsLAi
         XZsiBILFlLJO7XDy+bw5izIso/JaPxCgIeKYx5kMRh3DMLYT4VpjptwDY0AlU0OTPl
         ItckxP0D//rpg==
Date:   Tue, 8 Nov 2022 17:22:40 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Vineet Gupta <vineetg@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Chris Stillson <stillson@rivosinc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v12 04/17] riscv: Add vector feature to compile
Message-ID: <Y2qQYAfZL7I2qXoo@spud>
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-4-stillson@rivosinc.com>
 <87zgd2d6j1.fsf@all.your.base.are.belong.to.us>
 <f4887649-3933-0a65-7ed5-1bf6bd842a46@rivosinc.com>
 <Y2oLkQSdCBJPvZW/@wendy>
 <95287691-752f-5920-2dbc-b9a5b144d0ac@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95287691-752f-5920-2dbc-b9a5b144d0ac@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 09:17:26AM -0800, Vineet Gupta wrote:
> On 11/7/22 23:56, Conor Dooley wrote:
> > On Mon, Nov 07, 2022 at 04:04:28PM -0800, Vineet Gupta wrote:
> > > +CC Andy, Conor
> > > 
> > > On 11/7/22 09:21, Björn Töpel wrote:
> > > > > +config VECTOR
> > > > > +	bool "VECTOR support"
> > > > > +	depends on GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
> > > > > +	default n
> > > > > +	help
> > > > > +	  Say N here if you want to disable all vector related procedure
> > > > > +	  in the kernel.
> > > > > +
> > > > > +	  If you don't know what to do here, say Y.
> > > > > +
> > > > > +endmenu
> > > > "VECTOR" is not really consistent to how the other configs are named;
> > > > RISCV_ISA_V, RISCV_ISA_VECTOR, RISCV_VECTOR?
> > > 
> > > Good point, I've changed it to RISCV_ISA_V to keep it consistent with
> > > existing RISCV_ISA_C.
> > 
> > Hey Vineet, kinda randomly replying here but the wording makes it look
> > like you're going to take this patchset on?
> > If so, please check out v10 (think it was from April) as there are some
> > comments on that version that IIRC remain un-resolved.
> 
> Sure thing. Although I only see a few from Christoph and kernel build bot.

Yup, they were minor - I just don't wanna see them get lost :)

