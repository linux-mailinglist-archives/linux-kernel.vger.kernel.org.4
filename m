Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E966F323F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjEAOs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjEAOs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7EC10F5;
        Mon,  1 May 2023 07:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26B8561138;
        Mon,  1 May 2023 14:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AEFC433EF;
        Mon,  1 May 2023 14:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682952526;
        bh=6PwE3zJHPaioyiDWSqmFaqUW7EgsDCdN5KmKdLh3alU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QNECjiZzrcpwOdwAYM5SHEKSwEN3esJiPB8y7pVMD6K00FUsajuBvlJ3oGYh+K4DA
         M3lSPlWLRc8sEIkPsZMX5a+oTSDx8rNk7Rw/rxZAO0uOiS86dbSz8Ucw1EO7DLDZrd
         +dPT2DWLw+a5zCXlHbx9m38Fv0NWfAQlpjW5QgBzOlmRr3B6ltMNukNkAaBLT6+mCZ
         EniVzZr7mguwSNlEEGbYaPQ8zZ+qSgv6z4NAYddlX08vzZxGnbhnSNo9zY7+KSIQO1
         EglTcAP19dqJXbomvglgup5eHqynH/LFo5BfFpBBdE+Z5Lsp4bh621wYG4SjmtPREw
         FaTRYIFJYtWBg==
Date:   Mon, 1 May 2023 16:04:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <20230501160431.602e3086@jic23-huawei>
In-Reply-To: <00905352-f9a4-a8bf-63b7-92e3b1d2a4f4@gmail.com>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
        <593798a44c8ba45f969b86aa29e172d59065958c.1682373451.git.mehdi.djait.k@gmail.com>
        <00905352-f9a4-a8bf-63b7-92e3b1d2a4f4@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > +static int kx132_get_fifo_bytes(struct kx022a_data *data)
> > +{
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +	__le16 buf_status;
> > +	int ret, fifo_bytes;
> > +
> > +	ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
> > +			       &buf_status, sizeof(buf_status));
> > +	if (ret) {
> > +		dev_err(dev, "Error reading buffer status\n");
> > +		return ret;
> > +	}
> > +
> > +	fifo_bytes = le16_to_cpu(buf_status);
> > +	fifo_bytes &= data->chip_info->buf_smp_lvl_mask;  
> 
> This is probably just my limitation but I've hard time thinking how this 
> works out on BE machines. It'd be much easier for me to understand this 
> if the data was handled as two u8 values and mask was applied before 
> endianes conversion. (Eg - untested pseudo code follows;
> 
> __le16 buf_status;
> u8 *reg_data;
> 
> ...
> 
> ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
> 			&buf_status, sizeof(buf_status));
> ...
> 
> reg_data = (u8 *)&buf_status;
> 
> /* Clear the unused bits form 2.nd reg */
> reg_data[1] = reg_data[i] & MASK_SMP_LVL_REG_HIGH_BITS;
> 
> /* Convert to CPU endianess */
> fifo_bytes = le16_to_cpu(buf_status);
> 
> Well, others may have different view on this :)

:) 

I go the other way. It's less obvious to me that it is appropriate
to apply le16_to_cpu(buf_status) after applying a mask to some
bits. The moment that is appropriate, then we certainly hope a single
mask application is as well.

I think treating it as a 16 bit register is appropriate, in particular
as the field is described as SMP_LEV[9:0] on the datasheet
(of course there are datasheets that do that for unconnected sets of
bits so this doesn't always work ;)

Jonathan

