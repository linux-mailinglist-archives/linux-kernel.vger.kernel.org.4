Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A454C73D8F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjFZH5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjFZH5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:57:01 -0400
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0B110A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:56:58 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id B87A81E24;
        Mon, 26 Jun 2023 09:56:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz B87A81E24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1687766213; bh=IeCgRQNxrQ3a1y0bp9EimGNrftDyKTpDVhxmrEZe8Vo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fpj8S7Js7MWRLdA0pP1JWmLs1UlFE7sg15ctxSBVvR9P3PBqF6uoj2NaScJLWKRum
         P7lDcTvBWlAIXfL/SurcqZCYeHQ+C45RaGkJb7hF4Z8Yc6VMLaCQIsPP0+kGf/XsRS
         e9xjePgclLpTi+P5j1FL5LlAn+Sm+Ww6Km2Mzfw0=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon, 26 Jun 2023 09:56:47 +0200 (CEST)
Message-ID: <4d0931bf-b356-6969-5aaf-b663d7f2b21a@perex.cz>
Date:   Mon, 26 Jun 2023 09:56:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [BUG] ALSA: core: pcm_memory: a possible data race in
 do_alloc_pages()
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, Tuo Li <islituo@gmail.com>
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        baijiaju1990@outlook.com
References: <CADm8Tek6t0WedK+3Y6rbE5YEt19tML8BUL45N2ji4ZAz1KcN_A@mail.gmail.com>
 <877crqwvi1.wl-tiwai@suse.de>
 <CADm8Tenfy8joto5WLCqQWjfT8WimsbJgOss0hJe-ciyDRMrSXw@mail.gmail.com>
 <871qhywucj.wl-tiwai@suse.de>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <871qhywucj.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 06. 23 9:33, Takashi Iwai wrote:
> On Mon, 26 Jun 2023 09:31:18 +0200,
> Tuo Li wrote:
>>
>>
>> Hello,
>>
>> Thank you for your reply!
> 
> FWIW, the simplest fix would be something like below, just extending
> the mutex coverage.  But it'll serialize the all calls, so it might
> influence on the performance, while it's the safest way.

It may be better to update total_pcm_alloc_bytes before 
snd_dma_alloc_dir_pages() call and decrease this value when allocation fails 
to allow parallel allocations. Then the mutex can be held only for the 
total_pcm_alloc_bytes variable update.

Eventually, total_pcm_alloc_bytes may be atomic.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

