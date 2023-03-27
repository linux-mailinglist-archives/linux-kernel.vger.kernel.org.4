Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F6B6CADC8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjC0Srf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 14:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC0Sre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:47:34 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7B7A3;
        Mon, 27 Mar 2023 11:47:33 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id cn12so40216323edb.4;
        Mon, 27 Mar 2023 11:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679942852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cCHTNdmx+dCtz9EDkrSJRp3w3F7nMooVAktpNgobt0=;
        b=AlCJl78ee+sraSMqlpUqnbt0xyexkjssZmbS6CABhyt3XxzfVOAWqusCCn34PQB5JK
         p+V8/IvL6bHM7Pm2obXh92VOkVs4yh8+gG9V8sYDw5bQPnoKlD+x5zF8rNbH2zu6kgm7
         65KFL/S0c+kwlGwdHB6mZ9jCIkh5G4VYt26QT3yVY1fH+90PzikEdjBYGZpugUQjZX7O
         92laK148dLZjVGABTJm3IQAdAoQEAZCbjahALVElR5hqelRe4ebFSbciDw8f8lqBHclx
         z+QWoKnBZpmhFykinNyiO7K/i7Fx3LtFIVejq4uEkOY5f7/LJjQNdXiOXUAp5oYov75T
         XpqA==
X-Gm-Message-State: AAQBX9edCbzx1B7McH92j0rIgWBiGrWuwYg3Hls3HARuAv4yV7eBAfb9
        uJvitoGYnRamNapxGqC+hUFyLbSBaC6nW7j7T/Y=
X-Google-Smtp-Source: AKy350YI4IY1e3atIoHZawwZ9Y8RzJaMpgrAZR/oQkFZadXFcUZijCDpD+pzAQUHz4OHz1J1p06YSbN2Jha/46qeXm8=
X-Received: by 2002:a17:907:d48d:b0:93e:c1ab:ae67 with SMTP id
 vj13-20020a170907d48d00b0093ec1abae67mr5274858ejc.2.1679942851520; Mon, 27
 Mar 2023 11:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230317073310.4237-1-xueshuai@linux.alibaba.com> <20230323015357.8481-1-xueshuai@linux.alibaba.com>
In-Reply-To: <20230323015357.8481-1-xueshuai@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 20:47:20 +0200
Message-ID: <CAJZ5v0hKGVKt=Nks+74C79CQy2ofBO_rhrPUMxJiohTsYgTHcA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: APEI: EINJ: warn on invalid argument when
 explicitly indicated by platform
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     tony.luck@intel.com, baolin.wang@linux.alibaba.com,
        benjamin.cheatham@amd.com, bp@alien8.de, dan.j.williams@intel.com,
        james.morse@arm.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        zhuo.song@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 2:54 AM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>
> OSPM executes an EXECUTE_OPERATION action to instruct the platform to begin
> the injection operation, then executes a GET_COMMAND_STATUS action to
> determine the status of the completed operation. The ACPI Specification
> documented error codes[1] are:
>
>         0 = Success (Linux #define EINJ_STATUS_SUCCESS)
>         1 = Unknown failure (Linux #define EINJ_STATUS_FAIL)
>         2 = Invalid Access (Linux #define EINJ_STATUS_INVAL)
>
> The original code report -EBUSY for both "Unknown Failure" and "Invalid
> Access" cases. Actually, firmware could do some platform dependent sanity
> checks and returns different error codes, e.g. "Invalid Access" to indicate
> to the user that the parameters they supplied cannot be used for injection.
>
> To this end, fix to return -EINVAL in the __einj_error_inject() error
> handling case instead of always -EBUSY, when explicitly indicated by the
> platform in the status of the completed operation.
>
> [1] ACPI Specification 6.5 18.6.1. Error Injection Table
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> changelog since v1:
> - elaborate commit log based on follow up discussion with Tony
> - pick up Reviewed-by tag of Tony
> ---
>  drivers/acpi/apei/einj.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index b4373e575660..fa0b4320312e 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -489,9 +489,15 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>         if (rc)
>                 return rc;
>         val = apei_exec_ctx_get_output(&ctx);
> -       if (val != EINJ_STATUS_SUCCESS)
> +       if (val == EINJ_STATUS_FAIL)
>                 return -EBUSY;
> +       else if (val == EINJ_STATUS_INVAL)
> +               return -EINVAL;
>
> +       /*
> +        * The error is injected into the platform successfully, then it needs
> +        * to trigger the error.
> +        */
>         rc = apei_exec_run(&ctx, ACPI_EINJ_GET_TRIGGER_TABLE);
>         if (rc)
>                 return rc;
> --

Applied as 6.4 material, thanks!
