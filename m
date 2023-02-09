Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3036C6911E2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjBIUGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjBIUGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:06:17 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967F06BA94
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 12:05:49 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id iz19so2769301plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 12:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CIfREX/YQWh4b/q/oQJmrJNs03C5pbZw938goHZ0As0=;
        b=C3LGkKaZ/egq9pyVVyVUA/uUoyAfyHfgHZtTpDQ42GhMZ5h6GZ1iZ4R7W9FnEMNf+W
         z273Vxq5Fu0FUidkreu9oK0Il3x8I5FgMMlY9mplRGsomy2jRPQb6DoZhFjQg4KbSjlH
         TpGfM2kAFHBlSy0ig7CVp38EvJMZ6MCsrLsik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIfREX/YQWh4b/q/oQJmrJNs03C5pbZw938goHZ0As0=;
        b=Wazm0arJVDx6jc1SmXi/yhwqnVHuwTGkbDJ6h4ROZi68/5QnM0iUQi8KOPXeplS8uW
         3W8YLPirc0BioHhJRwPeYsmmQcLWkLRRFiR7pLiPKTX6dTn7ugwbtNJyw4YSmr/82xmM
         jq36YKf4Ac5QkNIF6lZrd11ETdJob0Eldyql9gqYZrDsCYSQN0bxPRxZPaIaX9fa9sY5
         VfE6zs7Wu2ATNiYn6DL9amDeMhJkgutO63Ir7x6zrpryhNCOx5+mYqofkXjd7/hGf5Ek
         8APP2usxkvv0kW9Adx5QFvl1+ubKfyy6GBpWyB1Olmua8Ep3MQZmvT4x3ApxmzQ5FkzE
         Rknw==
X-Gm-Message-State: AO0yUKWE0d2FrulOtfxUk0lWpPcOmkNfcQOSJU0M0UCTE+VoP3NjwRzZ
        epaKqMhL6um3qZYf4EVWtNBDJw==
X-Google-Smtp-Source: AK7set/V2FOS5XFwG1dSzxjyTU/evZqkEa4kdYXJ7FE1Q2EBIaFEC8a8SbHRIQBi30Xmq4fgtz7Mzg==
X-Received: by 2002:a17:902:e5ce:b0:197:19f7:52b4 with SMTP id u14-20020a170902e5ce00b0019719f752b4mr14816901plf.42.1675973146806;
        Thu, 09 Feb 2023 12:05:46 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jm13-20020a17090304cd00b001948ff5cc32sm1883026plb.215.2023.02.09.12.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 12:05:46 -0800 (PST)
Message-ID: <63e5521a.170a0220.297d7.3a80@mx.google.com>
X-Google-Original-Message-ID: <202302091202.@keescook>
Date:   Thu, 9 Feb 2023 12:05:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bpf: Deprecate "data" member of bpf_lpm_trie_key
References: <20230209192337.never.690-kees@kernel.org>
 <CAEf4BzZXrf48wsTP=2H2gkX6T+MM0B45o0WNswi50DQ_B-WG4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZXrf48wsTP=2H2gkX6T+MM0B45o0WNswi50DQ_B-WG4Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 11:52:10AM -0800, Andrii Nakryiko wrote:
> Do we need to add a new type to UAPI at all here? We can make this new
> struct internal to kernel code (e.g. struct bpf_lpm_trie_key_kern) and
> point out that it should match the layout of struct bpf_lpm_trie_key.
> User-space can decide whether to use bpf_lpm_trie_key as-is, or if
> just to ensure their custom struct has the same layout (I see some
> internal users at Meta do just this, just make sure that they have
> __u32 prefixlen as first member).

The uses outside the kernel seemed numerous enough to justify a new UAPI
struct (samples, selftests, etc). It also paves a single way forward
when the userspace projects start using modern compiler options (e.g.
systemd is usually pretty quick to adopt new features).

> This whole union work-around seems like just extra cruft that we don't
> really need in UAPI.

The union is really only there so that possible uses of container_of()
would be happy. But I did add a BUILD_BUG_ON() test for member offset
equality, so a hard cast would be safe too. I'm happy to drop it if
that's preferred?

-- 
Kees Cook
