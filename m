Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975385B8EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 20:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiINSQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 14:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiINSP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:15:56 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DE057250
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 11:15:51 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f13so7285014qkk.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vnzfdOKLIVU+LdB7pkSZ/shmrsmivP69BUtxhc7yWtE=;
        b=PbLrNz1muqGs6C2HXcUX4tKV1A1V2Ij/BZpI5N2It7JtkIv1Bb/kpImcy3pk/XutUf
         90pTyjGz8aibHmEnsqFGLU9MrUm/I5rJBmGNWFa4SJalsWGWljw4jxAJ6NIQEW2CMR1f
         /seGqG7fItGckxJI+pbNkWw20UUEOxsw98as/2B3LiS/s1CR5xGQAFJIxQGH8LWlPbRk
         /31DQKQKRTvSGzkHU68SP0lMsUvWq4MEO7JHPifyW89v2XHqTgoTdj1HLxa3nLMutkZT
         E9ws02CnMpCnSxVFDVjjRLbrHNamxrrgoJGIwc8CyQ5t2OzBo/hA4uoQkrwXtsn9GpK/
         495A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vnzfdOKLIVU+LdB7pkSZ/shmrsmivP69BUtxhc7yWtE=;
        b=rgaUQUfMcf5bMWNwF/bOkbyzQH2iJ8dphaURkdUZJyabxLe9/ZKUlPe0nCc9cK3Wle
         lGsJXWu5lrfXutOyq04390oLB2HGBd3PNEEQcEomQDbNKkgCAAD4rsox1+Vb1XeR8Iad
         2XkEGrYzPvAAvEnT3/aZLCNvf64POVBdvevO2c3KDMpfuMMjt6TxnXEzIusEL1s9CVlm
         nDUyDhKbT+q4ij0hrAxezd9jQ5EPQAxchvgxe5inRTJPnS1lxDGA8ZISuYG242hgVJ4b
         e3IHKItcf+jdbCG2hQ76i1L8OiBcnaZ3awiTrW+DPciimKGIEhoA0oQXj0FKQBwh0gac
         ovZw==
X-Gm-Message-State: ACgBeo3zu5w7O8GUzoo6rB/oUdwHUbzwj/IJx9Pp28WKyE0hzi88uizr
        a4nEP0Pt03ZVXLZh23qW8PLvHRt2oQ3tZDPSjQ177g==
X-Google-Smtp-Source: AA6agR5pnPIUttp8wDBH3u+vcrj/weO4zNsNtKy4JrxzTt9V3OwxiMKaAWRMskba78pF5IQm+rlDbaozrs4XGoRVLK8=
X-Received: by 2002:a37:63d1:0:b0:6ce:5f67:47bc with SMTP id
 x200-20020a3763d1000000b006ce5f6747bcmr8489977qkb.682.1663179350617; Wed, 14
 Sep 2022 11:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220914123423.24368-1-liuxin350@huawei.com>
In-Reply-To: <20220914123423.24368-1-liuxin350@huawei.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 14 Sep 2022 11:15:39 -0700
Message-ID: <CA+khW7hS=c4PSo4coBmw+6VReWNhj+4Bnsr+r+mGsG4tCZ8KnQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: adjust OPTS_VALID logic, so that it can be used correctly
To:     Xin Liu <liuxin350@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com, zhudi2@huawei.com,
        kongweibin2@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Wed, Sep 14, 2022 at 5:35 AM Xin Liu <liuxin350@huawei.com> wrote:
>
> We found that function btf_dump__dump_type_data can be called by the user
> as an api, but in this function, the `opts` parameter may be used as a
> null pointer, because OPTS_VALID can't properly prevent opts used as null
> pointers during verification. Therefore, we fix this problem through this
> modification.
>
> This modification has no impact on other places where OPTS_VALID has been
> used.

I think this is a bug of btf_dump__dump_type_data(), not OPTS_VALID.
It seems allowing OPTS_VALID to accept NULL is the intended behavior.

>
[...]
>
