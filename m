Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC626708656
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjERRDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjERRDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:03:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1CB10DF;
        Thu, 18 May 2023 10:03:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 534BA61A1D;
        Thu, 18 May 2023 17:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3E1C4339B;
        Thu, 18 May 2023 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684429382;
        bh=VCCeLI373vWJ8f/V7BOKXbKqCsAysHhGwbaiZFbiJmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EueXkezxKj8nsJY6EorpUBrXyGljC2oM1QZ+ceid8fG1IVIYkpXDLZkMjfRN5QDB2
         Z150nRe+/hVcuOORPtXaJpq4vHrFh8+lRXxhG/NhNmUcALYlk8/5i6PNh4+43oSnVT
         4LI0+bZ40SX2fM6qVvrG0jDp5dQs+XT/WTGa2QkUUaLUvwBpF5wuoZ9PSErDbJN6cc
         JizqUfJeuDqzlpg2rmHRyHJcq256RFrmrFcK1qdYxA3QbC0y+2vZZzwQ7TNEfbXvgs
         oMjAOzZmPeCxnng3UUPTAvmK0inbvh5x+G0+ctVTPM+n0HmhH10s8Y0aZynM8QFKsz
         mpq6yWqZTxQhg==
Date:   Thu, 18 May 2023 13:03:01 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-kernel@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.3 08/59] bpf, mips: Implement DADDI workarounds
 for JIT
Message-ID: <ZGZaRfsA/FTvZcsX@sashalap>
References: <20230504194142.3805425-1-sashal@kernel.org>
 <20230504194142.3805425-8-sashal@kernel.org>
 <50FCC591-D86A-46A3-AF4A-DD68D2FACC78@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50FCC591-D86A-46A3-AF4A-DD68D2FACC78@flygoat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 01:04:14PM +0100, Jiaxun Yang wrote:
>
>
>> 2023年5月4日 20:40，Sasha Levin <sashal@kernel.org> 写道：
>>
>> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>
>> [ Upstream commit bbefef2f07080cd502a93cb1c529e1c8a6c4ac8e ]
>>
>> For DADDI errata we just workaround by disable immediate operation
>> for BPF_ADD / BPF_SUB to avoid generation of DADDIU.
>>
>> All other use cases in JIT won't cause overflow thus they are all safe.
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
>> Link: https://lore.kernel.org/bpf/20230228113305.83751-2-jiaxun.yang@flygoat.com
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Hi Sasha,
>
>I think this patch should count as a functional improvement instead of regression fix.
>
>Please drop it from stable queue.

Dropped, thanks!

-- 
Thanks,
Sasha
