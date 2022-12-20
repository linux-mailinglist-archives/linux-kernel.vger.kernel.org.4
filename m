Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B023651B02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiLTG6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiLTG6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:58:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057C6140AC;
        Mon, 19 Dec 2022 22:58:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD887B811A0;
        Tue, 20 Dec 2022 06:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7C6C433D2;
        Tue, 20 Dec 2022 06:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671519484;
        bh=hezfHxyVtEQckJyh4KpukNcGmjuAeZBzbORAHzBO+L0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+FbG7jq2WiorMSGVEt1LOS6JezSbl1gvPuIFj8mIJR08aCmSTXlqguUyyRDLCXjE
         bIfbr+49tX9D9RzoKKPHVXO/svnFqyR9WEApoYrXym1zTbFBtcc7HZh91b42oZieVs
         OFfXQyvHBuDbBEBI/hOIsWV8ygYT6wqc0I8Rlv9A=
Date:   Tue, 20 Dec 2022 07:58:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH] usb: misc: onboard_usb_hub: Don't defer probing for
 'incomplete' DT nodes
Message-ID: <Y6Fc+QU1kM7fTvH2@kroah.com>
References: <20221220004427.1.If5e7ec83b1782e4dffa6ea759416a27326c8231d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220004427.1.If5e7ec83b1782e4dffa6ea759416a27326c8231d@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 12:45:01AM +0000, Matthias Kaehlcke wrote:
> Some boards have device tree nodes for USB hubs supported by the
> onboard_usb_hub driver, but the nodes don't have all properties
> needed for the driver to work properly (which is not necessarily
> an error in the DT). Currently _find_onboard_hub() returns
> -EPROBE_DEFER in such cases, which results in an unusable USB hub,
> since successive probes fail in the same way. Use the absence of
> the "vdd" supply as an indicator of such 'incomplete' DT nodes
> and return -ENODEV.
> 
> Fixes: 8bc063641ceb ("usb: misc: Add onboard_usb_hub driver")
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

No cc: stable?
