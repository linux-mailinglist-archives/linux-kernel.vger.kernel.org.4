Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DC268CF4B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBGGJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBGGJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:09:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BA52E0F9;
        Mon,  6 Feb 2023 22:08:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4339B611D2;
        Tue,  7 Feb 2023 06:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177D3C433EF;
        Tue,  7 Feb 2023 06:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675750137;
        bh=4QW7Z9hDWBfSp+o7tMeI+umOx2kSv/pt7HuJMchSsUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M5OyJ92Tm8fh6AFzLtGy1m4jzHyT8laR3FYpuIEF1SNedo1qYoU8TWwQFA/Vv7Np3
         q0kIuWSq8DbQ/6pSfhhIIBgUexFvWX1SLX4Ih9JEbtq4KbS0BvRV42pf8w2OB/y7EK
         KJG+lcMZyTKfACAWQ6GjUbPVROVmFEoypwIo4xj0=
Date:   Tue, 7 Feb 2023 07:08:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Furong <furong.zhou@linux.intel.com>
Cc:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, martin.petersen@oracle.com,
        beanhuo@micron.com, arnd@arndb.de, avri.altman@wdc.com,
        iwona.winiarska@intel.com, fmdefrancesco@gmail.com,
        dipenp@nvidia.com, ogabbay@kernel.org, bvanassche@acm.org,
        mathieu.poirier@linaro.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCHv2 2/4] wiegand: add Wiegand bus driver
Message-ID: <Y+Hq9gqq9tRhP+eD@kroah.com>
References: <20230202143305.21789-1-m.zatovic1@gmail.com>
 <20230202143305.21789-3-m.zatovic1@gmail.com>
 <Y9ynYmIhygqp3U5u@kroah.com>
 <cd6bd118-68ef-1742-fd9d-08a65872b02c@linux.intel.com>
 <Y+DVyPUXBliomobN@kroah.com>
 <581353bc-cc2c-295b-1f9a-04bcf705261b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <581353bc-cc2c-295b-1f9a-04bcf705261b@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 08:36:47AM +0800, Zhou Furong wrote:
> 
> 
> On 2023/2/6 18:26, Greg KH wrote:
> > On Mon, Feb 06, 2023 at 05:49:44PM +0800, Zhou Furong wrote:
> > > 
> > > > > +
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/of.h>
> > > > > +#include <linux/of_device.h>
> > > > > +#include <linux/slab.h>
> > > > > +#include <linux/wiegand.h>
> > > > > +#include <linux/dma-mapping.h>
> > > > > +#include <linux/dmaengine.h>
> > > > > +#include <linux/property.h>
> > > > > +
> > > 
> > > please order headers
> > 
> > Why?  What order?  For what gain >
> 
> If all header file ordered in alphabet, it will be easy to find if a header
> file has been included or not when header file list is long.

That's what search in your editor is for :)

This is not a real problem with this code, sorry.

thanks,

greg k-h
