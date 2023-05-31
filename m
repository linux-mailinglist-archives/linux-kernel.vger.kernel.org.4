Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95DD7189E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjEaTLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEaTL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE02101
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:11:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4015963CF5
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5757EC433D2;
        Wed, 31 May 2023 19:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685560286;
        bh=fMSN4rRfT/YYU6DsAL7hio8xQmlEastZREnZfyRzIGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B59LSF5KqgIhbEtoBiMu7ARLPF64RaqTGXLyiZUt+BLf3OyW1pdp6PsTGcBuZZX54
         U6DyzqueZhBcnxc6GASVw3s6EIVscQt7BjTG/U27gmwogyb9pB2F+CK01yLPfceIg5
         Gp6pcm1OPrJ+PCkLGh9TSODhmvqmpY6Qu89pepAU=
Date:   Wed, 31 May 2023 20:11:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ABI: sysfs-nvmem-cells: Expose cells through sysfs
Message-ID: <2023053113-caddy-affected-e1fa@gregkh>
References: <20230530100929.285235-1-miquel.raynal@bootlin.com>
 <20230530100929.285235-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530100929.285235-2-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 12:09:28PM +0200, Miquel Raynal wrote:
> The binary content of nvmem devices is available to the user so in the
> easiest cases, finding the content of a cell is rather easy as it is
> just a matter of looking at a known and fixed offset. However, nvmem
> layouts have been recently introduced to cope with more advanced
> situations, where the offset and size of the cells is not known in
> advance or is dynamic. When using layouts, more advanced parsers are
> used by the kernel in order to give direct access to the content of each
> cell regardless of their position/size in the underlying device, but
> these information were not accessible to the user.
> 
> By exposing the nvmem cells to the user through a dedicated cell/ folder
> containing one file per cell, we provide a straightforward access to
> useful user information without the need for re-writing a userland
> parser. Content of nvmem cells is usually: product names, manufacturing
> date, MAC addresses, etc,
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/ABI/testing/sysfs-nvmem-cells | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
> 
> diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells b/Documentation/ABI/testing/sysfs-nvmem-cells
> new file mode 100644
> index 000000000000..bee4acc5bfcb
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-nvmem-cells
> @@ -0,0 +1,19 @@
> +What:		/sys/bus/nvmem/devices/.../cells/<cell-name>
> +Date:		May 2023
> +KernelVersion:  6.5

No tab?

