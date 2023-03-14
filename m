Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4E76B9FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCNTkK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Mar 2023 15:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjCNTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:40:08 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155CC193E0;
        Tue, 14 Mar 2023 12:40:07 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id x13so19264319edd.1;
        Tue, 14 Mar 2023 12:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678822805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lngV1SBJchusWtrK2aOr9VYqvqXEEwJ9k8SBgXaHbrk=;
        b=Z8RFCd5x5piC/w/qZE85f2CA6aRmQqPjxEHb87Ph5o4TLioJyhuUysH8oYtn5zT00i
         N2WQKiXCIEQyTLYWRb8B/LEHRMl6myFJ6MuxrCw1O+DykyEw9JZbi6UKaOivp+xgsuU3
         50sEF5oZak9lbmyVLUVmPwUjjfLYBQjKbklumVPNcykHTq6J5Kud+o6jjjAh6+EkWng3
         W6Esu085h1rnxQ+03rbWWqAx5EIispjjL8kjl1Nh7gClHwtaP6Gh2xLWdJGFtC76Tr2E
         yafmRzmvnu2zaNBkOfuhgnHaTV1qZHzzYdOtRZLC0DKFJBfBf5y7lUMWfggH4+DJ4OSR
         Sfbg==
X-Gm-Message-State: AO0yUKWuILM7u4Onb0SEhrOqWt/NIRGBODj6Y1cSeVkLt8bwtYDC5XY1
        NnGM3Em7IaSE/E7guiww3v4KzquO8rm+cKOeB/8=
X-Google-Smtp-Source: AK7set/lJc5Pr883/nO0O+8ECRQFHtff91e6HCCh3sc0wnAQLJZk6QiDSRlN/qBx2oOymxYCdUYTCiZHrpVq94ilq9g=
X-Received: by 2002:a17:906:58c6:b0:8b1:7aec:c8e6 with SMTP id
 e6-20020a17090658c600b008b17aecc8e6mr2049482ejs.2.1678822805425; Tue, 14 Mar
 2023 12:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230308132309.18827-1-yu.c.chen@intel.com>
In-Reply-To: <20230308132309.18827-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Mar 2023 20:39:54 +0100
Message-ID: <CAJZ5v0hgKifYp=5L4XVVnDDZ_JDvizQWu5CvAFP1eb5xK0+XMA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: tools: pfrut: Check if the input of level and
 type is in the right numeric range
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hariganesh Govindarajulu <hariganesh.govindarajulu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 6:28 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> The user provides arbitrary non-numeic value to level and type,
> which could bring expected behavior. In this case the expected
> behavior would be to throw an error.
>
>  pfrut -h
> usage: pfrut [OPTIONS]
> code injection:
> -l, --load
> -s, --stage
> -a, --activate
> -u, --update [stage and activate]
> -q, --query
> -d, --revid
> update telemetry:
> -G, --getloginfo
> -T, --type(0:execution, 1:history)
> -L, --level(0, 1, 2, 4)
> -R, --read
> -D, --revid log
>
>  pfrut -T A
>  pfrut -G
> log_level:0
> log_type:0
> log_revid:2
> max_data_size:65536
> chunk1_size:0
> chunk2_size:1530
> rollover_cnt:0
> reset_cnt:17
>
> Fix this by restricting the input to be in the expected range.
>
> Reported-by: Hariganesh Govindarajulu <hariganesh.govindarajulu@intel.com>
> Suggested-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: Replace atoi() with strtol() to filter the number. (Rafael)
>
> ---
>  tools/power/acpi/tools/pfrut/pfrut.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/tools/power/acpi/tools/pfrut/pfrut.c b/tools/power/acpi/tools/pfrut/pfrut.c
> index 52aa0351533c..388c9e3ad040 100644
> --- a/tools/power/acpi/tools/pfrut/pfrut.c
> +++ b/tools/power/acpi/tools/pfrut/pfrut.c
> @@ -97,7 +97,7 @@ static struct option long_options[] = {
>  static void parse_options(int argc, char **argv)
>  {
>         int option_index = 0;
> -       char *pathname;
> +       char *pathname, *endptr;
>         int opt;
>
>         pathname = strdup(argv[0]);
> @@ -125,11 +125,23 @@ static void parse_options(int argc, char **argv)
>                         log_getinfo = 1;
>                         break;
>                 case 'T':
> -                       log_type = atoi(optarg);
> +                       log_type = strtol(optarg, &endptr, 0);
> +                       if (*endptr || (log_type != 0 && log_type != 1)) {
> +                               printf("Number expected: type(0:execution, 1:history) - Quit.\n");
> +                               exit(1);
> +                       }
> +
>                         set_log_type = 1;
>                         break;
>                 case 'L':
> -                       log_level = atoi(optarg);
> +                       log_level = strtol(optarg, &endptr, 0);
> +                       if (*endptr ||
> +                           (log_level != 0 && log_level != 1 &&
> +                            log_level != 2 && log_level != 4)) {
> +                               printf("Number expected: level(0, 1, 2, 4) - Quit.\n");
> +                               exit(1);
> +                       }
> +
>                         set_log_level = 1;
>                         break;
>                 case 'R':
> --

Applied as 6.3-rc material, thanks!
