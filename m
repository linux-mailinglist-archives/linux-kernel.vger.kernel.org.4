Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42B3615498
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiKAWCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiKAWBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:01:53 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBBE6338
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:01:52 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id k19so22532500lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cb+tt9Vtj615rOrk5Qe1IbJBDO4sgCO757XJJ/DJ6iw=;
        b=lAxW1D8vqNJPKLYEA3wmWpu8nXmAvhM56I+75pXI5bch9ayzOM1BIgSgbZQnqy5g95
         ytdzXSRmiRlrGW5TkN0eHoDLCSfxXApbBzhaNKsKFMDDUxmisMVizgv4t0h+lMzG0DEs
         xXZpbCrCzoq+ItfLqH+r2gs4I5NVGQ3J0I9GGczNQWgZZzB3J9H/6sxe2Ip+sr+ypMsJ
         sfSA4F8vImPylcbBGpX369T/swtKAfV4DDV7fo2I+fpxysMnxXFragJG6OBfmNNNchVY
         iwDZ87Pay5wPd3DHMEFbA2PTID1UiQGf8w0v4mJzm96Fdgzj93BD+9d3655s/qqH5dL0
         4SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cb+tt9Vtj615rOrk5Qe1IbJBDO4sgCO757XJJ/DJ6iw=;
        b=2oLZ6Lw99fGg01Ji3nl9zz0N/L60xEgKHOuc3R1COkLp46eB582e6HlqjfDiS66Efw
         Kv5pHx/YBg3MvJ6amemDPCK4rhmW2cHoU3q3Jyv3Q49nMNwjFumhOM7rWeWPf9rRLfff
         ETfJ4cJh3nV1U6cZEggtFOGLj7JXYqmhVzRy/2/vPyIKPIpwA7kK+9DKB61gN1rLniYh
         TjW1g86mdocicHH24eEePTv5Fq2VZroVC2hG+hwDxPaltE64s6xIONogWlFXW8JFCpOv
         kCzESetBhFseCi1+BzSRJeHvsq5Gdn8E81yyioM3noYXOG1lHXoEgBgrBE5nH029MJZp
         KaXA==
X-Gm-Message-State: ACrzQf3JwI1RCytHQjSTH2piP9QqcDG+S+PCo0KqAIkbwmF/2c6okKPn
        Bk0u95mZlrURam6I4IIiRi0VfU2rZsTHxnkSeO0=
X-Google-Smtp-Source: AMsMyM61WyYzDD6Xmh5TB9DP6GzRoiHWWRokJZEctycLLrpprMbnj3c/WbietIKDX3lmK23IcRHhJUD/PIHFaR+JKhA=
X-Received: by 2002:a2e:3012:0:b0:277:32d:34b4 with SMTP id
 w18-20020a2e3012000000b00277032d34b4mr8044871ljw.112.1667340110382; Tue, 01
 Nov 2022 15:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAM6Wdxc0KRJMXVAA0Y=u6Jh2V=uWB-_Fn6M4xRuNppfXzL1mUg@mail.gmail.com>
 <20221031145046.2a7f9d32@rorschach.local.home> <CAM6WdxeZbGmRopXqLtDNTwPOahnyC6GrCfv4H1m=mF41-J=VbA@mail.gmail.com>
 <20221101153135.5345c748@rorschach.local.home> <CAM6WdxfYU1Dc6dkMQMSGjgiggrziLvfwVPJV5OC02_AQO8YkVw@mail.gmail.com>
 <20221101173802.7a476a04@rorschach.local.home> <CAM6WdxdAF5X8v_tbL1LvNDXgEPY5veL_OtQv5CrADV9qH4um-g@mail.gmail.com>
In-Reply-To: <CAM6WdxdAF5X8v_tbL1LvNDXgEPY5veL_OtQv5CrADV9qH4um-g@mail.gmail.com>
From:   Roland Ruckerbauer <roland.rucky@gmail.com>
Date:   Tue, 1 Nov 2022 23:01:38 +0100
Message-ID: <CAM6WdxfsP13aS62=xWNTFEEzAekAuDwFTpnONP9qF3br-65KWQ@mail.gmail.com>
Subject: Re: [BUG] NULL pointer dereference probably caused by kernel/trace/ring_buffer.c
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        regressions@lists.linux.dev,
        Steven Noonan <steven.noonan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just figured out something, the poll() errors starting at fd 29 (which
is CPU 24).
But I only have 24 cores. Looked at
/sys/kernel/debug/tracing/instances/rasdaemon/per_cpu/, and voila, it
lists 32 cpus not 24.
