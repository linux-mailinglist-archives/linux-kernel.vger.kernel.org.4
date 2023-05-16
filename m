Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DBE704A18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjEPKIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjEPKII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613F8E7A;
        Tue, 16 May 2023 03:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E955462347;
        Tue, 16 May 2023 10:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B29DC433EF;
        Tue, 16 May 2023 10:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684231685;
        bh=9rwHmSwT7dbAEIPo156SJSK+Xaa+4zJir8iTQqqilwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmNhx/lcnsROh7wR1TaHGtfMENiJUolfSpwCka1PRPcWcef52D+RUVjt1lMQpdij2
         VMqSbc0lkDTLfjZqsnLvzHUusDw6BhIsaw8DxfGe9GZ0fl/dc9DL8jt5Mp2uAuuUxx
         gFtZDuqvlToE8f5ILadJUrkBfPRwaScOdRN8DyfYfKQlr4QjX2UNZvA3zK9Ns07Q4D
         7Mf2t8aCfgtrmIDv6rN1SL8igBkeaELZLp+p5H5McQhlemZk/5ae2Rh3jwov9pxeta
         JG1pqdX6EMlNIJkT4N9TFyjp7N+MbmYDYkqt197TAEclYWC6N2C6qyCoxAjCXofzyx
         uERUFIEq1Kc9w==
Date:   Tue, 16 May 2023 11:07:58 +0100
From:   Lee Jones <lee@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tglx@linutronix.de, linus.walleij@linaro.org,
        vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] irqchip/cs42l43: Add support for the cs42l43 IRQs
Message-ID: <20230516100758.GE10825@google.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-8-ckeepax@opensource.cirrus.com>
 <86o7mpmvqq.wl-maz@kernel.org>
 <20230512153933.GH68926@ediswmail.ad.cirrus.com>
 <86mt29mt2m.wl-maz@kernel.org>
 <20230512164233.GN68926@ediswmail.ad.cirrus.com>
 <ZGGGGcZNEx7o8GC6@finisterre.sirena.org.uk>
 <20230515095752.GQ68926@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515095752.GQ68926@ediswmail.ad.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023, Charles Keepax wrote:

> On Mon, May 15, 2023 at 10:08:41AM +0900, Mark Brown wrote:
> > On Fri, May 12, 2023 at 04:42:33PM +0000, Charles Keepax wrote:
> > 
> > > I guess if Mark doesn't mind I think the only internal bit of the
> > > device that uses the IRQs is the CODEC driver so I could move the
> > > IRQ handling in there, it does seem a little odd to me, but I
> > > guess I don't have any problems with it.
> > 
> > The obvious (and previously standard) place for it would be the MFD.
> 
> Alright I certainly have no objection to moving it there, although
> would be good to get Lee's thoughts, make sure he is happy with
> that too.

Submit a patch and we'll take it from there.

-- 
Lee Jones [李琼斯]
