Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41C85B7D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIMWft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiIMWfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:35:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098E72E9E1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84EA7B80FF4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 22:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2D8C433D6;
        Tue, 13 Sep 2022 22:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663108541;
        bh=/a+0hAg8mYXC9XGXNJ/uAASVNMvl9QrQiTnTEHk3aCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjO7EV1VAyigoz6PI7uLgWY6S6i5Qy78wXYKR4PhtOotnsP2tmyYMHDb+x4r7rAPf
         Nqsoogm8zTHL1T/EKHBHgBqDyt//QIshj/+ScRGFGM6RIO7Wh8EiJkMIcBoABZkA1f
         0XV9aeJm0x9Ne5o/6i5ND5BMzxMWVdCSYe6+ijFfwaL0x7KxrYk3KTrILf3d8gFNrd
         LHEI424z46rRg52JgWZghncGx2GpvzcNUupk+6bWS0DMKyG/2Qlfl+LiBO1J1sdiT0
         PfRdMtj0wOogmRrH2u8G9yY6A/RQseEPPvG1IV5sJpKp75NXiCcEQnQC6b31wJ2IqY
         lwiGh7rUABDxA==
Date:   Tue, 13 Sep 2022 15:35:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: Fix return type of cvm_oct_xmit and
 cvm_oct_xmit_pow
Message-ID: <YyEFu8uzoxK64p0Y@dev-arch.thelio-3990X>
References: <20220912214523.929094-1-nhuck@google.com>
 <YyEFNA3nVShxwkJT@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyEFNA3nVShxwkJT@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 03:33:24PM -0700, Nathan Chancellor wrote:
> On Mon, Sep 12, 2022 at 02:45:20PM -0700, Nathan Huckleberry wrote:
> > The ndo_start_xmit field in net_device_ops is expected to be of type
> > netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb, struct net_device *dev).
> > 
> > The mismatched return type breaks forward edge kCFI since the underlying
> > function definition does not match the function hook definition.
> > 
> > The return type of cvm_oct_xmit and cvm_oct_xmit_pow should be changed
> > from int to netdev_tx_t.
> > 
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Sorry, forgot to point out that the prototypes in
drivers/staging/octeon/ethernet-tx.h should be updated as well.

> > ---
> >  drivers/staging/octeon/ethernet-tx.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
> > index 1ad94c5060b5..a36e36701c74 100644
> > --- a/drivers/staging/octeon/ethernet-tx.c
> > +++ b/drivers/staging/octeon/ethernet-tx.c
> > @@ -125,7 +125,7 @@ static void cvm_oct_free_tx_skbs(struct net_device *dev)
> >   *
> >   * Returns Always returns NETDEV_TX_OK
> >   */
> > -int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
> > +netdev_tx_t cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
> >  {
> >  	union cvmx_pko_command_word0 pko_command;
> >  	union cvmx_buf_ptr hw_buffer;
> > @@ -506,7 +506,7 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
> >   * @dev:    Device info structure
> >   * Returns Always returns zero
> >   */
> > -int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
> > +netdev_tx_t cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
> >  {
> >  	struct octeon_ethernet *priv = netdev_priv(dev);
> >  	void *packet_buffer;
> > -- 
> > 2.37.2.789.g6183377224-goog
> > 
> 
