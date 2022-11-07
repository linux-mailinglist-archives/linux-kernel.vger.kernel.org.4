Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E2762009F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiKGVMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiKGVML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:12:11 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3E92FC21;
        Mon,  7 Nov 2022 13:09:12 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id q2-20020a4a3302000000b0049ee5fe3ab7so622104ooq.8;
        Mon, 07 Nov 2022 13:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJRjXYPrBJnSWOuAvcjC4UzikNviJ6pcXZBPjMYgmEU=;
        b=RLkdwBoWC75Tc/Ms1KSv9WUgwQrUd8yYqybHokZFwSfTaTYH6xCf54efHTOBMVoTDa
         bUWSJmUlpoo3LUw+pyIBM1VnDAUwhYyyMoBzf6FWqQZ4zc6t0K2T8XIVO6vkHnyY+rqv
         1uORYszq47Mcs/zjfXshOOCmTuJKq6dk4qwxF2Dtc+zbME9kyKzADz506jTd9e68auEJ
         Jups4Qfo4vYjb3dxF3ON/2ehua15aPGWh2HHbDDfMhWw9dWgJbMws1eoggQhl4+mjxAR
         FYIJevXroW1x/6F7NNCbzOIXjNpsYwNI3R+CIDuFrKgFa7M/ghq43JQ0lYmZWNASfzUq
         bFcg==
X-Gm-Message-State: ACrzQf3/kJxxZHn3softwadg1oFE1ji2kmlwcjzpip7cfDZayECMVo50
        sgo4JgMecuCFX+hYY+BPRFRXnOVKdwKE9NPGak3Evm3o
X-Google-Smtp-Source: AMsMyM58h+AC38zp7Qdffo3gCYh/exaBPOgKomdQnStR3tjmFAq3T5TffdkResyJhkY8BxBKetsFmOzdd40MQDIB8Uc=
X-Received: by 2002:a4a:b913:0:b0:480:b3bf:7812 with SMTP id
 x19-20020a4ab913000000b00480b3bf7812mr22421024ooo.97.1667855351882; Mon, 07
 Nov 2022 13:09:11 -0800 (PST)
MIME-Version: 1.0
References: <166761727445.480106.3738447577082071942.stgit@devnote3>
In-Reply-To: <166761727445.480106.3738447577082071942.stgit@devnote3>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 7 Nov 2022 13:09:00 -0800
Message-ID: <CAM9d7ci8YX22Bp31ZD9k31NFN6pP3fbPKpNDNZYnmdZiqav1Vg@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix to get the DW_AT_decl_file and
 DW_AT_call_file as unsinged data
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Fri, Nov 4, 2022 at 8:01 PM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Dwarf version 5 standard Sec 2.14 says that
>
>   Any debugging information entry representing the declaration of an object,
>   module, subprogram or type may have DW_AT_decl_file, DW_AT_decl_line and
>   DW_AT_decl_column attributes, each of whose value is an unsigned integer
>   constant.
>
> So it should be an unsigned integer data. Also, even though the standard
> doesn't clearly say the DW_AT_call_file is signed or unsigned, the
> elfutils (eu-readelf) interprets it as unsigned integer data and it is
> natural to handle it as unsigned integer data as same as DW_AT_decl_file.
> This changes the DW_AT_call_file as unsigned integer data too.
>
> Fixes: 3f4460a28fb2 ("perf probe: Filter out redundant inline-instances")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/dwarf-aux.c |   21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
>
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 30b36b525681..b07414409771 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -315,19 +315,6 @@ static int die_get_attr_udata(Dwarf_Die *tp_die, unsigned int attr_name,
>         return 0;
>  }
>
> -/* Get attribute and translate it as a sdata */
> -static int die_get_attr_sdata(Dwarf_Die *tp_die, unsigned int attr_name,
> -                             Dwarf_Sword *result)
> -{
> -       Dwarf_Attribute attr;
> -
> -       if (dwarf_attr_integrate(tp_die, attr_name, &attr) == NULL ||
> -           dwarf_formsdata(&attr, result) != 0)
> -               return -ENOENT;
> -
> -       return 0;
> -}
> -
>  /**
>   * die_is_signed_type - Check whether a type DIE is signed or not
>   * @tp_die: a DIE of a type
> @@ -467,9 +454,9 @@ int die_get_data_member_location(Dwarf_Die *mb_die, Dwarf_Word *offs)
>  /* Get the call file index number in CU DIE */
>  static int die_get_call_fileno(Dwarf_Die *in_die)
>  {
> -       Dwarf_Sword idx;
> +       Dwarf_Word idx;
>
> -       if (die_get_attr_sdata(in_die, DW_AT_call_file, &idx) == 0)
> +       if (die_get_attr_udata(in_die, DW_AT_call_file, &idx) == 0)
>                 return (int)idx;
>         else
>                 return -ENOENT;
> @@ -478,9 +465,9 @@ static int die_get_call_fileno(Dwarf_Die *in_die)
>  /* Get the declared file index number in CU DIE */
>  static int die_get_decl_fileno(Dwarf_Die *pdie)
>  {
> -       Dwarf_Sword idx;
> +       Dwarf_Word idx;
>
> -       if (die_get_attr_sdata(pdie, DW_AT_decl_file, &idx) == 0)
> +       if (die_get_attr_udata(pdie, DW_AT_decl_file, &idx) == 0)
>                 return (int)idx;
>         else
>                 return -ENOENT;
>
