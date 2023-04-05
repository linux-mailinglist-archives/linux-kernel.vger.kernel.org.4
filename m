Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0936D7DF7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbjDENog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbjDENoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:44:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1304261B3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:44:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 821D0628B4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB38BC433D2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680702259;
        bh=FS+AGi5qUs6DfUvOjsQUAC8iTrpMCMFw7bPCXSd8rcg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PgwwztpNsMIU0+xlaOl2RbS12B6Kq63ZTS+YsEPOmpPbUkAnR2bLA6pM7i9lRyC16
         eJg5jLiGTb2ClSs4kDM3fCDbTTOyStPaZQBYyjd5U3EBoDXLtdnr7VOgrkNGdCFkfK
         HAra0vTxAW1tUapyPfKuFS+Z81MUjahZnJMfCdl1c42C9Kg6w3bxRV7jSmai9dM/XJ
         IqHGnisEpYSPne+aT9BHC0GQu8wY5Ff/o6eDOxS1RAWusprc/+ioZuuwhqg4/y5NVA
         QYWSVb2Qb1O0E/g4QrqfHxiqTsgrubu2Mi0mbLu082ivGLP3hhfil6HY+ucVssMuRf
         9i5fKxNSnmqkg==
Received: by mail-lf1-f53.google.com with SMTP id h11so39733231lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 06:44:18 -0700 (PDT)
X-Gm-Message-State: AAQBX9eQtFMC955Yniqx7hN+ey5LcDV4RnSW1f6uucgj04BcfvmVbTpU
        qK0facAAiEDvz+uB3oDUZa8x+DQRBdAgp3tgtK4=
X-Google-Smtp-Source: AKy350b8+ZAhqSbmmlqLlFTEuDVvZVG6K1GNCk6fzfwUnOh2P2lGd2uyWSVcDLBLtJ+Fb5UhyzKmlKLHpBeBcE/Ilbk=
X-Received: by 2002:ac2:43ce:0:b0:4e9:8c46:32ad with SMTP id
 u14-20020ac243ce000000b004e98c4632admr1900972lfl.9.1680702256857; Wed, 05 Apr
 2023 06:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <cover.1680628986.git.thomas.lendacky@amd.com> <1d38d28c2731075d66ac65b56b813a138900f638.1680628986.git.thomas.lendacky@amd.com>
 <20230404174506.pjdikxvk2fsyy4au@box.shutemov.name> <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
 <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name> <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
 <20230404202445.6qkl7hz67qgievqz@box.shutemov.name> <CAMj1kXFrm74+zNcSpHJ1kw38PTMOFk1cTx_EAoGFHaG1fYzRTQ@mail.gmail.com>
 <20230404210153.tll2mojlglx4rfsa@box.shutemov.name> <CAMj1kXGvcg-E84h1T_vPi7qxPWxEXBpyuB79KOL+ON7v5YAgJg@mail.gmail.com>
 <e46777d3-adea-90a2-afc4-35f9d7cef50c@intel.com>
In-Reply-To: <e46777d3-adea-90a2-afc4-35f9d7cef50c@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 5 Apr 2023 15:44:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEDYa5YcRj7t9JJmQ21+ierue2q6ADOXUOMjoOGndGRug@mail.gmail.com>
Message-ID: <CAMj1kXEDYa5YcRj7t9JJmQ21+ierue2q6ADOXUOMjoOGndGRug@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 at 15:00, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 4/5/23 00:46, Ard Biesheuvel wrote:
> > Once the firmware stops exposing this protocol (and ceases to accept
> > memory on the OS's behalf), we can phase it out from the kernel as
> > well.
>
> This is a part of the story that I have doubts about.
>
> How and when do you think this phase-out would happen, realistically?
>
> The firmware will need the unaccepted memory protocol support as long as
> there are guests around that need it, right?
>

Current firmware will accept all memory on behalf of the OS unless the
OS invokes the protocol to prevent it from doing so.

Future firmware will simply never accept all memory on behalf of the
OS, and not expose the protocol at all.

So the difference of opinion mainly comes down to whether or not the
intermediate, first step is needed or not.

Unenlightened OS kernels will not invoke the protocol, and will
therefore need current firmware in order to see all of their memory.

Enlightened OS kernels will invoke the protocol unless it does not
exist, and so will be able to accept their memory lazily both on
current and future firmware.

We will be able to move to future firmware once we no longer need to
support unenlightened kernels.

> People like to keep running old kernels for a _long_ time.  Doesn't that
> mean _some_ firmware will need to keep doing this dance for a long time?
>

Yes.

> As long as there is firmware out there in the wild that people want to
> run new kernels on, the support needs to stay in mainline.  It can't be
> dropped.

The penalty for not calling the protocol on firmware that implements
it is a much slower boot, but everything works as it should beyond
that.

Given that the intent here is to retain compatibility with
unenlightened workloads (i.e., which do not upgrade their kernels), I
think it is perfectly reasonable to drop this from mainline at some
point.
