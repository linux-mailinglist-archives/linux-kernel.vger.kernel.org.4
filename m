Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7908A647275
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLHPGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLHPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:06:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CBD57B54
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:06:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1806CB82439
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A89C433C1;
        Thu,  8 Dec 2022 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670511991;
        bh=RpnrviEbFDIpdJQF9m6keZwuAic3Ld19rC7PuI9w9Pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qv9EgHMwY9WsdrwNl3reVIS8TiRMXn6jY2fLWZVamOYBzILHc5qvI1ryoYaRSvJxz
         3z0p/4CPXOtLXTq8Nftq0Nn8RMAO55HVawqoeCqVv1jj+8AimI5l4Dm5wta/CPJnFi
         ED3bhhrXI5QSfzLA1IXiWmDvGowhv9t5mDboZSf65VXN2msEkmXkV2yW7vL20C2/ea
         LaxALrG+6nJ8FN1stQilYL+E+xPPraZKvBHF5ViMKTRNksQZtIavc/UphA4kCTVnp9
         q5cUM7H7dn5o8W71vZionO2kBA0oPiNUvzqMtlv2f3w2Jz69gJzcFfgnbcIjlqpYEf
         3kWLf14eu3S7Q==
Date:   Thu, 8 Dec 2022 15:06:19 +0000
From:   Lee Jones <lee@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: core: fix UAF while using device of node
Message-ID: <Y5H9W6KVXhD9bcNT@google.com>
References: <20221116074116.1022139-1-yangyingliang@huawei.com>
 <9ad01578-9982-fd55-14a3-a74bf0906165@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ad01578-9982-fd55-14a3-a74bf0906165@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Dec 2022, Yang Yingliang wrote:

> Hi,
> 
> On 2022/11/16 15:41, Yang Yingliang wrote:
> > I got the following UAF report:
> > 
> >    refcount_t: underflow; use-after-free.
> >    WARNING: CPU: 1 PID: 270 at lib/refcount.c:29 refcount_warn_saturate+0x121/0x180
> >    ...
> >    OF: ERROR: memory leak, expected refcount 1 instead of -1073741824,
> >    of_node_get()/of_node_put() unbalanced - destroy cset entry:
> >    attach overlay node /i2c/pmic@62/powerkey
> > 
> > The of_node of device assigned in mfd_match_of_node_to_dev() need be
> > get, and it will be put in platform_device_release().
> > 
> > Fixes: 002be8114007 ("mfd: core: Add missing of_node_put for loop iteration")
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Is this patch good or do you have any suggestion ?

Looks okay, but I'm not applying it this late in the cycle.

Please wait until the next merge-window closes.

-- 
Lee Jones [李琼斯]
