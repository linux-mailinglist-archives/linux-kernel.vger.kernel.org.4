Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9217270CF9A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjEWAlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjEWAMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:12:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B2C2105;
        Mon, 22 May 2023 17:00:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae3ed1b0d6so46850925ad.3;
        Mon, 22 May 2023 17:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684800047; x=1687392047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RfShBrimcvfQvoSW9H7VPg8y8VhC7yAuAl2Q2us2MOE=;
        b=Gn7T5NOLRH94HNqln1r1fynHLmaqyP3yvCtlj45POcIfD4MhgTa0WxwhIRmsftXEMk
         Z7S8y5+Uqz9WUp7ztJWYEemAg0kwXHi21LruY3EPB04Gp40Wt9vSMseMkcNgOVI5w2zY
         r1ZoLfNCge13xiYGhlg4RPCSWkKv7+KobtGOZaPkihe8V7PYaXIycKH3rqsPg/nEbqeY
         Ek9aZdI99CXlRxegKY5K8BpHJEDs4NKJRO5z5mDs0tsi7heczzjrwz7vAmAEEqjVT6DQ
         /vfdTSj098EnGa2feb+Rg2Gz13YaGL3QItCrHvp2MMZhBP2bJ9SGW+F79VsndBN2uhI5
         JRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684800048; x=1687392048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfShBrimcvfQvoSW9H7VPg8y8VhC7yAuAl2Q2us2MOE=;
        b=ET2tg4Dl0V8u1u45eYFJKtqVUQC06myifn6TgNl/FWXNyTu0aWuEmCSvYXEIyfpkGe
         vLBuvt6mpFTJ5i8Y0/QTRqnt2hxxLVRX+rEuljzqpuCcATpk+oIutNWq0e9jlHgV2xEF
         FYa+2jk4OD4Yo0GZlIkDRS+Z8q2t3KmYlshGlZhbxtTwW9DbfEPTCzH8xDx92x89y9c4
         8sZpEZqpv+nDefO7WXd70MRUZr+8EqW86CkDDsMRs4eVZQPsMlF1cRxEJyHdOdt1L7XK
         PCaY3pBZSgKT2m9C9NSZOru1h079p0xZdnS+Ehc41EqHzbUPvQ4oXwKWY9DkD5Z/qd4Z
         QaPA==
X-Gm-Message-State: AC+VfDxsKr6rNX+2fZ/LmiP0P0w3/N9KTmeaR3OYhRBsJQBMv/dmn5DI
        g7l+FGQul4f2qmf5y7BxjT+iev+92YQ=
X-Google-Smtp-Source: ACHHUZ76t7JP0WL3FW9gcb6W5j0OuuhYuEntEmFDq/p38FuWTG7i3mSCL6Ax6ojcZaIUHNGGkbXWrw==
X-Received: by 2002:a17:902:c20c:b0:1ab:d2c:a1a6 with SMTP id 12-20020a170902c20c00b001ab0d2ca1a6mr11179857pll.69.1684800047465;
        Mon, 22 May 2023 17:00:47 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:54fa:e8a7:76de:888d])
        by smtp.gmail.com with ESMTPSA id p13-20020a1709028a8d00b001a674fb0dd8sm5356394plo.247.2023.05.22.17.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 17:00:46 -0700 (PDT)
Date:   Mon, 22 May 2023 17:00:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Dana Elfassy <delfassy@redhat.com>
Cc:     eballetb@redhat.com, javierm@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dana Elfassy <dangel101@gmail.com>
Subject: Re: [PATCH v3] Input: tests: add test to cover all
 input_grab_device() function
Message-ID: <ZGwCK3A+pFldJ23r@google.com>
References: <20230522215514.722564-1-dangel101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522215514.722564-1-dangel101@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 12:55:14AM +0300, Dana Elfassy wrote:
> Currently input_grab_device() isn't covered by any tests
> Thus, adding a test to cover the cases:
> 1. The device is grabbed successfully
> 2. Trying to grab a device that is already grabbed by another input
>    handle
> 
> Signed-off-by: Dana Elfassy <dangel101@gmail.com>
> Tested-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> Changes in v3:
> 1. Retrieve test_handle variable to try and grab the device that's
> currently grabbed by another handle
> 2. Add verification that test_handle can indeed grab the device after
> it's released by the handle that grabbed it
> 3. Remove duplicated call for input_grab_device() in KUNIT_ASSERT_TRUE()
> functions
> Changes in v2:
> - Use input_put_device() to decrement the refcount increased by get().
> - Remove unnecessary struct input_handle test_handle variable.
> 
>  drivers/input/tests/input_test.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
> index 25bbf51b5c87..1939cc12bae0 100644
> --- a/drivers/input/tests/input_test.c
> +++ b/drivers/input/tests/input_test.c
> @@ -124,10 +124,42 @@ static void input_test_match_device_id(struct kunit *test)
>  	KUNIT_ASSERT_FALSE(test, input_match_device_id(input_dev, &id));
>  }
>  
> +static void input_test_grab(struct kunit *test)
> +{
> +	struct input_dev *input_dev = test->priv;
> +	struct input_handle test_handle;
> +	struct input_handler handler;
> +	struct input_handle handle;
> +	struct input_device_id id;
> +	int res;
> +
> +	handler.name = "handler";
> +	handler.id_table = &id;
> +
> +	handle.dev = input_get_device(input_dev);
> +	handle.name = dev_name(&input_dev->dev);
> +	handle.handler = &handler;
> +	res = input_grab_device(&handle);
> +	KUNIT_ASSERT_TRUE(test, res == 0);

Could you please tell me why you are using KUNIT_ASSERT_TRUE() here but
KUNIT_ASSERT_EQ() below?

> +
> +	test_handle.dev = input_get_device(input_dev);
> +	test_handle.name = dev_name(&input_dev->dev);
> +	test_handle.handler = &handler;
> +	res = input_grab_device(&test_handle);
> +	KUNIT_ASSERT_EQ(test, res, -EBUSY);
> +
> +	input_release_device(&handle);
> +	input_put_device(input_dev);
> +	res = input_grab_device(&test_handle);
> +	KUNIT_ASSERT_TRUE(test, res == 0);
> +	input_put_device(input_dev);
> +}
> +
>  static struct kunit_case input_tests[] = {
>  	KUNIT_CASE(input_test_polling),
>  	KUNIT_CASE(input_test_timestamp),
>  	KUNIT_CASE(input_test_match_device_id),
> +	KUNIT_CASE(input_test_grab),
>  	{ /* sentinel */ }
>  };
>  
> -- 
> 2.40.1
> 

Thanks.

-- 
Dmitry
