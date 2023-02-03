Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B32E688FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjBCGcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjBCGcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:32:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5B16B373;
        Thu,  2 Feb 2023 22:32:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFD6D61D97;
        Fri,  3 Feb 2023 06:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81651C433D2;
        Fri,  3 Feb 2023 06:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675405934;
        bh=BRGs1JjoM7ZNTYAjJnD9aVL5SFuUUCncsvqLY/zvcRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pbCbXV7lELlYZAr+fBHwzXKnqrog2ElSW7yAE2qBA0ndTZIMwnWVOxRCqY5ehux14
         VYzgQaLUEkiQurwtOPNttXhRPge8gcIRedYIGH7teA16Xt3wj3RVaJ1L8z60HyB7hA
         VtJCggRQy1B8qcTnqnagTr97WRcCa00c83SqIrfE=
Date:   Fri, 3 Feb 2023 07:20:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, martin.petersen@oracle.com,
        beanhuo@micron.com, arnd@arndb.de, avri.altman@wdc.com,
        iwona.winiarska@intel.com, fmdefrancesco@gmail.com,
        dipenp@nvidia.com, ogabbay@kernel.org, bvanassche@acm.org,
        mathieu.poirier@linaro.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCHv2 4/4] wiegand: add Wiegand GPIO bit-banged controller
 driver
Message-ID: <Y9ynwHvkg/0PBiFb@kroah.com>
References: <20230202143305.21789-1-m.zatovic1@gmail.com>
 <20230202143305.21789-5-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230202143305.21789-5-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:33:05PM +0100, Martin Zaťovič wrote:
> +/*
> + * Attribute file for setting payload length of Wiegand messages.
> + */
> +ssize_t payload_len_show(struct device *dev, struct device_attribute *attr,
> +								 char *buf)
> +{
> +	struct wiegand_gpio *wiegand_gpio = (struct wiegand_gpio *)
> +							dev->driver_data;

No need to cast.


> +
> +	device_create_file(dev, &dev_attr_payload_len);

No, just add an attribute group pointer to your driver and the driver
core will add/remove the sysfs attributes automatically.  No need to do
it manually at all.

thanks,

greg k-h
