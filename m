Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718CA70B7F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjEVIrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjEVIrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:47:45 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540EBA8;
        Mon, 22 May 2023 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=k1tdzx4vAwXIV92zOVsZmImKM3IKiJYlisOunktC7RM=; b=i7roivs08Clf1Uck1tvH9I5uJA
        YkJNiBPORQwUixddu5Y43fiIGnpkoOS5Ztm9wzO9RvRqQQXIfn0YITpIzs+ISCyyvSJik/hrdYjyz
        Gb0G65gPeeTxF5LilXzbJ5V2FeFNyV4fKSSm+GMqboJO0hKE2IwI6NBzQJS7hwnanLXsYdMM5IpXO
        lgYv2Rd2yMz0paNKRrJRxlB6h6Uz4J9wMDT5mdP8xGre28i0mfD/t3LGXuZI/D472mkiUG6vDfzSW
        Q6nVtyIewWftxldo1FDidUVF509/af/X4aBg0xnWlA5gLj1FzZLzkdKsmP52+Mfpuw7iLJawtQBvt
        8Fv0E62A==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1q11CU-000BTa-3K; Mon, 22 May 2023 10:47:29 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1q11CT-00061B-E7; Mon, 22 May 2023 10:47:29 +0200
Subject: Re: [PATCH bpf-next] samples/bpf: hbm: Fix compile error about
 fallthrough marking
To:     Rong Tao <rtoax@foxmail.com>, ast@kernel.org
Cc:     Rong Tao <rongtao@cestc.cn>, Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <tencent_C11060D6C765B08AC1ABE2A801228381B206@qq.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ceda1ef3-0bd2-9273-af59-81d896189ac5@iogearbox.net>
Date:   Mon, 22 May 2023 10:47:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <tencent_C11060D6C765B08AC1ABE2A801228381B206@qq.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26915/Mon May 22 09:23:18 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 5:20 AM, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> commit f7a858bffcdd("tools: Rename __fallthrough to fallthrough") rename
> macro __fallthrough to fallthrough, commit 4b7ef71ac977("bpftool: Replace
> "__fallthrough" by a comment to address merge conflict") use comments to
> replace __fallthrough, here we can use fallthrough directly.
> 
> Compiling samples/bpf hits an error related to fallthrough marking:
>      ...
>      CC  samples/bpf/hbm.o
>      linux/samples/bpf/hbm.c: In function ‘main’:
>      linux/samples/bpf/hbm.c:501:25: error: ‘__fallthrough’ undeclared
>      (first use in this function); did you mean ‘fallthrough’?
>      501 |                         __fallthrough;
>          |                         ^~~~~~~~~~~~~
>          |                         fallthrough
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>   samples/bpf/hbm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Fixed here already:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=a820ca1a739b7e3ee0ddb48bdfa3c09dc7cd4302
