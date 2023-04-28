Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A236F1116
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 06:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbjD1EpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 00:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjD1EpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 00:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B2A2696
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 21:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E49B63EA7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10820C433EF;
        Fri, 28 Apr 2023 04:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682657102;
        bh=Omj+SL5zqTsoKaLqrqXUY1PyXUHPTRyCAvEul9HQv8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHTufx1BvoVAN/sP7vEbGBBVMysIynmpWajofD1UGvid6AhWj2FUZRXJ0bTTnJTsF
         HgpW12cAND2I2MiUMCYJSNk3LIJHYUGwtdrHoGk9oZ2+OyQGKHAhMfski6Q/YKUNYV
         CLi5r+zu4Cb4Yrp8tofpBJV/KJI5fYAO2hBzSEpRR+MtQAgBK5/5FulPnZ5Wd0eLia
         TraRD9gPr886vQD34GrZfNXaczVbUFQFEPKoR8WVZeOD7Q5dSaWH9RFXV5MawPFKSg
         6Wd6V4TWu32cwHTlj9chgegk7nV35Eo/QVjZfkVDl/KZKh6QXRBiV7c/uvfWSOxS3n
         OvILD//WJ3zWQ==
Date:   Thu, 27 Apr 2023 21:45:00 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, ak@linux.intel.com, David.Laight@ACULAB.COM
Subject: Re: [PATCH v3] x86: profiling: remove lock functions profiling in
 profile_pc
Message-ID: <20230428044500.h5eaabiezuw7duxr@treble>
References: <20230423012744.24320-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230423012744.24320-1-chenzhongjin@huawei.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 09:27:44AM +0800, Chen Zhongjin wrote:
> Syzbot has been reporting the problem of stack-out-of-bounds in
> profile_pc for a long time:
> https://syzkaller.appspot.com/bug?extid=84fe685c02cd112a2ac3
> 
> profile_pc will get return address for caller if current function
> is lock function. For !CONFIG_FRAME_POINTER it uses a hack way to get
> the caller by directly reading sp[0] or sp [1].
> It not works when KASAN is enabled because KASAN pushes data on stack
> which makes sp[0/1] become KASAN red zone. Then profile_pc reads wrong
> memory and triggers KASAN warning frequently.
> 
> This hack might be ok when first added at 2006 but now it's different:
> 
> 1. There are some lock functions which have frame longer than two stack
> slots. For these functions sp[0/1] is not a legal return address even
> KASAN is not enabled.
> 2. !CONFIG_FRAME_POINTER is more used today because UNWINDER_ORC.
> 3. Lock function caller information can be prfiled by perf better.
> 
> Since profile as a low level facility it's not proper to depend on
> complex generic unwinder to get the next frame. As lock profiling is
> no longer useful, it's fine to remove it.

In that case we can remove the in_lock_functions() check from all the
other arches' implementations of profile_pc().

-- 
Josh
