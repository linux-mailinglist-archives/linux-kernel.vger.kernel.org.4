Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997D2716403
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjE3O0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjE3O0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:26:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C7210DE;
        Tue, 30 May 2023 07:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 352E862927;
        Tue, 30 May 2023 14:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA3EC433EF;
        Tue, 30 May 2023 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685456707;
        bh=+SYa9bhZBDTkyURy2GHBB/vLDr+xUSjpSqvR1WZibas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/juyAhcdNjjQ8aklB2nIws+qDmE0bsjg9H0H0+PjK5dDKw5piNsQu0LQFnle03Yl
         pcEdusnAxxj9dHlTeNkV+iC98Vu5M74hvEWApcEMA+QTNmPyUZIbyQNfrc7e+xci+E
         jWaEaqX0Nlrj7xc4/zFfss978JpHu7PUqK/OtbzKKIDg63TFtKyAGkSDzBY2haeDQP
         jSf8irbEX8RfwIQAKd+HVI01bv762Tm27eBTHgv3KZIdZI+xepKeblQg24dCrvM9ar
         s5SSwE/2T9R0JdfV+kzwUBrZ5UMu7+F3t/CWanLmj/4trn6WjhaqR6/OR7FFPM5Wwy
         ITn/31eU7zXRQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q40Hd-0007sX-3Z; Tue, 30 May 2023 16:25:09 +0200
Date:   Tue, 30 May 2023 16:25:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 0/2] Bluetooth: fix bdaddr quirks
Message-ID: <ZHYHRW-9BN4n4pPs@hovoldconsulting.com>
References: <20230424133542.14383-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424133542.14383-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 03:35:40PM +0200, Johan Hovold wrote:
> These patches fixes a couple of issues with the two bdaddr quirks:
> 
> The first one allows HCI_QUIRK_INVALID_BDADDR to be used with
> HCI_QUIRK_NON_PERSISTENT_SETUP.
> 
> The second patch restores the original semantics of the
> HCI_QUIRK_USE_BDADDR_PROPERTY so that the controller is marked as
> unconfigured when no device address is specified in the devicetree (as
> the quirk is documented to work).
> 
> This specifically makes sure that Qualcomm HCI controllers such as
> wcn6855 found on the Lenovo X13s are marked as unconfigured until user
> space has provided a valid address.
> 
> Long term, the HCI_QUIRK_USE_BDADDR_PROPERTY should probably be dropped
> in favour of HCI_QUIRK_INVALID_BDADDR and always checking the devicetree
> property.

> Johan Hovold (2):
>   Bluetooth: fix invalid-bdaddr quirk for non-persistent setup
>   Bluetooth: fix use-bdaddr-property quirk
> 
>  net/bluetooth/hci_sync.c | 30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)

Any further comments to this series, or can this one be merged for 6.5
now?

Johan
