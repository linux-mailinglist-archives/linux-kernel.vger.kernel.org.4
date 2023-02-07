Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374EB68D36F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjBGKBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjBGKAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:00:33 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094C8A4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:59:57 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id m1so13818453vst.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=imMOAypeeJYion5hiSp9RS8CiVWyB5tI9arDNTtrtKE=;
        b=bxlHnoNqIlciOE1JCTm3MVDeUCQ+odxGZ9WUWJmVI02GC/nrDypx5EbtOjqqTjFeP+
         OaYYotHLLLcEUUU0zn4eJQlcTTxj+3GeMa8HStWgjuOscbbeBkX438oZkJHMVhkor3fz
         +yWuy1/03Fr1cocf8172yQ0d6lBkb3OS/41a169ayFXaLwRvW7DLpbugozVWcAOzMxu3
         +T9at9SRa49QwPFNuagAC1m5FynhbXO+T1cMcSQCL23yV1Qj5CPk1LJm+yhqGAQFSaBh
         qUkbKXMcgpgRSAgklisXAyjEdosnQoz2XnHTupuDWQmgQu++3U6gpodu0j3rNwqZulJ9
         ssEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imMOAypeeJYion5hiSp9RS8CiVWyB5tI9arDNTtrtKE=;
        b=e7gElUgoseiNLioGOIC5l9xAeksYaZeOiXk2WvM7W/S+WxzMnOhnKHbnlKnhU45+NI
         uZYs7d8PmVcj8dXUekcWRhzaJoRFjG7swRPousFtny7RUzCinm4eyRy/toEiDjVDmN4q
         n3pEeOLi5KPiOlbsR1JzGAasHYdzrwasQtiZW6sGXVOvgj2KA9yHDFDALPSDu+yMzKpO
         i2SUJo773fsnbUJf+S4hGEwiJU8TKwfld0l9aOPfHb7NV8rPNzTfZ8sLY2J+5fnNG7zs
         G9Us8AzgTAmy6SKroLjazSNyd6R5v1FoH2zuvl9rJbegSgFv0b/H9Onh+wHRi3Fj8+Iy
         qjng==
X-Gm-Message-State: AO0yUKVmkgslA5RlFAp+/1mDJPA5carLmqWtfC1aA0lQRNNl8HLs7pB8
        LgTJxgeX5PxXzeP7TQZciJtfEJAY/W1iU56RSqvDVBbU04nj6/xK
X-Google-Smtp-Source: AK7set9AvG0RtYsCd6ghvSYyXvZviioTJXnritNJvTa/2hxC/SJhSUn3k0EhwLpsHjprFQ0tHspCjAwoEsweFK2gU5c=
X-Received: by 2002:a67:cd87:0:b0:411:9ff1:9747 with SMTP id
 r7-20020a67cd87000000b004119ff19747mr334794vsl.62.1675763996156; Tue, 07 Feb
 2023 01:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20230130094157.1082712-1-etienne.carriere@linaro.org> <20230130094157.1082712-2-etienne.carriere@linaro.org>
In-Reply-To: <20230130094157.1082712-2-etienne.carriere@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 7 Feb 2023 15:29:44 +0530
Message-ID: <CAFA6WYMDP88=3+NnrwTm_u99M-1BZe5ob-bo4mQDRA=QZ9xQXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: arm_scmi: optee: use optee system invocation
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 at 15:12, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Changes SCMI optee transport to enable sys_service capability of
> its tee context to leverage provisioned system resources in OP-TEE
> preventing possible deadlock.
>
> Such deadlock could happen when many Linux clients invoke OP-TEE are
> are all suspended waiting for an OP-TEE RPC request access an SCMI
> resource through the SCMI OP-TEE PTA service.
>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  drivers/firmware/arm_scmi/optee.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> index 2a7aeab40e54..91840345e946 100644
> --- a/drivers/firmware/arm_scmi/optee.c
> +++ b/drivers/firmware/arm_scmi/optee.c
> @@ -559,6 +559,9 @@ static int scmi_optee_service_probe(struct device *dev)
>         if (IS_ERR(tee_ctx))
>                 return -ENODEV;
>
> +       /* SCMI agent can used TEE system service resources */
> +       tee_ctx->sys_service = true;
> +

As per the other thread for patch #1, this feature will only be
available with OP-TEE supporting TEE_GEN_CAP_REG_MEM. Can we add a
corresponding conditional check here?

-Sumit

>         agent = devm_kzalloc(dev, sizeof(*agent), GFP_KERNEL);
>         if (!agent) {
>                 ret = -ENOMEM;
> --
> 2.25.1
>
