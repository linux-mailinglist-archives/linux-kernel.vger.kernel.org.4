Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0074713B19
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 19:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjE1RWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 13:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjE1RWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 13:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C03B2;
        Sun, 28 May 2023 10:22:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 961E660EBC;
        Sun, 28 May 2023 17:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F97C433EF;
        Sun, 28 May 2023 17:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685294558;
        bh=a0bn35byPravsJL/aYIpPMkp2CEo3YyQfJm8G1Uhmj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JcSvyNHSuJhMCIZhkT0NmgEV5yatXQOX99p2xnzxjucNbNZ6i+BarPWm+13xPevVd
         KnycU6jKzIlvm7c2h7mYTACvih4blk1JQl65IJZfKFy9lzQDMiWBd9fp6RMx+4sZEG
         ibDQ0gagPYT7jefM+FoWANzeB8YfacbrZ6le8iCjeL13sJyotz6bySx47Um43dQ9G3
         bwo2hN2kWqgdJTsdpjEHJszC3HNRRx7MtHXZPm8Kuhj+8llDq9h56E4lsVZ6p0atQA
         FzK0m/L8lOLn9PUhYRNtOciGzh5XjkBGF/zDc5GE6A52LX5sxmDOsGCALfgjU6O8xY
         IzaFvxx+p9pXg==
Date:   Sun, 28 May 2023 18:38:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 7/9] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
Message-ID: <20230528183855.0c95d308@jic23-huawei>
In-Reply-To: <20230523151223.109551-8-herve.codina@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-8-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 17:12:21 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Industrial I/O devices can be present in the audio path.
> These devices needs to be used as audio components in order to be fully
> integrated in the audio path.
> 
> This support allows to consider these Industrial I/O devices as auxliary
> audio devices and allows to control them using mixer controls.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---

> diff --git a/sound/soc/codecs/audio-iio-aux.c b/sound/soc/codecs/audio-iio-aux.c
> new file mode 100644
> index 000000000000..21575c4b35fd
> --- /dev/null
> +++ b/sound/soc/codecs/audio-iio-aux.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// audio-iio-aux.c  --  ALSA SoC glue to use IIO devices as audio components
> +//
> +// Copyright 2023 CS GROUP France
> +//
> +// Author: Herve Codina <herve.codina@bootlin.com>
> +
> +#include <linux/iio/consumer.h>
> +#include <linux/module.h>

#include <linux/mod_devicetable.h> ideally to pick up
the of_device_id definition without bouncing through some non 
obvious header path.


> +#include <linux/slab.h>
> +#include <sound/soc.h>
> +#include <sound/tlv.h>

Otherwise, the IIO elements of this look good.  So for those at least
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I don't have enough knowledge of the snd stuff to review those
parts.

Jonathan


