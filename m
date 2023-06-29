Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC52174221C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjF2I07 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 04:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjF2I0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:26:20 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EE0297B;
        Thu, 29 Jun 2023 01:26:13 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-991f9148334so12140366b.1;
        Thu, 29 Jun 2023 01:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688027172; x=1690619172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcoeEMptu8D0NAxYrvJpfZG4mBLFHI5XmeFegUh6FYE=;
        b=CC8+rYb0uYVafBn83zDBSVUkusGMjpwoF2PrpwBETV5LNbH6oGz+yaT7sZb7icBSGk
         zb0xGL/MtkZX7bsbz8NRe4LR3x3b979TZmNfenc6aAkDLumn6Ha57/QDtCObbRI1czvR
         J6kp8Frj9fj6Nk7K3ZgWS99n+hdzlRjhzL8c8LJbmNGCloVnQeEZNXynFMFeuIE2UARm
         bNWITDUyQHtYGbEg2Wh++6K64kUc4RnKnhFf5Wp2SORqCgDqvo4n5VFHwVWhtLvSNkVH
         Ca5CepIutG/yKa/94M8BUg94Ox1RfOzxB/m3QtqO6q/wRoGmJmsQjLyTXjqBhO2b6pzQ
         /bSQ==
X-Gm-Message-State: AC+VfDxxEpqCkQHa/e4tA503T60blDlHwbfJMxsiw3d7SlZkCoJTTKrL
        usZIPDc7sW/QfZtvBATfZ62InhbG909Mw/qt+3Q=
X-Google-Smtp-Source: ACHHUZ5I1YUITTiwuNaGJRhEAVUxvdz45PNbS+KgIsVW0LO/GbPa8OHkL/ixpQy58lXWNknd7Fzke4lYgKnwJTVvR1E=
X-Received: by 2002:a17:906:73dd:b0:989:1ed3:d00b with SMTP id
 n29-20020a17090673dd00b009891ed3d00bmr20500149ejl.4.1688027171871; Thu, 29
 Jun 2023 01:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230626220525.1654780-1-abmainkar@nvidia.com>
In-Reply-To: <20230626220525.1654780-1-abmainkar@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 10:26:00 +0200
Message-ID: <CAJZ5v0iE4MtjnBWwq0dS7x8B8AsZS0sJFfO6fRwtLJOfUhbEUg@mail.gmail.com>
Subject: Re: [Patch] acpica: Add AML_NO_OPERAND_RESOLVE flag to Timer
To:     Abhishek Mainkar <abmainkar@nvidia.com>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 12:10 AM Abhishek Mainkar <abmainkar@nvidia.com> wrote:
>
> According to the ACPI specification 19.6.134, no argument is
> required to be passed for ASL Timer instruction. For taking
> care of no argument, AML_NO_OPERAND_RESOLVE flag is added to
> ASL Timer instruction opcode.
>
> When ASL timer instruction interpreted by ACPI interpreter,
> getting error. After adding AML_NO_OPERAND_RESOLVE flag to
> ASL Timer instruction opcode, issue is not observed.
>
> =============================================================
> UBSAN: array-index-out-of-bounds in acpica/dswexec.c:401:12
> index -1 is out of range for type 'acpi_operand_object *[9]'
> CPU: 37 PID: 1678 Comm: cat Not tainted
> 6.0.0-dev-th500-6.0.y-1+bcf8c46459e407-generic-64k
> HW name: NVIDIA BIOS v1.1.1-d7acbfc-dirty 12/19/2022 Call trace:
>  dump_backtrace+0xe0/0x130
>  show_stack+0x20/0x60
>  dump_stack_lvl+0x68/0x84
>  dump_stack+0x18/0x34
>  ubsan_epilogue+0x10/0x50
>  __ubsan_handle_out_of_bounds+0x80/0x90
>  acpi_ds_exec_end_op+0x1bc/0x6d8
>  acpi_ps_parse_loop+0x57c/0x618
>  acpi_ps_parse_aml+0x1e0/0x4b4
>  acpi_ps_execute_method+0x24c/0x2b8
>  acpi_ns_evaluate+0x3a8/0x4bc
>  acpi_evaluate_object+0x15c/0x37c
>  acpi_evaluate_integer+0x54/0x15c
>  show_power+0x8c/0x12c [acpi_power_meter]
>
> Signed-off-by: Abhishek Mainkar <abmainkar@nvidia.com>

ACPICA changes need to be submitted as pull requests to the upstream
ACPICA project on GitHub.

Once you have submitted an ACPICA pull request, please resend the
corresponding Linux patch with a Link: tag pointing to that pull
request.

Thanks!

> ---
>  drivers/acpi/acpica/psopcode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/psopcode.c b/drivers/acpi/acpica/psopcode.c
> index bef69e87a0a2..8c34c0ffb1d9 100644
> --- a/drivers/acpi/acpica/psopcode.c
> +++ b/drivers/acpi/acpica/psopcode.c
> @@ -603,7 +603,7 @@ const struct acpi_opcode_info acpi_gbl_aml_op_info[AML_NUM_OPCODES] = {
>
>  /* 7E */ ACPI_OP("Timer", ARGP_TIMER_OP, ARGI_TIMER_OP, ACPI_TYPE_ANY,
>                          AML_CLASS_EXECUTE, AML_TYPE_EXEC_0A_0T_1R,
> -                        AML_FLAGS_EXEC_0A_0T_1R),
> +                        AML_FLAGS_EXEC_0A_0T_1R | AML_NO_OPERAND_RESOLVE),
>
>  /* ACPI 5.0 opcodes */
>
> --
> 2.17.1
>
