Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A89562A17C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiKOSmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKOSmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:42:31 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C67B2EF5C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:42:30 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id l4-20020a170903244400b00188c393fff1so5366502pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=upp3xuPUqFgBifk0MziDCU3KXshXPKZfotY7q9TX0Ao=;
        b=M+ayA7Evg1qqUP/5ClI2/pfzlCK3DjfiRWi2h90dAUKX8Veki4vekOpdIwkCpGxXhu
         dKVSdhGQvRSWWv8rLRJwCQjKMJ2ls+ZfmcZ8wei45ApLn/8ZCMGsO4/Hzz442vsJVn0G
         UovgDytAoB1fdNRXs5ftW1ux5GEqRK3OHkXpu9QgQLAlIj/8J66z4nIcwDU0xKZq6Ppy
         egJqhhTZiAHgQQTnQTOy4BYjW/eb1VOWFQqJyeQVJ9vu8nQeaLr0a7p4v4IxwlWJC9S9
         wwOmXubSdnQcG5nBCkxinjtfIiGz3PwlWcbXv87zwZpsbX75hOu6nq8BV5ndki89uT79
         dgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upp3xuPUqFgBifk0MziDCU3KXshXPKZfotY7q9TX0Ao=;
        b=ZZFmg/Gb+rkOQ24+6pMrqRRH4IyOYhr5+AuZ9HJYHDsNYW1ZeEi4VZt+Hp/S74PUx7
         o7wdDKYam/U4tQFYC4pUdIkwMuArsbngaL6ln/uKEEUfvj9s69i4H5eiLsjQBESEv3dc
         1bbp9fJvDDrUpiDmvX5uVNSzW7FslBda5yJ79SvsTI4WwiHBMZHAx+3e7BJL0tXQIkCV
         AtehOPokwHeUYM3yu7pYKSk8bCcAqsBh09JrUFQ4/rIiZhS2hFBS5CGOcMRpRDqQgCgL
         bs1peedqA1M4X7ZZMVJg0uohxCPCufzhhXE7FywQN6mDTOvWACQwxwbpSH+CvVyL8Fdr
         z2Ug==
X-Gm-Message-State: ANoB5pn+0LZDe8U7z0PSlbDdvkWw/SHcUmVo4ZK5RT43Pizj1ySRCyhF
        w3a2sSRcJU0kzeRd1iPWJEQqDq8=
X-Google-Smtp-Source: AA0mqf5Wo9rUwTp6N6LxIHlVY1a27mW8hhU5yEv6CA5FN6k6Iht03uVoYvjKxEjbi9jVPK29ozBn0dI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:2403:b0:186:9fb9:1f8c with SMTP id
 e3-20020a170903240300b001869fb91f8cmr5214872plo.69.1668537750032; Tue, 15 Nov
 2022 10:42:30 -0800 (PST)
Date:   Tue, 15 Nov 2022 10:42:28 -0800
In-Reply-To: <1668517207-11822-1-git-send-email-yangtiezhu@loongson.cn>
Mime-Version: 1.0
References: <1668517207-11822-1-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <Y3PdlPVxobFMVYoX@google.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Check argc first before "file" in do_batch()
From:   sdf@google.com
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15, Tiezhu Yang wrote:
> If the parameters for batch are more than 2, check argc first can
> return immediately, no need to use is_prefix() to check "file" with
> a little overhead and then check argc, it is better to check "file"
> only when the parameters for batch are 2.

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>   tools/bpf/bpftool/main.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 741e50e..337ab79 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -337,12 +337,12 @@ static int do_batch(int argc, char **argv)
>   	if (argc < 2) {
>   		p_err("too few parameters for batch");
>   		return -1;
> -	} else if (!is_prefix(*argv, "file")) {
> -		p_err("expected 'file', got: %s", *argv);
> -		return -1;
>   	} else if (argc > 2) {
>   		p_err("too many parameters for batch");
>   		return -1;
> +	} else if (!is_prefix(*argv, "file")) {
> +		p_err("expected 'file', got: %s", *argv);
> +		return -1;
>   	}
>   	NEXT_ARG();

> --
> 2.1.0

