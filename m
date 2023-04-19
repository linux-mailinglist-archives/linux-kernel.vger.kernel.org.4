Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6986E7F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 18:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjDSQRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 12:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjDSQRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 12:17:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E0C2698
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 09:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4652640C0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 16:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CE2C433D2;
        Wed, 19 Apr 2023 16:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681921036;
        bh=dMNtXuqea4V7TaN2gT5Bxv8+XCBlK0wjj+o7l4xp8Eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCT+TGX3lYp3+3+VGx7WXJzgLflD/TA03tHGZv1KD8Gyj1Jk+AaBI9WMGEBwcVsBO
         rXwabFayRVmfcHKmuWiURJkpsxnGXIJ2ayNxvBnMvlo0aJHxZv4HMC5CPejveILe9X
         6hDgllcj/KxBPgSRnxpnZX44C2kk/HYcefAAMVMWLcLv/CUVo6XTdnhhoixXPwBs+T
         ItCNPGun0doCP5bjWHQakNr2q+F6d8ag9KYsCt9IC+F+0JwODUscvJuwhfbPGJkqVq
         6WECRO7lMgwRbRJRd1fZ2vfBFeVFaEHF8hV+2yrYatQHzE+4VOC8lfvy3WuLld7MWT
         ySc0oKPJU6Y0w==
Date:   Wed, 19 Apr 2023 09:17:13 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Chen Zhongjin' <chenzhongjin@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "akpm@linux-foudation.org" <akpm@linux-foudation.org>,
        "ben-linux@fluff.org" <ben-linux@fluff.org>,
        "wuchi.zero@gmail.com" <wuchi.zero@gmail.com>
Subject: Re: [PATCH 1/2] x86: profiling: remove lock functions hack for
 !FRAME_POINTER
Message-ID: <20230419161713.qtmnnt5n64c2vvmm@treble>
References: <20230410022226.181812-1-chenzhongjin@huawei.com>
 <20230410022226.181812-2-chenzhongjin@huawei.com>
 <d416428f-c846-b6b9-74da-f3571d92d38a@intel.com>
 <1ceb1769-f01b-c417-e912-4ee1149dd0cb@huawei.com>
 <4c601a93e55341fc8cff766af43cb5e6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c601a93e55341fc8cff766af43cb5e6@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 10:01:18AM +0000, David Laight wrote:
> From: Chen Zhongjin
> > Sent: 12 April 2023 08:02
> ...
> > > 4. !CONFIG_FRAME_POINTER is probably even more rare today than it was in
> > >     2006
> >
> > No. !CONFIG_FRAME_POINTER is more common today because of UNWINDER_ORC.
> > And that is why the bug is triggered more frequently.
> 
> CONFIG_FRAME_POINTER is pretty much required (on x86-64)
> for the user copy checks that are enabled in distro kernels.

CONFIG_FRAME_POINTER is pretty much deprecated.  The only distro still
using it (that I know of) is Ubuntu.

-- 
Josh
