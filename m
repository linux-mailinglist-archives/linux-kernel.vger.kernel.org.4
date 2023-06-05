Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67EB722DA1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjFER04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbjFER0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:26:52 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6407B113
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:26:49 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-52857fc23b1so4515272a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685986008; x=1688578008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gI5++jso8zojBV0vx6mKi/JVB3NStV9TzsSq8gpkyGA=;
        b=PSwb4y32X+7AX397LSBZScP3Tf2M7xCGNFdQmHQr9VKemE8hVL+QDGlKh+EBEdBIot
         paGsVJwM1q9ohix7Fl1ICi9rNp1cpN7X/So5fNTRn7CjJxfKGx8MQpk6E7LdLUaLJzdd
         yvrnI2CbMfwqB4YiSNDB7datL+0i9c3OZP4yPpiYH4TExE7A209nlepyNBSXyTfbUVWb
         1kyqHHHc5b+EuaMkhMaXzK5L8VbGVLP6Ly6ubQ1VWwTmhNo+gHIgQkrbN5HteXwJhfE8
         lIWsJ5sgQ/+DC7JLi1cqKzf4crOks92AaVcxmV98G3gafZC5VOF4zfZ1HNW3o8GGRSNH
         zeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685986008; x=1688578008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gI5++jso8zojBV0vx6mKi/JVB3NStV9TzsSq8gpkyGA=;
        b=Jy/BtwNkFrSs79fn2LP/bj4AZqG+8f4Dif+8q03lLzW1RaRpEzgL6PlNrgVVfNznlB
         P3tJ8j3gyy+z9lfl3nttEiuiNt+TXNBlMU9nJGlyuQxTVaOLqoFgJNz4kDI/wS0APnAI
         pm6sgN9I/RmnCPbQdC+pAPlSw0EOAnxkPvwuQWdEmvt3gO28KWNfamYafk4PSuL5NrHH
         B9sdvUemrWaplM8yOOfPK/D2XELXzJ5dbdAm2Zfb1dInqhuO47vkIPSXILQJS1twQeYp
         vJ3MTktXrAcd4rC7UyvCAMWqFq/QMZFAo7UZJuxXdxglZETE4AlAla1VI296jmiwpQmt
         h9yQ==
X-Gm-Message-State: AC+VfDyuclk0lXwVdRwZV7u1G93VBVQ0qFZR7u3HztSjmjWEUzKuyGqM
        4+cAVSkNpmt5rIFjG/cLqII1/Is=
X-Google-Smtp-Source: ACHHUZ7jBorG0N5niR51/rjKQ02tEOhsYvW3GusoQqySYItyHe2yyK+9rICJCRfVrzhy+Jm09OGOWcs=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:1542:0:b0:50c:a00:c1fa with SMTP id
 2-20020a631542000000b0050c0a00c1famr85783pgv.7.1685986008448; Mon, 05 Jun
 2023 10:26:48 -0700 (PDT)
Date:   Mon, 5 Jun 2023 10:26:46 -0700
In-Reply-To: <20230605033449.239123-1-liuxin350@huawei.com>
Mime-Version: 1.0
References: <20230605033449.239123-1-liuxin350@huawei.com>
Message-ID: <ZH4a1l1pfG8ewo3v@google.com>
Subject: Re: [PATCH] libbpf:fix use empty function pointers in ringbuf_poll
From:   Stanislav Fomichev <sdf@google.com>
To:     Xin Liu <liuxin350@huawei.com>
Cc:     daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        hsinweih@uci.edu, jakub@cloudflare.com, john.fastabend@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzbot+49f6cef45247ff249498@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05, Xin Liu wrote:
> From: zhangmingyi <zhangmingyi5@huawei.com>
> 
> The sample_cb of the ring_buffer__new interface can transfer NULL. However,
> the system does not check whether sample_cb is NULL during 
> ring_buffer__poll, null pointer is used.

What is the point of calling ring_buffer__new with sample_cb == NULL?
