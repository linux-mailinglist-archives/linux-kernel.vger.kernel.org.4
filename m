Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3C0742273
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjF2Imy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjF2IlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181B4297B;
        Thu, 29 Jun 2023 01:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0210614C9;
        Thu, 29 Jun 2023 08:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABC2C433C0;
        Thu, 29 Jun 2023 08:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688028012;
        bh=AIUH8mRUplcQ3HfuP4DceQUR2BEXzAOyNoGosEpG0PU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x4n3wIhUv1ByMeGcPTOb6H9n7hguZqKF7JqlsTu8Kg7cxVmSt3uqLHrMOL3f6JNq2
         igHDe3mCw9jYTQayUmatdyXMcN96+kzmaN0GdCMnDYxtrF4SKkuK7z1W3zqKeDYsm7
         bUTR2ZXy5uSbhbJ1B5xthmN01KXdYU3Vs+2ykXdY=
Date:   Thu, 29 Jun 2023 10:40:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Zubin Mithra <zsm@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: xhci-mtk: set the dma max_seg_size
Message-ID: <2023062942-thumb-giddily-f0e0@gregkh>
References: <20230628-mtk-usb-v1-1-3c5b2ea3d6b9@chromium.org>
 <CANiDSCsAgD33gMk9-CTGHuUv_b4KfRnO02ETEt6jFtQvw+6cag@mail.gmail.com>
 <ZJystxdl0jVoe5b6@google.com>
 <CANiDSCu3WOqK9wdLDXmW+zbckq15gmxKjtFA4Aghv6uoidO_3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCu3WOqK9wdLDXmW+zbckq15gmxKjtFA4Aghv6uoidO_3Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 09:13:23AM +0200, Ricardo Ribalda wrote:
> Hi Zubin
> 
> On Wed, 28 Jun 2023 at 23:57, Zubin Mithra <zsm@chromium.org> wrote:
> >
> > On Wed, Jun 28, 2023 at 11:04:20PM +0200, Ricardo Ribalda wrote:
> > > On Wed, 28 Jun 2023 at 23:00, Ricardo Ribalda <ribalda@chromium.org> wrote:
> > > >
> > > > Allow devices to have dma operations beyond 64K, and avoid warnings such
> > > > as:
> > > >
> > > > DMA-API: xhci-mtk 11200000.usb: mapping sg segment longer than device claims to support [len=98304] [max=65536]
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > Reported-by: Zubin Mithra <zsm@chromium.org>
> >
> > Should this be cc'd to stable@ as well?
> 
> Not sure, in most of the cases this is "just" a warning fix. Let the
> maintainer decide:

Warnings can cause reboots as the majority of the linux systems in the
world run panic-on-warn, so yes, it should be backported.

thanks,

greg k-h
