Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC775FE60B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJNAD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJNADy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:03:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1434157469
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:03:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f11so5192991wrm.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=twO0p5/xsK51AFSKG4/+NF4p0nXn+aIHiYgabetyYzM=;
        b=ogURrAxlnWu3vFqjB7rIY1G5B2xyvvoBnUC0V40Z0wdBZWqC60AnzlmZV9kyfON4XA
         pmtIzlTMvgjsxalBx5RzqguT6mOGzTecK+c2BBk2QvoqMvRCrKLjPICKYhtXVZp6n4cM
         JonlftWrVoFZQdkkaLjGmq5FzMO1UevuRmOXr1O74+K7TOivpjOEl6hUIPNfI1JZVtL0
         o2OQIVjdyNTVAPFgdIQUah+Ce6Mzk9obfMX20xKkpGpmGcIo4XKE72TEQOyflCPdga6V
         P92/3ejEUtxQH2H5H9158sRuxTEaagdKKxkBxJm0AVIqjumi0g08R271PUCTNYmEGw67
         eIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twO0p5/xsK51AFSKG4/+NF4p0nXn+aIHiYgabetyYzM=;
        b=1n2lKt7VG9+e8M3ciVRN0nFVMg9CJr/lNFdaRMRMXTRO9HZhyB9EY6OBbcgzyvZeEK
         n19Ts0rChVJwgNEEzU65kq57zPAWnpWF5wF3r3zVdF8Xh/BzkHOx9qs3nnR1u76TTpN/
         +T1YmTfC0DfnVejKlnHMHYakIkI2BE7YE+q80ZIr08fePHDU1Zo/ScHmBSzfvnXOwW+9
         /eQ6bjeFA2n0yW1wtNDhPfwU3yAGy2P7c9p6sCotWTv/jXr4x1BxNh8Zypekeb164rjd
         5NeZU32p8Q2nSZlIC4C6eOGGw0LoIgvYYAYm7czIF1WKAf+MqFsCkYNTymBLLtwtvBIa
         xwvA==
X-Gm-Message-State: ACrzQf21Jo5Qq02YbwWVox3BZfu0DxX6n1Fy6qAOZh5lThHvIuowAybx
        lhdw1YLXwl++408wG6ZhmHI4/geph1GBfRgFBUSOcg==
X-Google-Smtp-Source: AMsMyM69o+xkxQCL0URhk14ropUJuWavWYXez2f/c8x1PekuXpo1/tfwcJbetPXOoEDA/xWRmULmY9gV2XQTFDm/GxM=
X-Received: by 2002:a5d:4909:0:b0:22e:7bbf:c8d with SMTP id
 x9-20020a5d4909000000b0022e7bbf0c8dmr1450837wrq.80.1665705831072; Thu, 13 Oct
 2022 17:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
 <CANDhNCrrM58vmWCos5kd7_V=+NimW-5sU7UFtjxX0C+=mqW2KQ@mail.gmail.com> <CANDhNCojzuCW2Udx_CssLvnY9DunEqVBSxnC5D6Rz0oX-r2-7g@mail.gmail.com>
In-Reply-To: <CANDhNCojzuCW2Udx_CssLvnY9DunEqVBSxnC5D6Rz0oX-r2-7g@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 13 Oct 2022 17:03:14 -0700
Message-ID: <CAJD7tkb=FSoRETXDMBs+ZUO1BhT7X1aG7wziYNtFg8XqmXH-Zw@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     John Stultz <jstultz@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 8:07 PM John Stultz <jstultz@google.com> wrote:
>
> On Wed, Oct 12, 2022 at 8:02 PM John Stultz <jstultz@google.com> wrote:
> > On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > So I think it reasonable to say its bounded by approximately  2 *
> > NSEC_PER_SEC/HZ +/- 11%.
>
> Sorry, this should be 2*NSEC_PER_SEC/HZ * 0.11

Thanks so much for the detailed response :)

IIUC this error bound is in ns. So on a 2 GHz cpu the bound is 0.11 ns
(essentially 0)? I feel like I miscalculated, this error bound is too
good to be true.

>
> thanks
> -john
