Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B806B416E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCJNwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjCJNww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:52:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11A5115668;
        Fri, 10 Mar 2023 05:52:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A44F5B822B4;
        Fri, 10 Mar 2023 13:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B19DC433D2;
        Fri, 10 Mar 2023 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678456357;
        bh=dpDGW2N1xqRPYgeros8o5hPMwYMnc2iwLM7fkp1Wqs0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=q0Tn/K2AN7/bNlSBDz0jmL0PSDR8Cqag47gd0zulxUjLo7J4xUc3SlT75f1Co1K2m
         IZ2SFMrcb8CJQHO8jVybi8U5lBimhJ7OTTgGLYbP7mB5sfzPh3mh3g/EnYKHHoqatf
         u4Fzs2hLYcRCHjxal53dGzF3kg54yTpuINRdS2ajPMaC11Sowf5BHTTl3XEzKhMh6q
         WO3ZwPJI8ToMKnGOwepwi7wr8tQFcTWx6ZyR83oI319Qb99x/W5YIVpTPezoRznPDN
         tPc7dgytpwjN7U0j1ljVGgDDi3quk393qFVX/mb1tdMSF20IX8vhKcrrhDkSBBr9kM
         Ju7SE3VAHkbaQ==
Message-ID: <21a188b3-d3f9-ac13-4e9b-d870401b074f@kernel.org>
Date:   Fri, 10 Mar 2023 14:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv2 2/2] trace/hwlat: Do not start per-cpu thread if it is
 already running
Content-Language: en-US
To:     Tero Kristo <tero.kristo@linux.intel.com>, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230310100451.3948583-1-tero.kristo@linux.intel.com>
 <20230310100451.3948583-3-tero.kristo@linux.intel.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230310100451.3948583-3-tero.kristo@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 11:04, Tero Kristo wrote:
> The hwlatd tracer will end up starting multiple per-cpu threads with
> the following script:
> 
>     #!/bin/sh
>     cd /sys/kernel/debug/tracing
>     echo 0 > tracing_on
>     echo hwlat > current_tracer
>     echo per-cpu > hwlat_detector/mode
>     echo 100000 > hwlat_detector/width
>     echo 200000 > hwlat_detector/window
>     echo 1 > tracing_on
> 
> To fix the issue, check if the hwlatd thread for the cpu is already
> running, before starting a new one. Along with the previous patch, this
> avoids running multiple instances of the same CPU thread on the system.
> 
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel
