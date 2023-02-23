Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A406A10DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBWTxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBWTxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:53:32 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7B199E1;
        Thu, 23 Feb 2023 11:53:30 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id ck15so47684610edb.0;
        Thu, 23 Feb 2023 11:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZIzqGdZRyWKbXrRJe16s42mfqNVQ/FkSeeNmQnErqM=;
        b=lvRPP03tU4dnWgRYNKu0JEM13PORJY1vKuuB5XiA7glfzLkdPz3I0oOKWLM8XYjiQh
         F53dgpAygMncMPI/4LtX1/w9njpFut/hC+Df71ntmEgKpjwpCdjAdh2rN3UtHxZAzWep
         hoBKPt50yabk+Ld8m+P1M4UbFIOr6tgwjylw/1H7Cnw9KzJuCym4Qp8yBJHs+jSUdugb
         7tpmNNYZXUEUTVrJgYjRp5A1iL2I+l4ngGZGOA4vefnTdHFeVSv49wAsAfkR7Q+aHTBW
         Naw6Kp2Dmczia3WoXfTPohKsCx8gJ/STCobTWWpiF6FRDUdZOjpiydSWSwqklHDtxUnm
         xq5w==
X-Gm-Message-State: AO0yUKXrAYsQDammqNF06pPuQ8PZfBkJR8BtfU1cVpQA3eojut8ZWD5d
        3JG2/H8FLyKv1zOAMhkgEdXv+g/LjKyrshLQLSxlA1zpJmc=
X-Google-Smtp-Source: AK7set9cwGypVN2kUcpo9eQ91rAglE05AsZTeOthBSGDMurOl7/mHFcktGjvu0nrm+WAf9SgMdXUJi/VjCgjItMWk/E=
X-Received: by 2002:a17:906:195b:b0:8a6:91d9:c7ac with SMTP id
 b27-20020a170906195b00b008a691d9c7acmr10267468eje.5.1677182009048; Thu, 23
 Feb 2023 11:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20230223070252.2029174-1-kai.heng.feng@canonical.com>
In-Reply-To: <20230223070252.2029174-1-kai.heng.feng@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Feb 2023 20:53:17 +0100
Message-ID: <CAJZ5v0iHgsY4rm-mx67bUO7wc3ZXWU48QAXHERLAQyJRtLEi2g@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: amd-pstate: Let user know amd-pstate is disabled
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     ray.huang@amd.com, mario.limonciello@amd.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Feb 23, 2023 at 8:03 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Commit 202e683df37c ("cpufreq: amd-pstate: add amd-pstate driver
> parameter for mode selection") changed the driver to be disabled by
> default, and this can surprise users.
>
> Let users know what happened so they can decide what to do next.
>
> Link: https://bugs.launchpad.net/bugs/2006942
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Remove redundancy in pr_info().
>  - Fix spelling and URL tag.
>
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 45c88894fd8e..f965f54f7ae7 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1263,7 +1263,7 @@ static int __init amd_pstate_init(void)
>          * with amd_pstate=passive or other modes in kernel command line
>          */
>         if (cppc_state == AMD_PSTATE_DISABLE) {
> -               pr_debug("driver load is disabled, boot with specific mode to enable this\n");
> +               pr_info("driver load is disabled, boot with specific mode to enable this\n");
>                 return -ENODEV;
>         }
>
> --

Applied as 6.3-rc material, thanks!
