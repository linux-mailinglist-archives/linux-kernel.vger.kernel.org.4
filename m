Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57088694F14
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjBMSS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjBMSSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:18:53 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C0A10430;
        Mon, 13 Feb 2023 10:18:52 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id v13so14127118eda.11;
        Mon, 13 Feb 2023 10:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SKYj8OvgCYN/iU7ggdNVrfsLHo704AktG+/S1pLrRM=;
        b=K3MRiipSpAD/B214b/hOEEpY0KRSkEVfZvtw6NgoVoF3cYxVXQTY3dKMPnGuJ9XxFt
         txtUTHUvRDMqGE3hlzlhYvtKJ8IeO8DnC7T56YwrhhiqCdIQocjs2j49EeQGWNvEMkKs
         aSxPqbtuik3a6Sbrkb6wzvnV/c6SJ2i6n2MTE7F5ESxy4mT5El3NwhD7jLuL4QET0TPi
         0FBXBLuOyK2j8EXe9q100WJFD/sfFV4VETMSynAYrVLcVrAs2uGOJZZe9AmxXFMmX7mj
         mAh+VybC/iqRhUm/FqfSSf6XuRbiMwpB853zeoVRFZ/rijaqJHppkkz+XzWcrWAHRoZf
         fE0g==
X-Gm-Message-State: AO0yUKXlrtpxGH9MWbPRBOgSonI7zJxC0Po3p7azzUy+w57lmkzwT8pB
        YWMyl72M+aVZ+8MjIu//t0IcS80vzvX2Z9aIRzs=
X-Google-Smtp-Source: AK7set9Reyndahu2DrUtCmDaatIhuUu5gAV7Emfh6vqL37rzyOSXAa1jV6mMd9aheuf66lKvR5VeRmjBLLCluZnaV+g=
X-Received: by 2002:a50:baab:0:b0:4ac:cdd9:1c97 with SMTP id
 x40-20020a50baab000000b004accdd91c97mr1353074ede.6.1676312331145; Mon, 13 Feb
 2023 10:18:51 -0800 (PST)
MIME-Version: 1.0
References: <20230213165005.2943219-1-rf@opensource.cirrus.com>
In-Reply-To: <20230213165005.2943219-1-rf@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 19:18:39 +0100
Message-ID: <CAJZ5v0g1S8U6+UxzfN5xxzYFB7PZK5V5zdsb3RdJj0sHkYPkTA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Add EXPORT macros for exporting PM functions
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 5:50 PM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add a pair of macros for exporting functions only if CONFIG_PM
> is enabled.
>
> The naming follows the style of the standard EXPORT_SYMBOL_*()
> macros that they replace.
>
> Sometimes a module wants to export PM functions directly to other
> drivers, not a complete struct dev_pm_ops. A typical example is
> where a core library exports the generic (shared) implementation
> and calling code wraps one or more of these in custom code.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  include/linux/pm.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 93cd34f00822..035d9649eba4 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -379,9 +379,13 @@ const struct dev_pm_ops name = { \
>         const struct dev_pm_ops name;                                   \
>         __EXPORT_SYMBOL(name, sec, ns);                                 \
>         const struct dev_pm_ops name
> +#define EXPORT_PM_FN_GPL(name)         EXPORT_SYMBOL_GPL(name)
> +#define EXPORT_PM_FN_NS_GPL(name, ns)  EXPORT_SYMBOL_NS_GPL(name, ns)
>  #else
>  #define _EXPORT_DEV_PM_OPS(name, sec, ns)                              \
>         static __maybe_unused const struct dev_pm_ops __static_##name
> +#define EXPORT_PM_FN_GPL(name)
> +#define EXPORT_PM_FN_NS_GPL(name, ns)
>  #endif
>
>  #define EXPORT_DEV_PM_OPS(name) _EXPORT_DEV_PM_OPS(name, "", "")
> --

Applied as 6.3 material, thanks!
