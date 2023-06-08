Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614E272800F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbjFHMcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjFHMc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:32:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC211E43;
        Thu,  8 Jun 2023 05:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 587EB64D26;
        Thu,  8 Jun 2023 12:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A26C433D2;
        Thu,  8 Jun 2023 12:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686227547;
        bh=fOIh00zUsqrqEdfNZOGPcviNsKUmrWFA0cvT+HdU7bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cXQ9YLYUnV4G4NTQ7+9pYEtShpe+uwTuwZu9W29GrYrGtu7DW/fOJWZsDoyRObAVo
         EF4xcLQUCauJa/cRtxi5iEevrYqaf+CbaZttx2sdz5s1f65yZuEx4/rFEo2J9BwajU
         QThEzJiIu9c4X5N3bx0hQ83pnGqaBGZ/7TVCZKJwS4adFFTlDnx2xJ2Ioh2VpgIG/v
         sRFs0ZK+/QdlVHQ67W9x6RVbrDgCWrC42TWHTADFFQ5qH0+3jnG/tA8svRFSP1CBxW
         dPp0QYElm6BwCNkAlpbl4qp9Q00nP/JdT5vaxB4d1bga/2pJmTM6GY9gg4F1zm43se
         3vj8mdiY3iY0A==
Date:   Thu, 8 Jun 2023 13:32:18 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Julien Panis <jpanis@baylibre.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        macro@orcam.me.uk, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
        jirislaby@kernel.org, rostedt@goodmis.org, revest@chromium.org,
        gehao@kylinos.cn, akpm@linux-foundation.org, jgg@ziepe.ca,
        razor@blackwall.org, stephen@networkplumber.org,
        prabhakar.csengg@gmail.com, contact@emersion.fr,
        alex.williamson@redhat.com, akrowiak@linux.ibm.com,
        mark.rutland@arm.com, ye.xingchen@zte.com.cn, ojeda@kernel.org,
        me@kloenk.de, milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com
Subject: Re: [PATCH v7 2/6] mfd: tps6594: Add driver for TI TPS6594 PMIC
Message-ID: <20230608123218.GF1930705@google.com>
References: <20230511095126.105104-1-jpanis@baylibre.com>
 <20230511095126.105104-3-jpanis@baylibre.com>
 <20230518150740.GN404509@google.com>
 <20230607173351.GA3605615-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607173351.GA3605615-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2023, Rob Herring wrote:

> On Thu, May 18, 2023 at 04:07:40PM +0100, Lee Jones wrote:
> > On Thu, 11 May 2023, Julien Panis wrote:
> > 
> > > This patch adds support for TPS6594 PMIC MFD core. It provides
> > > communication through the I2C and SPI interfaces, and supports
> > > protocols with embedded CRC data fields for safety applications.
> > > 
> > > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> > > Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> > > ---
> > >  drivers/mfd/Kconfig         |   32 ++
> > >  drivers/mfd/Makefile        |    3 +
> > >  drivers/mfd/tps6594-core.c  |  462 ++++++++++++++++
> > >  drivers/mfd/tps6594-i2c.c   |  244 +++++++++
> > >  drivers/mfd/tps6594-spi.c   |  129 +++++
> > >  include/linux/mfd/tps6594.h | 1020 +++++++++++++++++++++++++++++++++++
> > >  6 files changed, 1890 insertions(+)
> > >  create mode 100644 drivers/mfd/tps6594-core.c
> > >  create mode 100644 drivers/mfd/tps6594-i2c.c
> > >  create mode 100644 drivers/mfd/tps6594-spi.c
> > >  create mode 100644 include/linux/mfd/tps6594.h
> > 
> > Applied - current being build tested.
> > 
> > Once complete, I'll send out a pull-request for the other maintainers.
> 
> Some reason the binding wasn't applied too? The compatible strings are 
> now reported as undocumented (make dt_compatible_check).

Good call.

Applied now, thanks.

-- 
Lee Jones [李琼斯]
