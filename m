Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5785BC522
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiISJNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiISJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:13:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05B325297;
        Mon, 19 Sep 2022 02:13:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F843B81683;
        Mon, 19 Sep 2022 09:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E35EC433D6;
        Mon, 19 Sep 2022 09:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663578791;
        bh=V2N6Hc4OEc+ltlU1q+NbI7yUBCpUoVbXk8iMszXa1OM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sLUApOQL9mRQ+a4nkShGX1JjETbhzXss7ZHAghtoAGEi+W69c0V8pMCnLO5LE2emt
         sV1z+ADfqTo5QJmeFaTtlQqv4qW/hjQuqVHoN9srJb6HD9BCEUjiezpkq6SFpTqKh4
         Uv074Z7lc+0oGRqA/dRQYTp5dZKTxaLEzYBm5SKWUY5MRdllXKwG3kAUVwn3qn5siS
         PLXTuT3TiIvudAr8TCrGsBTTpEHNm4r0ik7tMIia/MQt+BcG5vECeFthvkagqu2aqZ
         2yHit6xeh/GLKlLSKwpH+yop2lA7ls2OMGbtZq3g35J7m+Vt90KVLEDCKBjEqSHca7
         6GpyXv3Xdz0cw==
Received: by mail-lf1-f48.google.com with SMTP id a8so45805045lff.13;
        Mon, 19 Sep 2022 02:13:10 -0700 (PDT)
X-Gm-Message-State: ACrzQf3o+Z/orjtMBMijfentKUzncjbqdgCPaauTga14dOjj+t94isWq
        iVRmM1dbgK53K2PeXRWUQsCsj/Bz7SOffW1BpaU=
X-Google-Smtp-Source: AMsMyM73dBJTImjoWAwsVnb4NVBokcROyl4XiaAKGB17jVLi1eVbJgVW+hcHktXJzON9eILENswSWvWCTnfH0bFkz3Q=
X-Received: by 2002:ac2:4431:0:b0:497:aaf5:83eb with SMTP id
 w17-20020ac24431000000b00497aaf583ebmr5720184lfl.228.1663578789018; Mon, 19
 Sep 2022 02:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220919191126.4a3c36f9@canb.auug.org.au>
In-Reply-To: <20220919191126.4a3c36f9@canb.auug.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 19 Sep 2022 11:12:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFKm2A=zNHRSWtWkwBXWM=tQD=x+Q6-Mv_a66qopiXkjQ@mail.gmail.com>
Message-ID: <CAMj1kXFKm2A=zNHRSWtWkwBXWM=tQD=x+Q6-Mv_a66qopiXkjQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the efi tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sept 2022 at 11:11, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the efi tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>
> x86_64-linux-gnu-ld: drivers/firmware/efi/libstub/x86-stub.stub.o:(.bss.efistub+0x8): multiple definition of `efi_system_table'; drivers/firmware/efi/libstub/systable.stub.o:(.bss.efistub+0x0): first defined here
>
> Presumably caused by commit
>
>   8fd3c9a90998 ("efi/libstub: move efi_system_table global var into separate object")
>
> (or maybe commit
>
>   ba2dd31b7588 ("efi/libstub: implement generic EFI zboot")
> )
>
> I have used the efi tree from next-20220916 for today.
>

Thanks for the report. I'll take a look and fix this asap.
