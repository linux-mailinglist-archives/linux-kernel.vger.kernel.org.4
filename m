Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DBB6DB10A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDGQ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjDGQ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:57:51 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4AE61A5;
        Fri,  7 Apr 2023 09:57:50 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id ld14so1520218qvb.13;
        Fri, 07 Apr 2023 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680886669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+EC9oSqo+HSTysdaLl9MdTGNN+XyvYFDHraMGNwzHo=;
        b=KAFsJ88KqYSuxae/wmpNfoMXlas7mSPVg8du6CvORQjqNZSSfmg/gJmR0aSHYNqOej
         xUCyV7ghNU/pu5rKHl5CK7JAzupwOhro1oHui6dXT8nv5iBvJNuPiX2XCe/u0C1Sfwt+
         Dmtz1MrBIFdBpodPvmmapP1SAwb5Xlb2XJzmr0aLMfqq3z4z9DvfVNRtpfrN0trsOavb
         nmBeKzzO9MEr1boanB4ojnuNJDi9E+NgAqIlWXnm5YxmuUeUxOurftf8+aLXzwk4tuNZ
         JgtT/B1BxH0uKKmC/mYjb/wY4PhBDw+silSWAAdiNn4Q+XKpGOZjUbWWZzge1nhvS2EE
         6S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680886669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+EC9oSqo+HSTysdaLl9MdTGNN+XyvYFDHraMGNwzHo=;
        b=XcwKqtQ+WFEH6BbqIlj07dZoAhY86y4dxI3LjJv/gKIGCOvAI5dukIZ0mJ5nrKfffn
         LJ4xrcYxTFK6f5GQ2LGJbVpQ5kBUD9nni7QFIeLlCvlkglklxw1HyDT/tnKI+6x5SvQe
         EganWA4/NMA0MJpOLcSvO177pve8PzV+hN492g4qd9NEynmuslI2eip19y7A1aXzBH/q
         9fRWQMqZUA2GGKRFpNq2oLhRe5DOY+m5bmlQ52s24rlHLp8j/jABCU6YRr5EWtb9lN+/
         29mqSo2LLN81v7l5pHh+E2pJkgYAIkBqfH90pegbhRIVkv0UTI3T5eRdulyBdf2KbuIP
         kN3g==
X-Gm-Message-State: AAQBX9cYhtrm/riMDj+Utt7leOhZa7cNX2ipakUIxCPp8iMNq2udf1wL
        LaUMLxJTtj2CX24wWu2j713JhWSFpmk=
X-Google-Smtp-Source: AKy350YHDMgNvgTK9CT41wGDurKn6+YzqMaaNnr4pZILaC4amGknZRiPUSNd+P7UXpyjnCZiToUQqQ==
X-Received: by 2002:a05:6214:2a49:b0:5bf:370e:f446 with SMTP id jf9-20020a0562142a4900b005bf370ef446mr6635631qvb.17.1680886669126;
        Fri, 07 Apr 2023 09:57:49 -0700 (PDT)
Received: from penguin ([205.220.129.30])
        by smtp.gmail.com with ESMTPSA id kl14-20020a056214518e00b005dd8b9345absm1454622qvb.67.2023.04.07.09.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:57:48 -0700 (PDT)
Date:   Fri, 7 Apr 2023 09:57:12 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "jingle.wu" <jingle.wu@emc.com.tw>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        phoenix@emc.com.tw, josh.chen@emc.com.tw, dave.wang@emc.com.tw
Subject: Re: [PATCH] Input: elan_i2c - Implement inhibit/uninhibit functions.
Message-ID: <ZDBKwo4UMUm+TSnj@penguin>
References: <20230320011456.986321-1-jingle.wu@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320011456.986321-1-jingle.wu@emc.com.tw>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingle,

On Mon, Mar 20, 2023 at 09:14:56AM +0800, jingle.wu wrote:
> Add inhibit/uninhibit functions.
> 
> Signed-off-by: Jingle.wu <jingle.wu@emc.com.tw>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 86 +++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 5f0d75a45c80..b7100945c9cc 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -329,6 +329,89 @@ static int elan_initialize(struct elan_tp_data *data, bool skip_reset)
>  	return error;
>  }
>  
> +static int elan_reactivate(struct elan_tp_data *data)
> +{
> +	struct device *dev = &data->client->dev;
> +	int ret;

Please call this variable and other similar ones "error".

> +
> +	ret = elan_set_power(data, true);
> +	if (ret)
> +		dev_err(dev, "failed to restore power: %d\n", ret);
> +
> +	ret = data->ops->sleep_control(data->client, false);
> +	if (ret) {
> +		dev_err(dev,
> +			"failed to wake device up: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;

return 0;

> +}
> +
> +static void elan_inhibit(struct input_dev *input_dev)
> +{
> +	struct elan_tp_data *data = input_get_drvdata(input_dev);
> +	struct i2c_client *client = data->client;
> +	int ret;
> +
> +	if (data->in_fw_update)
> +		return;

Simply and silently ignoring inhibit request is not great. Can we wait
for firmware update to complete?

> +
> +	dev_dbg(&client->dev, "inhibiting\n");
> +	/*
> +	 * We are taking the mutex to make sure sysfs operations are
> +	 * complete before we attempt to bring the device into low[er]
> +	 * power mode.
> +	 */
> +	ret = mutex_lock_interruptible(&data->sysfs_mutex);
> +	if (ret)
> +		return;
> +
> +	disable_irq(client->irq);
> +
> +	ret = elan_set_power(data, false);
> +	if (ret)
> +		enable_irq(client->irq);
> +
> +	mutex_unlock(&data->sysfs_mutex);
> +
> +}
> +
> +static void elan_close(struct input_dev *input_dev)
> +{
> +	if ((input_dev->users) && (!input_dev->inhibited))
> +		elan_inhibit(input_dev);

I am not sure why you need these checks. Input core will only call
input_dev->close() when device is powered up st (i.e. it is not inhibited
and there are users of it) and when either:

- there is inhibit request or
- the last user is letting go of the device

Similarly elan_open() will be called when first user opens device if
device is not inhibited, or when request to uninhibit comes for
inhibited device that has users.

But you need to make sure you start in a low power state.

Thanks.

-- 
Dmitry
