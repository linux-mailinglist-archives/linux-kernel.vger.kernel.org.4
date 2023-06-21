Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36B9738CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjFURXB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 13:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjFURW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:22:59 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3614210C;
        Wed, 21 Jun 2023 10:22:59 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-bb2ffa1e235so5937884276.0;
        Wed, 21 Jun 2023 10:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687368178; x=1689960178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEe5QkJa8Tj6wbx7n/OFn5hoJnPVHkIkLosmDQ908PM=;
        b=YU8ketYrgE5+S57dqocG1ShbsRilxZtXMEq/lF7Z9vlYYVVzXp2JqJTBPCKlTGW5Sl
         npy38D6iIfvE/4mJ/NoTdf7z2dMebgd4+nDIpv3IAcJAnOA9XJZiyuZF7fVOzmqYH3Jd
         teM2oO2ro2wered68uHoh1a1qoKyZOfZiUWwFVX4ENTQR96uIuBPSfiOJmzhG3BHiXCz
         4sCrRkFG7V8aSHvcLLzKdepU4M0/laJSFae6JcF2eEm6yqtRZCRunikWhtRjxGfHzaRZ
         R8c4G1gaPBrJcJU6emhaHGGaMtPDFTpibVi5QP/9C5zmw+MeBmVf163l7c0tRA+eoCwV
         tOQg==
X-Gm-Message-State: AC+VfDyBsSEILy8TPo1vc1MIsfWgu2PMvh+cYg9UznD1kHOcHpk5DLeO
        TOCx4NahBD8e5YH2e5bUbOJHB9ukJaIvegcPhEU=
X-Google-Smtp-Source: ACHHUZ71I97j5WODI68uKRtv6X09CgvUKOs6mAIUHzrx9FOHAG6/iFX9E10UepwS9Txxy/i5/eW7A8xH4dSVtZQvlOc=
X-Received: by 2002:a25:d3c6:0:b0:bcb:f3cc:e965 with SMTP id
 e189-20020a25d3c6000000b00bcbf3cce965mr12586639ybf.11.1687368178335; Wed, 21
 Jun 2023 10:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230614021505.59856-1-yangjihong1@huawei.com>
In-Reply-To: <20230614021505.59856-1-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 10:22:47 -0700
Message-ID: <CAM9d7cjqim4iyBKU1ob3uYXbycQTJ1f-XEL1fCQpiKDMirEuFQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf stat: Add missing newline in pr_err messages
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.clark@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 7:16 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> The newline is missing for error messages in add_default_attributes()
>
> Before:
>
>   # perf stat --topdown
>   Topdown requested but the topdown metric groups aren't present.
>   (See perf list the metric groups have names like TopdownL1)#
>
> After:
>
>   # perf stat --topdown
>   Topdown requested but the topdown metric groups aren't present.
>   (See perf list the metric groups have names like TopdownL1)
>   #
>
> In addition, perf_stat_init_aggr_mode() and perf_stat_init_aggr_mode_file()
> have the same problem, fixed by the way.
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Reviewed-by: James Clark <james.clark@arm.com>

Applied to perf-tools-next, thanks!
