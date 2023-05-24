Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C72770F006
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjEXH4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239940AbjEXH4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:56:32 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9689E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:56:31 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-437e1f38b34so430215137.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 00:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684914990; x=1687506990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pATV2+EA7wDu3eCWAMeDbjzukVVsv0g+hOiuCnqGpoc=;
        b=Pu8owvzcQNiaTGmS/RUla+ONULdtvXvAz+WHJj6XCB5WXK2M3Cntg1gigoPpoQW6uX
         X9ZwLJe9+cph56AJk81ykjCCRaAPZRkEjqroK8dvmyClSak/EkTrUdyrdVhiNIAttRoG
         WbKoFZQ96gqpCv+cAH/sxqeNNKMykMsYCcUL/pPpNM3vzO1TKVX9pCfJGifoSQl4cwbb
         ayOlV0C9aaP5kLLtPrNe3paGnwho4c/CdhDRTOi1Jg9NinNKM2q4ZY1dJOyo2QfPBmko
         kcjRn4lqB9G7cPgdEEYsbPhyDebP8c2Mqh32lm5Zh0mAWLIbNeXwTRczUH+OtoLhiCBp
         bzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684914990; x=1687506990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pATV2+EA7wDu3eCWAMeDbjzukVVsv0g+hOiuCnqGpoc=;
        b=WzPqsG0HmxShmaw0aHuPNOXOtcZ22mfcVZ3vwxUN0WiVLMz2VVK/re68B7rYbsNwRm
         s+x8h3iZFrekFtNmieM45xYLJEhZEf6Mpk5kvQpimg3OKiP+b5Gsd2moZuIUWM4w9zZ4
         Rs7VCIAuWXnyW24OmdWkcDvaAsz/KTj1Zu+HdVArdtNCjyluLAaPzfjoqC/hEAbgldCo
         MP2FbINckJg1v5drkTL8BUvD7dF8LW+xVWz6YVFNr4+/cH9azFrUYw4Aw3Vsa2N9gjAf
         FkABBOuzMIe6bXMUPIsdUhcTidoxmYJ8DQ0/TKAlZMxK2VhV7dQpKyvNGxu/tf4tUCJF
         WamQ==
X-Gm-Message-State: AC+VfDwjpJ1bXZyCVk2szMn35whW01XnoVrnpxb3Ch49Pd/RBx+vANdW
        4y+infNbXcWjbrIKaxO0OyNWOQfE/jolv1SaLx1oSw==
X-Google-Smtp-Source: ACHHUZ7sdR4tCP9ZOae2DJ83gFNkXve6Lm1s4Q1aGvMRC6vddpQ/v8xW4e8Qmefl0cBH3IEcJa5ojVAErZmOON5JdSg=
X-Received: by 2002:a05:6102:48f:b0:439:61d9:2684 with SMTP id
 n15-20020a056102048f00b0043961d92684mr1251647vsa.33.1684914990108; Wed, 24
 May 2023 00:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230523090607.1433-1-masahisa.kojima@linaro.org>
In-Reply-To: <20230523090607.1433-1-masahisa.kojima@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 24 May 2023 13:26:18 +0530
Message-ID: <CAFA6WYOOEwd=jWk1LEaj9K2GkjfV+kfPYOfwPkJVoWXJKGoQXA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] introduce tee-based EFI Runtime Variable Service
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 at 14:36, Masahisa Kojima
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
> v3 -> v4:
> - replace the reference from EDK2 to PI Specification
> - remove EDK2 source code reference comments
> - prepare nonblocking variant of set_variable, it just returns
>   EFI_UNSUPPORTED
> - remove redundant buffer size check
> - argument name change in mm_communicate
> - function interface changes in setup_mm_hdr to remove (void **) cast

I don't have detailed insights into how EFI spec mandates StandaloneMM
should be implemented. But utilizing OP-TEE as the underlying
transport here looks fine to me. FWIW,

For the series:
Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

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
>  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 637 +++++++++++++++++++
>  include/linux/efi.h                          |   4 +
>  6 files changed, 905 insertions(+)
>  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
>  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
>
> --
> 2.30.2
>
