Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC2F640CCB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiLBSDe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Dec 2022 13:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbiLBSDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:03:31 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0397260B4C;
        Fri,  2 Dec 2022 10:03:30 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id y16so8995363wrm.2;
        Fri, 02 Dec 2022 10:03:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5S9AInjAkBzgT4Ue2Z9+cewf5MRHGtio+KBn1axLoU=;
        b=ljRwqPwIY3zJkK+ZKd+fmuYoxTbwwtPcuyB7Qx/2C590v+s04ukAE2dDkG0z8T2Jok
         w2c6O5CXEBQUmwY+p0qNcEWIpH3Moxm8HdG1WKATf10zWtc/r9SE4Znk9op8/zevnb8g
         1PgwqXXdRXxkZJ8/kQasd0nwfz0gM2bx0kdkR3Fl5CC0vlH49vznkj4vNudELOWmIlpT
         kZxDdok39xvVQnMa7yIUcPTgH2Bo4yewZtayojEJ5hFiZCZCrnPzgvfPNpaYke5ibvL1
         oZIuW2kWk0yyV9gOPUFcjl7NR8FF8V4f0JN+3rVpE8axEKWaJGSFwDYMAlRTrnT6/cWH
         0M1g==
X-Gm-Message-State: ANoB5plKNR1UDOj1PHwSSXKoWkpS30HUuDvqYvVCryebVqfTj524XZlh
        wtn/85Y30JpE1lhgq+orDUn0WBy0695UcV2PRo8=
X-Google-Smtp-Source: AA0mqf4J29r5VWt/rIsXxWUvZrIM5pOiyObcfuwEfzF4lKw4wKaW8FjVPrPCKe4pd0OWBfGxpijsqt3j8zXtDkL+T2U=
X-Received: by 2002:a5d:5b08:0:b0:241:d7b1:b3db with SMTP id
 bx8-20020a5d5b08000000b00241d7b1b3dbmr1829830wrb.293.1670004208244; Fri, 02
 Dec 2022 10:03:28 -0800 (PST)
MIME-Version: 1.0
References: <CO6PR11MB56352D2831C1554FE8C3A872EE179@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB56352D2831C1554FE8C3A872EE179@CO6PR11MB5635.namprd11.prod.outlook.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 2 Dec 2022 10:03:16 -0800
Message-ID: <CAM9d7chqpLxZ81GRZktZf03pjZ-a7BOnD2mOCpNSDDCRZn3RMg@mail.gmail.com>
Subject: Re: [PATCH 13/15] perf stat: Fix JSON output in metric-only mode
To:     "Wang, Weilin" <weilin.wang@intel.com>
Cc:     "acme@kernel.org" <acme@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "atrajeev@linux.vnet.ibm.com" <atrajeev@linux.vnet.ibm.com>,
        "irogers@google.com" <irogers@google.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Dec 1, 2022 at 4:56 PM Wang, Weilin <weilin.wang@intel.com> wrote:
>
> Hi Namhyung,
>
>
>
> I encountered an issue with the metric json output, which I think might be related to this commit.
>
>
>
> This is one of the commands I tried:
>
>
>
> ./perf stat -M memory_bandwidth_total,memory_bandwidth_read,memory_bandwidth_write -a -j -- sleep 1
>
>
>
> Output before this commit:
>
> ====================================================
>
> {"counter-value" : "1117309.000000", "unit" : "", "event" : "UNC_M_CAS_COUNT.RD", "event-runtime" : 8017286783, "pcnt-running" : 100.00, "metric-value" : 124.961911, "metric-unit" : "MB/s  memory_bandwidth_read"} {"metric-value" : 237.237504, "metric-unit" : "MB/s  memory_bandwidth_total"} {"counter-value" : "1004052.000000", "unit" : "", "event" : "UNC_M_CAS_COUNT.WR", "event-runtime" : 8017286783, "pcnt-running" : 100.00, "metric-value" : 112.275593, "metric-unit" : "MB/s  memory_bandwidth_write"} {"counter-value" : "1002140370.000000", "unit" : "ns", "event" : "duration_time", "event-runtime" : 1002140370, "pcnt-running" : 100.00, "metric-value" : 0.000000, "metric-unit" : "(null)"}
>
> ====================================================
>
>
>
> Output after this commit:
>
> ====================================================
>
> {"counter-value" : "1374098.000000", "unit" : "", "event" : "UNC_M_CAS_COUNT.RD", "event-runtime" : 8016491003, "pcnt-running" : 100.00, "metric-value" : 153.660738, "metric-unit" : "MB/s  memory_bandwidth_read"} "metric-value" : 300.338968, "metric-unit" : "MB/s  memory_bandwidth_total"} {"counter-value" : "1311710.000000", "unit" : "", "event" : "UNC_M_CAS_COUNT.WR", "event-runtime" : 8016491003, "pcnt-running" : 100.00, "metric-value" : 146.678229, "metric-unit" : "MB/s  memory_bandwidth_write"} {"counter-value" : "1002037512.000000", "unit" : "ns", "event" : "duration_time", "event-runtime" : 1002037512, "pcnt-running" : 100.00, "metric-value" : 0.000000, "metric-unit" : "(null)"}
>
> ====================================================
>
>
>
> The second set of output is missing a "{" on the second line. Looks like it happens when I collect two related metrics together. Another example is:
>
>
>
> ./perf stat -M memory_bandwidth_total,memory_bandwidth_read,memory_bandwidth_write,L3_Cache_Fill_BW_1T,L3_Cache_Fill_BW -a -j -- sleep 1
>
>
>
> {"counter-value" : "944204.000000", "unit" : "", "event" : "UNC_M_CAS_COUNT.RD", "event-runtime" : 8033937053, "pcnt-running" : 100.00, "metric-value" : 105.369994, "metric-unit" : "MB/s  memory_bandwidth_read"} "metric-value" : 210.592807, "metric-unit" : "MB/s  memory_bandwidth_total"} {"counter-value" : "942679.000000", "unit" : "", "event" : "UNC_M_CAS_COUNT.WR", "event-runtime" : 8033937053, "pcnt-running" : 100.00, "metric-value" : 105.222813, "metric-unit" : "MB/s  memory_bandwidth_write"} {"counter-value" : "1004471458.000000", "unit" : "ns", "event" : "duration_time", "event-runtime" : 1004471458, "pcnt-running" : 100.00, "metric-value" : 0.000000, "metric-unit" : "(null)"} {"counter-value" : "184675.000000", "unit" : "", "event" : "LONGEST_LAT_CACHE.MISS", "event-runtime" : 88387319917, "pcnt-running" : 100.00, "metric-value" : 0.011767, "metric-unit" : "L3_Cache_Fill_BW_1T"} "metric-value" : 0.011767, "metric-unit" : "L3_Cache_Fill_BW"} {"counter-value" : "1004471458.000000", "unit" : "ns", "event" : "duration_time", "event-runtime" : 1004471458, "pcnt-running" : 100.00, "metric-value" : 0.000000, "metric-unit" : "(null)"}

Thanks for your report.  It seems it misses the open bracket when the metric
produces more than one values.  I think new_line_json() should have it.
Will send the fix soon.

Thanks,
Namhyung
