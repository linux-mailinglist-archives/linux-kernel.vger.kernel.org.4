Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA44F5BB931
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 17:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIQPq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 11:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIQPqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 11:46:54 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2352ED50
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 08:46:53 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id c4so19778494iof.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=76LNLWl97VBxvuOLqnfHoaJ1C5wpIf0pCDajDj3WnPs=;
        b=kM476BpCsVFVzdG+B04n8LyO3+t/pSGr8pkMVKDgjLiNmfasFm19tYHK78AGJcknZ4
         +kHMj3Mbmr1VxvhtT/uSNa3JjbfZoVi4s1oTLt+ag28l4UXris4QE2wyMEDrHeHvM1RO
         ivErMU34C11GpdAdTuKLCsPadb7W4l+qdkS9CK8N9UrMNPfJUoSmjDoKCCYjzTVNA5Zt
         C5N1JDiz2HYTXq4DJDQrig4PM5te7wdzCUXpk9v/DfrbZhX7ahTNXBdLLkJ49ZolpR95
         aFD+OBYefx8Z8sC0z4QTwQVMDwa38Wun5Ho/p0silav03IL40sgGBG191gUS9THcnBYe
         pTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=76LNLWl97VBxvuOLqnfHoaJ1C5wpIf0pCDajDj3WnPs=;
        b=OsXMiy3D4CWP17N/GxgMy9umHjve8kWIY2+gVRG22MwV3R3L385mV8DEMu51N8l47b
         a7MDhDLVh/8lN4TuDDZr57khGlcPwPL0APFItJrNRz8RUEC1nC/BZnHR7+zx4lOi9yz/
         HUnwIULQbSgPTzfyHeNJr/K4r6UMLin7MrW/znyuvfQwNvMeKXcc+Tc41bRl8W9h/JdE
         /75M6TLTRrHVZKcukne1wqGg+XIfipAveGxjgNxQaxGe6ef8gSUFxdQhN8L4pMFjqdV6
         2WXHslUmCRnZHSH5GdnTbu/fgMeFqsv75M/eN/XFPQhUcaq0N65Amh/xF5h+QPV3rXIo
         wJFw==
X-Gm-Message-State: ACrzQf3mAeuNq6XbBHg/PnDrxmL8RroHkgZqc1OS8Okvaao5pv6TLk1D
        omc9TCYlPAsmx7HLafnX4QN/zIkol6GPkq7xTjvpDaE+Gc/vaf9p
X-Google-Smtp-Source: AMsMyM7muT0ex5SM+GpL9y0fIVqBf6fc9stAJzeskXt9Fpjsyqh8gABNtknz+Im45nVSucKhz9QMLR56YDuszWdWJoI=
X-Received: by 2002:a05:6602:1554:b0:6a1:de25:9ce8 with SMTP id
 h20-20020a056602155400b006a1de259ce8mr3928023iow.202.1663429612687; Sat, 17
 Sep 2022 08:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220715115559.139691-1-shaozhengchao@huawei.com> <20220914111936.19881-1-oss@lmb.io>
In-Reply-To: <20220914111936.19881-1-oss@lmb.io>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Sat, 17 Sep 2022 08:46:36 -0700
Message-ID: <CAKH8qBujKnFh8_g+npxHpo7RGFshus3N0iysmVBohTtG1X2yow@mail.gmail.com>
Subject: Re: [PATCH v4,bpf-next] bpf: Don't redirect packets with invalid pkt_len
To:     Lorenz Bauer <oss@lmb.io>
Cc:     shaozhengchao@huawei.com, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuehaibing@huawei.com
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

On Wed, Sep 14, 2022 at 4:20 AM Lorenz Bauer <oss@lmb.io> wrote:
>
> Hi,
>
> I think this patch is causing user-space breakage, see [0].
>
> The gist is that we do BPF_PROG_RUN of a socket filter with 14 byte input to determine whether
> BPF_PROG_RUN is available or not. I'll fix this in cilium/ebpf, but I think this patch
> needs more work since users may be doing the same thing in their code.

Ooops, sorry about that.

Instead of rejecting len=0 data, we might accept the packet but add
some safe header? I think that should be more backwards compatible?
Zhengchao, something you can look into?


> Thanks,
> Lorenz
>
> 0: https://github.com/cilium/ebpf/pull/788
