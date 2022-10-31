Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECD7613E08
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJaTJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJaTJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:09:39 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F105511170
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:09:37 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so1767281ooi.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hD4xU0q6YbZ6CRjJUPNp1E0zHiqSDa4ieXvjdTrdlqI=;
        b=ESyloqwZRaeiSzDIT+o134cBYHvil6ep7JGcqijFvoki6zqN/w8gZ6CY8hzCb7aeZ+
         FhUzHm83qwHv0h1fCAgcSYuPgqE2nqlA71yNo4eoIiRn3E/AigO1xuGXtKYA0JEFdRvk
         MM1NiabBXmMjhcfj3XkTioBpOrpP5PHQzPF3Q9lp0aeiCzv/iotoXk/rPWBU5C1JdWlA
         yKDDwjVB/PXg3qd6uat30bMIRgUI9v3nXxUIa+Cd6oWG7J653hHdhVIj73XDIn0pSRol
         aot1Ti+irwl1+IahohHIW8cMr8OYeMy/bxTdYunhuWoEmWPjiikj3SWMv9CU7CtvRQHM
         FA0Q==
X-Gm-Message-State: ACrzQf0n2ty8B4DCmB8uaxLFx6iLyrvyKXPkheY9qVQScY5neDxsLDsV
        wHdM3maOhXP4wDp/zsZG8A==
X-Google-Smtp-Source: AMsMyM6MQNPx72Ni8lRQ9ixoikyghtIS0crG//ltDCgjvCEwBcx7OTcxdQuiLtGHd8N+KHOACVosZA==
X-Received: by 2002:a4a:b14d:0:b0:480:fd94:1317 with SMTP id e13-20020a4ab14d000000b00480fd941317mr6158234ooo.54.1667243377175;
        Mon, 31 Oct 2022 12:09:37 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f66-20020a9d03c8000000b0066756fdd916sm3036705otf.68.2022.10.31.12.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 12:09:36 -0700 (PDT)
Received: (nullmailer pid 3268773 invoked by uid 1000);
        Mon, 31 Oct 2022 19:09:38 -0000
Date:   Mon, 31 Oct 2022 14:09:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] ASoC: rt5682: Support dbvdd and ldo1-in supplies
Message-ID: <20221031190938.GA3264845-robh@kernel.org>
References: <20221028205540.3197304-1-nfraprado@collabora.com>
 <20221028205540.3197304-7-nfraprado@collabora.com>
 <Y1/JCN+mtlT0r/rw@sirena.org.uk>
 <20221031163140.h63kjpivwg7xpvs3@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031163140.h63kjpivwg7xpvs3@notapiano>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 12:31:40PM -0400, Nícolas F. R. A. Prado wrote:
> On Mon, Oct 31, 2022 at 01:09:28PM +0000, Mark Brown wrote:
> > On Fri, Oct 28, 2022 at 04:55:38PM -0400, Nícolas F. R. A. Prado wrote:
> > 
> > > @@ -35,6 +35,8 @@ const char *rt5682_supply_names[RT5682_NUM_SUPPLIES] = {
> > >  	"AVDD",
> > >  	"MICVDD",
> > >  	"VBAT",
> > > +	"dbvdd",
> > > +	"ldo1-in",
> > 
> > Why are we making these inconsistent in style with the other supplies?
> 
> In short because the other supplies already have users while these are new ones.
> My understanding was that new supplies should have lowercase names, following DT
> convention. But I do see the argument on having them all be consistent for a
> single driver/binding. If there are no remarks from Rob or Krzysztof I can
> change it in the next version.

We want lowercase and consistency... Between the 2, I pick consistency.

Rob
