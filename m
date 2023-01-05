Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854AD65F3EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjAESpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjAESpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:45:01 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7062BFC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 10:44:59 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id fc4so91995309ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 10:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ojaUANg6489F6UhekwXZgoRInAu5mt099cKH9PNdGSE=;
        b=ZlI5Vuj2TBGXPpsGgWMlVWG4ukkh8Jncr3YY+gT6T8/0Ia8rxK390imIHfsK/Gd3qn
         +3rIcWuMxjcCVp0gYX6JnKb8OBnVxfnCaB6tG+wMoNWbZ6Ue3xfy7GBTHagFOSp9aHfH
         0m8bS3J1r9EghcBzNAV3DXtlfuVXZWUkP03Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojaUANg6489F6UhekwXZgoRInAu5mt099cKH9PNdGSE=;
        b=tGojxAZYOQqN1yFnoiF6crNi+060nAY2S1wDlHJTm94XdACt0J+U0uni7t+WmSznI/
         cz43sW8TtBleNif7fO2nP50ZOljQGPsU52znVQlSWkvxAKABlNY7IengNmV8cjiy3JF5
         OnBHHUpAh0lzqcDAKzWqwvdAmzdxsumTHhRBi5/hu4PvpwOLkmOgOremln3KhWpkjHfF
         e6NWXqIrLOQhIG8qZ1J8e2adVRtfg2P7cH/6mg9HA2CGjiEmQd0E9CZcovk2AFRt0iKC
         htYrS0vurJGlSFccIJgzxrBbQSJn4k6ob9YQd6/D9GbG1w3EY997ClYawk9hfEF0sA7M
         5bpQ==
X-Gm-Message-State: AFqh2krcuFA7R2bK4Bm/HAVj+Azu9bYs0g27CfFd4Gyy/yCxvUs8+OP9
        JW9KWgpZMB0sCG7jxp535y2nnIi0pcAuGSwcCLBayg==
X-Google-Smtp-Source: AMrXdXuZaTwSwLvO6Evn4zHTCe1NYcoZ2XwUQT8vG4f12cSnl//oOaHYwI30X/CqN6x9x7eUZLgaMpZZ+5liuVOyY5s=
X-Received: by 2002:a17:907:2be3:b0:7c0:cd95:bbaf with SMTP id
 gv35-20020a1709072be300b007c0cd95bbafmr4687962ejc.460.1672944297682; Thu, 05
 Jan 2023 10:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20230104060846.112216-1-pmalani@chromium.org>
In-Reply-To: <20230104060846.112216-1-pmalani@chromium.org>
From:   Benson Leung <bleung@chromium.org>
Date:   Thu, 5 Jan 2023 10:44:41 -0800
Message-ID: <CANLzEkuV3r6hQeB_e5qHm7eWLF2VftH-U9sbED30wWmu29UEyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: cros_typec_switch: Use fwnode* prop check
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On Tue, Jan 3, 2023 at 10:09 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Using device_property_present() multiple times on an ACPI device
> leads to kernel panics on Chromebook systems. This happens when there
> is > 1 boolean property in an ACPI device which is created dynamically
> by the BIOS as part of SSDT[1] on Chromebook systems
>
> Since fwnode_* can handle simple device tree properties equally
> well, switch to using the fwnode_property_present() function
> version. This will avoid panics and make the usage consistent
> when we introduce a check for the 2nd property in a subsequent patch.
>
> [1] https://wiki.osdev.org/SSDT
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Benson Leung <bleung@chromium.org>

Thanks,
Benson

> ---
>  drivers/platform/chrome/cros_typec_switch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
> index a26219e97c93..2536bda03bf3 100644
> --- a/drivers/platform/chrome/cros_typec_switch.c
> +++ b/drivers/platform/chrome/cros_typec_switch.c
> @@ -254,7 +254,7 @@ static int cros_typec_register_switches(struct cros_typec_switch_data *sdata)
>
>                 dev_dbg(dev, "Retimer switch registered for index %llu\n", index);
>
> -               if (!device_property_present(fwnode->dev, "mode-switch"))
> +               if (!fwnode_property_present(fwnode, "mode-switch"))
>                         continue;
>
>                 ret = cros_typec_register_mode_switch(port, fwnode);
> --
> 2.39.0.314.g84b9a713c41-goog
>
>


-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
