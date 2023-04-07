Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39C66DB1A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDGRbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDGRbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:31:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A71AD0A;
        Fri,  7 Apr 2023 10:31:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91AA26125C;
        Fri,  7 Apr 2023 17:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05371C433D2;
        Fri,  7 Apr 2023 17:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680888660;
        bh=ApDacg564yr5uR1+DT8HL2ziSN/TMUAvPNtZ6acpD3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VHUNZdR24huVQ3g2RLjQ1xdAaKubYbmcrRB2kQPYzhpspIc4v06WFLP+PS8ylUO51
         08qSoDjKIUCw2cA1FlPWJjVYGomByikHqHy0WmwyT8QOGlMojM3dsL2qT4sTzh7ecM
         aAUZqV9KkGmw2wglP+snCPhkOOhMtFt+7CflxUjJS85QtRoiQztPO2UxC0xJH/Xqg7
         /zT8VlGzCCspVKWpOXgtvJ0vn/2oE4joc83/d7Cw0OIwg+cmei7eW/JGTqmnTPsEGk
         qMr9aFovFQQsSGHNY2JKntiBj81kWzFvGRFHC96f+HEKEkfMUlhQMZhDjczaU8aV15
         bCBPnA9xIGDXw==
Date:   Fri, 7 Apr 2023 18:46:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: dac: mcp4922: get and enable vdd regulator
Message-ID: <20230407184616.2fd2d52a@jic23-huawei>
In-Reply-To: <ee6a428b-905c-82ac-48fd-0b440d90e014@metafoo.de>
References: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
        <20230405140114.99011-3-frattaroli.nicolas@gmail.com>
        <ee6a428b-905c-82ac-48fd-0b440d90e014@metafoo.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 07:21:00 -0700
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 4/5/23 07:01, Nicolas Frattaroli wrote:
> > [...]
> > +	state->vdd_reg = devm_regulator_get(&spi->dev, "vdd");
> > +	if (IS_ERR(state->vdd_reg)) {
> > +		ret = dev_err_probe(&spi->dev, PTR_ERR(state->vdd_reg),
> > +				    "vdd regulator not specified\n");
> > +		goto error_disable_vref_reg;
> > +	}
> > +	ret = regulator_enable(state->vdd_reg);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "Failed to enable vdd regulator: %d\n",
> > +			ret);
> > +		goto error_disable_vref_reg;
> > +	}  
> The two above can be combined into `devm_regulator_get_enable()`. This 
> will also take care of automatically disabling the regulator on the 
> error path and on remove.

I'm not keen on the ordering of probe wrt to remove that results from mixing
devm and not.   Note that already happens because of the gets vs enables
so another reason to take this driver fully devm_ based.

Jonathan


> > +
> >   	spi_set_drvdata(spi, indio_dev);
> >   	id = spi_get_device_id(spi);
> >   	indio_dev->info = &mcp4922_info;
> > [...]  
> 
> 

