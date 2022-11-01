Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCD961474F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiKAJ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiKAJ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:57:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816AC193C7;
        Tue,  1 Nov 2022 02:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BB716153B;
        Tue,  1 Nov 2022 09:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38897C433D6;
        Tue,  1 Nov 2022 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667296642;
        bh=WasZXVU7s1HS+z+NeBIed/22dFD0Q7UuAxT94f1Stwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYs5eN00k/EhhFOxGnarzvgNFkGAUXMao19T1Hc+uZI6AEq/xhkJxZsvsmlvLf0hD
         5bU4b4nVDVqw8oYRBXtpD2HGqUdr4RtsApkBv2UMJr0d4w8Dyc+MPkvo0LUzHALujW
         ofY6jU/jmb5WjMH21XiVJ+Tu7BOIdaV67m+21XWk=
Date:   Tue, 1 Nov 2022 10:43:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jing Leng <jleng@ambarella.com>
Cc:     pawell@cadence.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] usb: cdnsp: Fix wrong transmission direction of EP0
Message-ID: <Y2DqOefwSAjmExof@kroah.com>
References: <20221101044433.5627-1-3090101217@zju.edu.cn>
 <20221101061730.8991-1-jleng@ambarella.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101061730.8991-1-jleng@ambarella.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 02:17:30PM +0800, Jing Leng wrote:
> EP0 transfer is bi-directional, but in the cdnsp gadget, the
> transmission direction of EP0 is not changed after it is
> initialized to IN, so the OUT data from EP0 received by the host
> is invalid.
> 
> The value of ep0_expect_in will change according to the value of
> bRequestType in the SETUP transaction of control transfer, so we
> can use it as the transmission direction of EP0.
> 
> Signed-off-by: Jing Leng <jleng@ambarella.com>
> ---
> ChangeLog v2->v3:
> - Repair my email address.

Yes, it works, and it's validated!

Nice job, thanks.  I'll let the cdns3 maintainer review it first, but
just wanted to say thanks for fixing this up, it makes my life a lot
easier when accepting patches.

greg k-h
