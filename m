Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08696835AE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjAaSva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjAaSv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:51:27 -0500
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0271E83FE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:51:23 -0800 (PST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id BC972400;
        Tue, 31 Jan 2023 19:51:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz BC972400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1675191080; bh=3nzYCZcw7/+jFcY6pwONKDi/Zj110sMOebq8ZsrjNjM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GXZnwlhSkswK+mEpgA8fhz/5fjAo+UljjKdsOQUj/76cW3/l1wXao2eYvA2xrWt+k
         9U//imSekCazruTt4GWYc1/fE3xerxyBGTU/Onrv5r+I3dJvg6iMi/3pDyPp9EdIF9
         wW1J9k6z66TOvVwXIioU1XIzpr2Y5pU7LiZE8uj8=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue, 31 Jan 2023 19:51:12 +0100 (CET)
Message-ID: <9d61d3c1-c94c-a9c6-2d0d-3368e02e1943@perex.cz>
Date:   Tue, 31 Jan 2023 19:51:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 0/6] Fix default DMIC gain on AMD PDM drivers
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Jaroslav Kysela <jkysela@redhat.com>,
        Mukunda Vijendar <Vijendar.Mukunda@amd.com>,
        Saba Kareem Syed <Syed.SabaKareem@amd.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Mark Pearson <mpearson@lenovo.com>,
        Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>
References: <20230131184653.10216-1-mario.limonciello@amd.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230131184653.10216-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31. 01. 23 19:46, Mario Limonciello wrote:
> It's been reported that a number of laptops have a low volume
> level from the digital microphone compared to Windows.
> 
> AMD offers a register that can adjust the gain for PDM which is not
> configured at maximum gain by default.
> 
> To fix this change the default for all 3 drivers to raise the gain
> but also offer a module parameter. The module parameter can be used
> for debugging if the gain is too high on a given laptop.
> 
> This is intentionally split into multiple patches for default and
> parameter so that if the default really does behave better universally
> we can bring it back to stable too later.
> 
> v2->v3:
>   * Use clamp and clear properly
> 
> Mario Limonciello (6):
>    ASoC: amd: yc: Adjust the gain for PDM DMIC
>    ASoC: amd: yc: Add a module parameter to influence pdm_gain
>    ASoC: amd: renoir: Adjust the gain for PDM DMIC
>    ASoC: amd: renoir: Add a module parameter to influence pdm_gain
>    ASoC: amd: ps: Adjust the gain for PDM DMIC
>    ASoC: amd: ps: Add a module parameter to influence pdm_gain

For all patches:

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

