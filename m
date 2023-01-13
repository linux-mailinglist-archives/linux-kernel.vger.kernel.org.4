Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978B166A4C0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjAMVGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjAMVGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:06:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D82714B5;
        Fri, 13 Jan 2023 13:06:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E25F560E0B;
        Fri, 13 Jan 2023 21:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5FCC433F2;
        Fri, 13 Jan 2023 21:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673643989;
        bh=0FVzf6yMOJV1/lWKf4eOppKwRrG1u9c/xElEn+pOW6g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XHW+II8VTmjDd2IjPOkub6Sbny6KV7fcE1GKLhfmF4wxH32SaE/L0Nr4V9fPzPNcA
         ORhsWdDhwzS3HcxfEhvFLFXNjCEJPV8NzJpn2eWIwDkAzoraBQiSEt8UB0xfvlt5dH
         WeELJa+ZO444KTNou+IgQ74LFJoNB+2Nh6zk5/absoROUeW0EtvChXzMGBHGUEWvQo
         QdKtVROVQTsbDa2XZVl5yDirZeyye+bJ3fraLLng27j4ZxWYHp1Lhq3UHBs5GGklPP
         Y/97fEgv7t7zeiNujgCeD0KYWyUvhKSRbHo4g3BZlQOxWQkWl6OLr1Z5jaRlAMf+88
         9R2LL6hFd3O6Q==
Received: by mail-lf1-f43.google.com with SMTP id bf43so34800428lfb.6;
        Fri, 13 Jan 2023 13:06:29 -0800 (PST)
X-Gm-Message-State: AFqh2koVTjWl3Z01eLVB1WqSiRitZUZEok++Uk6eVe9Qpet/9DCO48ys
        MVo+jIA6W3Yzyb7iDnT4nXFr+ssx3YBfdyHh3YY=
X-Google-Smtp-Source: AMrXdXt/+1bp2sKLbWDXGOcsOqhQeifNegNbRSku++OJEbjShpqxBwNCmy5aW34mTrRwGlqqaitVroip9icQtPFsXJA=
X-Received: by 2002:ac2:4a8d:0:b0:4a2:4282:89c7 with SMTP id
 l13-20020ac24a8d000000b004a2428289c7mr6165278lfp.437.1673643987303; Fri, 13
 Jan 2023 13:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20230112214015.1014857-1-namhyung@kernel.org> <20230112214015.1014857-8-namhyung@kernel.org>
In-Reply-To: <20230112214015.1014857-8-namhyung@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 13 Jan 2023 13:06:14 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4D9E84J1v=KHePQxSaw+DAbJipPuHaBGdAJRay2zp6YA@mail.gmail.com>
Message-ID: <CAPhsuW4D9E84J1v=KHePQxSaw+DAbJipPuHaBGdAJRay2zp6YA@mail.gmail.com>
Subject: Re: [PATCH 7/8] perf/core: Introduce perf_prepare_header()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 1:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Factor out perf_prepare_header() so that it can call
> perf_prepare_sample() without a header if not needed.
>
> Also it checks the filtered_sample_type to avoid duplicate
> work when perf_prepare_sample() is called twice (or more).
>
> Cc: linux-s390@vger.kernel.org
> Cc: x86@kernel.org
> Suggested-by: Peter Zijlstr <peterz@infradead.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Song Liu <song@kernel.org>
