Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EBF6AD3B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 02:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCGBIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 20:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCGBIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE6667819
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 17:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678151267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1dx5SRFJt30qkFOM5quycQQfnL680S8jPbZ0eS+2Fw=;
        b=LGCEY9+6BZrIiN7b4eITlujntJDdbort1mdYwCpJ2XPeLGg4gw2LabcvbSRW4o6/VOUGlj
        Ptv4F39Jr0HPRk8H7LsUUgHOj1y4mIA0qIsIq2/M4HytQRjdE7T4qcRa+BjzOVOGJPQ+6m
        WBIivI7dEnCKCoKMG6in5+ECknW3sXU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-P1LwFeZhNQ-YduYhOkFycw-1; Mon, 06 Mar 2023 20:07:46 -0500
X-MC-Unique: P1LwFeZhNQ-YduYhOkFycw-1
Received: by mail-qk1-f197.google.com with SMTP id dm13-20020a05620a1d4d00b00742a22c4239so6538593qkb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 17:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678151266;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1dx5SRFJt30qkFOM5quycQQfnL680S8jPbZ0eS+2Fw=;
        b=NKb5IxY2O4Jd6qUq265UsNyM2PJndrIdvisbDqOIGrMoH0tZaeOyVH5O0OOBzkVYk8
         Q9ncPjTgKJggHdlygTVPDtRL4zQE53uQusKWkW18keIG9UU06O/hWhlWBUZ695A4AEPe
         HhRS4Uu9QVL++zZ9o1l3AYNCUJwYd4axkOyK3R10thA/mTMBaYdgxPvAKXPKbri2ATkN
         PFwN++0BT9DKGixv1Ie7H7SxDGXzJt5IAcYMtMqIcsUHfqBPptL1eNBdxjPzvt5Wqbxw
         g1uGrfpqVNwWNR1gjHTpCp/A0Sl1nXfDfXHmDp8Rgrbzbar9PmWoP7QbL0Un24Y4HrHk
         fmdA==
X-Gm-Message-State: AO0yUKWOvDQbHHvPtQ6mpOgIIVYVrPJqGZ2jaF5Fjpf25ZUaNhFHB2y0
        QCGqt+NQ0O2k3a8ZDlB4vfMem5iCtBlIBOIVgSIB/raMwXHFqKlB4FCLKfCVGa7UEg8UVF7e21U
        GikZmHF3XKL13P0KtBBe7bGY9kzdIDfbzdeSV+gxiRxgYnLt9f5XxZSbtICCkDu2UmDDGiyFQpZ
        YQ5kE=
X-Received: by 2002:a05:622a:348:b0:3bf:dc2e:ce3f with SMTP id r8-20020a05622a034800b003bfdc2ece3fmr17366440qtw.16.1678151265923;
        Mon, 06 Mar 2023 17:07:45 -0800 (PST)
X-Google-Smtp-Source: AK7set+O9AR/zAebLHTqZOqIU8pqBL5bY3EH/iBlzeZ7TNswlxRKXxlGGaBUf+Ef0MDMppts75qN3A==
X-Received: by 2002:a05:622a:348:b0:3bf:dc2e:ce3f with SMTP id r8-20020a05622a034800b003bfdc2ece3fmr17366399qtw.16.1678151265454;
        Mon, 06 Mar 2023 17:07:45 -0800 (PST)
Received: from [192.168.1.19] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id s15-20020ac85ecf000000b003afbf704c7csm8368670qtx.24.2023.03.06.17.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 17:07:45 -0800 (PST)
Subject: Re: [PATCH] init/Kconfig: extend -Wno-array-bounds to gcc 13
To:     Kees Cook <kees@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     mhiramat@kernel.org, akpm@linux-foundation.org,
        masahiroy@kernel.org, paulmck@kernel.org, hannes@cmpxchg.org,
        ojeda@kernel.org, thunder.leizhen@huawei.com,
        christophe.leroy@csgroup.eu, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
References: <20230306220947.1982272-1-trix@redhat.com>
 <CAKwvOdkd7pUu_oxt4=CW3fxXz2y7evtU9J5Gd7oQuyi1MkDMCw@mail.gmail.com>
 <C01C39FE-E776-48DA-84F2-402B49A705A8@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <899b639b-3c93-b96d-863d-9e25d1824dc3@redhat.com>
Date:   Mon, 6 Mar 2023 17:07:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <C01C39FE-E776-48DA-84F2-402B49A705A8@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/6/23 3:02 PM, Kees Cook wrote:
> On March 6, 2023 2:20:50 PM PST, Nick Desaulniers <ndesaulniers@google.com> wrote:
>> + Kees
>> https://lore.kernel.org/lkml/20230306220947.1982272-1-trix@redhat.com/
>>
>> On Mon, Mar 6, 2023 at 2:10 PM Tom Rix <trix@redhat.com> wrote:
>>> With gcc 13.0.1 on x86, there are several false positives like
>>>
>>> drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:167:31:
>>>    error: array subscript 4 is above array bounds of ‘const struct sparx5_psfp_gce[4]’ [-Werror=array-bounds=]
>>>    167 |                 gce = &sg->gce[i];
>>>        |                        ~~~~~~~^~~
>>> In file included from drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:8:
>>> drivers/net/ethernet/microchip/sparx5/sparx5_main.h:506:32: note: while referencing ‘gce’
>>>    506 |         struct sparx5_psfp_gce gce[SPX5_PSFP_GCE_CNT];
>>>        |                                ^~~
>>>
>>> The code lines for the reported problem
>>>          /* For each scheduling entry */
>>>          for (i = 0; i < sg->num_entries; i++) {
>>>                  gce = &sg->gce[i];
>>>
>>> i is bounded by num_entries, which is set in sparx5_tc_flower.c
>>>          if (act->gate.num_entries >= SPX5_PSFP_GCE_CNT) {
>>>                  NL_SET_ERR_MSG_MOD(extack, "Invalid number of gate entries");
>>>                  return -EINVAL;
>>>          }
>>> ..
>>>          sg->num_entries = act->gate.num_entries;
>>>
>>> So disable array-bounds as was done on gcc 11 and 12
> GCC 13 isn't released yet, and we've been working to make Linux warning-free under -Wareay-bounds. (And we succeeded briefly with GCC 11.)
>
> I'd much rather get GCC fixed. This is due to the shift sanitizer reducing the scope of num_entries (via macro args) to 0-31, which is still >4. This seems like a hinting bug in GCC: just because the variable was used in a shift doesn't mean the compiler can make any value assumptions.

The build with fail generally with gcc 13.

The warnings could be cleaned without having an error, but I looked at 
multiple errors, none of them were real.

imo this is a broken compiler option.

Tom

>
> -Kees
>
>
>

