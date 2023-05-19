Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8128B709F80
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjESTBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjESTBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:01:17 -0400
Received: from out-55.mta0.migadu.com (out-55.mta0.migadu.com [IPv6:2001:41d0:1004:224b::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C32DFA
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:01:16 -0700 (PDT)
Message-ID: <073cf884-e191-e323-1445-b79c86759557@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684522872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nmyd7ev1kC4N1SPCSUefexlvGt6H+78x/hkY+aW/KbQ=;
        b=nMrIGWBUuBrYwb8WMXJDdRGeymsJlSPg+G2FjG+pCNRkP3gFcTl6dkgvY0saj70bprml22
        h7wyNaZRx0c8Vi5MQT7IkI4ZVLdDAni2uaNGgdWMuo3/DKIgM6I1gfXyZKFue5MeP8RPTL
        uML/nDfyMhAyBPSGzuncxyJqGPKUnDM=
Date:   Fri, 19 May 2023 12:01:09 -0700
MIME-Version: 1.0
Subject: Re: a small question about bpftool struct_ops
Content-Language: en-US
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>, bpf@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CAABZP2wiPdij+q_Nms08e8KbT9+CgXuoU+MO3dyoujG_1PPHAQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAABZP2wiPdij+q_Nms08e8KbT9+CgXuoU+MO3dyoujG_1PPHAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/23 5:07 AM, Zhouyi Zhou wrote:
> Dear developers:
> I compiled bpftool and bpf tests in mainline (2d1bcbc6cd70),
> but when I invoke:
> bpftool struct_ops register bpf_cubic.bpf.o
> 
> the command line fail with:
> libbpf: struct_ops init_kern: struct tcp_congestion_ops data is not
> found in struct bpf_struct_ops_tcp_congestion_ops

At the machine trying to register the bpf_cubic, please dump the vmlinux btf and 
search for bpf_struct_ops_tcp_congestion_ops and paste it here:

For example:
#> bpftool btf dump file /sys/kernel/btf/vmlinux

...

[74578] STRUCT 'bpf_struct_ops_tcp_congestion_ops' size=256 vlen=3
         'refcnt' type_id=145 bits_offset=0
         'state' type_id=74569 bits_offset=32
         'data' type_id=6241 bits_offset=512

