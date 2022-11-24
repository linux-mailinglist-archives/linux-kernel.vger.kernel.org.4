Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC54637DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKXQqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKXQqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:46:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1981FE6744;
        Thu, 24 Nov 2022 08:46:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8773B82889;
        Thu, 24 Nov 2022 16:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB41C433C1;
        Thu, 24 Nov 2022 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669308407;
        bh=Sn8M4fx8fx/wEVCyRTVc4X373HlczYcWv7HjAxwc5f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uxzBwFCXMfC+OaHTIgdLoJiCIVjBaSjFWm9ahSGrxrkceB/AwYJkruTiTJJ8Akrzy
         FMjCvt2zU1tL9j5RjFQoi7WRGK2sc/qXadQevenQc4pRJjumeEjYEZ+Ncz8URypB9Q
         6NOJneQEWR8e9lsoSmUfcXQR8CJZt7jsMf8ChmtE=
Date:   Thu, 24 Nov 2022 17:46:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 00/10] misc: fastrpc: Add audiopd support
Message-ID: <Y3+f9OGt5qEYEmrt@kroah.com>
References: <20220909133938.3518520-1-abel.vesa@linaro.org>
 <83a961ef-132e-6b9a-37e0-182ea2025be4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83a961ef-132e-6b9a-37e0-182ea2025be4@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 11:07:55AM +0000, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> On 09/09/2022 14:39, Abel Vesa wrote:
> > This patchset adds audiopd support to fastrpc.
> > 
> > The v2 of this patchset is here:
> > https://lore.kernel.org/all/20220902154900.3404524-1-abel.vesa@linaro.org/
> > 
> > Abel Vesa (10):
> >    misc: fastrpc: Rename audio protection domain to root
> >    misc: fastrpc: Add reserved mem support
> >    dt-bindings: misc: fastrpc: Document memory-region property
> >    misc: fastrpc: Add fastrpc_remote_heap_alloc
> >    misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail
> >    misc: fastrpc: Rework fastrpc_req_munmap
> >    misc: fastrpc: Add support for audiopd
> >    misc: fastrpc: Safekeep mmaps on interrupted invoke
> >    misc: fastrpc: Add mmap request assigning for static PD pool
> >    misc: fastrpc: Add dma_mask to fastrpc_channel_ctx
> > 
> 
> Do you think you could pick these fastrpc patches as it is or should I
> collect these patches with other fastrpc patches on the list and send them?
> 
> As there are few more of fastrpc patches that could go in 6.2.

Pleasae collect them all up and send them on to me.

thanks,

greg k-h
