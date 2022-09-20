Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE41F5BE064
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiITIjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiITIiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:38:17 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B306B653;
        Tue, 20 Sep 2022 01:37:12 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkwl20tj04snw15cjtflt-3.rev.dnainternet.fi [IPv6:2001:14ba:4493:6f40:fec3:d72a:e447:8113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 2632420167;
        Tue, 20 Sep 2022 11:37:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1663663027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GlPLCGc/da4Da/fy1sO3woiVLHczv9MB6uMDmjv0bMA=;
        b=tuNsAKU6z4OTnrweOUm5IuaXE/+/Q192I6Exa1uBxNWWaI86SoZAs5FvUjw9NhYl8YitwE
        fI0o0PndPKGBFHUXnDKC5h59WWkw6Avq3fATwvjHBkephrb74vjNgnSpfzTT156XKteb9E
        CDqoVtqq1iWNnvkR8nxjUoEVTRkFRlg=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id BCB62634C91;
        Tue, 20 Sep 2022 11:37:06 +0300 (EEST)
Date:   Tue, 20 Sep 2022 11:37:06 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Hidenori Kobayashi <hidenorik@chromium.org>
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ov8856: Add runtime PM callbacks
Message-ID: <Yyl7spRDgJ+R39Pj@valkosipuli.retiisi.eu>
References: <20220920020002.710533-1-hidenorik@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920020002.710533-1-hidenorik@chromium.org>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1663663027; a=rsa-sha256; cv=none;
        b=T7mPl+Ppct5PQk5Tq1S+wOcV1ERVUWDRfy5MFa1HwMdkJpqDPjTYQdhc4zX9n5olFFlsvW
        Io1iv87K229sGwQVH6qNCp+tGvkW0Q26OK2c4trhTK57r/Fd3TcXMHGR2xPdm95YLW4V+G
        xuleL6TU93sBr6ASzADzXeQ847A5GWQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1663663027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GlPLCGc/da4Da/fy1sO3woiVLHczv9MB6uMDmjv0bMA=;
        b=uRG6DjTDYKe0FE1FoLSCIGWtrJ4PLFlboB6UkGx62jWqxzjmFoUXmIeexjrL7wFsHsG7Yx
        dliCMMXMGUdr8NAiHbFChTkdPUVGf/BcTwSne/DB/Dab5JMaiY1bJLfihHotDFE9PLpnIW
        3yPXxWoKtpjJ0wQ1OSHDD1ts3ZOllfc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hidenori,

On Tue, Sep 20, 2022 at 11:00:01AM +0900, Hidenori Kobayashi wrote:
> There were no runtime PM callbacks registered, leaving regulators being
> enabled while the device is suspended on DT systems. Calling existing
> power controlling functions from callbacks properly turn them off/on.
> 
> Signed-off-by: Hidenori Kobayashi <hidenorik@chromium.org>
> ---
>  drivers/media/i2c/ov8856.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> index a9728afc81d4..3f57bc30b78b 100644
> --- a/drivers/media/i2c/ov8856.c
> +++ b/drivers/media/i2c/ov8856.c
> @@ -2200,6 +2200,26 @@ static int __maybe_unused ov8856_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int __maybe_unused ov8856_runtime_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> +	struct ov8856 *ov8856 = to_ov8856(sd);
> +
> +	__ov8856_power_off(ov8856);

Could you refactor this a bit, changing the __ov8856_power_off() argument
to struct dev *?

> +
> +	return 0;
> +}
> +
> +static int __maybe_unused ov8856_runtime_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> +	struct ov8856 *ov8856 = to_ov8856(sd);
> +
> +	return __ov8856_power_on(ov8856);
> +}
> +
>  static int ov8856_set_format(struct v4l2_subdev *sd,
>  			     struct v4l2_subdev_state *sd_state,
>  			     struct v4l2_subdev_format *fmt)
> @@ -2540,6 +2560,7 @@ static int ov8856_probe(struct i2c_client *client)
>  
>  static const struct dev_pm_ops ov8856_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(ov8856_suspend, ov8856_resume)
> +	SET_RUNTIME_PM_OPS(ov8856_runtime_suspend, ov8856_runtime_resume, NULL)
>  };
>  
>  #ifdef CONFIG_ACPI

-- 
Kind regards,

Sakari Ailus
