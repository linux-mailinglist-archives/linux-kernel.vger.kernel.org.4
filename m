Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49226FF20F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbjEKNCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjEKNCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:02:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0681BFF
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C37B064CC0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118FCC433EF;
        Thu, 11 May 2023 13:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683810166;
        bh=sObupSBzb6+eT7mNGEYA+/hRNFw5wsaKlXnIuXNdy5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RVOxalxkdwWrBjsYtYQ63s8k4vRZeetzuFLnCMMHu1l0y0ku45V4sccWrs4OJQwAk
         LpGEsHjsMtazblUDgC8p5QNJYhlL5GSeHHV7xEH6uobuf1Sob4AmsyY7ydWyFOFmF4
         Ogm8fTNhFKSMY78NRIS7gA402JKCWYWjG5CXUrY+u2uBNJ1jelcBodP6QAg/A96qp6
         fswiO8lT4akdh8cyxsrmt6JqBjsQAPHJA68Cp02g12kXPHPEGaR8ZVnU0Ov2Si3fPx
         lp64m4VTugJJZawoVLcq39THtEu7kYXA9PmVoLesE8scVoho3FPrvNgXSozd+hskpz
         fpeEctTo/Dp6w==
Date:   Thu, 11 May 2023 15:02:40 +0200
From:   Simon Horman <horms@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     Shenwei Wang <shenwei.wang@nxp.com>, Wei Fang <wei.fang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: Re: [PATCH v2 net 1/1] net: fec: using the standard return codes
 when xdp xmit errors
Message-ID: <ZFzncPmqH1C5HAyf@kernel.org>
References: <20230510200523.1352951-1-shenwei.wang@nxp.com>
 <20230511072452.umskoyoscsxgmcoo@soft-dev3-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511072452.umskoyoscsxgmcoo@soft-dev3-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 09:24:52AM +0200, Horatiu Vultur wrote:
> The 05/10/2023 15:05, Shenwei Wang wrote:
> > 
> > This patch standardizes the inconsistent return values for unsuccessful
> > XDP transmits by using standardized error codes (-EBUSY or -ENOMEM).
> 
> Shouldn't this patch target net-next instead of net? As Simon suggested
> here [1], or maybe is just me who misunderstood that part.
> Also it is nice to CC people who comment at your previous patches in all
> the next versions.
> 
> Just a small thing, if there is only 1 patch in the series, you don't
> need to add 1/1 in the subject.
> 
> [1] https://lore.kernel.org/netdev/20230509193845.1090040-1-shenwei.wang@nxp.com/T/#m4b6b21c75512391496294fc78db2fbdf687f1381
> 
> > 
> > Fixes: 26312c685ae0 ("net: fec: correct the counting of XDP sent frames")

Hi Shenwei,

I agree with Horatiu.

Also, this is not a fix. So it should not have a Fixes tag.

After waiting for further review please send a v3 with these updates.

pw-bot: cr
