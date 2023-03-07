Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2576ADDC2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCGLm4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Mar 2023 06:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjCGLlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:41:50 -0500
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D92D7E890;
        Tue,  7 Mar 2023 03:39:23 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id a25so51187912edb.0;
        Tue, 07 Mar 2023 03:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678189093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=827BZ7QHKXX/o/3YKoJ2JGa31MebA6PuHwtCfOkih34=;
        b=rkz6279ZsoFhZfvNeJyco8gp7CbXeQgUy6JYpfD0qwcuT1pLfrCcjaA7RgM4Z2cizA
         y4zUkT2Vn4unwQSOZ+WNpNs4fj+1TaESJthIZcbIvY2oNQJ5ffO5NSw8IfYRvs09WE0q
         eW9SHQXg4ucctAj1ioSkWh12BMdWh2JBpaYR5Z9M4VYGDryVhhP57rIXpQ+V+Tx09PsT
         pi0a3G4N5zyfsvhuQRFwAjjKlk+xB5JvaAsx46/WSxXmfHsxuIHMX1cKqgFcr/te7QYy
         73j1jUoXt9bSFQIT0IHOmO+CyrpASksOSszFTvrNLOXXuZpu0EXylQGpJiUOFJmWkkXt
         GImQ==
X-Gm-Message-State: AO0yUKW6IwLGDaTWWlV1ce02CQA6x9XEmDE02+5Kot6geiJ9Pq/3kb63
        uL+qfE7z+kSUtwYeVL6VAbE7UdTfD4uW6Mk49v+SMKjPjsM=
X-Google-Smtp-Source: AK7set91GVVFAjSNfN3Wl524EpgJm6XPO7jUSYGAzuwAJ7KbSmoxDYk6absqcEyIjriEfblA2UpLdwuGsMvhpKo3Kt4=
X-Received: by 2002:a17:906:a14:b0:8b1:38d6:9853 with SMTP id
 w20-20020a1709060a1400b008b138d69853mr6407368ejf.2.1678189093313; Tue, 07 Mar
 2023 03:38:13 -0800 (PST)
MIME-Version: 1.0
References: <20230307114145.8933-1-yu.c.chen@intel.com>
In-Reply-To: <20230307114145.8933-1-yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Mar 2023 12:38:02 +0100
Message-ID: <CAJZ5v0h8Z8_zb_seSfsFsgWksG6N41jFcuTycrEicJYJOG1yLQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: tools: pfrut: Check if the input of level and type
 is in the right numeric range
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
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

On Tue, Mar 7, 2023 at 4:46 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> The user can provide arbitrary non-numeic value to level and type, which
> brings unexpected behavior:

So I guess the expected behavior would be to throw an error?

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
> Fix this by restricting the input is in the expected range.
>
> Reported-by: Hariganesh Govindarajulu <hariganesh.govindarajulu@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  tools/power/acpi/tools/pfrut/pfrut.c | 33 ++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/tools/power/acpi/tools/pfrut/pfrut.c b/tools/power/acpi/tools/pfrut/pfrut.c
> index 52aa0351533c..ed672efef83b 100644
> --- a/tools/power/acpi/tools/pfrut/pfrut.c
> +++ b/tools/power/acpi/tools/pfrut/pfrut.c
> @@ -22,6 +22,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
>  #include <uuid/uuid.h>
> +#include <ctype.h>
>  #include PFRUT_HEADER
>
>  char *capsule_name;
> @@ -77,6 +78,18 @@ static void help(void)
>                 progname);
>  }
>
> +static int is_digit_input(char *str)
> +{
> +       char *scan;
> +
> +       for (scan = str; *scan != '\0'; scan++) {
> +               if (!isdigit(*scan))
> +                       return 0;
> +       }
> +
> +       return 1;
> +}
> +
>  char *option_string = "l:sauqd:GT:L:RD:h";
>  static struct option long_options[] = {
>         {"load", required_argument, 0, 'l'},
> @@ -125,11 +138,31 @@ static void parse_options(int argc, char **argv)
>                         log_getinfo = 1;
>                         break;
>                 case 'T':
> +                       if (!is_digit_input(optarg)) {
> +                               printf("Please provide numeric value for type (0:execution, 1:history) - Exiting.\n");
> +                               exit(1);
> +                       }
> +

Wouldn't using strtol() instead of atoi() work?

>                         log_type = atoi(optarg);
> +                       if (log_type != 0 && log_type != 1) {
> +                               printf("Please provide numeric value for type (0:execution, 1:history) - Exiting.\n");
> +                               exit(1);
> +                       }
> +
>                         set_log_type = 1;
>                         break;
>                 case 'L':
> +                       if (!is_digit_input(optarg)) {
> +                               printf("Please provide numeric value for level (0, 1, 2, 4) - Exiting.\n");
> +                               exit(1);
> +                       }
> +
>                         log_level = atoi(optarg);
> +                       if (log_level > 4) {
> +                               printf("Please provide numeric value for level (0, 1, 2, 4) - Exiting.\n");
> +                               exit(1);
> +                       }
> +
>                         set_log_level = 1;
>                         break;
>                 case 'R':
> --
> 2.25.1
>
