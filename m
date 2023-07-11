Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C6E74E65D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjGKFdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGKFdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:33:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FBF134;
        Mon, 10 Jul 2023 22:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=IfAvbg/acDNQeoM7eEbFiEz6wtRsGjbKzIBXP8u7GMA=; b=aivrftftA46cvcQwatC4SCcEe8
        /a+CHbq3Yz8LqhdFj9rppYc5cOpKdtCoffhtrl9sCkE0wogKFtEUy/nRxQ9LYHmVfEr7ARlfIaDCq
        QmQd2b7YxCJzsCXcjuadykyrBexWs4D2H+jdyUopRCmfFpcEqNBDEW+9Vy8X26VhEhmC+XdVKJEbk
        bJoAk9IZPR3BObc4rAWXgwbf+PNtE5zaYDo/xzgGIdOd0pQhcqYX8y1EDC+ahNcwko0KYkoQm297f
        ToZhBBMD2dxF1+uZqzXeG32ROC0QOW4SrDhhIejGnZbkbMNGSscOSfwT6crReVXeoN7RE0v/hr9rq
        fEAVp4qQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ5zw-00DlWW-2Y;
        Tue, 11 Jul 2023 05:33:17 +0000
Message-ID: <b464f2b4-d2bc-11e0-bb2e-45ff43934bf6@infradead.org>
Date:   Mon, 10 Jul 2023 22:33:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Build regressions/improvements in v6.5-rc1 (cpufreq/sparc*)
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <CAHk-=wj8sPDVoWgaceAs1AiwZrHV8mtC3vQNGbeV6-RypJi6aw@mail.gmail.com>
 <20230710100012.2625532-1-geert@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230710100012.2625532-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/10/23 03:00, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v6.5-rc1[1] compared to v6.4[2].
> 
> Summarized:
>   - build errors: +3/-4
>   - build warnings: +36/-18
> 
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
> 
> Happy fixing! ;-)
> 
> Thanks to the linux-next team for providing the build service.
> 
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5/ (all 162 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6995e2de6891c724bfeb2db33d7b87775f913ad1/ (160 out of 162 configs)
> 
> 
> *** WARNINGS ***
> 
> 36 warning regressions:

>   + modpost: WARNING: modpost: drivers/cpufreq/sparc-us2e-cpufreq: section mismatch in reference: cpufreq_us2e_driver+0x20 (section: .data) -> us2e_freq_cpu_init (section: .init.text):  => N/A
>   + modpost: WARNING: modpost: drivers/cpufreq/sparc-us3-cpufreq: section mismatch in reference: cpufreq_us3_driver+0x20 (section: .data) -> us3_freq_cpu_init (section: .init.text):  => N/A

The way that I read this is that these __init functions (us2e_freq_cpu_init and us3_freq_cpu_init)
should not be marked as __init since they can be called at any time by exercising the CPU hotplug
code path.

-- 
~Randy
