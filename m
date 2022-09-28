Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF7D5EE4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiI1TOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiI1TOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:14:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB41D4DC7;
        Wed, 28 Sep 2022 12:13:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5C37DCE1F79;
        Wed, 28 Sep 2022 19:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C75C433D6;
        Wed, 28 Sep 2022 19:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664392435;
        bh=pwdpaHy4JfFsu1FhFw+lb4jAa9ctSa587IaYVjG346A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kekBmyizrwLU4Bb7ZghMcKJLqaAM7DS5Mj1mXUok+G/cwsZu4oBNpQ2zxTP47YaE8
         elMRowzgOD/0jZAIxpvjaG9qa8DcEDVP9JARRRClbbl9MGxZ+dV0fyqrw+EGomoXdL
         hnwoZNx9TRgikCVqu2vd7hjZtnCiEz1lJOYO1j3Xba214+nXlOg0+J11a/wgmdqqTr
         AReP0pFcQoBBQrgAPhbqze59HaiX7uNwdNY/oVkrPptv9/S/yqQaP+IMxPrYdW+Izd
         Ikegucxc1JzGfzetgY2aCW1Ix0uA52BtKwUcSwvTLYye6ORa8Tgy2UYxZDv3WclL8t
         fZRcd15XrhQtg==
Date:   Wed, 28 Sep 2022 12:13:53 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <yujie.liu@intel.com>, lkp@intel.com,
        aik@ozlabs.ru, linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, chenzhongjin@huawei.com,
        llvm@lists.linux.dev, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, lkp@lists.01.org, mingo@redhat.com,
        Sathvika Vasireddy <sv@linux.ibm.com>, rostedt@goodmis.org,
        jpoimboe@redhat.com, naveen.n.rao@linux.vnet.ibm.com,
        mbenes@suse.cz, linuxppc-dev@lists.ozlabs.org
Subject: Re: [objtool] ca5e2b42c0: kernel_BUG_at_arch/x86/kernel/jump_label.c
Message-ID: <20220928191353.yu2o7rhkhpi3n74z@treble>
References: <20220912082020.226755-12-sv@linux.ibm.com>
 <202209280801.2d5eebb5-yujie.liu@intel.com>
 <YzRr23Bn6qFDC7j0@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzRr23Bn6qFDC7j0@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 08:44:27AM -0700, Nathan Chancellor wrote:
> This crash appears to just be a symptom of objtool erroring throughout
> the entire build, which means things like the jump label hacks do not
> get applied. I see a flood of
> 
>   error: objtool: --mnop requires --mcount
> 
> throughout the build because the configuration has
> CONFIG_HAVE_NOP_MCOUNT=y because CONFIG_HAVE_OBJTOOL_MCOUNT is
> unconditionally enabled for x86_64 due to CONFIG_HAVE_OBJTOOL but
> '--mcount' is only actually used when CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
> is enabled so '--mnop' gets passed in without '--mcount'. This should
> obviously be fixed somehow, perhaps by moving the '--mnop' addition into
> the '--mcount' if, even if that makes the line really long.
> 
> A secondary issue is that it seems like if objtool encounters a fatal
> error like this, it should completely fail the build to make it obvious
> that something is wrong, rather than allowing it to continue and
> generate a broken kernel, especially since x86_64 requires objtool to
> build a working kernel at this point.

Grrr... I really dislike that objtool is capable of bricking the kernel
like this.  We just saw something similar in RHEL.

IMO, we should just get rid of this "short JMP" feature in the jump
label code, those saved three bytes aren't worth the pain.

But yes, we do need to fix that config issue.

And yes, maybe fatal objtool warnings should cause a build failure.  We
used to do that, but it brought a different sort of pain.  But if
objtool is going to be in the kernel's critical boot path then I guess
we have to do that.

-- 
Josh
