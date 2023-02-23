Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C046A1009
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjBWTDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjBWTDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:03:00 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916E5BBF;
        Thu, 23 Feb 2023 11:02:53 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id s26so45858403edw.11;
        Thu, 23 Feb 2023 11:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0zHO1uw3aFMg8wBsIwWiNbY+2MxzsmFELdpO0ONlaI=;
        b=oRaMdzUuFwpybTq6hbSZlf2+7pCH1L2Xcsb+PIsFZ3oe5+xogSEiBCO03ZdSnkdNFe
         ZSw/SuVV1/YtTzz0MYlYAu0hqBh0k1KLsnd8KklkFxUsrcSfGi84jsDrONevYRU1T/o4
         r7ow8NXUEih1xFJcCdd96wYedG5NtN9pM+VnASGmHQshdnP2uEk5SsI19KWFpkfS6BMk
         7i00g9KSDzOnTbTww0/z9S1QzYqky06qBQsPPAZWQwT78aaVMpCX/tJ4azhYG+94VEJu
         RG9e2uTZ8k78kjbnZSAhVer0Tnxm0g7JB7FhpW9niB2LtImxoDf1VGql+TT2u7ERI/No
         NhqA==
X-Gm-Message-State: AO0yUKVPgTuseSe3Vm1mjWioboH8U3R++lqdvXua2Q5G0zLJVArmZF9y
        I/2SDfliGHu/MlYNTRfvp1r4XOqTwvw5a87LEsw=
X-Google-Smtp-Source: AK7set8lGpDJq6NWH3PQGPB8Bx+/IEKdtHDSVLSbwu0PmInP01f5vEhCemaF1Zfydo02A4+gfP0sFu4Yzy+w1lhP8bM=
X-Received: by 2002:a17:906:194f:b0:8b1:76b8:9834 with SMTP id
 b15-20020a170906194f00b008b176b89834mr11216475eje.5.1677178971506; Thu, 23
 Feb 2023 11:02:51 -0800 (PST)
MIME-Version: 1.0
References: <20230217141059.392471-1-nick.alcock@oracle.com> <20230217141059.392471-6-nick.alcock@oracle.com>
In-Reply-To: <20230217141059.392471-6-nick.alcock@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Feb 2023 20:02:40 +0100
Message-ID: <CAJZ5v0h6LiifjEQRJrWkSc4MT-7GJbEkoaxA1nWj6oALwEH6gg@mail.gmail.com>
Subject: Re: [PATCH 05/24] kbuild, cpufreq: amd-pstate: remove MODULE_LICENSE
 in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
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

On Fri, Feb 17, 2023 at 3:11 PM Nick Alcock <nick.alcock@oracle.com> wrote:
>
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>
> So remove it in the files in this commit, none of which can be built as
> modules.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/cpufreq/amd-pstate.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c17bd845f5fc..adbc7b0921aa 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -686,4 +686,3 @@ early_param("amd_pstate", amd_pstate_param);
>
>  MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>  MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
> -MODULE_LICENSE("GPL");
> --

Applied as 6.3-rc material, thanks!
