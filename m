Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3383469C4DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjBTFCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTFB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:01:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EFBCA06
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676869275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iz5/XJcUnQF/LFQxvol9TqG2b7RW1QrWjYsgCVHX3XQ=;
        b=XBBiRCiffRCXVmxnwZj4e/ria8O3xqxIGaXLabaSX845pEGxUr1SGYkFMT5VJIORm0ETKn
        nbCr8rFbkW6YdY6jySMIWSDLFOsLtVgZyOymibjt8b1cmykFKaZg/jB9tlidlffXxWVAEP
        AvNHbAeOcW/mJ2zL0ScS/3GTdWnvRUs=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-258-wICiuvUzNVGCWkktj6uCsQ-1; Mon, 20 Feb 2023 00:00:43 -0500
X-MC-Unique: wICiuvUzNVGCWkktj6uCsQ-1
Received: by mail-ua1-f71.google.com with SMTP id q19-20020a056130029300b00683c94d9881so998440uac.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iz5/XJcUnQF/LFQxvol9TqG2b7RW1QrWjYsgCVHX3XQ=;
        b=SkOw1dP/CQc8XBPxESZONbrs3FeV5TzfpdawfxQtvPdT1CHO1WigtbvQLXt7Y8FOy3
         xOWpaGTtbcASZz6pAqcypdlPDCcTkQ8S5xhWOU5C93DdXUTBJYS16Mn25w9fHzAL2ory
         7w64PJEl2x/1oUl+4dvnAdSbuXJo3ydY5j12nguHvJCqq5BgWnlCWCiXHjsrOQ6RIXiL
         PcOC+1H4XlwxeKY1AKW5TNBRpcGint8KJmbmtCSnd0ix0vHGwylac8jlrn29ZSwnakY5
         enRr3TUPQy9cWMII0v9PE2ejp4bcmEM5o58K13mffcJUV0WCNRRiVRuNs27HHrux1+/U
         UJqg==
X-Gm-Message-State: AO0yUKV8Pl2/MbQmmjWnJPbWdt1u1i8DtKWGoNGoD1LAIUKc/LaR5JiS
        Q/5sfdkb20MFeTtMuuv1/+WdjJ3xsPm2jL55BTJUUszY1okJ2aw/efWfeAIoY7BU87K/pvs0ceU
        0GPX7njBVuzJPNrQVwtUa0x8L/kc/0TN2B7jRNY6d
X-Received: by 2002:a05:6102:f0a:b0:411:bd2e:11ac with SMTP id v10-20020a0561020f0a00b00411bd2e11acmr165955vss.75.1676869241595;
        Sun, 19 Feb 2023 21:00:41 -0800 (PST)
X-Google-Smtp-Source: AK7set9f9ox6vr3CX95NfKEGX65cBproFKTgZSzrIfnLLXYRXGGY0eODN/Gl2kUycvwizSjQfY+ldPdK2BDBA0MyKSw=
X-Received: by 2002:a05:6102:f0a:b0:411:bd2e:11ac with SMTP id
 v10-20020a0561020f0a00b00411bd2e11acmr165950vss.75.1676869241338; Sun, 19 Feb
 2023 21:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20230217141059.392471-1-nick.alcock@oracle.com> <20230217141059.392471-12-nick.alcock@oracle.com>
In-Reply-To: <20230217141059.392471-12-nick.alcock@oracle.com>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 20 Feb 2023 05:00:25 +0000
Message-ID: <CAOgh=Fyak7mxqva0qkUtrqBnsBbhMtP+AsHpOz3TNhwp4wPaAQ@mail.gmail.com>
Subject: Re: [PATCH 11/24] kbuild, soc: apple: apple-pmgr-pwrstate: remove
 MODULE_LICENSE in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2023 at 14:20, Nick Alcock <nick.alcock@oracle.com> wrote:
>
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>
> So remove it in the files in this commit, none of which can be built as
> modules.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: Sven Peter <sven@svenpeter.dev>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: asahi@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

>  drivers/soc/apple/apple-pmgr-pwrstate.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/soc/apple/apple-pmgr-pwrstate.c b/drivers/soc/apple/apple-pmgr-pwrstate.c
> index e1122288409a..2c15474c7b53 100644
> --- a/drivers/soc/apple/apple-pmgr-pwrstate.c
> +++ b/drivers/soc/apple/apple-pmgr-pwrstate.c
> @@ -319,6 +319,5 @@ static struct platform_driver apple_pmgr_ps_driver = {
>
>  MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
>  MODULE_DESCRIPTION("PMGR power state driver for Apple SoCs");
> -MODULE_LICENSE("GPL v2");
>
>  module_platform_driver(apple_pmgr_ps_driver);
> --
> 2.39.1.268.g9de2f9a303
>
>

