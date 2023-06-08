Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582AF728262
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbjFHOLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbjFHOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:11:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329212726;
        Thu,  8 Jun 2023 07:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD9ED64AAE;
        Thu,  8 Jun 2023 14:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A54C433D2;
        Thu,  8 Jun 2023 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686233462;
        bh=0fbVVZxbX+7uBgaaZMvGPxIbYG32eywvC3Mz0AqXISM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=TigkBz+YRO/u3oLmHQKwkHwj4QrP4ft+JZV3ZXtwhNeFhRm1GaZNDa0B9/f2X0A1/
         Tw+IlYUnslamhSw5nPXeMWNAeKSQ33lefHzmbLvvJhnGXqydAkf0tZCLMg7COvk/1G
         pnKJ1JYKToBNfjjZFbewCIVljf9lNDaBt5sWvRrk6YKQ6O720wW48C3JWdMKKk59R5
         BLd+NiBkVuhOVcm4eJvb5KFgjvK3tL6xixKxzLoUH5f3z6Ujf/7cZC1Jp/wuF8aMl/
         FkGU4TPM5NWJsds/qAW3bMrlMA5OOeAJDyzFNeY8JKTuatD6Rti8851XZa3mAHOnlk
         fx9da291xNTpQ==
Date:   Thu, 8 Jun 2023 16:10:58 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Siarhei Vishniakou <svv@google.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v4] Add rumble support to latest xbox controllers
In-Reply-To: <20230425163844.3711710-1-svv@google.com>
Message-ID: <nycvar.YFH.7.76.2306081610380.29760@cbobk.fhfr.pm>
References: <20230425163844.3711710-1-svv@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023, Siarhei Vishniakou wrote:

> Currently, rumble is only supported via bluetooth on a single xbox
> controller, called 'model 1708'. On the back of the device, it's named
> 'wireless controller for xbox one'. However, in 2021, Microsoft released
> a firmware update for this controller. As part of this update, the HID
> descriptor of the device changed. The product ID was also changed from
> 0x02fd to 0x0b20. On this controller, rumble was supported via
> hid-microsoft, which matched against the old product id (0x02fd). As a
> result, the firmware update broke rumble support on this controller.
> 
> See:
> https://news.xbox.com/en-us/2021/09/08/xbox-controller-firmware-update-rolling-out-to-insiders-starting-today/
> 
> The hid-microsoft driver actually supports rumble on the new firmware,
> as well. So simply adding new product id is sufficient to bring back
> this support.
> 
> After discussing further with the xbox team, it was pointed out that
> another xbox controller, xbox elite series 2, can be supported in a
> similar way.
> 
> Add rumble support for all of these devices in this patch. Two of the
> devices have received firmware updates that caused their product id's to
> change. Both old and new firmware versions of these devices were tested.
> 
> The tested controllers are:
> 
> 1. 'wireless controller for xbox one', model 1708
> 2. 'xbox wireless controller', model 1914. This is also sometimes
>    referred to as 'xbox series S|X'.
> 3. 'elite series 2', model 1797.
> 
> The tested configurations are:
> 1. model 1708, pid 0x02fd (old firmware)
> 2. model 1708, pid 0x0b20 (new firmware)
> 3. model 1914, pid 0x0b13
> 4. model 1797, pid 0x0b05 (old firmware)
> 5. model 1797, pid 0x0b22 (new firmware)
> 
> I verified rumble support on both bluetooth and usb.
> 
> Reviewed-by: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Siarhei Vishniakou <svv@google.com>

Applied, sorry for the delay.

-- 
Jiri Kosina
SUSE Labs

