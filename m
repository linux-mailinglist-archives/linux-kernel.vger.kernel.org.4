Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D794617877
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKCINU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKCINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:13:17 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27FBE60
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 01:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667463180; bh=O+mMeFtgdlxXHJDP6iXzPllPw2adCXFQra8DGX8IuI4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=OfXeZ79UI0yImxGq76C1OX6yu6aKHY0p32h0/ZNAVg1Asy2ulkJOKweB+PVpnRi4K
         rbzASdTHE18fnZTC8Rjp8wEKIE5xn+2p4EMeP57q7i4XEz1sm43Cts4fFbBmXAUHr4
         Zkriud/QkDSWldOsgLp4pis/gs+EkXbvuiP3guz0=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Thu,  3 Nov 2022 09:13:00 +0100 (CET)
X-EA-Auth: plpUEzRR4JMlyjZPE/X+H+BtojrboKHPOU9QZLL1HF9xTNqdkXpdJxtRb174iW7t5xjmdWu8l+BLEYYl7rS9TUNuNjis1Di3
Date:   Thu, 3 Nov 2022 13:42:56 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging: emxx_udc question on i_write_length datatype
Message-ID: <Y2N4CBhaAYBG2jGz@qemulion>
References: <Y2NtTXwMef0kp01s@qemulion>
 <Y2Nz7wB5ovzgrs6N@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Nz7wB5ovzgrs6N@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:55:27AM +0300, Dan Carpenter wrote:
> On Thu, Nov 03, 2022 at 12:57:09PM +0530, Deepak R Varma wrote:
> > Hello,
> > While reviewing this [1] coccicheck warning, I observed something that concerned
> > me. The variable i_write_length is declared to be of u32 type. Later it is
> > assigned a value DMA_MAX_COUNT * mpkt; which is 256 * u32;
> >
> > I am unable to estimate if mpkt (or max packet size) can attain value greater
> > than 16777215 in which case the result will overflow the 32 bits of
> > i_write_length. Is it safe to make i_write_length to be a u64?
> >
> > [1] drivers/staging/emxx_udc/emxx_udc.c:1007:28-29: WARNING opportunity for min()
> >
>
> drivers/staging/emxx_udc/emxx_udc.c
>    983  static int _nbu2ss_in_dma(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
>    984                            struct nbu2ss_req *req, u32 num, u32 length)
>    985  {
>    986          dma_addr_t      p_buffer;
>    987          u32             mpkt;           /* MaxPacketSize */
>    988          u32             lmpkt;          /* Last Packet Data Size */
>    989          u32             dmacnt;         /* IN Data Size */
>    990          u32             i_write_length;
>    991          u32             data;
>    992          int             result = -EINVAL;
>    993          struct fc_regs __iomem *preg = udc->p_regs;
>    994
>    995          if (req->dma_flag)
>    996                  return 1;               /* DMA is forwarded */
>    997
>    998  #ifdef USE_DMA
>    999          if (req->req.actual == 0)
>   1000                  _nbu2ss_dma_map_single(udc, ep, req, USB_DIR_IN);
>   1001  #endif
>   1002          req->dma_flag = true;
>   1003
>   1004          /* MAX Packet Size */
>   1005          mpkt = _nbu2ss_readl(&preg->EP_REGS[num].EP_PCKT_ADRS) & EPN_MPKT;
>                                                                          ^^^^^^^^
> mpkt is 0-0x7ff so 256 * 0x7ff will not be greater than UINT_MAX.

Thank you Dan. I understand now. "& EPN_MPKT" keeps the size under control.
Appreciate very much.

./drv

>
>   1006
>   1007          if ((DMA_MAX_COUNT * mpkt) < length)
>   1008                  i_write_length = DMA_MAX_COUNT * mpkt;
>   1009          else
>   1010                  i_write_length = length;
>   1011
>   1012          /*------------------------------------------------------------*/
>   1013          /* Number of transmission packets */
>   1014          if (mpkt < i_write_length) {
>
> regards,
> dan carpenter
>


