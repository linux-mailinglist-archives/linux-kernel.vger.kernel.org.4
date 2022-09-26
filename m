Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F065EB2FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiIZVSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiIZVSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:18:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5EA9258F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:18:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y5so12141049wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=9WNHl/J7CDcN3AJJwxysC1X1MJGVamy/d3xDM62RZCM=;
        b=iTfWWXsyoyyFkYlrrS7DICAuYfRfeOlVw8+wXgtFjgus7YmmaIvPk5+2Om+rsthySy
         jPgIA8nlnEoA2CX+LB72k1qEtvUHFqPnajLEWpikagbcDB6RJq63MQjHJpl7/D6W7oMj
         byu+1gqXOuC84bqGg6msDILqouBcywWNVXqAilxBVv6HXpyFDliqYg4GfO7tMe7Oa+nc
         FBiCF2CzM6jHb3zzy0GskAy8L2JZpxirBUNuaettizqYM4dTr8OLj2ODl1phIEiuvivI
         REFOHHGvXjGsvaMBAsHwLNifhFpOnjOWGaFEQcvRf4V2QU/BpUC1zoByiTriys2BMyIv
         PtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=9WNHl/J7CDcN3AJJwxysC1X1MJGVamy/d3xDM62RZCM=;
        b=eD1ymc0i/EBUnVVTQiJt42elxh+rEQ2xpaMX+SNZ/cmeVNXWgXlvfq/qkRmYepnkd8
         dlhuBn8gsJjAvlAamXAT+fhxyPqsjFcB7T//fQDxL9uxwQrNwICG9yEVtS5/TrEsDvwW
         H/mMnSWy+0BGw9XNJnP45qN83v6tC8hzuwUREkp91Kuh30muWqO1urQCbx+ykoCK1QK/
         lFx18NjdwW6dBOwY/4D5yLQDfNgYqTDuV2YWq92uELIjpkE65CbUBovdNZ0Bch+c9lY8
         2QeTJ4AWmUQs45FXne/OWHN3e6VjlusbVGsnlcCbgwY2PiiR8OcoVR+WlbOX1xhtFCKy
         bJ+w==
X-Gm-Message-State: ACrzQf1XMMzByUTkSJOJGMS5xAXfYfZIOl/0d3B2svG0m551VK5pvFNQ
        pjvGjEZVFpknlp+Zv6UnDny7WybvqihdU4vSfoKcJA==
X-Google-Smtp-Source: AMsMyM7ys6VghKlHdebcfATYHg8zk6mLZSBwge5OwAV4zZVj917EVOTd7EZ+yHh3MlixALlmhNs59ALc31r/PsJiqsA=
X-Received: by 2002:a5d:5611:0:b0:228:e1d2:81d with SMTP id
 l17-20020a5d5611000000b00228e1d2081dmr15061344wrv.210.1664227120149; Mon, 26
 Sep 2022 14:18:40 -0700 (PDT)
MIME-Version: 1.0
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 26 Sep 2022 14:18:04 -0700
Message-ID: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
Subject: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     John Stultz <jstultz@google.com>, tglx@linutronix.de,
        sboyd@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
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

Hey everyone,

I have a question about ktime_get_mono_fast_ns(), which is used by the
BPF helper bpf_ktime_get_ns() among other use cases. The comment above
this function specifies that there are cases where the observed clock
would not be monotonic.

I had 2 beginner questions:

1) Is there a (rough) bound as to how much the clock can go backwards?
My understanding is that it is bounded by (slope update * delta), but
I don't know what's the bound of either of those (if any).

2) The comment specifies that for a single cpu, the only way for this
behavior to happen is when observing the time in the context of an NMI
that happens during an update.
For observations across different cpus, are the scenarios where the
non-monotonic behavior happens also tied to observing time within NMI
contexts? or is it something that can happen outside of NMI contexts
as well?

Thanks in advance! (and please excuse any dumb/obvious questions :) )
