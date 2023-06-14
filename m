Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE9172F333
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjFNDpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjFNDpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:45:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C64DE4D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64C0B63CA5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B907C433C0;
        Wed, 14 Jun 2023 03:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686714339;
        bh=vybn/0UP/i4FCllwB+QLyE9U1pCAzcrXTRNnoZxtrDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gUf+RUxHrvb43aEu7iFgxT4YPIWR0mDA0sobv9DdyKJsLEunXHtis1iEjVGwc1fnz
         Vda55/qLETgWm8WcFxOfZc34OThIDeF7wDMrFJmdrPnokua5Cs1CMPCOACsTOMUqRm
         /N8lsL10BP7cm0XrC/AzhUhRq83CAobSf51oXhLAeGrUUBrTzVVJ5uHQMxjeFDNSCZ
         m6TI4fhVDsmyoKv9hPIIIrIx19fZOPmsF5THKIgS5MvjqyI9hE/uv6kREVKaIyoNze
         lJqRPc9bmyL9daoy14cexSt27g/HmPRInPVuqzRWMNM1MuT6B1Dz7WELDScGzcfuXp
         fOWy0MSt+OXBg==
Date:   Tue, 13 Jun 2023 20:45:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hillf Danton <hdanton@sina.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net 2/2] net/sched: qdisc_destroy() old ingress and
 clsact Qdiscs before grafting
Message-ID: <20230613204538.726bc0a4@kernel.org>
In-Reply-To: <7f773c114001cbcd0c6ff21da9976eb0ba533421.camel@redhat.com>
References: <cover.1686355297.git.peilin.ye@bytedance.com>
        <c1f67078dc8a3fd7b3c8ed65896c726d1e9b261e.1686355297.git.peilin.ye@bytedance.com>
        <7f773c114001cbcd0c6ff21da9976eb0ba533421.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 10:39:33 +0200 Paolo Abeni wrote:
> The fixes LGTM, but I guess this could deserve an explicit ack from
> Jakub, as he raised to point for the full retry implementation.

AFAIU the plan is to rework flags in net-next to address the live lock
issue completely? No objections here.
