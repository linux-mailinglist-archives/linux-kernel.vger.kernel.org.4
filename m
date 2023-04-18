Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335AC6E6971
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjDRQ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjDRQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:26:00 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33E6C66C;
        Tue, 18 Apr 2023 09:25:59 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1879fc89f5eso377646fac.0;
        Tue, 18 Apr 2023 09:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835159; x=1684427159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GALPTZ5rs1mIduJF7Jl53u7XfsfluO0jc0nwk+zxYao=;
        b=j6SEneBD+X+GuvYYcjRcNenjkeOA+gD5OAymFYCEd1AwbCoD3vFAG0m2lEbe02wsSz
         2HtLhPCSarVQ89EVK1kLePe7q/rR8xDmlD3Y8Ybi70i+jA8O47B/hjTsn1CiwV8OfPdQ
         JgCnrzmPF9P7gjYGDr7/I8rCUF/w2CfUqgy4XspIRe8g/J041P2Rv0f50Grk1WDyB/Rs
         2zlZ4Oyhb9KY43AvV0d40aQMNNdAjNgjZUjWrr7TMHzLCCiqqvuZbjPv5c5MdWEComgB
         tizuyvrS7WdoqegAntF1Va2BPYNX1u7j/SIAHh5bkooqHmTHKGjZiuo9wRa1h8Y1ehfO
         pLdg==
X-Gm-Message-State: AAQBX9cydhk2iknBKVKTWgiMTgSvtGbZpm0snQHB51B55fCuIrO5LJyY
        XPNYGqvtxpvtCuTsEEmpFw==
X-Google-Smtp-Source: AKy350aqiwGvkm3PEtoK/oiOYt0ohBeRtozgRcDrXi5U4KbApLSinkvRa0UgAiJEnhzYkN4LUDI3oQ==
X-Received: by 2002:a05:6871:149:b0:169:dcba:1ec9 with SMTP id z9-20020a056871014900b00169dcba1ec9mr1623622oab.41.1681835158903;
        Tue, 18 Apr 2023 09:25:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r204-20020a4a37d5000000b00541fbbbcd31sm1737771oor.5.2023.04.18.09.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:25:58 -0700 (PDT)
Received: (nullmailer pid 1808654 invoked by uid 1000);
        Tue, 18 Apr 2023 16:25:57 -0000
Date:   Tue, 18 Apr 2023 11:25:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: Use of_property_read_bool() for boolean properties
Message-ID: <20230418162557.GD1764573-robh@kernel.org>
References: <20230310144734.1546587-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144734.1546587-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:47:33AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  sound/ppc/tumbler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ping!

> 
> diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
> index 6c882873b344..12f1e10db1c4 100644
> --- a/sound/ppc/tumbler.c
> +++ b/sound/ppc/tumbler.c
> @@ -1361,7 +1361,7 @@ int snd_pmac_tumbler_init(struct snd_pmac *chip)
>  
>  	for_each_child_of_node(chip->node, np) {
>  		if (of_node_name_eq(np, "sound")) {
> -			if (of_get_property(np, "has-anded-reset", NULL))
> +			if (of_property_read_bool(np, "has-anded-reset"))
>  				mix->anded_reset = 1;
>  			if (of_property_present(np, "layout-id"))
>  				mix->reset_on_sleep = 0;
> -- 
> 2.39.2
> 
