Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD475FAD9C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJKHjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:39:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE267D785
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AB7F6112D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FE5C433C1;
        Tue, 11 Oct 2022 07:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665473967;
        bh=/Ldq9v8soB6HiHZnmN/eTehQkAxq1vqVxPyWHGez8Rg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrXkDlX86Cu2XWFhwHdoOLrhDIS7yMQFQaeY+ao1DvuQ+b4sXm2Hco2M2OWnO/+aS
         rzCMban25RWo5untMMHT4Fq9V9/wpQkBg2SoeR2bDjLQ+sVSnM7OcKW56xNbsqrLzH
         MdXKXusjwaNmPITGHGvSTcNs+iP1bpCsb0dIbjTUrDvQwuptp/3Q0fArVH8lADTUAA
         Xz+ssfU+qbUCIhxqmaXD3AUmbgJpF08TGtOpHYfgPLYUczlQWwQ84tj89qAYL3kjD4
         hTuYv+MmP3bV1jMe56se2//PjMywO8as9Dt7eqaP8PH8yPW2+8hfFH96OpZgtQ76cM
         Ly7K6F1ur9khg==
Date:   Tue, 11 Oct 2022 08:39:23 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mfd: syscon: Remove repetition of the
 regmap_get_val_endian()"
Message-ID: <Y0Udqwp9j1HNEwn8@google.com>
References: <Y0GZwkDwnak2ReTt@zx2c4.com>
 <20221008154700.404837-1-Jason@zx2c4.com>
 <CAHk-=wiqN9EJ6zKXh21EQ2CV-B7_oDJKy73+yhRwtbNMWCzfVA@mail.gmail.com>
 <Y0HKeTWneX12OP+Y@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y0HKeTWneX12OP+Y@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Oct 2022, Andy Shevchenko wrote:

> On Sat, Oct 08, 2022 at 09:45:16AM -0700, Linus Torvalds wrote:
> > On Sat, Oct 8, 2022 at 8:47 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > This reverts commit 72a95859728a7866522e6633818bebc1c2519b17. It broke
> > > reboots on big-endian MIPS and MIPS64 malta QEMU instances, which use
> > > the syscon driver. Little-endian is not effected, which means likely
> > > it's important to handle regmap_get_val_endian() in this function after
> > > all.
> > 
> > Hmm. The revert may indeed be the right thing to do, but we're still
> > early in the release process, so let's go through the channels.
> > 
> > I do note that commit 72a95859728a points to commit 0dbdb76c0ca8
> > ("regmap: mmio: Parse endianness definitions from DT") as the reason
> > why it's not necessary any more, but that commit
> > 
> >  (a) doesn't seem to set config->val_format_endian (which somebody may
> > care about). It does set the operation pointers etc, but doesn't set
> > that field.
> 
> It should.
> 
> of_syscon_register() calls to regmap_init_mmio() with syscon_config data
> structure as a parameter.
> 
> Before 72a95859728a the of_syscon_register() fills the val_format_endian with
> something it parses from DT. After that commit the default value (0) is
> REGMAP_ENDIAN_DEFAULT. Now when __regmap_init_mmio_clk() is called it
> creates a context base on DT since the field is 0.
> 
> >  (b) it uses regmap_get_val_endian(), which doesn't actually even look
> > at the OF properties unless config->val_format_endian is
> > REGMAP_ENDIAN_DEFAULT
> 
> Which is 0!
> 
> > so the code that commit 72a95859728a removed was actually quite a bit
> > different from the code in commit 0dbdb76c0ca8.
> > 
> > Maybe the problem is related to those semantic differences, and is
> > easy to fix for somebody who knows what the heck that stuff is doing.
> 
> But while looking into this, I think I know what is going on,
> of_syscon_register() calls regmap API with dev == NULL, hence
> fwnode == NULL, hence nothing to read from DT.
> 
> But default (via regmap bus configuration) is LE and LE works fine.
> 
> > And if not, please just send me the revert through the normal channels. Ok?
> 
> Yeah, revert is a good move here.

Could you review and provide a tag for the revert patch please?

-- 
Lee Jones [李琼斯]
