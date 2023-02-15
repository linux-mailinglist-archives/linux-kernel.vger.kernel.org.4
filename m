Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2C069839E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBOSnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBOSm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:42:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0344D3CE3E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:42:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75C93B81F86
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687FEC433EF;
        Wed, 15 Feb 2023 18:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676486486;
        bh=jdvkUbDeD0+NjKmqBpzFb3SJxoDKFX9S+eNEcnraNH4=;
        h=From:Subject:Date:To:Cc:From;
        b=PDt6O2zX0ayjES6ktMzzKb5kguyA1gM3lcFdMyIAKSrpr753+jnhbXBD035CjrB+d
         dZpYWfnFBbXKdyKFZd2BzlRgI8UyjfyU/7epoHMBblzNdNS/382sV1CEOg6h1hq2pS
         ckEWIEm9XoBW72njizL2GTHFhL7ofcx7t7SWsMAlAn6Uhb2yskSV6am4gAhGSB1y7f
         BaV7lU+A646s3/btf83QsZ0fIzt4Wm8mwwtHJseJJNzIKCAMRJla2/6c2BFd0amEdW
         7V0PYMPEjBNdRSg6n7W+lDZs7hrMTsoBt5kSFO/tW+CnmcJcaCHpPCIfmxVyxKRwob
         pfn1toSYhmE1w==
From:   Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/3] Allow CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2 with ld.lld
 15+
Date:   Wed, 15 Feb 2023 11:41:14 -0700
Message-Id: <20230118-ppc64-elfv2-llvm-v1-0-b9e2ec9da11d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEon7WMC/x2NywrDIBAAfyXsuQtqSvr4ldLDatZGMFZ2ixRC/
 r2mx2EYZgNlSaxwHzYQbknTu3SwpwHCQuXFmObO4IwbjbVXrDVMZ+Qcm8Oc24rjjWcK08VHQ9A
 zT8rohUpYjnAl/bAcogrH9P2/Hs99/wG6U831ewAAAA==
To:     mpe@ellerman.id.au
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        erhard_f@mailbox.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=nathan@kernel.org;
 h=from:subject:message-id; bh=jdvkUbDeD0+NjKmqBpzFb3SJxoDKFX9S+eNEcnraNH4=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDMlv1UPOxtVaN/z3qfsy05LNTCRq2ycBTRbuiE729ZnVz
 Ck9/R0dpSwMYhwMsmKKLNWPVY8bGs45y3jj1CSYOaxMIEMYuDgFYCKxRxgZJrgdiSo786p/9oc3
 O8X/rOv+Kf0gyefDienPg7cy2e1cZMPI0LJ57/R2oc8n/VivJmyZEp43LWBun5W4cIXZ9DrvjHd
 ezAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2 is not selectable with
ld.lld because of an explicit dependency on GNU ld, due to lack of
testing with LLVM.

Erhard was kind enough to test this option on his hardware with LLVM 15,
which ran without any issues. This should not be too surprising, as
ld.lld does not have support for the ELFv1 ABI, only ELFv2, so it should
have decent support. With this series, big endian kernels can be built
with LLVM=1.

This has seen our basic set of powerpc configurations with clang-15,
clang-16, and clang-17 but I will never be opposed to more testing :)

The first two patches fix a couple of issues I noticed while build
testing and the final patch actually allows the option to be selected.

---
Nathan Chancellor (3):
      powerpc/boot: Only use '-mabi=elfv2' with CONFIG_PPC64_BOOT_WRAPPER
      powerpc: Fix use of '-mabi=elfv2' with clang
      powerpc: Allow CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2 with ld.lld 15+

 arch/powerpc/Kconfig       | 3 +--
 arch/powerpc/Makefile      | 4 +---
 arch/powerpc/boot/Makefile | 6 +++---
 3 files changed, 5 insertions(+), 8 deletions(-)
---
base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
change-id: 20230118-ppc64-elfv2-llvm-39edac67bf0a

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

