Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8C5BD5F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiISU4x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Sep 2022 16:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiISU4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:56:50 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884114BA4F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:56:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 20A7E63BBD39;
        Mon, 19 Sep 2022 22:56:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CXropBphbfZn; Mon, 19 Sep 2022 22:56:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2412B63BBD41;
        Mon, 19 Sep 2022 22:56:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6lDz_60MzvkD; Mon, 19 Sep 2022 22:56:45 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id EFA3763BBD39;
        Mon, 19 Sep 2022 22:56:44 +0200 (CEST)
Date:   Mon, 19 Sep 2022 22:56:44 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Randy Dunlap <rdunlap@infradead.org>,
        davidgow <davidgow@google.com>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        tglx <tglx@linutronix.de>, mingo <mingo@redhat.com>,
        dave hansen <dave.hansen@linux.intel.com>,
        torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kunit-dev@googlegroups.com, x86 <x86@kernel.org>
Message-ID: <437983532.241061.1663621004742.JavaMail.zimbra@nod.at>
In-Reply-To: <39e063ad-208d-f5f0-9807-eedcf0db1692@infradead.org>
References: <20220823010830.2675419-1-davidgow@google.com> <39e063ad-208d-f5f0-9807-eedcf0db1692@infradead.org>
Subject: Re: [PATCH] arch: um: Mark the stack non-executable to fix a
 binutils warning
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: arch: um: Mark the stack non-executable to fix a binutils warning
Thread-Index: zdAqwB2k00Llj9CfHPRJhRE7IrjHTg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Randy Dunlap" <rdunlap@infradead.org>
>> Link:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ffcf9c5700e49c0aee42dcba9a12ba21338e8136
>> Link:
>> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=ba951afb99912da01a6e8434126b8fac7aa75107
>> Signed-off-by: David Gow <davidgow@google.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

This patch causes a build error on one of my systems:

/usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-linux/bin/ld: unrecognized option '--no-warn-rwx-segments'
/usr/lib64/gcc/x86_64-suse-linux/7/../../../../x86_64-suse-linux/bin/ld: use the --help option for usage information
collect2: error: ld returned 1 exit status

Just like in commit ffcf9c5700e4 ("x86: link vdso and boot with -z noexecstack --no-warn-rwx-segments") you need to
test for it.

Thanks,
//richard
