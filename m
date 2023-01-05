Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AAC65F36C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbjAESGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjAESFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:05:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C765BA37;
        Thu,  5 Jan 2023 10:04:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D557B81BAE;
        Thu,  5 Jan 2023 18:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56603C433EF;
        Thu,  5 Jan 2023 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672941865;
        bh=qgLRdj60mW8eOCCU8IOIvx4YirE72RALiIrG9dhDlsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZeOPl0nlhGR+rHDtz9tedHiTqc/L3K1MVUN1WY6RAiunwqvgZ8Gqb/9S8jsWIUjy
         Z+/ThuUlri5WUDMU6mmdzZ0lZw4/jhroRoWbuKL62e3LUUnVxQrG+YIHmzorKbeR41
         eNEqNqUmFZIaYj7/OFsGdZgpH1c5gTEJTQYcrKgZdS8HUQWgIE1AMZqpu7aCBiqh6D
         K67Hj55YGC+dWIsjh+AK/1oBC4ogj9scScF+yoHd2yWZlNhtLZNBjhfRROoexxMmgB
         Py0Rvx5mZQykzQG4VeCbQzdVS7Yj64G0jqtemSJsNilk7GiTpdxSsaO0ygPc/HGGK4
         R3A6LkwaJ5mIw==
Date:   Thu, 5 Jan 2023 11:04:23 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-s390@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, llvm@lists.linux.dev,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: next: clang-15: s390x-linux-gnu-ld: BFD (GNU Binutils for
 Debian) 2.35.2 assertion fail ../../bfd/elf64-s390.c:3349
Message-ID: <Y7cRJ8xh/LLT9kk0@dev-arch.thelio-3990X>
References: <CA+G9fYu6=N4OU11CcHqh5auVJ4WdrR4QmovHjni-z88N41y8zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYu6=N4OU11CcHqh5auVJ4WdrR4QmovHjni-z88N41y8zw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Thu, Jan 05, 2023 at 10:19:23PM +0530, Naresh Kamboju wrote:
> The s390 clang-15 build failures on Linux next-20230105 due to following
> errors / warnings.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> `.exit.text' referenced in section `__jump_table' of fs/fuse/inode.o:
> defined in discarded section `.exit.text' of fs/fuse/inode.o
> `.exit.text' referenced in section `__jump_table' of fs/fuse/inode.o:
> defined in discarded section `.exit.text' of fs/fuse/inode.o
> `.exit.text' referenced in section `__bug_table' of crypto/algboss.o:
> defined in discarded section `.exit.text' of crypto/algboss.o
> `.exit.text' referenced in section `__bug_table' of drivers/scsi/sd.o:
> defined in discarded section `.exit.text' of drivers/scsi/sd.o
> `.exit.text' referenced in section `__jump_table' of drivers/md/md.o:
> defined in discarded section `.exit.text' of drivers/md/md.o
> `.exit.text' referenced in section `__jump_table' of drivers/md/md.o:
> defined in discarded section `.exit.text' of drivers/md/md.o
> `.exit.text' referenced in section `.altinstructions' of
> drivers/md/md.o: defined in discarded section `.exit.text' of
> drivers/md/md.o
> `.exit.text' referenced in section `.altinstructions' of
> drivers/md/md.o: defined in discarded section `.exit.text' of
> drivers/md/md.o
> `.exit.text' referenced in section `.altinstructions' of
> net/iucv/iucv.o: defined in discarded section `.exit.text' of
> net/iucv/iucv.o
> `.exit.text' referenced in section `__bug_table' of
> drivers/s390/cio/qdio_thinint.o: defined in discarded section
> `.exit.text' of drivers/s390/cio/qdio_thinint.o
> `.exit.text' referenced in section `__bug_table' of
> drivers/s390/net/qeth_l3_main.o: defined in discarded section
> `.exit.text' of drivers/s390/net/qeth_l3_main.o
> `.exit.text' referenced in section `__bug_table' of
> drivers/s390/net/qeth_l3_main.o: defined in discarded section
> `.exit.text' of drivers/s390/net/qeth_l3_main.o
> s390x-linux-gnu-ld: BFD (GNU Binutils for Debian) 2.35.2 assertion
> fail ../../bfd/elf64-s390.c:3349
> make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
> make[2]: Target '__default' not remade because of errors.
> make[1]: *** [Makefile:1252: vmlinux] Error 2

Thank you for the report! This has been reported and discussed in a few
different places on the mailing list with various solutions:

https://lore.kernel.org/Y7Jal56f6UBh1abE@dev-arch.thelio-3990X/
https://lore.kernel.org/20230102225656.GA3532398@roeck-us.net/

https://lore.kernel.org/20230105031306.1455409-1-masahiroy@kernel.org/
https://lore.kernel.org/20230105132349.384666-1-mpe@ellerman.id.au/
https://lore.kernel.org/CAMj1kXHqQoqoys83nEp=Q6oT68+-GpCuMjfnYK9pMy-X_+jjKw@mail.gmail.com/

For the future, if you are able to bisect to the change that caused the
failure, you can devise a more targeted Cc list and potentially find
some of this information out beforehand, which would allow more threads
to stay together.

The PowerPC build failure that you reported around the same time as this
one has the same root cause.

Cheers,
Nathan
