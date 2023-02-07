Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C3968DD94
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjBGQFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjBGQEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:04:51 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71B18A6F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:04:49 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d14so14032721wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkf6lOjY+w6DriQTsiaHaBfCPRbIUyjacQUodaIbLxU=;
        b=IUBq3RMtPA3k2MKRTgAfydlMP2qwP0EC81gv4qLy8dAyOBq6pIXbsZ67OTGzT90+qw
         ZAMttaxC9lrUZIQzT9IRp01AeJktYdQLMVNZuH9U4iNDZ2qRLSUJtcHr/MYgQ3Yrquq9
         XYwK7y6inyycbsI07PRq87GMq0tGE062k1JN9+4vhrekZ+j3PDg6T/kjF23V31T+Wa/N
         btSMmWetssqTLRpbKS+q8CNKaHnioeI7FBfNsoF+vOP1PcbvNWNn2aWA1sn0nDuTbVXv
         PeheqzRFdrkj9Hvit6RfZ93rT+bzJNdiBc0Y2uibhh3sLv01uUdfz3mSPBXye/LL9cKC
         kV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkf6lOjY+w6DriQTsiaHaBfCPRbIUyjacQUodaIbLxU=;
        b=AyNiHhZ442GiY9R/WYKvrovtJ8wL7eq6Da+EMTcpfln2otQ0bp5cJowoEqZZSNCptW
         eyGFE/l3ZDRZfE73SA9XaO3uX7K/+dLYbGhzOxtA6O1hUhhe1c2NZh07n4mD211TskOc
         wuNri4ao2pprl+4uhciPFeKf4QhJxS/cd7tIipiXqn9OdJ8RClk8HJOguB7ykXeFuqsW
         gDebz/RjzvS/vv8u/iK4Gwcn70s+IfOhJYgKxcgdIEkmZpZepRGdPi+9/V7bEQWqyVAr
         Td1OQnhJSGTWF50nEJ2DrHhiMlsnrNJJgtlLriH2WrDC8jfBU2cLBlzChOS0cVLpzZNM
         LVqQ==
X-Gm-Message-State: AO0yUKVTqQcs1jOuqqrbrBW+NIxyQtQ1lyjbAn3ktEkC+gC1F/Zv5fit
        6ZU5I03dY1/clbKIhnJbP9Jfcg==
X-Google-Smtp-Source: AK7set9LgoQq1EFwiHlPQBez/yjb5wqI/qwX7KEaVYJBXi2mBz0UnHVgxLE673PKnV0Mh116yXa5lA==
X-Received: by 2002:adf:e0c1:0:b0:2bf:960b:7282 with SMTP id m1-20020adfe0c1000000b002bf960b7282mr3532660wri.44.1675785888336;
        Tue, 07 Feb 2023 08:04:48 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id bj24-20020a0560001e1800b002bded7da2b8sm11685999wrb.102.2023.02.07.08.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:04:47 -0800 (PST)
Date:   Tue, 7 Feb 2023 16:04:45 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] backlight: hx8357: switch to using gpiod API
Message-ID: <Y+J2nRyDpOE0ihfj@aspen.lan>
References: <20230131225707.3599889-1-dmitry.torokhov@gmail.com>
 <Y+DmBGiq9kvRBHLY@aspen.lan>
 <Y+HQfDtiqUso7e9k@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+HQfDtiqUso7e9k@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 08:15:56PM -0800, Dmitry Torokhov wrote:
> On Mon, Feb 06, 2023 at 11:35:32AM +0000, Daniel Thompson wrote:
> > On Tue, Jan 31, 2023 at 02:57:06PM -0800, Dmitry Torokhov wrote:
> > > +				dev_info(&spi->dev, "im gpio[%d] is not here yet, deferring the probe\n",
> > > +					 i);
> > > +			} else {
> > > +				dev_err(&spi->dev, "failed to request im gpio[%d]: %d\n",
> > > +					i, ret);
> > >  			}
> >
> > These last two clauses should be updated to return dev_err_probe(...)
> > instead.
> >
> > With that change:
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>
> So you want to actually suppress the deferral message unless debug
> printks are enabled? So you want this to read:
>
>
> 		if (ret) {
> 			if (ret == -ENOENT) {
> 				if (i == 0)
> 					break;
>
> 				dev_err(&spi->dev, "Missing im gpios[%d]\n", i);
> 				return -EINVAL;
> 			}
>
> 			return dev_err_probe(&spi->dev, ret,
> 					     "failed to request im gpio[%d]\n", i);
> 		}
>
> Did I get it right?

LGTM.


Daniel.
