Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FDD6910D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBIS40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBIS4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:56:24 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556212594E;
        Thu,  9 Feb 2023 10:56:22 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1442977d77dso3794496fac.6;
        Thu, 09 Feb 2023 10:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDdJLl/I2QNjpdO825TEwCGc0DaecEW+rgD7gN8oIZY=;
        b=gSG0CjisJS+AxFbFwbud6Rgpmpod8Pd/i2gBkPbYPNj+yoSIGlIkH+IPF/8advAgDn
         K9ZHjO8bn3i3MvxLzNG14LSodDcziWIjUe+xOyaqXS3TH8xN+fKf8sBdiYBCS1abdXs7
         wX8SaZAK4q7tm3o1vUmlUpPXHQWGeKTrkTVN/7c/S6SzaRBfT4Fz4rsRrq5u7fNbf+wi
         l0cCSWpgly5fzcL8L+bAkJeK+rkA4GI7OUTbjCF4NIXe5Y8PFUImwuvlAiRRxj6mJKVw
         zaIN9dckq/UdIo232zdy1aYPlIchuVDf0t1sJVGGkbIT6r05FKgzu2Y0E8/RQGLsV/0l
         Ks/A==
X-Gm-Message-State: AO0yUKUMjYaC1ZHmIQDNtBGmqhPrhmeDQ7sHe41bLw8AYZTSrGyAIBqW
        1a2xP5l5YM2yeaCcKE+iTg==
X-Google-Smtp-Source: AK7set8wvXkxStxQda+9e/UpPnApKqoGe5N+cFZTKOBh6yMrhDNfyn3R4rsni5Zm8h3NV7MUwQSC2A==
X-Received: by 2002:a05:6870:50f:b0:15e:cd80:8dfa with SMTP id j15-20020a056870050f00b0015ecd808dfamr7432066oao.17.1675968981572;
        Thu, 09 Feb 2023 10:56:21 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b15-20020a4a98cf000000b00516d4eac864sm1062231ooj.29.2023.02.09.10.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:56:21 -0800 (PST)
Received: (nullmailer pid 632505 invoked by uid 1000);
        Thu, 09 Feb 2023 18:56:20 -0000
Date:   Thu, 9 Feb 2023 12:56:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 1/1] dt-bindings: Fix multi pattern support in
 DT_SCHEMA_FILES
Message-ID: <20230209185620.GA624026-robh@kernel.org>
References: <20230209002634.745163-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209002634.745163-1-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 02:26:34AM +0200, Cristian Ciocaltea wrote:
> DT_SCHEMA_FILES used to allow specifying a space separated list of file
> paths, but the introduction of partial matches support broke this
> feature:

That only happened to work by chance...

> 
> $ make dtbs_check DT_SCHEMA_FILES="path/to/schema1.yaml path/to/schema2.yaml"

Spaces are valid in filenames though we avoid them. Perhaps it would be 
better to use ':'.

> [...]
>   LINT    Documentation/devicetree/bindings
> usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [...]
>                 [-v]
>                 [FILE_OR_DIR ...]
> yamllint: error: one of the arguments FILE_OR_DIR - is required

I think this also happens if nothing matches.

> [...]
> 
> Restore the lost functionality by preparing a grep filter that is able
> to handle multiple search patterns.
> 
> Fixes: 309d955985ee ("dt-bindings: kbuild: Support partial matches with DT_SCHEMA_FILES")
> 

Should be no blank line.

> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  Documentation/devicetree/bindings/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index bf2d8a8ced77..5475c25ae803 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -28,7 +28,7 @@ $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
>  find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
>  		-name 'processed-schema*' \)
>  
> -find_cmd = $(find_all_cmd) | grep -F "$(DT_SCHEMA_FILES)"
> +find_cmd = $(find_all_cmd) | grep -F -e "$(subst $() ," -e ",$(strip $(DT_SCHEMA_FILES)))"
>  CHK_DT_DOCS := $(shell $(find_cmd))
>  
>  quiet_cmd_yamllint = LINT    $(src)
> -- 
> 2.39.1
> 
