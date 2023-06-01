Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B097197DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjFAJ4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjFAJyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:54:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D35E53;
        Thu,  1 Jun 2023 02:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C70F5642AA;
        Thu,  1 Jun 2023 09:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1341EC433A1;
        Thu,  1 Jun 2023 09:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685613270;
        bh=LBqHWjOXWHLVP7NmjizqJrn/SFhLwC0EcVXIWfRrzzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U8qkzq8ezNBbLMhO9LpawjTYIaqNQh0SCLdz5SaKDrPvhpL2zgR7715KEN+2T1vFb
         k2x8QauBDIfHsGNLsEio1PmSNZhQTJd/VAJylkO99Is6feBHTh7zMibzPgPGZsOQ1L
         834yZXO3LiDdVIuNTUboop9qwM2GBC9ghdToFJcy5hJ1tlg56L6qydc/kv0SOcNfpK
         Gpua8g0mQMBWSgOPLYJBkukReICp5WS6WyohrajcbuFyFS46HTT4HuJW/+iUKhdAAE
         LX7TrBQshW+fH3Fpl2cfEzv/9CMBey0wg1ZgS8JaFOwBJdtwnUl5IyKDONb6IGq62N
         kAEz1i3wIidFw==
Date:   Thu, 1 Jun 2023 05:54:28 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lucas Tanure <tanure@linux.com>, Rob Herring <robh@kernel.org>,
        robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.3 06/11] of: fdt: Scan /memreserve/ last
Message-ID: <ZHhq1DKT1CBSTQlz@sashalap>
References: <20230511193757.623114-1-sashal@kernel.org>
 <20230511193757.623114-6-sashal@kernel.org>
 <20230515-headroom-swirl-a0a845584a58@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230515-headroom-swirl-a0a845584a58@spud>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 09:21:04PM +0100, Conor Dooley wrote:
>Hey Sasha,
>
>On Thu, May 11, 2023 at 03:37:49PM -0400, Sasha Levin wrote:
>> From: Lucas Tanure <tanure@linux.com>
>>
>> [ Upstream commit b413281876292de44ae84e9a9ce9d62e47f266e9 ]
>>
>> Change the scanning /memreserve/ and /reserved-memory node order to fix
>> Kernel panic on Khadas Vim3 Board.
>>
>> If /memreserve/ goes first, the memory is reserved, but nomap can't be
>> applied to the region. So the memory won't be used by Linux, but it is
>> still present in the linear map as normal memory, which allows
>> speculation. Legitimate access to adjacent pages will cause the CPU
>> to end up prefetching into them leading to Kernel panic.
>>
>> So /reserved-memory node should go first, as it has a more updated
>> description of the memory regions and can apply flags, like nomap.
>>
>> Link: https://lore.kernel.org/all/CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com/
>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>> Link: https://lore.kernel.org/r/20230424113846.46382-1-tanure@linux.com
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Rob requested that this patch (and it's bretheren in other AUTOSEL
>series) not be backported immediately:
>| Going to let this sit in linux-next for a bit. I also didn't tag for
>| stable kernels. I want it to get some exposure in mainline at least for
>| a few -rc releases rather than getting backported right away. Please
>| help ensure that happens if you see stable review emails. I'm going to
>| be offline most of the next month.
>https://lore.kernel.org/linux-devicetree/168262872454.3491083.6407810340850053636.robh@kernel.org/
>
>Perhaps delaying it for another couple of weeks, since we have only just
>had -rc2, is a good idead?

I'll drop it, let me know when you want it included back. Thanks!

-- 
Thanks,
Sasha
