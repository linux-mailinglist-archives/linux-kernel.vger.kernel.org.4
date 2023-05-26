Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8730771273A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbjEZNKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243407AbjEZNKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F09D13A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 242E364FAC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DA5C433EF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685106611;
        bh=k2BJ0HikbjM2TWyiQ0EXj0kBBlObywlG1rbIpGgKzNU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SsnusJ0cFLd5bvMz0Sam5z3CUNM2k8dG7A34E85D+JOoaU6X3jYkWIRIDbBON4+61
         PcgGy4DTRpEsdEf9P2X2LMY9NLAvh+nkldBlrbefHUkOVjqjtEnv9gr6FoN90t8HVc
         f/erV8v1EodUVntx6HlHq/cGHcAb6mW0v30na6qaaNvHowev7EGYqiZJoLkwAtydHu
         XRPLE/Kj3z9bkj/CbF9P7bZczVN1B557p5C8GVptdo1G9i+AZrzGd2NrFZ6WycryrP
         ppz9hL1bu1h5zbH77Kghcjyh6GPdCN1lqrf7b4JRxGmovplwdRW/00Ro2yR5s1sbTP
         GMeIbXXC+p31A==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2af2d092d7aso7604081fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:10:11 -0700 (PDT)
X-Gm-Message-State: AC+VfDyLBFQfVEmH9zJzOYs+AohIwCeYkOL0xrB5eYuDEfDNTbqLj8RF
        tJYnxMjiDt6hjjGDQ3+5okvJHgYHCB7n68q7Brk=
X-Google-Smtp-Source: ACHHUZ6C+T9gLAa1zrB+an4OSimYQlmTD88YkPyIWI/b0Lv6NS78ngMtRAEv98k6oX6InN75YFLZJyvSPbzUMNH+Ykg=
X-Received: by 2002:a2e:3206:0:b0:2ad:d6cd:efe0 with SMTP id
 y6-20020a2e3206000000b002add6cdefe0mr630827ljy.37.1685106609205; Fri, 26 May
 2023 06:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
In-Reply-To: <20230526010748.1222-1-masahisa.kojima@linaro.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 26 May 2023 15:09:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEN0naaKAzGKBsJaL7LKa_4b+iP=g9YLcBK8qxZxy1C-A@mail.gmail.com>
Message-ID: <CAMj1kXEN0naaKAzGKBsJaL7LKa_4b+iP=g9YLcBK8qxZxy1C-A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] introduce tee-based EFI Runtime Variable Service
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023 at 03:08, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> This series introduces the tee based EFI Runtime Variable Service.
>
> The eMMC device is typically owned by the non-secure world(linux in
> this case). There is an existing solution utilizing eMMC RPMB partition
> for EFI Variables, it is implemented by interacting with
> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> and tee-supplicant. The last piece is the tee-based variable access
> driver to interact with OP-TEE and StandaloneMM.
>
> Changelog:
> v4 -> v5
> - rebase to efi-next based on v6.4-rc1
> - set generic_ops.query_variable_info, it works as expected as follows.
> $ df -h /sys/firmware/efi/efivars/
> Filesystem      Size  Used Avail Use% Mounted on
> efivarfs         16K  1.3K   15K   8% /sys/firmware/efi/efivars

Excellent, thanks a lot for double checking that.

Jens, did you have any feedback on this? If not, I intend to queue it
up for v6.5

Thanks,

>
> v3 -> v4:
> - replace the reference from EDK2 to PI Specification
> - remove EDK2 source code reference comments
> - prepare nonblocking variant of set_variable, it just returns
>   EFI_UNSUPPORTED
> - remove redundant buffer size check
> - argument name change in mm_communicate
> - function interface changes in setup_mm_hdr to remove (void **) cast
>
> v2 -> v3:
> - add CONFIG_EFI dependency to TEE_STMM_EFI
> - add missing return code check for tee_client_invoke_func()
> - directly call efivars_register/unregister from tee_stmm_efi.c
>
> rfc v1 -> v2:
> - split patch into three patches, one for drivers/tee,
>   one for include/linux/efi.h, and one for the driver/firmware/efi/stmm
> - context/session management into probe() and remove() same as other tee
> client driver
> - StMM variable driver is moved from driver/tee/optee to driver/firmware/efi
> - use "tee" prefix instead of "optee" in driver/firmware/efi/stmm/tee_stmm_efi.c,
>   this file does not contain op-tee specific code, abstracted by tee layer and
>   StMM variable driver will work on other tee implementation.
> - PTA_STMM_CMD_COMMUNICATE -> PTA_STMM_CMD_COMMUNICATE
> - implement query_variable_store() but currently not used
> - no use of TEEC_SUCCESS, it is defined in driver/tee/optee/optee_private.h.
>   Other tee client drivers use 0 instead of using TEEC_SUCCESS
> - remove TEEC_ERROR_EXCESS_DATA status, it is referred just to output
> error message
>
> Masahisa Kojima (3):
>   efi: expose efivar generic ops register function
>   efi: Add EFI_ACCESS_DENIED status code
>   efi: Add tee-based EFI variable driver
>
>  drivers/firmware/efi/Kconfig                 |  15 +
>  drivers/firmware/efi/Makefile                |   1 +
>  drivers/firmware/efi/efi.c                   |  12 +
>  drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
>  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 638 +++++++++++++++++++
>  include/linux/efi.h                          |   4 +
>  6 files changed, 906 insertions(+)
>  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
>  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
>
> --
> 2.30.2
>
