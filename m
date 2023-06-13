Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB0F72ECBB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjFMUR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjFMURy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:17:54 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBD0A7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:17:53 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f98276f89cso3981cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686687472; x=1689279472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXZYbcN4lT4MwovmyfDQYwlkMbjb1em4SMZ8xBlxtCs=;
        b=7P+JWTqo/e3oHiBcBjVlnIK4cD2+AO1Irn4+L5r6prMwkbhG4VHXGoRVMUd8rfypWE
         xqSMBWVx+c6OMPd4pisCGsJSOVVuK5AUAFx4uK/dnhE1pymPHMNlHW+POxTYaxPVdYSb
         3+82UqxGWVruw7f+dcplHLVmXLuKV1sNEKHxEVypwHPKiwv/tlhf+RjddK8CUcjwvN06
         lrC8J359WkUxC/ocI1ya1q6mroKPB/Y/xDmmFU/rhoGgFeax8hZkoY7iyd+8ECYq9iX3
         wvQr2xbykQTUq+8xUWFuVtfphyzv8pxdGQ6Ol7ttxU4J0JNbtjU6X525A+NeGR3ENWTT
         q6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687472; x=1689279472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXZYbcN4lT4MwovmyfDQYwlkMbjb1em4SMZ8xBlxtCs=;
        b=Isby3y+6+livuhI4zNo+43jxEzZLd5hyiEuATo3YjSnYGIE0pSHItT2tX67Mv1ZdiR
         CxSAHxyaawNHmqPNPr2gk8L5alx9vL9Kw1H23iwy++YIhS/9VAsIg6InLgnpX/zI8mDp
         BKXDS6xpcHkWsSPanRxWQNN65jizUxu/TYPcXCQScdWAt2DK57+z3XRGe08wo4oxT4Y0
         u8cVE7BpHKvO/nTKyyBYT1EsBSi0ykK6UDyhvvEE/auK/GOhnnHAB813SwuDHsnNCHnx
         r2rmdXu3lzMFhaWqRlpS8TfyIYB7M/yzfRtBK4Ranzdkd6u+pQO+Ba0vNKdBtRrSrzyD
         tIew==
X-Gm-Message-State: AC+VfDy6EceiC0GzQ2+kbil9vbBUxv/4u0Fx/gbx/va6BKSh7WAU16s9
        18W7C3fat+35rSecwqfPbYGdrrDZXHMOa4sIeCz7KQ==
X-Google-Smtp-Source: ACHHUZ7jXI3SsKtoyWPHN02Hr9RxZp6g80e3/Y77CE8muNDSa5vHp/cZjeHyLgrXhyoyw/ySM252aJDwifFsHNTU3xc=
X-Received: by 2002:ac8:7e8b:0:b0:3f9:a986:f3a4 with SMTP id
 w11-20020ac87e8b000000b003f9a986f3a4mr44756qtj.25.1686687472411; Tue, 13 Jun
 2023 13:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230607162700.3234712-1-kan.liang@linux.intel.com> <20230607162700.3234712-8-kan.liang@linux.intel.com>
In-Reply-To: <20230607162700.3234712-8-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 13:17:41 -0700
Message-ID: <CAP-5=fX9E0g28spjC2k_YUKz6Vm2AKe_1VLJoapStHY6juDX1A@mail.gmail.com>
Subject: Re: [PATCH 7/8] pert tests: Support metricgroup perf stat JSON output
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 9:27=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> A new field metricgroup has been added in the perf stat JSON output.
> Support it in the test case.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lib/perf_json_output_lint.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/=
perf/tests/shell/lib/perf_json_output_lint.py
> index b81582a89d36..5e9bd68c83fe 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -55,6 +55,7 @@ def check_json_output(expected_items):
>        'interval': lambda x: isfloat(x),
>        'metric-unit': lambda x: True,
>        'metric-value': lambda x: isfloat(x),
> +      'metricgroup': lambda x: True,
>        'node': lambda x: True,
>        'pcnt-running': lambda x: isfloat(x),
>        'socket': lambda x: True,
> @@ -70,6 +71,8 @@ def check_json_output(expected_items):
>          # values and possibly other prefixes like interval, core and
>          # aggregate-number.
>          pass
> +      elif count !=3D expected_items and count >=3D 1 and count <=3D 5 a=
nd 'metricgroup' in item:
> +        pass
>        elif count !=3D expected_items:
>          raise RuntimeError(f'wrong number of fields. counted {count} exp=
ected {expected_items}'
>                             f' in \'{item}\'')
> --
> 2.35.1
>
