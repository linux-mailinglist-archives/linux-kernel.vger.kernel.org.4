Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1847241D5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjFFMOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjFFMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:13:59 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24B641710;
        Tue,  6 Jun 2023 05:13:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5D36580AE;
        Tue,  6 Jun 2023 12:13:26 +0000 (UTC)
Date:   Tue, 6 Jun 2023 15:13:25 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_mtk: Simplify clock sequencing and runtime
 PM
Message-ID: <20230606121325.GB14287@atomide.com>
References: <20230606091747.2031168-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606091747.2031168-1-wenst@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Chen-Yu Tsai <wenst@chromium.org> [230606 09:19]:
> The 8250_mtk driver's runtime PM support has some issues:
> 
> - The bus clock is enabled (through runtime PM callback) later than a
>   register write
> - runtime PM resume callback directly called in probe, but no
>   pm_runtime_set_active() call is present
> - UART PM function calls the callbacks directly, _and_ calls runtime
>   PM API
> - runtime PM callbacks try to do reference counting, adding yet another
>   count between runtime PM and clocks
> 
> This fragile setup worked in a way, but broke recently with runtime PM
> support added to the serial core. The system would hang when the UART
> console was probed and brought up.

Great, looks like a good for Linux next to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>
