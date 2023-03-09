Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8FA6B27D2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCIOws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjCIOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:52:07 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F92BDDF32
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1678373423;
        bh=q3h2JpVV9jvpnNd5XNlFvcxvCJfVVeO6QkeNJYdNwLg=;
        h=Subject:From:To:Cc:Date:From;
        b=TfvV3zsT0Po6dvLlQYHwawUQ66qz06Mzv+wMhiHJSaaihds62FfSxj66jKHJyupIH
         aF4AJpmchzT/sYrnb7NG83zrQJbwBr5w4vBm7sj09Yudj+uig1xmdWOkZM8ShnvOs5
         UmFBRl6Mt/9XyEOPN4gBjEkI+GXhDdCN8Uz7lBRw=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id E2F7266318;
        Thu,  9 Mar 2023 09:50:22 -0500 (EST)
Message-ID: <dbef7b89aa65887bda1a59dc37602385416828b5.camel@xry111.site>
Subject: PAE + virtio = probe error?
From:   Xi Ruoyao <xry111@xry111.site>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 09 Mar 2023 22:50:21 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using a QEMU VM for testing things on 32-bit x86.  Today I updated
the VM to use Linux kernel 6.2.2, and a strange issue happened: both
virtio block driver and virtio network driver fail to probe with errors
like:

[    0.950474] virtio_blk virtio1: virtio: device uses modern interface but=
 does not have VIRTIO_F_VERSION_1
[    0.951669] virtio_blk: probe of virtio1 failed with error -22

I spent some time debugging the issue, and it turned out if I disable
CONFIG_X86_PAE, the virtio drivers would function normally.  But then I
can only use 4GB RAM in the VM.

Is this a bug or I'm doing something wrong?  The command to start the VM
is:

qemu -enable-kvm                     \
     -smp 8                          \
     -cpu host                       \
     -m 16G                          \
     -drive file=3Ddisk.img,if=3Dvirtio  \
     -boot menu=3Don                   \
     -net nic,netdev=3Dnet0,model=3Dvirtio-net-pci            \
     -netdev user,id=3Dnet0            \
     -device ac97                    \
     -vga std                        \
     -serial mon:stdio               \
     -name "32_bit_x86"              \
     -pflash /usr/share/qemu/edk2-x86_64-code.fd

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
