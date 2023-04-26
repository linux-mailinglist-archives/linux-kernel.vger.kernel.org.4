Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512E66EF9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjDZSDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjDZSD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:03:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F0A76B4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:03:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31FFD60AD6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 18:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B1BC433EF;
        Wed, 26 Apr 2023 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682532203;
        bh=+gW1t81U43qlS5mrFEoNWpIN3Xj6kQ4n1Ya1m0H/TZM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E2j0xqYkPWi5fEnslDzuxsDLRjDYUDqdpIATJn9fY/9QzPsmDJDt/aApF4d9BBt9D
         6t1HgIyT+lK8nDkUS5E5JkeaD8TOTpMbLmaGQYSICWokjcwSyG8LnLFkiKC54sHrvE
         Y5+Ph0W7mDiuCMuboy9fODRaxV7c1f1kowB3JW7ekonbOlrxLw+8tGR4HkbV2tpBZd
         Cm0jT13m5Lf6YbeOydL7vQY6B8QN77xcaZqLlKHFbovdPqNRRuP5J6byucB5Tsshoz
         V+SKdMdBQhN4vMZ0KPMyDkKhzIf7kTL4+7gzmLf52DC1T62o2lCiWzZUDzTTbTYGZS
         CsCGlpZlwDuqQ==
Message-ID: <af2b2e0246c970d59e67b746eacc9b9a129cfde0.camel@kernel.org>
Subject: Re: [Syzkaller & bisect] There is WARNING in tpm_chip_unregister in
 upstream patch "tpm: st33zp24: Mark ACPI and OF related data as maybe
 unused"
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pengfei Xu <pengfei.xu@intel.com>, l.sanfilippo@kunbus.com
Cc:     linux-kernel@vger.kernel.org, jgg@ziepe.ca, heng.su@intel.com,
        peterhuewe@gmx.de, dhowells@redhat.com, lkp@intel.com
Date:   Wed, 26 Apr 2023 21:03:19 +0300
In-Reply-To: <1b67d480-d6f1-965f-ccfa-0874eb9a3b6b@linaro.org>
References: <ZEjqhwHWBnxcaRV5@xpf.sh.intel.com>
         <1b67d480-d6f1-965f-ccfa-0874eb9a3b6b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-26 at 15:12 +0200, Krzysztof Kozlowski wrote:
> On 26/04/2023 11:10, Pengfei Xu wrote:
> > Hi Jarkko and Krzysztof Kozlowski,
> >=20
> > Greeting!
> >=20
> > Platform: x86 platforms
> >=20
> > There is WARNING in tpm_chip_unregister in upstream patch "tpm: st33zp2=
4: Mark
> > ACPI and OF related data as maybe unused":
> > https://lore.kernel.org/lkml/20230424144130.1084795-1-jarkko@kernel.org=
/
> > -> https://lore.kernel.org/lkml/20230319141354.22907-1-krzysztof.kozlow=
ski@linaro.org/
> >=20
> > We tested Intel internal kernel and found that, the above patch caused =
below
> > WARNING and then kernel BUG dmesg info. After reverted above commit on =
top
> > of Intel internal kernel, this issue was gone.
> > I checked that internal commit:"c3985d8b9c22 tpm: st33zp24: Mark ACPI a=
nd OF
> > related data as maybe unused" was same as above link patch.
> > This issue could be reproduced in 155s in VM.
> >=20
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main=
/230426_132902_tpm_chip_unregister_warning
> > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/b=
lob/main/230426_132902_tpm_chip_unregister_warning/repro.c
> > Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkall=
er_logs/blob/main/230426_132902_tpm_chip_unregister_warning/repro.prog
> > Syzkaller analysis report: https://github.com/xupengfe/syzkaller_logs/b=
lob/main/230426_132902_tpm_chip_unregister_warning/repro.report
> > Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_13=
2902_tpm_chip_unregister_warning/kconfig_origin
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/23042=
6_132902_tpm_chip_unregister_warning/bisect_info.log
> >=20
> > "
> > [   24.638052] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=
=3D329 'systemd'
> > [   28.731375] cgroup: Unknown subsys name 'net'
> > [   28.741433] cgroup: Unknown subsys name 'rlimit'
> > [   35.900833] tpm tpm0: Operation Canceled
> > [   35.901377] ------------[ cut here ]------------
> > [   35.901648] refcount_t: addition on 0; use-after-free.
> > [   35.901986] WARNING: CPU: 0 PID: 4095 at lib/refcount.c:25 refcount_=
warn_saturate+0xe6/0x1c0
>=20
> Thanks for the report. I am quite surprised that this commit was pointed
> as possible cause. The patch does not touch anything related to reported
> issue... At least I do not see it. Could be some tooling problem in your
> reproduction steps?

I see a critical bug in this commit.

Because only tpm_tis_core calls tpm_chip_startup(), in effect none of this
code is ever executd for e.g. tpm_crb and tpm_vtpm_proxy and some other
drivers that are not based on TIS/FIFO specification.

Lino, can you submit a fix re-enabling non-tpm_tis drivers?

BR, Jarkko
