Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1246194D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiKDKu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiKDKu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:50:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A692B272;
        Fri,  4 Nov 2022 03:50:53 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e72b329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e72b:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F8A81EC02DD;
        Fri,  4 Nov 2022 11:50:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667559052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8WImQ7ZL8KrObKcbD6n0+VmHllyJCHfdjTe3x0R7HQ=;
        b=dN/GvTKKqzlUUDakXZilCZ4uSdGe5CAJbJl40VQolvuHhJtQW1xcdTi0YDrLS0QZB0jMhb
        eQaBUuNsI7Q4vIQY40V9Yc40Te46X3x4T3b1lTvnHpVMUlN4ouXzHpCyZ5uFQO1dFeSUuO
        ij0Xzs8AtZKYfBUg49QCf7gN02IzTqM=
Date:   Fri, 4 Nov 2022 11:50:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Joseph, Jithu" <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com
Subject: Re: [PATCH 07/14] x86/microcode/intel: Expose
 microcode_sanity_check()
Message-ID: <Y2TuhwiGFJ1M1V7u@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-8-jithu.joseph@intel.com>
 <Y2OnHuSHgIMGxcUH@zn.tnic>
 <a4107510-add4-3d85-ed2f-2f5e8c32a350@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4107510-add4-3d85-ed2f-2f5e8c32a350@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:15:12PM -0700, Joseph, Jithu wrote:
> If these doesn’t alleviate your concern, I will post v2 without
> exporting the aforementioned functions and implementing them
> separately in IFS driver as you suggested.

So tglx persuaded me yesterday that we should do code sharing after
all, so that all blob loading remains consistent. So let's try the
cpu/intel.c thing and see what breaks, how and when.

As to patch 8, that metadata checking should not be part of
microcode_intel_sanity_check() but a separate function. Along with
microcode_intel_find_meta_data() - all those should go into the IFS
thing.

When microcode loading ends up really needing metadata, *then*
that functionality should be lifted into a more fitting place like
cpu/intel.c

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
