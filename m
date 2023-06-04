Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4746972172E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 15:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjFDNH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 09:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFDNH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 09:07:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1EDB1;
        Sun,  4 Jun 2023 06:07:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1B7560ECC;
        Sun,  4 Jun 2023 13:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861F3C433D2;
        Sun,  4 Jun 2023 13:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685884046;
        bh=0P33fMw15N/rBZGu2NM+90HF89luwm9sJg51r4dQ4ks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L36Et4KUtUDohC5eMsKNMO0QBkJcZHH0MQsrrvnO7I1K3AQQf5UtDKB/WL1F6VteV
         tFJ0ygW7y+odH+jYP24sWUh4nOvf1W1AUOZ25zA6sSUM6bnjQxFnGjNYhFM1/Qz7he
         Ke6417XTlv9ZyPZbsdVcgXklbfJPEiQcCoH6ov/L/NxYQwDAJeVmyp61/kbwAUjyEC
         Xfe9XQK5R5NV7vcQQ7F12ZQKSdCDxgzzqvOmDpPOJc11e1Rd2aupwg9XfPeBC12Ir7
         Z5o58q6jTu9UIzqfABSefzfeB9VEJiuKeUG/kOvFebn5H7Xh7ceFV05Fc/pU2B5AV9
         1z41ziHNzdzog==
Date:   Sun, 4 Jun 2023 14:07:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     andy.shevchenko@gmail.com
Cc:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: pressure: Honeywell mprls0025pa pressure
 sensor
Message-ID: <20230604140722.5eef740b@jic23-huawei>
In-Reply-To: <ZHPVn4xzErSZfqVy@surfacebook>
References: <ZGNpZM137jF5yzie@arbad>
        <ZGNp3SqyOJeEcLsj@arbad>
        <ZHPVn4xzErSZfqVy@surfacebook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> > +	if (dev_fwnode(dev)) {  
> 
> Why not simply use defaults?

Potential for inconsistent set if a firmware provides some but not others?
(at least that was my assumption that could well be wrong)

> 
> > +		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
> > +								&data->pmin);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +				"honeywell,pmin-pascal could not be read\n");
> > +		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
> > +								&data->pmax);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +				"honeywell,pmax-pascal could not be read\n");
> > +		ret = device_property_read_u32(dev,
> > +				"honeywell,transfer-function", &data->function);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +				"honeywell,transfer-function could not be read\n");
> > +		if (data->function > MPR_FUNCTION_C)
> > +			return dev_err_probe(dev, -EINVAL,  
