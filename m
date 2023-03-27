Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC216CAA99
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjC0QbU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 12:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjC0QbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:31:18 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5141BF8;
        Mon, 27 Mar 2023 09:31:16 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id ek18so38641247edb.6;
        Mon, 27 Mar 2023 09:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679934675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ze47oiOMMwEVxqfmFdemK0JOgAXssrF7lNQS7gfxOk=;
        b=qAzAqN/uh3+eKGho/srvYPoyOC3KGmS+xRmqgXoTrVW59idRa/rHRlTAQuoHHU3FyJ
         0OJ1/3iTRxcvvB0XduWx9RNdtiN7HX/r2UyE2KbmL3SKkcO8AdDBQu8/sq/xdJg2fGkO
         +0GR96FYJsIboQWJaZ79o+9C2t+0cn5z+DhUfhMNcHXwREjwHoCrW55AyW8Bb+Que0Kj
         aqJpw6eRF7oZ70YXAsfUo8cVauCtGAOsA/B9o1XF0gc1nub3FN9dkvBS+Rl4dZ57IFDs
         O1FUO1p+5/fBMcrTI0hBIyWJgpzOeZmRImfXjyFdoNrpHjwbhsggdQ3R0hZJzxkUA7QB
         DO3A==
X-Gm-Message-State: AAQBX9ehkzJxx1ZALCeDb79aXdjKauT2McpmvDNqEKTp49JT9hWE9fFB
        sQ5tmcvZ6L7qXsq95U7fqluxUwwryLJcC4x8mx8=
X-Google-Smtp-Source: AKy350aSM5bh29ivpbq6LAhxYig+POjK4M7ZT6QDUBFSac9DFKNJ1s03/LnJQH/g9PiZt0GifWQAyZI7IoRbKqB+zXk=
X-Received: by 2002:a50:d49e:0:b0:502:148d:9e1e with SMTP id
 s30-20020a50d49e000000b00502148d9e1emr6145533edi.3.1679934674643; Mon, 27 Mar
 2023 09:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com> <20230207051105.11575-12-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20230207051105.11575-12-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 18:31:03 +0200
Message-ID: <CAJZ5v0hOdubRdhDpHyU474Px5mSo7hcYGS+oXLYLf38_y+V-Gg@mail.gmail.com>
Subject: Re: [PATCH v3 11/24] thermal: intel: hfi: Introduce Intel Thread
 Director classes
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
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

On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Intel hybrid parts, each type of CPU has specific performance and
> energy efficiency capabilities. The Intel Thread Director technology
> extends the Hardware Feedback Interface (HFI) to provide performance and
> energy efficiency data for advanced classes of instructions.
>
> Add support to parse per-class capabilities.
>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

No objections to this patch, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes since v2:
>  * None
>
> Changes since v1:
>  * Removed a now obsolete comment.
> ---
>  drivers/thermal/intel/intel_hfi.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index 6e604bda2b93..2527ae3836c7 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -77,7 +77,7 @@ union cpuid6_edx {
>   * @ee_cap:            Energy efficiency capability
>   *
>   * Capabilities of a logical processor in the HFI table. These capabilities are
> - * unitless.
> + * unitless and specific to each HFI class.
>   */
>  struct hfi_cpu_data {
>         u8      perf_cap;
> @@ -89,7 +89,8 @@ struct hfi_cpu_data {
>   * @perf_updated:      Hardware updated performance capabilities
>   * @ee_updated:                Hardware updated energy efficiency capabilities
>   *
> - * Properties of the data in an HFI table.
> + * Properties of the data in an HFI table. There exists one header per each
> + * HFI class.
>   */
>  struct hfi_hdr {
>         u8      perf_updated;
> @@ -127,16 +128,21 @@ struct hfi_instance {
>
>  /**
>   * struct hfi_features - Supported HFI features
> + * @nr_classes:                Number of classes supported
>   * @nr_table_pages:    Size of the HFI table in 4KB pages
>   * @cpu_stride:                Stride size to locate the capability data of a logical
>   *                     processor within the table (i.e., row stride)
> + * @class_stride:      Stride size to locate a class within the capability
> + *                     data of a logical processor or the HFI table header
>   * @hdr_size:          Size of the table header
>   *
>   * Parameters and supported features that are common to all HFI instances
>   */
>  struct hfi_features {
> +       unsigned int    nr_classes;
>         size_t          nr_table_pages;
>         unsigned int    cpu_stride;
> +       unsigned int    class_stride;
>         unsigned int    hdr_size;
>  };
>
> @@ -333,8 +339,8 @@ static void init_hfi_cpu_index(struct hfi_cpu_info *info)
>  }
>
>  /*
> - * The format of the HFI table depends on the number of capabilities that the
> - * hardware supports. Keep a data structure to navigate the table.
> + * The format of the HFI table depends on the number of capabilities and classes
> + * that the hardware supports. Keep a data structure to navigate the table.
>   */
>  static void init_hfi_instance(struct hfi_instance *hfi_instance)
>  {
> @@ -515,18 +521,30 @@ static __init int hfi_parse_features(void)
>         /* The number of 4KB pages required by the table */
>         hfi_features.nr_table_pages = edx.split.table_pages + 1;
>
> +       /*
> +        * Capability fields of an HFI class are grouped together. Classes are
> +        * contiguous in memory.  Hence, use the number of supported features to
> +        * locate a specific class.
> +        */
> +       hfi_features.class_stride = nr_capabilities;
> +
> +       /* For now, use only one class of the HFI table */
> +       hfi_features.nr_classes = 1;
> +
>         /*
>          * The header contains change indications for each supported feature.
>          * The size of the table header is rounded up to be a multiple of 8
>          * bytes.
>          */
> -       hfi_features.hdr_size = DIV_ROUND_UP(nr_capabilities, 8) * 8;
> +       hfi_features.hdr_size = DIV_ROUND_UP(nr_capabilities *
> +                                            hfi_features.nr_classes, 8) * 8;
>
>         /*
>          * Data of each logical processor is also rounded up to be a multiple
>          * of 8 bytes.
>          */
> -       hfi_features.cpu_stride = DIV_ROUND_UP(nr_capabilities, 8) * 8;
> +       hfi_features.cpu_stride = DIV_ROUND_UP(nr_capabilities *
> +                                              hfi_features.nr_classes, 8) * 8;
>
>         return 0;
>  }
> --
> 2.25.1
>
