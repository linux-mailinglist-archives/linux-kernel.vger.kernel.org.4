Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533D773D98A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjFZIXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFZIXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:23:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ED795;
        Mon, 26 Jun 2023 01:22:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6431860D24;
        Mon, 26 Jun 2023 08:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59B9C433CB;
        Mon, 26 Jun 2023 08:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687767778;
        bh=P3+JV6+Pn1MuKtmU6/nLqOAPWXJCPA/e3Ct5ze9xX9w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UPy8Yc+LKOA9er8GGm/aH8bjiBPMrWQAPWrEvbPSAqpA8/uaKVfzGHFw6PLs06QiZ
         DzynlleyBjlGZJpOBqOtSLywu2BNftjemBLXRiGuw9WgVNQ9jwRnjiLRovYoyC/AGv
         x13rbO9JIdwK21T5lsY+O84KkZDQfcLj0QhIJAhAds0Y4NM78GD5uaCKhzplmmo/dQ
         jAzx67DiwY3LaEb7E7f4tRvz4e9W2DCTYfBpbCbysGSmWU6R9IvKB/AXeCrjlyphz/
         9B3c57xMGnORmHCVwjc+Ugl+dUS9iOzp4pJItsTjvTA9Kh/zxOky5rERa3kx7JUO+m
         AbNHpk3dv3vyA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f8777caaa1so3805898e87.3;
        Mon, 26 Jun 2023 01:22:58 -0700 (PDT)
X-Gm-Message-State: AC+VfDwvblg464Zws8SHfzm+W+yA/nCfUtFB7O9QrTJXVhVBT1GbeS3Q
        1zeZap4GmfhQAGoyx55R1g9bq3vVCD68wYOgWfQ=
X-Google-Smtp-Source: ACHHUZ6V992UdonyD1tdbLNjlWaFnubF9o6xFj75lGF04s3z9bepvio5LoGeebXmGXTYbkJlfuLdaCAhMfLauflN8LA=
X-Received: by 2002:a19:ab12:0:b0:4f9:5933:8ee8 with SMTP id
 u18-20020a19ab12000000b004f959338ee8mr8109583lfe.32.1687767776741; Mon, 26
 Jun 2023 01:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <CAP6exY+tqAU0j1TVEMTzTb18M6_mPH5bWWiAS=94gyDGTY3hyQ@mail.gmail.com>
 <CAEEQ3w=wBdpZWnUd2WWVBC3BtFiUp-PQtNAtdXE4cO4n0XT-fg@mail.gmail.com>
 <CAMj1kXFGpXEPtYpy1+bs13F2P_LLZf9rTMfYMU=6jzgd3=SEcw@mail.gmail.com>
 <CAEEQ3wnbXE0vJnQRLo5MhfDc-Q4PbNWBoWS-oMn71CcJU51JdA@mail.gmail.com>
 <CAMj1kXHfqkU2QxvjTkGBSkEcTf_HirbdOReOJwdpgz3hM8fBHw@mail.gmail.com>
 <CAEEQ3wn2n48TpNQ3MuvrRH4zzg28SaiOswunPeZ01jFm-TbJ5w@mail.gmail.com>
 <CAMj1kXHgaLD43jx0f6hn_j209LGT_4G+w5XEGaYB9znV5p9tdA@mail.gmail.com>
 <CAP6exYJRE8iM63SX3hQP9_5aKYcnN5x0KOAtZOgeEWU5bwLEBA@mail.gmail.com>
 <CAEEQ3wn2zHUZP8gs8ezCczQLdQJqU6MqAgpcG0YeDW2aYTz0TA@mail.gmail.com>
 <CAMj1kXFn7+W=ZGNcSLL6p383SbA8=wstutJ85+qvXzt2G66Seg@mail.gmail.com> <CAEEQ3wnXJVBLdqW6GRFuCKuBtr38uKHz7E2+P8TAv1_+b6kBKA@mail.gmail.com>
In-Reply-To: <CAEEQ3wnXJVBLdqW6GRFuCKuBtr38uKHz7E2+P8TAv1_+b6kBKA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 26 Jun 2023 10:22:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFAsG0nH+2OcG3CBZYqKg=hCRHp8wAmVBFy9vNx6rWgOQ@mail.gmail.com>
Message-ID: <CAMj1kXFAsG0nH+2OcG3CBZYqKg=hCRHp8wAmVBFy9vNx6rWgOQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Cc:     ron minnich <rminnich@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>,
        =?UTF-8?B?6Z+m5Lic?= <weidong.wd@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 at 10:05, =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@byteda=
nce.com> wrote:
>
> Hi Ard,
>
> On Mon, Jun 26, 2023 at 2:43=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
>
> > I think all of this belongs under arch/riscv
>
> Could you look at the content of the patch again? As we discussed
> before, we need to connect to the ACPI and the SMBIOS entry
> At least this part of the code has to be placed in the corresponding plac=
e:
> drivers/acpi/osl.c: acpi_os_get_root_pointer()
> drivers/firmware/dmi_scan.c:dmi_scan_machine()
>
> Because obtaining firmware information through DTS belongs to the
> content of the driver firmware, it is appropriate to put this piece of
> code in drivers/firmware/ffi.c.
>
> So I insist on the current revision, what do you think?
>

DT support for SMBIOS can live in generic code, but the binding has to
be sane. As I suggested before, it probably makes sense to supplant
the entrypoint rather than just carry its address - this means a 'reg'
property with base and size to describe the physical region, and at
least major/minor/docrev fields to describe the version.

In any case, there is really no point in supporting both entrypoints
(this applies to the ACPI root pointer as well).

For the ACPI side, you should just implement
acpi_arch_get_root_pointer() under arch/riscv, and wire it up in
whichever way you want. But please check with the RISC-V maintainers
if they are up for this, and whether they want to see this mechanism
contributed to one of the pertinent specifications.

So NAK on the current revision, in case this was unclear.
