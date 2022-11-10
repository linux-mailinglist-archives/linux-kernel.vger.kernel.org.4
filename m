Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112EB624A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKJT0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJT0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:26:17 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57372ED56;
        Thu, 10 Nov 2022 11:26:16 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id cg5so1530696qtb.12;
        Thu, 10 Nov 2022 11:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdILW2TfdSLcvwmccYyLpd9PEgHcqApl5ASbOnvFyLQ=;
        b=hPjk1U5q5+hKduPsTTZewAYTO7VjuuiLqy1ITGGEIPD66w5ik1JS9eLrW0XlPZ6Xgv
         uca7VjhWSNfudy+hcX3tsU3xuI2aUwBlj6VaMHXyMCNdtreXUzvPT/5JuewQAcYIqTxX
         egcyQz3GPnEhgSZw4fotg+hKetxwlJTzJzl5fwYwSL6haNW6fhwvo/+MnphJJcuGI+mb
         w/8XNFz+G8zuFB89Z3HrEVqpJ4Fh+5XS/i+HLvV+htMOoIw4hc/gH1Q23Z8loU4Mp8JR
         HzJVNgzojRFO8xW3MSkQQkcpOcZZTce+dOvyVJ3gixd5leLXoxqyJQEYskGJT8uG9TgC
         AR7Q==
X-Gm-Message-State: ACrzQf0CO4X/zpN6wYbSP7RzqDg969ycq0M+JDr8LfKY2ckNdagPiIu/
        kbj+MQVoMPaUpq3TE5bBWR3XDaOWfLihMPJUQXs=
X-Google-Smtp-Source: AMsMyM5ktEA3aUw5IRtIhd3g+zdFRr6hdyuyfF9mJftyAkgbQ3Db2e7gyhNiWHydReVIIEbhfO7ez2rGHKVRyhxh6jA=
X-Received: by 2002:ac8:690f:0:b0:3a5:4678:5b24 with SMTP id
 bt15-20020ac8690f000000b003a546785b24mr1513773qtb.411.1668108375937; Thu, 10
 Nov 2022 11:26:15 -0800 (PST)
MIME-Version: 1.0
References: <202211092125250606392@zte.com.cn>
In-Reply-To: <202211092125250606392@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 20:26:05 +0100
Message-ID: <CAJZ5v0hLP4pzGzyHAXb9Ksox5_rT85_30B95yX0mqt6=vMmzaw@mail.gmail.com>
Subject: Re: [PATCH linux-next] ACPI: sysfs: use sysfs_emit() to instead of scnprintf()
To:     yang.yang29@zte.com.cn
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
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

On Wed, Nov 9, 2022 at 2:25 PM <yang.yang29@zte.com.cn> wrote:
>
> From: Xu Panda <xu.panda@zte.com.cn>
>
> Replace scnprintf() with sysfs_emit() to simplify the code.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> ---
>  drivers/acpi/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 2d81c742e4d2..e6fe1c02a138 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -198,7 +198,7 @@ static int param_set_trace_method_name(const char *val,
>
>  static int param_get_trace_method_name(char *buffer, const struct kernel_param *kp)
>  {
> -       return scnprintf(buffer, PAGE_SIZE, "%s\n", acpi_gbl_trace_method_name);
> +       return sysfs_emit(buffer, "%s\n", acpi_gbl_trace_method_name);
>  }
>
>  static const struct kernel_param_ops param_ops_trace_method = {
> --

Applied as 6.2 material, thanks!
