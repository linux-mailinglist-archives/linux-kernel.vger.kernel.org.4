Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C4C6FEBB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbjEKGYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbjEKGX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:23:56 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A6BCCA;
        Wed, 10 May 2023 23:23:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 511618109;
        Thu, 11 May 2023 06:23:54 +0000 (UTC)
Date:   Thu, 11 May 2023 09:23:53 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Judith Mendez <jm@ti.com>
Cc:     linux-can@vger.kernel.org,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Schuyler Patton <spatton@ti.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/2] can: m_can: Add hrtimer to generate software
 interrupt
Message-ID: <20230511062353.GE14287@atomide.com>
References: <20230510202952.27111-1-jm@ti.com>
 <20230510202952.27111-3-jm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510202952.27111-3-jm@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Judith Mendez <jm@ti.com> [230510 20:31]:
> Add an hrtimer to MCAN class device. Each MCAN will have its own
> hrtimer instantiated if there is no hardware interrupt found and
> poll-interval property is defined in device tree M_CAN node.
> 
> The hrtimer will generate a software interrupt every 1 ms. In
> hrtimer callback, we check if there is a transaction pending by
> reading a register, then process by calling the isr if there is.

So what about system suspend, do you need to do something to
ensure the timer does not happen to run while suspending?

Regards,

Tony
